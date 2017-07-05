From: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: RE: [PATCH v2] virtio-blk: add DISCARD support to virtio-blk driver
Date: Wed, 5 Jul 2017 07:57:07 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B595B29@SHSMSX103.ccr.corp.intel.com>
References: <1499244279-3484-1-git-send-email-changpeng.liu@intel.com>
	<01542f21-6fa3-c406-65e1-a37d04130fb7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <01542f21-6fa3-c406-65e1-a37d04130fb7@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Tuesday, July 4, 2017 5:24 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>; virtualization@lists.linux-
> foundation.org
> Cc: stefanha@gmail.com; hch@lst.de; mst@redhat.com
> Subject: Re: [PATCH v2] virtio-blk: add DISCARD support to virtio-blk driver
> 
> 
> 
> On 05/07/2017 10:44, Changpeng Liu wrote:
> > Currently virtio-blk driver does not provide discard feature flag, so the
> > filesystems which built on top of the block device will not send discard
> > command. This is okay for HDD backend, but it will impact the performance
> > for SSD backend.
> >
> > Add a feature flag VIRTIO_BLK_F_DISCARD and command
> VIRTIO_BLK_T_DISCARD
> > to extend exist virtio-blk protocol, define 16 bytes discard descriptor
> > for each discard segment, the discard segment defination aligns with
> > SCSI or NVM Express protocols, virtio-blk driver will support multi-range
> > discard request as well.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> 
> Please include a patch for the specification.  Since we are at it, I
Thanks Paolo, do you mean include a text file which describe the changes for the specification?
> would like to have three operations defined using the same descriptor:
> 
> - discard (SCSI UNMAP)
> 
> - write zeroes (SCSI WRITE SAME without UNMAP flag)
> 
> - write zeroes and possibly discard (SCSI WRITE SAME with UNMAP flag)
> 
> The last two can use the same command VIRTIO_BLK_T_WRITE_ZEROES, using
> the reserved field as a flags field.
Will add write zeroes feature.
> 
> Paolo
> 
> > ---
> >  drivers/block/virtio_blk.c      | 76
> +++++++++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/virtio_blk.h | 19 +++++++++++
> >  2 files changed, 92 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 0297ad7..8f0c614 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -172,10 +172,52 @@ static int virtblk_add_req(struct virtqueue *vq, struct
> virtblk_req *vbr,
> >  	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
> >  }
> >
> > +static inline int virtblk_setup_discard(struct request *req)
> > +{
> > +	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
> > +	u32 block_size = queue_logical_block_size(req->q);
> > +	struct virtio_blk_discard *range;
> > +	struct bio *bio;
> > +
> > +	if (block_size < 512 || !block_size)
> > +		return -1;
> > +
> > +	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> > +	if (!range)
> > +		return -1;
> > +
> > +	__rq_for_each_bio(bio, req) {
> > +		u64 slba = (bio->bi_iter.bi_sector << 9) / block_size;
> > +		u32 nlb = bio->bi_iter.bi_size / block_size;
> > +
> > +		range[n].reserved = cpu_to_le32(0);
> > +		range[n].nlba = cpu_to_le32(nlb);
> > +		range[n].slba = cpu_to_le64(slba);
> > +		n++;
> > +	}
> > +
> > +	if (WARN_ON_ONCE(n != segments)) {
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
> > @@ -237,6 +279,9 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >  	case REQ_OP_FLUSH:
> >  		type = VIRTIO_BLK_T_FLUSH;
> >  		break;
> > +	case REQ_OP_DISCARD:
> > +		type = VIRTIO_BLK_T_DISCARD;
> > +		break;
> >  	case REQ_OP_SCSI_IN:
> >  	case REQ_OP_SCSI_OUT:
> >  		type = VIRTIO_BLK_T_SCSI_CMD;
> > @@ -256,9 +301,15 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >
> >  	blk_mq_start_request(req);
> >
> > +	if (type == VIRTIO_BLK_T_DISCARD) {
> > +		err = virtblk_setup_discard(req);
> > +		if (err)
> > +			return BLK_STS_IOERR;
> > +	}
> > +
> >  	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
> >  	if (num) {
> > -		if (rq_data_dir(req) == WRITE)
> > +		if (rq_data_dir(req) == WRITE || type == VIRTIO_BLK_T_DISCARD)
> >  			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
> VIRTIO_BLK_T_OUT);
> >  		else
> >  			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
> VIRTIO_BLK_T_IN);
> > @@ -767,6 +818,25 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	if (!err && opt_io_size)
> >  		blk_queue_io_opt(q, blk_size * opt_io_size);
> >
> > +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > +		q->limits.discard_alignment = blk_size;
> > +		q->limits.discard_granularity = blk_size;
> > +
> > +		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg, &v);
> > +		if (v)
> > +			blk_queue_max_discard_sectors(q, v);
> > +		else
> > +			blk_queue_max_discard_sectors(q, -1U);
> > +
> > +		virtio_cread(vdev, struct virtio_blk_config, max_discard_num, &v);
> > +		if (v)
> > +			blk_queue_max_discard_segments(q, v);
> > +		else
> > +			blk_queue_max_discard_segments(q, 256);
> > +
> > +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> > +	}
> > +
> >  	virtio_device_ready(vdev);
> >
> >  	device_add_disk(&vdev->dev, vblk->disk);
> > @@ -874,14 +944,14 @@ static int virtblk_restore(struct virtio_device *vdev)
> >  	VIRTIO_BLK_F_SCSI,
> >  #endif
> >  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY,
> VIRTIO_BLK_F_CONFIG_WCE,
> > -	VIRTIO_BLK_F_MQ,
> > +	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD,
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
> >  };
> >
> >  static struct virtio_driver virtio_blk = {
> > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> > index 9ebe4d9..3354cc3 100644
> > --- a/include/uapi/linux/virtio_blk.h
> > +++ b/include/uapi/linux/virtio_blk.h
> > @@ -38,6 +38,7 @@
> >  #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available*/
> >  #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is
> available */
> >  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
> > +#define VIRTIO_BLK_F_DISCARD	13	/* DISCARD command is
> supported */
> >
> >  /* Legacy feature bits */
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> > @@ -86,6 +87,10 @@ struct virtio_blk_config {
> >
> >  	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
> >  	__u16 num_queues;
> > +	/* The maximum segment size (if VIRTIO_BLK_F_DISCARD) */
> > +	__u32 max_discard_seg;
> > +	/* The maximum number of segments (if VIRTIO_BLK_F_DISCARD) */
> > +	__u32 max_discard_num;
> >  } __attribute__((packed));
> >
> >  /*
> > @@ -114,6 +119,9 @@ struct virtio_blk_config {
> >  /* Get device ID command */
> >  #define VIRTIO_BLK_T_GET_ID    8
> >
> > +/* Discard command */
> > +#define VIRTIO_BLK_T_DISCARD	16
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  /* Barrier before this op. */
> >  #define VIRTIO_BLK_T_BARRIER	0x80000000
> > @@ -133,6 +141,17 @@ struct virtio_blk_outhdr {
> >  	__virtio64 sector;
> >  };
> >
> > +/*
> > + * Array of discard ranges for each request.
> > + */
> > +struct virtio_blk_discard {
> > +	/* start discard lba */
> > +	__virtio64 slba;
> > +	/* number of discard sectors */
> > +	__virtio32 nlba;
> > +	__virtio32 reserved;
> > +};
> > +
> >  #ifndef VIRTIO_BLK_NO_LEGACY
> >  struct virtio_scsi_inhdr {
> >  	__virtio32 errors;
> >
