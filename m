Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7533BC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 08:47:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1AC64DE0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 08:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1AC64DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D61C84F279;
	Mon,  1 Mar 2021 08:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aL78_M4O6szy; Mon,  1 Mar 2021 08:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36B204F276;
	Mon,  1 Mar 2021 08:47:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBF8C000A;
	Mon,  1 Mar 2021 08:47:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4672CC0001;
 Mon,  1 Mar 2021 08:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 269EB43021;
 Mon,  1 Mar 2021 08:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N81hCnDdoHtw; Mon,  1 Mar 2021 08:47:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62DD942D1E;
 Mon,  1 Mar 2021 08:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=NUEaUjqfH2GDGtCYsoSXPehku+Mq8OQF5mXn7mqOfQk=; b=n5tDKlDMbueJd/ePanMjpNlq96
 I8kXqjNmJ2ER0GNDVeP8sKit6aOhCTxFnGma7qjJx7d0oMSM7JKcQ9ufLrRAjr7P0tOZ+3do+cN7R
 dx0Cl4Yhd+oJBzpt6MCKH68hINYcxpACZPLF215U5z+iA2lbg91E0DaC75wmCyF6H/Jvd+D1e85iU
 0n/Mh2uli18fCIE6Jh+IFEv6uKTz3wIdf9LuWEyDsi6rhpXaMLIDBMZWi7hZ8SbWf+1dAfT5zwkQZ
 LFDN8HCmEcpTiohKWS/Vp+FkbV24bjMBGwwUdoTGhob0/6LX3qbukw5U4AkTUywk0LmrhuCipT8al
 hSy6VmBQ==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeBw-00FUnE-SE; Mon, 01 Mar 2021 08:46:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 10/17] iommu/fsl_pamu: enable the liodn when attaching a device
Date: Mon,  1 Mar 2021 09:42:50 +0100
Message-Id: <20210301084257.945454-11-hch@lst.de>
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

Instead of a separate call to enable all devices from the list, just
enablde the liodn one the device is attached to the iommu domain.

This also remove the DOMAIN_ATTR_FSL_PAMU_ENABLE iommu_attr.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/fsl_pamu_domain.c     | 47 ++---------------------------
 drivers/iommu/fsl_pamu_domain.h     | 10 ------
 drivers/soc/fsl/qbman/qman_portal.c | 11 -------
 include/linux/iommu.h               |  1 -
 4 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 962cdc1a4a1924..21c6d9e79eddf9 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -195,9 +195,6 @@ static void fsl_pamu_domain_free(struct iommu_domain *domain)
 
 	/* remove all the devices from the device list */
 	detach_device(NULL, dma_domain);
-
-	dma_domain->enabled = 0;
-
 	kmem_cache_free(fsl_pamu_domain_cache, dma_domain);
 }
 
@@ -285,6 +282,9 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 		ret = pamu_set_liodn(dma_domain, dev, liodn[i]);
 		if (ret)
 			break;
+		ret = pamu_enable_liodn(liodn[i]);
+		if (ret)
+			break;
 	}
 	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
 	return ret;
@@ -341,46 +341,6 @@ int fsl_pamu_configure_l1_stash(struct iommu_domain *domain, u32 cpu)
 	return ret;
 }
 
-/* Configure domain dma state i.e. enable/disable DMA */
-static int configure_domain_dma_state(struct fsl_dma_domain *dma_domain, bool enable)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&dma_domain->domain_lock, flags);
-	dma_domain->enabled = enable;
-	list_for_each_entry(info, &dma_domain->devices, link) {
-		ret = (enable) ? pamu_enable_liodn(info->liodn) :
-			pamu_disable_liodn(info->liodn);
-		if (ret)
-			pr_debug("Unable to set dma state for liodn %d",
-				 info->liodn);
-	}
-	spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
-
-	return 0;
-}
-
-static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
-				    enum iommu_attr attr_type, void *data)
-{
-	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
-	int ret = 0;
-
-	switch (attr_type) {
-	case DOMAIN_ATTR_FSL_PAMU_ENABLE:
-		ret = configure_domain_dma_state(dma_domain, *(int *)data);
-		break;
-	default:
-		pr_debug("Unsupported attribute type\n");
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 static struct iommu_group *get_device_iommu_group(struct device *dev)
 {
 	struct iommu_group *group;
@@ -505,7 +465,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.attach_dev	= fsl_pamu_attach_device,
 	.detach_dev	= fsl_pamu_detach_device,
 	.iova_to_phys	= fsl_pamu_iova_to_phys,
-	.domain_set_attr = fsl_pamu_set_domain_attr,
 	.probe_device	= fsl_pamu_probe_device,
 	.release_device	= fsl_pamu_release_device,
 	.device_group   = fsl_pamu_device_group,
diff --git a/drivers/iommu/fsl_pamu_domain.h b/drivers/iommu/fsl_pamu_domain.h
index cd488004acd1b3..5f4ed253f61b31 100644
--- a/drivers/iommu/fsl_pamu_domain.h
+++ b/drivers/iommu/fsl_pamu_domain.h
@@ -12,16 +12,6 @@
 struct fsl_dma_domain {
 	/* list of devices associated with the domain */
 	struct list_head		devices;
-	/* dma_domain states:
-	 * enabled - DMA has been enabled for the given
-	 * domain. This translates to setting of the
-	 * valid bit for the primary PAACE in the PAMU
-	 * PAACT table. Domain geometry should be set and
-	 * it must have a valid mapping before DMA can be
-	 * enabled for it.
-	 *
-	 */
-	int				enabled;
 	u32				stash_id;
 	u32				snoop_id;
 	struct iommu_domain		iommu_domain;
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index 798b3a1ffd0b9c..bf38eb0042ed52 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -46,7 +46,6 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 {
 #ifdef CONFIG_FSL_PAMU
 	struct device *dev = pcfg->dev;
-	int window_count = 1;
 	int ret;
 
 	pcfg->iommu_domain = iommu_domain_alloc(&platform_bus_type);
@@ -66,14 +65,6 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 			ret);
 		goto out_domain_free;
 	}
-	ret = iommu_domain_set_attr(pcfg->iommu_domain,
-				    DOMAIN_ATTR_FSL_PAMU_ENABLE,
-				    &window_count);
-	if (ret < 0) {
-		dev_err(dev, "%s(): iommu_domain_set_attr() = %d", __func__,
-			ret);
-		goto out_detach_device;
-	}
 
 no_iommu:
 #endif
@@ -82,8 +73,6 @@ static void portal_set_cpu(struct qm_portal_config *pcfg, int cpu)
 	return;
 
 #ifdef CONFIG_FSL_PAMU
-out_detach_device:
-	iommu_detach_device(pcfg->iommu_domain, NULL);
 out_domain_free:
 	iommu_domain_free(pcfg->iommu_domain);
 	pcfg->iommu_domain = NULL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 208e570e8d99e7..840864844027dc 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -109,7 +109,6 @@ enum iommu_cap {
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
-	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_IO_PGTABLE_CFG,
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
