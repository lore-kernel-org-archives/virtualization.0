Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F23C433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A77A207DE
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJXaHRti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A77A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3689F883A1;
	Fri, 21 Aug 2020 13:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnluct6FM4fo; Fri, 21 Aug 2020 13:16:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E29F87E6D;
	Fri, 21 Aug 2020 13:16:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19ECDC0889;
	Fri, 21 Aug 2020 13:16:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B634FC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A443522EE6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ji+BrxD+oU7Z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 5CAEC2047E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:11 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id di22so1365353edb.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qIWN2A9Pg6dkinmsu+W9xC580ElUmiDl+mJTFgDdlfk=;
 b=lJXaHRtihKmQ0Z2fAhiSdOZT5NzKnzoSxLejvf96zLb4lOwQTV2Mth4JS8ym05KJfj
 hbZuRDp8ARmG/8/q30QH/hSDRmtTGGlcAihsxtc72ByHW7yYNak+CEcwcMEL71gQ2sJm
 DHN6LUUhbybZNvBQeMbghUQKNhDFO/9WxcYazlqTb7ApD0jzGbGI0b4yvUJpXE+fF6bN
 69U2Fw1Qrm94pB44JFwSqFPgMODwH43iIYsIO0i0faBkkZ1i+TxwuoQIuXkHN0VuU7E3
 IH0FlmWpLAOeeRpFjqrbDLBLyAssqLX6ZOTkwS72nMckwOMlG81tV46gVG/P6PC40tNf
 alrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qIWN2A9Pg6dkinmsu+W9xC580ElUmiDl+mJTFgDdlfk=;
 b=iJkCoTltW1Fmlz1i8UCGrENN3bjkV8J1PsJxCvIf3hxH6Gmebkj0ze4vedaw3ymNBv
 FXqLwbMDQq5+rOmWgiNqIasmMeG2EB+5UzigX21n6eWjUyr2RxH50NolxUOHH5wqZWLb
 QWwEGDFSgpYzTXFxnXlTl2ief93/OoMvYeXuelLfv/AP1WXPYv0uGB8xg5lCkblNCbr4
 ovxue64iXOajb447ekk8DbrUTdc1kMvwT72T6C4dL3EHvZsevHR6+9JayeAl6FYigjmU
 tJUez//Si7qml18XRQ5T/vkJ91f5HQcPf4o+1JBxdZB5mp+FchzyWyOvtrzbjlueropx
 TQuA==
X-Gm-Message-State: AOAM530nqOQfub1VIh0JC/WU8fiMp0QfG6yD7GC4oEE+MPEalWpxFudx
 D1mUdNd40qHAUpYMjjYSxY3P2Q==
X-Google-Smtp-Source: ABdhPJzxq1c9JigDVrS42THmZTWZeFAgfMyVfSNwCK+EUYesa8zCQaunBd0jytbwhye3B13DjvZOhA==
X-Received: by 2002:a05:6402:1d92:: with SMTP id
 dk18mr2705911edb.206.1598015769483; 
 Fri, 21 Aug 2020 06:16:09 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:08 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 2/6] iommu/virtio: Add topology helpers
Date: Fri, 21 Aug 2020 15:15:36 +0200
Message-Id: <20200821131540.2801801-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lorenzo.pieralisi@arm.com,
 mst@redhat.com, joro@8bytes.org, eric.auger@redhat.com,
 sebastien.boeuf@intel.com, bhelgaas@google.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

To support topology description from ACPI and from the builtin
description, add helpers to keep track of I/O topology descriptors.

To ease re-use of the helpers by other drivers and future ACPI
extensions, use the "virt_" prefix rather than "virtio_" when naming
structs and functions.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig                   |   3 +
 drivers/iommu/virtio/Makefile           |   1 +
 drivers/iommu/virtio/topology-helpers.h |  50 ++++++
 include/linux/virt_iommu.h              |  15 ++
 drivers/iommu/virtio/topology-helpers.c | 196 ++++++++++++++++++++++++
 drivers/iommu/virtio/virtio-iommu.c     |   4 +
 MAINTAINERS                             |   1 +
 7 files changed, 270 insertions(+)
 create mode 100644 drivers/iommu/virtio/topology-helpers.h
 create mode 100644 include/linux/virt_iommu.h
 create mode 100644 drivers/iommu/virtio/topology-helpers.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bef5d75e306b..e29ae50f7100 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -391,4 +391,7 @@ config VIRTIO_IOMMU
 
 	  Say Y here if you intend to run this kernel as a guest.
 
+config VIRTIO_IOMMU_TOPOLOGY_HELPERS
+	bool
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/virtio/Makefile b/drivers/iommu/virtio/Makefile
index 279368fcc074..b42ad47eac7e 100644
--- a/drivers/iommu/virtio/Makefile
+++ b/drivers/iommu/virtio/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS) += topology-helpers.o
diff --git a/drivers/iommu/virtio/topology-helpers.h b/drivers/iommu/virtio/topology-helpers.h
new file mode 100644
index 000000000000..436ca6a900c5
--- /dev/null
+++ b/drivers/iommu/virtio/topology-helpers.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef TOPOLOGY_HELPERS_H_
+#define TOPOLOGY_HELPERS_H_
+
+#ifdef CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS
+
+/* Identify a device node in the topology */
+struct virt_topo_dev_id {
+	unsigned int			type;
+#define VIRT_TOPO_DEV_TYPE_PCI		1
+#define VIRT_TOPO_DEV_TYPE_MMIO		2
+	union {
+		/* PCI endpoint or range */
+		struct {
+			u16		segment;
+			u16		bdf_start;
+			u16		bdf_end;
+		};
+		/* MMIO region */
+		u64			base;
+	};
+};
+
+/* Specification of an IOMMU */
+struct virt_topo_iommu {
+	struct virt_topo_dev_id		dev_id;
+	struct device			*dev; /* transport device */
+	struct fwnode_handle		*fwnode;
+	struct iommu_ops		*ops;
+	struct list_head		list;
+};
+
+/* Specification of an endpoint */
+struct virt_topo_endpoint {
+	struct virt_topo_dev_id		dev_id;
+	u32				endpoint_id;
+	struct virt_topo_iommu		*viommu;
+	struct list_head		list;
+};
+
+void virt_topo_add_endpoint(struct virt_topo_endpoint *ep);
+void virt_topo_add_iommu(struct virt_topo_iommu *viommu);
+
+void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops);
+
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+static inline void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{ }
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+#endif /* TOPOLOGY_HELPERS_H_ */
diff --git a/include/linux/virt_iommu.h b/include/linux/virt_iommu.h
new file mode 100644
index 000000000000..17d2bd4732e0
--- /dev/null
+++ b/include/linux/virt_iommu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef VIRT_IOMMU_H_
+#define VIRT_IOMMU_H_
+
+#ifdef CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS
+int virt_dma_configure(struct device *dev);
+
+#else /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+static inline int virt_dma_configure(struct device *dev)
+{
+	/* Don't disturb the normal DMA configuration methods */
+	return 0;
+}
+#endif /* !CONFIG_VIRTIO_IOMMU_TOPOLOGY_HELPERS */
+#endif /* VIRT_IOMMU_H_ */
diff --git a/drivers/iommu/virtio/topology-helpers.c b/drivers/iommu/virtio/topology-helpers.c
new file mode 100644
index 000000000000..8815e3a5d431
--- /dev/null
+++ b/drivers/iommu/virtio/topology-helpers.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/dma-iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/virt_iommu.h>
+
+#include "topology-helpers.h"
+
+static LIST_HEAD(viommus);
+static LIST_HEAD(pci_endpoints);
+static LIST_HEAD(mmio_endpoints);
+static DEFINE_MUTEX(viommus_lock);
+
+static bool virt_topo_device_match(struct device *dev,
+				   struct virt_topo_dev_id *id)
+{
+	if (id->type == VIRT_TOPO_DEV_TYPE_PCI && dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		u16 dev_id = pci_dev_id(pdev);
+
+		return pci_domain_nr(pdev->bus) == id->segment &&
+			dev_id >= id->bdf_start &&
+			dev_id <= id->bdf_end;
+	} else if (id->type == VIRT_TOPO_DEV_TYPE_MMIO &&
+		   dev_is_platform(dev)) {
+		struct platform_device *plat_dev = to_platform_device(dev);
+		struct resource *mem;
+
+		mem = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
+		if (!mem)
+			return false;
+		return mem->start == id->base;
+	}
+	return false;
+}
+
+static const struct iommu_ops *virt_iommu_setup(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct virt_topo_iommu *viommu = NULL;
+	struct virt_topo_endpoint *ep;
+	struct pci_dev *pci_dev = NULL;
+	u32 epid;
+	int ret;
+
+	/* Already translated? */
+	if (fwspec && fwspec->ops)
+		return NULL;
+
+	mutex_lock(&viommus_lock);
+	if (dev_is_pci(dev)) {
+		pci_dev = to_pci_dev(dev);
+		list_for_each_entry(ep, &pci_endpoints, list) {
+			if (virt_topo_device_match(dev, &ep->dev_id)) {
+				epid = pci_dev_id(pci_dev) -
+					ep->dev_id.bdf_start +
+					ep->endpoint_id;
+				viommu = ep->viommu;
+				break;
+			}
+		}
+	} else if (dev_is_platform(dev)) {
+		list_for_each_entry(ep, &mmio_endpoints, list) {
+			if (virt_topo_device_match(dev, &ep->dev_id)) {
+				epid = ep->endpoint_id;
+				viommu = ep->viommu;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&viommus_lock);
+	if (!viommu)
+		return NULL;
+
+	/* We're not translating ourselves. */
+	if (virt_topo_device_match(dev, &viommu->dev_id) ||
+	    dev == viommu->dev)
+		return NULL;
+
+	/*
+	 * If we found a PCI range managed by the viommu, we're the one that has
+	 * to request ACS.
+	 */
+	if (pci_dev)
+		pci_request_acs();
+
+	if (!viommu->ops)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	ret = iommu_fwspec_init(dev, viommu->fwnode, viommu->ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	iommu_fwspec_add_ids(dev, &epid, 1);
+
+	return viommu->ops;
+}
+
+/**
+ * virt_topo_add_endpoint - Register endpoint specification
+ * @ep: the endpoint specification
+ */
+void virt_topo_add_endpoint(struct virt_topo_endpoint *ep)
+{
+	mutex_lock(&viommus_lock);
+	list_add(&ep->list,
+		 ep->dev_id.type == VIRT_TOPO_DEV_TYPE_MMIO ?
+		 &mmio_endpoints : &pci_endpoints);
+	mutex_unlock(&viommus_lock);
+}
+
+/**
+ * virt_topo_add_iommu - Register IOMMU specification
+ * @viommu: the IOMMU specification
+ */
+void virt_topo_add_iommu(struct virt_topo_iommu *viommu)
+{
+	mutex_lock(&viommus_lock);
+	list_add(&viommu->list, &viommus);
+	mutex_unlock(&viommus_lock);
+}
+
+/**
+ * virt_dma_configure - Configure DMA of virtualized devices
+ * @dev: the endpoint
+ *
+ * Setup the DMA and IOMMU ops of a virtual device, for platforms without DT or
+ * ACPI.
+ *
+ * Return: -EPROBE_DEFER if the device is managed by an IOMMU that hasn't been
+ *   probed yet, 0 otherwise
+ */
+int virt_dma_configure(struct device *dev)
+{
+	const struct iommu_ops *iommu_ops;
+
+	iommu_ops = virt_iommu_setup(dev);
+	if (IS_ERR_OR_NULL(iommu_ops)) {
+		int ret = PTR_ERR(iommu_ops);
+
+		if (ret == -EPROBE_DEFER || ret == 0)
+			return ret;
+		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
+		return 0;
+	}
+
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (dev->bus && !device_iommu_mapped(dev))
+		iommu_probe_device(dev);
+
+	/* Assume coherent, as well as full 64-bit addresses. */
+#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, true);
+#else
+	iommu_setup_dma_ops(dev, 0, ~0ULL);
+#endif
+	return 0;
+}
+
+/**
+ * virt_topo_set_iommu_ops - Set the IOMMU ops of a virtual IOMMU device
+ * @dev: the IOMMU device (transport)
+ * @ops: the new IOMMU ops or NULL
+ *
+ * Setup the iommu_ops associated to an IOMMU, once the driver is loaded
+ * and the device probed.
+ */
+void virt_topo_set_iommu_ops(struct device *dev, struct iommu_ops *ops)
+{
+	struct virt_topo_iommu *viommu;
+
+	mutex_lock(&viommus_lock);
+	list_for_each_entry(viommu, &viommus, list) {
+		/*
+		 * In case the topology driver didn't have a dev handle when
+		 * registering the topology, add it now.
+		 */
+		if (!viommu->dev &&
+		    virt_topo_device_match(dev, &viommu->dev_id))
+			viommu->dev = dev;
+
+		if (viommu->dev == dev) {
+			viommu->ops = ops;
+			viommu->fwnode = ops ? dev->fwnode : NULL;
+			break;
+		}
+	}
+	mutex_unlock(&viommus_lock);
+}
+EXPORT_SYMBOL_GPL(virt_topo_set_iommu_ops);
diff --git a/drivers/iommu/virtio/virtio-iommu.c b/drivers/iommu/virtio/virtio-iommu.c
index b4da396cce60..b371d15f837f 100644
--- a/drivers/iommu/virtio/virtio-iommu.c
+++ b/drivers/iommu/virtio/virtio-iommu.c
@@ -25,6 +25,8 @@
 
 #include <uapi/linux/virtio_iommu.h>
 
+#include "topology-helpers.h"
+
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
@@ -1065,6 +1067,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_free_vqs;
 
+	virt_topo_set_iommu_ops(dev->parent, &viommu_ops);
 	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
 	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
 
@@ -1111,6 +1114,7 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
+	virt_topo_set_iommu_ops(vdev->dev.parent, NULL);
 	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 3602b223c9b2..8fd53c22a0ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18452,6 +18452,7 @@ M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
 L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/iommu/virtio/
+F:	include/linux/virt_iommu.h
 F:	include/uapi/linux/virtio_iommu.h
 
 VIRTIO MEM DRIVER
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
