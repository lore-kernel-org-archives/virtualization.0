From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH] virtio_pci: support enabling VFs
Date: Wed, 30 May 2018 16:55:21 +0800
Message-ID: <20180530085521.26583-1-tiwei.bie__16075.7954734892$1527670410$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, bhelgaas@google.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc: alexander.h.duyck@intel.com, mark.d.rustad@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

There is a new feature bit allocated in virtio spec to
support SR-IOV (Single Root I/O Virtualization):

https://github.com/oasis-tcs/virtio-spec/issues/11

This patch enables the support for this feature bit in
virtio driver.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
This patch depends on below proposal:
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00154.html

This patch depends on below patch:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=8effc395c2097e258fcedfc02ed4a66d45fb4238

 drivers/virtio/virtio_pci_common.c | 20 ++++++++++++++++++++
 drivers/virtio/virtio_pci_modern.c | 14 ++++++++++++++
 include/uapi/linux/virtio_config.h |  7 ++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 48d4d1cf1cb6..023da80a7a3e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -588,6 +588,25 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	put_device(dev);
 }
 
+static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_device *vdev = &vp_dev->vdev;
+	int (*sriov_configure)(struct pci_dev *pci_dev, int num_vfs);
+
+	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		return -EBUSY;
+
+	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
+		return -EINVAL;
+
+	sriov_configure = pci_sriov_configure_simple;
+	if (sriov_configure == NULL)
+		return -ENOENT;
+
+	return sriov_configure(pci_dev, num_vfs);
+}
+
 static struct pci_driver virtio_pci_driver = {
 	.name		= "virtio-pci",
 	.id_table	= virtio_pci_id_table,
@@ -596,6 +615,7 @@ static struct pci_driver virtio_pci_driver = {
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
+	.sriov_configure = virtio_pci_sriov_configure,
 };
 
 module_pci_driver(virtio_pci_driver);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 2555d80f6eec..07571daccfec 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -153,14 +153,28 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+static void vp_transport_features(struct virtio_device *vdev, u64 features)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+
+	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
+			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
+		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_pci a chance to accept features. */
+	vp_transport_features(vdev, features);
+
 	if (!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
 		dev_err(&vdev->dev, "virtio: device uses modern interface "
 			"but does not have VIRTIO_F_VERSION_1\n");
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..b7c1f4e7d59e 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		38
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +71,9 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/*
+ * Does the device support Single Root I/O Virtualization?
+ */
+#define VIRTIO_F_SR_IOV			37
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.17.0
