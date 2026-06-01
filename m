Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137E367B8A
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315645; cv=none; b=ht5QsVb8qipelaiohN2jFEzLlDyRbH6FSGnMEPBjZMRtnACdzhB0q3M90EnaSTib0IJDN6GTn8/rD/HybnqUMVnoiarn80pKVvjb2OVSFX4/CBIKUN+LFecviYlHIOsEr6p9zq0Rjef5CL6AIDWpCoG0t0wgTmd3EQCgmIkkUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315645; c=relaxed/simple;
	bh=D+YhP7JqeVK1cd7S+xdhX0eKs9LMo3V4Y3EcVSHZNCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b5s/qSw9wQOlZ72PWH2gO3oHQKStOspLhUH/TPXrNWlXqw5DH+0Zl5XbyHcsGsfqVgnGNqm9pz997oFT0/TWmeWa995dS5BeiE1phsYmCm68ZDm6IweBRXhLmzeoYOBZWbEVJ3vcPCufFd58vonZj0fWH0p+z359wqLG1TQNUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGp3VdzD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGp3VdzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780315642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6CzF1sm1t6LcN5j1kxM/c5/Y63P6D9+npzxAyQXHUEE=;
	b=QGp3VdzDlpwA7pG6ql/8/MZMDanxHooPePkITWiGDEbixtO7/0b1HgdapC4QuxCKNcomHL
	rnB7hS5fVXyOpAdUMXLgm3UId9bcQmRkwlV3HOVSzDh+lTw/X/MosFcPXh1Z6voZjMtJ+8
	IY/QiAnrQAGFXrGxrgtGUkcwz/iiuOQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-s83p62b1PheyKMMVuARzsg-1; Mon, 01 Jun 2026 08:06:12 -0400
X-MC-Unique: s83p62b1PheyKMMVuARzsg-1
X-Mimecast-MFC-AGG-ID: s83p62b1PheyKMMVuARzsg_1780315571
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-beb6d964066so109114866b.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 05:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315571; x=1780920371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CzF1sm1t6LcN5j1kxM/c5/Y63P6D9+npzxAyQXHUEE=;
        b=WGDvd1vOQHQyd/ZnlaITpvX0Dsglqnde4ATZtszXTctlG1vi8JOT7REj2kbbRGAyuE
         rXDYiavPR9L6EELCGUgCki5oMo72O7mv9LSy0ijQgBpATifY5eEwRhjO1kelhEPNcZP4
         hC6r9ZU8eTR1aVsCuprVF9mjMwoIgSdT3omdVMBONfJw8kYGHoXRj7grYtrBwtb3M27r
         YN/Xyzfz/Pk6153HXmp+FIFZV2CO1Tkm/kr6o7Svhv7Khan+Nk3JTD8OiOM85u3gc/QX
         Iks4LJ5M56so0z/VFi7JdMqCUYPuo9WRJE5mxutcWLIXeqhMnXtROIuukEdHUEL8mzNv
         xLnA==
X-Forwarded-Encrypted: i=1; AFNElJ93OtadydHFZD/s5/dYglXQz6iagZWxXsDJg30Eb/RQvz89UB6KiJ7yIftx2dYZzzpkBreu+WEeMZy0TeG+pQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxMRdT4euyn9fKduZyb5ZpzbOz0gQkueb/e3ISQFt1UzfYI/gd
	CPW14Qj+wr4YuCT6hFA+5mgmn8gLXA5EznxpirWZXGJXWkplwbbp6GTpx6cRQY5OX6sqQQmpsYj
	iIGkJ4+WgUE7sbW2s68ZM8OLP7xhhj7uKcK6cebf9ikJz1HeO7FBraMI2WUIkHxrqZhBl
X-Gm-Gg: Acq92OE3prWJ+0C/xGUyoVeJkXJt9YFBBAX+qNl8pwEPAw1VIeEzRfiuOJtZVYcm+1i
	gJJj/Lg/+RvezJbc8GV8ilwa+R1s4Ip6sWhU+JF5ON037LsCII+EbcA4fNO9c5XGm5goIOQV+/P
	/4We4tSQZmAxeGL0ocQdrgSwgWP+2aK6bxMu34PE1BlBEWJJd2vFqHulaeBbbUOGuQSLRPgMP4R
	shmT9q7MM3PNaZTu6eYdCNQ03bus+PMjdcGUBOrSXvuufgr38xgo1J84+Z1w3QXDH+Dcx56vpzn
	lFIR0nAjZS1e46hX/ioKKsV179Ml1rVtOH5P0gFiqux2yJ+JVmxGtjSIsFLr3nf0onnc6k2uZ3V
	9DRpvQoa+b8UpKAUwQkLk/E99aYXDGM7+AsLYWlH544YKHsSAbd4rxw==
X-Received: by 2002:a17:907:3e0a:b0:bcb:66df:819a with SMTP id a640c23a62f3a-beab1e809cdmr565363566b.40.1780315570228;
        Mon, 01 Jun 2026 05:06:10 -0700 (PDT)
X-Received: by 2002:a17:907:3e0a:b0:bcb:66df:819a with SMTP id a640c23a62f3a-beab1e809cdmr565353666b.40.1780315569312;
        Mon, 01 Jun 2026 05:06:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9d32d37b2sm328665566b.24.2026.06.01.05.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:06:08 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:06:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH v9 07/37] mm: thread user_addr through page allocator for
 cache-friendly zeroing
Message-ID: <20260601075807-mutt-send-email-mst@kernel.org>
References: <cover.1780067977.git.mst@redhat.com>
 <a526a713dbba63c7a69df37b67ed1590f77fefd3.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <a526a713dbba63c7a69df37b67ed1590f77fefd3.1780067977.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6bQ7xwrhUxf2CipZ2rHq7ZfN1kcn7nS_xUElGWSoH74_1780315571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2026 at 11:22:42AM -0400, Michael S. Tsirkin wrote:
> Thread a user virtual address from vma_alloc_folio() down through
> the page allocator to post_alloc_hook(). This is plumbing
> preparation for a subsequent patch that will use user_addr to
> call folio_zero_user() for cache-friendly zeroing of user pages.
> 
> The user_addr is stored in struct alloc_context and flows through:
>   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
>   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
>   post_alloc_hook
> 
> USER_ADDR_NONE ((unsigned long)-1) is used for non-user
> allocations, since address 0 is a valid userspace mapping.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  include/linux/gfp.h |  2 +-
>  mm/compaction.c     |  5 ++---
>  mm/hugetlb.c        | 36 ++++++++++++++++++++----------------
>  mm/internal.h       | 22 +++++++++++++++++++---
>  mm/mempolicy.c      | 44 ++++++++++++++++++++++++++++++++------------
>  mm/mmap.c           |  6 ++++++
>  mm/page_alloc.c     | 44 +++++++++++++++++++++++++++++---------------
>  mm/slub.c           |  4 ++--
>  8 files changed, 111 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 7ccbda35b9ad..ee35c5367abc 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -337,7 +337,7 @@ static inline struct folio *folio_alloc_noprof(gfp_t gfp, unsigned int order)
>  static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
>  		struct mempolicy *mpol, pgoff_t ilx, int nid)
>  {
> -	return folio_alloc_noprof(gfp, order);
> +	return __folio_alloc_noprof(gfp, order, numa_node_id(), NULL);
>  }
>  #endif
>  
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3648ce22c807..72684fe81e83 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -82,7 +82,7 @@ static inline bool is_via_compact_memory(int order) { return false; }
>  
>  static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
>  {
> -	post_alloc_hook(page, order, __GFP_MOVABLE);
> +	post_alloc_hook(page, order, __GFP_MOVABLE, USER_ADDR_NONE);
>  	set_page_refcounted(page);
>  	return page;
>  }
> @@ -1849,8 +1849,7 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
>  		set_page_private(&freepage[size], start_order);
>  	}
>  	dst = (struct folio *)freepage;
> -
> -	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
> +	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
>  	set_page_refcounted(&dst->page);
>  	if (order)
>  		prep_compound_page(&dst->page, order);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f24bf49be047..a999f3ead852 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1806,7 +1806,8 @@ struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
>  }
>  
>  static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
> -		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry)
> +		int nid, nodemask_t *nmask, nodemask_t *node_alloc_noretry,
> +		unsigned long addr)
>  {
>  	struct folio *folio;
>  	bool alloc_try_hard = true;
> @@ -1823,7 +1824,7 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
>  	if (alloc_try_hard)
>  		gfp_mask |= __GFP_RETRY_MAYFAIL;
>  
> -	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask);
> +	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask, addr);
>  
>  	/*
>  	 * If we did not specify __GFP_RETRY_MAYFAIL, but still got a
> @@ -1852,7 +1853,7 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
>  
>  static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
>  		gfp_t gfp_mask, int nid, nodemask_t *nmask,
> -		nodemask_t *node_alloc_noretry)
> +		nodemask_t *node_alloc_noretry, unsigned long addr)
>  {
>  	struct folio *folio;
>  	int order = huge_page_order(h);
> @@ -1864,7 +1865,7 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
>  		folio = alloc_gigantic_frozen_folio(order, gfp_mask, nid, nmask);
>  	else
>  		folio = alloc_buddy_frozen_folio(order, gfp_mask, nid, nmask,
> -						 node_alloc_noretry);
> +						 node_alloc_noretry, addr);
>  	if (folio)
>  		init_new_hugetlb_folio(folio);
>  	return folio;
> @@ -1878,11 +1879,12 @@ static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
>   * pages is zero, and the accounting must be done in the caller.
>   */
>  static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
> -		gfp_t gfp_mask, int nid, nodemask_t *nmask)
> +		gfp_t gfp_mask, int nid, nodemask_t *nmask,
> +		unsigned long addr)
>  {
>  	struct folio *folio;
>  
> -	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
> +	folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL, addr);
>  	if (folio)
>  		hugetlb_vmemmap_optimize_folio(h, folio);
>  	return folio;
> @@ -1922,7 +1924,7 @@ static struct folio *alloc_pool_huge_folio(struct hstate *h,
>  		struct folio *folio;
>  
>  		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
> -					nodes_allowed, node_alloc_noretry);
> +					nodes_allowed, node_alloc_noretry, USER_ADDR_NONE);
>  		if (folio)
>  			return folio;
>  	}
> @@ -2091,7 +2093,8 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn, unsigned long end_pfn)
>   * Allocates a fresh surplus page from the page allocator.
>   */
>  static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
> -				gfp_t gfp_mask,	int nid, nodemask_t *nmask)
> +				gfp_t gfp_mask,	int nid, nodemask_t *nmask,
> +				unsigned long addr)
>  {
>  	struct folio *folio = NULL;
>  
> @@ -2103,7 +2106,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  		goto out_unlock;
>  	spin_unlock_irq(&hugetlb_lock);
>  
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
> +	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, addr);
>  	if (!folio)
>  		return NULL;
>  
> @@ -2146,7 +2149,7 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
>  	if (hstate_is_gigantic(h))
>  		return NULL;
>  
> -	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask);
> +	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, USER_ADDR_NONE);
>  	if (!folio)
>  		return NULL;
>  
> @@ -2182,14 +2185,14 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
>  	if (mpol_is_preferred_many(mpol)) {
>  		gfp_t gfp = gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
>  
> -		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask);
> +		folio = alloc_surplus_hugetlb_folio(h, gfp, nid, nodemask, addr);
>  
>  		/* Fallback to all nodes if page==NULL */
>  		nodemask = NULL;
>  	}
>  
>  	if (!folio)
> -		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask);
> +		folio = alloc_surplus_hugetlb_folio(h, gfp_mask, nid, nodemask, addr);
>  	mpol_cond_put(mpol);
>  	return folio;
>  }
> @@ -2296,7 +2299,8 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>  		 * down the road to pick the current node if that is the case.
>  		 */
>  		folio = alloc_surplus_hugetlb_folio(h, htlb_alloc_mask(h),
> -						    NUMA_NO_NODE, &alloc_nodemask);
> +						    NUMA_NO_NODE, &alloc_nodemask,
> +						    USER_ADDR_NONE);
>  		if (!folio) {
>  			alloc_ok = false;
>  			break;
> @@ -2702,7 +2706,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct folio *old_folio,
>  			spin_unlock_irq(&hugetlb_lock);
>  			gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  			new_folio = alloc_fresh_hugetlb_folio(h, gfp_mask,
> -							      nid, NULL);
> +							      nid, NULL, USER_ADDR_NONE);
>  			if (!new_folio)
>  				return -ENOMEM;
>  			goto retry;
> @@ -3400,13 +3404,13 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
>  			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  
>  			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
> -					&node_states[N_MEMORY], NULL);
> +					&node_states[N_MEMORY], NULL, USER_ADDR_NONE);
>  			if (!folio && !list_empty(&folio_list) &&
>  			    hugetlb_vmemmap_optimizable_size(h)) {
>  				prep_and_add_allocated_folios(h, &folio_list);
>  				INIT_LIST_HEAD(&folio_list);
>  				folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
> -						&node_states[N_MEMORY], NULL);
> +						&node_states[N_MEMORY], NULL, USER_ADDR_NONE);
>  			}
>  			if (!folio)
>  				break;
> diff --git a/mm/internal.h b/mm/internal.h
> index 5a2ddcf68e0b..389098200aa6 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -662,6 +662,16 @@ void calculate_min_free_kbytes(void);
>  int __meminit init_per_zone_wmark_min(void);
>  void page_alloc_sysctl_init(void);
>  
> +/*
> + * Sentinel for user_addr: indicates a non-user allocation.
> + * Cannot use 0 because address 0 is a valid userspace mapping.
> + * (unsigned long)-1 is safe because:
> + * 1. vm_end = addr + len <= TASK_SIZE, and vm_end is exclusive,
> + *    so -1 is never inside any VMA.
> + * 2. It will only be compared to page-aligned addresses.
> + */
> +#define USER_ADDR_NONE	((unsigned long)-1)
> +
>  /*
>   * Structure for holding the mostly immutable allocation parameters passed
>   * between functions involved in allocations, including the alloc_pages*
> @@ -693,6 +703,7 @@ struct alloc_context {
>  	 */
>  	enum zone_type highest_zoneidx;
>  	bool spread_dirty_pages;
> +	unsigned long user_addr;
>  };
>  
>  /*
> @@ -916,24 +927,29 @@ static inline void init_compound_tail(struct page *tail,
>  	prep_compound_tail(tail, head, order);
>  }
>  
> -void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
> +void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
> +		     unsigned long user_addr);
>  extern bool free_pages_prepare(struct page *page, unsigned int order);
>  
>  extern int user_min_free_kbytes;
>  
>  struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
> -		nodemask_t *);
> +		nodemask_t *, unsigned long user_addr);
>  #define __alloc_frozen_pages(...) \
>  	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
>  void free_frozen_pages(struct page *page, unsigned int order);
> +void free_frozen_pages_zeroed(struct page *page, unsigned int order);


sashiko pointed this one out:
https://sashiko.dev/#/patchset/cover.1780067977.git.mst%40redhat.com?part=7

this landed here by mistake during one of the rebases, harmless but
ideally belongs in patch 33.  Will move if there's v10.

it's other findings on this patch seem like false positives.

>  void free_unref_folios(struct folio_batch *fbatch);
>  
>  #ifdef CONFIG_NUMA
>  struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
> +struct folio *folio_alloc_mpol_user_noprof(gfp_t gfp, unsigned int order,
> +		struct mempolicy *pol, pgoff_t ilx, int nid,
> +		unsigned long user_addr);
>  #else
>  static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order)
>  {
> -	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL);
> +	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL, USER_ADDR_NONE);
>  }
>  #endif
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a1707ad498a8..f573ff32e94d 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2413,7 +2413,8 @@ bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  }
>  
>  static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
> -						int nid, nodemask_t *nodemask)
> +						int nid, nodemask_t *nodemask,
> +						unsigned long user_addr)
>  {
>  	struct page *page;
>  	gfp_t preferred_gfp;
> @@ -2426,25 +2427,29 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
>  	 */
>  	preferred_gfp = gfp | __GFP_NOWARN;
>  	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> -	page = __alloc_frozen_pages_noprof(preferred_gfp, order, nid, nodemask);
> +	page = __alloc_frozen_pages_noprof(preferred_gfp, order, nid,
> +					   nodemask, user_addr);
>  	if (!page)
> -		page = __alloc_frozen_pages_noprof(gfp, order, nid, NULL);
> +		page = __alloc_frozen_pages_noprof(gfp, order, nid, NULL,
> +						   user_addr);
>  
>  	return page;
>  }
>  
>  /**
> - * alloc_pages_mpol - Allocate pages according to NUMA mempolicy.
> + * __alloc_pages_mpol - Allocate pages according to NUMA mempolicy.
>   * @gfp: GFP flags.
>   * @order: Order of the page allocation.
>   * @pol: Pointer to the NUMA mempolicy.
>   * @ilx: Index for interleave mempolicy (also distinguishes alloc_pages()).
>   * @nid: Preferred node (usually numa_node_id() but @mpol may override it).
> + * @user_addr: User fault address for cache-friendly zeroing, or USER_ADDR_NONE.
>   *
>   * Return: The page on success or NULL if allocation fails.
>   */
> -static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
> -		struct mempolicy *pol, pgoff_t ilx, int nid)
> +static struct page *__alloc_pages_mpol(gfp_t gfp, unsigned int order,
> +		struct mempolicy *pol, pgoff_t ilx, int nid,
> +		unsigned long user_addr)
>  {
>  	nodemask_t *nodemask;
>  	struct page *page;
> @@ -2452,7 +2457,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
>  
>  	if (pol->mode == MPOL_PREFERRED_MANY)
> -		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
> +		return alloc_pages_preferred_many(gfp, order, nid, nodemask,
> +						 user_addr);
>  
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>  	    /* filter "hugepage" allocation, unless from alloc_pages() */
> @@ -2476,7 +2482,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  			 */
>  			page = __alloc_frozen_pages_noprof(
>  				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
> -				nid, NULL);
> +				nid, NULL, user_addr);
>  			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
>  				return page;
>  			/*
> @@ -2488,7 +2494,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  		}
>  	}
>  
> -	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
> +	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, user_addr);
>  
>  	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
>  		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
> @@ -2504,11 +2510,18 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  	return page;
>  }
>  
> -struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
> +static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
>  		struct mempolicy *pol, pgoff_t ilx, int nid)
>  {
> -	struct page *page = alloc_pages_mpol(gfp | __GFP_COMP, order, pol,
> -			ilx, nid);
> +	return __alloc_pages_mpol(gfp, order, pol, ilx, nid, USER_ADDR_NONE);
> +}
> +
> +struct folio *folio_alloc_mpol_user_noprof(gfp_t gfp, unsigned int order,
> +		struct mempolicy *pol, pgoff_t ilx, int nid,
> +		unsigned long user_addr)
> +{
> +	struct page *page = __alloc_pages_mpol(gfp | __GFP_COMP, order, pol,
> +			ilx, nid, user_addr);
>  	if (!page)
>  		return NULL;
>  
> @@ -2516,6 +2529,13 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
>  	return page_rmappable_folio(page);
>  }
>  
> +struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
> +		struct mempolicy *pol, pgoff_t ilx, int nid)
> +{
> +	return folio_alloc_mpol_user_noprof(gfp, order, pol, ilx, nid,
> +					    USER_ADDR_NONE);
> +}
> +
>  struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
>  {
>  	struct mempolicy *pol = &default_policy;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5754d1c36462..73413cebc418 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -855,6 +855,12 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  	if (IS_ERR_VALUE(addr))
>  		return addr;
>  
> +	/*
> +	 * The check below ensures vm_end = addr + len <= TASK_SIZE.
> +	 * Since (unsigned long)-1 (USER_ADDR_NONE) >= TASK_SIZE and
> +	 * vm_end is exclusive, USER_ADDR_NONE is thus never a valid
> +	 * userspace address.
> +	 */
>  	if (addr > TASK_SIZE - len)
>  		return -ENOMEM;
>  	if (offset_in_page(addr))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0c4f4c678233..b96c9892f6c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1819,7 +1819,7 @@ static inline bool should_skip_init(gfp_t flags)
>  }
>  
>  inline void post_alloc_hook(struct page *page, unsigned int order,
> -				gfp_t gfp_flags)
> +				gfp_t gfp_flags, unsigned long user_addr)
>  {
>  	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
>  			!should_skip_init(gfp_flags);
> @@ -1874,9 +1874,10 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  }
>  
>  static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
> -							unsigned int alloc_flags)
> +							unsigned int alloc_flags,
> +							unsigned long user_addr)
>  {
> -	post_alloc_hook(page, order, gfp_flags);
> +	post_alloc_hook(page, order, gfp_flags, user_addr);
>  
>  	if (order && (gfp_flags & __GFP_COMP))
>  		prep_compound_page(page, order);
> @@ -3958,7 +3959,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
>  				gfp_mask, alloc_flags, ac->migratetype);
>  		if (page) {
> -			prep_new_page(page, order, gfp_mask, alloc_flags);
> +			prep_new_page(page, order, gfp_mask, alloc_flags,
> +				      ac->user_addr);
>  
>  			return page;
>  		} else {
> @@ -4186,7 +4188,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  
>  	/* Prep a captured page if available */
>  	if (page)
> -		prep_new_page(page, order, gfp_mask, alloc_flags);
> +		prep_new_page(page, order, gfp_mask, alloc_flags,
> +			      ac->user_addr);
>  
>  	/* Try get a page from the freelist if available */
>  	if (!page)
> @@ -5063,7 +5066,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  	struct zoneref *z;
>  	struct per_cpu_pages *pcp;
>  	struct list_head *pcp_list;
> -	struct alloc_context ac;
> +	struct alloc_context ac = { .user_addr = USER_ADDR_NONE };
>  	gfp_t alloc_gfp;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	int nr_populated = 0, nr_account = 0;
> @@ -5178,7 +5181,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  		}
>  		nr_account++;
>  
> -		prep_new_page(page, 0, gfp, 0);
> +		prep_new_page(page, 0, gfp, 0, USER_ADDR_NONE);
>  		set_page_refcounted(page);
>  		page_array[nr_populated++] = page;
>  	}
> @@ -5203,12 +5206,13 @@ EXPORT_SYMBOL_GPL(alloc_pages_bulk_noprof);
>   * This is the 'heart' of the zoned buddy allocator.
>   */
>  struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> -		int preferred_nid, nodemask_t *nodemask)
> +		int preferred_nid, nodemask_t *nodemask,
> +		unsigned long user_addr)
>  {
>  	struct page *page;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
> -	struct alloc_context ac = { };
> +	struct alloc_context ac = { .user_addr = user_addr };
>  
>  	/*
>  	 * There are several places where we assume that the order value is sane
> @@ -5269,10 +5273,12 @@ EXPORT_SYMBOL(__alloc_frozen_pages_noprof);
>  
>  struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>  		int preferred_nid, nodemask_t *nodemask)
> +
>  {
>  	struct page *page;
>  
> -	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask);
> +	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid,
> +					   nodemask, USER_ADDR_NONE);
>  	if (page)
>  		set_page_refcounted(page);
>  	return page;
> @@ -5315,7 +5321,8 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
>  		gfp |= __GFP_NOWARN;
>  
>  	pol = get_vma_policy(vma, addr, order, &ilx);
> -	folio = folio_alloc_mpol_noprof(gfp, order, pol, ilx, numa_node_id());
> +	folio = folio_alloc_mpol_user_noprof(gfp, order, pol, ilx,
> +					     numa_node_id(), addr);
>  	mpol_cond_put(pol);
>  	return folio;
>  }
> @@ -5323,10 +5330,17 @@ struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
>  struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order,
>  		struct vm_area_struct *vma, unsigned long addr)
>  {
> +	struct page *page;
> +
>  	if (vma->vm_flags & VM_DROPPABLE)
>  		gfp |= __GFP_NOWARN;
>  
> -	return folio_alloc_noprof(gfp, order);
> +	page = __alloc_frozen_pages_noprof(gfp | __GFP_COMP, order,
> +					   numa_node_id(), NULL, addr);
> +	if (!page)
> +		return NULL;
> +	set_page_refcounted(page);
> +	return page_rmappable_folio(page);
>  }
>  #endif
>  EXPORT_SYMBOL(vma_alloc_folio_noprof);
> @@ -6907,7 +6921,7 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
>  		list_for_each_entry_safe(page, next, &list[order], lru) {
>  			int i;
>  
> -			post_alloc_hook(page, order, gfp_mask);
> +			post_alloc_hook(page, order, gfp_mask, USER_ADDR_NONE);
>  			if (!order)
>  				continue;
>  
> @@ -7113,7 +7127,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>  		struct page *head = pfn_to_page(start);
>  
>  		check_new_pages(head, order);
> -		prep_new_page(head, order, gfp_mask, 0);
> +		prep_new_page(head, order, gfp_mask, 0, USER_ADDR_NONE);
>  	} else {
>  		ret = -EINVAL;
>  		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
> @@ -7778,7 +7792,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
>  	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
>  			| gfp_flags;
>  	unsigned int alloc_flags = ALLOC_TRYLOCK;
> -	struct alloc_context ac = { };
> +	struct alloc_context ac = { .user_addr = USER_ADDR_NONE };
>  	struct page *page;
>  
>  	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
> diff --git a/mm/slub.c b/mm/slub.c
> index 0baa906f39ab..74dd2d96941b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3275,7 +3275,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  	else if (node == NUMA_NO_NODE)
>  		page = alloc_frozen_pages(flags, order);
>  	else
> -		page = __alloc_frozen_pages(flags, order, node, NULL);
> +		page = __alloc_frozen_pages(flags, order, node, NULL, USER_ADDR_NONE);
>  
>  	if (!page)
>  		return NULL;
> @@ -5235,7 +5235,7 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
>  	if (node == NUMA_NO_NODE)
>  		page = alloc_frozen_pages_noprof(flags, order);
>  	else
> -		page = __alloc_frozen_pages_noprof(flags, order, node, NULL);
> +		page = __alloc_frozen_pages_noprof(flags, order, node, NULL, USER_ADDR_NONE);
>  
>  	if (page) {
>  		ptr = page_address(page);
> -- 
> MST
> 

