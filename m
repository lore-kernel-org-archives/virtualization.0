From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V3 5/6] ifcvf: replace irq_request/free with vDPA helpers
Date: Wed, 22 Jul 2020 18:08:58 +0800
Message-ID: <20200722100859.221669-6-lingshan.zhu@intel.com>
References: <20200722100859.221669-1-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200722100859.221669-1-lingshan.zhu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: jasowang@redhat.com, alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com, wanpengli@tencent.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, kvm@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This commit replaced irq_request/free() with vDPA helpers
vdpa_devm_request/free_irq() so that it can request/free
irq and setup irq offloading on order.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f5a60c14b979..65aab6bcaccb 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -47,11 +47,12 @@ static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct ifcvf_hw *vf = &adapter->vf;
+	struct vdpa_device *vdpa = &adapter->vdpa;
 	int i;
 
 
 	for (i = 0; i < queues; i++)
-		devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
+		vdpa_devm_free_irq(&pdev->dev, vdpa, vf->vring[i].irq, i, &vf->vring[i]);
 
 	ifcvf_free_irq_vectors(pdev);
 }
@@ -60,6 +61,7 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct ifcvf_hw *vf = &adapter->vf;
+	struct vdpa_device *vdpa = &adapter->vdpa;
 	int vector, i, ret, irq;
 
 	ret = pci_alloc_irq_vectors(pdev, IFCVF_MAX_INTR,
@@ -73,6 +75,10 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 		 pci_name(pdev));
 	vector = 0;
 	irq = pci_irq_vector(pdev, vector);
+	/* This is config interrupt, config accesses all go
+	 * through userspace, so no need to setup
+	 * config interrupt offloading.
+	 */
 	ret = devm_request_irq(&pdev->dev, irq,
 			       ifcvf_config_changed, 0,
 			       vf->config_msix_name, vf);
@@ -82,13 +88,11 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 			 pci_name(pdev), i);
 		vector = i + IFCVF_MSI_QUEUE_OFF;
 		irq = pci_irq_vector(pdev, vector);
-		ret = devm_request_irq(&pdev->dev, irq,
+		ret = vdpa_devm_request_irq(&pdev->dev, vdpa, irq,
 				       ifcvf_intr_handler, 0,
 				       vf->vring[i].msix_name,
-				       &vf->vring[i]);
+				       &vf->vring[i], i);
 		if (ret) {
-			IFCVF_ERR(pdev,
-				  "Failed to request irq for vq %d\n", i);
 			ifcvf_free_irq(adapter, i);
 
 			return ret;
-- 
2.18.4
