Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777734751B
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808882; cv=none; b=NEa5bcJJSRMa/RN/fMoEofRzkKi6Si+hj+fZs2NeQg4JfLFd1EA+vWof3lj22rPccMnLiBJwLZtc1spEliDmi9AW4gWkFrLrBjiHr5oS+93sPMsHnt4iGEvB+RgXlupqnm//lV5fKm1sJFqRmRQDEczbAwhsc/F5UywHMaq+33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808882; c=relaxed/simple;
	bh=9EKMu0q4T5CXWStF6YI05YDQp8pVyMFXjsLQILWW/H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LtREcne9shg2ctFXs+PK6o3LQajDtfabT9pEEwJVT4W86ZIF5h1d02GHs3Q0gb0o0xkXpSWlxVjSZwmt17YlXbdV1xPKVaUHk2aIBthg/T3I4ZGV/YaKUmEUvFELU+3YzKC0lDLzGRVPkqH37gUpSg8RDL0TEG37YGa+3nFVZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmbCov2B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmbCov2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/RSJYR+H+bpWdktahJfxrAiG8FsUf0fzB70AZgkr2Y=;
	b=ZmbCov2B+IikFfoVDAOL2g2TGpxi0QPNvHoOhKayuLFIK4CPrVhVeZ7QCHSBbQRSMzGyoX
	b2Qj8rlqee7a5JGPYfbM0ttj0t2ResMjZOWPKTpB+McXjgElatmWmI/Sia66Nv/zcUM7nj
	FVCjBd2/xQPgWYsBRuUCZfZrTQpzp7c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Z8T2L-F5Ofq0gTz9Zf2KFw-1; Tue, 21 Apr 2026 18:01:18 -0400
X-MC-Unique: Z8T2L-F5Ofq0gTz9Zf2KFw-1
X-Mimecast-MFC-AGG-ID: Z8T2L-F5Ofq0gTz9Zf2KFw_1776808877
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d03065782so3208260f8f.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808877; x=1777413677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/RSJYR+H+bpWdktahJfxrAiG8FsUf0fzB70AZgkr2Y=;
        b=iyDEi1ly7nKNFnmaRlFZbTDFSWhbJdBvuKyVOHplb3Zr/R+46WNzdqq8a2iLLy6Z5z
         260cRT8SHzs+RDA2gZctSOYKT5yUJQ69pwE6HgyuOuxhaL7xajqgehnG26/YQO+kDKIc
         NdWxTG533s5IbdC9GNh6Sae/Jl6dYxHFrTPBOduqym3Yqgb3gJe/D2PDrU53WDXZNlBC
         qbyTaa0n+ZzGueCTzqb/U3dzOD/lA3/OuJ7a79q/JzLE67HjWhQ4EfE32x5BdbOB1+Er
         YgTeD8Kppi97MtyESgjUa/14h0owJIpPs3cPfXJraRGan0ar9M8FCTOCjgfyWbH0+8RQ
         UZSg==
X-Forwarded-Encrypted: i=1; AFNElJ8fTDjfAdJRMKCibSsHaFsEn7OxtzvApN1WernWLO7X6ywma1dG+s5pmLmGVbjsRvEVBt9+AHlQsPsvbagb0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfNkEKrdtdE+y1IzAKcR88T5WktXjG6zMZcVaD9BINAyTqwnNx
	v6LDrVg7NHDCIK7LMOsENk4ndxvBXrCbzck4QqUs/G9Hh2EmdZkWg8eXW0Q/8eWl0FLzs85wTmc
	wjfaMZhH6QVz7EGju5CRFVHvi6FpppTXSogvfz5hXeb8wdUi8rJ9919FooqFGsZAadJeJ
X-Gm-Gg: AeBDievu1evI41uylF3dpgZImR3A1a1JQMdaU3CYHAxGOVKRedUFJU7G212813UwoRq
	K6unJfWScUSexmYgbv6DJ9UcjWGlGJSCXamVw8LgHlqN18T3CvKt/i8hEvdNr0P0vu+YAxHWnP1
	RH+p7ZXcXnsxWbmxcyOVnKevOd/e3dOlf2PcoaIsdRFZddM3NCb6hfd5cd24BRYDCoW2A6qZqwz
	HFMiqYYFYGJJuSQ8qOPfeXZms9YA9V2AYqgA0gbsHMILNc2JgiHIKDrGJJaBG8QEaXLfQROF3L9
	BUVC6qryIMKreW0NHdQ4B4UWF6bgLbJ/q9diZyONB01KM7OE+x0qHFRC++wxuDXMImVkdWnG53N
	GRMQrXbS6G1yeUK46aZagQCjaU52Rfx4ygQqtGMshEUUab+6xJ+F0KA==
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id ffacd0b85a97d-43fe3e120c6mr31540717f8f.45.1776808876642;
        Tue, 21 Apr 2026 15:01:16 -0700 (PDT)
X-Received: by 2002:a05:6000:40ca:b0:43d:70de:1c62 with SMTP id ffacd0b85a97d-43fe3e120c6mr31540636f8f.45.1776808875976;
        Tue, 21 Apr 2026 15:01:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm40811860f8f.12.2026.04.21.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator for
 cache-friendly zeroing
Message-ID: <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PSYPT8v2iRQOa4aMWd_T6AsOhEfey6O3c7FsnGXZOxg_1776808877
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Thread a user virtual address from vma_alloc_folio() down through
the page allocator to post_alloc_hook().  This is plumbing preparation
for a subsequent patch that will use user_addr to call folio_zero_user()
for cache-friendly zeroing of user pages.

The user_addr is stored in struct alloc_context and flows through:
  vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
  __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
  post_alloc_hook

Public APIs (__alloc_pages, __folio_alloc, folio_alloc_mpol) gain a
user_addr parameter directly.  Callers that do not need user_addr
pass USER_ADDR_NONE ((unsigned long)-1), since
address 0 is a valid user mapping.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/gfp.h  | 25 +++++++++++++++++--------
 mm/compaction.c      |  6 ++----
 mm/filemap.c         |  3 ++-
 mm/hugetlb.c         | 36 ++++++++++++++++++++----------------
 mm/internal.h        |  9 ++++++---
 mm/khugepaged.c      |  2 +-
 mm/mempolicy.c       | 39 ++++++++++++++++++++++++++-------------
 mm/migrate.c         |  2 +-
 mm/page_alloc.c      | 38 ++++++++++++++++++++++----------------
 mm/page_frag_cache.c |  4 ++--
 mm/shmem.c           |  2 +-
 mm/slub.c            |  4 ++--
 mm/swap_state.c      |  2 +-
 13 files changed, 103 insertions(+), 69 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 51ef13ed756e..10f653338042 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -226,12 +226,18 @@ static inline void arch_free_page(struct page *page, int order) { }
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
 
+/*
+ * Sentinel for user_addr: indicates a non-user allocation.
+ * Cannot use 0 because address 0 is a valid userspace mapping.
+ */
+#define USER_ADDR_NONE	((unsigned long)-1)
+
 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask);
+		nodemask_t *nodemask, unsigned long user_addr);
 #define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
 
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask);
+		nodemask_t *nodemask, unsigned long user_addr);
 #define __folio_alloc(...)			alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
 
 unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
@@ -286,7 +292,7 @@ __alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp_mask);
 
-	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
+	return __alloc_pages_noprof(gfp_mask, order, nid, NULL, USER_ADDR_NONE);
 }
 
 #define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_noprof(__VA_ARGS__))
@@ -297,7 +303,7 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp);
 
-	return __folio_alloc_noprof(gfp, order, nid, NULL);
+	return __folio_alloc_noprof(gfp, order, nid, NULL, USER_ADDR_NONE);
 }
 
 #define  __folio_alloc_node(...)		alloc_hooks(__folio_alloc_node_noprof(__VA_ARGS__))
@@ -322,7 +328,8 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
 struct page *alloc_pages_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *mpol, pgoff_t ilx, int nid);
+		struct mempolicy *mpol, pgoff_t ilx, int nid,
+		unsigned long user_addr);
 struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr);
 #else
@@ -335,14 +342,16 @@ static inline struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order)
 	return __folio_alloc_node_noprof(gfp, order, numa_node_id());
 }
 static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
-		struct mempolicy *mpol, pgoff_t ilx, int nid)
+		struct mempolicy *mpol, pgoff_t ilx, int nid,
+		unsigned long user_addr)
 {
-	return folio_alloc_noprof(gfp, order);
+	return __folio_alloc_noprof(gfp, order, numa_node_id(), NULL, user_addr);
 }
 static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	return folio_alloc_noprof(gfp, order);
+	return folio_alloc_mpol_noprof(gfp, order, NULL, 0, numa_node_id(),
+				      addr);
 }
 #endif
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..82f2914962f5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -82,8 +82,7 @@ static inline bool is_via_compact_memory(int order) { return false; }
 
 static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
 {
-	post_alloc_hook(page, order, __GFP_MOVABLE);
-	set_page_refcounted(page);
+	post_alloc_hook(page, order, __GFP_MOVABLE, USER_ADDR_NONE)
 	return page;
 }
 #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
@@ -1832,8 +1831,7 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 		set_page_private(&freepage[size], start_order);
 	}
 	dst = (struct folio *)freepage;
-
-	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
 	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6cd7974d4ada..bfc6554b993d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -998,7 +998,8 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
 
 	if (policy)
 		return folio_alloc_mpol_noprof(gfp, order, policy,
-				NO_INTERLEAVE_INDEX, numa_node_id());
+				NO_INTERLEAVE_INDEX, numa_node_id(),
+				USER_ADDR_NONE);
 
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0beb6e22bc26..de8361b503d2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1842,7 +1842,8 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
 }
 
 static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
-		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry)
+		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry,
+		unsigned long addr)
 {
 	struct folio *folio;
 	bool alloc_try_hard = true;
@@ -1859,7 +1860,7 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
 	if (alloc_try_hard)
 		gfp_mask |= __GFP_RETRY_MAYFAIL;
 
-	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask);
+	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask, addr);
 
 	/*
 	 * If we did not specify __GFP_RETRY_MAYFAIL, but still got a
@@ -1888,7 +1889,7 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
 
 static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+		nodemask_t *node_alloc_noretry, unsigned long addr)
 {
 	struct folio *folio;
 	int order = huge_page_order(h);
@@ -1900,7 +1901,7 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
 		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask);
 	else
 		folio = alloc_buddy_frozen_folio(order, gfp_mask, nid, nmask,
-						 node_alloc_noretry);
+						 node_alloc_noretry, addr);
 	if (folio)
 		init_new_hugetlb_folio(folio);
 	return folio;
@@ -1914,11 +1915,12 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
  * pages is zero, and the accounting must be done in the caller.
  */
 static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask)
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		unsigned long addr)
 {
 	struct folio *folio;
 
-	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
+	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL, addr);
 	if (folio)
 		hugetlb_vmemmap_optimize_folio(h, folio);
 	return folio;
@@ -1958,7 +1960,7 @@ static struct folio *alloc_pool_huge_folio(struct hstate *h,
 		struct folio *folio;
 
 		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
-					nodes_allowed, node_alloc_noretry);
+					nodes_allowed, node_alloc_noretry, USER_ADDR_NONE);
 		if (folio)
 			return folio;
 	}
@@ -2127,7 +2129,8 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn, unsigned long end_pfn)
  * Allocates a fresh surplus page from the page allocator.
  */
 static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
-				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
+				gfp_t gfp_mask,	int nid, nodemask_t *nmask,
+				unsigned long addr)
 {
 	struct folio *folio = NULL;
 
@@ -2139,7 +2142,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 		goto out_unlock;
 	spin_unlock_irq(&hugetlb_lock);
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, addr);
 	if (!folio)
 		return NULL;
 
@@ -2182,7 +2185,7 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
 	if (hstate_is_gigantic(h))
 		return NULL;
 
-	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
+	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, USER_ADDR_NONE);
 	if (!folio)
 		return NULL;
 
@@ -2218,14 +2221,14 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 	if (mpol_is_preferred_many(mpol)) {
 		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
-		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask, addr);
 
 		/* Fallback to all nodes if page==NULL */
 		nodemask = NULL;
 	}
 
 	if (!folio)
-		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
+		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask, addr);
 	mpol_cond_put(mpol);
 	return folio;
 }
@@ -2332,7 +2335,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		 * down the road to pick the current node if that is the case.
 		 */
 		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
-						    NUMA_NO_NODE, &alloc_nodemask);
+						    NUMA_NO_NODE, &alloc_nodemask,
+						    USER_ADDR_NONE);
 		if (!folio) {
 			alloc_ok = false;
 			break;
@@ -2738,7 +2742,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct folio *old_folio,
 			spin_unlock_irq(&hugetlb_lock);
 			gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 			new_folio = alloc_fresh_hugetlb_folio(h, gfp_mask,
-							      nid, NULL);
+							      nid, NULL, USER_ADDR_NONE);
 			if (!new_folio)
 				return -ENOMEM;
 			goto retry;
@@ -3434,13 +3438,13 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY], NULL);
+					&node_states[N_MEMORY], NULL, USER_ADDR_NONE);
 			if (!folio && !list_empty(&folio_list) &&
 			    hugetlb_vmemmap_optimizable_size(h)) {
 				prep_and_add_allocated_folios(h, &folio_list);
 				INIT_LIST_HEAD(&folio_list);
 				folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-						&node_states[N_MEMORY], NULL);
+						&node_states[N_MEMORY], NULL, USER_ADDR_NONE);
 			}
 			if (!folio)
 				break;
diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..0b9c0bd133d3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -672,6 +672,7 @@ struct alloc_context {
 	 */
 	enum zone_type highest_zoneidx;
 	bool spread_dirty_pages;
+	unsigned long user_addr;
 };
 
 /*
@@ -887,16 +888,18 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
+		     unsigned long user_addr);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
 
 struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
-		nodemask_t *);
+		nodemask_t *, unsigned long user_addr);
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);
+void free_frozen_pages_zeroed(struct page *page, unsigned int order);
 void free_unref_folios(struct folio_batch *fbatch);
 
 #ifdef CONFIG_NUMA
@@ -904,7 +907,7 @@ struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
 #else
 static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order)
 {
-	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL);
+	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL, USER_ADDR_NONE);
 }
 #endif
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1dd3cfca610d..f7e0f37f0632 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1055,7 +1055,7 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
 
-	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
+	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask, USER_ADDR_NONE);
 	if (!folio) {
 		*foliop = NULL;
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0e5175f1c767..ca2f430a7ffd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1454,7 +1454,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 	else
 		gfp = GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL | __GFP_COMP;
 
-	return folio_alloc_mpol(gfp, order, pol, ilx, nid);
+	return folio_alloc_mpol(gfp, order, pol, ilx, nid, USER_ADDR_NONE);
 }
 #else
 
@@ -2406,7 +2406,8 @@ bool mempolicy_in_oom_domain(struct task_struct *tsk,
 }
 
 static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
-						int nid, nodemask_t *nodemask)
+						int nid, nodemask_t *nodemask,
+						unsigned long user_addr)
 {
 	struct page *page;
 	gfp_t preferred_gfp;
@@ -2419,9 +2420,11 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	 */
 	preferred_gfp = gfp | __GFP_NOWARN;
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
-	page = __alloc_frozen_pages_noprof(preferred_gfp, order, nid, nodemask);
+	page = __alloc_frozen_pages_noprof(preferred_gfp, order, nid,
+					   nodemask, user_addr);
 	if (!page)
-		page = __alloc_frozen_pages_noprof(gfp, order, nid, NULL);
+		page = __alloc_frozen_pages_noprof(gfp, order, nid, NULL,
+						   user_addr);
 
 	return page;
 }
@@ -2436,8 +2439,9 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
  *
  * Return: The page on success or NULL if allocation fails.
  */
-static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
-		struct mempolicy *pol, pgoff_t ilx, int nid)
+static struct page *__alloc_pages_mpol(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid,
+		unsigned long user_addr)
 {
 	nodemask_t *nodemask;
 	struct page *page;
@@ -2445,7 +2449,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
 	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		return alloc_pages_preferred_many(gfp, order, nid, nodemask,
+						 user_addr);
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2469,7 +2474,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 			 */
 			page = __alloc_frozen_pages_noprof(
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
-				nid, NULL);
+				nid, NULL, user_addr);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
 				return page;
 			/*
@@ -2481,7 +2486,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		}
 	}
 
-	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
+	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, user_addr);
 
 	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
 		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
@@ -2497,17 +2502,25 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 	return page;
 }
 
-struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		struct mempolicy *pol, pgoff_t ilx, int nid)
 {
-	struct page *page = alloc_pages_mpol(gfp | __GFP_COMP, order, pol,
-			ilx, nid);
+	return __alloc_pages_mpol(gfp, order, pol, ilx, nid, USER_ADDR_NONE);
+}
+
+struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *pol, pgoff_t ilx, int nid,
+		unsigned long user_addr)
+{
+	struct page *page = __alloc_pages_mpol(gfp | __GFP_COMP, order, pol,
+			ilx, nid, user_addr);
 	if (!page)
 		return NULL;
 
 	set_page_refcounted(page);
 	return page_rmappable_folio(page);
 }
+EXPORT_SYMBOL(folio_alloc_mpol_noprof);
 
 /**
  * vma_alloc_folio - Allocate a folio for a VMA.
@@ -2535,7 +2548,7 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct
 		gfp |= __GFP_NOWARN;
 
 	pol = get_vma_policy(vma, addr, order, &ilx);
-	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
+	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id(), addr);
 	mpol_cond_put(pol);
 	return folio;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 1bf2cf8c44dd..df805a763991 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2202,7 +2202,7 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
-	return __folio_alloc(gfp_mask, order, nid, mtc->nmask);
+	return __folio_alloc(gfp_mask, order, nid, mtc->nmask, USER_ADDR_NONE);
 }
 
 #ifdef CONFIG_NUMA
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4b6f1a554e..1cf5551849fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1837,7 +1837,7 @@ static inline bool should_skip_init(gfp_t flags)
 }
 
 inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
+				gfp_t gfp_flags, unsigned long user_addr)
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
@@ -1892,9 +1892,10 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-							unsigned int alloc_flags)
+							unsigned int alloc_flags,
+							unsigned long user_addr)
 {
-	post_alloc_hook(page, order, gfp_flags);
+	post_alloc_hook(page, order, gfp_flags, user_addr);
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
@@ -3959,7 +3960,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
-			prep_new_page(page, order, gfp_mask, alloc_flags);
+			prep_new_page(page, order, gfp_mask, alloc_flags,
+				      ac->user_addr);
 
 			/*
 			 * If this is a high-order atomic allocation then check
@@ -4194,7 +4196,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	/* Prep a captured page if available */
 	if (page)
-		prep_new_page(page, order, gfp_mask, alloc_flags);
+		prep_new_page(page, order, gfp_mask, alloc_flags,
+			      ac->user_addr);
 
 	/* Try get a page from the freelist if available */
 	if (!page)
@@ -5187,7 +5190,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, 0);
+		prep_new_page(page, 0, gfp, 0, USER_ADDR_NONE);
 		set_page_refcounted(page);
 		page_array[nr_populated++] = page;
 	}
@@ -5201,7 +5204,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed:
-	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
+	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask, USER_ADDR_NONE);
 	if (page)
 		page_array[nr_populated++] = page;
 	goto out;
@@ -5212,12 +5215,13 @@ EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
  * This is the 'heart' of the zoned buddy allocator.
  */
 struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
-		int preferred_nid, nodemask_t *nodemask)
+		int preferred_nid, nodemask_t *nodemask,
+		unsigned long user_addr)
 {
 	struct page *page;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
-	struct alloc_context ac = { };
+	struct alloc_context ac = { .user_addr = user_addr };
 
 	/*
 	 * There are several places where we assume that the order value is sane
@@ -5277,11 +5281,13 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 EXPORT_SYMBOL(__alloc_frozen_pages_noprof);
 
 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
-		int preferred_nid, nodemask_t *nodemask)
+		int preferred_nid, nodemask_t *nodemask,
+		unsigned long user_addr)
 {
 	struct page *page;
 
-	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask);
+	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid,
+					   nodemask, user_addr);
 	if (page)
 		set_page_refcounted(page);
 	return page;
@@ -5289,10 +5295,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 EXPORT_SYMBOL(__alloc_pages_noprof);
 
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask)
+		nodemask_t *nodemask, unsigned long user_addr)
 {
 	struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
-					preferred_nid, nodemask);
+					preferred_nid, nodemask, user_addr);
 	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(__folio_alloc_noprof);
@@ -6910,7 +6916,7 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
 		list_for_each_entry_safe(page, next, &list[order], lru) {
 			int i;
 
-			post_alloc_hook(page, order, gfp_mask);
+			post_alloc_hook(page, order, gfp_mask, USER_ADDR_NONE);
 			if (!order)
 				continue;
 
@@ -7116,7 +7122,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		struct page *head = pfn_to_page(start);
 
 		check_new_pages(head, order);
-		prep_new_page(head, order, gfp_mask, 0);
+		prep_new_page(head, order, gfp_mask, 0, USER_ADDR_NONE);
 	} else {
 		ret = -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
@@ -7781,7 +7787,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
 			| gfp_flags;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
-	struct alloc_context ac = { };
+	struct alloc_context ac = { .user_addr = USER_ADDR_NONE };
 	struct page *page;
 
 	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e..bcd3d1aa8589 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -57,10 +57,10 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
-			     numa_mem_id(), NULL);
+			     numa_mem_id(), NULL, USER_ADDR_NONE);
 #endif
 	if (unlikely(!page)) {
-		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
+		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL, USER_ADDR_NONE);
 		order = 0;
 	}
 
diff --git a/mm/shmem.c b/mm/shmem.c
index b40f3cd48961..896cef466b0c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1927,7 +1927,7 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
 	struct folio *folio;
 
 	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
-	folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id());
+	folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id(), USER_ADDR_NONE);
 	mpol_cond_put(mpol);
 
 	return folio;
diff --git a/mm/slub.c b/mm/slub.c
index 0c906fefc31b..fc8f998a0fe1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3266,7 +3266,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	else if (node == NUMA_NO_NODE)
 		page = alloc_frozen_pages(flags, order);
 	else
-		page = __alloc_frozen_pages(flags, order, node, NULL);
+		page = __alloc_frozen_pages(flags, order, node, NULL, USER_ADDR_NONE);
 
 	if (!page)
 		return NULL;
@@ -5178,7 +5178,7 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 	if (node == NUMA_NO_NODE)
 		page = alloc_frozen_pages_noprof(flags, order);
 	else
-		page = __alloc_frozen_pages_noprof(flags, order, node, NULL);
+		page = __alloc_frozen_pages_noprof(flags, order, node, NULL, USER_ADDR_NONE);
 
 	if (page) {
 		ptr = page_address(page);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6d0eef7470be..12ac29ae818c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -568,7 +568,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 		return NULL;
 
 	/* Allocate a new folio to be added into the swap cache. */
-	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
+	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id(), USER_ADDR_NONE);
 	if (!folio)
 		return NULL;
 	/* Try add the new folio, returns existing folio or NULL on failure. */
-- 
MST

