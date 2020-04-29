From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 29/34] iommu/omap: Convert to probe/release_device()
 call-backs
Date: Wed, 29 Apr 2020 15:37:07 +0200
Message-ID: <20200429133712.31431-30-joro@8bytes.org>
References: <20200429133712.31431-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200429133712.31431-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Convert the OMAP IOMMU driver to use the probe_device() and
release_device() call-backs of iommu_ops, so that the iommu core code
does the group and sysfs setup.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 49 ++++++++++----------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index ecc9d0829a91..6699fe6d9e06 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1640,15 +1640,13 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static int omap_iommu_add_device(struct device *dev)
+static struct iommu_device *omap_iommu_probe_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data, *tmp;
+	struct platform_device *pdev;
 	struct omap_iommu *oiommu;
-	struct iommu_group *group;
 	struct device_node *np;
-	struct platform_device *pdev;
 	int num_iommus, i;
-	int ret;
 
 	/*
 	 * Allocate the archdata iommu structure for DT-based devices.
@@ -1657,7 +1655,7 @@ static int omap_iommu_add_device(struct device *dev)
 	 * IOMMU users.
 	 */
 	if (!dev->of_node)
-		return 0;
+		return ERR_PTR(-ENODEV);
 
 	/*
 	 * retrieve the count of IOMMU nodes using phandle size as element size
@@ -1670,27 +1668,27 @@ static int omap_iommu_add_device(struct device *dev)
 
 	arch_data = kcalloc(num_iommus + 1, sizeof(*arch_data), GFP_KERNEL);
 	if (!arch_data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
 		np = of_parse_phandle(dev->of_node, "iommus", i);
 		if (!np) {
 			kfree(arch_data);
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 		}
 
 		pdev = of_find_device_by_node(np);
 		if (!pdev) {
 			of_node_put(np);
 			kfree(arch_data);
-			return -ENODEV;
+			return ERR_PTR(-ENODEV);
 		}
 
 		oiommu = platform_get_drvdata(pdev);
 		if (!oiommu) {
 			of_node_put(np);
 			kfree(arch_data);
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 		}
 
 		tmp->iommu_dev = oiommu;
@@ -1699,46 +1697,25 @@ static int omap_iommu_add_device(struct device *dev)
 		of_node_put(np);
 	}
 
+	dev->archdata.iommu = arch_data;
+
 	/*
 	 * use the first IOMMU alone for the sysfs device linking.
 	 * TODO: Evaluate if a single iommu_group needs to be
 	 * maintained for both IOMMUs
 	 */
 	oiommu = arch_data->iommu_dev;
-	ret = iommu_device_link(&oiommu->iommu, dev);
-	if (ret) {
-		kfree(arch_data);
-		return ret;
-	}
-
-	dev->archdata.iommu = arch_data;
-
-	/*
-	 * IOMMU group initialization calls into omap_iommu_device_group, which
-	 * needs a valid dev->archdata.iommu pointer
-	 */
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group)) {
-		iommu_device_unlink(&oiommu->iommu, dev);
-		dev->archdata.iommu = NULL;
-		kfree(arch_data);
-		return PTR_ERR(group);
-	}
-	iommu_group_put(group);
 
-	return 0;
+	return &oiommu->iommu;
 }
 
-static void omap_iommu_remove_device(struct device *dev)
+static void omap_iommu_release_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
 
 	if (!dev->of_node || !arch_data)
 		return;
 
-	iommu_device_unlink(&arch_data->iommu_dev->iommu, dev);
-	iommu_group_remove_device(dev);
-
 	dev->archdata.iommu = NULL;
 	kfree(arch_data);
 
@@ -1763,8 +1740,8 @@ static const struct iommu_ops omap_iommu_ops = {
 	.map		= omap_iommu_map,
 	.unmap		= omap_iommu_unmap,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
-	.add_device	= omap_iommu_add_device,
-	.remove_device	= omap_iommu_remove_device,
+	.probe_device	= omap_iommu_probe_device,
+	.release_device	= omap_iommu_release_device,
 	.device_group	= omap_iommu_device_group,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 };
-- 
2.17.1
