Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03620C49EA2
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 15:30:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28E761351
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 15:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28E761351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EE1C8397F;
	Fri, 18 Jun 2021 15:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A_Uj8NzSCv2J; Fri, 18 Jun 2021 15:30:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 48A9483CC8;
	Fri, 18 Jun 2021 15:30:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE93AC0023;
	Fri, 18 Jun 2021 15:30:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26725C000F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16B2583CD8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rg7W7aQDUkf2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4709483CC8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:27 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id og14so16523220ejc.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rpRcMlANuJMVLr/XwX8HEu/R5blh278L1JFLoof2k1A=;
 b=jO4a4H8Yhggcga4GQdZHUtondp+5Jx+D9WWbrevj+4RY3niqEa7Gjxo9T0BM+3mFzj
 q7Kjb+dga1Uy0PA0AIU3gPoqzIGyr3Zyhhr+ELhL6dj55qnE/8J00aGATXw7obrxrjHc
 fDxsl5c0eNS6ExRmSIPOIogUma7fv7B+Zlb9CXFU+YbLEtXgmxZUosqgnUPtM2gTMoFb
 3EHZu4+eKUmgSdc/Gnm9yDnbIJSrWyiNtION2WYfgl59CR3LvTGF12+CATOUdvom3/XV
 cGh+zU5eQWCjbhXehiI74kJeaclkuwe5nSulA+QKKQuKMvcBkYkApJH7trVKqt7Txo5D
 j3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rpRcMlANuJMVLr/XwX8HEu/R5blh278L1JFLoof2k1A=;
 b=RstcBRNBsW6uI78kV/q61S8+PEep7wsqffUw77x69on72cB7NDzSEncK2ZcqFAy6eg
 mseu4WFWP8NoZRz81Aaz3hRkxXcKPZQtwQ3KLncPhULSkkzMibSwmNrKnmxuTXip4WWk
 CFH04h6T+w+/t6rCFVyvZZ4EKYsacjk+vxrAwFxZSNyjKD84TTiDXdGR//BgFr+BKn2o
 G6+FDJMN33thFfPc474sHq90mZq9u3a0qHuHrBAZQiypafxMYXKx9qcuO0lgcJ5aYBIJ
 +ifPJ7ORxLSGkndc9mlsL7Sp5eagIHAKYESXiq9v2Np08FtaUyXqEvdOBvBrHLzo/R1+
 LosA==
X-Gm-Message-State: AOAM530Vsyj9MSSkvWerolBTMFeT7/uIOcfceMiaHBITbyymFb5KzCjK
 +Sygk8o49ZukfFNv8LSoRKEiUA==
X-Google-Smtp-Source: ABdhPJwv2gkUGSnBNaByT41YPue7mNT8OUrgVjtrwBeLgH2oLQ6rAXxgrzJb3pLtycur69cTKQfF+A==
X-Received: by 2002:a17:906:b0c6:: with SMTP id
 bk6mr11670554ejb.97.1624030225430; 
 Fri, 18 Jun 2021 08:30:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id bn7sm1197613ejb.111.2021.06.18.08.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 08:30:25 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v5 5/5] iommu/virtio: Enable x86 support
Date: Fri, 18 Jun 2021 17:21:00 +0200
Message-Id: <20210618152059.1194210-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618152059.1194210-1-jean-philippe@linaro.org>
References: <20210618152059.1194210-1-jean-philippe@linaro.org>
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

With the VIOT support in place, x86 platforms can now use the
virtio-iommu.

Because the other x86 IOMMU drivers aren't yet ready to use the
acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
moment. Similarly to Vt-d and AMD IOMMU, clear the DMA ops and call
iommu_setup_dma_ops() from probe_finalize().

Acked-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig        |  3 ++-
 drivers/iommu/dma-iommu.c    |  1 +
 drivers/iommu/virtio-iommu.c | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index aff8a4830dd1..07b7c25cbed8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -400,8 +400,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA
 	select INTERVAL_TREE
 	select ACPI_VIOT if ACPI
 	help
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c62e19bed302..9dbbc95c8189 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1330,6 +1330,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 		 dev_name(dev));
 }
+EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index c6e5ee4d9cef..fe581f0c9b3a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -10,6 +10,7 @@
 #include <linux/amba/bus.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/dma-map-ops.h>
 #include <linux/freezer.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
@@ -904,6 +905,15 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+static void viommu_probe_finalize(struct device *dev)
+{
+#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	/* First clear the DMA ops in case we're switching from a DMA domain */
+	set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
+#endif
+}
+
 static void viommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -940,6 +950,7 @@ static struct iommu_ops viommu_ops = {
 	.iova_to_phys		= viommu_iova_to_phys,
 	.iotlb_sync		= viommu_iotlb_sync,
 	.probe_device		= viommu_probe_device,
+	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
