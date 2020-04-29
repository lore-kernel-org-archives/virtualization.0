From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 28/34] iommu/omap: Remove orphan_dev tracking
Date: Wed, 29 Apr 2020 15:37:06 +0200
Message-ID: <20200429133712.31431-29-joro@8bytes.org>
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

Remove the tracking of device which could not be probed because
their IOMMU is not probed yet. Replace it with a call to
bus_iommu_probe() when a new IOMMU is probed.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 54 +++-----------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 887fefcb03b4..ecc9d0829a91 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -35,15 +35,6 @@
 
 static const struct iommu_ops omap_iommu_ops;
 
-struct orphan_dev {
-	struct device *dev;
-	struct list_head node;
-};
-
-static LIST_HEAD(orphan_dev_list);
-
-static DEFINE_SPINLOCK(orphan_lock);
-
 #define to_iommu(dev)	((struct omap_iommu *)dev_get_drvdata(dev))
 
 /* bitmap of the page sizes currently supported */
@@ -62,8 +53,6 @@ static DEFINE_SPINLOCK(orphan_lock);
 static struct platform_driver omap_iommu_driver;
 static struct kmem_cache *iopte_cachep;
 
-static int _omap_iommu_add_device(struct device *dev);
-
 /**
  * to_omap_domain - Get struct omap_iommu_domain from generic iommu_domain
  * @dom:	generic iommu domain handle
@@ -1177,7 +1166,6 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	struct omap_iommu *obj;
 	struct resource *res;
 	struct device_node *of = pdev->dev.of_node;
-	struct orphan_dev *orphan_dev, *tmp;
 
 	if (!of) {
 		pr_err("%s: only DT-based devices are supported\n", __func__);
@@ -1260,13 +1248,8 @@ static int omap_iommu_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 
-	list_for_each_entry_safe(orphan_dev, tmp, &orphan_dev_list, node) {
-		err = _omap_iommu_add_device(orphan_dev->dev);
-		if (!err) {
-			list_del(&orphan_dev->node);
-			kfree(orphan_dev);
-		}
-	}
+	/* Re-probe bus to probe device attached to this IOMMU */
+	bus_iommu_probe(&platform_bus_type);
 
 	return 0;
 
@@ -1657,7 +1640,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static int _omap_iommu_add_device(struct device *dev)
+static int omap_iommu_add_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data, *tmp;
 	struct omap_iommu *oiommu;
@@ -1666,8 +1649,6 @@ static int _omap_iommu_add_device(struct device *dev)
 	struct platform_device *pdev;
 	int num_iommus, i;
 	int ret;
-	struct orphan_dev *orphan_dev;
-	unsigned long flags;
 
 	/*
 	 * Allocate the archdata iommu structure for DT-based devices.
@@ -1702,23 +1683,7 @@ static int _omap_iommu_add_device(struct device *dev)
 		if (!pdev) {
 			of_node_put(np);
 			kfree(arch_data);
-			spin_lock_irqsave(&orphan_lock, flags);
-			list_for_each_entry(orphan_dev, &orphan_dev_list,
-					    node) {
-				if (orphan_dev->dev == dev)
-					break;
-			}
-			spin_unlock_irqrestore(&orphan_lock, flags);
-
-			if (orphan_dev && orphan_dev->dev == dev)
-				return -EPROBE_DEFER;
-
-			orphan_dev = kzalloc(sizeof(*orphan_dev), GFP_KERNEL);
-			orphan_dev->dev = dev;
-			spin_lock_irqsave(&orphan_lock, flags);
-			list_add(&orphan_dev->node, &orphan_dev_list);
-			spin_unlock_irqrestore(&orphan_lock, flags);
-			return -EPROBE_DEFER;
+			return -ENODEV;
 		}
 
 		oiommu = platform_get_drvdata(pdev);
@@ -1764,17 +1729,6 @@ static int _omap_iommu_add_device(struct device *dev)
 	return 0;
 }
 
-static int omap_iommu_add_device(struct device *dev)
-{
-	int ret;
-
-	ret = _omap_iommu_add_device(dev);
-	if (ret == -EPROBE_DEFER)
-		return 0;
-
-	return ret;
-}
-
 static void omap_iommu_remove_device(struct device *dev)
 {
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
-- 
2.17.1
