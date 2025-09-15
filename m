Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992472D6630
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921682; cv=none; b=Q/ZtKmjvMrz3fVTjntvdbCrMMAUeJpuTX4VIy8KJBoWIM23N56zSv7ohWD4nyR04/e2U7TRICcR8nHiIe0Z7lnIjgSHGKwV6voAZ8zfipV6gvU/mMj2LzSbr7Vzb0uIcB4BLs6ZGw4FoERCk7blz1hi1yvfVRwiKzAXlrgaT7KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921682; c=relaxed/simple;
	bh=2HMhB+z9Wmbw+6HNUryCiUx8upi/xjPSlu9nG2BaTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TeYJScSi9bqNRSLLuzH7V9uSChVqQ5WVYhs17Ssz/hY5kZAXAiQe2uMo9auECfUSQUclF9HGCr4rMJ/NHPq4ERIX7EbpgkgW40jMnl9357ywW5uYnTXmvHj0qyFSmst0Def03L3pd38rSCpX+gNImfWiaPZ2GgURn+fZAcx+Fhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VUsd8kPK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VUsd8kPK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77615d6af4fso3117163b3a.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757921680; x=1758526480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0rUlxu9dxRa7SjOGu2hjs3bhYsbBAOKtMENXiwjFtw=;
        b=VUsd8kPKS/L7aA3BwanwL6Gx0GvzIep48ZYR36XUx1B4xo6RfQ1EpTQgdnE82ibBrg
         AEJCX9bAUNAyDtPD8iFJDegGv9AHtvDPKWp+E6kh5e8m0Ez4hWklKBEHntMAjw0UmYvg
         a+US3o7JDHiqRD1gjgebegWuPoMO3wzMUWbYf3U+filtsaMkzqGMlHlDwfqiBELmSB01
         z1G6Bu54/IjdoHQZUtULUQ3kxHu7rUoSmA7nj3v4NXzjkiCO42+VQ+oStFoRoDV/UB4h
         DLuY5Eu99R4q9GGJOo7srEH+nW+525rONr5VgLh9G0N4sAHtnenrLm1C4u1xV8fewcuz
         ZN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921680; x=1758526480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0rUlxu9dxRa7SjOGu2hjs3bhYsbBAOKtMENXiwjFtw=;
        b=gS7N66fe65gOL66679dUbyZgWHb2zWuYjY/rfyhUpcCVAv4Qk5EdkXEpWKl8MGWwMO
         jO9GV/LbyxM5JyyLc0qn3nPx+vfLDMcaY/ZPio6HgIsHQD6LvHSI2FSbLuJEfRICwo3j
         hCKLKXu1lqxKVINJulSVqXYpCFQDYDbqds0RsixF85wrhhxFjSiDidTB3vnX998syGTz
         PaLjjL7rhdkf4cGY0+cdqNs/HjdDsBO8f0OhUbbT372gKaPvNHDnbOE0xNI77vNZfctT
         NE9LooZbo1rgZ8OEsvMRKwpItL8d2XqZ8H8GlhXDXE6Yz+dQn2B5vJoiHCmp1YqOD01Z
         e3gw==
X-Gm-Message-State: AOJu0YzEGyNjljlXt093xsZKHET6pqwSVEfJ1ocYxN1rDFugXcgbaitu
	FtV8nkjQXG2wpUr+NSNrxhhqFfEL3HjoUwOWfuxV1EV40EQZq5fbbTZmCs8qdDdA8h4=
X-Gm-Gg: ASbGncviLsIcbr8lNWG1rX/Q8/4uFvpq7Z/n0kntgJSyYcIBJc/esJHps5/KAzy7Dbz
	SXlo50V//3SDpu+zsEHqMruRS0CMJVJ7+FPOOmmjQAgPlIThF/Y/pwWA62hSQyOPlkTOdkRRY9W
	Akadjz9dK1I7q5wAGhY5I66JZaPw56AUvOtS2JjMCsZ9/gpTQ8QV5qjoBB3i+0o3NO3HMnfazyy
	VDFTGyd9/JIK+dS/9jseTJkq5hd3PiUbYU915lh/ekvHw3qnvDAq190PRZ5qGOXyGZ7Uv94x4M2
	QfSJGzW/4KkdawXrevdCYO5I1V/csMdT+HW4py4TRkyIDO7AXyHFlHhISvw/R1tMxSegW7fBGBe
	cjFZHnwOuT3ERsdouKPEsjPMCnA/fsejdibLhMRoFH4SkNldiPZqmFlBrIUYTTXqccWONfj/wH8
	ct7fy8zTMPOg==
X-Google-Smtp-Source: AGHT+IGWBBFTvXjPkwhC1q3K/gyU/0rSmSOfhvtAxOVjYW+gf7TUoGsC85i/QUCRghpMZknvfprsuQ==
X-Received: by 2002:a05:6a20:7343:b0:243:aca2:e500 with SMTP id adf61e73a8af0-2602c04a56fmr14074924637.29.1757921679721;
        Mon, 15 Sep 2025 00:34:39 -0700 (PDT)
Received: from N91GQ2C6R9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cd4bsm11050234a12.35.2025.09.15.00.34.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 00:34:39 -0700 (PDT)
From: sheng.zhao@bytedance.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Sheng Zhao <sheng.zhao@bytedance.com>
Subject: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
Date: Mon, 15 Sep 2025 15:34:29 +0800
Message-Id: <20250915073429.54027-1-sheng.zhao@bytedance.com>
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
kind of memory waste will be more significant on arm64 with 64KB pages.

So, optimize it by using fixed 4KB bounce pages.

Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
 drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
 2 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..768313c80b62 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 					 u64 iova, u64 size, u64 paddr)
 {
-	struct vduse_bounce_map *map;
+	struct vduse_bounce_map *map, *head_map;
+	struct page *tmp_page;
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
 		if (!map->bounce_page) {
-			map->bounce_page = alloc_page(GFP_ATOMIC);
-			if (!map->bounce_page)
-				return -ENOMEM;
+			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
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
+		paddr += BOUNCE_PAGE_SIZE;
+		iova += BOUNCE_PAGE_SIZE;
 	}
 	return 0;
 }
@@ -127,12 +134,17 @@ static void vduse_domain_unmap_bounce_page(struct vduse_iova_domain *domain,
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
 		map->orig_phys = INVALID_PHYS_ADDR;
-		iova += PAGE_SIZE;
+		iova += BOUNCE_PAGE_SIZE;
 	}
 }
 
+static unsigned int offset_in_bounce_page(dma_addr_t addr)
+{
+	return (addr & ~BOUNCE_PAGE_MASK);
+}
+
 static void do_bounce(phys_addr_t orig, void *addr, size_t size,
 		      enum dma_data_direction dir)
 {
@@ -163,7 +175,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 {
 	struct vduse_bounce_map *map;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, head_offset;
 	void *addr;
 	size_t sz;
 
@@ -171,9 +183,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		return;
 
 	while (size) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
-		offset = offset_in_page(iova);
-		sz = min_t(size_t, PAGE_SIZE - offset, size);
+		map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
+		head_offset = offset_in_page(iova);
+		offset = offset_in_bounce_page(iova);
+		sz = min_t(size_t, BOUNCE_PAGE_SIZE - offset, size);
 
 		if (WARN_ON(!map->bounce_page ||
 			    map->orig_phys == INVALID_PHYS_ADDR))
@@ -183,7 +196,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		       map->user_bounce_page : map->bounce_page;
 
 		addr = kmap_local_page(page);
-		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
+		do_bounce(map->orig_phys + offset, addr + head_offset, sz, dir);
 		kunmap_local(addr);
 		size -= sz;
 		iova += sz;
@@ -218,7 +231,7 @@ vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 	struct page *page = NULL;
 
 	read_lock(&domain->bounce_lock);
-	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+	map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
 	if (domain->user_bounce_pages || !map->bounce_page)
 		goto out;
 
@@ -236,7 +249,7 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
 
-	bounce_pfns = domain->bounce_size >> PAGE_SHIFT;
+	bounce_pfns = domain->bounce_size >> BOUNCE_PAGE_SHIFT;
 
 	for (pfn = 0; pfn < bounce_pfns; pfn++) {
 		map = &domain->bounce_maps[pfn];
@@ -246,7 +259,8 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 		if (!map->bounce_page)
 			continue;
 
-		__free_page(map->bounce_page);
+		if (!((pfn << BOUNCE_PAGE_SHIFT) & ~PAGE_MASK))
+			__free_page(map->bounce_page);
 		map->bounce_page = NULL;
 	}
 }
@@ -254,8 +268,12 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				       struct page **pages, int count)
 {
-	struct vduse_bounce_map *map;
-	int i, ret;
+	struct vduse_bounce_map *map, *head_map;
+	int i, j, ret;
+	int inner_pages = PAGE_SIZE / BOUNCE_PAGE_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_PAGE_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	/* Now we don't support partial mapping */
 	if (count != (domain->bounce_size >> PAGE_SHIFT))
@@ -267,16 +285,23 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
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
@@ -288,8 +313,12 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 
 void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 {
-	struct vduse_bounce_map *map;
-	unsigned long i, count;
+	struct vduse_bounce_map *map, *head_map;
+	unsigned long i, j, count;
+	int inner_pages = PAGE_SIZE / BOUNCE_PAGE_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_PAGE_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	write_lock(&domain->bounce_lock);
 	if (!domain->user_bounce_pages)
@@ -297,20 +326,27 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 
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
@@ -581,7 +617,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	unsigned long pfn, bounce_pfns;
 	int ret;
 
-	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
+	bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_PAGE_SHIFT;
 	if (iova_limit <= bounce_size)
 		return NULL;
 
@@ -613,7 +649,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	rwlock_init(&domain->bounce_lock);
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
-			PAGE_SIZE, IOVA_START_PFN);
+			BOUNCE_PAGE_SIZE, IOVA_START_PFN);
 	ret = iova_domain_init_rcaches(&domain->stream_iovad);
 	if (ret)
 		goto err_iovad_stream;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 7f3f0928ec78..23139a2eaf5c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -19,6 +19,11 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+#define BOUNCE_PAGE_SHIFT	12
+#define BOUNCE_PAGE_SIZE	(1 << BOUNCE_PAGE_SHIFT)
+#define BOUNCE_PAGE_MASK	(~(BOUNCE_PAGE_SIZE - 1))
+#define BOUNCE_PAGE_ALIGN(addr)	(((addr) + BOUNCE_PAGE_SIZE - 1) & ~(BOUNCE_PAGE_SIZE - 1))
+
 struct vduse_bounce_map {
 	struct page *bounce_page;
 	struct page *user_bounce_page;
-- 
2.20.1

