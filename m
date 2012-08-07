From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 2/2] virtio-blk: Add REQ_FLUSH and REQ_FUA support
	to bio path
Date: Tue, 7 Aug 2012 11:15:10 +0200
Message-ID: <20120807091510.GA2651@lst.de>
References: <1344329235-17449-1-git-send-email-asias@redhat.com>
	<1344329235-17449-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1344329235-17449-3-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

At least after review is done I really think this patch sopuld be folded
into the previous one.

Some more comments below:

> @@ -58,6 +58,12 @@ struct virtblk_req
>  	struct bio *bio;
>  	struct virtio_blk_outhdr out_hdr;
>  	struct virtio_scsi_inhdr in_hdr;
> +	struct work_struct work;
> +	struct virtio_blk *vblk;

I think using bio->bi_private for the virtio_blk pointer would
be cleaner.


> +	bool is_flush;
> +	bool req_flush;
> +	bool req_data;
> +	bool req_fua;

This could be a bitmap, or better even a single state field.

> +static int virtblk_bio_send_flush(struct virtio_blk *vblk,
> +				  struct virtblk_req *vbr)

> +static int virtblk_bio_send_data(struct virtio_blk *vblk,
> +				 struct virtblk_req *vbr)

These should only get the struct virtblk_req * argument as the virtio_blk
structure is easily derivable from it.

> +static inline void virtblk_bio_done_flush(struct virtio_blk *vblk,
> +					  struct virtblk_req *vbr)
>  {
> +	if (vbr->req_data) {
> +		/* Send out the actual write data */
> +		struct virtblk_req *_vbr;
> +		_vbr = virtblk_alloc_req(vblk, GFP_NOIO);
> +		if (!_vbr) {
> +			bio_endio(vbr->bio, -ENOMEM);
> +			goto out;
> +		}
> +		_vbr->req_fua = vbr->req_fua;
> +		_vbr->bio = vbr->bio;
> +		_vbr->vblk = vblk;
> +		INIT_WORK(&_vbr->work, virtblk_bio_send_data_work);
> +		queue_work(virtblk_wq, &_vbr->work);

The _vbr naming isn't too nice.  Also can you explain why the original
request can't be reused in a comment here?

Also if using a state variable I think the whole code would be
a bit cleaner if the bio_done helpers are combined.

> -	if (writeback && !use_bio)
> +	if (writeback)
>  		blk_queue_flush(vblk->disk->queue, REQ_FLUSH);

Shouldn't this be REQ_FLUSH | REQ_FUA for the bio case?

Btw, did you verify that flushes really work correctly for all cases
using tracing in qemu?
