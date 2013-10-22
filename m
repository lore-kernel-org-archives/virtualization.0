From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 7/7] virtio_blk: trigger IO errors in case virtqueue is
	broken
Date: Tue, 22 Oct 2013 14:45:11 +0200
Message-ID: <1382445911-55657-8-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

In case the virtqueue is flagged as broken, IO errors are triggered
for current request queue entries.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 01b5d3a..8eb91be 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -875,6 +875,20 @@ out:
 	return err;
 }
 
+static void virtblk_flush_request_queue(struct request_queue *q)
+{
+	spinlock_t *lock = q->queue_lock;
+	struct request *req;
+
+	if (!q)
+		return;
+
+	spin_lock_irq(lock);
+	while ((req = blk_fetch_request(q)))
+		__blk_end_request_all(req, -EIO);
+	spin_unlock_irq(lock);
+}
+
 static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
@@ -890,6 +904,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	virtqueue_notify(vblk->vq);
 	if (virtqueue_is_broken(vblk->vq)) {
 		queue_broken = true;
+		virtblk_flush_request_queue(vblk->disk->queue);
 		blk_cleanup_queue(vblk->disk->queue);
 		del_gendisk(vblk->disk);
 	} else {
-- 
1.8.3.1
