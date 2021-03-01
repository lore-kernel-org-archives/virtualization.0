Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EF2C433E6
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 08:48:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5F564DF1
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 08:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5F564DF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B511E4F27B;
	Mon,  1 Mar 2021 08:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fDF5z5ES1qhB; Mon,  1 Mar 2021 08:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EC6F4F27D;
	Mon,  1 Mar 2021 08:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAA30C0010;
	Mon,  1 Mar 2021 08:48:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8825BC0001;
 Mon,  1 Mar 2021 08:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69D8943021;
 Mon,  1 Mar 2021 08:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F_Nu2wiABuJW; Mon,  1 Mar 2021 08:48:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD54542D1E;
 Mon,  1 Mar 2021 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=usr7xT8HjEnq451z093KqRmLnxf+lOohzyPFd88RWYc=; b=qoX9vVxVZZKAyq7B5O0VZvcYtQ
 M1LLUOhp5PXNHx3LLs7t+kTFESYbZVnXg///4sLFsnDJ6YAc7sx0E7LxldOc05oZ4jRo0RlJu47tJ
 O5UwI4r8nvaAw6Z0ID0gcNv1Nq9526ZQx+GtA3BWS27srD8y+6L1slKHkvqYKmT2m0IJrfUORQB8m
 RV0AJLuqivIXh9zJINYtKgWsg8dzdoAzdIHhD2m4shGEwS3g3Oaate2Tpj+ohHthG9x/A1gd8m3t2
 VLK/BghVxmkGpZq6vvyOuutmdPOZZoaKtqLvAr6nn+FS8uyv936L4FUlVEI87OVFnB7SIfWkxVUDC
 HgObuMmw==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeCV-00FUoN-LS; Mon, 01 Mar 2021 08:46:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 11/17] iommu/fsl_pamu: remove the snoop_id field
Date: Mon,  1 Mar 2021 09:42:51 +0100
Message-Id: <20210301084257.945454-12-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301084257.945454-1-hch@lst.de>
References: <20210301084257.945454-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

The snoop_id is always set to ~(u32)0.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/fsl_pamu_domain.c | 5 ++---
 drivers/iommu/fsl_pamu_domain.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 21c6d9e79eddf9..701fc3f187a100 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -97,12 +97,12 @@ static int pamu_set_liodn(struct fsl_dma_domain *dma_domain, struct device *dev,
 		goto out_unlock;
 	ret = pamu_config_ppaace(liodn, geom->aperture_start,
 				 geom->aperture_end - 1, omi_index, 0,
-				 dma_domain->snoop_id, dma_domain->stash_id, 0);
+				 ~(u32)0, dma_domain->stash_id, 0);
 	if (ret)
 		goto out_unlock;
 	ret = pamu_config_ppaace(liodn, geom->aperture_start,
 				 geom->aperture_end - 1, ~(u32)0,
-				 0, dma_domain->snoop_id, dma_domain->stash_id,
+				 0, ~(u32)0, dma_domain->stash_id,
 				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);
 out_unlock:
 	spin_unlock_irqrestore(&iommu_lock, flags);
@@ -210,7 +210,6 @@ static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
 		return NULL;
 
 	dma_domain->stash_id = ~(u32)0;
-	dma_domain->snoop_id = ~(u32)0;
 	INIT_LIST_HEAD(&dma_domain->devices);
 	spin_lock_init(&dma_domain->domain_lock);
 
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index 5f4ed253f61b31..95ac1b3cab3b69 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -13,7 +13,6 @@ struct fsl_dma_domain {
 	/* list of devices associated with the domain */
 	struct list_head		devices;
 	u32				stash_id;
-	u32				snoop_id;
 	struct iommu_domain		iommu_domain;
 	spinlock_t			domain_lock;
 };
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
