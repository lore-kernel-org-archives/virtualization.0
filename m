Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41352C4167E
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 17:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 797BA61BA8;
	Wed,  1 Dec 2021 17:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q2O218UdLIAR; Wed,  1 Dec 2021 17:34:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02D1261BF3;
	Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE0F9C0044;
	Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9C8FC002E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0DF261BEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FDkwTYdTsrNt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE748607AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id p18so21034943wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 09:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VGZjSTZN525q3rqWpMgRlQQk2cIWs1KD7fKMvPoSwC8=;
 b=K70ST+5ecDC2AksgI+RoMDjbuEgGNmAEKB0RiOi/MGNAvK52JKxXiqnh2+LADP79Eg
 nL7fsykgDUFowmjc3bPVoUM9JoLOBJPjJVJhu5Dx0HX2bQLZahOIlWk3xuuncP24ERHJ
 z8roUN+vH5FqIABoCAnvSH1Co/IcIohwN51HtUlUNM8weKkArLSZFZ6WiK2dqref1e60
 9maB2WylkMVZ3ZMSAuz9DB3IGleoPSQ5NFL7lZ1MUXh975U7fJHjN4kJzCnGJr7udi8X
 q8AWKZBqZLjWpIIRT4hdGNEv0s5Lsgp+ZVgtk9ifuv7BNdvpOQFkq347Cg+SJdGxE8lj
 yFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VGZjSTZN525q3rqWpMgRlQQk2cIWs1KD7fKMvPoSwC8=;
 b=SV7E7rpvRXhsrULpl0xzye/Lz2/4dBwT/bufkOt35uWx1GZd0c3PicRhHSW6W258rs
 0ImcvE7f+/yIpuMVVRb27WG5u5rQHNIPhJK1hF/1WhMWQR2yCVpzcy8vfFqroqAE3HHt
 5qo7UOEYt9hmVArQzjON1ywXcmrk/Mt/MURaFdCL6n9UgNl63S0pRFQ/5m23yhf6kb5l
 l39haBRyKO3Zu1zthycLZCIl80TsLOv3DbsQLJ8LIDSZy63nEFZMLt56Q88sp+VDhLQx
 uPXBECyZ++sLHIofUJBUWSU9yYnVu12cQQgeErCb9Ou6X/2QpclHmowvAF+PgxJHvWKt
 NHBA==
X-Gm-Message-State: AOAM5317GTSoC6OR/+AvxyBZMbdhBLx9D4dGeRhidhHiKhfUk8flIWV+
 +hkIyirWUHKBrKIiu5q4Fbh2zg==
X-Google-Smtp-Source: ABdhPJxVqGIvJlYfbpH1rB11Lh+wBtxpRPW3nrXgkr2ATJ9igyrj/amNIf7bgfZOJhb0MMtIdAuWtg==
X-Received: by 2002:a05:600c:1d01:: with SMTP id
 l1mr8967936wms.44.1638380078933; 
 Wed, 01 Dec 2021 09:34:38 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q8sm360023wrx.71.2021.12.01.09.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 09:34:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 4/5] iommu/virtio: Pass end address to viommu_add_mapping()
Date: Wed,  1 Dec 2021 17:33:24 +0000
Message-Id: <20211201173323.1045819-5-jean-philippe@linaro.org>
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

To support identity mappings, the virtio-iommu driver must be able to
represent full 64-bit ranges internally. Pass (start, end) instead of
(start, size) to viommu_add/del_mapping().

Clean comments. The one about the returned size was never true: when
sweeping the whole address space the returned size will most certainly
be smaller than 2^64.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 1b3c1f2741c6..2fa370c2659c 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
  *
  * On success, return the new mapping. Otherwise return NULL.
  */
-static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
-			      phys_addr_t paddr, size_t size, u32 flags)
+static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
+			      phys_addr_t paddr, u32 flags)
 {
 	unsigned long irqflags;
 	struct viommu_mapping *mapping;
@@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
 
 	mapping->paddr		= paddr;
 	mapping->iova.start	= iova;
-	mapping->iova.last	= iova + size - 1;
+	mapping->iova.last	= end;
 	mapping->flags		= flags;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
@@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
  *
  * @vdomain: the domain
  * @iova: start of the range
- * @size: size of the range. A size of 0 corresponds to the entire address
- *	space.
+ * @end: end of the range
  *
- * On success, returns the number of unmapped bytes (>= size)
+ * On success, returns the number of unmapped bytes
  */
 static size_t viommu_del_mappings(struct viommu_domain *vdomain,
-				  unsigned long iova, size_t size)
+				  u64 iova, u64 end)
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	unsigned long last = iova + size - 1;
 	struct viommu_mapping *mapping = NULL;
 	struct interval_tree_node *node, *next;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
-	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
+	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
 	while (next) {
 		node = next;
 		mapping = container_of(node, struct viommu_mapping, iova);
-		next = interval_tree_iter_next(node, iova, last);
+		next = interval_tree_iter_next(node, iova, end);
 
 		/* Trying to split a mapping? */
 		if (mapping->iova.start < iova)
@@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	/* Free all remaining mappings (size 2^64) */
-	viommu_del_mappings(vdomain, 0, 0);
+	/* Free all remaining mappings */
+	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
 
 	if (vdomain->viommu)
 		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
@@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	u32 flags;
+	u64 end = iova + size - 1;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (flags & ~vdomain->map_flags)
 		return -EINVAL;
 
-	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
+	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
 	if (ret)
 		return ret;
 
@@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		.domain		= cpu_to_le32(vdomain->id),
 		.virt_start	= cpu_to_le64(iova),
 		.phys_start	= cpu_to_le64(paddr),
-		.virt_end	= cpu_to_le64(iova + size - 1),
+		.virt_end	= cpu_to_le64(end),
 		.flags		= cpu_to_le32(flags),
 	};
 
@@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
 	if (ret)
-		viommu_del_mappings(vdomain, iova, size);
+		viommu_del_mappings(vdomain, iova, end);
 
 	return ret;
 }
@@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	unmapped = viommu_del_mappings(vdomain, iova, size);
+	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
 	if (unmapped < size)
 		return 0;
 
-- 
2.34.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
