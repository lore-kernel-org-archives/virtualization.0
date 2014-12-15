From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/6] virtio_pci: move probe to common file
Date: Mon, 15 Dec 2014 23:23:17 +0200
Message-ID: <1418678575-31755-5-git-send-email-mst__39868.6767941856$1418678639$gmane$org@redhat.com>
References: <1418678575-31755-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418678575-31755-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It turns out this make everything easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.h |  6 +++---
 drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/virtio/virtio_pci_legacy.c | 24 ++----------------------
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 38d99ad..adddb64 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -128,8 +128,8 @@ const char *vp_bus_name(struct virtio_device *vdev);
 int vp_set_vq_affinity(struct virtqueue *vq, int cpu);
 void virtio_pci_release_dev(struct device *);
 
-#ifdef CONFIG_PM_SLEEP
-extern const struct dev_pm_ops virtio_pci_pm_ops;
-#endif
+int virtio_pci_legacy_probe(struct pci_dev *pci_dev,
+			    const struct pci_device_id *id);
+void virtio_pci_legacy_remove(struct pci_dev *pci_dev);
 
 #endif
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 953057d..59d3685 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -458,7 +458,39 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
-const struct dev_pm_ops virtio_pci_pm_ops = {
+static const struct dev_pm_ops virtio_pci_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
 };
 #endif
+
+
+/* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
+static const struct pci_device_id virtio_pci_id_table[] = {
+	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
+
+static int virtio_pci_probe(struct pci_dev *pci_dev,
+			    const struct pci_device_id *id)
+{
+	return virtio_pci_legacy_probe(pci_dev, id);
+}
+
+static void virtio_pci_remove(struct pci_dev *pci_dev)
+{
+     virtio_pci_legacy_remove(pci_dev);
+}
+
+static struct pci_driver virtio_pci_driver = {
+	.name		= "virtio-pci",
+	.id_table	= virtio_pci_id_table,
+	.probe		= virtio_pci_probe,
+	.remove		= virtio_pci_remove,
+#ifdef CONFIG_PM_SLEEP
+	.driver.pm	= &virtio_pci_pm_ops,
+#endif
+};
+
+module_pci_driver(virtio_pci_driver);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2588252..6c76f0f 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -19,14 +19,6 @@
 
 #include "virtio_pci_common.h"
 
-/* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
-static const struct pci_device_id virtio_pci_id_table[] = {
-	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
-	{ 0 }
-};
-
-MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
-
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
 {
@@ -220,7 +212,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 };
 
 /* the PCI probing function */
-static int virtio_pci_probe(struct pci_dev *pci_dev,
+int virtio_pci_legacy_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id)
 {
 	struct virtio_pci_device *vp_dev;
@@ -300,7 +292,7 @@ out:
 	return err;
 }
 
-static void virtio_pci_remove(struct pci_dev *pci_dev)
+void virtio_pci_legacy_remove(struct pci_dev *pci_dev)
 {
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 
@@ -312,15 +304,3 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	pci_disable_device(pci_dev);
 	kfree(vp_dev);
 }
-
-static struct pci_driver virtio_pci_driver = {
-	.name		= "virtio-pci",
-	.id_table	= virtio_pci_id_table,
-	.probe		= virtio_pci_probe,
-	.remove		= virtio_pci_remove,
-#ifdef CONFIG_PM_SLEEP
-	.driver.pm	= &virtio_pci_pm_ops,
-#endif
-};
-
-module_pci_driver(virtio_pci_driver);
-- 
MST
