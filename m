From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 26/34] iommu/tegra: Convert to probe/release_device() call-backs
Date: Wed, 29 Apr 2020 15:37:04 +0200
Message-ID: <20200429133712.31431-27-joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200429133712.31431-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Convert the Tegra IOMMU drivers to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 24 ++++++------------------
 drivers/iommu/tegra-smmu.c | 31 ++++++++-----------------------
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index db6559e8336f..5fbdff6ff41a 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -243,28 +243,16 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 	return false;
 }
 
-static int gart_iommu_add_device(struct device *dev)
+static struct iommu_device *gart_iommu_probe_device(struct device *dev)
 {
-	struct iommu_group *group;
-
 	if (!dev_iommu_fwspec_get(dev))
-		return -ENODEV;
-
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
+		return ERR_PTR(-ENODEV);
 
-	iommu_device_link(&gart_handle->iommu, dev);
-
-	return 0;
+	return &gart_handle->iommu;
 }
 
-static void gart_iommu_remove_device(struct device *dev)
+static void gart_iommu_release_device(struct device *dev)
 {
-	iommu_group_remove_device(dev);
-	iommu_device_unlink(&gart_handle->iommu, dev);
 }
 
 static int gart_iommu_of_xlate(struct device *dev,
@@ -290,8 +278,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.domain_free	= gart_iommu_domain_free,
 	.attach_dev	= gart_iommu_attach_dev,
 	.detach_dev	= gart_iommu_detach_dev,
-	.add_device	= gart_iommu_add_device,
-	.remove_device	= gart_iommu_remove_device,
+	.probe_device	= gart_iommu_probe_device,
+	.release_device	= gart_iommu_release_device,
 	.device_group	= generic_device_group,
 	.map		= gart_iommu_map,
 	.unmap		= gart_iommu_unmap,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 63a147b623e6..7426b7666e2b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -757,11 +757,10 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
 	return 0;
 }
 
-static int tegra_smmu_add_device(struct device *dev)
+static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct tegra_smmu *smmu = NULL;
-	struct iommu_group *group;
 	struct of_phandle_args args;
 	unsigned int index = 0;
 	int err;
@@ -774,7 +773,7 @@ static int tegra_smmu_add_device(struct device *dev)
 			of_node_put(args.np);
 
 			if (err < 0)
-				return err;
+				return ERR_PTR(err);
 
 			/*
 			 * Only a single IOMMU master interface is currently
@@ -783,8 +782,6 @@ static int tegra_smmu_add_device(struct device *dev)
 			 */
 			dev->archdata.iommu = smmu;
 
-			iommu_device_link(&smmu->iommu, dev);
-
 			break;
 		}
 
@@ -793,26 +790,14 @@ static int tegra_smmu_add_device(struct device *dev)
 	}
 
 	if (!smmu)
-		return -ENODEV;
-
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
+		return ERR_PTR(-ENODEV);
 
-	return 0;
+	return &smmu->iommu;
 }
 
-static void tegra_smmu_remove_device(struct device *dev)
+static void tegra_smmu_release_device(struct device *dev)
 {
-	struct tegra_smmu *smmu = dev->archdata.iommu;
-
-	if (smmu)
-		iommu_device_unlink(&smmu->iommu, dev);
-
 	dev->archdata.iommu = NULL;
-	iommu_group_remove_device(dev);
 }
 
 static const struct tegra_smmu_group_soc *
@@ -895,8 +880,8 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.domain_free = tegra_smmu_domain_free,
 	.attach_dev = tegra_smmu_attach_dev,
 	.detach_dev = tegra_smmu_detach_dev,
-	.add_device = tegra_smmu_add_device,
-	.remove_device = tegra_smmu_remove_device,
+	.probe_device = tegra_smmu_probe_device,
+	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
@@ -1015,7 +1000,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	 * value. However the IOMMU registration process will attempt to add
 	 * all devices to the IOMMU when bus_set_iommu() is called. In order
 	 * not to rely on global variables to track the IOMMU instance, we
-	 * set it here so that it can be looked up from the .add_device()
+	 * set it here so that it can be looked up from the .probe_device()
 	 * callback via the IOMMU device's .drvdata field.
 	 */
 	mc->smmu = smmu;
-- 
2.17.1
