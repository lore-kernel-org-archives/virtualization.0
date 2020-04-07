From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 28/34] iommu/renesas: Convert to probe/release_device()
 call-backs
Date: Tue,  7 Apr 2020 20:37:36 +0200
Message-ID: <20200407183742.4344-29-joro@8bytes.org>
References: <20200407183742.4344-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200407183742.4344-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Convert the Renesas IOMMU driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 60 +++++++++++++-------------------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 310cf09feea3..fb7e702dee23 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -805,24 +805,8 @@ static int ipmmu_of_xlate(struct device *dev,
 static int ipmmu_init_arm_mapping(struct device *dev)
 {
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	struct iommu_group *group;
 	int ret;
 
-	/* Create a device group and add the device to it. */
-	group = iommu_group_alloc();
-	if (IS_ERR(group)) {
-		dev_err(dev, "Failed to allocate IOMMU group\n");
-		return PTR_ERR(group);
-	}
-
-	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-
-	if (ret < 0) {
-		dev_err(dev, "Failed to add device to IPMMU group\n");
-		return ret;
-	}
-
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
 	 * VAs. This will allocate a corresponding IOMMU domain.
@@ -856,48 +840,39 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 	return 0;
 
 error:
-	iommu_group_remove_device(dev);
 	if (mmu->mapping)
 		arm_iommu_release_mapping(mmu->mapping);
 
 	return ret;
 }
 
-static int ipmmu_add_device(struct device *dev)
+static struct iommu_device *ipmmu_probe_device(struct device *dev)
 {
 	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-	struct iommu_group *group;
-	int ret;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
 	if (!mmu)
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 
-	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
-		ret = ipmmu_init_arm_mapping(dev);
-		if (ret)
-			return ret;
-	} else {
-		group = iommu_group_get_for_dev(dev);
-		if (IS_ERR(group))
-			return PTR_ERR(group);
+	return &mmu->iommu;
+}
 
-		iommu_group_put(group);
-	}
+static void ipmmu_probe_finalize(struct device *dev)
+{
+	int ret = 0;
 
-	iommu_device_link(&mmu->iommu, dev);
-	return 0;
+	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
+		ret = ipmmu_init_arm_mapping(dev);
+
+	if (ret)
+		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
 }
 
-static void ipmmu_remove_device(struct device *dev)
+static void ipmmu_release_device(struct device *dev)
 {
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
-
-	iommu_device_unlink(&mmu->iommu, dev);
 	arm_iommu_detach_device(dev);
-	iommu_group_remove_device(dev);
 }
 
 static struct iommu_group *ipmmu_find_group(struct device *dev)
@@ -925,9 +900,14 @@ static const struct iommu_ops ipmmu_ops = {
 	.flush_iotlb_all = ipmmu_flush_iotlb_all,
 	.iotlb_sync = ipmmu_iotlb_sync,
 	.iova_to_phys = ipmmu_iova_to_phys,
-	.add_device = ipmmu_add_device,
-	.remove_device = ipmmu_remove_device,
+	.probe_device = ipmmu_probe_device,
+	.release_device = ipmmu_release_device,
+	.probe_finalize = ipmmu_probe_finalize,
+#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
+	.device_group = generic_device_group,
+#else
 	.device_group = ipmmu_find_group,
+#endif
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 	.of_xlate = ipmmu_of_xlate,
 };
-- 
2.17.1
