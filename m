From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 12/33] iommu: Move iommu_group_create_direct_mappings() out
 of iommu_group_add_device()
Date: Tue, 14 Apr 2020 15:15:21 +0200
Message-ID: <20200414131542.25608-13-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20200414131542.25608-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

After the previous changes the iommu group may not have a default
domain when iommu_group_add_device() is called. With no default domain
iommu_group_create_direct_mappings() will do nothing and no direct
mappings will be created.

Rename iommu_group_create_direct_mappings() to
iommu_create_device_direct_mappings() to better reflect that the
function creates direct mappings only for one device and not for all
devices in the group. Then move the call to the places where a default
domain actually exists.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7de0e29db333..834a45da0ed0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -89,6 +89,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static void __iommu_detach_group(struct iommu_domain *domain,
 				 struct iommu_group *group);
+static int iommu_create_device_direct_mappings(struct iommu_group *group,
+					       struct device *dev);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -243,6 +245,8 @@ static int __iommu_probe_device_helper(struct device *dev)
 	if (group->default_domain)
 		ret = __iommu_attach_device(group->default_domain, dev);
 
+	iommu_create_device_direct_mappings(group, dev);
+
 	iommu_group_put(group);
 
 	if (ret)
@@ -263,6 +267,7 @@ static int __iommu_probe_device_helper(struct device *dev)
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct iommu_group *group;
 	int ret;
 
 	WARN_ON(dev->iommu_group);
@@ -285,6 +290,10 @@ int iommu_probe_device(struct device *dev)
 	if (ret)
 		goto err_module_put;
 
+	group = iommu_group_get(dev);
+	iommu_create_device_direct_mappings(group, dev);
+	iommu_group_put(group);
+
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
@@ -736,8 +745,8 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
 }
 EXPORT_SYMBOL_GPL(iommu_group_set_name);
 
-static int iommu_group_create_direct_mappings(struct iommu_group *group,
-					      struct device *dev)
+static int iommu_create_device_direct_mappings(struct iommu_group *group,
+					       struct device *dev)
 {
 	struct iommu_domain *domain = group->default_domain;
 	struct iommu_resv_region *entry;
@@ -841,8 +850,6 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	dev->iommu_group = group;
 
-	iommu_group_create_direct_mappings(group, dev);
-
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
@@ -1736,6 +1743,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 		gtype.type = iommu_def_domain_type;
 
 	iommu_group_alloc_default_domain(bus, group, gtype.type);
+
 }
 
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
@@ -1760,6 +1768,21 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 					  iommu_group_do_dma_attach);
 }
 
+static int iommu_do_create_direct_mappings(struct device *dev, void *data)
+{
+	struct iommu_group *group = data;
+
+	iommu_create_device_direct_mappings(group, dev);
+
+	return 0;
+}
+
+static int iommu_group_create_direct_mappings(struct iommu_group *group)
+{
+	return __iommu_group_for_each_dev(group, group,
+					  iommu_do_create_direct_mappings);
+}
+
 static int bus_iommu_probe(struct bus_type *bus)
 {
 	const struct iommu_ops *ops = bus->iommu_ops;
@@ -1792,6 +1815,8 @@ static int bus_iommu_probe(struct bus_type *bus)
 				continue;
 			}
 
+			iommu_group_create_direct_mappings(group);
+
 			ret = __iommu_group_dma_attach(group);
 
 			mutex_unlock(&group->mutex);
@@ -2632,7 +2657,7 @@ request_default_domain_for_dev(struct device *dev, unsigned long type)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = domain;
 
-	iommu_group_create_direct_mappings(group, dev);
+	iommu_create_device_direct_mappings(group, dev);
 
 	dev_info(dev, "Using iommu %s mapping\n",
 		 type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
-- 
2.17.1
