From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 01/15] iommu: Define dev_iommu_fwspec_get() for !CONFIG_IOMMU_API
Date: Tue, 10 Mar 2020 10:12:15 +0100
Message-ID: <20200310091229.29830-2-joro@8bytes.org>
References: <20200310091229.29830-1-joro@8bytes.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200310091229.29830-1-joro@8bytes.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

There are users outside of the IOMMU code that need to call that
function. Define it for !CONFIG_IOMMU_API too so that compilation does
not break.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..3c4ca041d7a2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1073,6 +1073,10 @@ static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.17.1
