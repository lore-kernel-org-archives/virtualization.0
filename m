Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A81C48BD1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:03:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0D1613CA
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0D1613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C574E83C8B;
	Thu, 10 Jun 2021 08:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rijr7LcplcV1; Thu, 10 Jun 2021 08:03:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E92AE83CC8;
	Thu, 10 Jun 2021 08:02:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C184C0011;
	Thu, 10 Jun 2021 08:02:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE72CC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CEB840539
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PxMdY8xjliaW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CAE040386
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:53 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 v206-20020a1cded70000b02901a586d3fa23so5804559wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T0y2iCeYYHmrE1fv4Hgj0FTcnFeMz1q5JiDftJFl4po=;
 b=piloNKZ3ohr7pJlYL+8Vi7WuxS6ZzeMjvv2uKYon90XrjsxqgLFIbwbfB4kJsdA0v7
 0ozBa16idjurywVrDqinefJkY/MNbqYRRsY+mXLdox7/NHHMSpXwsHUTtUdD6mqF5MeE
 1j0v2DZOWc6tt+q5oa9zHrZx7DL4vKbfMqbvK7ZI4Sc5wHTFmZsz37xjxNu7N7O6u2DM
 V2PGp+w/RUs9vhhztPS7IEFj5dwI8ACn3a9ZurIh+axORWmDDJPjXHpN+itozM2lY/we
 gh+d/rlXU14QiQJZvmQLqOVhYAKcDR7N+3oELLHtsKCQczCwG0bP+72HbuGcXv3q3fRO
 5hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T0y2iCeYYHmrE1fv4Hgj0FTcnFeMz1q5JiDftJFl4po=;
 b=j4zEvVvkOWDKlY2fMu5r+8VEcrDmjwhIkDuBRhEx47CSSgjFpntqYdNZKyx0fhz2/K
 FpXl7YydGZIqpTwa2SSsKKwcodWjlU42aIeWWF8wOZwkrd+qHF0rAs2KacAUnRDXQzCU
 /9tFQ9aYlwqT/WRXYclNk5PbvfXn++evV83aNWBJjKk2xj4G+oLZKo8VPvNz6mcienFj
 1MMb7uPY9yzUP1UIdaHHjYVY+e/7bDWx6jbDB50eW7GCfquLs5j4R+SO2ViRzqkZlRxm
 I2gZNbGyhm/p67aoT04MnjE+EtqCo70zBmOLSsjTZXak9wW+/ZK1dbhDtVXp+JbspHfp
 bfcg==
X-Gm-Message-State: AOAM533QdcobzBiwlZPGevbDvYn9KB/rDYObcnU75D5SBBs7FeX1LmQ7
 fcECYpYKObnDab/5BgkDgDhZoQ==
X-Google-Smtp-Source: ABdhPJyhgs0pAJM3GOPSSYmXX4Hm6qTgRSjCiSLLmiqaGmb5GA99bgCBCuS6FCgIdzuYCrwUncTV2A==
X-Received: by 2002:a1c:a54b:: with SMTP id o72mr3678130wme.124.1623312171684; 
 Thu, 10 Jun 2021 01:02:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id o3sm2715059wrm.78.2021.06.10.01.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 01:02:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v4 4/6] iommu/dma: Pass address limit rather than size to
 iommu_setup_dma_ops()
Date: Thu, 10 Jun 2021 09:51:31 +0200
Message-Id: <20210610075130.67517-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210610075130.67517-1-jean-philippe@linaro.org>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
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

Passing a 64-bit address width to iommu_setup_dma_ops() is valid on
virtual platforms, but isn't currently possible. The overflow check in
iommu_dma_init_domain() prevents this even when @dma_base isn't 0. Pass
a limit address instead of a size, so callers don't have to fake a size
to work around the check.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/dma-iommu.h   |  4 ++--
 arch/arm64/mm/dma-mapping.c |  2 +-
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 12 ++++++------
 drivers/iommu/intel/iommu.c |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 6e75a2d689b4..758ca4694257 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -19,7 +19,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
+void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 /*
@@ -50,7 +50,7 @@ struct msi_msg;
 struct device;
 
 static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
-		u64 size)
+				       u64 dma_limit)
 {
 }
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4bf1dd3eb041..7bd1d2199141 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -50,7 +50,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	dev->dma_coherent = coherent;
 	if (iommu)
-		iommu_setup_dma_ops(dev, dma_base, size);
+		iommu_setup_dma_ops(dev, dma_base, size - dma_base - 1);
 
 #ifdef CONFIG_XEN
 	if (xen_swiotlb_detect())
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3ac42bbdefc6..94b96d81fcfd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1713,7 +1713,7 @@ static void amd_iommu_probe_finalize(struct device *dev)
 	/* Domains are initialized for this device - have a look what we ended up with */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
+		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
 	else
 		set_dma_ops(dev, NULL);
 }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..c62e19bed302 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -319,16 +319,16 @@ static bool dev_is_untrusted(struct device *dev)
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
  * @base: IOVA at which the mappable address space starts
- * @size: Size of IOVA space
+ * @limit: Last address of the IOVA space
  * @dev: Device the domain is being initialised for
  *
- * @base and @size should be exact multiples of IOMMU page granularity to
+ * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
  * avoid rounding surprises. If necessary, we reserve the page at address 0
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
  */
 static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
-		u64 size, struct device *dev)
+				 dma_addr_t limit, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
@@ -346,7 +346,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
 		if (base > domain->geometry.aperture_end ||
-		    base + size <= domain->geometry.aperture_start) {
+		    limit < domain->geometry.aperture_start) {
 			pr_warn("specified DMA range outside IOMMU capability\n");
 			return -EFAULT;
 		}
@@ -1308,7 +1308,7 @@ static const struct dma_map_ops iommu_dma_ops = {
  * The IOMMU core code allocates the default DMA domain, which the underlying
  * IOMMU driver needs to support via the dma-iommu layer.
  */
-void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
+void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
@@ -1320,7 +1320,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size)
 	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
 	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (iommu_dma_init_domain(domain, dma_base, size, dev))
+		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..85f18342603c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5171,7 +5171,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 
 	if (domain && domain->type == IOMMU_DOMAIN_DMA)
 		iommu_setup_dma_ops(dev, base,
-				    __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
+				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
 	else
 		set_dma_ops(dev, NULL);
 }
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
