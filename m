From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 11/33] iommu: Split off default domain allocation from
 group assignment
Date: Tue, 14 Apr 2020 15:15:20 +0200
Message-ID: <20200414131542.25608-12-joro@8bytes.org>
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

When a bus is initialized with iommu-ops, all devices on the bus are
scanned and iommu-groups are allocated for them, and each groups will
also get a default domain allocated.

Until now this happened as soon as the group was created and the first
device added to it. When other devices with different default domain
requirements were added to the group later on, the default domain was
re-allocated, if possible.

This resulted in some back and forth and unnecessary allocations, so
change the flow to defer default domain allocation until all devices
have been added to their respective IOMMU groups.

The default domains are allocated for newly allocated groups after
each device on the bus is handled and was probed by the IOMMU driver.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 154 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8be047a4808f..7de0e29db333 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -199,7 +199,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	dev->iommu->iommu_dev = iommu_dev;
 
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group)) {
+	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_release;
 	}
@@ -1599,6 +1599,37 @@ static int add_iommu_group(struct device *dev, void *data)
 	return ret;
 }
 
+static int probe_iommu_group(struct device *dev, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct list_head *group_list = data;
+	int ret;
+
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	if (!try_module_get(ops->owner)) {
+		ret = -EINVAL;
+		goto err_free_dev_iommu;
+	}
+
+	ret = __iommu_probe_device(dev, group_list);
+	if (ret)
+		goto err_module_put;
+
+	return 0;
+
+err_module_put:
+	module_put(ops->owner);
+err_free_dev_iommu:
+	dev_iommu_free(dev);
+
+	if (ret == -ENODEV)
+		ret = 0;
+
+	return ret;
+}
+
 static int remove_iommu_group(struct device *dev, void *data)
 {
 	iommu_release_device(dev);
@@ -1658,10 +1689,127 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+struct __group_domain_type {
+	struct device *dev;
+	unsigned int type;
+};
+
+static int probe_get_default_domain_type(struct device *dev, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct __group_domain_type *gtype = data;
+	unsigned int type = 0;
+
+	if (ops->def_domain_type)
+		type = ops->def_domain_type(dev);
+
+	if (type) {
+		if (gtype->type && gtype->type != type) {
+			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
+				 iommu_domain_type_str(type),
+				 dev_name(gtype->dev),
+				 iommu_domain_type_str(gtype->type));
+			gtype->type = 0;
+		}
+
+		if (!gtype->dev) {
+			gtype->dev  = dev;
+			gtype->type = type;
+		}
+	}
+
+	return 0;
+}
+
+static void probe_alloc_default_domain(struct bus_type *bus,
+				       struct iommu_group *group)
+{
+	struct __group_domain_type gtype;
+
+	memset(&gtype, 0, sizeof(gtype));
+
+	/* Ask for default domain requirements of all devices in the group */
+	__iommu_group_for_each_dev(group, &gtype,
+				   probe_get_default_domain_type);
+
+	if (!gtype.type)
+		gtype.type = iommu_def_domain_type;
+
+	iommu_group_alloc_default_domain(bus, group, gtype.type);
+}
+
+static int iommu_group_do_dma_attach(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops;
+	int ret;
+
+	ret = __iommu_attach_device(domain, dev);
+
+	ops = domain->ops;
+
+	if (ret == 0 && ops->probe_finalize)
+		ops->probe_finalize(dev);
+
+	return ret;
+}
+
+static int __iommu_group_dma_attach(struct iommu_group *group)
+{
+	return __iommu_group_for_each_dev(group, group->default_domain,
+					  iommu_group_do_dma_attach);
+}
+
+static int bus_iommu_probe(struct bus_type *bus)
+{
+	const struct iommu_ops *ops = bus->iommu_ops;
+	int ret;
+
+	if (ops->probe_device) {
+		struct iommu_group *group, *next;
+		LIST_HEAD(group_list);
+
+		/*
+		 * This code-path does not allocate the default domain when
+		 * creating the iommu group, so do it after the groups are
+		 * created.
+		 */
+		ret = bus_for_each_dev(bus, NULL, &group_list, probe_iommu_group);
+		if (ret)
+			return ret;
+
+		list_for_each_entry_safe(group, next, &group_list, entry) {
+			/* Remove item from the list */
+			list_del_init(&group->entry);
+
+			mutex_lock(&group->mutex);
+
+			/* Try to allocate default domain */
+			probe_alloc_default_domain(bus, group);
+
+			if (!group->default_domain) {
+				mutex_unlock(&group->mutex);
+				continue;
+			}
+
+			ret = __iommu_group_dma_attach(group);
+
+			mutex_unlock(&group->mutex);
+
+			if (ret)
+				break;
+		}
+	} else {
+		ret = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
+	}
+
+	return ret;
+}
+
 static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
-	int err;
 	struct notifier_block *nb;
+	int err;
 
 	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
 	if (!nb)
@@ -1673,7 +1821,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_free;
 
-	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
+	err = bus_iommu_probe(bus);
 	if (err)
 		goto out_err;
 
-- 
2.17.1
