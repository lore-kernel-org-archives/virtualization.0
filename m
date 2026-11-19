Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089763;
	b=Q0LFfeAHloUJdhFHWP0rgTpaCRj6xQoROM2nv3zAoqU2zS959dUAmQYI2j2HTFlKiIhe
	 HE5Uh7oILy0OzG3msCqgfB4mI2WAaFxVvDS0GIO53Ez6KILGo209cL0IhV2PYoVmqKVg3
	 lSvtaPX4CxvTnpmqVC4uIDba3kX1HrSBxMYU3YmZk8s0weBBhaoRl/MhHa89rEmHz8j2q
	 RtHjjhKT48QPI7MuSLlks7EkAP1+heR/3h6yaD0Ce5Dxn7sdCIM9zgNch+sTk16K4teLB
	 DDxplVHcUhvmBBDgHuoGFLrmA3A2vqP/k2LsOyVD9uE1s8mFwC8OfCTwR2IUK0U4dDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089763;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=AJpa1vQKPwsA3exeR0zFQL8OS++YNOFFgxas0w1fwx0=;
	b=jGGj3D3rjAyXAcXfZzueW44MAQuIPaKziL11AKYxOI0ub37t5gEXo6gpf6kCpFCsrUAM
	 ggkIHI8+smD+1itVlnE6OukgRZ6wvsEd3ZA21Ox3IOCTiQLSOVduNNt0xgODb1ZnWaB4f
	 u9Gw1jegvo15j7toxiggu2fTW9w67Emj/boHh3nnAvulgt+1Gx+W1NoBiQ5dy3mz+Bj9o
	 Qiqff8dPKzI1Xa9DUHXNX7y2vWcr0Eui8CvHb7tJOvnP3coIIy7ZBFLBsCIBGvlmOwgVi
	 XX5+ioJZoWICC86DPZmLQDuaFi7/w/5O976O2iZwOK9FC18duKl6O8Pb7W6fbHNAN4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hn5aiso9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C8606A331
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 12:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1C8606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hn5aiso9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795089761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJpa1vQKPwsA3exeR0zFQL8OS++YNOFFgxas0w1fwx0=;
	b=hn5aiso9Xa4ICGE/HCy+oP3G6m7uin78zxBDswmaYhx+RTChDPhUH8qIHECVcToPacLoKc
	0deNuFttZYXXywUo1LVM9TjyyhUWDBxoOHK9LMzbYG+TfhMGeUOfLT5CgC8IOSHI8jqFlt
	zccCfcrR6hDLAv6gQlAcoFeqvPi9UaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-z6G9vHRFNSOeAOfbqhR0uQ-1; Thu, 19 Nov 2026 07:02:38 -0500
X-MC-Unique: z6G9vHRFNSOeAOfbqhR0uQ-1
X-Mimecast-MFC-AGG-ID: z6G9vHRFNSOeAOfbqhR0uQ_1795089757
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49034831bb3so1459466f8f.1
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 04:02:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089757; x=1795694557;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJpa1vQKPwsA3exeR0zFQL8OS++YNOFFgxas0w1fwx0=;
        b=JfO1El+Gis2HJ9KjWEdM2luPc1MUQrndPM/RgBDsQvopfHe8r1rYrfYcr3FYYdzC+1
         ZfCq3RTrZV/YJ+Jkv/i2Ez2iz439fMEQ3nCfesbPsqsohOHplluO5YaY6BA0caSgmJ/9
         s/Zlob3dUYFeUI7pLzxZ2fjgVC7wzTVP9w/bsouh/8JwCAmu85VKjTi7yeaS1kVcMM/N
         9BFWxqgUEycFDo9o20D8uEZlHEoZt89hxL9BNpQ7NeJk5ubcKBhBsUL2H+tT9TuLkmx5
         Rzr4HVFPL2Nhu5aUg2bbbGDCkD+pRr2pUiBCAGEIjxEH4FXcPgijF+6Fg5X6scHlWOe0
         bkkg==
X-Forwarded-Encrypted: i=1; AL+hErGat7Uqxy5G4cMacs8tyhMC6szlNYD8LOUpgMKNzdsoe/PdHcxTbv67Ag0og888ck9izqD6BAqz4fjyT5ZbLQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9+I2sv7FIx/o8Jh1vbV8bqViY8ALu4oKRNalgn9clyHFlZzAq4
	JeW7rQg0r14DJ51giz4Oyamo+gkpuxTIykgihyefLfOfj5jX7XQRmSoIjYnB9kcpu+WLasNzj0s
	OvuGQyguQu0KARwMn0Gkho7O4z1pPKWBAk/9TYPoyadl4VkilfIDzr9NGRJjt20goBVt8
X-Gm-Gg: AZFdTZdoSKe+gsThbLRJiJ+wzj8kAYOmTJRmGE3xE30Qd0LqYeyAt/f+8x3HJ1LfMvK
	flsdUviFFTagz2x9bpFwQ/Q6m8t9ZUr27HxQAxECswvctBhvgDGJKbD8CUxxLZOKj52rHKQLfu1
	VGS3zkwIU8jawBcIYeWfiXXnPyxz0uHmSHgflzCxiuiN/XHFzEKy02cpKRtu6P8ihXia9C22KeJ
	aNQ2mmgHTFXjzNtbzk4tW7VGa2Q6wpNVmNhzmeJAPvsa/CmfaenBnb8C7KsqLXkaBIDw9w+ZNSq
	5PWhe48eWOInBDflnFn4anrHHiVaQejgxSqg/bpm4Bif6rvYnPpF231bPzfeEO/uDP25yrOrhnP
	mL8BsCXr7Esb5c9X/8T0j4/xh5TiugJaRX3c1kjGDC8s=
X-Received: by 2002:a05:6000:2602:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-4a63ae56784mr10952381f8f.13.1795089756745;
        Thu, 19 Nov 2026 04:02:36 -0800 (PST)
X-Received: by 2002:a05:6000:2602:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-4a63ae56784mr10952307f8f.13.1795089755989;
        Thu, 19 Nov 2026 04:02:35 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a650d2f682sm9896560f8f.6.2026.11.19.04.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:02:35 -0800 (PST)
Date: Thu, 19 Nov 2026 07:02:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, virtualization@lists.linux.dev,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <brendan.jackman@linux.dev>
Subject: [PATCH v11 1/7] mm: add PG_zeroed page flag and buddy merge tracking
Message-ID: <a98c8a49744d30a5e603228d9cb17509261add90.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795089715.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oCi3EYCoihIGgficllIViiBUIVnXUZBg1jdkWd5Gxbw_1795089757
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add PG_zeroed (aliased to PG_private_2) to track pages whose contents
are known to be zero.  Propagate it through buddy merges and splits.
Upon folio allocation, PG_zeroed is cleared and its value is transferred
to BIT(2) in lru.next.

This bit, in turn, is tested by the new folio_init_user(). If clear, the
helper zero-initializes the folio. If set, it skips clearing the
contents.

Clear the aliased flag on free so filesystem state cannot be mistaken
for zeroed contents.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
---
 include/linux/highmem.h    | 21 +++++++++++++++++++++
 include/linux/mm.h         | 32 +++++++++++++++++++++++++++-----
 include/linux/page-flags.h | 15 ++++++++++++++-
 mm/page_alloc.c            | 38 ++++++++++++++++++++++++++++++++------
 4 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d7aac9de1c8a4..70bbe93b8d669 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -303,6 +303,27 @@ static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
 #endif
 }
 
+/**
+ * folio_init_user - Initialize a freshly allocated folio for userspace.
+ * @folio: The folio freshly allocated from the buddy allocator.
+ * @addr_hint: The address accessed by the user or the base address.
+ *
+ * The caller must not have written to the folio or repurposed folio->lru
+ * since allocation: the pre-zeroed marker is only valid until then.
+ * Preserve known-zero contents, but initialize KMSAN metadata that the
+ * allocator may have poisoned. Otherwise, clear the folio if required.
+ */
+static inline void folio_init_user(struct folio *folio, unsigned long addr_hint)
+{
+	if (folio_is_zeroed(folio)) {
+		kmsan_unpoison_memory(folio_address(folio), folio_size(folio));
+		return;
+	}
+
+	if (user_alloc_needs_zeroing())
+		folio_zero_user(folio, addr_hint);
+}
+
 #ifndef vma_alloc_zeroed_movable_folio
 /**
  * vma_alloc_zeroed_movable_folio - Allocate a zeroed page for a VMA.
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6af3b7008f1ad..7c9ada8273815 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3325,6 +3325,26 @@ static inline void clear_page_pfmemalloc(struct page *page)
 	page->lru.next = NULL;
 }
 
+static inline bool page_is_zeroed(const struct page *page)
+{
+	return (uintptr_t)page->lru.next & BIT(2);
+}
+
+static inline bool folio_is_zeroed(const struct folio *folio)
+{
+	return (uintptr_t)folio->lru.next & BIT(2);
+}
+
+static inline void set_page_zeroed(struct page *page)
+{
+	page->lru.next = (void *)((uintptr_t)page->lru.next | BIT(2));
+}
+
+static inline void clear_page_zeroed(struct page *page)
+{
+	page->lru.next = (void *)((uintptr_t)page->lru.next & ~BIT(2));
+}
+
 /*
  * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
  */
@@ -5544,8 +5564,9 @@ enum mf_action_page_type {
 	MF_MSG_UNKNOWN,
 };
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 void folio_zero_user(struct folio *folio, unsigned long addr_hint);
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
 int copy_user_large_folio(struct folio *dst, struct folio *src,
 			  unsigned long addr_hint,
 			  struct vm_area_struct *vma);
@@ -5693,11 +5714,12 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
 
 /* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
  * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
- * the head page of compound page and bit 1 for pfmemalloc page, as well as the
- * bits used for the DMA index. page_is_pfmemalloc() is checked in
- * __page_pool_put_page() to avoid recycling the pfmemalloc page.
+ * the head page of compound page, bit 1 for pfmemalloc page, and bit 2 for
+ * zeroed page, as well as the bits used for the DMA index.
+ * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid
+ * recycling the pfmemalloc page.
  */
-#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
+#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x7UL)
 
 #ifdef CONFIG_PAGE_POOL
 static inline bool page_pool_page_is_pp(const struct page *page)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b0ddc652e76cc..39cd5911a2188 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -153,6 +153,9 @@ enum pageflags {
 	 */
 	PG_fscache = PG_private_2,	/* page backed by cache */
 
+	/* Page contents are known to be zero (host-zeroed or balloon) */
+	PG_zeroed = PG_private_2,
+
 	/* XEN */
 	/* Pinned in Xen as a read-only pagetable page. */
 	PG_pinned = PG_owner_priv_1,
@@ -686,6 +689,16 @@ FOLIO_FLAG_FALSE(idle)
  */
 __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
 
+/*
+ * PageZeroed() tracks pages whose contents are known to be zero.
+ * Set on free-list pages by the balloon driver or page reporting.
+ * The allocator uses this to skip redundant zeroing.
+ */
+__PAGEFLAG(Zeroed, zeroed, PF_HEAD)
+SETPAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
+CLEARPAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
+#define __PG_ZEROED (1UL << PG_zeroed)
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 PAGEFLAG(VmemmapSelfHosted, vmemmap_self_hosted, PF_ANY)
 #else
@@ -1189,7 +1202,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  * alloc-free cycle to prevent from reusing the page.
  */
 #define PAGE_FLAGS_CHECK_AT_PREP	\
-	((PAGEFLAGS_MASK & ~__PG_HWPOISON) | LRU_GEN_MASK | LRU_REFS_MASK)
+	((PAGEFLAGS_MASK & ~(__PG_HWPOISON | __PG_ZEROED)) | LRU_GEN_MASK | LRU_REFS_MASK)
 
 /*
  * Flags stored in the second page of a compound page.  They may overlap
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6624293e4d787..927a288eb419b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -986,10 +986,21 @@ static inline void __free_one_page(struct page *page,
 			change_pageblock_range(buddy, order, migratetype);
 		}
 
-		combined_pfn = buddy_pfn & pfn;
-		page = page + (combined_pfn - pfn);
-		pfn = combined_pfn;
-		order++;
+		{
+			bool page_zeroed = PageZeroed(page);
+			bool buddy_zeroed = PageZeroed(buddy);
+
+			__ClearPageZeroed(page);
+			__ClearPageZeroed(buddy);
+
+			combined_pfn = buddy_pfn & pfn;
+			page = page + (combined_pfn - pfn);
+			pfn = combined_pfn;
+			order++;
+
+			if (page_zeroed && buddy_zeroed)
+				__SetPageZeroed(page);
+		}
 	}
 
 done_merging:
@@ -1378,7 +1389,7 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 					continue;
 				}
 			}
-			tail_page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+			tail_page->flags.f &= ~(PAGE_FLAGS_CHECK_AT_PREP | __PG_ZEROED);
 		}
 	}
 	if (folio_test_anon(folio)) {
@@ -1397,7 +1408,8 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 	}
 
 	page_cpupid_reset_last(page);
-	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	/* Clear the aliased PG_private_2 bit when freeing allocated pages. */
+	page->flags.f &= ~(PAGE_FLAGS_CHECK_AT_PREP | __PG_ZEROED);
 	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
@@ -1507,6 +1519,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 			      unsigned long pfn, int order, fpi_t fpi)
 {
 	unsigned long end = pfn + (1 << order);
+	bool zeroed = PageZeroed(page);
 
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
@@ -1518,6 +1531,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
+		if (zeroed)
+			__SetPageZeroed(page);
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
 		if (pfn == end)
@@ -1705,6 +1720,7 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
+	bool zeroed = PageZeroed(page);
 
 	while (high > low) {
 		high--;
@@ -1722,6 +1738,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
+		if (zeroed)
+			__SetPageZeroed(&page[size]);
 		nr_added += size;
 	}
 
@@ -1880,6 +1898,13 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 		set_page_pfmemalloc(page);
 	else
 		clear_page_pfmemalloc(page);
+
+	if (PageZeroed(page)) {
+		__ClearPageZeroed(page);
+		set_page_zeroed(page);
+	} else {
+		clear_page_zeroed(page);
+	}
 }
 
 /*
@@ -3144,6 +3169,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 	}
 
 	del_page_from_free_list(page, zone, order, mt);
+	__ClearPageZeroed(page);
 
 	/*
 	 * Set the pageblock if the isolated page is at least half of a
-- 
MST

