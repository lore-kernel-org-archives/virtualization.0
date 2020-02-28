From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 07/14] iommu: Introduce accessors for iommu private data
Date: Fri, 28 Feb 2020 16:08:13 +0100
Message-ID: <20200228150820.15340-8-joro@8bytes.org>
References: <20200228150820.15340-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200228150820.15340-1-joro@8bytes.org>
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

Add dev_iommu_priv_get/set() functions to access per-device iommu
private data. This makes it easier to move the pointer to a different
location.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/iommu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a049bcb660e1..904fb24418e5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -627,6 +627,16 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 	dev->iommu->fwspec = fwspec;
 }
 
+static inline void *dev_iommu_priv_get(struct device *dev)
+{
+	return dev->iommu->fwspec->iommu_priv;
+}
+
+static inline void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+	dev->iommu->fwspec->iommu_priv = priv;
+}
+
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
-- 
2.17.1
