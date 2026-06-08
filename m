Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAD3BFE25
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907999; cv=none; b=XWeobp7Js7GU4nasCYw8BVip1bBlCIP3uslQcVcovr7D3b7h12lJwONPH578zbC8Q3cQ9QiazVSEr6uwinFqNrrNkLBpqHIY7XActjAgfiEG9PSveID2ne5kjyROCSmn1SbyOAhAWtv05DmyIdDihhEdwOMHSfoOjwG5L+d5yMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907999; c=relaxed/simple;
	bh=uD9B0Z2r8dApvmwrr4a0YLqj2hTMaiDgCysJxcZ5WsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A8LxwOMMvoq4RmebEbSIxp9FDH+hXPhe5mr1iEuFWjugI/VQPTJt5audPfPe0hqDApFDVY+R6y7wrP7Xa2u8mjgYiq3HJZI73GXbBoMz2p+qf57bHmFK8WcL86mFv6KaXDNfjouhMMQS9Cu2WiIyqwwi0FFKK+OGseZYezVZgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLusyw+I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLusyw+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScAoSfQrcD4R0Yhb9nAUBLjdu8qZL5GRGpRfEb8F90Q=;
	b=YLusyw+ItlQxXrA/V/CSRHNVyYJhcjmE9XsqoXfMKtwfzLZ8F7PatqWgdF9b640qNEvgHk
	nPS/GWUMDha/7mjHYfOQKIIVe0PiYNys9zlmNP5WHAqIXOPQzQa0VBXuUakRAADfMLdjNY
	Jl+XnC/uPWrhdDNZWrvMSkuCr6AFTcc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-YJ2RhuwHPxqg1PyORZwTXA-1; Mon, 08 Jun 2026 04:39:50 -0400
X-MC-Unique: YJ2RhuwHPxqg1PyORZwTXA-1
X-Mimecast-MFC-AGG-ID: YJ2RhuwHPxqg1PyORZwTXA_1780907990
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b3ec3f7fso27085515e9.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907989; x=1781512789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScAoSfQrcD4R0Yhb9nAUBLjdu8qZL5GRGpRfEb8F90Q=;
        b=LeVoHnImoklrhZFkKQ/nndI3GIVb//PwS1lxrWgtFsWONDNx46pb5hoeL5SQ0a1/JO
         W0M38lVujyLT4IZ11UKQE4v0nouHrRiw1eoeu0TAyZG3S1WPRVR23Rdq93izrufe23sA
         Jt03Zn5cSZr+BCh7oMXsbmPT+t/yvVLHw4whJ6sMco/WPrn0o0AQ0FMI0HQRHaPJiiBf
         cfm9Ba0XEvPWh8JwKcRwF4+qjNVGjmvbzR5DxxSBPd2v0RJShikA9mmaYmFzzVVf7Vhq
         5bNOeXbT1J/3NpRqoubE52JAWENdtA5wr5YcCoAxc+sJeU7Ub91Ro0cLjK/48fetYWGg
         yXjw==
X-Forwarded-Encrypted: i=1; AFNElJ8R2UAEbFTkXR7Bj9MdzrUg0jSWG66b7TYqGDCiefQKLdlUDJQT+1gAUgJdly1jlc6Ric2dzNdgJtYxjJ6/Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnlHiSyPcDye+U0+tmPOWrHL+xc1tYJmxWJkgufOksbmYttzhN
	HqcuO9pzZFmjUO8H8zJYucCcPZKxORgIM6gaCLXlXP1dMirs456HcXqK2jYhn7xf3Zdz+qrpomt
	GG/tYw6qkf2jgH+YE2NBtUDOjJDnXaLbvm42S4j/E+ENayeWFRiSw599BU1mN+Qu/Dnsp
X-Gm-Gg: Acq92OE8KC4IJPQtAnGEy7TUN6EsCj5ehRAu14GEIgDj+t+0qBoJ47W45gxmGP8F7Hk
	kiMCO+fKNtSnjugmVbcuHL2xGIJTHaumkDoUFVVonPW7HLours3lvs11qdkplSc/Qi0pb9sOr+o
	CTmNb8cd894k2yJvOpPUelVvy1cig+7hGM0HSCB/RMPx5Ki/JI3rZJvw+WG+uUGLFFca17jfjNO
	ZDto/ogLpzttvFtJBozzeAIO0rTNRXEoWBp/KvSdg/dA8jC3y6Edxz4McxIJCp7PnbRsDCeBCaQ
	q23xOaapCjGdAs7eLtZnFvjSPLAKi+Hcmpwj8DvSUrUq1EHLL4SUiHNSbxbUoGbTnOTVgy4Xv9Q
	O0BpVgH5pkmcYqRYB9+GOIcg=
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490c25f67d9mr239704965e9.26.1780907989484;
        Mon, 08 Jun 2026 01:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3e15:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490c25f67d9mr239704145e9.26.1780907988974;
        Mon, 08 Jun 2026 01:39:48 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm356783495e9.10.2026.06.08.01.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:39:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:39:37 -0400
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
Subject: [PATCH v10 29/37] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <0d6c2d31f48ff454223ad4f1d37ef7b73263bf5d.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B4GSJJCXc_AfMACBjY-OVT4_6B4X_O-slJrvm92wYSs_1780907990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add bool *zeroed output to alloc_hugetlb_folio_reserve() so
callers can check whether the pool page is known-zero.  memfd's
memfd_alloc_folio() uses this to skip the explicit folio_zero_user()
when the page is already zero.

This avoids redundant zeroing for memfd hugetlb pages that were
pre-allocated into the pool and never mapped to userspace.

Note: HPG_zeroed is currently only set for surplus pages
allocated with __GFP_ZERO (via alloc_surplus_hugetlb_folio),
not for pool pages from alloc_pool_huge_folio. So the
zeroed output from alloc_hugetlb_folio_reserve is typically
false for pool-only reservations. It becomes true when
surplus pages fill the reservation. The addr_hint 0 passed
to folio_zero_user is acceptable for memfd: these pages are
not mapped yet and will get proper dcache handling at mmap
time via the page fault path.

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
index 06d033a57a61..7eb529eabe99 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -708,7 +708,8 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask,
 				bool allow_alloc_fallback);
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-					  nodemask_t *nmask, gfp_t gfp_mask);
+					  nodemask_t *nmask, gfp_t gfp_mask,
+					  bool *zeroed);
 
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
@@ -1128,7 +1129,8 @@ static inline void wait_for_freed_hugetlb_folios(void)
 
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
index ed00db703911..a087e915783f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2196,7 +2196,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 }
 
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool *zeroed)
 {
 	struct folio *folio;
 
@@ -2212,6 +2212,12 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
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
 
@@ -2296,7 +2302,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
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
index abe13b291ddc..a99617a62e33 100644
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

