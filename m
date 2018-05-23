From: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: RE: [PATCH v3] virtio_blk: add DISCARD and WRIET ZEROES command
	support
Date: Wed, 23 May 2018 20:37:30 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B65D28E@SHSMSX103.ccr.corp.intel.com>
References: <1522370974-28259-1-git-send-email-changpeng.liu@intel.com>
	<20180330034517-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180330034517-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "cavery@redhat.com" <cavery@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Thursday, March 29, 2018 6:07 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> stefanha@redhat.com; jasowang@redhat.com; pbonzini@redhat.com;
> Wodkowski, PawelX <pawelx.wodkowski@intel.com>; Harris, James R
> <james.r.harris@intel.com>; fabio.miranda.martins@canonical.com
> Subject: Re: [PATCH v3] virtio_blk: add DISCARD and WRIET ZEROES command
> support
> 
> On Fri, Mar 30, 2018 at 08:49:34AM +0800, Changpeng Liu wrote:
> > Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES
> > command support, this will impact the performance when using SSD
> > backend over file systems.
> >
> > The idea here is using 16 Bytes payload as one descriptor for
> > DISCARD/WRITE ZEROES command, users can put several ranges into
> > one command, for the purpose to support such feature, two feature
> > flags VIRTIO_BLK_F_DISCARD/VIRTIO_BLK_F_WRITE_ZEROES and two
> > commands VIRTIO_BLK_T_DISCARD/VIRTIO_BLK_T_WRITE_ZEROES are
> > introduced, and some parameters are added to the configuration
> > space to tell the OS the granularity of DISCARD/WRITE ZEROES
> > commands.
> 
> Pls fix grammar in this comment, I am not sure what are you
> trying to say.
Okay, will add more description here.
> 
> >
> > The specification change list here:
> > https://github.com/oasis-tcs/virtio-spec
> 
> Which commit?
> 
> > CHANGELOG:
> > v3: finalized the specification change.
> 
> Changelog belongs after -- and should be complete
> including changes v1 to v2.
> 
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > ---
> >  drivers/block/virtio_blk.c      | 96
> +++++++++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/virtio_blk.h | 39 +++++++++++++++++
> >  2 files changed, 132 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4a07593c..1943adb 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -172,10 +172,53 @@ static int virtblk_add_req(struct virtqueue *vq, struct
> virtblk_req *vbr,
> >  	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
> >  }
> >
> > +static inline int virtblk_setup_discard_write_zeroes(struct request *req, bool
> unmap)
> > +{
> > +	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
> 
> Split on two lines pls:
> 	unsigned short n = 0;
> 
> > +	u32 block_size = queue_logical_block_size(req->q);
> 
> Seems to be unused except for the sanity check below. Why?
> 
> > +	struct virtio_blk_discard_write_zeroes *range;
> > +	struct bio *bio;
> > +
> > +	if (block_size < 512 || !block_size)
> 
> Why 512? And when is it 0?
Ok, actually this check is  not necessary, will remove it.
> 
> > +		return -1;
> 
> -1 isn't a normal errno code.
> 
> > +
> > +	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> 
> This might be pretty large: with 64K segments it looks like you are
> trying to allocate ~1Mbyte with GFP_ATOMIC which is unlikely to succeed.
> Can we split this up in chunks?
This is already chunks now, if the backend can only support 1 segment, so the number
is always 1, I can change the GFP_ATOMIC with GFP_KERNEL. 
> 
> > +	if (!range)
> > +		return -1;
> > +
> > +	__rq_for_each_bio(bio, req) {
> > +		u64 sector = bio->bi_iter.bi_sector;
> > +		u32 num_sectors = bio->bi_iter.bi_size >> 9;
> 
> why 9?
The sectors in virtio-blk protocol and Linux is expressed by 512-bytes.
> 
> > +
> > +		range[n].flags.unmap = cpu_to_le32(unmap);
> > +		range[n].flags.reserved = cpu_to_le32(0);
> > +		range[n].num_sectors = cpu_to_le32(num_sectors);
> > +		range[n].sector = cpu_to_le64(sector);
> 
> Isn't this causing sparse warnings?
No warning when I complied the module.
> 
> 
> > +		n++;
> > +	}
> > +
> > +	if (WARN_ON_ONCE(n != segments)) {
> 
> and when does this happen?
This check shouldn't happen too, will remove it.
> 
> > +		kfree(range);
> > +		return -1;
> > +	}
> > +
> > +	req->special_vec.bv_page = virt_to_page(range);
> > +	req->special_vec.bv_offset = offset_in_page(range);
> > +	req->special_vec.bv_len = sizeof(*range) * segments;
> > +	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> > +
> > +	return 0;
> > +}
> > +
> >  static inline void virtblk_request_done(struct request *req)
> >  {
> >  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> >
> > +	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
> > +		kfree(page_address(req->special_vec.bv_page) +
> > +		      req->special_vec.bv_offset);
> > +	}
> > +
> >  	switch (req_op(req)) {
> >  	case REQ_OP_SCSI_IN:
> >  	case REQ_OP_SCSI_OUT:
> > @@ -225,6 +268,7 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >  	int qid = hctx->queue_num;
> >  	int err;
> >  	bool notify = false;
> > +	bool unmap = false;
> >  	u32 type;
> >
> >  	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > @@ -237,6 +281,13 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >  	case REQ_OP_FLUSH:
> >  		type = VIRTIO_BLK_T_FLUSH;
> >  		break;
> > +	case REQ_OP_DISCARD:
> > +		type = VIRTIO_BLK_T_DISCARD;
> > +		break;
> > +	case REQ_OP_WRITE_ZEROES:
> > +		type = VIRTIO_BLK_T_WRITE_ZEROES;
> > +		unmap = !(req->cmd_flags & REQ_NOUNMAP);
> > +		break;
> >  	case REQ_OP_SCSI_IN:
> >  	case REQ_OP_SCSI_OUT:
> >  		type = VIRTIO_BLK_T_SCSI_CMD;
> > @@ -256,9 +307,16 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >
> >  	blk_mq_start_request(req);
> >
> > +	if (type == VIRTIO_BLK_T_DISCARD || type ==
> VIRTIO_BLK_T_WRITE_ZEROES) {
> > +		err = virtblk_setup_discard_write_zeroes(req, unmap);
> > +		if (err)
> > +			return BLK_STS_IOERR;
> 
> Does a failure actually indicate an IO error?
Good catch, BLK_STS_RESOURCE makes more sense.
> 
> 
> > +	}
> > +
> >  	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
> >  	if (num) {
> > -		if (rq_data_dir(req) == WRITE)
> > +		if (rq_data_dir(req) == WRITE || type == VIRTIO_BLK_T_DISCARD
> ||
> > +		    type == VIRTIO_BLK_T_WRITE_ZEROES)
> >  			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
> VIRTIO_BLK_T_OUT);
> >  		else
> >  			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
> VIRTIO_BLK_T_IN);
> > @@ -777,6 +835,38 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	if (!err && opt_io_size)
> >  		blk_queue_io_opt(q, blk_size * opt_io_size);
> >
> > +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > +		q->limits.discard_granularity = blk_size;
> > +
> > +		virtio_cread(vdev, struct virtio_blk_config,
> discard_sector_alignment, &v);
> > +		if (v)
> > +			q->limits.discard_alignment = v << 9;
> > +		else
> > +			q->limits.discard_alignment = 0;
> > +
> > +		virtio_cread(vdev, struct virtio_blk_config, max_discard_sectors,
> &v);
> > +		if (v)
> > +			blk_queue_max_discard_sectors(q, v);
> > +		else
> > +			blk_queue_max_discard_sectors(q, UINT_MAX);
> > +
> > +		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg, &v);
> > +		if (v)
> > +			blk_queue_max_discard_segments(q, v);
> > +		else
> > +			blk_queue_max_discard_segments(q, USHRT_MAX);
> > +
> > +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> > +	}
> > +
> > +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
> > +		virtio_cread(vdev, struct virtio_blk_config,
> max_write_zeroes_sectors, &v);
> > +		if (v)
> > +			blk_queue_max_write_zeroes_sectors(q, v);
> > +		else
> > +			blk_queue_max_write_zeroes_sectors(q, UINT_MAX);
> > +	}
> > +
> >  	virtblk_update_capacity(vblk, false);
> >  	virtio_device_ready(vdev);
> >
> > @@ -885,14 +975,14 @@ static int virtblk_restore(struct virtio_device *vdev)
> >  	VIRTIO_BLK_F_SCSI,
> >  #endif
> >  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
> VIRTIO_BLK_F_CONFIG_WCE,
> > -	VIRTIO_BLK_F_MQ,
> > +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
> VIRTIO_BLK_F_WRITE_ZEROES,
> >  }
> >  ;
> >  static unsigned int features[] = {
> >  	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX,
> VIRTIO_BLK_F_GEOMETRY,
> >  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
> >  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
> VIRTIO_BLK_F_CONFIG_WCE,
> > -	VIRTIO_BLK_F_MQ,
> > +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
> VIRTIO_BLK_F_WRITE_ZEROES,
> >  };
> >
> >  static struct virtio_driver virtio_blk = {
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > index 9ebe4d9..78a60e6 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -38,6 +38,8 @@
> >  #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
> >  #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is
> available */
> >  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
> > +#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD command is
> supported */
> > +#define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES
> command is supported */
> >
> >  /* Legacy feature bits */
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> > @@ -86,6 +88,22 @@ struct virtio_blk_config {
> >
> >  	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
> >  	__u16 num_queues;
> > +	/* The maximum discard segment size (if VIRTIO_BLK_F_DISCARD) */
> > +	__u32 max_discard_sectors;
> > +	/* The maximum number of discard segments (if VIRTIO_BLK_F_DISCARD)
> */
> > +	__u32 max_discard_seg;
> > +	/* The sector alignment for discard (if VIRTIO_BLK_F_DISCARD) */
> > +	__u32 discard_sector_alignment;
> > +	/* The maximum number of write zeroes sectors (if
> VIRTIO_BLK_F_WRITE_ZEROES) */
> > +	__u32 max_write_zeroes_sectors;
> > +	/* The maximum number of write zeroes segments (if
> VIRTIO_BLK_F_WRITE_ZEROES) */
> > +	__u32 max_write_zeroes_seg;
> > +	/* Device clear this bit when write zeroes command cannot result in
> > +	 * deallocating one or more sectors
> > +	 * (if VIRTIO_BLK_F_WRITE_ZEROES with unmap bit)
> 
> Pls fix grammar in this comment, I am not sure what are you trying to
> say.
> 
> > +	 */
> > +	__u8 write_zeroes_may_unmap;
> > +	__u8 unused1[3];
> >  } __attribute__((packed));
> >
> >  /*
> > @@ -114,6 +132,12 @@ struct virtio_blk_config {
> >  /* Get device ID command */
> >  #define VIRTIO_BLK_T_GET_ID    8
> >
> > +/* Discard command */
> > +#define VIRTIO_BLK_T_DISCARD	11
> > +
> > +/* Write zeroes command */
> > +#define VIRTIO_BLK_T_WRITE_ZEROES	13
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  /* Barrier before this op. */
> >  #define VIRTIO_BLK_T_BARRIER	0x80000000
> > @@ -133,6 +157,21 @@ struct virtio_blk_outhdr {
> >  	__virtio64 sector;
> >  };
> >
> > +/*
> > + * discard/write zeroes range for each request.
> > + */
> > +struct virtio_blk_discard_write_zeroes {
> > +	/* discard/write zeroes start sector */
> > +	__virtio64 sector;
> > +	/* number of discard/write zeroes sectors */
> > +	__virtio32 num_sectors;
> > +	/* valid for write zeroes command */
> > +	struct {
> > +		__virtio32 unmap:1;
> > +		__virtio32 reserved:31;
> > +	} flags;
> > +};
> > +
> 
> You can't use bitmaps in portable code.
> The format differs between architectures.
> 
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  struct virtio_scsi_inhdr {
> >  	__virtio32 errors;
> > --
> > 1.9.3
