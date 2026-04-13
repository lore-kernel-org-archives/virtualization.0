Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF942E5B2A
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112528; cv=none; b=JzKa2wqeGvTfaTPK2m2ikEgDbt6+aUGNwq25tvG7AO/kL0t8YElj99Q1yFJzNlOFUZXdP42xKQ600DzPXYcDlbK3H4Q/bDBo8Q7Dmv6DpK2TA6COjmdw/3ywYMtPP98c3AU2Nto/SNEp6Nln8SFPQeAdLQoamHh5e0W/b/ReAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112528; c=relaxed/simple;
	bh=XIlTzsWmUC/UEeZ9+x8Nig6LKPLGrXsI8Ejxn6M3wKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gw3u4pTzf78qLowdTLnCwh4xC3kAukSXATOw7xNoszPJzRE0kjPfPykE4n89Rk2wvYzccPlqJPYUWX7dUn0KZW9U3Bw/pFHUo+ieosRHLxyiRu1Tvs06t+uwLbHfwGgvlCaVA6cvG4bofyHxuXOaYwuzlTfXCGqeAzRihC05SiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZMRD2xW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZMRD2xW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776112525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GStuJI1A/J008doSpFXCtvMZRtsnt6jcoaLjFghqr5o=;
	b=GZMRD2xW6t5Y/JUXzT9j7hifFqbtB8V3kUj1M/71qvBJBqwTKpOCizb2XK/J8/Z/bXraRL
	pgDWnVrrmReJy5SrNGOlZ+VQvwfSpjbOdav4UVSj0CexRt1+PbovOSHmBsAUKcMSBaI3WX
	5crMs3xOLLXfpuzXH9+BmmuXAoYQiFc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-PaMumPtmPum0xZ8N8w8CBw-1; Mon, 13 Apr 2026 16:35:24 -0400
X-MC-Unique: PaMumPtmPum0xZ8N8w8CBw-1
X-Mimecast-MFC-AGG-ID: PaMumPtmPum0xZ8N8w8CBw_1776112523
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so784922f8f.2
        for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 13:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112523; x=1776717323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GStuJI1A/J008doSpFXCtvMZRtsnt6jcoaLjFghqr5o=;
        b=ggg4G63V+elxtX78HiD2rL1dObK5J4pfhP2nnkcPqI5ty7TX7QhaeB+RpubClUgJ50
         G2k7QZU/aGjHM1ySjtwLxj5zBvhtjf/3/jsY0rITATrj8usQjpQ6FBam4BLEUWiOT6SF
         eGcacpdjYEkYLGZcKOZMdFrtQSMRIYfKEUjU8OomU8k6alwborO6mL7n+hZPlpeKzEM2
         OthDF8Bv+Y0V7VjAucOyS+4fxgopWAhmiWFwOFu8q5b6AlpQ/eb1OuoZ2Sl7GkuByUnu
         T/oCbjvscWJ9GRo2se2mFHp0YwHVpvwci92yhF7w7h8Z4aPBXPpQ9f1lR6R0e/dmh9in
         kYRg==
X-Forwarded-Encrypted: i=1; AFNElJ85oKpGw5qfuMa1Kw7PbAEfvWr83Pik0q1i3EkBT0pMqD3Tb1UwC0GmvuPqlZfnULikFflXjMY8fKDTREtPEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRVWix/GBFWisUo1edsAXLD5fsr64MuR4KLMg9W30LyF8libpo
	6/5UJmAJF1FYqK/rzn4+NFEOV6LkmjI0sTK77DoZPUnGIVMzp2J7+YTeAPiTU65xmtcIEPDkpcA
	xvrAW5SFxnJLZBmYBVRw+tzFGD1GiQgDcf3AihxmIO/bxtuAsiszNjY553aRtvEsCkNuNc1OOxw
	GK
X-Gm-Gg: AeBDietaBzX7mxf30cQIcFd3cdGpoZC0/QHfYoYz3xPGyC1mmz95dMTGDYsVQFpeY0F
	3InZNbT9zKob6k4HrCOsuYKfIzeavc+aAYwniAa+73KyYLfG9gMq02jZ2KWdrs74P4ppHe0w2jI
	gS2y2JUVQumrcYMd+yoq3u73lwl6/7b8jp/Bz8cIhko8qzUioTsp0fKCwwfmN7JJTmCF+WyR13E
	w4IZ/+zrQOGp93rkCRTgDVYph04+OYgo39XHcP2ivAd5tJNCsFVq8/8boUJJ1/627hgfPO1cFqB
	YxrOSVCErbFKubhW+PaNaDSRezf6iM8uwW7YGe+y4ql+fCt0JtHPvvunchLVc6dEYU1c6nTmHLG
	LgW63SeLczLMwUHNFudlPgrQMR8c71dJH5hUYq3i6NNc=
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488d680851fmr196276495e9.6.1776112522419;
        Mon, 13 Apr 2026 13:35:22 -0700 (PDT)
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488d680851fmr196276055e9.6.1776112521752;
        Mon, 13 Apr 2026 13:35:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d688da2csm108300015e9.34.2026.04.13.13.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 13:35:21 -0700 (PDT)
Date: Mon, 13 Apr 2026 16:35:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH RFC 2/9] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260413163233-mutt-send-email-mst@kernel.org>
References: <cover.1776033471.git.mst@redhat.com>
 <ea67e39bc3aea1b0b491908f851ffce25154cd26.1776033771.git.mst@redhat.com>
 <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2155527a-e077-4b71-80ee-d735f9984f60@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KqIx4XG89giB_xMabfg6ezGkpEFQhTR3uD_-JDArpRk_1776112523
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 10:00:58AM +0200, David Hildenbrand (Arm) wrote:
> On 4/13/26 00:50, Michael S. Tsirkin wrote:
> > When a guest reports free pages to the hypervisor via the page reporting
> > framework (used by virtio-balloon and hv_balloon), the host typically
> > zeros those pages when reclaiming their backing memory.  However, when
> > those pages are later allocated in the guest, post_alloc_hook()
> > unconditionally zeros them again if __GFP_ZERO is set.  This
> > double-zeroing is wasteful, especially for large pages.
> > 
> > Avoid redundant zeroing by propagating the "host already zeroed this"
> > information through the allocation path:
> > 
> > 1. Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
> >    drivers to declare that their host zeros reported pages on reclaim.
> >    A static key (page_reporting_host_zeroes) gates the fast path.
> > 
> > 2. In page_del_and_expand(), when the page was reported and the
> >    static key is enabled, stash a sentinel value (MAGIC_PAGE_ZEROED)
> >    in page->private.
> > 
> > 3. In post_alloc_hook(), check page->private for the sentinel.  If
> >    present and zeroing was requested (but not tag zeroing), skip
> >    kernel_init_pages().
> > 
> > In particular, __GFP_ZERO is used by the x86 arch override of
> > vma_alloc_zeroed_movable_folio.
> > 
> > No driver sets host_zeroes_pages yet; a follow-up patch to
> > virtio_balloon is needed to opt in.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  include/linux/mm.h             |  6 ++++++
> >  include/linux/page_reporting.h |  3 +++
> >  mm/page_alloc.c                | 21 +++++++++++++++++++++
> >  mm/page_reporting.c            |  9 +++++++++
> >  mm/page_reporting.h            |  2 ++
> >  5 files changed, 41 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 5be3d8a8f806..59fc77c4c90e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4814,6 +4814,12 @@ static inline bool user_alloc_needs_zeroing(void)
> >  				   &init_on_alloc);
> >  }
> >  
> > +/*
> > + * Sentinel stored in page->private to indicate the page was pre-zeroed
> > + * by the hypervisor (via free page reporting).
> > + */
> > +#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
> 
> Why are we not using another page flag that is yet unused for buddy pages?
> 
> Using page->private for that, and exposing it to buddy users with the
> __GFP_PREZEROED flag (I hope we can avoid that) does not sound
> particularly elegant.


So here's an only alternative I see: a page flag for when page is in
buddy and a new "prezero" bool that we have to propagate everywhere
else. This is a patch on top. More elegant? Please tell me if you prefer that.
If yes I will squash it into the appropriate patches.



diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 903f87c7fec9..b9c5bdbb0e7b 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -294,7 +294,7 @@ enum {
 #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN ((__force gfp_t)___GFP_SKIP_KASAN)
 
-/* Caller handles pre-zeroed pages; preserve MAGIC_PAGE_ZEROED in private */
+/* Caller handles pre-zeroed pages; preserve PagePrezeroed */
 #define __GFP_PREZEROED ((__force gfp_t)___GFP_PREZEROED)
 
 /* Disable lockdep for GFP context tracking */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index caa1de31bbca..3e46233d5758 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4814,11 +4814,21 @@ static inline bool user_alloc_needs_zeroing(void)
 				   &init_on_alloc);
 }
 
-/*
- * Sentinel stored in page->private to indicate the page was pre-zeroed
- * by the hypervisor (via free page reporting).
+/**
+ * __page_test_clear_prezeroed - test and clear the pre-zeroed marker.
+ * @page: the page to test.
+ *
+ * Returns true if the page was pre-zeroed by the host, and clears
+ * the marker. Caller must have exclusive access to @page.
  */
-#define MAGIC_PAGE_ZEROED	0x5A45524FU	/* ZERO */
+static inline bool __page_test_clear_prezeroed(struct page *page)
+{
+	if (PagePrezeroed(page)) {
+		__ClearPagePrezeroed(page);
+		return true;
+	}
+	return false;
+}
 
 /**
  * folio_test_clear_prezeroed - test and clear the pre-zeroed marker.
@@ -4829,11 +4839,7 @@ static inline bool user_alloc_needs_zeroing(void)
  */
 static inline bool folio_test_clear_prezeroed(struct folio *folio)
 {
-	if (page_private(&folio->page) == MAGIC_PAGE_ZEROED) {
-		set_page_private(&folio->page, 0);
-		return true;
-	}
-	return false;
+	return __page_test_clear_prezeroed(&folio->page);
 }
 
 int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f7a0e4af0c73..342f9baf2206 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -135,6 +135,8 @@ enum pageflags {
 	PG_swapcache = PG_owner_priv_1, /* Swap page: swp_entry_t in private */
 	/* Some filesystems */
 	PG_checked = PG_owner_priv_1,
+	/* Page contents are known to be zero */
+	PG_prezeroed = PG_owner_priv_1,
 
 	/*
 	 * Depending on the way an anonymous folio can be mapped into a page
@@ -679,6 +681,13 @@ FOLIO_TEST_CLEAR_FLAG_FALSE(young)
 FOLIO_FLAG_FALSE(idle)
 #endif
 
+/*
+ * PagePrezeroed() tracks pages known to be zero. The
+ * allocator may preserve this bit for __GFP_PREZEROED callers so they can
+ * skip redundant zeroing after allocation.
+ */
+__PAGEFLAG(Prezeroed, prezeroed, PF_NO_COMPOUND)
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..d3c024c5a88b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -82,7 +82,7 @@ static inline bool is_via_compact_memory(int order) { return false; }
 
 static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
 {
-	post_alloc_hook(page, order, __GFP_MOVABLE);
+	post_alloc_hook(page, order, __GFP_MOVABLE, false);
 	set_page_refcounted(page);
 	return page;
 }
@@ -1833,7 +1833,7 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 	}
 	dst = (struct folio *)freepage;
 
-	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, false);
 	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..ceb0b604c682 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -887,7 +887,8 @@ static inline void prep_compound_tail(struct page *head, int tail_idx)
 	set_page_private(p, 0);
 }
 
-void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
+		     bool prezeroed);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fba8321c45ed..57dc5195b29b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1528,6 +1528,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
+			if (PagePrezeroed(page))
+				__ClearPagePrezeroed(page);
 			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
@@ -1783,11 +1785,14 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 
 	/*
 	 * If the page was reported and the host is known to zero reported
-	 * pages, mark it zeroed via page->private so that
-	 * post_alloc_hook() can skip redundant zeroing.
+	 * pages, mark it pre-zeroed so post_alloc_hook() can skip
+	 * redundant zeroing.
 	 */
-	if (was_reported)
-		set_page_private(page, MAGIC_PAGE_ZEROED);
+	if (was_reported) {
+		__SetPagePrezeroed(page);
+	} else {
+		__ClearPagePrezeroed(page);
+	}
 }
 
 static void check_new_page_bad(struct page *page)
@@ -1859,21 +1864,20 @@ static inline bool should_skip_init(gfp_t flags)
 }
 
 inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
+				gfp_t gfp_flags, bool prezeroed)
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
-	bool prezeroed = page_private(page) == MAGIC_PAGE_ZEROED;
+	bool preserve_prezeroed = prezeroed && (gfp_flags & __GFP_PREZEROED);
 	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
 	int i;
 
 	/*
 	 * If the page is pre-zeroed and the caller opted in via
 	 * __GFP_PREZEROED, preserve the marker so the caller can
-	 * skip its own zeroing.  Otherwise always clear private.
+	 * skip its own zeroing.
 	 */
-	if (!(prezeroed && (gfp_flags & __GFP_PREZEROED)))
-		set_page_private(page, 0);
+	__ClearPagePrezeroed(page);
 
 	/*
 	 * If the page is pre-zeroed, skip memory initialization.
@@ -1923,15 +1927,18 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	if (init)
 		kernel_init_pages(page, 1 << order);
 
+	if (preserve_prezeroed)
+		__SetPagePrezeroed(page);
+
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
 	pgalloc_tag_add(page, current, 1 << order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-							unsigned int alloc_flags)
+			  unsigned int alloc_flags, bool prezeroed)
 {
-	post_alloc_hook(page, order, gfp_flags);
+	post_alloc_hook(page, order, gfp_flags, prezeroed);
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
@@ -3276,7 +3283,7 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 static __always_inline
 struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			   unsigned int order, unsigned int alloc_flags,
-			   int migratetype)
+			   int migratetype, bool *prezeroed)
 {
 	struct page *page;
 	unsigned long flags;
@@ -3311,6 +3318,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+		*prezeroed = __page_test_clear_prezeroed(page);
 	} while (check_new_pages(page, order));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -3372,10 +3380,9 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 /* Remove page from the per-cpu list, caller must protect the list */
 static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
-			int migratetype,
-			unsigned int alloc_flags,
+			int migratetype, unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			struct list_head *list, bool *prezeroed)
 {
 	struct page *page;
 
@@ -3396,6 +3403,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		page = list_first_entry(list, struct page, pcp_list);
 		list_del(&page->pcp_list);
 		pcp->count -= 1 << order;
+		*prezeroed = __page_test_clear_prezeroed(page);
 	} while (check_new_pages(page, order));
 
 	return page;
@@ -3404,7 +3412,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 /* Lock and remove page from the per-cpu list */
 static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			int migratetype, unsigned int alloc_flags)
+			int migratetype, unsigned int alloc_flags,
+			bool *prezeroed)
 {
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
@@ -3423,7 +3432,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp->free_count >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags,
+				 pcp, list, prezeroed);
 	pcp_spin_unlock(pcp, UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -3448,19 +3458,19 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype)
+			int migratetype, bool *prezeroed)
 {
 	struct page *page;
 
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
-				       migratetype, alloc_flags);
+				       migratetype, alloc_flags, prezeroed);
 		if (likely(page))
 			goto out;
 	}
 
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
-							migratetype);
+			     migratetype, prezeroed);
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3851,6 +3861,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool prezeroed;
 	bool skip_kswapd_nodes = nr_online_nodes > 1;
 	bool skipped_kswapd_nodes = false;
 
@@ -3995,9 +4006,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+					gfp_mask, alloc_flags, ac->migratetype,
+					&prezeroed);
 		if (page) {
-			prep_new_page(page, order, gfp_mask, alloc_flags);
+			prep_new_page(page, order, gfp_mask, alloc_flags,
+				      prezeroed);
 
 			/*
 			 * If this is a high-order atomic allocation then check
@@ -4232,7 +4245,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	/* Prep a captured page if available */
 	if (page)
-		prep_new_page(page, order, gfp_mask, alloc_flags);
+		prep_new_page(page, order, gfp_mask, alloc_flags, false);
 
 	/* Try get a page from the freelist if available */
 	if (!page)
@@ -5206,6 +5219,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* Attempt the batch allocation */
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 	while (nr_populated < nr_pages) {
+		bool prezeroed = false;
 
 		/* Skip existing pages */
 		if (page_array[nr_populated]) {
@@ -5214,7 +5228,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		}
 
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+					 pcp, pcp_list, &prezeroed);
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
@@ -5225,7 +5239,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, 0);
+		prep_new_page(page, 0, gfp, 0, prezeroed);
 		set_page_refcounted(page);
 		page_array[nr_populated++] = page;
 	}
@@ -6948,7 +6962,7 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
 		list_for_each_entry_safe(page, next, &list[order], lru) {
 			int i;
 
-			post_alloc_hook(page, order, gfp_mask);
+			post_alloc_hook(page, order, gfp_mask, false);
 			if (!order)
 				continue;
 
@@ -7154,7 +7168,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		struct page *head = pfn_to_page(start);
 
 		check_new_pages(head, order);
-		prep_new_page(head, order, gfp_mask, 0);
+		prep_new_page(head, order, gfp_mask, 0, false);
 	} else {
 		ret = -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",

