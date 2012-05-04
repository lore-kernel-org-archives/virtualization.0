From: Asias He <asias@redhat.com>
Subject: [PATCH v3] virtio-blk: Fix hot-unplug race in remove method
Date: Fri,  4 May 2012 20:22:04 +0800
Message-ID: <1336134124-14744-1-git-send-email-asias@redhat.com>
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
To: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If we reset the virtio-blk device before the requests already dispatched
to the virtio-blk driver from the block layer are finised, we will stuck
in blk_cleanup_queue() and the remove will fail.

blk_cleanup_queue() calls blk_drain_queue() to drain all requests queued
before DEAD marking. However it will never success if the device is
already stopped. We'll have q->in_flight[] > 0, so the drain will not
finish.

How to reproduce the race:
1. hot-plug a virtio-blk device
2. keep reading/writing the device in guest
3. hot-unplug while the device is busy serving I/O

Test:
~1000 rounds of hot-plug/hot-unplug test passed with this patch.

Changes in v3:
- Drop blk_abort_queue and blk_abort_request
- Use __blk_end_request_all to complete request dispatched to driver

Changes in v2:
- Drop req_in_flight
- Use virtqueue_detach_unused_buf to get request dispatched to driver

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/block/virtio_blk.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 72fe55d..693187d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -576,6 +576,8 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 	int index = vblk->index;
+	struct virtblk_req *vbr;
+	unsigned long flags;
 
 	/* Prevent config work handler from accessing the device. */
 	mutex_lock(&vblk->config_lock);
@@ -588,6 +590,15 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
 	flush_work(&vblk->config_work);
 
 	del_gendisk(vblk->disk);
+
+	/* Abort requests dispatched to driver. */
+	spin_lock_irqsave(&vblk->lock, flags);
+	while ((vbr = virtqueue_detach_unused_buf(vblk->vq))) {
+		__blk_end_request_all(vbr->req, -EIO);
+		mempool_free(vbr, vblk->pool);
+	}
+	spin_unlock_irqrestore(&vblk->lock, flags);
+
 	blk_cleanup_queue(vblk->disk->queue);
 	put_disk(vblk->disk);
 	mempool_destroy(vblk->pool);
-- 
1.7.10.1
