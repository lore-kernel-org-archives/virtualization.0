Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9799CC43217
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D41B4040D;
	Tue, 23 Nov 2021 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQrnVCCLffXn; Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C38E040416;
	Tue, 23 Nov 2021 15:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E36BC0049;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52746C0031
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8070D4036A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZ77s2fCa5uJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F499400E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 p27-20020a05600c1d9b00b0033bf8532855so2394274wms.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YTNjqGpE3VcD9ViHGW/d2oZFLfgGV6uZyRdtocoRURc=;
 b=RA9304xNns63IlLjRuNm+T8Rp3eWxRbdJ/hHmQG3UhgcRlcOk2VlXLlDBnqlRv9MpM
 PdxsnIuO8ClAT20SfREl5kipXcbOqbloB6e1kt7e214jRC3KCdxvee5DEySscSMBNeOa
 41GERuNUateIwHRENsHic7PPCW5Dq2n0Ym9H64VH9rLiJknE+KRn6+8ZpVi+hL+aES1s
 J17vSVImd6uxf/QnAmae//Z8obQ43MWeUTwXhX5Ld1mPF//iOGx2m+DIdS723TAfG/D8
 WNZDRpcVLUEUkbU/yX4tqQki0ld32E4CGaSjsq0ZfSu7HlOOGx9kFmuucgYMIBzJtXcQ
 5C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YTNjqGpE3VcD9ViHGW/d2oZFLfgGV6uZyRdtocoRURc=;
 b=nZYudjktnxC7Z+qICv3az0kDPkoNYY8EmNzPebpdHfUd6AwCMsbCy+JmEclJdZU/tY
 g5da88LWvIexm2xFboxjK3XTrUOF+Ju3pfjonZafl4YpFR0KM4uX4bmr10ZHWW0MdWtl
 PKSZild03S88+tN865vrVb/LdznmVhmOq5crZR+dUNsoxwraFnAHzKQna9Cvw92Q8n++
 VSSAzGnWyn2OtR9wWpNvy+RUcfr0jlt2I69uTuaekk/HxSHnCixOFS0SrKmDJpbpzZO2
 h5NOHCkOCaAjNeKMHYlhlXMGzctGHH4HqrKlHGB0rGZP7cSK8TdRiTTYcFwyzIyVM9ey
 X2Vg==
X-Gm-Message-State: AOAM532NfS4v+KAk0fGuTi0geqaD8NQN09CZdAfsBfrFgbQoAbwTBp+n
 8xTdgav3PVdjRU6TWp9CDbwvHw==
X-Google-Smtp-Source: ABdhPJyXbikfTn7PtUh68WnDjY38u0Aw8ibNTeoa5UYjoRdL57FuzLwnZVG0aXh8MXyP/eLTk64Brg==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4378312wmi.70.1637683001305; 
 Tue, 23 Nov 2021 07:56:41 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:40 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 4/5] iommu/virtio: Pass end address to viommu_add_mapping()
Date: Tue, 23 Nov 2021 15:53:01 +0000
Message-Id: <20211123155301.1047943-5-jean-philippe@linaro.org>
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

To support identity mappings, the virtio-iommu driver must be able to
represent full 64-bit ranges internally. Pass (start, end) instead of
(start, size) to viommu_add/del_mapping().

Clean comments. The one about the returned size was never true: when
sweeping the whole address space the returned size will most certainly
be smaller than 2^64.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index d63ec4d11b00..eceb9281c8c1 100644
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
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
