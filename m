Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254103BADB5
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489579; cv=none; b=UBFgWUwkdKdCeYqmzRn7JVvbGXFEjt79+hk/RJqUwx2cEH9cJEZpVY9C08XJmsHk1Xqi+UQT3O3QCLKCyIGPzCfZFp87nO/xUU4v+wDQw7/MdjFxVVa5OUGRvrk5MCgNMTfobuNrg07u4zW7dnkx9hBEwzeTJZ4hHdKtDBJZ+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489579; c=relaxed/simple;
	bh=9w/BOdxv/UPl05k6lc7Ua9O+VaMhaIMHRfLJTh0Clsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wefx3vz4uZr0331PADmc4OP08+ykiGq9R3TjeWDA2kjTh+4S2poS6Luq8lY+B7W+yjdIYgUdif5EtQsjrA9pU5YOXTuYq8XUdBhOvlM/hahxvFbuNbOgZORPc6Kd8HLpY++TUXBPo1N3Pcj1mbKi6+QuwYE5JwHJGT70c8aL3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW0lz2jR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW0lz2jR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hsz4Yb9WaP0J2d/ovLyM+GlU9a8IJXiQXaVWXPUNWME=;
	b=EW0lz2jRQrPDMXMgHIhVx8wQalCr4RrY6WiGaJlW1PdqR2fH3Qx6v368tX82m6Tx9rBFUX
	/wVzMmfzmSj3vx3pWhDOBGC+Pm5cMrjZheMf04ymHV2uqZaqHfmSn3j4Z4KHpxf1RAC51a
	4ljFyqC+w3QXnCi0T7XhqcqLS51Kk88=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-2mb24hEgNMihBPVD85CRCg-1; Mon, 11 May 2026 04:52:54 -0400
X-MC-Unique: 2mb24hEgNMihBPVD85CRCg-1
X-Mimecast-MFC-AGG-ID: 2mb24hEgNMihBPVD85CRCg_1778489573
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a69f565so3586411f8f.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489573; x=1779094373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsz4Yb9WaP0J2d/ovLyM+GlU9a8IJXiQXaVWXPUNWME=;
        b=SwjNKeJ85DmCZqX5L43+qKXphTi07K5WLay+x8wHjLUM94eyfw9fAKGko8h+U/2qIV
         4M6oh9v29B2JdZWDs4gWlPpM6BPGJtQamSgnx0gLufpkam6d2aCskgx1/FhA8TUeb841
         NzBuD5qMiRj6Mmj/PCxrKVzIaek8V52nMRCjDPFBjlMZIaCIsvLEDWUah4x0JFdjdgHx
         R0XihVZWpUUxDhPXcefzePOvwODEclIaHkgbIKbsxspWvbHJPWBrnB3K+bTv3om+yNJr
         uRVmw4TwQh4z9u+c/kZDaI+kwHJqCRW9gSKyBQht67PY9Eusp4T4E5syWxDYuklY2eXK
         Aekw==
X-Forwarded-Encrypted: i=1; AFNElJ8muzLdxjyf6/wUo1SjP0sXemSkZyMB24ZthHHrmRUrvm5B85aWXOX1J8/euMdCedLR2VHTxMWaUOgsNR4Bkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+BrP7IIwr6PplSchMnps/TZCzQ2n92YXvrQs0A4+XJ14CnhHB
	bV10p7LYiMB8PrZ77FP0xCuLRqRwmPxi7Kp+SQwizT/01GBs9KqGiaKmIeJauDMMF97MhnQFCTE
	j14MI973N8/Ky+sdHgL4CkB2kqeikul4LGzZJxikgDYlNnriz22oHf7jV/N1mjbwxyAXU
X-Gm-Gg: Acq92OHjAdQUblsTI1nAGhR0f1zsNV2KcxHeqiPD01WyFoCjSzwcq53Zhf3uERIInnz
	POcVlMvs7lUCrA8bHf55lNCyIk9ID5BOiSPM2lhVhh59Htrh/VYORagjp+Zg0BEPdriwQZY3S9L
	wE4oYZayiujLVkF+MMoZ9LbbuOU1zxvdQBzVsFsNJT8vejvogk9+Q2DJ2dWXVUNcDAZyLoEr63W
	gMuv5uuX7Cous/yYH86//17wmHii9qiJWgKFx81U/PT8c1ORACYycSLb5zvbos3wgn9ljx0nl0a
	n6TvPkN4lS72AtNATj5ybVuZWkaqYYA21JX1xghFkABnXqtqUo4IpS+sO3xB/4+4/zniPc0OPTW
	orNRuAFOTIvKQhHspILlU4+eBjCyKa9cvmKm/oxUtyuujbCZqIGA=
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr253137355e9.0.1778489573230;
        Mon, 11 May 2026 01:52:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d7 with SMTP id 5b1f17b1804b1-48e635a1ba0mr253136485e9.0.1778489572590;
        Mon, 11 May 2026 01:52:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf496bsm82372475e9.4.2026.05.11.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:52:52 -0700 (PDT)
Date: Mon, 11 May 2026 04:52:47 -0400
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
Subject: [PATCH v6 01/30] mm: move vma_alloc_folio_noprof to page_alloc.c
Message-ID: <a26c5850219e349f8a666282aa8003a82a4819b8.1778488966.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: i2RwNYd5aNADrWZPNDS5bRMPIWkhrBt8jDObQxVjH2g_1778489573
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

