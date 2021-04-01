Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79124C433B4
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C37B61390
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C37B61390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 069FC60BF8;
	Thu,  1 Apr 2021 16:56:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZprkyOiLXAN; Thu,  1 Apr 2021 16:56:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97D5660BE3;
	Thu,  1 Apr 2021 16:56:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48873C0014;
	Thu,  1 Apr 2021 16:56:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FA2FC000A;
 Thu,  1 Apr 2021 16:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD7FD60BEB;
 Thu,  1 Apr 2021 16:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iAn4gqNXDMeP; Thu,  1 Apr 2021 16:56:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01E4E60BE8;
 Thu,  1 Apr 2021 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Z9JPy9TPg1G6vRAErbmN4dHQgiCuv74xNNZwb3XvOzc=; b=z9dfmxVC+AkYI7A3FhvuGUicXf
 WsoEPdEBOr+mzC8jJKT9D43IWxD08C6UN9gP6Ng4MFLpHmmOK/CaiM+Kj8DAhByTQGNSZnoKEF9+y
 2Rs0dYWfh0Z8jr5K8/Eyyi2JziQCArZaQo30OIrvsewrAgQ0huTTx0kHtqju6eTI1uSgCbrZiUQc9
 4HDViC6rLsC62o8HMxHELgdcrVhxuR6TqKCMUlRCPGi4fNvZxAOMIpWTR1OEyU4LN6LNCAeyiOii1
 7FkldJGkzOokyuTL3g131A2VtwTYvp4sN7duB59mWrFNH3kHEwrIRmYWub3Vv4NX+o2+kciSwQZWr
 NJ/psRCg==;
Received: from [2001:4bb8:180:7517:83e4:a809:b0aa:ca74] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzdd-00Cicd-Dp; Thu, 01 Apr 2021 15:53:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 12/20] iommu/fsl_pamu: remove the rpn and snoop_id arguments
 to pamu_config_ppaac
Date: Thu,  1 Apr 2021 17:52:48 +0200
Message-Id: <20210401155256.298656-13-hch@lst.de>
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

These are always wired to fixed values, so don't bother passing them as
arguments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/fsl_pamu.c        | 14 +++-----------
 drivers/iommu/fsl_pamu.h        |  3 +--
 drivers/iommu/fsl_pamu_domain.c |  6 +++---
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 3e1647cd5ad47a..742fa0e8c45b88 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -181,18 +181,14 @@ int pamu_update_paace_stash(int liodn, u32 value)
  * @win_addr: starting address of DSA window
  * @win-size: size of DSA window
  * @omi: Operation mapping index -- if ~omi == 0 then omi not defined
- * @rpn: real (true physical) page number
  * @stashid: cache stash id for associated cpu -- if ~stashid == 0 then
  *	     stashid not defined
- * @snoopid: snoop id for hardware coherency -- if ~snoopid == 0 then
- *	     snoopid not defined
  * @prot: window permissions
  *
  * Returns 0 upon success else error code < 0 returned
  */
 int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
-		       u32 omi, unsigned long rpn, u32 snoopid, u32 stashid,
-		       int prot)
+		       u32 omi, u32 stashid, int prot)
 {
 	struct paace *ppaace;
 
@@ -234,13 +230,9 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 	if (~stashid != 0)
 		set_bf(ppaace->impl_attr, PAACE_IA_CID, stashid);
 
-	/* configure snoop id */
-	if (~snoopid != 0)
-		ppaace->domain_attr.to_host.snpid = snoopid;
-
 	set_bf(ppaace->impl_attr, PAACE_IA_ATM, PAACE_ATM_WINDOW_XLATE);
-	ppaace->twbah = rpn >> 20;
-	set_bf(ppaace->win_bitfields, PAACE_WIN_TWBAL, rpn);
+	ppaace->twbah = 0;
+	set_bf(ppaace->win_bitfields, PAACE_WIN_TWBAL, 0);
 	set_bf(ppaace->addr_bitfields, PAACE_AF_AP, prot);
 	set_bf(ppaace->impl_attr, PAACE_IA_WCE, 0);
 	set_bf(ppaace->addr_bitfields, PPAACE_AF_MW, 0);
diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index 04fd843d718dd1..c96b29f0c7077f 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -384,8 +384,7 @@ int pamu_domain_init(void);
 int pamu_enable_liodn(int liodn);
 int pamu_disable_liodn(int liodn);
 int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
-		       u32 omi, unsigned long rpn, u32 snoopid, uint32_t stashid,
-		       int prot);
+		       u32 omi, uint32_t stashid, int prot);
 
 u32 get_stash_id(u32 stash_dest_hint, u32 vcpu);
 void get_ome_index(u32 *omi_index, struct device *dev);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index e9c1e0dd68f084..c83f1e7c2cb0c9 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -96,13 +96,13 @@ static int pamu_set_liodn(struct fsl_dma_domain *dma_domain, struct device *dev,
 	if (ret)
 		goto out_unlock;
 	ret = pamu_config_ppaace(liodn, geom->aperture_start,
-				 geom->aperture_end + 1, omi_index, 0,
-				 ~(u32)0, dma_domain->stash_id, 0);
+				 geom->aperture_end + 1, omi_index,
+				 dma_domain->stash_id, 0);
 	if (ret)
 		goto out_unlock;
 	ret = pamu_config_ppaace(liodn, geom->aperture_start,
 				 geom->aperture_end + 1, ~(u32)0,
-				 0, ~(u32)0, dma_domain->stash_id,
+				 dma_domain->stash_id,
 				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);
 out_unlock:
 	spin_unlock_irqrestore(&iommu_lock, flags);
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
