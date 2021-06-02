Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90478C47093
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 15:55:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BBB86139A
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 15:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBB86139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FC6683CFE;
	Wed,  2 Jun 2021 15:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qPxyA1ywf_nE; Wed,  2 Jun 2021 15:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DD9583D20;
	Wed,  2 Jun 2021 15:55:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17F21C0025;
	Wed,  2 Jun 2021 15:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4B69C0024
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 90225607FF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rUVyiORIUNJv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68306605A1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:10 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id jt22so4593193ejb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rcZqp7kiQKPtioIYYmePxJZ8jRjqdm9ovqpRz8DAQNM=;
 b=GGijrFXc+HpSE9WoeOpBAm3mX9yf2YsAm4HFWzomjBMECg8vMuWrBnJJuRwkgjGdOz
 rmerVt4RbeC+7JFC6zNSMASgwdGIgq/FdKsDNaNzekPpg7V2o/iDiWEVS4u0Kbh2mz1o
 TjFNsrCBiz0dezcDqyzlOQ1roB0s4vk35pO1BuFCvrC4bsNRVUHlJRPBOCvnfvlqJUTc
 FRqFUdZBXUSueL8CNsyLB9eD9AP64x6+irapuCeyhxmMmDnTtrpNRFpIoKFwH8vbzRu4
 llijmwWT0wmotHWX5Z8aP+AbRPYIXeuKCk/l8/gTBE/xpGyQ6/6pdx6TiIzUxIYcKpB/
 Jn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rcZqp7kiQKPtioIYYmePxJZ8jRjqdm9ovqpRz8DAQNM=;
 b=QtLl00IcYYyjw6jXUJ0DnBCSLosslLxbbpHMk+bCGxybMbR/I+m2Hk4804uDvY38kd
 jBoNWVP+9QRhz4NJ+0fJyX1hIVJaTAO0EgDna9m7M27n1gZNmHoBWvausLTHycwRX5NO
 Kcq0aPuc8HUsptAsemJD9rfqEh7/qCEK+R1AqZEz/KHq0pB80dFdUI/Av3xfUdMXcU12
 47Gklk6GxE2fHoixAn2lCdhBOlL4a/LzBdkjZU2BlH+VkY5Bp6GucHGmidz8yW0rr6RH
 4bWykcQl9FTNfXozT09HrVo95eXR2g9XRZ69hmIRs0aP0BtBvhF4aDZOXA99xjgWcZro
 jZLw==
X-Gm-Message-State: AOAM530S6LMDYwaUHxk+ObW9QoIHatMXADq8UbZ8S6EEqzKXlLrbwzXS
 mRV9iLF65kPWOGc90d2xH14rpQ==
X-Google-Smtp-Source: ABdhPJy9yrHMoYAwjXHc3cT1Wq2Q/FnFuA9YZgVp+llXF3Hw5P/BD8qlnDLkBD9n8fAe6XzHgk0LkQ==
X-Received: by 2002:a17:906:4e95:: with SMTP id
 v21mr20387922eju.434.1622649308415; 
 Wed, 02 Jun 2021 08:55:08 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 08:55:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Date: Wed,  2 Jun 2021 17:44:42 +0200
Message-Id: <20210602154444.1077006-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602154444.1077006-1-jean-philippe@linaro.org>
References: <20210602154444.1077006-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, lorenzo.pieralisi@arm.com, eric.auger@redhat.com,
 catalin.marinas@arm.com, sudeep.holla@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com
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

Extract the code that sets up the IOMMU infrastructure from IORT, since
it can be reused by VIOT. Move it one level up into a new
acpi_iommu_configure_id() function, which calls the IORT parsing
function which in turn calls the acpi_iommu_fwspec_init() helper.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/acpi_bus.h   |  3 ++
 include/linux/acpi_iort.h |  8 ++---
 drivers/acpi/arm64/iort.c | 75 +++++----------------------------------
 drivers/acpi/scan.c       | 55 +++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a82faac5767..41f092a269f6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -588,6 +588,9 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+int acpi_iommu_fwspec_init(struct device *dev, u32 id,
+			   struct fwnode_handle *fwnode,
+			   const struct iommu_ops *ops);
 int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 		       u64 *size);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index f7f054833afd..f1f0842a2cb2 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -35,8 +35,7 @@ void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
-const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-						const u32 *id_in);
+int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
@@ -50,9 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-static inline const struct iommu_ops *iort_iommu_configure_id(
-				      struct device *dev, const u32 *id_in)
-{ return NULL; }
+static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
+{ return -ENODEV; }
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a940be1cf2af..b5b021e064b6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -806,23 +806,6 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
-}
-
-static inline int iort_add_device_replay(struct device *dev)
-{
-	int err = 0;
-
-	if (dev->bus && !device_iommu_mapped(dev))
-		err = iommu_probe_device(dev);
-
-	return err;
-}
-
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -900,18 +883,6 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 	}
 }
 
-static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
-			       struct fwnode_handle *fwnode,
-			       const struct iommu_ops *ops)
-{
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
-
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
-
-	return ret;
-}
-
 static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 {
 	struct acpi_iort_root_complex *pci_rc;
@@ -946,7 +917,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 		return iort_iommu_driver_enabled(node->type) ?
 		       -EPROBE_DEFER : -ENODEV;
 
-	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
 }
 
 struct iort_pci_alias_info {
@@ -1020,24 +991,14 @@ static int iort_nc_iommu_map_id(struct device *dev,
  * @dev: device to configure
  * @id_in: optional input id const value pointer
  *
- * Returns: iommu_ops pointer on configuration success
- *          NULL on configuration failure
+ * Returns: 0 on success, <0 on failure
  */
-const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-						const u32 *id_in)
+int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	struct acpi_iort_node *node;
-	const struct iommu_ops *ops;
+	const struct iommu_ops *ops = NULL;
 	int err = -ENODEV;
 
-	/*
-	 * If we already translated the fwspec there
-	 * is nothing left to do, return the iommu_ops.
-	 */
-	ops = iort_fwspec_iommu_ops(dev);
-	if (ops)
-		return ops;
-
 	if (dev_is_pci(dev)) {
 		struct iommu_fwspec *fwspec;
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
@@ -1046,7 +1007,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
 				      iort_match_node_callback, &bus->dev);
 		if (!node)
-			return NULL;
+			return -ENODEV;
 
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
@@ -1059,7 +1020,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 				      iort_match_node_callback, dev);
 		if (!node)
-			return NULL;
+			return -ENODEV;
 
 		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
 			      iort_nc_iommu_map(dev, node);
@@ -1068,32 +1029,14 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 			iort_named_component_init(dev, node);
 	}
 
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
-	 */
-	if (!err) {
-		ops = iort_fwspec_iommu_ops(dev);
-		err = iort_add_device_replay(dev);
-	}
-
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		ops = ERR_PTR(err);
-	} else if (err) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		ops = NULL;
-	}
-
-	return ops;
+	return err;
 }
 
 #else
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
-const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-						const u32 *input_id)
-{ return NULL; }
+int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
+{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ea613df8f913..696b81432ae7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/iommu.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/dmi.h>
@@ -1520,6 +1521,58 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 	return ret >= 0 ? 0 : ret;
 }
 
+int acpi_iommu_fwspec_init(struct device *dev, u32 id,
+			   struct fwnode_handle *fwnode,
+			   const struct iommu_ops *ops)
+{
+	int ret = iommu_fwspec_init(dev, fwnode, ops);
+
+	if (!ret)
+		ret = iommu_fwspec_add_ids(dev, &id, 1);
+
+	return ret;
+}
+
+static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	return fwspec ? fwspec->ops : NULL;
+}
+
+static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
+						       const u32 *id_in)
+{
+	int err;
+	const struct iommu_ops *ops;
+
+	/*
+	 * If we already translated the fwspec there is nothing left to do,
+	 * return the iommu_ops.
+	 */
+	ops = acpi_iommu_fwspec_ops(dev);
+	if (ops)
+		return ops;
+
+	err = iort_iommu_configure_id(dev, id_in);
+
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (!err && dev->bus && !device_iommu_mapped(dev))
+		err = iommu_probe_device(dev);
+
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (err == -EPROBE_DEFER) {
+		return ERR_PTR(err);
+	} else if (err) {
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+		return NULL;
+	}
+	return acpi_iommu_fwspec_ops(dev);
+}
+
 /**
  * acpi_dma_configure_id - Set-up DMA configuration for the device.
  * @dev: The pointer to the device
@@ -1539,7 +1592,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 
 	acpi_arch_dma_setup(dev, &dma_addr, &size);
 
-	iommu = iort_iommu_configure_id(dev, input_id);
+	iommu = acpi_iommu_configure_id(dev, input_id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
