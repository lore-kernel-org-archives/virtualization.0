From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] virtio_blk: check for hardsector size from host
Date: Thu, 29 May 2008 11:08:26 +0200
Message-ID: <200805291108.26375.borntraeger__27106.3774860979$1212052427$gmane$org@de.ibm.com>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<200805291027.25369.borntraeger@de.ibm.com>
	<20080529083004.GQ25504@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080529083004.GQ25504@kernel.dk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently virtio_blk assumes a 512 byte hard sector size. This can cause 
trouble / performance issues if the backing has a different block size
(like a file on an ext3 file system formatted with 4k block size or a dasd).

Lets add a feature flag that tells the guest to use a different hard sector
size than 512 byte.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/block/virtio_blk.c |   10 +++++++++-
 include/linux/virtio_blk.h |    3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: kvm/drivers/block/virtio_blk.c
===================================================================
--- kvm.orig/drivers/block/virtio_blk.c
+++ kvm/drivers/block/virtio_blk.c
@@ -196,6 +196,7 @@ static int virtblk_probe(struct virtio_d
 	int err;
 	u64 cap;
 	u32 v;
+	u32 blk_size;
 
 	if (index_to_minor(index) >= 1 << MINORBITS)
 		return -ENOSPC;
@@ -290,6 +291,13 @@ static int virtblk_probe(struct virtio_d
 	if (!err)
 		blk_queue_max_hw_segments(vblk->disk->queue, v);
 
+	/* Host can optionally specify the block size of the device */
+	err = virtio_config_val(vdev, VIRTIO_BLK_F_BLK_SIZE,
+				offsetof(struct virtio_blk_config, blk_size),
+				&blk_size);
+	if (!err)
+		blk_queue_hardsect_size(vblk->disk->queue, blk_size);
+
 	add_disk(vblk->disk);
 	return 0;
 
@@ -329,7 +337,7 @@ static struct virtio_device_id id_table[
 
 static unsigned int features[] = {
 	VIRTIO_BLK_F_BARRIER, VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX,
-	VIRTIO_BLK_F_GEOMETRY, VIRTIO_BLK_F_RO,
+	VIRTIO_BLK_F_GEOMETRY, VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
 };
 
 static struct virtio_driver virtio_blk = {
Index: kvm/include/linux/virtio_blk.h
===================================================================
--- kvm.orig/include/linux/virtio_blk.h
+++ kvm/include/linux/virtio_blk.h
@@ -11,6 +11,7 @@
 #define VIRTIO_BLK_F_SEG_MAX	2	/* Indicates maximum # of segments */
 #define VIRTIO_BLK_F_GEOMETRY	4	/* Legacy geometry available  */
 #define VIRTIO_BLK_F_RO		5	/* Disk is read-only */
+#define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
 
 struct virtio_blk_config
 {
@@ -26,6 +27,8 @@ struct virtio_blk_config
 		__u8 heads;
 		__u8 sectors;
 	} geometry;
+	/* block size of device (if VIRTIO_BLK_F_BLK_SIZE) */
+	__u32 blk_size;
 } __attribute__((packed));
 
 /* These two define direction. */
