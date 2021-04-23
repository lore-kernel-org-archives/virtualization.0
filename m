Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC72C433ED
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C976141C
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C976141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 201934051A;
	Fri, 23 Apr 2021 11:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFd3d5reywQN; Fri, 23 Apr 2021 11:57:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EC3D41836;
	Fri, 23 Apr 2021 11:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83B56C0025;
	Fri, 23 Apr 2021 11:57:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20586C001A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A15A260DD7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0sHr2hoV5kx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E32360DAE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id w4so44399727wrt.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UQIMwLFTls4/WJjymQFgC41Tqut/moVpCvSGVMf3p14=;
 b=Se4ZGfMvg0biJnx9os+LbCidHgcUoRYMUQXaJ9i8nJ8CAL99l38h8GPg0NHq49WW6Y
 mw1HDf5F6KlG0LIlhxpFz1Dbr6v7NyQtWGEUGnus7O1uj9JPoj+FvchqF9voIr3Lw7+2
 M5dc/EKCPMli8MltA6zuQTi89PJ9sKFptK+3b5ZJjI7nOKf8bLoctqz1zx/o4CnCIsrz
 JVrPibAH9yZspQx1yQAZZh7zv5PsJ/AMqDE0G3P0W0WF+vxlnmr3nPjMz3ikPlpBZRAf
 93+Y7IU3tAdRYBSUiBhAwU3/KwrrQ/nBjUi+aREYk3hY3aK8OVBk4gpyUtNN/QrgrUzU
 79hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UQIMwLFTls4/WJjymQFgC41Tqut/moVpCvSGVMf3p14=;
 b=MD+HzvxFCRbalVOhkNFuUdM7mMyoRfK57k6sMYkoCyYhejMlyOp954oFWpY51a+3a4
 pWcc6X7Mi3TMu9jxc9JdCgiKTbTLzWuS8s3Z4sxJ1yjuZmRnT8gMVJuAgN+b9TeIxSVc
 Svy2IgskmnIacw+PI+MJ7wgh3VD9uhXmV06p7iJFw/OFPrV3DniaA1rSt4SVZjd6l0Xl
 v1Dx2dXwzC4PJ4MTRpdwVctFb5slN+CvFeyJecmEx1Oq31SN2K5o6bQbgFxhQfeeRVDm
 P2ktjKf1SqlmBLptdEsEnbtBGn4N9hB2ghoTm9b891i8bEV46AYTEgMIO08C9tkDGlBS
 K7YQ==
X-Gm-Message-State: AOAM530bsqV5SzGgy0NeH//Zu7y+40Xa5KhtG5AFW4JDNksjhVvJqYr5
 5D3PLBtHea1KSdxPMTJ/zCO9CA==
X-Google-Smtp-Source: ABdhPJysuuOvIFTUKOIqqVw+v/bc4x5l41zhX5bZVOgfrTtfrN8ysU7xvrJmyKi3hnVPMITPgWptTQ==
X-Received: by 2002:adf:a1db:: with SMTP id v27mr4292159wrv.181.1619179019689; 
 Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 04:56:59 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v2 6/6] iommu/virtio: Enable x86 support
Date: Fri, 23 Apr 2021 13:38:37 +0200
Message-Id: <20210423113836.3974972-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
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
index 29a397c2d12f..8be546a338e7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1027,6 +1027,13 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
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
@@ -1063,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
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
