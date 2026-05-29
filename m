Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801B3E92B4
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068163; cv=none; b=pOXT6wsN4rmMY+iACf3steqrHR39P3gNoFWIXk388egHLPUNrCOJz/yTPXrqq8ujEzlPGFS2mTSnD20ClN0mt/QySAb9BRY8Yi962YbEmMyVE+JTWM2lMCp27z3DfeAhf4Oi0af9G+cV8XoDSW6q0Gfk0NSERjJkoBvNRRA82/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068163; c=relaxed/simple;
	bh=UliapvFzBZgGZQz4lzdPjxY0rdM8nGKqjKGuh8rusnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UsujLC0E4MXLDoc9DpgW0DjJ3if2NhNcCs3GJXKyfrA+gOxooCQYgHNq53RotZYlPnRyPklTdZeqN3eDUhHiVn//g+M55ahyQhLCBIgiC0vNizcE8kA2etHb2NKXm+4lobnE/m4A5dFyRs8EzLTocZ9yCb5Bs7fdIWU1ZwZtTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9rbl8N5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9rbl8N5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1d6/7ocvnM9x5v92z8cdenZMlPT5Fb+FBGOKjHhSxWM=;
	b=B9rbl8N5HN3M8rYrLTO8GdWfLYDIQcUyX3voGdL+XaJBgT9S9659Jp8eto2lG2mO0iYOgB
	XU3nVWHxIlfn+WPYqZeA4mEKDOwOAq56H++mXIvv8r1XcQBg8RsALnabAUhzAWeEKSunmQ
	u4dHejHn4eJRqV0w2Sgis5wFtCvnFGE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-2mzCC7MoMPaS55R32PXafQ-1; Fri, 29 May 2026 11:22:38 -0400
X-MC-Unique: 2mzCC7MoMPaS55R32PXafQ-1
X-Mimecast-MFC-AGG-ID: 2mzCC7MoMPaS55R32PXafQ_1780068157
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so8348751f8f.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068157; x=1780672957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1d6/7ocvnM9x5v92z8cdenZMlPT5Fb+FBGOKjHhSxWM=;
        b=poQ7YEhn8GobYILKkNfUNdwSlaOQ44+bSCXGGQ0Amu0SoblWv1t34ktxF7V0FSlo3R
         +2bT5WsbiG6uJ9uNtFFGyP2X713jfjEzeWyGDzS9sz4Mxp0+JJ/wvJKKGqd2we6DFqPm
         3BGJM3uTHqOTVeHrKTjpzM7/QXMCQ7Z5NSTZ9+Xcpaoh92ge03wghb2VFrjtKVW6TXV3
         2K40N/QRICg/qAOYRvfwUuN5bc1qCsCGtPhPCK3DXcWdswOFdMryLrwiRpnpElE2zONe
         HzXP3bR7rz5mkVEyvmDgsBw71cTE8CB9gMYzeHqQd2i3eXOfR4K595LabuD51xDB8tnS
         3Mjg==
X-Forwarded-Encrypted: i=1; AFNElJ/lE96loETLyzMgzykvT4uVq8IfQBEElqs9o8nfEV8RoJRv5BrRpJe+o/oINagC9A2AWLUg4jt9KKy1fH9nYA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsgj1B6dss73PIoayqs170jO0q61lO/CsKt3P3vkeIXnW4CZ8O
	/a1ZPKsvj49NTFwylO5Ho3Vk1Wht+xcySKdWFFUvOjEWgi1tVnolkcGMPDMjS/+BjCNKhtD4D8a
	oQZ/yuGYbBcD5eOL1NR8btfLLfE0RdmIzz1Ld8KCE8t+8mk6Lof8fnBk3U4w+OZbvEZx7
X-Gm-Gg: Acq92OEzaXTagYnCD9f+/eoUlMVK/JIJMCM90bt1/h+qt5fmoG6iD+0Gm36dQ17UEya
	3+z0j57wTeJvmXkljy29XnK/HemljKTt5vy8Q+Ush/WBtLbfXEKOzGboq0SBf/46LQ0dW6YFb7I
	uxRh8jQIYDTQ20eJgvRCf5CXUTmRcBKzLTNmKK6hIEW4DDUJ07QFJrMQ7BsOfGvU1v93VDkmTiW
	iYJNkIBImiQZs+aEy15uTfkudAuWM+YxktTbXf5RKvDkvGKMTvgUUv3hZ/TOJmnYfygjd+BxaTk
	4h6JYa2IIsPHDFYoMzzI/x3+s95vjhSpXaZfjCMKkMtJA36S7ojEPxI3N0kUK5GmJ0FzKTw2Tnp
	epM4tgMV9Uek93HveVQlnY0V4zcB+Ac/SMMEsA814Qbx1F2Ane4TefA==
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490a2947c86mr1027185e9.28.1780068157041;
        Fri, 29 May 2026 08:22:37 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490a2947c86mr1026475e9.28.1780068156493;
        Fri, 29 May 2026 08:22:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0e8c1bsm22645615e9.3.2026.05.29.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:35 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:31 -0400
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
Subject: [PATCH v9 06/37] mm: move vma_alloc_folio_noprof to page_alloc.c
Message-ID: <926990355eadc624f8ef12b30b50f8aaf67118f0.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y7t1v6k8aIPdRk9wrYYzDp32ZVWOTHMyGvTN3w6Mm08_1780068157
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

