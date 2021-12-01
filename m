Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B8FC433F5
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 17:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3211F61BF2;
	Wed,  1 Dec 2021 17:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gQS1Dx6ZpPo; Wed,  1 Dec 2021 17:34:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B1F261BE2;
	Wed,  1 Dec 2021 17:34:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BEC2C003C;
	Wed,  1 Dec 2021 17:34:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61BDDC003E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4076561BF0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rvj3OSG-2knT
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0AE161BCB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 o19-20020a1c7513000000b0033a93202467so1731897wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ht2VzoGN+S/PkTX664g1y/SfBIF5stVyopXayUTwdMM=;
 b=KQgNyfaK/CGS4b7aWmii+Hs6TH4TTgdXnJGQJ5q96JWJEMWJ83/tDDCjUCRzk8U7OZ
 t6uZ/5LnrmAA8w5miu3T4KhAh5JBTBNFI60zU6Bb8SHobIFErGXf7tVjgWRGx7zglGNC
 COWDNtj8v8WYgYXysN9JscXE7ySnunB9S6uB4flJHl+ZApHrdxN8pWKgdeZywFlX60px
 UisAHl7PgFa26g9VW6gQP943bsokJ/3rRF28tOMavhqqiNdVRTYI6PJMob3YQ6xCJKwl
 ZSugGTswvLOtBQP3ZVL3x/yYv8GZHrvBTIPcyiUgnlaHNTEIxWpzTlBqu66eMfZ0uT8m
 8vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ht2VzoGN+S/PkTX664g1y/SfBIF5stVyopXayUTwdMM=;
 b=ELeC2k7rhBAGz98+TvmohSoHbWOStvyHg2GjQi2RH/jS8JxB1CXPT0t/3iyU/ewD4m
 wRZ+8QTKfpSz8hEoPTEU8ah11edzfTiVwzrV57HuLSQVl4CbqQYYnZN9BsSOSSZNlRCl
 KEzfo851F8IRGTFlM9aVJLRo2zz4z84aWHmez5oHDJcth7c/ZFUyy9LxhDTR8nR0nzqC
 c6HELvJWGhFBP7hsZDzAZ/ezR8lji9fyDor0gmVXjbMcsFQ/i3w+8/iQVm5nAZBXQJbX
 PYM+2gXP34tDGSSbcxmpeGUh/veGS0vO/wguQruyYZ3haheAt3I03JgdR7gAwcjDFiuI
 9RDg==
X-Gm-Message-State: AOAM530hxEbZUxS82SvA21Hp+V+IuG+wAsrf+84cCmqQ6ff81OneIlVF
 2R0dsWK+V7opEGMTHX3cZV4GoQ==
X-Google-Smtp-Source: ABdhPJwT+pu91liuF3w9bR5qfSx/F3ol9Pk2QBWzIgI1VOYNlToxql1cSlVGhQM68pLu5noVrYqfAQ==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr8642371wmb.90.1638380079899;
 Wed, 01 Dec 2021 09:34:39 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q8sm360023wrx.71.2021.12.01.09.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 09:34:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 5/5] iommu/virtio: Support identity-mapped domains
Date: Wed,  1 Dec 2021 17:33:25 +0000
Message-Id: <20211201173323.1045819-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211201173323.1045819-1-jean-philippe@linaro.org>
References: <20211201173323.1045819-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eric.auger@redhat.com, iommu@lists.linux-foundation.org,
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 61 +++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 2fa370c2659c..6a8a52b4297b 100644
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
 			vdomain->viommu = NULL;
 			return -EOPNOTSUPP;
 		}
-
-		vdomain->bypass = true;
 	}
 
 	return 0;
-- 
2.34.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
