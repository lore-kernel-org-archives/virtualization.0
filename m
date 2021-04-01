Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33996C433ED
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:59:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED5C61394
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED5C61394
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9BDE60BE6;
	Thu,  1 Apr 2021 16:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AyHkujkUHQrn; Thu,  1 Apr 2021 16:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A75260603;
	Thu,  1 Apr 2021 16:59:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A58AC0014;
	Thu,  1 Apr 2021 16:59:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 380B0C000A;
 Thu,  1 Apr 2021 16:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEBA041884;
 Thu,  1 Apr 2021 16:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n67OYKZvZz2F; Thu,  1 Apr 2021 16:59:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A73D34187C;
 Thu,  1 Apr 2021 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=8o97dp155P8hIZws3Wqj7iFhRfZWTujRmO4zOFp4hPY=; b=sbeo5j7kg3nPD6IXZPP02HCuXv
 Fn0XGzQY9Xs8deWb5kiWPPZEPu3kf4/88/O8rU+//nAvht8ZHRp7k0OEHl5f5AkxSQBtAB1M2uVxN
 WJc5k73bvy2GVPOqO/3erApIaqj85gWgPTmy3737ygxMkYRY3rQYtT6wl5bDjs+cBUry2kQBWqzDa
 1llNchW0ontfI71fUBzt0pN93Wkc8Ovqek9yb13g7IjSSZKuDsAb6i++YAEa7f4ux1g3vjK2tPm8h
 R07NZMOgF09HJ7hVc+esTWRwSrMZ38joUQvQy93g6nM2O31QVdtA2u4gaoabbeJIVZDQoq+883z0R
 yTGf247g==;
Received: from [2001:4bb8:180:7517:83e4:a809:b0aa:ca74] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzdS-00CibP-Sf; Thu, 01 Apr 2021 15:53:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 08/20] iommu/fsl_pamu: merge pamu_set_liodn and map_liodn
Date: Thu,  1 Apr 2021 17:52:44 +0200
Message-Id: <20210401155256.298656-9-hch@lst.de>
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

Merge the two fuctions that configure the ppaace into a single coherent
function.  I somehow doubt we need the two pamu_config_ppaace calls,
but keep the existing behavior just to be on the safe side.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/fsl_pamu_domain.c | 65 +++++++++------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 557a152c1d2c49..198725ef27954f 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -54,25 +54,6 @@ static int __init iommu_init_mempool(void)
 	return 0;
 }
 
-/* Map the DMA window corresponding to the LIODN */
-static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
-{
-	int ret;
-	struct iommu_domain_geometry *geom = &dma_domain->iommu_domain.geometry;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iommu_lock, flags);
-	ret = pamu_config_ppaace(liodn, geom->aperture_start,
-				 geom->aperture_end + 1, ~(u32)0,
-				 0, dma_domain->snoop_id, dma_domain->stash_id,
-				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);
-	spin_unlock_irqrestore(&iommu_lock, flags);
-	if (ret)
-		pr_debug("PAACE configuration failed for liodn %d\n", liodn);
-
-	return ret;
-}
-
 static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 			      u32 val)
 {
@@ -94,11 +75,11 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 }
 
 /* Set the geometry parameters for a LIODN */
-static int pamu_set_liodn(int liodn, struct device *dev,
-			  struct fsl_dma_domain *dma_domain,
-			  struct iommu_domain_geometry *geom_attr)
+static int pamu_set_liodn(struct fsl_dma_domain *dma_domain, struct device *dev,
+			  int liodn)
 {
-	phys_addr_t window_addr, window_size;
+	struct iommu_domain *domain = &dma_domain->iommu_domain;
+	struct iommu_domain_geometry *geom = &domain->geometry;
 	u32 omi_index = ~(u32)0;
 	unsigned long flags;
 	int ret;
@@ -110,22 +91,25 @@ static int pamu_set_liodn(int liodn, struct device *dev,
 	 */
 	get_ome_index(&omi_index, dev);
 
-	window_addr = geom_attr->aperture_start;
-	window_size = geom_attr->aperture_end + 1;
-
 	spin_lock_irqsave(&iommu_lock, flags);
 	ret = pamu_disable_liodn(liodn);
-	if (!ret)
-		ret = pamu_config_ppaace(liodn, window_addr, window_size, omi_index,
-					 0, dma_domain->snoop_id,
-					 dma_domain->stash_id, 0);
+	if (ret)
+		goto out_unlock;
+	ret = pamu_config_ppaace(liodn, geom->aperture_start,
+				 geom->aperture_end + 1, omi_index, 0,
+				 dma_domain->snoop_id, dma_domain->stash_id, 0);
+	if (ret)
+		goto out_unlock;
+	ret = pamu_config_ppaace(liodn, geom->aperture_start,
+				 geom->aperture_end + 1, ~(u32)0,
+				 0, dma_domain->snoop_id, dma_domain->stash_id,
+				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);
+out_unlock:
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	if (ret) {
 		pr_debug("PAACE configuration failed for liodn %d\n",
 			 liodn);
-		return ret;
 	}
-
 	return ret;
 }
 
@@ -265,7 +249,6 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 				int num)
 {
 	unsigned long flags;
-	struct iommu_domain *domain = &dma_domain->iommu_domain;
 	int ret = 0;
 	int i;
 
@@ -280,21 +263,7 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 		}
 
 		attach_device(dma_domain, liodn[i], dev);
-		/*
-		 * Check if geometry has already been configured
-		 * for the domain. If yes, set the geometry for
-		 * the LIODN.
-		 */
-		ret = pamu_set_liodn(liodn[i], dev, dma_domain,
-				     &domain->geometry);
-		if (ret)
-			break;
-
-		/*
-		 * Create window/subwindow mapping for
-		 * the LIODN.
-		 */
-		ret = map_liodn(liodn[i], dma_domain);
+		ret = pamu_set_liodn(dma_domain, dev, liodn[i]);
 		if (ret)
 			break;
 	}
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
