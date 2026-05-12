Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C623C1978
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619942; cv=none; b=rArYF0T/jvXRkvnnVKc8kpF8qYNP4TNN01+jd/ADB2DSttAH6qQ+lAusRo/kG7GjDgFjlNBHTk/T1wkkcjghS54M62IavxoQsyQQABUNUxRqZ60g/xM1k0oyy3IN3EH2reEM7fkDRiuaLKY5XmnZ+4Jk+/hg3qVYOFkDX1iSmrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619942; c=relaxed/simple;
	bh=ePR7uNlotrezAJookcUJ/8DLykTQxnwcGZYCYwhIa5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FwX9ewPtnnSMtXCIMf5lbrHTo9JON3RanaiIi/fT41/mAFpctqd0sJd29TWYIf1sVEWu9pc0LBX5lBRbINyPn9wysffojaVR+uGjuwElS+hJOAxmKG0FrX6oSUBZ7G6NIkJb+777B+MNEVqPfWZIG4jeyyxTv60p17E+evhiaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iutyET05; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iutyET05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uXm+f+MkYB5oL4CzdS91ST7c4wCcchxSd9UlyIAHNL0=;
	b=iutyET05D3a2zgKfoNyzSsBbR+GKdiCBvOci2CkQtfEK8P83PMoANgtaKJfUtqLxvUV19a
	1sE58vpbv2WrSeKWW9J0nmUdcWqxzhPKaMSi57TPeGYuAo51JCQjPPT3FMjOsTUGGLjlht
	jkppYS21ycZhVuRNyNum0czBwOIIq7I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-XIvwFnUJM0OxdXetJY_76g-1; Tue, 12 May 2026 17:05:38 -0400
X-MC-Unique: XIvwFnUJM0OxdXetJY_76g-1
X-Mimecast-MFC-AGG-ID: XIvwFnUJM0OxdXetJY_76g_1778619937
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so3818736f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619937; x=1779224737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXm+f+MkYB5oL4CzdS91ST7c4wCcchxSd9UlyIAHNL0=;
        b=kt3x+xcGZv9cVKaJTw3m6W9QVIbMHR+4afY8sn4r05em3X6Q/BoS5fotQcQErAQQ+P
         ooy8OTdkOpi4QCM+maq+fUj76tv1vzZdwLt+EOQrU2EQAtXjGb3nTDVjt6C1wqAEiSqw
         X2jI6YZv2v2fQAwim5dLF62fmQX6RGyg6pckL98+sfuwXfCzRzAF+kG8Aa18RdMkZUa/
         l5VoNfZgFKxvgba/LVkhcdE6XeZ2Cyl2lWs6j9WrZ3TQJEQ9hZ0OORL9UT/KglzLaJO1
         7ELh3z8l9aJgoCyv/pDi99juAtf5oMgI3k/UPMqcXiWcL9PStvUyJAp6Eo2Vq0oPEtXt
         H0yw==
X-Forwarded-Encrypted: i=1; AFNElJ/YVDVnJA03pPWcr+C7pTFEr8fI7P8c9BK6VZdb5pP9CmtlhM9cmyd3aUZCvjtIBKNRy8B0lEd8jzb5lySHxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI6KfqkDLTSMpQvq9TTtA1L1RKQIV8YwGgSi900iOlWA9gNFD8
	LsvZwe5a3vgwLrtybKVBo31RebdSuV0Iir5W2nGzKwEZsqEwTt63fmKAhjg+3KONbDFODMt8oL1
	5ankouBqSW0IV1uRCpikp1axVc/dogcCYBO5+muX8aGuL7U4jRK92OlbbeEzLrwrPJHoI
X-Gm-Gg: Acq92OF80l0Fo9Adjj49N4cQ5JZQuekCSpCV2VwoVv2CGxgBc9kHmWoSsXGcUz2H0QE
	P+bhdqgVr+UMfQMcFxs0rqPSQEsLBz1OsJQvJOoQ3GUfgT3eMpuOpBk2UBE8f4Dfxf0V53fLW57
	l8l6VDbypteopVX7V9m4MeODDCpcrt3g3HQ+qv+7kvr5mqaHGAxTFuNby4Hz6G2h6RRzt6Yz5JN
	GlU3TfubZawqRht3Bza9d4snpzG1FE91Ss2AF51LNFsK+h2rfFjXaLmJ7uvjm5QCz6ODdGMgHm6
	8n+62DdJOR7OKOI+Fgu/7vsBuo8CdtJUigx5GBGNrKhz6NOWkbepON1Fq5rW8KpYHiJlc9pFKgm
	JpYce5vOx/WiMmtxxFQQW6a9vushlmSEddV55+i4h
X-Received: by 2002:a05:6000:26cf:b0:45a:ff7d:9800 with SMTP id ffacd0b85a97d-45c584a868bmr548636f8f.15.1778619937182;
        Tue, 12 May 2026 14:05:37 -0700 (PDT)
X-Received: by 2002:a05:6000:26cf:b0:45a:ff7d:9800 with SMTP id ffacd0b85a97d-45c584a868bmr548593f8f.15.1778619936563;
        Tue, 12 May 2026 14:05:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6aea4sm40612389f8f.10.2026.05.12.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:05:36 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:31 -0400
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
Subject: [PATCH v7 05/31] mm: move vma_alloc_folio_noprof to page_alloc.c
Message-ID: <17711d281fa0cb9751da2c856e693e9da6d1efa9.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: w-HSzBQ4K1HpgUB1BoYepQnA1cBxa1T1LjA2AASKab8_1778619937
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
index b2c21ed1fd84..39e556e3d263 100644
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
index e40fd39acbd0..4c5610b45de5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5285,6 +5285,49 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
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

