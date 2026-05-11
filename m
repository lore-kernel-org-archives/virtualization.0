Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47B3BFE42
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489685; cv=none; b=DX/Iq4Vj3bfYINOZ00Z3WbaJgWwLkStcCWs5uZ0EYKjaQaQbbrGoMu4MlU8O0Wornvt3rGifjU2xZxJ4MFgw+CCi8UqR2nbttXpvBgfXMgk5gdpdCTXssQyX5WZwRxu3jjgsS1Cf0IFiX6pViw5F8MfAgT5bvMWpHtwL4CMtAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489685; c=relaxed/simple;
	bh=uae5V1T54mMZVBXPfWqdPxGd95+bgq8V6VITT9f8SnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i8GFr0zMDqhPU1lGiRrA0mA3ruoKuiKAkn/PpwYcvZ69NFWBcTcaUvsMUUdtfP9Ha1C9YF9LMJr5Qv30dfyXj/HlH9OeC6vGQE8VzypLkFFWGY/NbVUB0LGaoJwLsVtwN19uxeMNXyXvjqEGKlWATxxIOR828WZ+TZvvYq9GiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcCmkCae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcCmkCae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0Jd/7EvCnA8N9ANiNsWM9FOCa/+r1oqSAVkRa3NTmw=;
	b=BcCmkCaeYICE+zznTb7akuTOjhSSnILtyzhF+Y5zpQSaWwX3C07rn/HqSoFEUclb3ozGlJ
	gm2fLNp34gR5rMNkyyJV04fX4jBTgB3X0AH9UjsNnfn0vUXgEJ9UcYAQ837E7TafXQ9hTt
	ILOc27xGrwtY2F2nC6rRQPV839K2atY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-7K7qT2LyNNCBNaInSk_yHA-1; Mon, 11 May 2026 04:54:41 -0400
X-MC-Unique: 7K7qT2LyNNCBNaInSk_yHA-1
X-Mimecast-MFC-AGG-ID: 7K7qT2LyNNCBNaInSk_yHA_1778489680
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso24285525e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489680; x=1779094480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Jd/7EvCnA8N9ANiNsWM9FOCa/+r1oqSAVkRa3NTmw=;
        b=MRZvvlZpXgBq10j5u3G8TGcym2CKyk0aBdA0KSQt0sdu87iz3pgTLVsEdg4dcdT2lG
         eyiwzrJ8Amst8o5c24MBKAPqwenh2x/YrNDkwwmeDanmO6eA6BRx3Ll+oTGHJyNVMGt6
         f3xlvfGrPhx0BVqpG3DiP0E60ek4vA0E7mgxemVHugY8rZUYRv9OleTyfNn5qalrfmRt
         LHkJBmWYZVoK7bUqwrIAE/DZIx8MWEfLJNZzeqq3zcxzIZaP0JTvP1DQWUcvc4UIwaTD
         HwsMiMvOlR18zEM4mj3dhx0ueRrF53WdVRroQoUDs5nKad0fLtlcGoGIH9ZDS5x/+bp7
         oKSA==
X-Forwarded-Encrypted: i=1; AFNElJ+hMVlWp1JeNIowvw9lXK4ZuTeXGbskhbG0K/F4Uy2GiZzdYT+JIgVbGS/MP4qOP2H7wjxHCPSaIXUe2P9BRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmcACt+mHK03T9zwd8IfT4TOmWVvssyGMGqjuv08GxqARqJTlm
	AdFh3HhZeK7EYuyuas645k6EXpRcrlNIrLqKZ8fuuRsB1zL86CZam75Xkyteg6UcW8bDlQtUNFI
	+K0XrEdgQfjpH/YMy1JziUBUPt2fViLEKNVej07XUeN5mH9fLVzerokjH4mnL31S+MY5b
X-Gm-Gg: Acq92OEB9/t9knSGyhlega5v4177b9WLlOntduzLbTdJ1rEhk0+shSZh31lZrRfdnU4
	a7ejTnIdJrUPg9S/ZCYfnkgGB0y73YdUgmGBSQrPE7ARaVHbvaI8PnCU7ObIpMgpq/xfbGHNseX
	Mzaw/qbip0YWo6KgwDY3/y5s1yQmZGpVP/N1ze6goD1YLiEGHzZg8moZV0KodqZi1Zbi+OLYmkq
	8iTI/iHl+swiW3HqVXStuVqwkaeQDGia38Fvl52wOZ2VW9+H8Xxz34qGX9U4GlMy+UOHO7lghbY
	oFLxbw3rODQjRudgG77fKa1PIevcSrMouXUR6/ME1989ob4hSIUWOltGWMXXlo9zKkufTWH16U5
	0fOvSsxW4RE7D3XtR+c64HzK5x+yj3xlsEa783pqR
X-Received: by 2002:a05:600c:c094:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48e51f40a29mr268729135e9.23.1778489680008;
        Mon, 11 May 2026 01:54:40 -0700 (PDT)
X-Received: by 2002:a05:600c:c094:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48e51f40a29mr268728595e9.23.1778489679389;
        Mon, 11 May 2026 01:54:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dafa6c2sm81289945e9.5.2026.05.11.01.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:38 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:34 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH v6 14/30] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <8f111e92b512bf59570021fc0e71eef013289992.1778487000.git.mst@redhat.com>
References: <cover.1778487000.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778487000.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GAY3HSs2fZ70KVo3mkOWvs5dlaAglbGjmeynQBEpgCQ_1778489680
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
index 950e1702fbd8..c4e66a371fce 100644
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
@@ -1142,7 +1143,8 @@ static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 static inline struct folio *
 alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
-			    nodemask_t *nmask, gfp_t gfp_mask)
+			    nodemask_t *nmask, gfp_t gfp_mask,
+			    bool *zeroed)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8710366d14b7..03ad5c1e0655 100644
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

