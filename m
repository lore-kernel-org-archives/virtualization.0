From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio-blk: Fix hot-unplug race in remove method
Date: Thu, 3 May 2012 08:27:51 +0300
Message-ID: <20120503052751.GE8266@redhat.com>
References: <1336011592-24889-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1336011592-24889-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 03, 2012 at 10:19:52AM +0800, Asias He wrote:
> If we reset the virtio-blk device before the requests already dispatched
> to the virtio-blk driver from the block layer are finised, we will stuck
> in blk_cleanup_queue() and the remove will fail.
> 
> blk_cleanup_queue() calls blk_drain_queue() to drain all requests queued
> before DEAD marking. However it will never success if the device is
> already stopped. We'll have q->in_flight[] > 0, so the drain will not
> finish.
> 
> How to reproduce the race:
> 1. hot-plug a virtio-blk device
> 2. keep reading/writing the device in guest
> 3. hot-unplug while the device is busy serving I/O
> 
> Signed-off-by: Asias He <asias@redhat.com>

We used to do similar tracking in -net but dropped it all by using the
tracking that virtio core does.  Can't blk do the same?  Isn't there
some way to use virtqueue_detach_unused_buf for this instead?

> ---
>  drivers/block/virtio_blk.c |   26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 72fe55d..72b818b 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -46,6 +46,9 @@ struct virtio_blk
>  	/* Ida index - used to track minor number allocations. */
>  	int index;
>  
> +	/* Number of pending requests dispatched to driver. */
> +	int req_in_flight;
> +
>  	/* Scatterlist: can be too big for stack. */
>  	struct scatterlist sg[/*sg_elems*/];
>  };
> @@ -95,6 +98,7 @@ static void blk_done(struct virtqueue *vq)
>  		}
>  
>  		__blk_end_request_all(vbr->req, error);
> +		vblk->req_in_flight--;
>  		mempool_free(vbr, vblk->pool);
>  	}
>  	/* In case queue is stopped waiting for more buffers. */
> @@ -190,6 +194,7 @@ static void do_virtblk_request(struct request_queue *q)
>  
>  	while ((req = blk_peek_request(q)) != NULL) {
>  		BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> +		vblk->req_in_flight++;
>  
>  		/* If this request fails, stop queue and wait for something to
>  		   finish to restart it. */
> @@ -443,7 +448,7 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  	if (err)
>  		goto out_free_vblk;
>  
> -	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
> +	vblk->pool = mempool_create_kmalloc_pool(1, sizeof(struct virtblk_req));
>  	if (!vblk->pool) {
>  		err = -ENOMEM;
>  		goto out_free_vq;
> @@ -466,6 +471,7 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  
>  	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
>  
> +	vblk->req_in_flight = 0;
>  	vblk->disk->major = major;
>  	vblk->disk->first_minor = index_to_minor(index);
>  	vblk->disk->private_data = vblk;
> @@ -576,22 +582,34 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
>  	int index = vblk->index;
> +	unsigned long flags;
> +	int req_in_flight;
>  
>  	/* Prevent config work handler from accessing the device. */
>  	mutex_lock(&vblk->config_lock);
>  	vblk->config_enable = false;
>  	mutex_unlock(&vblk->config_lock);
>  
> +	/* Abort all request on the queue. */
> +	blk_abort_queue(vblk->disk->queue);
> +	del_gendisk(vblk->disk);
> +
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
> -
> +	vdev->config->del_vqs(vdev);
>  	flush_work(&vblk->config_work);
>  
> -	del_gendisk(vblk->disk);
> +	/* Wait requests dispatched to device driver to finish. */
> +	do {
> +		spin_lock_irqsave(&vblk->lock, flags);
> +		req_in_flight = vblk->req_in_flight;
> +		spin_unlock_irqrestore(&vblk->lock, flags);
> +	} while (req_in_flight != 0);
> +
>  	blk_cleanup_queue(vblk->disk->queue);
>  	put_disk(vblk->disk);
> +
>  	mempool_destroy(vblk->pool);
> -	vdev->config->del_vqs(vdev);
>  	kfree(vblk);
>  	ida_simple_remove(&vd_index_ida, index);
>  }
> -- 
> 1.7.10
