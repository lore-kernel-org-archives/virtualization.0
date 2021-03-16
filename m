Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A81C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 15:43:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9434E64F7B
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 15:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9434E64F7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 699EE6F633;
	Tue, 16 Mar 2021 15:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SCPASC0bCEBT; Tue, 16 Mar 2021 15:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13F81600BA;
	Tue, 16 Mar 2021 15:43:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 894C7C0012;
	Tue, 16 Mar 2021 15:43:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02691C000A;
 Tue, 16 Mar 2021 15:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3CB84ECBC;
 Tue, 16 Mar 2021 15:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QRyGRR6_g2er; Tue, 16 Mar 2021 15:43:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F29FA4ECB2;
 Tue, 16 Mar 2021 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=iw+fifO7jrg/z05+P9SvlFTQmtqEOKLWF4/W63fZSxg=; b=t8rWyJbHNRA+UdMLiAjEgLyDck
 M+oVJgU7mMVSpeTyf1YPJI2RGqBN3Sn9PFh94Tt6X8WVm0claWr2KRveHeGUslpukjM6021i8VVBe
 ssNC9EADHuhaXovE2EAOdZ4HeCHi3cv5pZI4mIecJDA/63eHhSIoS9Z1+v7buOcgx4JwQLb8XLsyx
 xRZ3DxAOxonTDtzuxqSHKRwT0oOjxGyH/gr3wj9utxLuYw9mok8rdNoakTiZj7k/VNJiBlfkYDt+a
 qHIiUMUrvM9EkvpjGvbvgckkoVGdIgUJSCpXRj+w1toY53CSWJG7Tpu5DPfUwLKKgwCdjYatVnt4k
 eXidtaZQ==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMBqQ-000Fk5-G4; Tue, 16 Mar 2021 15:42:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 01/18] iommu: remove the unused domain_window_disable method
Date: Tue, 16 Mar 2021 16:38:07 +0100
Message-Id: <20210316153825.135976-2-hch@lst.de>
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

domain_window_disable is wired up by fsl_pamu, but never actually called.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/fsl_pamu_domain.c | 48 ---------------------------------
 include/linux/iommu.h           |  2 --
 2 files changed, 50 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index b2110767caf49c..53380cf1fa452f 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -473,53 +473,6 @@ static int update_domain_mapping(struct fsl_dma_domain *dma_domain, u32 wnd_nr)
 	return ret;
 }
 
-static int disable_domain_win(struct fsl_dma_domain *dma_domain, u32 wnd_nr)
-{
-	struct device_domain_info *info;
-	int ret = 0;
-
-	list_for_each_entry(info, &dma_domain->devices, link) {
-		if (dma_domain->win_cnt == 1 && dma_domain->enabled) {
-			ret = pamu_disable_liodn(info->liodn);
-			if (!ret)
-				dma_domain->enabled = 0;
-		} else {
-			ret = pamu_disable_spaace(info->liodn, wnd_nr);
-		}
-	}
-
-	return ret;
-}
-
-static void fsl_pamu_window_disable(struct iommu_domain *domain, u32 wnd_nr)
-{
-	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&dma_domain->domain_lock, flags);
-	if (!dma_domain->win_arr) {
-		pr_debug("Number of windows not configured\n");
-		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return;
-	}
-
-	if (wnd_nr >= dma_domain->win_cnt) {
-		pr_debug("Invalid window index\n");
-		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-		return;
-	}
-
-	if (dma_domain->win_arr[wnd_nr].valid) {
-		ret = disable_domain_win(dma_domain, wnd_nr);
-		if (!ret) {
-			dma_domain->win_arr[wnd_nr].valid = 0;
-			dma_domain->mapped--;
-		}
-	}
-
-	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-}
 
 static int fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				  phys_addr_t paddr, u64 size, int prot)
@@ -1032,7 +985,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.attach_dev	= fsl_pamu_attach_device,
 	.detach_dev	= fsl_pamu_detach_device,
 	.domain_window_enable = fsl_pamu_window_enable,
-	.domain_window_disable = fsl_pamu_window_disable,
 	.iova_to_phys	= fsl_pamu_iova_to_phys,
 	.domain_set_attr = fsl_pamu_set_domain_attr,
 	.domain_get_attr = fsl_pamu_get_domain_attr,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430af4..47c8b318d8f523 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -209,7 +209,6 @@ struct iommu_iotlb_gather {
  * @put_resv_regions: Free list of reserved regions for a device
  * @apply_resv_region: Temporary helper call-back for iova reserved ranges
  * @domain_window_enable: Configure and enable a particular window for a domain
- * @domain_window_disable: Disable a particular window for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
@@ -270,7 +269,6 @@ struct iommu_ops {
 	/* Window handling functions */
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
 				    phys_addr_t paddr, u64 size, int prot);
-	void (*domain_window_disable)(struct iommu_domain *domain, u32 wnd_nr);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
