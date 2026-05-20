Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F03B0AE5
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315663; cv=none; b=ZIaM6eu6dc1YZmPu8GmL4EFcr3pYyRlhKPPn4ki/iwvs8a5UEuO63on0Jx2jLG5Fxar05dZqhDbXR/eQrnPgSNTNxiNy7VCymIhSLOxzuJ8zZCfxE3HZtRxKDTfppUhcFmNyhG5MaCOjJqWx68n271tMeGKK7Sl5C5tHOvMoAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315663; c=relaxed/simple;
	bh=YV4jBXFQrQQpbg0jR4Mv8OiHoL2bzi28JLwzDY6BCc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bFjDhermTUBFeBNZet1stUNgb35zoa4C2HQM/tKFo41vlhr/s/X6+q8oWoKwU1xo6tKEOR4ntj5ZaRlHBL+PP9Pjh1Yi5iCrA6w7O5rP98jxa2CHYwct0/Z77eN2foccmBpnJRS7MeEa0yJyfAuKF9pXCCm8O+xgexlObV2gsvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sw6MH+6g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sw6MH+6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri6YQ3HlLjUAH8mONUkbxIg9Wl46GlG+rJaCqygm0zg=;
	b=Sw6MH+6gAReXKx/fohgQ7Pku/zlk3KMXc7eTq4sc8B8A/h79uC/fzFDZLx2dlbH5AHu8UP
	RgA8/TK6H8lJLjsIaoc1V+s25Z3Y6tUlLu5oRw/0Ito8I9P4I0W/FHIniEXhPSbXRS0dzD
	g3Ckaw9onwCc1Ld25Hg4FYEPbNwFEW8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-vhLDy9zgOoKCjlNh42uceg-1; Wed, 20 May 2026 18:20:59 -0400
X-MC-Unique: vhLDy9zgOoKCjlNh42uceg-1
X-Mimecast-MFC-AGG-ID: vhLDy9zgOoKCjlNh42uceg_1779315658
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-393d72477bfso27239431fa.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315658; x=1779920458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri6YQ3HlLjUAH8mONUkbxIg9Wl46GlG+rJaCqygm0zg=;
        b=jWAmAm2Hf/3P90BgjO9mrA+0V0ZIKxiVyC/vrRYFpjE8FyIHCxO2mRHb4ghSVU+Jou
         J3+rd/RXGzNuuF9mtAg7VjYmVnftdoYrtdDErw3XkUAc7HE3lWgFaGHNRDJwS5ddqQog
         2gLzvqCA0o9WNhUp3XuhIGomhYZQfdmLVzpXpeXNvUNH3WvKAJY8AGcSqkHQ+E2LQvi7
         x8N/FCKrUir3MdzPZTcAqt5CbUcQyDYWl4XqA3ThkQd0JoWZi2O0AbjoVf6ZA5LjwQcV
         weXG5sNETP+JpgSaN+erG7+aEUeCNqeV7D90U3QhepiumRCcGbu10QrMaw6dr3w2cSpp
         G61w==
X-Forwarded-Encrypted: i=1; AFNElJ8fbbLvhfTNgR3rW9E+UTJGfDgOc7PLyQacF/jCJ689RKrXpUvQa16hYKQYlLoQQ/GIgFEAV/tKDgkGJMlu5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdLZxzjQyx2UtLuPWKh8sc78SVpAGffX6m/c9DDfxERD7Q43HJ
	5r7klMz/QHx9IXCaAmP4itrlIBeO8IGynVP+PPJe9CQMiq3Ea/mgkuZ9qWVoG4Sz443r25Oj8UA
	4J1Rbo1cCBpSTSBzyrKA9mH9QKttPTvvUdC8fM4LV3UlHQDCQ68LwO3IB8DDfhIgUgZ9A
X-Gm-Gg: Acq92OE6/l7XT2aDBFBUfCRciBf5+BvVIawY99a5qkKE88lJGbPvHtG0cZFyWBxtJBx
	FPIPKUzPj0JTcYnzUcYbrlUtlueEco9e+fCnEUeMmtREOwRvBQhc2lZxZ3te3sqKokSG/y0yPiS
	ynD1MBI3MLl+Ux3DXKt37ktjWZQ4+tqV4Ff/beMwrFDw+ZHQEtEPErzgvwZXparvc0Tluq47Hc4
	ePBscfgbGxzoVl6IrTWDcXkC+scYOEzQ4kaYsITDaS9mS6YD0n9eTzqTmpn15LWsuQnhh9GReux
	rp3paYcpvFhQM6BcdgAul2cgwOGFJvHeUArvufQG4NEbUUSn1C5oHqb1hgaNkdgRkAxIQGfIRoU
	21AjI367f0jcunI7+sszFSMcl6/4IwSKhRvxkGFT3zpo=
X-Received: by 2002:a05:651c:1512:b0:38a:45d6:c246 with SMTP id 38308e7fff4ca-395ca1dfb3emr1246361fa.8.1779315657770;
        Wed, 20 May 2026 15:20:57 -0700 (PDT)
X-Received: by 2002:a05:651c:1512:b0:38a:45d6:c246 with SMTP id 38308e7fff4ca-395ca1dfb3emr1246201fa.8.1779315657241;
        Wed, 20 May 2026 15:20:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39588791302sm31998751fa.32.2026.05.20.15.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:20:55 -0700 (PDT)
Date: Wed, 20 May 2026 18:20:48 -0400
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
Subject: [PATCH v8 06/37] mm: move vma_alloc_folio_noprof to page_alloc.c
Message-ID: <caf74b4efdaff24d77e6c9aaee6b431f53ad8335.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ogWoNY0-3Cjre-MSYfs-uq2UF75eVItfMVQ7P4nWePQ_1779315658
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
index 1192c4e47da4..0c4f4c678233 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5288,6 +5288,49 @@ struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_
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

