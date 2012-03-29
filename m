From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/5] virtio-pci: drop restore_common()
Date: Thu, 29 Mar 2012 13:58:09 +0530
Message-ID: <fc7c9585359c0eef15880cd6dbb068ddb9a55463.1333008576.git.amit.shah@redhat.com>
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

restore_common() was shared between restore and thaw callbacks.  With
thaw gone, we don't need restore_common() anymore.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_pci.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a35a402..982d6c9 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -758,33 +758,24 @@ static int virtio_pci_freeze(struct device *dev)
 	return ret;
 }
 
-static int restore_common(struct device *dev)
+static int virtio_pci_restore(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_driver *drv;
 	int ret;
 
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
 	ret = pci_enable_device(pci_dev);
 	if (ret)
 		return ret;
+
 	pci_set_master(pci_dev);
 	vp_finalize_features(&vp_dev->vdev);
 
-	return ret;
-}
-
-static int virtio_pci_restore(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	ret = restore_common(dev);
-	if (!ret && drv && drv->restore)
+	if (drv && drv->restore)
 		ret = drv->restore(&vp_dev->vdev);
 
 	/* Finally, tell the device we're all set */
-- 
1.7.7.6
