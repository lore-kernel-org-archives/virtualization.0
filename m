Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE3C433E6
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312AE64F5D
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312AE64F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AA174ECBE;
	Tue, 16 Mar 2021 16:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KBVjeAq9Gpg2; Tue, 16 Mar 2021 16:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8161B4ECC7;
	Tue, 16 Mar 2021 16:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2925EC0012;
	Tue, 16 Mar 2021 16:00:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A088C000A;
 Tue, 16 Mar 2021 16:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F91D4ECBD;
 Tue, 16 Mar 2021 16:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X41Boh13x_2v; Tue, 16 Mar 2021 16:00:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B4214EBF4;
 Tue, 16 Mar 2021 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=uAkAL9bKpEi2EHehW2pGjvC7Z2PgJIxUdOpjcgZC0vk=; b=Qt22ze7Ge8lRN1C/kGC82F1d6H
 MJExup8bOyJQbhJDnVi2n/POMgBEQJBqGxeQUfNS7uZY0W0qw8WeFwUmbF5QwFTot1AgE9JTwPHOJ
 cBdq0yVzkPLNFL+kM6co7kJ70DIwfkL6snqTVa5+A1B79uxD9b26FLheYDcM03iOsXg1UmQoIRr++
 0+WdeMQw5SMM1Oinu7tKy4rKkKdpW7l/RtTpD3LQkXe6YqbQe2pibrMwmCdhGFFrFCzNIO/j1gn11
 2mg0fIH7YfDY19y+biZHqZgbHl+uLPnbrNnqgU5kYwS63iJ93vPMjJ8Pl3e9/IcuoBdMfnRTCcWEA
 tMnVcidQ==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMC6q-000Gy8-1D; Tue, 16 Mar 2021 15:59:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 08/18] iommu/fsl_pamu: merge pamu_set_liodn and map_liodn
Date: Tue, 16 Mar 2021 16:38:14 +0100
Message-Id: <20210316153825.135976-9-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210316153825.135976-1-hch@lst.de>
References: <20210316153825.135976-1-hch@lst.de>
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

Merge the two fuctions that configure the ppaace into a single coherent
function.  I somehow doubt we need the two pamu_config_ppaace calls,
but keep the existing behavior just to be on the safe side.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/fsl_pamu_domain.c | 65 +++++++++------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 40eff4b7bc5d42..4a4944332674f7 100644
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
-				 geom->aperture_end - 1, ~(u32)0,
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
+				 geom->aperture_end - 1, omi_index, 0,
+				 dma_domain->snoop_id, dma_domain->stash_id, 0);
+	if (ret)
+		goto out_unlock;
+	ret = pamu_config_ppaace(liodn, geom->aperture_start,
+				 geom->aperture_end - 1, ~(u32)0,
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
