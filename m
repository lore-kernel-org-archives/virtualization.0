Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E142FB093
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800141; cv=none; b=ee91DoUUPJl4tFNRPJAFlQJPBdVJGu8r6vjJHnJ/DkQix5bRcvMlMSPAyiiUIBSDg8NtVliKx5pSwhmaJ5hssusGUBeAPH90goWXw/xooHfECx/1QxcD3gvsrFQtivmiAgZqVyT1Zky9RyPeTcDMMjdZUjX2uylUKl4HgAYrnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800141; c=relaxed/simple;
	bh=VmC4Jxvgj+OF+HuiXN+o66ZmH7lTaAFzcHBdiAtT+3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q9ERgYXsxMS0qvYmr6L7ZyFpfAZgO8400GurCvElrp6P5HmUWjGuwWyycNm7fpNk4bgNzZEaa6p2Wdk9x4WpxqenkyyzXxVZuOv3gDvzJjMZllCZDzp9XYYk4lgCu+9OF3NY+mog+IkL1C+ogJ9qRxKaSzWWb00BTNZSccXr/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fl/6ndzW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fl/6ndzW"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso803127a12.3
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758800138; x=1759404938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erUzbsjS7Pcc5I0u/VOZEOT90HSwlVZDCaCA1mBPIHY=;
        b=Fl/6ndzWGRSiXAch+KwKh1quMQM23YyTeqtRiGahikYb9py+8HSRo4utFaKxpX9xRD
         jg18i47wSXVgoth7K0+44M9fwKh4VZNI6ZDJ0SSO8/ZIEt40XI9IQghDZYqIwdzwc95v
         ScBvP4WOJb3rfDVSZ2ndTz2MDkxZKc1MDW7/6ph1W917Gg9mGY8Fg6WPk/8XeYzuK7Wx
         Rv+ItgqEL7Pp2Z3zNup7Gs9vdDYjhuLlauutlu7QYoWnLLGneeJ/e1DxCcRvoB1Yxea6
         MVwPQuLFIsjfGnFUPSErRqfBsqIv5CxwX8Mnitex+UswtDYtml/XZvrJIPVLVGorR9jy
         MGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800138; x=1759404938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erUzbsjS7Pcc5I0u/VOZEOT90HSwlVZDCaCA1mBPIHY=;
        b=CAX2WPXBHbiPhUnQ2bJKhtP2tcdkEduARK24I7g/XvqwSIUSvMSH+fXx/OeFgJODnM
         eNLEAI3euQZdTqGF313oNiR8jvERXEP8kLfHVULxcHct/MkORwRq3Wlw/dMQ+yaJh2TQ
         trM0McNWyhHHOjrgdIL9kxNGN7RDeiX7Q0jxVehcdRgPTKjKBY5RjNG7XqHTrxpKciDI
         zJ7l3Al9rOiyeygw4jubuNGVVNAEcw5O/SKYiKUI8PJaZJ3d1tjbd04W2Xozxy3ROir/
         1RlLYbSBTQrnVsCSlb2AgTDR/c001v9OZHefD7YLPTkTXfry5M1PHKsy7L2JeSLBN1G3
         bPCA==
X-Gm-Message-State: AOJu0Yx14zvjcNqBUhDMeLWA5Oabs3DBrAd+kmfKH7lBea5NFeuDQ2OW
	PHYyjCOYrT2ZdjpgHkfdVsoBiIzAI9AWMNCMazLLFT+9ZGaIovMRXeFI09sSy0zkmY0=
X-Gm-Gg: ASbGncszYpXJcdIQhSAuW66uyjYHc+jtvfy51Pg8Jb/cJcbyRD8SG2QjEAk1DEI0sLb
	HMuC9frm3L8HmXA1VAIJvBJksuzcV2qnayC9xPIna4yIpr2BpvzPvUENdjsj31GNWeWWSyr9YA4
	F6qBtdEkfpZSuNQqAo679BZRrzcZ8qm3cxr0CFFnhPTTNJjc+rGSwtDz7wdCFl2yeWZaK5YdhBA
	eFAMH4xVu6OZUNnmcO5ZRJnDPDNOOPdYuXaFka6whj00ISz8fweMSq5FL0ywRuk48Q0URZn9oPi
	jbJw4RXrKV7rCk7uIfFuBiopyEVE1AW3DI+h6hiS1aCOjW0YVcTCMk4HLZEeuIMi2J/sXOQ+9VT
	nRzutPnT5FgvYrB3yEI7tAaUGvq7Gsq8WUU7uob/dVdN69L6yqSZeF+wqJAhNwJ+QwSPfdUxtTX
	7SmOeIrEk8zQ==
X-Google-Smtp-Source: AGHT+IGDrwphJcBu9glOmSZz197HGaYZSeILmht8xenQ8C3DJiOpCgzoJEGon4xMLPYxAWllFUIfww==
X-Received: by 2002:a17:902:eccb:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-27ed4a0d705mr38227785ad.25.1758800137766;
        Thu, 25 Sep 2025 04:35:37 -0700 (PDT)
Received: from N91GQ2C6R9.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm22909415ad.49.2025.09.25.04.35.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 04:35:37 -0700 (PDT)
From: sheng.zhao@bytedance.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Sheng Zhao <sheng.zhao@bytedance.com>
Subject: [PATCH v2] vduse: Use fixed 4KB bounce pages for non-4KB page size
Date: Thu, 25 Sep 2025 19:35:16 +0800
Message-Id: <20250925113516.60305-1-sheng.zhao@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Zhao <sheng.zhao@bytedance.com>

The allocation granularity of bounce pages is PAGE_SIZE. This may cause
even small IO requests to occupy an entire bounce page exclusively. The
kind of memory waste will be more significant when PAGE_SIZE is larger
than 4KB (e.g. arm64 with 64KB pages).

So, optimize it by using fixed 4KB bounce maps and iova allocation
granularity. A single IO request occupies at least a 4KB bounce page
instead of the entire memory page of PAGE_SIZE.

Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
---

Changes in v2:
- Tweak the title and improve the commit message.
- Change the macro prefix from BOUNCE_PAGE to BOUNCE_MAP.
- Add code comments.
- Link to v1: https://lore.kernel.org/lkml/20250915073429.54027-1-sheng.zhao@bytedance.com

---
 drivers/vdpa/vdpa_user/iova_domain.c | 132 ++++++++++++++++++---------
 drivers/vdpa/vdpa_user/iova_domain.h |   5 +
 2 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..402e66a0ae39 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -103,19 +103,38 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 					 u64 iova, u64 size, u64 paddr)
 {
-	struct vduse_bounce_map *map;
+	struct vduse_bounce_map *map, *head_map;
+	struct page *tmp_page;
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		/*
+		 * When PAGE_SIZE is larger than 4KB, multiple adjacent bounce_maps will
+		 * point to the same memory page of PAGE_SIZE. Since bounce_maps originate
+		 * from IO requests, we may not be able to guarantee that the orig_phys
+		 * values of all IO requests within the same 64KB memory page are contiguous.
+		 * Therefore, we need to store them separately.
+		 *
+		 * Bounce pages are allocated on demand. As a result, it may occur that
+		 * multiple bounce pages corresponding to the same 64KB memory page attempt
+		 * to allocate memory simultaneously, so we use cmpxchg to handle this
+		 * concurrency.
+		 */
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 		if (!map->bounce_page) {
-			map->bounce_page = alloc_page(GFP_ATOMIC);
-			if (!map->bounce_page)
-				return -ENOMEM;
+			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
+			if (!head_map->bounce_page) {
+				tmp_page = alloc_page(GFP_ATOMIC);
+				if (!tmp_page)
+					return -ENOMEM;
+				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
+					__free_page(tmp_page);
+			}
+			map->bounce_page = head_map->bounce_page;
 		}
 		map->orig_phys = paddr;
-		paddr += PAGE_SIZE;
-		iova += PAGE_SIZE;
+		paddr += BOUNCE_MAP_SIZE;
+		iova += BOUNCE_MAP_SIZE;
 	}
 	return 0;
 }
@@ -127,12 +146,17 @@ static void vduse_domain_unmap_bounce_page(struct vduse_iova_domain *domain,
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 		map->orig_phys = INVALID_PHYS_ADDR;
-		iova += PAGE_SIZE;
+		iova += BOUNCE_MAP_SIZE;
 	}
 }
 
+static unsigned int offset_in_bounce_page(dma_addr_t addr)
+{
+	return (addr & ~BOUNCE_MAP_MASK);
+}
+
 static void do_bounce(phys_addr_t orig, void *addr, size_t size,
 		      enum dma_data_direction dir)
 {
@@ -163,7 +187,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 {
 	struct vduse_bounce_map *map;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, head_offset;
 	void *addr;
 	size_t sz;
 
@@ -171,9 +195,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		return;
 
 	while (size) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
-		offset = offset_in_page(iova);
-		sz = min_t(size_t, PAGE_SIZE - offset, size);
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
+		head_offset = offset_in_page(iova);
+		offset = offset_in_bounce_page(iova);
+		sz = min_t(size_t, BOUNCE_MAP_SIZE - offset, size);
 
 		if (WARN_ON(!map->bounce_page ||
 			    map->orig_phys == INVALID_PHYS_ADDR))
@@ -183,7 +208,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		       map->user_bounce_page : map->bounce_page;
 
 		addr = kmap_local_page(page);
-		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
+		do_bounce(map->orig_phys + offset, addr + head_offset, sz, dir);
 		kunmap_local(addr);
 		size -= sz;
 		iova += sz;
@@ -218,7 +243,7 @@ vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 	struct page *page = NULL;
 
 	read_lock(&domain->bounce_lock);
-	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+	map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 	if (domain->user_bounce_pages || !map->bounce_page)
 		goto out;
 
@@ -236,7 +261,7 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
 
-	bounce_pfns = domain->bounce_size >> PAGE_SHIFT;
+	bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
 
 	for (pfn = 0; pfn < bounce_pfns; pfn++) {
 		map = &domain->bounce_maps[pfn];
@@ -246,7 +271,8 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 		if (!map->bounce_page)
 			continue;
 
-		__free_page(map->bounce_page);
+		if (!((pfn << BOUNCE_MAP_SHIFT) & ~PAGE_MASK))
+			__free_page(map->bounce_page);
 		map->bounce_page = NULL;
 	}
 }
@@ -254,8 +280,12 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				       struct page **pages, int count)
 {
-	struct vduse_bounce_map *map;
-	int i, ret;
+	struct vduse_bounce_map *map, *head_map;
+	int i, j, ret;
+	int inner_pages = PAGE_SIZE / BOUNCE_MAP_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	/* Now we don't support partial mapping */
 	if (count != (domain->bounce_size >> PAGE_SHIFT))
@@ -267,16 +297,23 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 		goto out;
 
 	for (i = 0; i < count; i++) {
-		map = &domain->bounce_maps[i];
-		if (map->bounce_page) {
+		need_copy = false;
+		head_map = &domain->bounce_maps[(i * inner_pages)];
+		head_page = head_map->bounce_page;
+		for (j = 0; j < inner_pages; j++) {
+			if ((i * inner_pages + j) >= bounce_pfns)
+				break;
+			map = &domain->bounce_maps[(i * inner_pages + j)];
 			/* Copy kernel page to user page if it's in use */
-			if (map->orig_phys != INVALID_PHYS_ADDR)
-				memcpy_to_page(pages[i], 0,
-					       page_address(map->bounce_page),
-					       PAGE_SIZE);
+			if ((head_page) && (map->orig_phys != INVALID_PHYS_ADDR))
+				need_copy = true;
+			map->user_bounce_page = pages[i];
 		}
-		map->user_bounce_page = pages[i];
 		get_page(pages[i]);
+		if ((head_page) && (need_copy))
+			memcpy_to_page(pages[i], 0,
+				       page_address(head_page),
+				       PAGE_SIZE);
 	}
 	domain->user_bounce_pages = true;
 	ret = 0;
@@ -288,8 +325,12 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 
 void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 {
-	struct vduse_bounce_map *map;
-	unsigned long i, count;
+	struct vduse_bounce_map *map, *head_map;
+	unsigned long i, j, count;
+	int inner_pages = PAGE_SIZE / BOUNCE_MAP_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	write_lock(&domain->bounce_lock);
 	if (!domain->user_bounce_pages)
@@ -297,20 +338,27 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 
 	count = domain->bounce_size >> PAGE_SHIFT;
 	for (i = 0; i < count; i++) {
-		struct page *page = NULL;
-
-		map = &domain->bounce_maps[i];
-		if (WARN_ON(!map->user_bounce_page))
+		need_copy = false;
+		head_map = &domain->bounce_maps[(i * inner_pages)];
+		if (WARN_ON(!head_map->user_bounce_page))
 			continue;
-
-		/* Copy user page to kernel page if it's in use */
-		if (map->orig_phys != INVALID_PHYS_ADDR) {
-			page = map->bounce_page;
-			memcpy_from_page(page_address(page),
-					 map->user_bounce_page, 0, PAGE_SIZE);
+		head_page = head_map->user_bounce_page;
+
+		for (j = 0; j < inner_pages; j++) {
+			if ((i * inner_pages + j) >= bounce_pfns)
+				break;
+			map = &domain->bounce_maps[(i * inner_pages + j)];
+			if (WARN_ON(!map->user_bounce_page))
+				continue;
+			/* Copy user page to kernel page if it's in use */
+			if ((map->orig_phys != INVALID_PHYS_ADDR) && (head_map->bounce_page))
+				need_copy = true;
+			map->user_bounce_page = NULL;
 		}
-		put_page(map->user_bounce_page);
-		map->user_bounce_page = NULL;
+		if (need_copy)
+			memcpy_from_page(page_address(head_map->bounce_page),
+					 head_page, 0, PAGE_SIZE);
+		put_page(head_page);
 	}
 	domain->user_bounce_pages = false;
 out:
@@ -581,7 +629,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	unsigned long pfn, bounce_pfns;
 	int ret;
 
-	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
+	bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
 	if (iova_limit <= bounce_size)
 		return NULL;
 
@@ -613,7 +661,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	rwlock_init(&domain->bounce_lock);
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
-			PAGE_SIZE, IOVA_START_PFN);
+			BOUNCE_MAP_SIZE, IOVA_START_PFN);
 	ret = iova_domain_init_rcaches(&domain->stream_iovad);
 	if (ret)
 		goto err_iovad_stream;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 7f3f0928ec78..e36d4b7ef5d0 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -19,6 +19,11 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+#define BOUNCE_MAP_SHIFT	12
+#define BOUNCE_MAP_SIZE	(1 << BOUNCE_MAP_SHIFT)
+#define BOUNCE_MAP_MASK	(~(BOUNCE_MAP_SIZE - 1))
+#define BOUNCE_MAP_ALIGN(addr)	(((addr) + BOUNCE_MAP_SIZE - 1) & ~(BOUNCE_MAP_SIZE - 1))
+
 struct vduse_bounce_map {
 	struct page *bounce_page;
 	struct page *user_bounce_page;
-- 
2.20.1

