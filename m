From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v4 RFC 2/3] virtio: introduce 'device_lost' flag in
	virtio_device
Date: Fri, 13 Dec 2013 14:13:29 +0100
Message-ID: <1386940410-44943-3-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
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

This flag should be set by a virtio transport driver, when it was
notified about a lost device, before the remove callback of a
backend driver is triggered.

A backend driver can test this flag in order to perform specific
actions that might be appropriate wrt the device loss.

In case of a device loss further request queueing should be prevented
by setting appropriate queue flags prior to invoking del_gendisk().
Blocking of request queueing leads to appropriate I/O errors when data
are tried to be synched. Trying to synch data to a lost block device
doesn't make too much sense.

Calling blk_cleanup_queue() when the device_lost flag is set due to a
disappeared device. It avoid hangs due to incomplete requests
(e.g. in-flight requests). Such requests must be considered as lost.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/block/virtio_blk.c | 14 +++++++++++++-
 include/linux/virtio.h     |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2d43be4..e5b4947 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -876,14 +876,26 @@ static void virtblk_remove(struct virtio_device *vdev)
 	struct virtio_blk *vblk = vdev->priv;
 	int index = vblk->index;
 	int refc;
+	int device_lost;
+	unsigned long flags;
 
 	/* Prevent config work handler from accessing the device. */
 	mutex_lock(&vblk->config_lock);
 	vblk->config_enable = false;
 	mutex_unlock(&vblk->config_lock);
 
+	device_lost = atomic_read(&vdev->device_lost);
+	if (device_lost) {
+		spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
+		queue_flag_set(QUEUE_FLAG_DYING, vblk->disk->queue);
+		queue_flag_set(QUEUE_FLAG_NOMERGES, vblk->disk->queue);
+		queue_flag_set(QUEUE_FLAG_NOXMERGES, vblk->disk->queue);
+		spin_unlock_irqrestore(vblk->disk->queue->queue_lock, flags);
+	}
+
 	del_gendisk(vblk->disk);
-	blk_cleanup_queue(vblk->disk->queue);
+	if (!device_lost)
+		blk_cleanup_queue(vblk->disk->queue);
 
 	/* Stop all the virtqueues. */
 	vdev->config->reset(vdev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f15f6e7..c18db21 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -87,6 +87,7 @@ bool virtqueue_is_broken(struct virtqueue *vq);
  * @vringh_config: configuration ops for host vrings.
  * @vqs: the list of virtqueues for this device.
  * @features: the features supported by both driver and device.
+ * @device_lost: to flag a device loss.
  * @priv: private pointer for the driver's use.
  */
 struct virtio_device {
@@ -98,6 +99,7 @@ struct virtio_device {
 	struct list_head vqs;
 	/* Note that this is a Linux set_bit-style bitmap. */
 	unsigned long features[1];
+	atomic_t device_lost;
 	void *priv;
 };
 
-- 
1.8.3.1
