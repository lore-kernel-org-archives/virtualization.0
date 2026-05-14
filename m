Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48D3E274F
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767988; cv=none; b=p3k0juLjmNi29pGTqykJjHrc4rCAfBxnf/fkdk+6EvlVW92ZJUcmUt4DhYAhOM2bjuMHmubweB32l85puhqNMrOJcvYBd347v7TPTbP7oQ2K8dXrsEdVD80AkOD3YeM7ufZYTKKizFJYFkZtpYCKAadRQ4ljHSx5nPdXJwZtj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767988; c=relaxed/simple;
	bh=NJNVFkfIzkCaxXjwBX7QdlhMNTuFqm2iMxn/MCWlBNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENcdvTtYw4YJMaNeBdkyi4npHVUabncHxc1SZWjTFS0INEszKM5b9SXcUTntjBWf6ztkX+NJD5jefijKu31tYikgq4NlBgXVhPjsU4SeyY5VQTto4qFWs9R3xmkQnU+iZ77AbSQFYt3r7qdwXGfcOP/s3EM639czpy/NjFTzk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GezROq89; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GezROq89"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9116861f004so65095285a.3
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778767984; x=1779372784; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdtxd9PSffu+HE4bGsPEmj9mXykJ6HEMz0H7e7/moXw=;
        b=GezROq89N5dn05Os3NQkxi9fx45d6nBt0+TJFa5d/79RlvRpmq6fsue2qe91ALCAir
         11rsPA1yKt0FQq26KUoQvY3WoRpg695vHXZ7ZmNPCj8zurUaJYhygjGE0l55V1ue04sK
         h/qFJnLLUyKiAiQ66PMb3kkaDLIWndnHvm6fTBKilvR8ddXxDdoVriHyXWy8mpALSrgk
         lGyuvz20pmZXtlIkUj7TfCBDaKJOKx97AWxTk+ns6RFrjHou1i5w0Jp5UZHFvJ1GwFQy
         a73zG9/1DmZFPN7fzp2p/TC2qb734Xlv2wFs9ndWlirRsYNsDwTbSssIYkPfKmG3fNhe
         2l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767984; x=1779372784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wdtxd9PSffu+HE4bGsPEmj9mXykJ6HEMz0H7e7/moXw=;
        b=n3ieNCWKfSNwfnXjO/sBfUIB0yZlmcG7yKtzBBGwa3ViUSinjKKW6i7bl0oiLrq2BO
         C8LRiQd15iaCYRJGGVpHQRwqMuPBiyAwlggQv4cQzJyft0hRezja51DHTa/xtzo8EfND
         Sf+oD/0rvZ94aV0/NiA3gtLQRcLnq3V9RyE/7Ls8+W17kmOKyJo4+de/YyCwX3x10m8r
         JKPLL/n5jDEa6XDoIH2EIUR/KBd4NP63xynkWtxu9oxvVIRlL4+Zegwt4NEdJlQ0MMnK
         CUvtE2dfX4cAu4qE4mtBIIhr7bNdepw+tA/E+SHjY/IYabkf8uFqtHRwqzeIuyOO+HcB
         QKXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/JkaRooyhNO5Qn/Gx9Qdec77KZy9oAR2q7WWp0MhuyNYJwQU89jcMQ20pc7GVDAthu63Us4+3sLrzr/GWOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4GeLB5iYsPQEJKyLZ/eLTVanTbEg1QbXoInIKbVHbiUWEbFmu
	bG53BlPUq4fA+2IIPorttofpjF4m8wovCZInIVNVoYy+CyCCxPUdwvB3ua6z7tmco/U=
X-Gm-Gg: Acq92OG6nVBMtP4duPMT84BVyLAskAYlKIB49f6mzbucVgk/Z/zkwRSLtnOYHTQptGh
	DwfLdZLUlacxSjlQSfPVOTlMEo4fWQoVUi1H6EciCUn9d6nzr3DQB1fGaXhfkuwdQikbv1n6iY5
	6mC58ghUHO7v9GruqdisgimBbUuuWyKo9FZlnlrtAX6gx/z3srRfPAxCoWC379v+tKtZVZBgtJm
	L7KQYemMkppUfBnWz4vcxONT0Vf1OpVUu1dvvUJ/jzFF9W/Mpl7KvzBMU1WYg/RJjGqAQ3BSxCt
	MzlV6/T4x6+09Fhh/eOqaFfj46GYc7PwYDRD2OKe4Ni29ZjwkeXcvAgzDCZJyYfK7HV306A5ob6
	EWaD1nGmYz7azPOEafqTIjTUIEUOpbSNRzKDla7rSo3DpuNJuab+tVE4A36c6ZG/szOOhCpd4vZ
	XwEaTUNmGvaP/RD5ScyC8qqc/RxpTSz3ovoX9Lm2XQYlA71UzMSMaGUEGXdAXayrBo/DsDT3w1q
	bHaOyosNX2hebM8rqiOWZ0=
X-Received: by 2002:a05:620a:2887:b0:8ec:c4a7:f8ec with SMTP id af79cd13be357-90f882f7328mr1219731985a.4.1778767984204;
        Thu, 14 May 2026 07:13:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae24879sm273937985a.18.2026.05.14.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:13:03 -0700 (PDT)
Date: Thu, 14 May 2026 10:13:01 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
Subject: Re: [PATCH v7 19/31] mm: page_reporting: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <agXYbcuQYooG74pb@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <b6966bac2a4bb8027ec0383ed84b497e05d5f835.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6966bac2a4bb8027ec0383ed84b497e05d5f835.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:48PM -0400, Michael S. Tsirkin wrote:
> When a guest reports free pages to the hypervisor via the page reporting
> framework (used by virtio-balloon and hv_balloon), the host typically
> zeros those pages when reclaiming their backing memory.  However, when
> those pages are later allocated in the guest, post_alloc_hook()
> unconditionally zeros them again if __GFP_ZERO is set.  This
> double-zeroing is wasteful, especially for large pages.
> 
> Avoid redundant zeroing:
> 
> - Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
>   drivers to declare that their host zeros reported pages on reclaim.
>   A static key (page_reporting_host_zeroes) gates the fast path.
> 
> - Add PG_zeroed page flag (sharing PG_private bit) to mark pages
>   that have been zeroed by the host.  Set it in
>   page_reporting_drain() after the host reports them.
> 
> - Thread the zeroed bool through rmqueue -> prep_new_page ->
>   post_alloc_hook, where it skips redundant zeroing for __GFP_ZERO
>   allocations.
> 
> No driver sets host_zeroes_pages yet; a follow-up patch to
> virtio_balloon is needed to opt in.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  include/linux/page-flags.h     |  9 +++++
>  include/linux/page_reporting.h |  3 ++
>  mm/compaction.c                |  6 ++--
>  mm/internal.h                  |  2 +-
>  mm/page_alloc.c                | 66 +++++++++++++++++++++++-----------
>  mm/page_reporting.c            | 14 +++++++-
>  mm/page_reporting.h            | 12 +++++++
>  7 files changed, 87 insertions(+), 25 deletions(-)
> 

Similar question to prior comment - we're adding plumbing in this patch
specifically to handle the zeroed page flag.

Should we instead just take a snapshot of entire page flags state
and plumb that all the way through?

I imagine we might want future post-alloc ops that want to know about
buddy-internal state of the page, so it seems useful/extensible.

David and others may have a differing opinion on whether that should
wait for another user.

~Gregory

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0e03d816e8b9..4ee64134acc3 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,8 @@ enum pageflags {
>  	PG_swapcache = PG_owner_priv_1, /* Swap page: swp_entry_t in private */
>  	/* Some filesystems */
>  	PG_checked = PG_owner_priv_1,
> +	/* Page contents are known to be zero */
> +	PG_zeroed = PG_private,
>  
>  	/*
>  	 * Depending on the way an anonymous folio can be mapped into a page
> @@ -673,6 +675,13 @@ FOLIO_TEST_CLEAR_FLAG_FALSE(young)
>  FOLIO_FLAG_FALSE(idle)
>  #endif
>  
> +/*
> + * PageZeroed() tracks pages known to be zero.  The allocator
> + * uses this to skip redundant zeroing in post_alloc_hook().
> + */
> +__PAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
> +#define __PG_ZEROED (1UL << PG_zeroed)
> +
>  /*
>   * PageReported() is used to track reported free pages within the Buddy
>   * allocator. We can use the non-atomic version of the test and set
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 5ab5be02fa15..c331c6b36687 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -14,6 +14,9 @@ struct page_reporting_dev_info {
>  	int (*report)(struct page_reporting_dev_info *prdev,
>  		      struct scatterlist *sg, unsigned int nents);
>  
> +	/* If true, host zeros reported pages on reclaim */
> +	bool host_zeroes_pages;
> +
>  	/* work struct for processing reports */
>  	struct delayed_work work;
>  
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4336e433c99b..8000fc5e0a2e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -82,7 +82,8 @@ static inline bool is_via_compact_memory(int order) { return false; }
>  
>  static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
>  {
> -	post_alloc_hook(page, order, __GFP_MOVABLE, USER_ADDR_NONE);
> +	__ClearPageZeroed(page);
> +	post_alloc_hook(page, order, __GFP_MOVABLE, false, USER_ADDR_NONE);
>  	set_page_refcounted(page);
>  	return page;
>  }
> @@ -1849,9 +1850,10 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
>  		set_page_private(&freepage[size], start_order);
>  	}
>  	dst = (struct folio *)freepage;
> +	__ClearPageZeroed(&dst->page);
>  	if (order)
>  		prep_compound_page(&dst->page, order);
> -	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
> +	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, false, USER_ADDR_NONE);
>  	set_page_refcounted(&dst->page);
>  	cc->nr_freepages -= 1 << order;
>  	cc->nr_migratepages -= 1 << order;
> diff --git a/mm/internal.h b/mm/internal.h
> index 389098200aa6..fd910743ddc3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -928,7 +928,7 @@ static inline void init_compound_tail(struct page *tail,
>  }
>  
>  void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
> -		     unsigned long user_addr);
> +		     bool zeroed, unsigned long user_addr);
>  extern bool free_pages_prepare(struct page *page, unsigned int order);
>  
>  extern int user_min_free_kbytes;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 76f39dd026ff..bd3b909cacdf 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1743,6 +1743,7 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  	bool was_reported = page_reported(page);
>  
>  	__del_page_from_free_list(page, zone, high, migratetype);
> +
>  	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
>  	account_freepages(zone, -nr_pages, migratetype);
>  }
> @@ -1815,8 +1816,10 @@ static inline bool should_skip_init(gfp_t flags)
>  	return (flags & __GFP_SKIP_ZERO);
>  }
>  
> +
>  inline void post_alloc_hook(struct page *page, unsigned int order,
> -				gfp_t gfp_flags, unsigned long user_addr)
> +				gfp_t gfp_flags, bool zeroed,
> +				unsigned long user_addr)
>  {
>  	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
>  			!should_skip_init(gfp_flags);
> @@ -1825,6 +1828,14 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  
>  	set_page_private(page, 0);
>  
> +	/*
> +	 * If the page is zeroed, skip memory initialization.
> +	 * We still need to handle tag zeroing separately since the host
> +	 * does not know about memory tags.
> +	 */
> +	if (zeroed && init && !zero_tags)
> +		init = false;
> +
>  	arch_alloc_page(page, order);
>  	debug_pagealloc_map_pages(page, 1 << order);
>  
> @@ -1882,13 +1893,13 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  }
>  
>  static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
> -							unsigned int alloc_flags,
> -							unsigned long user_addr)
> +			  unsigned int alloc_flags, bool zeroed,
> +			  unsigned long user_addr)
>  {
>  	if (order && (gfp_flags & __GFP_COMP))
>  		prep_compound_page(page, order);
>  
> -	post_alloc_hook(page, order, gfp_flags, user_addr);
> +	post_alloc_hook(page, order, gfp_flags, zeroed, user_addr);
>  
>  	/*
>  	 * page is set pfmemalloc when ALLOC_NO_WATERMARKS was necessary to
> @@ -3154,6 +3165,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
>  	}
>  
>  	del_page_from_free_list(page, zone, order, mt);
> +	__ClearPageZeroed(page);
>  
>  	/*
>  	 * Set the pageblock if the isolated page is at least half of a
> @@ -3226,7 +3238,7 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
>  static __always_inline
>  struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  			   unsigned int order, unsigned int alloc_flags,
> -			   int migratetype)
> +			   int migratetype, bool *zeroed)
>  {
>  	struct page *page;
>  	unsigned long flags;
> @@ -3261,6 +3273,8 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  			}
>  		}
>  		spin_unlock_irqrestore(&zone->lock, flags);
> +		*zeroed = PageZeroed(page);
> +		__ClearPageZeroed(page);
>  	} while (check_new_pages(page, order));
>  
>  	/*
> @@ -3329,10 +3343,9 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
>  /* Remove page from the per-cpu list, caller must protect the list */
>  static inline
>  struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
> -			int migratetype,
> -			unsigned int alloc_flags,
> +			int migratetype, unsigned int alloc_flags,
>  			struct per_cpu_pages *pcp,
> -			struct list_head *list)
> +			struct list_head *list, bool *zeroed)
>  {
>  	struct page *page;
>  
> @@ -3367,6 +3380,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  		page = list_first_entry(list, struct page, pcp_list);
>  		list_del(&page->pcp_list);
>  		pcp->count -= 1 << order;
> +		*zeroed = PageZeroed(page);
> +		__ClearPageZeroed(page);
>  	} while (check_new_pages(page, order));
>  
>  	return page;
> @@ -3375,7 +3390,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  /* Lock and remove page from the per-cpu list */
>  static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  			struct zone *zone, unsigned int order,
> -			int migratetype, unsigned int alloc_flags)
> +			int migratetype, unsigned int alloc_flags,
> +			bool *zeroed)
>  {
>  	struct per_cpu_pages *pcp;
>  	struct list_head *list;
> @@ -3393,7 +3409,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	 */
>  	pcp->free_count >>= 1;
>  	list = &pcp->lists[order_to_pindex(migratetype, order)];
> -	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
> +	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags,
> +				 pcp, list, zeroed);
>  	pcp_spin_unlock(pcp);
>  	if (page) {
>  		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
> @@ -3418,19 +3435,19 @@ static inline
>  struct page *rmqueue(struct zone *preferred_zone,
>  			struct zone *zone, unsigned int order,
>  			gfp_t gfp_flags, unsigned int alloc_flags,
> -			int migratetype)
> +			int migratetype, bool *zeroed)
>  {
>  	struct page *page;
>  
>  	if (likely(pcp_allowed_order(order))) {
>  		page = rmqueue_pcplist(preferred_zone, zone, order,
> -				       migratetype, alloc_flags);
> +				       migratetype, alloc_flags, zeroed);
>  		if (likely(page))
>  			goto out;
>  	}
>  
>  	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
> -							migratetype);
> +			     migratetype, zeroed);
>  
>  out:
>  	/* Separate test+clear to avoid unnecessary atomics */
> @@ -3821,6 +3838,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  	struct pglist_data *last_pgdat = NULL;
>  	bool last_pgdat_dirty_ok = false;
>  	bool no_fallback;
> +	bool zeroed;
>  	bool skip_kswapd_nodes = nr_online_nodes > 1;
>  	bool skipped_kswapd_nodes = false;
>  
> @@ -3965,10 +3983,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  
>  try_this_zone:
>  		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
> -				gfp_mask, alloc_flags, ac->migratetype);
> +					gfp_mask, alloc_flags, ac->migratetype,
> +					&zeroed);
>  		if (page) {
>  			prep_new_page(page, order, gfp_mask, alloc_flags,
> -				      ac->user_addr);
> +				      zeroed, ac->user_addr);
>  
>  			return page;
>  		} else {
> @@ -4195,9 +4214,11 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  	count_vm_event(COMPACTSTALL);
>  
>  	/* Prep a captured page if available */
> -	if (page)
> -		prep_new_page(page, order, gfp_mask, alloc_flags,
> +	if (page) {
> +		__ClearPageZeroed(page);
> +		prep_new_page(page, order, gfp_mask, alloc_flags, false,
>  			      ac->user_addr);
> +	}
>  
>  	/* Try get a page from the freelist if available */
>  	if (!page)
> @@ -5170,6 +5191,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  	/* Attempt the batch allocation */
>  	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
>  	while (nr_populated < nr_pages) {
> +		bool zeroed = false;
>  
>  		/* Skip existing pages */
>  		if (page_array[nr_populated]) {
> @@ -5178,7 +5200,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  		}
>  
>  		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
> -								pcp, pcp_list);
> +					 pcp, pcp_list, &zeroed);
>  		if (unlikely(!page)) {
>  			/* Try and allocate at least one page */
>  			if (!nr_account) {
> @@ -5189,7 +5211,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  		}
>  		nr_account++;
>  
> -		prep_new_page(page, 0, gfp, 0, USER_ADDR_NONE);
> +		prep_new_page(page, 0, gfp, 0, zeroed, USER_ADDR_NONE);
>  		set_page_refcounted(page);
>  		page_array[nr_populated++] = page;
>  	}
> @@ -6929,7 +6951,8 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
>  		list_for_each_entry_safe(page, next, &list[order], lru) {
>  			int i;
>  
> -			post_alloc_hook(page, order, gfp_mask, USER_ADDR_NONE);
> +			__ClearPageZeroed(page);
> +			post_alloc_hook(page, order, gfp_mask, false, USER_ADDR_NONE);
>  			if (!order)
>  				continue;
>  
> @@ -7134,8 +7157,9 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>  	} else if (start == outer_start && end == outer_end && is_power_of_2(end - start)) {
>  		struct page *head = pfn_to_page(start);
>  
> +		__ClearPageZeroed(head);
>  		check_new_pages(head, order);
> -		prep_new_page(head, order, gfp_mask, 0, USER_ADDR_NONE);
> +		prep_new_page(head, order, gfp_mask, 0, false, USER_ADDR_NONE);
>  	} else {
>  		ret = -EINVAL;
>  		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 006f7cdddc18..37e4fce9eb38 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -50,6 +50,8 @@ EXPORT_SYMBOL_GPL(page_reporting_order);
>  #define PAGE_REPORTING_DELAY	(2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>  
> +DEFINE_STATIC_KEY_FALSE(page_reporting_host_zeroes);
> +
>  enum {
>  	PAGE_REPORTING_IDLE = 0,
>  	PAGE_REPORTING_REQUESTED,
> @@ -129,8 +131,11 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
>  		 * report on the new larger page when we make our way
>  		 * up to that higher order.
>  		 */
> -		if (PageBuddy(page) && buddy_order(page) == order)
> +		if (PageBuddy(page) && buddy_order(page) == order) {
>  			__SetPageReported(page);
> +			if (page_reporting_host_zeroes_pages())
> +				__SetPageZeroed(page);
> +		}
>  	} while ((sg = sg_next(sg)));
>  
>  	/* reinitialize scatterlist now that it is empty */
> @@ -391,6 +396,10 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>  	/* Assign device to allow notifications */
>  	rcu_assign_pointer(pr_dev_info, prdev);
>  
> +	/* enable zeroed page optimization if host zeroes reported pages */
> +	if (prdev->host_zeroes_pages)
> +		static_branch_enable(&page_reporting_host_zeroes);
> +
>  	/* enable page reporting notification */
>  	if (!static_key_enabled(&page_reporting_enabled)) {
>  		static_branch_enable(&page_reporting_enabled);
> @@ -415,6 +424,9 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
>  
>  		/* Flush any existing work, and lock it out */
>  		cancel_delayed_work_sync(&prdev->work);
> +
> +		if (prdev->host_zeroes_pages)
> +			static_branch_disable(&page_reporting_host_zeroes);
>  	}
>  
>  	mutex_unlock(&page_reporting_mutex);
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index c51dbc228b94..736ea7b37e9e 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -15,6 +15,13 @@ DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>  extern unsigned int page_reporting_order;
>  void __page_reporting_notify(void);
>  
> +DECLARE_STATIC_KEY_FALSE(page_reporting_host_zeroes);
> +
> +static inline bool page_reporting_host_zeroes_pages(void)
> +{
> +	return static_branch_unlikely(&page_reporting_host_zeroes);
> +}
> +
>  static inline bool page_reported(struct page *page)
>  {
>  	return static_branch_unlikely(&page_reporting_enabled) &&
> @@ -46,6 +53,11 @@ static inline void page_reporting_notify_free(unsigned int order)
>  #else /* CONFIG_PAGE_REPORTING */
>  #define page_reported(_page)	false
>  
> +static inline bool page_reporting_host_zeroes_pages(void)
> +{
> +	return false;
> +}
> +
>  static inline void page_reporting_notify_free(unsigned int order)
>  {
>  }
> -- 
> MST
> 
