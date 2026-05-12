Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E303CAA5D
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620015; cv=none; b=UG5a2598hLYIuAlJjVtXfSp/uEV2n3Lw21Xg1CeLSkRaD98XqxAsUIpXENlsvgVyhTtTXDtpjNRJjv8eTkiyeiYYBJreol/UpzaI4oZ7Y40Ehhup3vLEYhmYDgW/bhseXghTiJp8R18k+p+vMYs0j7A0jNQx40t/R8MoXCWCcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620015; c=relaxed/simple;
	bh=yxS5pGAT+aBz/tCSPnjyQeoSUdyPcongdUsCoZ0a1X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CsWjq3nO8VD0wv1TYnN7r5kt9Y9qBtZyRsKGfAdZQ9OUqyODZ+FBQG7xzIrb7KYzpf5u2mtxO0xHNBDEEr+w14Fz3IZCldQQcMEtsCokmXMPO8er6X45ob2QYys1ALYZoyieYoyy7QD8AKrm/I+41NhRumxUoJ52W2Gsb+arwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFmS8R6J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFmS8R6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgzEDqlvhoYP0aAGYME8rWUPvmasj5/ucpL5w8urRD4=;
	b=jFmS8R6JlLuH1HXY9feFl07Mh/xBaoyFrHNn/eevqYhfNJrld3py5jWfrQaN1MFK7g2ljO
	6gZtA807k8aALNbK8VPpR3lIaHokJC8g1XvofHCLs0aDSGfJJcKiC3fXlAsR6FdvKcHzZX
	mcmtKlG/WpqVwQkFgI/IocO8mpbNizQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-jHNJTphcNXyPD-UJLOEYtg-1; Tue, 12 May 2026 17:06:52 -0400
X-MC-Unique: jHNJTphcNXyPD-UJLOEYtg-1
X-Mimecast-MFC-AGG-ID: jHNJTphcNXyPD-UJLOEYtg_1778620009
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so53152005e9.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620009; x=1779224809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgzEDqlvhoYP0aAGYME8rWUPvmasj5/ucpL5w8urRD4=;
        b=fcQut6o2wat2n5hykTMI5qnB6D2t/A499/8UCGqdG9XSs0kvRehtQEMkrCtR25pDqa
         zJ77HPCpuJY596zWZau3066z04ene1Gciy7yUvreQGISr0vAMJ/+p3A6BOPsJSudt2/m
         RhFoJDxnGG7Ek0qsUTLBa2iSqGB6f5ryqpv2n9eCyrv1AXQCUbhca5TdXSCvrD96gBBT
         lIoAcxbyFvR0stnYMl/NyL5fUJ8H9LQl+jfkwMNbE8DIA2WeryLsIm4IQ05sAAC1LSPa
         Lhizygn+sD/LONsxPeVJceBcB4L59z8AiJJIUfsOBRPx+hscMLlPcpliaORlx+Ij9tky
         YNAA==
X-Forwarded-Encrypted: i=1; AFNElJ/ZW8WDlZ1K/1SR7xRlVtmjlVeSlQmdojU5wq7Z47ShmF3q1oRsqrQewLouz+i3gVn8K86n7uLasrPBXAb1gQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz11FfJgVUC/yIbjGF+jxrNcClYi2cYWn+v7jrQje4y3nSdT5XU
	4VLXNXer4/0T1tG/s2RBcGhPZn/k7iF3PatKHSx+4ExLkWr9+1PLjyCMY5OG+USvxCxWF7qBiaX
	OVtkYeqitDRgJPjpx1mNXMDjJfqWW4ndvETaAPUsDp8S2QgaR6FYAMwc/5hxNfLv+If3h
X-Gm-Gg: Acq92OHYp5CJ6xQ7cLv8bBNgp3FWzBKI49qXyN16WvGXF8AcjLHaa7AGSYe1WQqlRQt
	FzXYhy4OhGsQkR5DJHNO+4z0pQhAO4RPhuxRP7nKpwGG7rk69I+P/kQUQaTtFbM/fddA8FOaPrx
	EnuI7CvPuB/Viti1HrttSkRn5s8TaywXT/LcZHsdLCumYbETHtHaqkOEqI6e7Obc1qU9W7iKqDF
	LzjCcrTtzecJ+pI992h8NPHaYqlRCTYRU0aAqqiNjvWrumXewae+3X98qqqNEfGhiFXVJ6JiP8q
	v342/rFciTBlEKTPW4SmDt9ND7ynR0i1Ff4VtiAW1P5wB8BQd3WVht0VW+mSlxt5mF04yG89hMD
	sMskr1mRNFnYMhU43Osazo+tsfXgcy3PUVbOuspj4
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr7783545e9.0.1778620008855;
        Tue, 12 May 2026 14:06:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr7783135e9.0.1778620008280;
        Tue, 12 May 2026 14:06:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce065732sm23005e9.6.2026.05.12.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:47 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:43 -0400
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
Subject: [PATCH v7 18/31] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <0ec51a9091b5ed3f61a49935953dd537d6c87428.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AdoCQqW_4WbsFPd7Fi41YyYs_WfLFd6yVXTCa1euPU4_1778620009
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gather_surplus_pages() pre-allocates hugetlb pages into the pool
during mmap.  Pass __GFP_ZERO so these pages are zeroed by the
buddy allocator, and HPG_zeroed is set by alloc_surplus_hugetlb_folio.

Add bool *zeroed output to alloc_hugetlb_folio_reserve() so
callers can check whether the pool page is known-zero.  memfd's
memfd_alloc_folio() uses this to skip the explicit folio_zero_user()
when the page is already zero.

This avoids redundant zeroing for memfd hugetlb pages that were
pre-allocated into the pool and never mapped to userspace.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/hugetlb.h |  6 ++++--
 mm/hugetlb.c            | 11 +++++++++--
 mm/memfd.c              | 14 ++++++++------
 3 files changed, 21 insertions(+), 10 deletions(-)

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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2ea078d4e5a8..0a19a078d860 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2205,7 +2205,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 }
 
 struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool *zeroed)
 {
 	struct folio *folio;
 
@@ -2221,6 +2221,12 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
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
 
@@ -2305,7 +2311,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
 		 * It is okay to use NUMA_NO_NODE because we use numa_mem_id()
 		 * down the road to pick the current node if that is the case.
 		 */
-		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
+		folio = alloc_surplus_hugetlb_folio(h,
+						    htlb_alloc_mask(h) | __GFP_ZERO,
 						    NUMA_NO_NODE, &alloc_nodemask,
 						    USER_ADDR_NONE);
 		if (!folio) {
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

