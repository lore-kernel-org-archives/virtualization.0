From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/3] virtio: balloon: separate out common code between remove
	and freeze functions
Date: Fri, 27 Apr 2012 00:45:57 +0530
Message-ID: <c207cb69a1469afc9d8addcdc8d336da5286fc6e.1335467427.git.amit.shah@redhat.com>
References: <cover.1335467427.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1335467427.git.amit.shah@redhat.com>
In-Reply-To: <cover.1335467427.git.amit.shah@redhat.com>
References: <cover.1335467427.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The remove and freeze functions have a lot of shared code; put it into a
common function that gets called by both.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_balloon.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 04baad6..bfbc15c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -381,21 +381,25 @@ out:
 	return err;
 }
 
-static void __devexit virtballoon_remove(struct virtio_device *vdev)
+static void remove_common(struct virtio_balloon *vb)
 {
-	struct virtio_balloon *vb = vdev->priv;
-
-	kthread_stop(vb->thread);
-
 	/* There might be pages left in the balloon: free them. */
 	while (vb->num_pages)
 		leak_balloon(vb, vb->num_pages);
 	update_balloon_size(vb);
 
 	/* Now we reset the device so we can clean up the queues. */
-	vdev->config->reset(vdev);
+	vb->vdev->config->reset(vb->vdev);
 
-	vdev->config->del_vqs(vdev);
+	vb->vdev->config->del_vqs(vb->vdev);
+}
+
+static void __devexit virtballoon_remove(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	kthread_stop(vb->thread);
+	remove_common(vb);
 	kfree(vb);
 }
 
@@ -409,13 +413,7 @@ static int virtballoon_freeze(struct virtio_device *vdev)
 	 * function is called.
 	 */
 
-	while (vb->num_pages)
-		leak_balloon(vb, vb->num_pages);
-	update_balloon_size(vb);
-
-	/* Ensure we don't get any more requests from the host */
-	vdev->config->reset(vdev);
-	vdev->config->del_vqs(vdev);
+	remove_common(vb);
 	return 0;
 }
 
-- 
1.7.7.6
