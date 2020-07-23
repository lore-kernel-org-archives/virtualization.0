From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/2] vdpa: ifcvf: free config irq in ifcvf_free_irq()
Date: Thu, 23 Jul 2020 17:12:54 +0800
Message-ID: <20200723091254.20617-2-jasowang@redhat.com>
References: <20200723091254.20617-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200723091254.20617-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

We don't free config irq in ifcvf_free_irq() which will trigger a
BUG() in pci core since we try to free the vectors that has an
action. Fixing this by recording the config irq in ifcvf_hw structure
and free it in ifcvf_free_irq().

Fixes: e7991f376a4d ("ifcvf: implement config interrupt in IFCVF")
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.h | 2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index f4554412e607..29efa75cdfce 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -84,7 +84,7 @@ struct ifcvf_hw {
 	void __iomem * const *base;
 	char config_msix_name[256];
 	struct vdpa_callback config_cb;
-
+	unsigned int config_irq;
 };
 
 struct ifcvf_adapter {
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index ae7110955a44..7a6d899e541d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -53,6 +53,7 @@ static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
 	for (i = 0; i < queues; i++)
 		devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
 
+	devm_free_irq(&pdev->dev, vf->config_irq, vf);
 	ifcvf_free_irq_vectors(pdev);
 }
 
@@ -72,8 +73,8 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 	snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
 		 pci_name(pdev));
 	vector = 0;
-	irq = pci_irq_vector(pdev, vector);
-	ret = devm_request_irq(&pdev->dev, irq,
+	vf->config_irq = pci_irq_vector(pdev, vector);
+	ret = devm_request_irq(&pdev->dev, vf->config_irq,
 			       ifcvf_config_changed, 0,
 			       vf->config_msix_name, vf);
 	if (ret) {
-- 
2.20.1
