From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 18 Jun 2012 13:21:08 +0300
Message-ID: <20120618102108.GD23134@redhat.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1340002390-3950-4-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 18, 2012 at 02:53:10PM +0800, Asias He wrote:
> +static void virtblk_make_request(struct request_queue *q, struct bio *bio)
> +{
> +	struct virtio_blk *vblk = q->queuedata;
> +	unsigned int num, out = 0, in = 0;
> +	struct virtblk_req *vbr;
> +
> +	BUG_ON(bio->bi_phys_segments + 2 > vblk->sg_elems);
> +	BUG_ON(bio->bi_rw & (REQ_FLUSH | REQ_FUA));
> +
> +	vbr = virtblk_alloc_req(vblk, GFP_NOIO);
> +	if (!vbr) {
> +		bio_endio(bio, -ENOMEM);
> +		return;
> +	}
> +
> +	vbr->bio = bio;
> +	vbr->req = NULL;
> +	vbr->out_hdr.type = 0;
> +	vbr->out_hdr.sector = bio->bi_sector;
> +	vbr->out_hdr.ioprio = bio_prio(bio);
> +
> +	sg_set_buf(&vbr->sg[out++], &vbr->out_hdr, sizeof(vbr->out_hdr));
> +
> +	num = blk_bio_map_sg(q, bio, vbr->sg + out);
> +
> +	sg_set_buf(&vbr->sg[num + out + in++], &vbr->status,
> +		   sizeof(vbr->status));
> +
> +	if (num) {
> +		if (bio->bi_rw & REQ_WRITE) {
> +			vbr->out_hdr.type |= VIRTIO_BLK_T_OUT;
> +			out += num;
> +		} else {
> +			vbr->out_hdr.type |= VIRTIO_BLK_T_IN;
> +			in += num;
> +		}
> +	}
> +
> +	spin_lock_irq(vblk->disk->queue->queue_lock);
> +	if (virtqueue_add_buf(vblk->vq, vbr->sg, out, in, vbr,
> +			      GFP_ATOMIC) < 0) {
> +		spin_unlock_irq(vblk->disk->queue->queue_lock);

Any implications of dropping lock like that?
E.g. for suspend. like we are still discussing with
unlocked kick?

> +		virtblk_add_buf_wait(vblk, vbr, out, in);
> +	} else {
> +		virtqueue_kick(vblk->vq);

Why special case the first call? task state manipulation so expensive?

> +		spin_unlock_irq(vblk->disk->queue->queue_lock);
> +	}
> +}
> +
