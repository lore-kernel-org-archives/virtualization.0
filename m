From: Changpeng Liu <changpeng.liu@intel.com>
Subject: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES commands support
Date: Wed,  6 Jun 2018 12:19:00 +0800
Message-ID: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, changpeng.liu@intel.com
Cc: pbonzini@redhat.com, cavery@redhat.com, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES commands
support, this will impact the performance when using SSD backend over
file systems.

Commit 88c85538 "virtio-blk: add discard and write zeroes features to
specification"(see https://github.com/oasis-tcs/virtio-spec) extended
existing virtio-blk protocol, adding extra DISCARD and WRITE ZEROES
commands support.

While here, using 16 bytes descriptor to describe one segment of DISCARD
or WRITE ZEROES commands, each command may contain one or more decriptors.

The following data structure shows the definition of one descriptor:

struct virtio_blk_discard_write_zeroes {
        le64 sector;
        le32 num_sectors;
        le32 unmap;
};

Field 'sector' means the start sector for DISCARD and WRITE ZEROES,
filed 'num_sectors' means the number of sectors for DISCARD and WRITE
ZEROES, if both DISCARD and WRITE ZEROES are supported, field 'unmap'
maybe used for WRITE ZEROES command with DISCARD enabled.

We also extended the virtio-blk configuration space to let backend
device put DISCARD and WRITE ZEROES configuration parameters.

struct virtio_blk_config {
        [...]

        le32 max_discard_sectors;
        le32 max_discard_seg;
        le32 discard_sector_alignment;
        le32 max_write_zeroes_sectors;
        le32 max_write_zeroes_seg;
        u8 write_zeroes_may_unmap;
}

New feature bit [VIRTIO_BLK_F_DISCARD (13)]: Device can support discard
command, maximum discard sectors size in field 'max_discard_sectors' and
maximum discard segment number in field 'max_discard_seg'.

New feature [VIRTIO_BLK_F_WRITE_ZEROES (14)]: Device can support write
zeroes command, maximum write zeroes sectors size in field
'max_write_zeroes_sectors' and maximum write zeroes segment number in
field 'max_write_zeroes_seg'.

The parameters in the configuration space of the device field
'max_discard_sectors' and field 'discard_sector_alignment' are expressed in
512-byte units if the VIRTIO_BLK_F_DISCARD feature bit is negotiated. The
field 'max_write_zeroes_sectors' is expressed in 512-byte units if the
VIRTIO_BLK_F_WRITE_ZEROES feature bit is negotiated.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
CHANGELOG:
v6: don't set T_OUT bit to discard and write zeroes commands.
v5: use new block layer API: blk_queue_flag_set.
v4: several optimizations based on MST's comments, remove bit field usage for
command descriptor.
v3: define the virtio-blk protocol to add discard and write zeroes support,
first version implementation based on proposed specification.
v2: add write zeroes command support.
v1: initial proposal implementation for discard command.
---
 drivers/block/virtio_blk.c      | 89 ++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h | 43 ++++++++++++++++++++
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4a07593c..5aabc63 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -172,10 +172,45 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
 	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
 }
 
+static inline int virtblk_setup_discard_write_zeroes(struct request *req,
+						bool unmap)
+{
+	unsigned short segments = blk_rq_nr_discard_segments(req);
+	unsigned short n = 0;
+	struct virtio_blk_discard_write_zeroes *range;
+	struct bio *bio;
+
+	range = kmalloc_array(segments, sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+
+	__rq_for_each_bio(bio, req) {
+		u64 sector = bio->bi_iter.bi_sector;
+		u32 num_sectors = bio->bi_iter.bi_size >> 9;
+
+		range[n].unmap = cpu_to_le32(unmap);
+		range[n].num_sectors = cpu_to_le32(num_sectors);
+		range[n].sector = cpu_to_le64(sector);
+		n++;
+	}
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * segments;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	return 0;
+}
+
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 
+	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		kfree(page_address(req->special_vec.bv_page) +
+		      req->special_vec.bv_offset);
+	}
+
 	switch (req_op(req)) {
 	case REQ_OP_SCSI_IN:
 	case REQ_OP_SCSI_OUT:
@@ -225,6 +260,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int qid = hctx->queue_num;
 	int err;
 	bool notify = false;
+	bool unmap = false;
 	u32 type;
 
 	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
@@ -237,6 +273,13 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
 		break;
+	case REQ_OP_DISCARD:
+		type = VIRTIO_BLK_T_DISCARD;
+		break;
+	case REQ_OP_WRITE_ZEROES:
+		type = VIRTIO_BLK_T_WRITE_ZEROES;
+		unmap = !(req->cmd_flags & REQ_NOUNMAP);
+		break;
 	case REQ_OP_SCSI_IN:
 	case REQ_OP_SCSI_OUT:
 		type = VIRTIO_BLK_T_SCSI_CMD;
@@ -256,6 +299,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
+	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
+		err = virtblk_setup_discard_write_zeroes(req, unmap);
+		if (err)
+			return BLK_STS_RESOURCE;
+	}
+
 	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
 	if (num) {
 		if (rq_data_dir(req) == WRITE)
@@ -777,6 +826,42 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (!err && opt_io_size)
 		blk_queue_io_opt(q, blk_size * opt_io_size);
 
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
+		q->limits.discard_granularity = blk_size;
+
+		virtio_cread(vdev, struct virtio_blk_config,
+				discard_sector_alignment, &v);
+		if (v)
+			q->limits.discard_alignment = v << 9;
+		else
+			q->limits.discard_alignment = 0;
+
+		virtio_cread(vdev, struct virtio_blk_config,
+				max_discard_sectors, &v);
+		if (v)
+			blk_queue_max_discard_sectors(q, v);
+		else
+			blk_queue_max_discard_sectors(q, UINT_MAX);
+
+		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
+				&v);
+		if (v)
+			blk_queue_max_discard_segments(q, v);
+		else
+			blk_queue_max_discard_segments(q, USHRT_MAX);
+
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	}
+
+	if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
+		virtio_cread(vdev, struct virtio_blk_config,
+				max_write_zeroes_sectors, &v);
+		if (v)
+			blk_queue_max_write_zeroes_sectors(q, v);
+		else
+			blk_queue_max_write_zeroes_sectors(q, UINT_MAX);
+	}
+
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
@@ -885,14 +970,14 @@ static int virtblk_restore(struct virtio_device *vdev)
 	VIRTIO_BLK_F_SCSI,
 #endif
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
-	VIRTIO_BLK_F_MQ,
+	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 }
 ;
 static unsigned int features[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
-	VIRTIO_BLK_F_MQ,
+	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 9ebe4d9..8e7a015 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -38,6 +38,8 @@
 #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
 #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
 #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
+#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
+#define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -86,6 +88,29 @@ struct virtio_blk_config {
 
 	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
 	__u16 num_queues;
+	/* The maximum discard sectors (in 512-byte sectors) for
+	 * one segment (if VIRTIO_BLK_F_DISCARD)
+	 */
+	__u32 max_discard_sectors;
+	/* The maximum number of discard segments in a
+	 * discard command (if VIRTIO_BLK_F_DISCARD)
+	 */
+	__u32 max_discard_seg;
+	/* The alignment sectors for discard (if VIRTIO_BLK_F_DISCARD) */
+	__u32 discard_sector_alignment;
+	/* The maximum number of write zeroes sectors (in 512-byte sectors) in
+	 * one segment (if VIRTIO_BLK_F_WRITE_ZEROES)
+	 */
+	__u32 max_write_zeroes_sectors;
+	/* The maximum number of segments in a write zeroes
+	 * command (if VIRTIO_BLK_F_WRITE_ZEROES)
+	 */
+	__u32 max_write_zeroes_seg;
+	/* Device clear this bit when write zeroes command can't result in
+	 * unmapping sectors (if VIRITO_BLK_F_WRITE_ZEROES and with unmap)
+	 */
+	__u8 write_zeroes_may_unmap;
+	__u8 unused1[3];
 } __attribute__((packed));
 
 /*
@@ -114,6 +139,12 @@ struct virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID    8
 
+/* Discard command */
+#define VIRTIO_BLK_T_DISCARD	11
+
+/* Write zeroes command */
+#define VIRTIO_BLK_T_WRITE_ZEROES	13
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op. */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -133,6 +164,18 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+/*
+ * discard/write zeroes range for each request.
+ */
+struct virtio_blk_discard_write_zeroes {
+	/* discard/write zeroes start sector */
+	__virtio64 sector;
+	/* number of discard/write zeroes sectors */
+	__virtio32 num_sectors;
+	/* valid for write zeroes command */
+	__virtio32 unmap;
+};
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 struct virtio_scsi_inhdr {
 	__virtio32 errors;
-- 
1.9.3
