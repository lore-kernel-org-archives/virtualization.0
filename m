Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC033CFF5A
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490199; cv=none; b=QDKC8lEZGgyzPYJ9RxoHIMhlw6ld4xhh4aO/8KVidprxocZhQZTcmwNRZ14qoegllggowYiBEwCG+JTQbl8lZkHNeDz6lTsTeNOikBHLXQvtPdJLa8BWZy+kS22JAad0CIAXrai2Iki0OZoailE/mUFKnOtegVc4hGnP/le/hNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490199; c=relaxed/simple;
	bh=uae5V1T54mMZVBXPfWqdPxGd95+bgq8V6VITT9f8SnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=a0lDcho4WtFPeOX2Ny8KfpLey0MK85s3NsF1+aDvMXzycw5iY9sp9ZaoNTiRxICczQcujHM1oNO5nxR0GcL7tmbXEqpp/TIBLi3yHQ5TMiT+1O7eiTFLX3Zh5S3dh+/Ztanx01QIEG0nSR42M2Tb1Btk9W6z77r3xwaOe7fAlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8Z9UsVL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8Z9UsVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0Jd/7EvCnA8N9ANiNsWM9FOCa/+r1oqSAVkRa3NTmw=;
	b=O8Z9UsVL9FiHBrcjrZPDG+zj+AaP7X5VPhb1hKGpGPR/OHbHI5zwpdcR2m200/HG0QcPt6
	w6jYOmRthIlwpcJohYBalhu2ha4U1RwvTiuJYueNEpTuCtYUq7nlL9kCetNnZRzg3WaDN2
	h5iV/5eQni2ukef/0/YDpOjn7GuB8r8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-0RChoY3NOTeEr347eNsvRA-1; Mon, 11 May 2026 05:03:15 -0400
X-MC-Unique: 0RChoY3NOTeEr347eNsvRA-1
X-Mimecast-MFC-AGG-ID: 0RChoY3NOTeEr347eNsvRA_1778490194
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d035e8593so27918175e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490194; x=1779094994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0Jd/7EvCnA8N9ANiNsWM9FOCa/+r1oqSAVkRa3NTmw=;
        b=KHWTURXxSRUw0vpBXuin6CXKZcX1yVszXBtTaVSphIVi0LHEE9itMLlrA79Ru6tgPj
         scBWTeQc9J/Ycg/OxAeQtYl2lQYoc88dRI7YQON2YBIC/Yyakm1VVYK4bNu6Ac37hbK4
         02cu7PADZQECl5WCGU4QRBRMjzxR/ilfwpGXBAXPvXmWWVHK3fg4q6GV882aqZyF62Al
         hX+t+u4i+e5NLolYAdWm3RD9NY+WtoMs4TagVsAY3EwNumJXp/KZCtBREBLp7om0qbiP
         RjYdrnh6C/BbsHlr5VltVLhENcbpmpaIOP5ZZfyOWEV4WBameDNPNKGR2dx77ysZ+qRU
         r6Aw==
X-Forwarded-Encrypted: i=1; AFNElJ/psMWgdh4K3AxmgIY/J5Xpd0rsSzVPKaRT9GMg2wNqWI1BDfym5k9AFkHGVDyYdy3hLYGU5YsZQMmUgZePlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwerRBqyxd5tj9AuRzAqBchRSj+wtpJHThJlF1pvTJImRxmLMt8
	fo/n7CcagN4KeqpF6dF+rZByz5Ly9nseIm9TEQlIFuxLjZLtXaTVdWFbyHc/i3KU2n9pu10VKRp
	6muAoGMJ+uze9Lf6t4y4hdw+41+XfCZUfHpBzch+rQNHzdFeQP+gOduZm3u2KtTXKvdti
X-Gm-Gg: Acq92OEfumjDCgVTQNb8B4ujDc2hwwKtK9IrAcrKdV2Y/045YnYdlprGKuL5uFKtNHl
	M9fu5ipIIrydkKNo4JZFpA3gO0O+RJYVm2dSnjjfXqWPOW25j6dNSKXZy4VEM73Qpb2uHJHrYJW
	02wnKzs586rkajaeuUNe1VFaporDkcfGORubhigsSGRdkGzq3uSVrMmg98gaUzYNS3jW9sKPGdu
	ETNvUHnYAB98sQHHmkoNHl6zWJ70z6+Hf0woN40dJ8RgG7a7E5EyuisXhM7o2L7T66zY9kyAKYn
	u16ftNuz3f1e3QSd97q/DUStnMtuSGZ8jwmly8DuOag9fWUuShhthPSJUT30QdP9a4qMH0iAF4t
	jFz/qb+qm0I6Fjkc6NSIRlqd9NK8EZKjneK1Kn/r1
X-Received: by 2002:a05:600c:4355:b0:48e:85b4:ac7b with SMTP id 5b1f17b1804b1-48e85b4ad2dmr11170335e9.18.1778490194084;
        Mon, 11 May 2026 02:03:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4355:b0:48e:85b4:ac7b with SMTP id 5b1f17b1804b1-48e85b4ad2dmr11169355e9.18.1778490193392;
        Mon, 11 May 2026 02:03:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8946a5sm98618955e9.0.2026.05.11.02.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:03:12 -0700 (PDT)
Date: Mon, 11 May 2026 05:03:08 -0400
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
Subject: [PATCH resend v6 15/30] mm: memfd: skip zeroing for zeroed hugetlb
 pool pages
Message-ID: <a39ab8288aceb244bdb31141aa9cf67106c0e042.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t-6ZHNvbsz-6OuxOBHW_Zoydd7QKvwnbOKQxZNY90Ug_1778490194
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

