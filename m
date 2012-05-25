From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] virtio-blk: Reset device after blk_cleanup_queue()
Date: Fri, 25 May 2012 10:06:01 +0300
Message-ID: <20120525070601.GF15474__41636.5192425021$1337929567$gmane$org@redhat.com>
References: <1337913289-23486-1-git-send-email-asias@redhat.com>
	<1337913289-23486-3-git-send-email-asias@redhat.com>
	<20120525065229.GD15474@redhat.com> <4FBF2EB4.3020702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FBF2EB4.3020702@redhat.com>
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

On Fri, May 25, 2012 at 03:03:16PM +0800, Asias He wrote:
> On 05/25/2012 02:52 PM, Michael S. Tsirkin wrote:
> >On Fri, May 25, 2012 at 10:34:48AM +0800, Asias He wrote:
> >>blk_cleanup_queue() will call blk_drian_queue() to drain all the
> >>requests before queue DEAD marking. If we reset the device before
> >>blk_cleanup_queue() the drain would fail.
> >>
> >>1) if the queue is stopped in do_virtblk_request() because device is
> >>full, the q->request_fn() will not be called.
> >>
> >>blk_drain_queue() {
> >>    while(true) {
> >>       ...
> >>       if (!list_empty(&q->queue_head))
> >>         __blk_run_queue(q) {
> >>	    if (queue is not stoped)
> >>		q->request_fn()
> >>	}
> >>       ...
> >>    }
> >>}
> >>
> >>Do no reset the device before blk_cleanup_queue() gives the chance to
> >>start the queue in interrupt handler blk_done().
> >>
> >>2) In commit b79d866c8b7014a51f611a64c40546109beaf24a, We abort requests
> >>dispatched to driver before blk_cleanup_queue(). There is a race if
> >>requests are dispatched to driver after the abort and before the queue
> >>DEAD mark. To fix this, instead of aborting the requests explicitly, we
> >>can just reset the device after after blk_cleanup_queue so that the
> >>device can complete all the requests before queue DEAD marking in the
> >>drain process.
> >>
> >>Cc: Rusty Russell<rusty@rustcorp.com.au>
> >>Cc: "Michael S. Tsirkin"<mst@redhat.com>
> >>Cc: virtualization@lists.linux-foundation.org
> >>Cc: kvm@vger.kernel.org
> >>Signed-off-by: Asias He<asias@redhat.com>
> >>---
> >>  drivers/block/virtio_blk.c |   12 +-----------
> >>  1 file changed, 1 insertion(+), 11 deletions(-)
> >>
> >>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >>index 1bed517..b4fa2d7 100644
> >>--- a/drivers/block/virtio_blk.c
> >>+++ b/drivers/block/virtio_blk.c
> >>@@ -576,8 +576,6 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
> >>  {
> >>  	struct virtio_blk *vblk = vdev->priv;
> >>  	int index = vblk->index;
> >>-	struct virtblk_req *vbr;
> >>-	unsigned long flags;
> >>
> >>  	/* Prevent config work handler from accessing the device. */
> >>  	mutex_lock(&vblk->config_lock);
> >>@@ -585,21 +583,13 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
> >>  	mutex_unlock(&vblk->config_lock);
> >>
> >>  	del_gendisk(vblk->disk);
> >>+	blk_cleanup_queue(vblk->disk->queue);
> >
> >Device is not reset here yet, so it will process
> >some requests in parallel with blk_cleanup_queue.
> >Is this a problem? Why not?
> 
> No. This is not a problem. Actually, blk_cleanup_queue assumes the
> device can process the requests before queue DEAD marking. Otherwise
> the drain in the blk_cleanup_queue would never success.

I see, thanks for the clarification.

> >
> >>
> >>  	/* Stop all the virtqueues. */
> >>  	vdev->config->reset(vdev);
> >>
> >>  	flush_work(&vblk->config_work);
> >>
> >>-	/* Abort requests dispatched to driver. */
> >>-	spin_lock_irqsave(&vblk->lock, flags);
> >>-	while ((vbr = virtqueue_detach_unused_buf(vblk->vq))) {
> >>-		__blk_end_request_all(vbr->req, -EIO);
> >>-		mempool_free(vbr, vblk->pool);
> >>-	}
> >>-	spin_unlock_irqrestore(&vblk->lock, flags);
> >>-
> >>-	blk_cleanup_queue(vblk->disk->queue);
> >>  	put_disk(vblk->disk);
> >>  	mempool_destroy(vblk->pool);
> >>  	vdev->config->del_vqs(vdev);
> >>--
> >>1.7.10.2
> 
> 
> -- 
> Asias
