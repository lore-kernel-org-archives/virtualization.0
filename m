Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42293421EE8
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068258; cv=none; b=D9YlEAN7FA2bvMUQdGfOV+so+7U/X5IfeoJ6RmP7ZyNHJl+IfYnSMvTvPAVUPa0Iyj8wBvpQOR6iFoNOQqdNWtLBpQ9GwWkT4tgUFBokWqMjfX9ddBH1U0aO47iwV21LvsxRHcQs48hjekg2luxWxKpMWaXYH/e+Lv+OCfb8cLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068258; c=relaxed/simple;
	bh=Axczvl8C15WZZkzyVXb9w4AL4G4ah5FFkNusKG6v0bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EJDRpEEhfQ0+T3sf60BQcBDmB9bS/P5gjzNtuTgu4AxMnDm6vGBusptaykLCeLRzJZQjlX7FkbYON6lHKUWl8O9/EuZYm36hem9yp7RuPMsPFHl9428r4dzg8GDVvyN3HoNCR1dEz5QGlWfJV5fnW/AEPhPdgMQDjZfWKwwcaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmjHS/xz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmjHS/xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ha0MKvEjPpqKYjU+TNR9cOwfxNwOYM3BFVBNkyNiIfo=;
	b=hmjHS/xz6CWhW6iIu6yN2Rj+aC6ePhv1TnPgBFi2JTpyqu0lb0JeLiP82KBRifb3qI/72m
	lAiHZuNk42XbfB67HCHlmW8iS0KLE40f8i6U84rvNO3QeIjGUZp8r3YHr/vWaZj5HvFpol
	iaoRJUHx/4Gy76tmL1+SgeC8/mTYrS8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-TKdjcUMNPCmqHFQNSnlkGA-1; Fri, 29 May 2026 11:24:15 -0400
X-MC-Unique: TKdjcUMNPCmqHFQNSnlkGA-1
X-Mimecast-MFC-AGG-ID: TKdjcUMNPCmqHFQNSnlkGA_1780068254
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e73a4f1dfso9996670f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068254; x=1780673054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha0MKvEjPpqKYjU+TNR9cOwfxNwOYM3BFVBNkyNiIfo=;
        b=b6m+D/917yKTNJalPaMv8L4zKJZy1wW3PiDhwo8bForihN5BlFFSPc1/eDLZFuFs6j
         9a1vwh2fGpq7s+tNvdgrwCGQSHGArw9P1e8Kmy/Qwi0ME/K5gPDBaYLk833wfwg5IsyB
         0tWcVKoNRJewf/JWIiENtFW+b+1qIQBdqoCMtWmfYWVJ6nAK/Pl9jlIw+AEQlz7nQK+y
         6scRB/AsfdpD7iRwpS5rxBdYV2HcvY4fW5N8/ESh5K/38yRJClSwgyu68CStz0jkOazm
         kwuCBQU++EytNIMs9EAkw3S5b4h4Vf5NBa4k7m09nJf4C0HIidBHJYao5oeZvS2sfRzN
         mvDA==
X-Forwarded-Encrypted: i=1; AFNElJ8Pls66EN2VI9OM+D9FVGucWLpjh6O/x552/e569ab7drYS28FVBEcFi8sMEURn0tuianruFHLoQ5fQ2+oWYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgX3v7JSirkOG9uiVBkbGKOGftc/fgAW7/t4huu1ASyQ9t6WHu
	KsotNzXV/sPHkXQy6qYeXkgi/rn28jw2+Rz2OJgfBBv7NE2/aApbFXQvjNt9PeUCSffw6XWtNev
	6zk6IZwMFc4t9RmF6xyMrCHsbSv5NzR6XGDn8iY25giPBcJRlUoBR9OEKyFMqCuOSQCpx
X-Gm-Gg: Acq92OEsvC3UTad0i/CCymzLWkQ0xybAErrTXE/MzLDzxxCRs+YtRUC02pnuaWsmc15
	EJkbdwXzYrmAHrrIBYXwudikLY6fw0YYPkXhStC0BZfkuh5ajiySHL83YC0GM2tgHzYl6y/W572
	euThRSur9CWRbbULeymksQUHZ63bla/0/CoHlGs54jfAPyttkNCGcMDCsbeA2cn53QmRaS/tFJk
	Do0wCrqDXlgPtgZy9xtOmKwTRBYKUx0a9n7WhNAK8Q5o4Dbb6Mn716mfg2drqe3nYiLSJhEjxVl
	5LO0TXVdigkzIE++gJ+ZYEj7Vk8kfu3xU5JUCL2GcKp+l1lU0RY4iTLNBUoMYsX6aSHhVDVMGw9
	oClh1OalJQjFes0tnZinPAFN9TGVulZOXAB0UE8EqMkwvDazAVO+nHw==
X-Received: by 2002:a05:600d:640f:10b0:489:2005:b36e with SMTP id 5b1f17b1804b1-490a2941d4emr1179005e9.19.1780068253504;
        Fri, 29 May 2026 08:24:13 -0700 (PDT)
X-Received: by 2002:a05:600d:640f:10b0:489:2005:b36e with SMTP id 5b1f17b1804b1-490a2941d4emr1178125e9.19.1780068252950;
        Fri, 29 May 2026 08:24:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c103a89sm16422195e9.20.2026.05.29.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:24:12 -0700 (PDT)
Date: Fri, 29 May 2026 11:24:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v9 21/37] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <43b19542a07b568279d1a6e734d6729d347b78d5.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iKafPSFYHaFjWCzZOl_vt7-ZWdPm29vArsW-JAnU3hc_1780068254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add bool *zeroed output to alloc_hugetlb_folio_reserve() so
callers can check whether the pool page is known-zero.  memfd's
memfd_alloc_folio() uses this to skip the explicit folio_zero_user()
when the page is already zero.

This avoids redundant zeroing for memfd hugetlb pages that were
pre-allocated into the pool and never mapped to userspace.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/cma.h     |  3 ++-
 include/linux/hugetlb.h |  6 ++++--
 mm/cma.c                |  6 ++++--
 mm/hugetlb.c            | 11 +++++++++--
 mm/hugetlb_cma.c        |  4 ++--
 mm/memfd.c              | 14 ++++++++------
 6 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1..dee88909cf5d 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -53,7 +53,8 @@ extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long
 
 struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 		unsigned int align, bool no_warn);
-struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
+struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order,
+				       gfp_t caller_gfp);
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count);
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 49e5557d6cc0..3d23267014e6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -714,7 +714,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-					  nodemask_t *nmask, gfp_t gfp_mask);
+					  nodemask_t *nmask, gfp_t gfp_mask,
+					  bool *zeroed);
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
@@ -1134,7 +1135,8 @@ static inline void wait_for_freed_hugetlb_folios(void)
 
 static inline struct folio *
 alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-			    nodemask_t *nmask, gfp_t gfp_mask)
+			    nodemask_t *nmask, gfp_t gfp_mask,
+			    bool *zeroed)
 {
 	return NULL;
 }
diff --git a/mm/cma.c b/mm/cma.c
index c7ca567f4c5c..27971f6264ab 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -924,9 +924,11 @@ struct page *cma_alloc_frozen(struct cma *cma, unsigned long count,
 	return __cma_alloc_frozen(cma, count, align, gfp);
 }
 
-struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order)
+struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order,
+				       gfp_t caller_gfp)
 {
-	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN;
+	gfp_t gfp = GFP_KERNEL | __GFP_COMP | __GFP_NOWARN |
+		    (caller_gfp & __GFP_ZERO);
 
 	return __cma_alloc_frozen(cma, 1 << order, order, gfp);
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4ccf4eb91d92..649972101ace 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2208,7 +2208,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 }
 
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool *zeroed)
 {
 	struct folio *folio;
 
@@ -2224,6 +2224,12 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 		h->resv_huge_pages--;
 
 	spin_unlock_irq(&hugetlb_lock);
+
+	if (zeroed && folio) {
+		*zeroed = folio_test_hugetlb_zeroed(folio);
+		folio_clear_hugetlb_zeroed(folio);
+	}
+
 	return folio;
 }
 
@@ -2308,7 +2314,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		 * It is okay to use NUMA_NO_NODE because we use numa_mem_id()
 		 * down the road to pick the current node if that is the case.
 		 */
-		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+		folio = alloc_surplus_hugetlb_folio(h,
+						    htlb_alloc_mask(h),
 						    NUMA_NO_NODE, &alloc_nodemask,
 						    USER_ADDR_NONE);
 		if (!folio) {
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 7693ccefd0c6..c9266b25be3d 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -35,14 +35,14 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 		return NULL;
 
 	if (hugetlb_cma[nid])
-		page = cma_alloc_frozen_compound(hugetlb_cma[nid], order);
+		page = cma_alloc_frozen_compound(hugetlb_cma[nid], order, gfp_mask);
 
 	if (!page && !(gfp_mask & __GFP_THISNODE)) {
 		for_each_node_mask(node, *nodemask) {
 			if (node == nid || !hugetlb_cma[node])
 				continue;
 
-			page = cma_alloc_frozen_compound(hugetlb_cma[node], order);
+			page = cma_alloc_frozen_compound(hugetlb_cma[node], order, gfp_mask);
 			if (page)
 				break;
 		}
diff --git a/mm/memfd.c b/mm/memfd.c
index fb425f4e315f..5518f7d2d91f 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -69,6 +69,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 #ifdef CONFIG_HUGETLB_PAGE
 	struct folio *folio;
 	gfp_t gfp_mask;
+	bool zeroed;
 
 	if (is_file_hugepages(memfd)) {
 		/*
@@ -93,17 +94,18 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		folio = alloc_hugetlb_folio_reserve(h,
 						    numa_node_id(),
 						    NULL,
-						    gfp_mask);
+						    gfp_mask,
+						    &zeroed);
 		if (folio) {
 			u32 hash;
 
 			/*
-			 * Zero the folio to prevent information leaks to userspace.
-			 * Use folio_zero_user() which is optimized for huge/gigantic
-			 * pages. Pass 0 as addr_hint since this is not a faulting path
-			 *  and we don't have a user virtual address yet.
+			 * Zero the folio to prevent information leaks to
+			 * userspace.  Skip if the pool page is known-zero
+			 * (HPG_zeroed set during pool pre-allocation).
 			 */
-			folio_zero_user(folio, 0);
+			if (!zeroed)
+				folio_zero_user(folio, 0);
 
 			/*
 			 * Mark the folio uptodate before adding to page cache,
-- 
MST

