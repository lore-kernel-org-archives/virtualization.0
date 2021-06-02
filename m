Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5969EC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 15:55:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AA661490
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 15:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AA661490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE9B283D30;
	Wed,  2 Jun 2021 15:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RcS8YJmWd2O; Wed,  2 Jun 2021 15:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1FC283D29;
	Wed,  2 Jun 2021 15:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF502C002E;
	Wed,  2 Jun 2021 15:55:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B930C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6621983CFE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2NK6m1oN4frw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C1D683D03
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:55:14 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id h24so4621041ejy.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o4eUQK2AFEVDf4pa1XuHff+3rIiA7+oIVY3xnoGa6wY=;
 b=bExAtgh8euYkUKN+qFMYT8WIbypPHTQY181GV1KXdKuEkhgYCTsTU8ZhMmQFbqINUs
 YBYH72ddFNokmmjPFRin7FXc5BcfxLA5iLn1r848O/879blXjvkXW+dODgO2LK2A5ieS
 CkCubDq8GRmUUksQdbBfRlrF9+MaD7Bi2HirCMNYVQVvcA/degevWtntRaCRdxUT7s/L
 uVh1he4RZ0lOH5FftG3r2TcRSkq/x8ur0ttG9qKLw9HP8vAPoZ1gbOzEAf+UG97MVKeC
 5qBXNJq4y/FzgbnxOsYBn0rFrs19nBwxV1wc7jijMS+OmNfyePVZwr9pR2lpAKcay6Im
 Xb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o4eUQK2AFEVDf4pa1XuHff+3rIiA7+oIVY3xnoGa6wY=;
 b=JyQCumqLgbly4ug9U4d8zzH0yEIoFGGWrHG571NzdC9Dz3ib3sLC+t9YzO8Q49txck
 2/XbmBkhODyRc7L2YZNRqFnxA5tM7y6D9pNlO6FpZFUppIeY/uXxJsLrGvOeM8QB320J
 iKrm/ig19CFhkQyCUiJioWTB8C3ywwczwYPldmF0FuDmldeUVIHZTaamCw5cTsN3gWQd
 DVTU8revX/kXX5uiWrIzp3ovNCYeG4HHWp0rW4Tb3TzjpMP4lkSiLMyJPic9DpptUi8g
 Lqe9UpiWtrt8c4NXPBjPTwJy4TndG3r21DEj6SB5qXQn66k1UftbVjTZ2aBlQVv4bkpo
 5JQw==
X-Gm-Message-State: AOAM5311q50kU3aOKeaueTstBBHql0eR+voCqJZBhzhQ8pN2bfusk7lg
 CncKjFcBl60MbttkYQWZ5933sA==
X-Google-Smtp-Source: ABdhPJx8H/Wug8busq8mblZuxKyvThUPC+Gm9BLdmmMckkP7okW8+Gtuckc+NdAKI0hRzGk0uxsvNA==
X-Received: by 2002:a17:906:63d2:: with SMTP id
 u18mr34676925ejk.186.1622649312754; 
 Wed, 02 Jun 2021 08:55:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 08:55:12 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v3 6/6] iommu/virtio: Enable x86 support
Date: Wed,  2 Jun 2021 17:44:46 +0200
Message-Id: <20210602154444.1077006-7-jean-philippe@linaro.org>
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

With the VIOT support in place, x86 platforms can now use the
virtio-iommu.

Because the other x86 IOMMU drivers aren't yet ready to use the
acpi_dma_setup() path, x86 doesn't implement arch_setup_dma_ops() at the
moment. Similarly to Vt-d and AMD IOMMU, call iommu_setup_dma_ops() from
probe_finalize().

Acked-by: Joerg Roedel <jroedel@suse.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig        | 3 ++-
 drivers/iommu/dma-iommu.c    | 1 +
 drivers/iommu/virtio-iommu.c | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

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
index 175f8eaeb5b3..46ed43c400cf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1332,6 +1332,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 		 dev_name(dev));
 }
+EXPORT_SYMBOL_GPL(iommu_setup_dma_ops);
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 218fe8560e8d..77aee1207ced 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1026,6 +1026,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+static void viommu_probe_finalize(struct device *dev)
+{
+#ifndef CONFIG_ARCH_HAS_SETUP_DMA_OPS
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
+#endif
+}
+
 static void viommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -1062,6 +1069,7 @@ static struct iommu_ops viommu_ops = {
 	.iova_to_phys		= viommu_iova_to_phys,
 	.iotlb_sync		= viommu_iotlb_sync,
 	.probe_device		= viommu_probe_device,
+	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
