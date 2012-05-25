From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/3] virtio-blk: Use block layer provided spinlock
Date: Fri, 25 May 2012 16:10:47 +0300
Message-ID: <20120525131046.GA19478@redhat.com>
References: <20120525070245.GE15474@redhat.com>
	<1337933007-30634-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1337933007-30634-1-git-send-email-asias@redhat.com>
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

On Fri, May 25, 2012 at 04:03:27PM +0800, Asias He wrote:
> Block layer will allocate a spinlock for the queue if the driver does
> not provide one in blk_init_queue().
> 
> The reason to use the internal spinlock is that blk_cleanup_queue() will
> switch to use the internal spinlock in the cleanup code path.
> 
>         if (q->queue_lock != &q->__queue_lock)
>                 q->queue_lock = &q->__queue_lock;
> 
> However, processes which are in D state might have taken the driver
> provided spinlock, when the processes wake up, they would release the
> block provided spinlock.
> 
> =====================================
> [ BUG: bad unlock balance detected! ]
> 3.4.0-rc7+ #238 Not tainted
> -------------------------------------
> fio/3587 is trying to release lock (&(&q->__queue_lock)->rlock) at:
> [<ffffffff813274d2>] blk_queue_bio+0x2a2/0x380
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 1 lock held by fio/3587:
>  #0:  (&(&vblk->lock)->rlock){......}, at:
> [<ffffffff8132661a>] get_request_wait+0x19a/0x250

The above is fixed by your patch
block: Fix lock unbalance caused by lock disconnect
so it really seems beside the point here.
So I think the part of the commit log that
makes sense starts here?


> Other drivers use block layer provided spinlock as well, e.g. SCSI.
> 
> Switching to the block layer provided spinlock saves a bit of memory and
> does not increase lock contention. Performance test shows no real
> difference is observed before and after this patch.
> 
> Changes in v2: Improve commit log as Michael suggested.
> 
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Asias He <asias@redhat.com>

Well why not.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b4fa2d7..774c31d 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -21,8 +21,6 @@ struct workqueue_struct *virtblk_wq;
>  
>  struct virtio_blk
>  {
> -	spinlock_t lock;
> -
>  	struct virtio_device *vdev;
>  	struct virtqueue *vq;
>  
> @@ -65,7 +63,7 @@ static void blk_done(struct virtqueue *vq)
>  	unsigned int len;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&vblk->lock, flags);
> +	spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
>  	while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
>  		int error;
>  
> @@ -99,7 +97,7 @@ static void blk_done(struct virtqueue *vq)
>  	}
>  	/* In case queue is stopped waiting for more buffers. */
>  	blk_start_queue(vblk->disk->queue);
> -	spin_unlock_irqrestore(&vblk->lock, flags);
> +	spin_unlock_irqrestore(vblk->disk->queue->queue_lock, flags);
>  }
>  
>  static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
> @@ -431,7 +429,6 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> -	spin_lock_init(&vblk->lock);
>  	vblk->vdev = vdev;
>  	vblk->sg_elems = sg_elems;
>  	sg_init_table(vblk->sg, vblk->sg_elems);
> @@ -456,7 +453,7 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>  		goto out_mempool;
>  	}
>  
> -	q = vblk->disk->queue = blk_init_queue(do_virtblk_request, &vblk->lock);
> +	q = vblk->disk->queue = blk_init_queue(do_virtblk_request, NULL);
>  	if (!q) {
>  		err = -ENOMEM;
>  		goto out_put_disk;
> -- 
> 1.7.10.2
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
