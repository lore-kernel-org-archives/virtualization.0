Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC279C43603
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A9461461
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 11:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A9461461
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E455E4183B;
	Fri, 23 Apr 2021 11:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XT-TMUoJTzQ1; Fri, 23 Apr 2021 11:57:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5036840F99;
	Fri, 23 Apr 2021 11:57:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71776C0026;
	Fri, 23 Apr 2021 11:57:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1724BC001C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6864660DE6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0QwREw2Mxshd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74AF660DAE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 11:57:00 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id j5so47152832wrn.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PPlf6PmudxEBhFFbCtfVg/0ThZVLyT3V5UlJSyz19uQ=;
 b=nRkBopEbDZfyoJj93wf3o22q/jswYgaQWnGlI6oAwmedhv/HGZN7g3FARSljblxKD5
 acjYCanfz5LdD8LEdDSIEHgIlB+f3gnCX35E78fjNUkoXlkSkJoAG+mUiJIeSX1hsyWd
 TgUSR6lrK82ZUQP53r6gGX0ZuRertEVlH4Sx1ROIBbK5ANGDVafwOuWFkaNDut9csDD7
 JSm7sySdFNLmhkzXYfVrer2Y+HT5K4AIjsqUojilCvM2hENpooUfV+o6rjIjG2yuDWPe
 q8wpXSscJjF+jwYonvShzo57XIzap+xqcFXhwpk+LrgZLsyQQUemvwa8GLCvj7lV44zS
 6yKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PPlf6PmudxEBhFFbCtfVg/0ThZVLyT3V5UlJSyz19uQ=;
 b=PE2wpOfwWIVyKzcw+5VVvGOD8jaZPkN7qZevQVoR+R+3VVN0zBzX9eSrEkYjz38Srz
 j+pTXCSC3ZC9DICHf1wl1e60ybVL/Hgzh4GmVC2NZe0KzC83cg5qZmBa31ZSCwCH7DuV
 m25N97KGgutG4+Y2xAUrIpkXMFZLVe2LlHQjyJDUn41bgm9BrgPAROrnsiUQl81d1XMI
 L3o49c1TD9VTLk6KdrXshUSOVUD0nLwQndatcDEkxkifQxJ8vhuq4doQ6nrmlD3sUXAV
 vu/lOuUsYznpWUJFEt48b50+oSDKvVShz7OT2OdBOWUTBKRuu9ND9nN4lRp3LgLSoerU
 WyJw==
X-Gm-Message-State: AOAM532HFPu9pk8A1i8zLhkjrr3X6dLUmp/vBVFmsSE6DwRk/53cmpdj
 WGI9Wx6nx8i2fQnAfdy9rs7XIA==
X-Google-Smtp-Source: ABdhPJy/J1DbcuIx65t0na0UfxgQvJFfmdbA8jSi+JVISUbWizw5uKkB9RPqHS3oQcM5gZ8NbRw5Pg==
X-Received: by 2002:a05:6000:1209:: with SMTP id
 e9mr4332783wrx.192.1619179018723; 
 Fri, 23 Apr 2021 04:56:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 04:56:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v2 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
Date: Fri, 23 Apr 2021 13:38:36 +0200
Message-Id: <20210423113836.3974972-6-jean-philippe@linaro.org>
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

dma-iommu uses the address bounds described in domain->geometry during
IOVA allocation. The address size parameters of iommu_setup_dma_ops()
are useful for describing additional limits set by the platform
firmware, but aren't needed for drivers that call this function from
probe_finalize(). The base parameter can be zero because dma-iommu
already removes the first IOVA page, and the limit parameter can be
U64_MAX because it's only checked against the domain geometry. Simplify
calls to iommu_setup_dma_ops().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/amd/iommu.c   |  9 +--------
 drivers/iommu/dma-iommu.c   |  4 +++-
 drivers/iommu/intel/iommu.c | 10 +---------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 50041df43391..bbb09840cf40 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1708,14 +1708,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain;
-
-	/* Domains are initialized for this device - have a look what we ended up with */
-	domain = iommu_get_domain_for_dev(dev);
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, U64_MAX);
-	else
-		set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void amd_iommu_release_device(struct device *dev)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c62e19bed302..175f8eaeb5b3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	if (domain->type == IOMMU_DOMAIN_DMA) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
-		dev->dma_ops = &iommu_dma_ops;
+		set_dma_ops(dev, &iommu_dma_ops);
+	} else {
+		set_dma_ops(dev, NULL);
 	}
 
 	return;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 39a4e672b1c2..c6fe11d3624e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5160,15 +5160,7 @@ static void intel_iommu_release_device(struct device *dev)
 
 static void intel_iommu_probe_finalize(struct device *dev)
 {
-	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-
-	if (domain && domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, base,
-				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
-	else
-		set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
