From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 22/22] virtio_pci: fix finalize_features in modern driver.
Date: Thu, 21 Mar 2013 18:59:43 +1030
Message-ID: <1363854584-25795-23-git-send-email-rusty@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Because we have potentially-infinite feature bits, it's hard for the device
to know when features are finalized.

This adds a new status bit, VIRTIO_CONFIG_S_FEATURES_DONE, which is only
set by the modern virtio_pci driver at the moment.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci-common.c |   28 --------------
 drivers/virtio/virtio_pci-common.h |    1 -
 drivers/virtio/virtio_pci.c        |   73 ++++++++++++++++++++++++++----------
 drivers/virtio/virtio_pci_legacy.c |   27 +++++++++++++
 include/uapi/linux/virtio_config.h |    2 +
 5 files changed, 83 insertions(+), 48 deletions(-)

diff --git a/drivers/virtio/virtio_pci-common.c b/drivers/virtio/virtio_pci-common.c
index d4e33ad..d2c78c8 100644
--- a/drivers/virtio/virtio_pci-common.c
+++ b/drivers/virtio/virtio_pci-common.c
@@ -392,32 +392,4 @@ int virtio_pci_freeze(struct device *dev)
 		pci_disable_device(pci_dev);
 	return ret;
 }
-
-int virtio_pci_restore(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
-	struct virtio_driver *drv;
-	int ret;
-
-	drv = container_of(vp_dev->vdev.dev.driver,
-			   struct virtio_driver, driver);
-
-	ret = pci_enable_device(pci_dev);
-	if (ret)
-		return ret;
-
-	pci_set_master(pci_dev);
-	vp_dev->vdev.config->finalize_features(&vp_dev->vdev);
-
-	if (drv && drv->restore)
-		ret = drv->restore(&vp_dev->vdev);
-
-	/* Finally, tell the device we're all set */
-	if (!ret)
-		vp_dev->vdev.config->set_status(&vp_dev->vdev,
-						vp_dev->saved_status);
-
-	return ret;
-}
 #endif
diff --git a/drivers/virtio/virtio_pci-common.h b/drivers/virtio/virtio_pci-common.h
index 146c3be..dac434e 100644
--- a/drivers/virtio/virtio_pci-common.h
+++ b/drivers/virtio/virtio_pci-common.h
@@ -118,5 +118,4 @@ int virtio_pci_set_vq_affinity(struct virtqueue *vq, int cpu);
 
 #ifdef CONFIG_PM
 int virtio_pci_freeze(struct device *dev);
-int virtio_pci_restore(struct device *dev);
 #endif
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 97d9b54..4614a15 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -50,6 +50,21 @@ static u64 ioread64(__le64 *addr)
 	return ioread32(addr) | ((u64)ioread32((__le32 *)addr + 1) << 32);
 }
 
+/* config->{get,set}_status() implementations */
+static u8 vp_get_status(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	return ioread8(&vp_dev->common->device_status);
+}
+
+static void vp_set_status(struct virtio_device *vdev, u8 status)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	/* We should never be setting status to 0. */
+	BUG_ON(status == 0);
+	iowrite8(status, &vp_dev->common->device_status);
+}
+
 static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -62,19 +77,27 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	return features;
 }
 
-static void vp_finalize_features(struct virtio_device *vdev)
+static void write_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	/* Give virtio_ring a chance to accept features. */
-	vring_transport_features(vdev);
-
 	iowrite32(0, &vp_dev->common->guest_feature_select);
 	iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
 	iowrite32(1, &vp_dev->common->guest_feature_select);
 	iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
 }
 
+static void vp_finalize_features(struct virtio_device *vdev)
+{
+	/* Give virtio_ring a chance to accept features. */
+	vring_transport_features(vdev);
+
+	write_features(vdev);
+
+	/* Update status to lock it in. */
+	vp_set_status(vdev, vp_get_status(vdev)|VIRTIO_CONFIG_S_FEATURES_DONE);
+}
+
 /* virtio config is little-endian for virtio_pci (vs guest-endian for legacy) */
 static u8 vp_get8(struct virtio_device *vdev, unsigned offset)
 {
@@ -132,21 +155,6 @@ static void vp_set64(struct virtio_device *vdev, unsigned offset, u64 val)
 	iowrite64(val, vp_dev->device + offset);
 }
 
-/* config->{get,set}_status() implementations */
-static u8 vp_get_status(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return ioread8(&vp_dev->common->device_status);
-}
-
-static void vp_set_status(struct virtio_device *vdev, u8 status)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	/* We should never be setting status to 0. */
-	BUG_ON(status == 0);
-	iowrite8(status, &vp_dev->common->device_status);
-}
-
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -571,6 +579,33 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PM
+static int virtio_pci_restore(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_driver *drv;
+	int ret;
+
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci_dev);
+	write_features(&vp_dev->vdev);
+
+	if (drv && drv->restore)
+		ret = drv->restore(&vp_dev->vdev);
+
+	/* Finally, tell the device we're all set */
+	if (!ret)
+		vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
+
+	return ret;
+}
+
 static const struct dev_pm_ops virtio_pci_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
 };
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index f78a858..cfff009 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -436,6 +436,33 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PM
+static int virtio_pci_restore(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_driver *drv;
+	int ret;
+
+	drv = container_of(vp_dev->vdev.dev.driver,
+			   struct virtio_driver, driver);
+
+	ret = pci_enable_device(pci_dev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci_dev);
+	vp_finalize_features(&vp_dev->vdev);
+
+	if (drv && drv->restore)
+		ret = drv->restore(&vp_dev->vdev);
+
+	/* Finally, tell the device we're all set */
+	if (!ret)
+		vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
+
+	return ret;
+}
+
 static const struct dev_pm_ops virtio_pci_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
 };
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index b7cda39..83848b7 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -36,6 +36,8 @@
 #define VIRTIO_CONFIG_S_ACKNOWLEDGE	1
 /* We have found a driver for the device. */
 #define VIRTIO_CONFIG_S_DRIVER		2
+/* Features are finalized (only for new virtio_pci) */
+#define VIRTIO_CONFIG_S_FEATURES_DONE	8
 /* Driver has used its parts of the config, and is happy */
 #define VIRTIO_CONFIG_S_DRIVER_OK	4
 /* We've given up on this device. */
-- 
1.7.10.4
