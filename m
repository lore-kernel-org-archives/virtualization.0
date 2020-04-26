From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V4 3/3] vdpa: implement config interrupt in IFCVF
Date: Sun, 26 Apr 2020 19:43:26 +0800
Message-ID: <1587901406-27400-4-git-send-email-lingshan.zhu@intel.com>
References: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This commit implements config interrupt support
in IFC VF

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c |  3 +++
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 +++
 drivers/vdpa/ifcvf/ifcvf_main.c | 22 +++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index b61b06e..c825d99 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -185,6 +185,9 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 status)
 
 void ifcvf_reset(struct ifcvf_hw *hw)
 {
+	hw->config_cb.callback = NULL;
+	hw->config_cb.private = NULL;
+
 	ifcvf_set_status(hw, 0);
 	/* flush set_status, make sure VF is stopped, reset */
 	ifcvf_get_status(hw);
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index e803070..23ac47d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -27,6 +27,7 @@
 		((1ULL << VIRTIO_NET_F_MAC)			| \
 		 (1ULL << VIRTIO_F_ANY_LAYOUT)			| \
 		 (1ULL << VIRTIO_F_VERSION_1)			| \
+		 (1ULL << VIRTIO_NET_F_STATUS)			| \
 		 (1ULL << VIRTIO_F_ORDER_PLATFORM)		| \
 		 (1ULL << VIRTIO_F_IOMMU_PLATFORM)		| \
 		 (1ULL << VIRTIO_NET_F_MRG_RXBUF))
@@ -81,6 +82,8 @@ struct ifcvf_hw {
 	void __iomem *net_cfg;
 	struct vring_info vring[IFCVF_MAX_QUEUE_PAIRS * 2];
 	void __iomem * const *base;
+	char config_msix_name[256];
+	struct vdpa_callback config_cb;
 };
 
 struct ifcvf_adapter {
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8d54dc5..f7baeca 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -18,6 +18,16 @@
 #define DRIVER_AUTHOR   "Intel Corporation"
 #define IFCVF_DRIVER_NAME       "ifcvf"
 
+static irqreturn_t ifcvf_config_changed(int irq, void *arg)
+{
+	struct ifcvf_hw *vf = arg;
+
+	if (vf->config_cb.callback)
+		return vf->config_cb.callback(vf->config_cb.private);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ifcvf_intr_handler(int irq, void *arg)
 {
 	struct vring_info *vring = arg;
@@ -256,7 +266,10 @@ static void ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
 static void ifcvf_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
 				     struct vdpa_callback *cb)
 {
-	/* We don't support config interrupt */
+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
+
+	vf->config_cb.callback = cb->callback;
+	vf->config_cb.private = cb->private;
 }
 
 /*
@@ -292,6 +305,13 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 	struct ifcvf_hw *vf = &adapter->vf;
 	int vector, i, ret, irq;
 
+	snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
+		pci_name(pdev));
+	vector = 0;
+	irq = pci_irq_vector(pdev, vector);
+	ret = devm_request_irq(&pdev->dev, irq,
+			       ifcvf_config_changed, 0,
+			       vf->config_msix_name, vf);
 
 	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
 		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
-- 
1.8.3.1
