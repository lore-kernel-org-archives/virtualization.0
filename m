From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/2] virtio-blk: fix hw_queue stopped on arbitrary error
Date: Thu, 13 Feb 2020 13:37:27 +0100
Message-ID: <20200213123728.61216-2-pasic@linux.ibm.com>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <20200213123728.61216-1-pasic@linux.ibm.com>
Sender: linux-block-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Since nobody else is going to restart our hw_queue for us, the
blk_mq_start_stopped_hw_queues() is in virtblk_done() is not sufficient
necessarily sufficient to ensure that the queue will get started again.
In case of global resource outage (-ENOMEM because mapping failure,
because of swiotlb full) our virtqueue may be empty and we can get
stuck with a stopped hw_queue.

Let us not stop the queue on arbitrary errors, but only on -EONSPC which
indicates a full virtqueue, where the hw_queue is guaranteed to get
started by virtblk_done() before when it makes sense to carry on
submitting requests. Let us also remove a stale comment.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>
Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
---

I'm in doubt with regards to the Fixes tag. The thing is, virtio-blk
probably made an assumption on virtqueue_add: the failure is either
because the virtqueue is full, or the failure is fatal. In both cases it
seems acceptable to stop the queue, although the fatal case is arguable.
Since commit f7728002c1c7 it the dma mapping has failed returns -ENOMEM
and not -EIO, and thus we have a recoverable failure that ain't
virtqueue full. So I lean towards to a fixes tag that references that
commit, although it ain't broken. Alternatively one could say 'Fixes:
e467cde23818 ("Block driver using virtio.")', if the aforementioned
assumption shouldn't have made in the first place.
---
 drivers/block/virtio_blk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 54158766334b..adfe43f5ffe4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -245,10 +245,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
-		blk_mq_stop_hw_queue(hctx);
+		/* Don't stop the queue if -ENOMEM: we may have failed to
+		 * bounce the buffer due to global resource outage.
+		 */
+		if (err == -ENOSPC)
+			blk_mq_stop_hw_queue(hctx);
 		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
-		/* Out of mem doesn't actually happen, since we fall back
-		 * to direct descriptors */
 		if (err == -ENOMEM || err == -ENOSPC)
 			return BLK_STS_DEV_RESOURCE;
 		return BLK_STS_IOERR;
-- 
2.17.1
