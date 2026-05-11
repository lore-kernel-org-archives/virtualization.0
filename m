Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C43BC687
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490118; cv=none; b=n1ch4DIZOFDcpiNkq7TvEImHbUX7ltjz5VCQ01mi1GIphFmtyzNvdIFtLvE0QDKFDJHr1PTmXUrKD3vhywSuA688ngxxCBI+Fyr2vtbNr5XG5EB+2rGDCDyN9lLDTRwQCB4tVMdm82Gt5RfREdR5yvnwo5meX/hPcAq2MnQoUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490118; c=relaxed/simple;
	bh=9w/BOdxv/UPl05k6lc7Ua9O+VaMhaIMHRfLJTh0Clsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ob8Jbg9tP3DAv6GrjXT3na9grgP7A7Z4Yo3OcSY+/okZ/UD+DiQD1dom+1aC+p7ydC8QhbPH2XYehGbWLekOIU1+bHkbNEE09CpnmVlt8ReIs1uMBvcNd3GIzTQsIviAEwX/hnzjiGQRjalLJSJjx3OE5+Q+fBcyc0NsfYTqN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRiVPUfA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRiVPUfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsz4Yb9WaP0J2d/ovLyM+GlU9a8IJXiQXaVWXPUNWME=;
	b=eRiVPUfAQGh0Rz7oH25m5sGglJE6DWhworEQjE8+1wfiiPjp/dotldz/UK85n1P+sIyZMh
	QurxLrUfVPrjdTRocDBK+W1CUDWyhgdoNdSTkoBJPd7zmWFk36r0osgvqUcoLHK8Pf45gK
	y32ye7fWs7lCjF9yLQO+tHKRa3SHP58=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-NecOjo3MNf2w7OnljFH3AQ-1; Mon, 11 May 2026 05:01:54 -0400
X-MC-Unique: NecOjo3MNf2w7OnljFH3AQ-1
X-Mimecast-MFC-AGG-ID: NecOjo3MNf2w7OnljFH3AQ_1778490113
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso30014315e9.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490113; x=1779094913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsz4Yb9WaP0J2d/ovLyM+GlU9a8IJXiQXaVWXPUNWME=;
        b=jNg4nfbHl3kVFxwz/rouciP5qqr4tKm7uIvPO0BeI93/BQUaJE/+4AfV6TeEK/c2Au
         q0b1vVSnQllbyNr1BisT55h5FbVj8qwPkNBsCq1+1dmmce+X8Ji0mmHSBCH/D3kLRpJp
         E96gRHuDyvFcog2pDcyYMGKFqGFE4HiCi1grI5FFFkZ6P71guVWqVpVyoLv68ePZkyEQ
         Ck6jX5Ai/ZXAnDUCqoauK7u/kVrHhoyiE76mz420IEyv0Ht+6VUr0iHq7RTrQoOjipjV
         h+djs0FYFsysPYE+KwWERkUjBHuQ3dG72W1y0NZqZWir8pgxxuWWPEs+NPb8ciQy06gd
         VwlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bCbo6PSFh4vIbXCwCPF07veelQucuXL+88qTRRp+YxaLNU7luuJ52aVCMVyU9YFCVDtv/qHkuTyZm70kWQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YynBkOhJF0v9syTxvy5izSOiQK1FwlLg+F3cp7yE8Ukk6sEJeTX
	8rrA+nfmnV9A1ji0nRkMyg70ihAAz5zYBEp6XTvN1iysMPtuxGEvVhcwl4A+MfiLAEARqHmCB4E
	wF6mMNzO4n7VkzRP0vP0dzgX+qP8Gzvz5iwr02EInKpWeS84B0E1gg5nWAUr4RI2DtugJ
X-Gm-Gg: Acq92OEiEb24MbkkAzGVavDUboNYluBipnYMqbRLwH75nqaXjFIawCTUSkvcjjW1ud0
	/8nkvrdW6ogDeBtli+DI2aO7kNWsQsEisj0McpWepv9pNmHmgMW0NzDNGUEe9xm8SHvt0aafU1t
	222hFDFUFDSuuv+yo1mfPCUsYL8kjSO01VA9hV9molt70u+E44tvVkMIpuiPEmz7U+vmH76Enhr
	x6cSTx79WFIwiiZ0ugrMDAcpvOir2DBgrMHWGOIlfmm9W34xOxf7CYp9l9rIJZWfiC6i7VNXxcC
	odvVgaU/59oRvEwVbO66G5i9ULM3eluLYjkMgR5QsVOenW08vzoPO5UDLz7ncuI/C/00/tv4hny
	oulvSiZD20GQC2Q715tKNsq+YHJgv1eh1b1kakUqt6Crrxl1wGfQ=
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr335189345e9.16.1778490112738;
        Mon, 11 May 2026 02:01:52 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr335186515e9.16.1778490109502;
        Mon, 11 May 2026 02:01:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e80ca2666sm91504845e9.10.2026.05.11.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:01:49 -0700 (PDT)
Date: Mon, 11 May 2026 05:01:44 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH resend v6 01/30] mm: move vma_alloc_folio_noprof to
 page_alloc.c
Message-ID: <a26c5850219e349f8a666282aa8003a82a4819b8.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zEwXGIoI1LWtPUnLiqo7wrQjJLAirNeW1Gv0wnn3sDM_1778490113
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
index 4e4421b22b59..6832cc68120f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2515,38 +2515,6 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
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
index 227d58dc3de6..fc7327ebdf6c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5273,6 +5273,49 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
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

