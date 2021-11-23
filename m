Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A49C4332F
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16186608EF;
	Tue, 23 Nov 2021 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJ-YTpsZoVml; Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 67C5C60809;
	Tue, 23 Nov 2021 15:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44202C0046;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB05C002E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0AD240435
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUUp2JQCzRN3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1C9EC4036D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 n33-20020a05600c502100b0032fb900951eso2705708wmr.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZRrdrvfwnfCOxGojLh1hGBZHdzw/L/mum0ej4VSc97g=;
 b=oyFy1LKvGJMU30/ivLT59O6Xv6m8YFTa3CmSp2WeA7ArdHN2pzN+8sYsZh0nJB1rpm
 TF2I8Klekcd8bV9ApA6N1uTUyS+MUUPbynsMx4R5A7Wuyv1B5BKPm2uTRN6YeON/kPub
 yyRWOLDWRI1135M63lVXQy4MGA4jh4oAUFMS7zaipKmEzLy373q6vZwbIlKtl78brDNa
 JAkYtMYeNwzNcnU98E9rav1aRV38fLddadpd7wkFzWzWq1zA+rbE+5ZBuBmu9GPBuQBX
 CIiYeKo+REQAxyrq77xvWAEZhujL1tBYi9MpEFBN3q4lRcvhtD2i9khCA7kRcnUalSyj
 U80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZRrdrvfwnfCOxGojLh1hGBZHdzw/L/mum0ej4VSc97g=;
 b=OtK0lClc2prxFG4f/StcS47drscugL5ADFBkBZudN36u53+IKdVAjXbAikk79kTfwB
 JHFXIMDVXm51EAHymL3XWB/m4+96T5bhKbM80M2AzELZttOyVSaANOrnI4yHHTTUh+tS
 ypPxU5/BT74M9GC93/Cx4ArYsYmV34ivvUgDOB78bwSq0nao56SRZc20i4wPQpd2XwKh
 6YwREWanUpqctXolmmene57DXN2KlpAjATORc7Vu6yxGfu2AUtfOLcSFiYhE3TzetkHI
 0TWSpvV2yGqJ5AKke1fOGPTnSIv2UIZhp6Nplt3P6FQLBCH5EwlSao2jubR466nfqXe/
 3uJw==
X-Gm-Message-State: AOAM5330BGt2ss2QJZVCADfyVGrzDMrBAQRHzGdCumMXYEAgCwhUxl3r
 F9bMXuicFv/Y4BpwTc6IRsxMRA==
X-Google-Smtp-Source: ABdhPJyRqECTbpPYHH5uCjl08AXcBFe2Levxz9M2D0pbrVXsv3m/dDvD18pCR8flubLYh4b2z40a9g==
X-Received: by 2002:a05:600c:2292:: with SMTP id
 18mr4489566wmf.6.1637683002293; 
 Tue, 23 Nov 2021 07:56:42 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:41 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
Date: Tue, 23 Nov 2021 15:53:02 +0000
Message-Id: <20211123155301.1047943-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eric.auger@redhat.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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

Support identity domains for devices that do not offer the
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, by creating 1:1 mappings between
the virtual and physical address space. Identity domains created this
way still perform noticeably better than DMA domains, because they don't
have the overhead of setting up and tearing down mappings at runtime.
The performance difference between this and bypass is minimal in
comparison.

It does not matter that the physical addresses in the identity mappings
do not all correspond to memory. By enabling passthrough we are trusting
the device driver and the device itself to only perform DMA to suitable
locations. In some cases it may even be desirable to perform DMA to MMIO
regions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index eceb9281c8c1..6a8a52b4297b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -375,6 +375,55 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 	return unmapped;
 }
 
+/*
+ * Fill the domain with identity mappings, skipping the device's reserved
+ * regions.
+ */
+static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
+				      struct viommu_domain *vdomain)
+{
+	int ret;
+	struct iommu_resv_region *resv;
+	u64 iova = vdomain->domain.geometry.aperture_start;
+	u64 limit = vdomain->domain.geometry.aperture_end;
+	u32 flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
+	unsigned long granule = 1UL << __ffs(vdomain->domain.pgsize_bitmap);
+
+	iova = ALIGN(iova, granule);
+	limit = ALIGN_DOWN(limit + 1, granule) - 1;
+
+	list_for_each_entry(resv, &vdev->resv_regions, list) {
+		u64 resv_start = ALIGN_DOWN(resv->start, granule);
+		u64 resv_end = ALIGN(resv->start + resv->length, granule) - 1;
+
+		if (resv_end < iova || resv_start > limit)
+			/* No overlap */
+			continue;
+
+		if (resv_start > iova) {
+			ret = viommu_add_mapping(vdomain, iova, resv_start - 1,
+						 (phys_addr_t)iova, flags);
+			if (ret)
+				goto err_unmap;
+		}
+
+		if (resv_end >= limit)
+			return 0;
+
+		iova = resv_end + 1;
+	}
+
+	ret = viommu_add_mapping(vdomain, iova, limit, (phys_addr_t)iova,
+				 flags);
+	if (ret)
+		goto err_unmap;
+	return 0;
+
+err_unmap:
+	viommu_del_mappings(vdomain, 0, iova);
+	return ret;
+}
+
 /*
  * viommu_replay_mappings - re-send MAP requests
  *
@@ -637,14 +686,18 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	vdomain->viommu		= viommu;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		if (!virtio_has_feature(viommu->vdev,
-					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+		if (virtio_has_feature(viommu->vdev,
+				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+			vdomain->bypass = true;
+			return 0;
+		}
+
+		ret = viommu_domain_map_identity(vdev, vdomain);
+		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
-			vdomain->viommu = 0;
+			vdomain->viommu = NULL;
 			return -EOPNOTSUPP;
 		}
-
-		vdomain->bypass = true;
 	}
 
 	return 0;
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
