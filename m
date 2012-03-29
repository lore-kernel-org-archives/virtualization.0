From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/5] virtio: drop thaw PM operation
Date: Thu, 29 Mar 2012 13:58:08 +0530
Message-ID: <50b68f453d4673e44fc5f38b5ff4a2779adab1b2.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The thaw operation was used by the balloon driver, but after the last
commit there's no reason to have separate thaw and restore callbacks.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_balloon.c |    6 ------
 drivers/virtio/virtio_pci.c     |   28 +---------------------------
 include/linux/virtio.h          |    1 -
 3 files changed, 1 insertions(+), 34 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9f1bb36..05f0a80 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -398,11 +398,6 @@ static int restore_common(struct virtio_device *vdev)
 	return 0;
 }
 
-static int virtballoon_thaw(struct virtio_device *vdev)
-{
-	return restore_common(vdev);
-}
-
 static int virtballoon_restore(struct virtio_device *vdev)
 {
 	return restore_common(vdev);
@@ -426,7 +421,6 @@ static struct virtio_driver virtio_balloon_driver = {
 #ifdef CONFIG_PM
 	.freeze	=	virtballoon_freeze,
 	.restore =	virtballoon_restore,
-	.thaw =		virtballoon_thaw,
 #endif
 };
 
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 635e1ef..a35a402 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -773,32 +773,6 @@ static int restore_common(struct device *dev)
 	return ret;
 }
 
-static int virtio_pci_thaw(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	ret = restore_common(dev);
-	if (ret)
-		return ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	if (drv && drv->thaw)
-		ret = drv->thaw(&vp_dev->vdev);
-	else if (drv && drv->restore)
-		ret = drv->restore(&vp_dev->vdev);
-
-	/* Finally, tell the device we're all set */
-	if (!ret)
-		vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
-
-	return ret;
-}
-
 static int virtio_pci_restore(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -824,7 +798,7 @@ static const struct dev_pm_ops virtio_pci_pm_ops = {
 	.suspend	= virtio_pci_suspend,
 	.resume		= virtio_pci_resume,
 	.freeze		= virtio_pci_freeze,
-	.thaw		= virtio_pci_thaw,
+	.thaw		= virtio_pci_restore,
 	.restore	= virtio_pci_restore,
 	.poweroff	= virtio_pci_suspend,
 };
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d0018d2..8efd28a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -96,7 +96,6 @@ struct virtio_driver {
 	void (*config_changed)(struct virtio_device *dev);
 #ifdef CONFIG_PM
 	int (*freeze)(struct virtio_device *dev);
-	int (*thaw)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
 #endif
 };
-- 
1.7.7.6
