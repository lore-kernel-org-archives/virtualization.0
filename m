Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEC3D413B
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489690; cv=none; b=Yz413nazpAKx+a9Wcr5UZcK4T3ZBbZFx8pQ0rBzaw22lmFPkgnsFL3aQQb4Y1EcgbgeiySNyB28eu1dEnSeRCxb2mrHXsT06A3cD0C84yC8j8kmOfhM0draO07VNZLV2d3wxf+ERITdzeLZhZJDYjnKJ5I007vxBlL08HBypoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489690; c=relaxed/simple;
	bh=uae5V1T54mMZVBXPfWqdPxGd95+bgq8V6VITT9f8SnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hixa8uIy9TGrfbvYHLfOuNOIH/p/eT/iBZlEMTCZ0mkoJxTsla/nMPpykM5T5cnPhaWaAr/Z5QJjKoKl8irJfurO6FHmcT5JVkmGHjKvh9h46yDKCrNzDQbbQVwm0TZYXuwZWtiRQ6ePZ5Iv8j3EPbZmIJQlkjvsPFGvzTFKOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/FvhzjW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/FvhzjW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0Jd/7EvCnA8N9ANiNsWM9FOCa/+r1oqSAVkRa3NTmw=;
	b=c/FvhzjWE6oV5T3O3TugyXPiRGcmr4vwSVuzokUs0bkIbF0Mz7yAL0QiTnvp5cEQa4ZpFU
	UM0VFZaiE+SMfAQqoJd29d664K7T6WScG0Zh3sogp/9JbeqILLhXZwb5gBImjwqMn1H0SJ
	SeL/xSATGll+WLE6t6OlemkQWWvDopI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-f570m6TOOFm-teGI4TgAwQ-1; Mon, 11 May 2026 04:54:46 -0400
X-MC-Unique: f570m6TOOFm-teGI4TgAwQ-1
X-Mimecast-MFC-AGG-ID: f570m6TOOFm-teGI4TgAwQ_1778489686
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so3202548f8f.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489685; x=1779094485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Jd/7EvCnA8N9ANiNsWM9FOCa/+r1oqSAVkRa3NTmw=;
        b=SQL6tyoCxdooujeC+qCkg/ss8oFs/2U50M1mMgLuS3tkeEklLNoyuXGI/7uVoGRzfF
         YkGvT21nBQOuNEYfoZLTJBR3QFMc8unV6Amu53X8xscHCaj8rMOOfdbPaBU6yLN/wI/6
         ZPdqV8sweLV/pKhO9zbx8koJgt4f0z1Fkb5WjVIcBuKUVsZJUboAtRollzIk/gz79sc4
         L8uUCirtKX05gLTp41ynE9cIY3DxaUYhwG3bpgfUL0qBMt9Rtq7M7i4m9X304lEmeP4K
         MiOz9+bFkbRWP2d/qN/1Kfq5cl7lyVBSlhK1DSIEz6X90opRGDRvrKV01+kAoNuHyCix
         jkaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5ieTcG0UapeUdmVynpA+TD04krRkEoODvmPi2iPPcssRDFc8hASk52C32PkdzAkfXvjfwVzZi/KoCbJc8yA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy+4rG5APWf761h7YCizd/oFs0GYQcupbbbsVqKkZUmSSyfchm
	T92r5OWoSw1FnnDLsCa69awcCGg8QGNuAHWH8c+3jZLsgWgKco+vyONJIgRqcwbQngzs1YP9TOt
	HJuK9QNIu86nTICXocXxmBovWy279R1o+BOZiJP3Ss7uq17dbBX1EYIEx5hhHwPgOYRWn
X-Gm-Gg: Acq92OEI6MgaiAgez/GOihJbvAw/CPI8d40qJNL/KjeYfXDR4Ce1z4eSps7vzamRtHE
	aZ0FLi3AHozdBbKUXqPhabLb8jkGo/uALPN/cb8h+RiT7u/2mxMthSUrtFa6K3vIQCsyYors4yV
	mqITNDGv2vYkn3XaCpdbzNtLwIH+KzX6TMg0IWW6COV1onwuEHa5j+yFtfixPBRzSlHp0zad3hW
	BysxdURCz9qIdaQDJCAKfNfT/esT5f7SFbvoTfHCTYi9Eb+kbWU3CFbw8rkqZ8l3xfTq34PSyUw
	87TrqkyMWjgYeFUKX+uPc/fWum/wxLiRrZStisTN7LPOeLSqMgLXUhhydUcLhnXJTnerIDWs0qa
	YXkpAQQ1WbVN013xE9Emao7h0ifHpe2grHe5dYJBsQmqpkNCTmJ4=
X-Received: by 2002:adf:e905:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-452eaa28388mr19585534f8f.31.1778489685352;
        Mon, 11 May 2026 01:54:45 -0700 (PDT)
X-Received: by 2002:adf:e905:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-452eaa28388mr19585465f8f.31.1778489684785;
        Mon, 11 May 2026 01:54:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a68ebsm22598211f8f.1.2026.05.11.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:44 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:39 -0400
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
Subject: [PATCH v6 15/30] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <a39ab8288aceb244bdb31141aa9cf67106c0e042.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2zj4lYFHerZulEWlwOvVBljcF1vofruALt4HjSU-bmE_1778489686
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

