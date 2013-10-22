From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 5/7] virtio_blk: do not free device id if virtqueue is
	broken
Date: Tue, 22 Oct 2013 14:45:09 +0200
Message-ID: <1382445911-55657-6-git-send-email-graalfs@linux.vnet.ibm.com>
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

Re-using the same device id when a device is re-added after it was
previously hot-unplugged should be avoided.
An additional test is added to check a potential broken virtqueue when
freeing the device id.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 98f081a..a787e6e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -874,6 +874,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	struct virtio_blk *vblk = vdev->priv;
 	int index = vblk->index;
 	int refc;
+	bool queue_broken = false;
 
 	/* Prevent config work handler from accessing the device. */
 	mutex_lock(&vblk->config_lock);
@@ -882,6 +883,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 
 	virtqueue_notify(vblk->vq);
 	if (virtqueue_is_broken(vblk->vq)) {
+		queue_broken = true;
 		blk_cleanup_queue(vblk->disk->queue);
 		del_gendisk(vblk->disk);
 	} else {
@@ -900,8 +902,10 @@ static void virtblk_remove(struct virtio_device *vdev)
 	vdev->config->del_vqs(vdev);
 	kfree(vblk);
 
-	/* Only free device id if we don't have any users */
-	if (refc == 1)
+	/* Only free device id if we don't have any users
+	 * and virtqueue is not broken due to a hot-unplugged device
+	 */
+	if (refc == 1 && !queue_broken)
 		ida_simple_remove(&vd_index_ida, index);
 }
 
-- 
1.8.3.1
