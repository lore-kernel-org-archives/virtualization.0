Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F0C433ED
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0801661394
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0801661394
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEEC94188A;
	Thu,  1 Apr 2021 16:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQt22ROzMNs2; Thu,  1 Apr 2021 16:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1008A4187E;
	Thu,  1 Apr 2021 16:56:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC1CCC000C;
	Thu,  1 Apr 2021 16:56:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33A05C000A;
 Thu,  1 Apr 2021 16:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEFB04188A;
 Thu,  1 Apr 2021 16:56:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfYW-oWihVhD; Thu,  1 Apr 2021 16:56:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE9704186C;
 Thu,  1 Apr 2021 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=6DcxZsiPepfGUgEn3X4Pytv10TvLFSsigpRcj4GEp8w=; b=uRAAEOxv+dvr1q453virD2Gtg2
 RxsviVpQmrYjUOesDnzmffH1s4f5/g/ydd6GmWzsNFgEAhk4MwZz160FCUG54cbCwoO7u9CKV2e6H
 oA/2q/iPNV0v3FgBw4/fS+dY5iILltmFPA24gZPu1D2JMj/qR3IqQRU6Y3/mqHpy3MK6b3FqwnQMT
 ZIKQX7drOizNIcl/RvwRzhCvsTPnqRZzU1azHpSJ2cwTryCvxHonansIz6pnu26oZ3I9+tYVkzdGQ
 Ub7tBWI6c7Tf08rokSakQpzuRx3oyNbi65wV30f87Ope5E1zKUA3FQEE9GQ5dk0QmbFmXxQyTxWUb
 Q2It65xg==;
Received: from [2001:4bb8:180:7517:83e4:a809:b0aa:ca74] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzdg-00Cict-3h; Thu, 01 Apr 2021 15:53:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 13/20] iommu/fsl_pamu: hardcode the window address and size in
 pamu_config_ppaace
Date: Thu,  1 Apr 2021 17:52:49 +0200
Message-Id: <20210401155256.298656-14-hch@lst.de>
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

The win_addr and win_size parameters are always set to 0 and 1 << 36
respectively, so just hard code them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/fsl_pamu.c        | 23 ++++-------------------
 drivers/iommu/fsl_pamu.h        |  3 +--
 drivers/iommu/fsl_pamu_domain.c | 10 ++--------
 3 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 742fa0e8c45b88..fc38b1fba7cff0 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -178,8 +178,6 @@ int pamu_update_paace_stash(int liodn, u32 value)
  * pamu_config_paace() - Sets up PPAACE entry for specified liodn
  *
  * @liodn: Logical IO device number
- * @win_addr: starting address of DSA window
- * @win-size: size of DSA window
  * @omi: Operation mapping index -- if ~omi == 0 then omi not defined
  * @stashid: cache stash id for associated cpu -- if ~stashid == 0 then
  *	     stashid not defined
@@ -187,35 +185,22 @@ int pamu_update_paace_stash(int liodn, u32 value)
  *
  * Returns 0 upon success else error code < 0 returned
  */
-int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
-		       u32 omi, u32 stashid, int prot)
+int pamu_config_ppaace(int liodn, u32 omi, u32 stashid, int prot)
 {
 	struct paace *ppaace;
 
-	if ((win_size & (win_size - 1)) || win_size < PAMU_PAGE_SIZE) {
-		pr_debug("window size too small or not a power of two %pa\n",
-			 &win_size);
-		return -EINVAL;
-	}
-
-	if (win_addr & (win_size - 1)) {
-		pr_debug("window address is not aligned with window size\n");
-		return -EINVAL;
-	}
-
 	ppaace = pamu_get_ppaace(liodn);
 	if (!ppaace)
 		return -ENOENT;
 
 	/* window size is 2^(WSE+1) bytes */
 	set_bf(ppaace->addr_bitfields, PPAACE_AF_WSE,
-	       map_addrspace_size_to_wse(win_size));
+	       map_addrspace_size_to_wse(1ULL << 36));
 
 	pamu_init_ppaace(ppaace);
 
-	ppaace->wbah = win_addr >> (PAMU_PAGE_SHIFT + 20);
-	set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL,
-	       (win_addr >> PAMU_PAGE_SHIFT));
+	ppaace->wbah = 0;
+	set_bf(ppaace->addr_bitfields, PPAACE_AF_WBAL, 0);
 
 	/* set up operation mapping if it's configured */
 	if (omi < OME_NUMBER_ENTRIES) {
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index c96b29f0c7077f..36df7975ff64d3 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -383,8 +383,7 @@ struct ome {
 int pamu_domain_init(void);
 int pamu_enable_liodn(int liodn);
 int pamu_disable_liodn(int liodn);
-int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
-		       u32 omi, uint32_t stashid, int prot);
+int pamu_config_ppaace(int liodn, u32 omi, uint32_t stashid, int prot);
 
 u32 get_stash_id(u32 stash_dest_hint, u32 vcpu);
 void get_ome_index(u32 *omi_index, struct device *dev);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index c83f1e7c2cb0c9..32944d67baa495 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -78,8 +78,6 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 static int pamu_set_liodn(struct fsl_dma_domain *dma_domain, struct device *dev,
 			  int liodn)
 {
-	struct iommu_domain *domain = &dma_domain->iommu_domain;
-	struct iommu_domain_geometry *geom = &domain->geometry;
 	u32 omi_index = ~(u32)0;
 	unsigned long flags;
 	int ret;
@@ -95,14 +93,10 @@ static int pamu_set_liodn(struct fsl_dma_domain *dma_domain, struct device *dev,
 	ret = pamu_disable_liodn(liodn);
 	if (ret)
 		goto out_unlock;
-	ret = pamu_config_ppaace(liodn, geom->aperture_start,
-				 geom->aperture_end + 1, omi_index,
-				 dma_domain->stash_id, 0);
+	ret = pamu_config_ppaace(liodn, omi_index, dma_domain->stash_id, 0);
 	if (ret)
 		goto out_unlock;
-	ret = pamu_config_ppaace(liodn, geom->aperture_start,
-				 geom->aperture_end + 1, ~(u32)0,
-				 dma_domain->stash_id,
+	ret = pamu_config_ppaace(liodn, ~(u32)0, dma_domain->stash_id,
 				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);
 out_unlock:
 	spin_unlock_irqrestore(&iommu_lock, flags);
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
