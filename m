From: Asias He <asias@redhat.com>
Subject: [PATCH] virtio-blk: Disable callback in virtblk_done()
Date: Tue, 25 Sep 2012 10:36:17 +0800
Message-ID: <1348540577-7474-1-git-send-email-asias@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This reduces unnecessary interrupts that host could send to guest while
guest is in the progress of irq handling.

If one vcpu is handling the irq, while another interrupt comes, in
handle_edge_irq(), the guest will mask the interrupt via mask_msi_irq()
which is a very heavy operation that goes all the way down to host.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/block/virtio_blk.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 53b81d5..0bdde8f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -274,15 +274,18 @@ static void virtblk_done(struct virtqueue *vq)
 	unsigned int len;
 
 	spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
-	while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
-		if (vbr->bio) {
-			virtblk_bio_done(vbr);
-			bio_done = true;
-		} else {
-			virtblk_request_done(vbr);
-			req_done = true;
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
+			if (vbr->bio) {
+				virtblk_bio_done(vbr);
+				bio_done = true;
+			} else {
+				virtblk_request_done(vbr);
+				req_done = true;
+			}
 		}
-	}
+	} while (!virtqueue_enable_cb(vq));
 	/* In case queue is stopped waiting for more buffers. */
 	if (req_done)
 		blk_start_queue(vblk->disk->queue);
-- 
1.7.11.4
