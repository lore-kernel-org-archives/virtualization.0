From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 02/15] ACPI/IORT: Remove direct access of dev->iommu_fwspec
Date: Tue, 10 Mar 2020 10:12:16 +0100
Message-ID: <20200310091229.29830-3-joro@8bytes.org>
References: <20200310091229.29830-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310091229.29830-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the accessor functions instead of directly dereferencing
dev->iommu_fwspec.

Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/arm64/iort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ed3d2d1a7ae9..7d04424189df 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1015,6 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		return ops;
 
 	if (dev_is_pci(dev)) {
+		struct iommu_fwspec *fwspec;
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
 		struct iort_pci_alias_info info = { .dev = dev };
 
@@ -1027,8 +1028,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     iort_pci_iommu_init, &info);
 
-		if (!err && iort_pci_rc_supports_ats(node))
-			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (fwspec && iort_pci_rc_supports_ats(node))
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
 	} else {
 		int i = 0;
 
-- 
2.17.1
