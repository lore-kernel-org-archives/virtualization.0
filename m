Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E39AC43460
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143356138D
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143356138D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5FA941883;
	Thu,  1 Apr 2021 16:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tfeNo83QGajN; Thu,  1 Apr 2021 16:56:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 256CC41879;
	Thu,  1 Apr 2021 16:56:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC84AC0014;
	Thu,  1 Apr 2021 16:56:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57B31C000A;
 Thu,  1 Apr 2021 16:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 385CA60BE8;
 Thu,  1 Apr 2021 16:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-SYc8bUfr0o; Thu,  1 Apr 2021 16:56:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7CE560BE4;
 Thu,  1 Apr 2021 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=g/lYlQLJmKIelbYGsJOMK8K3baqJu4KrHdTwHylUH98=; b=yk7zp4/a/VVy/qjNyBy+25HhKE
 M3MLuAAEGCHkhoP6K+6R5Jrd2o9QTpPa/n+D+jPbw8PfF0Hj+LlRVl4uxYQG9l3BZZ+4dc5I8r9e2
 IjqvjarJiebl1F9i4ul0iOVUIzj1oDsJXbYJ2qkBZ0gl0i5I6XA+OeaYxW2MRRFfMRRV32/ae8F5J
 dDH6vXR/maOTz6DfB53SyQcBbg8iRcUEK8qYomkv4uD4P3cJvtU6CBHm5BwRr30BFkiHIqeNzDoDA
 LbAzmQekckWvz0YH4pL5dkKd9Izu6Dwi1ld24zxZdieLRhcx6J9vWJ1Ig/OL/cF1UeinsSVUXpGco
 +Rs+TVvQ==;
Received: from [2001:4bb8:180:7517:83e4:a809:b0aa:ca74] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzdr-00Ciee-IE; Thu, 01 Apr 2021 15:53:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 17/20] iommu: remove iommu_set_cmd_line_dma_api and
 iommu_cmd_line_dma_api
Date: Thu,  1 Apr 2021 17:52:53 +0200
Message-Id: <20210401155256.298656-18-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210401155256.298656-1-hch@lst.de>
References: <20210401155256.298656-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org, Lu Baolu <baolu.lu@linux.intel.com>
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

Don't obsfucate the trivial bit flag check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/iommu.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 58d1d11a8d5c10..052cef11ae30df 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -70,16 +70,6 @@ static const char * const iommu_group_resv_type_string[] = {
 
 #define IOMMU_CMD_LINE_DMA_API		BIT(0)
 
-static void iommu_set_cmd_line_dma_api(void)
-{
-	iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
-}
-
-static bool iommu_cmd_line_dma_api(void)
-{
-	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
-}
-
 static int iommu_alloc_default_domain(struct iommu_group *group,
 				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
@@ -130,9 +120,7 @@ static const char *iommu_domain_type_str(unsigned int t)
 
 static int __init iommu_subsys_init(void)
 {
-	bool cmd_line = iommu_cmd_line_dma_api();
-
-	if (!cmd_line) {
+	if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
 		if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
 			iommu_set_default_passthrough(false);
 		else
@@ -146,7 +134,8 @@ static int __init iommu_subsys_init(void)
 
 	pr_info("Default domain type: %s %s\n",
 		iommu_domain_type_str(iommu_def_domain_type),
-		cmd_line ? "(set via kernel command line)" : "");
+		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
+			"(set via kernel command line)" : "");
 
 	return 0;
 }
@@ -2757,16 +2746,14 @@ EXPORT_SYMBOL_GPL(iommu_alloc_resv_region);
 void iommu_set_default_passthrough(bool cmd_line)
 {
 	if (cmd_line)
-		iommu_set_cmd_line_dma_api();
-
+		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
 	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 }
 
 void iommu_set_default_translated(bool cmd_line)
 {
 	if (cmd_line)
-		iommu_set_cmd_line_dma_api();
-
+		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
 	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 }
 
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
