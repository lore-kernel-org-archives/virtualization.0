From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v3 RFC 2/4] virtio_blk: avoid further request queueing on
	device loss
Date: Wed, 27 Nov 2013 11:32:38 +0100
Message-ID: <1385548360-31943-3-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Code is added to the remove callback to verify if a device was lost.

In case of a device loss further request queueing should be prevented
by setting appropriate queue flags prior to invoking del_gendisk().
Blocking of request queueing leads to appropriate I/O errors when data
are tried to be synched. Trying to synch data to a lost block device
doesn't make too much sense.

If the current remove callback was triggered due to an unregister driver,
and the surprize_removal is not already set (although the actual device
is already gone, e.g. virsh detach), del_gendisk() would be triggered
resulting in a hang. This is a weird situation, and most likely not
'serializable'.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2d43be4..0f64282 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -875,6 +875,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 	int index = vblk->index;
+	unsigned long flags;
 	int refc;
 
 	/* Prevent config work handler from accessing the device. */
@@ -882,6 +883,14 @@ static void virtblk_remove(struct virtio_device *vdev)
 	vblk->config_enable = false;
 	mutex_unlock(&vblk->config_lock);
 
+	if (vdev->surprize_removal) {
+		spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
+		queue_flag_set(QUEUE_FLAG_DYING, vblk->disk->queue);
+		queue_flag_set(QUEUE_FLAG_NOMERGES, vblk->disk->queue);
+		queue_flag_set(QUEUE_FLAG_NOXMERGES, vblk->disk->queue);
+		spin_unlock_irqrestore(vblk->disk->queue->queue_lock, flags);
+	}
+
 	del_gendisk(vblk->disk);
 	blk_cleanup_queue(vblk->disk->queue);
 
-- 
1.8.3.1
