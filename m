Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691643B19CA
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907728; cv=none; b=n3p9qAiS647Tt9C8AAxekOS4JO+yxFejghOqZTjz0HtVdOHOT/ztalZXZ0aW9WhtqCDmr1NJMAWi1Qedx6dDed/realDvG/ACIZz1MtRJkOdGysRkZMUCePDlYV8sgbwDcbyy7jJ70Tbi6xHBYGI4Q3cpBquG1gIMgeBosf6M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907728; c=relaxed/simple;
	bh=WqVTVeEY5sjLY71Wx43CJrvkZxe/1qqCM34phrgRwA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lD9ofMlfNMj4nEsQZKpitGzHMiC6PlImoYYJDG7Gkxp4KKRWOmyMJoTSQMcWe82L3TX5tK0RXNUMUQvsnTSroRi3kyfnbI4icIjjgEee5v6X0cUTidcb+3yERBn+7nQZYlzef5KbJFARaojrf9Ya1tIHKvoAhnbDIc/cD9LsJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwh4JEWq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwh4JEWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTsyEmHKpfx3QY2xerCkWdwHjor0zxZF5cs8sc/X2mI=;
	b=fwh4JEWqEgOb5pdYLaiUHarxpg4O3s7XeBae72xg1zRMiRFA2uM1VQDazjtuj7PQxx7SlS
	Tow+E0WCZ2qN9udBFJRyfjLoQzk4VuszIMpPgOIHLjTkzJFp9u/ZAQIQhMViJ0UigTNuxO
	o32rq0Wu2WBU9KJYVDHmLB7O9GVh6mk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-0r-OF6-POxidauBgMiS9LA-1; Mon, 08 Jun 2026 04:35:19 -0400
X-MC-Unique: 0r-OF6-POxidauBgMiS9LA-1
X-Mimecast-MFC-AGG-ID: 0r-OF6-POxidauBgMiS9LA_1780907718
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b5d2e394so29560375e9.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907718; x=1781512518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTsyEmHKpfx3QY2xerCkWdwHjor0zxZF5cs8sc/X2mI=;
        b=pq9w+TeLPpU8P1LbsRi+p2b+g64cyaPAguUpS4uxwxG/HLyQe/WWtb+M3d6A2ZPtUb
         BAoqAwgPHRkLo83YqaH7lCVAsnMJG32ra0YCUsNFuyq108Qw+5+0kr4yd9GgRzTe9Gri
         jTJ+bZYKrUOiXDGqkngVrgublxPY6S+9BxYzlSeklxWWjI34Rx0El79CO4x72Fj0hR33
         sfeJwKbCcY5kJ/CcBXOxU+8XLJ8WcU2I65H+0T8DiYcaKZFRIaj3xMM9jHBTGN3X7/pt
         /6e4WSfss0ZH9c92DOwWYQHm//OLxuEowQxncBXgifD0OH/sSqUhgA9xsvcyxtnMOx9B
         DWYQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cpeP1gTppn8e+fvuoJ/qACLmHo27tmIQ+AkIUz2I16V2hTVAgzoQAtRSUA5dlTSvJxQ0cBVb1lpI93NOB2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfouLt4fmN5P81t5PeYwztZtQBSkCf15xwbdwLxsGtMkZXJvu2
	msVfVh6kckZjR6IFTl8BIn12Fd6vNTOR9tVe1YUbx2g6372CY7C8LaA1VV4LaakVAhuM4bzaXk2
	GtEYKNczsN0xbBMWCWmWE5tSP77Q1aGu8yYiYTVIZJPlHWk/8W6jkzQtdIiE2Gyo2o5nK
X-Gm-Gg: Acq92OGon1cwzfukwqDnaTwePFlmEb6+yjjAIcSEeD4vK++CegCfHUJbhak/X2b31OL
	HDn0Mp/Lp+ZMGM7EbXM4ShMtDMDIm4SJfUbquv8UnsT/TTkCRxM0yaGnLtRWaas9/AQzKhfRhgl
	Aeb2I0c8ZIk0sxFOYJ1ZMikYz6C/yQKmTuHMFdf4rzEhsyKHIp501sg2q48rQsoqyFgIF+p4WKk
	qyYSqIUWeDM1tKKi5sseHSMgPtlwFYlCvbU9y72idl5KJ/1GeDgufuXWfsK/KWHqPZ+DL7NQ2CP
	SAXaU+yb/W+TdLwQsAKkJaAXdsaODPRqMLD0Vg1FbAXI+mJAtT1/fXSf4OHqYY0thd/nxXIyi0u
	XAFk4T4vxo5gcIz20qaCyVl0=
X-Received: by 2002:a05:600c:19d3:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490c25fa410mr242690715e9.26.1780907717890;
        Mon, 08 Jun 2026 01:35:17 -0700 (PDT)
X-Received: by 2002:a05:600c:19d3:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490c25fa410mr242690165e9.26.1780907717394;
        Mon, 08 Jun 2026 01:35:17 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm282225125e9.2.2026.06.08.01.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:35:16 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:35:05 -0400
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
Subject: [PATCH v10 06/37] mm: move vma_alloc_folio_noprof to page_alloc.c
Message-ID: <5a3034dc7b3d5ea1edcc8b9baff63c980b7ae434.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 264lmHlZ3IVy6At7ufJSpKnuMJO1MMQwb-iIVCcg2YI_1780907718
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move vma_alloc_folio_noprof() from an inline in gfp.h (for !NUMA)
and mempolicy.c (for NUMA) to page_alloc.c.

This prepares for a subsequent patch that will thread user_addr
through the allocator: having vma_alloc_folio_noprof in page_alloc.c
means user_addr can be passed to the internal allocation path
without changing public API signatures or duplicating plumbing
in both gfp.h and mempolicy.c.

The !NUMA path gains the VM_DROPPABLE -> __GFP_NOWARN check
that the NUMA path already had.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/gfp.h |  9 ++-------
 mm/mempolicy.c      | 32 --------------------------------
 mm/page_alloc.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 51ef13ed756e..7ccbda35b9ad 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -318,13 +318,13 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
 
 #define  alloc_pages_node(...)			alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
 
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr);
 #ifdef CONFIG_NUMA
 struct page *alloc_pages_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order);
 struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *mpol, pgoff_t ilx, int nid);
-struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr);
 #else
 static inline struct page *alloc_pages_noprof(gfp_t gfp_mask, unsigned int order)
 {
@@ -339,11 +339,6 @@ static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int orde
 {
 	return folio_alloc_noprof(gfp, order);
 }
-static inline struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
-		struct vm_area_struct *vma, unsigned long addr)
-{
-	return folio_alloc_noprof(gfp, order);
-}
 #endif
 
 #define alloc_pages(...)			alloc_hooks(alloc_pages_noprof(__VA_ARGS__))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d139b074a599..a1707ad498a8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2516,38 +2516,6 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 	return page_rmappable_folio(page);
 }
 
-/**
- * vma_alloc_folio - Allocate a folio for a VMA.
- * @gfp: GFP flags.
- * @order: Order of the folio.
- * @vma: Pointer to VMA.
- * @addr: Virtual address of the allocation.  Must be inside @vma.
- *
- * Allocate a folio for a specific address in @vma, using the appropriate
- * NUMA policy.  The caller must hold the mmap_lock of the mm_struct of the
- * VMA to prevent it from going away.  Should be used for all allocations
- * for folios that will be mapped into user space, excepting hugetlbfs, and
- * excepting where direct use of folio_alloc_mpol() is more appropriate.
- *
- * Return: The folio on success or NULL if allocation fails.
- */
-struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
-		unsigned long addr)
-{
-	struct mempolicy *pol;
-	pgoff_t ilx;
-	struct folio *folio;
-
-	if (vma->vm_flags & VM_DROPPABLE)
-		gfp |= __GFP_NOWARN;
-
-	pol = get_vma_policy(vma, addr, order, &ilx);
-	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
-	mpol_cond_put(pol);
-	return folio;
-}
-EXPORT_SYMBOL(vma_alloc_folio_noprof);
-
 struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
 {
 	struct mempolicy *pol = &default_policy;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dae5b3f5876..6a605d05e8cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5286,6 +5286,49 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
 }
 EXPORT_SYMBOL(__folio_alloc_noprof);
 
+#ifdef CONFIG_NUMA
+/**
+ * vma_alloc_folio - Allocate a folio for a VMA.
+ * @gfp: GFP flags.
+ * @order: Order of the folio.
+ * @vma: Pointer to VMA.
+ * @addr: Virtual address of the allocation.  Must be inside @vma.
+ *
+ * Allocate a folio for a specific address in @vma, using the appropriate
+ * NUMA policy.  The caller must hold the mmap_lock of the mm_struct of the
+ * VMA to prevent it from going away.  Should be used for all allocations
+ * for folios that will be mapped into user space, excepting hugetlbfs, and
+ * excepting where direct use of folio_alloc_mpol() is more appropriate.
+ *
+ * Return: The folio on success or NULL if allocation fails.
+ */
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol;
+	pgoff_t ilx;
+	struct folio *folio;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN;
+
+	pol = get_vma_policy(vma, addr, order, &ilx);
+	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
+	mpol_cond_put(pol);
+	return folio;
+}
+#else
+struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
+		struct vm_area_struct *vma, unsigned long addr)
+{
+	if (vma->vm_flags & VM_DROPPABLE)
+		gfp |= __GFP_NOWARN;
+
+	return folio_alloc_noprof(gfp, order);
+}
+#endif
+EXPORT_SYMBOL(vma_alloc_folio_noprof);
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
-- 
MST

