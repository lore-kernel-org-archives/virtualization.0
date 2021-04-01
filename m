Return-Path: <SRS0=3//R=I6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B7C433B4
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C7E61390
	for <virtualization@archiver.kernel.org>; Thu,  1 Apr 2021 16:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C7E61390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B65C84AE1;
	Thu,  1 Apr 2021 16:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dv30RzCdcfwz; Thu,  1 Apr 2021 16:56:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4D5F8497C;
	Thu,  1 Apr 2021 16:56:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF35C000C;
	Thu,  1 Apr 2021 16:56:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49626C000A;
 Thu,  1 Apr 2021 16:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28C4E40F44;
 Thu,  1 Apr 2021 16:56:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rWiJz0czCB-o; Thu,  1 Apr 2021 16:55:59 +0000 (UTC)
X-Greylist: delayed 01:02:26 by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34EDB4068E;
 Thu,  1 Apr 2021 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=dyx7QVblzHbK4MRCTPlF13BQO95VOFepHLOSDp+S53M=; b=caV2uLEXrsT0Av5dzUHGpy2nA0
 5of6fjvfFG86sDoA04gQUCb9PW2QONtmdI7AHXqyYAk0xCPiIZo4Hqo2voVWuvKrFVVtnuyQmkqdJ
 Cei1kTBr22HGPeQ/SawPspEXmUX8OOHKuE0EeXWZb9nUiLvcaoFvkYdS64jeHOF/homyV28A+nNjr
 rvx8RE4sHOLsqNhj0JuJMqhXWoIrc5DEBZovElemEBpanx3MW4/NVOqeyR5IFAUJSNPBhPcsMUb7x
 71alTGsl40CC1d6M0klsWg0ffIWmpTTsQpT4KIfOer+MqaRycotd9GdnMr717KrQJBTrmJXbk6zph
 Ab9fLjPQ==;
Received: from [2001:4bb8:180:7517:83e4:a809:b0aa:ca74] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lRzdl-00CidN-M2; Thu, 01 Apr 2021 15:53:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 15/20] iommu: remove DOMAIN_ATTR_GEOMETRY
Date: Thu,  1 Apr 2021 17:52:51 +0200
Message-Id: <20210401155256.298656-16-hch@lst.de>
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

The geometry information can be trivially queried from the iommu_domain
struture.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/iommu.c           | 20 +++-----------------
 drivers/vfio/vfio_iommu_type1.c | 26 ++++++++++++--------------
 drivers/vhost/vdpa.c            | 10 +++-------
 include/linux/iommu.h           |  1 -
 4 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a4cda390993e6..23daaea7883b75 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2667,23 +2667,9 @@ core_initcall(iommu_init);
 int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
-	struct iommu_domain_geometry *geometry;
-	int ret = 0;
-
-	switch (attr) {
-	case DOMAIN_ATTR_GEOMETRY:
-		geometry  = data;
-		*geometry = domain->geometry;
-
-		break;
-	default:
-		if (!domain->ops->domain_get_attr)
-			return -EINVAL;
-
-		ret = domain->ops->domain_get_attr(domain, attr, data);
-	}
-
-	return ret;
+	if (!domain->ops->domain_get_attr)
+		return -EINVAL;
+	return domain->ops->domain_get_attr(domain, attr, data);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_get_attr);
 
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 45cbfd4879a553..ae6d72f17aee78 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2262,7 +2262,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	int ret;
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base = 0;
-	struct iommu_domain_geometry geo;
+	struct iommu_domain_geometry *geo;
 	LIST_HEAD(iova_copy);
 	LIST_HEAD(group_resv_regions);
 
@@ -2343,10 +2343,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_domain;
 
 	/* Get aperture info */
-	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
-
-	if (vfio_iommu_aper_conflict(iommu, geo.aperture_start,
-				     geo.aperture_end)) {
+	geo = &domain->domain->geometry;
+	if (vfio_iommu_aper_conflict(iommu, geo->aperture_start,
+				     geo->aperture_end)) {
 		ret = -EINVAL;
 		goto out_detach;
 	}
@@ -2369,8 +2368,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
-	ret = vfio_iommu_aper_resize(&iova_copy, geo.aperture_start,
-				     geo.aperture_end);
+	ret = vfio_iommu_aper_resize(&iova_copy, geo->aperture_start,
+				     geo->aperture_end);
 	if (ret)
 		goto out_detach;
 
@@ -2503,7 +2502,6 @@ static void vfio_iommu_aper_expand(struct vfio_iommu *iommu,
 				   struct list_head *iova_copy)
 {
 	struct vfio_domain *domain;
-	struct iommu_domain_geometry geo;
 	struct vfio_iova *node;
 	dma_addr_t start = 0;
 	dma_addr_t end = (dma_addr_t)~0;
@@ -2512,12 +2510,12 @@ static void vfio_iommu_aper_expand(struct vfio_iommu *iommu,
 		return;
 
 	list_for_each_entry(domain, &iommu->domain_list, next) {
-		iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
-				      &geo);
-		if (geo.aperture_start > start)
-			start = geo.aperture_start;
-		if (geo.aperture_end < end)
-			end = geo.aperture_end;
+		struct iommu_domain_geometry *geo = &domain->domain->geometry;
+
+		if (geo->aperture_start > start)
+			start = geo->aperture_start;
+		if (geo->aperture_end < end)
+			end = geo->aperture_end;
 	}
 
 	/* Modify aperture limits. The new aper is either same or bigger */
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e0a27e33629356..cd1ff7b556dcee 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -832,18 +832,14 @@ static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 static void vhost_vdpa_set_iova_range(struct vhost_vdpa *v)
 {
 	struct vdpa_iova_range *range = &v->range;
-	struct iommu_domain_geometry geo;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 
 	if (ops->get_iova_range) {
 		*range = ops->get_iova_range(vdpa);
-	} else if (v->domain &&
-		   !iommu_domain_get_attr(v->domain,
-		   DOMAIN_ATTR_GEOMETRY, &geo) &&
-		   geo.force_aperture) {
-		range->first = geo.aperture_start;
-		range->last = geo.aperture_end;
+	} else if (v->domain && v->domain->geometry.force_aperture) {
+		range->first = v->domain->geometry.aperture_start;
+		range->last = v->domain->geometry.aperture_end;
 	} else {
 		range->first = 0;
 		range->last = ULLONG_MAX;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 180ff4bd7fa7ef..c15a8658daad64 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -107,7 +107,6 @@ enum iommu_cap {
  */
 
 enum iommu_attr {
-	DOMAIN_ATTR_GEOMETRY,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_IO_PGTABLE_CFG,
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
