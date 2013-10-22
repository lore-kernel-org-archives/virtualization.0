From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 4/7] virtio_blk: use dummy virtqueue_notify() to detect
	host kick error
Date: Tue, 22 Oct 2013 14:45:08 +0200
Message-ID: <1382445911-55657-5-git-send-email-graalfs@linux.vnet.ibm.com>
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

Deleting the disk and partitions in virtblk_remove() via del_gendisk() causes
never ending waits when trying to synch dirty inode pages.

A dummy virtqueue_notify() in virtblk_remove() is used to detect a host
notification error, latter occurs when block device was hot-unplugged.
When the dummy host kick failed blk_cleanup_queue() should be invoked
prior to del_gendisk().

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6472395..98f081a 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -880,8 +880,14 @@ static void virtblk_remove(struct virtio_device *vdev)
 	vblk->config_enable = false;
 	mutex_unlock(&vblk->config_lock);
 
-	del_gendisk(vblk->disk);
-	blk_cleanup_queue(vblk->disk->queue);
+	virtqueue_notify(vblk->vq);
+	if (virtqueue_is_broken(vblk->vq)) {
+		blk_cleanup_queue(vblk->disk->queue);
+		del_gendisk(vblk->disk);
+	} else {
+		del_gendisk(vblk->disk);
+		blk_cleanup_queue(vblk->disk->queue);
+	}
 
 	/* Stop all the virtqueues. */
 	vdev->config->reset(vdev);
-- 
1.8.3.1
