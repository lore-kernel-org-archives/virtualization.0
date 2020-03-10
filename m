From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 09/15] iommu/arm-smmu-v3: Use accessor functions for iommu
 private data
Date: Tue, 10 Mar 2020 10:12:23 +0100
Message-ID: <20200310091229.29830-10-joro@8bytes.org>
References: <20200310091229.29830-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200310091229.29830-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: iommu@lists.linux-foundation.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>, Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Make use of dev_iommu_priv_set/get() functions in the code.

Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index aa3ac2a03807..2b68498dfb66 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2659,7 +2659,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!fwspec)
 		return -ENOENT;
 
-	master = fwspec->iommu_priv;
+	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
 	arm_smmu_detach_dev(master);
@@ -2795,7 +2795,7 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return -ENODEV;
 
-	if (WARN_ON_ONCE(fwspec->iommu_priv))
+	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
 		return -EBUSY;
 
 	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
@@ -2810,7 +2810,7 @@ static int arm_smmu_add_device(struct device *dev)
 	master->smmu = smmu;
 	master->sids = fwspec->ids;
 	master->num_sids = fwspec->num_ids;
-	fwspec->iommu_priv = master;
+	dev_iommu_priv_set(dev, master);
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
 	for (i = 0; i < master->num_sids; i++) {
@@ -2852,7 +2852,7 @@ static int arm_smmu_add_device(struct device *dev)
 	iommu_device_unlink(&smmu->iommu, dev);
 err_free_master:
 	kfree(master);
-	fwspec->iommu_priv = NULL;
+	dev_iommu_priv_set(dev, NULL);
 	return ret;
 }
 
@@ -2865,7 +2865,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
 
-	master = fwspec->iommu_priv;
+	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
-- 
2.17.1
