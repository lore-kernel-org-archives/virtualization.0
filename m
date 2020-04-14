From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 01/33] iommu: Move default domain allocation to separate
 function
Date: Tue, 14 Apr 2020 15:15:10 +0200
Message-ID: <20200414131542.25608-2-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Move the code out of iommu_group_get_for_dev() into a separate
function.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 74 ++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..bfe011760ed1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1361,6 +1361,41 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+static int iommu_alloc_default_domain(struct device *dev,
+				      struct iommu_group *group)
+{
+	struct iommu_domain *dom;
+
+	if (group->default_domain)
+		return 0;
+
+	dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
+	if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
+		if (dom) {
+			dev_warn(dev,
+				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
+				 iommu_def_domain_type);
+		}
+	}
+
+	if (!dom)
+		return -ENOMEM;
+
+	group->default_domain = dom;
+	if (!group->domain)
+		group->domain = dom;
+
+	if (!iommu_dma_strict) {
+		int attr = 1;
+		iommu_domain_set_attr(dom,
+				      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+				      &attr);
+	}
+
+	return 0;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1393,40 +1428,21 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	/*
 	 * Try to allocate a default domain - needs support from the
-	 * IOMMU driver.
+	 * IOMMU driver. There are still some drivers which don't support
+	 * default domains, so the return value is not yet checked.
 	 */
-	if (!group->default_domain) {
-		struct iommu_domain *dom;
-
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
-			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
-			if (dom) {
-				dev_warn(dev,
-					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-					 iommu_def_domain_type);
-			}
-		}
-
-		group->default_domain = dom;
-		if (!group->domain)
-			group->domain = dom;
-
-		if (dom && !iommu_dma_strict) {
-			int attr = 1;
-			iommu_domain_set_attr(dom,
-					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
-					      &attr);
-		}
-	}
+	iommu_alloc_default_domain(dev, group);
 
 	ret = iommu_group_add_device(group, dev);
-	if (ret) {
-		iommu_group_put(group);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto out_put_group;
 
 	return group;
+
+out_put_group:
+	iommu_group_put(group);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(iommu_group_get_for_dev);
 
-- 
2.17.1
