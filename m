Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553C1A6838;
	Mon,  8 Jun 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922661; cv=none; b=XKmp6tSq9qZnhczKYlGInqd29AHTAYqAannslunBiu6HtViJ3WnCJPwWZwF7xP61HQ7/oEAwSDqiTd6iG8uLuTxR9WnHPq7jzwew7Tuh3ZAfPaSdUDh9On5X2vPpRwRQr744L89DmDnnfV8xwtBvC8Z5b7rQkJ7QZT0eLTSO/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922661; c=relaxed/simple;
	bh=4c46dSTFQwFuZL3xxXzpb3had8eRnZngGeMljoyqfX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXNEwR0q0rKgeq5tKpiwl6uG1U8/deKj7+KPGmcluURfFksVQ1g6zN0sKPd4iLNLp9qH65hw76RAuy5I36Ff0f0OqxgKFCkt/rJebRbX4SwqZhBoGuuqsJXLwRYxWKOTeGifF53Imwhd8Xi3kBLMQcYvpugI0rBlE4QuE60rxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezp4jH8c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezp4jH8c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73731F00893;
	Mon,  8 Jun 2026 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780922659;
	bh=TJT3PYoXvb+A2/9fCaNKZsQDTn/8GZsLy9b5n+CIJp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ezp4jH8csGclWf1TZwiQiJxUJN24mw5HlpFfBTB61UsfgZfhObWo/1cbO1NY176PC
	 k2pkQPYcPdks4JrGiB0olk6//yQllAmx94lgBnA/CbKWVymArXoe5zk/pX9DcbGIh/
	 o7qCxlUzf5jppfU25uX9s6oBUIxVKUGSv8HrI1WljNbB7ssKv0ns77jx0FenNKJ9Eg
	 A87LrBwTIatClD5BlMaD1TGlgtVjjWv+1kOKx/KLlwyY6bNGQmSoVv0Ne7kOEhknLD
	 aBiH+hF2zVD2KUUWT9nZH4Fzn2tL6ofa18MRIf487n455SvuJcZdR7muQmBjvqvZpn
	 S9treTmDAbbFw==
Date: Mon, 8 Jun 2026 13:44:05 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 28/37] mm: hugetlb: add gfp parameter and skip
 zeroing for zeroed pages
Message-ID: <aia2kFpUMN7BXnZc@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <f251c9e495cdf98169f225559927112103303137.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f251c9e495cdf98169f225559927112103303137.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:39:26AM -0400, Michael S. Tsirkin wrote:
> Add a gfp_t parameter to alloc_hugetlb_folio(). When __GFP_ZERO
> is set, the function guarantees the returned folio is zeroed:
> - Fresh allocations (buddy or gigantic): zeroed by
>   post_alloc_hook via __GFP_ZERO, HPG_zeroed set by
>   alloc_surplus_hugetlb_folio.
> - Pool pages with HPG_zeroed set: already zeroed, skip.
> - Pool pages without HPG_zeroed: zeroed via folio_zero_user().
>
> The address parameter is renamed to user_addr; the function
> aligns it internally for reservation and NUMA policy lookups.
> For pages that need zeroing, user_addr is passed to
> folio_zero_user() for cache-friendly zeroing near the faulting
> subpage.  All callers pass a page-aligned address; the
> hugetlb_no_page caller passes vmf->real_address & PAGE_MASK
> for consistency.
>
> HPG_zeroed (stored in hugetlb folio->private bits) tracks
> known-zero pool pages. It is set when alloc_surplus_hugetlb_folio
> allocates with __GFP_ZERO, and cleared in free_huge_folio when
> the page returns to the pool after userspace use.
>
> Note: for gigantic CMA pages, __GFP_ZERO is passed through
> to cma_alloc_frozen_compound() via its caller_gfp parameter,
> so the pages ARE zeroed by the allocator. HPG_zeroed is only
> set when __GFP_ZERO was in the original gfp_mask.
> Pool pages allocated without __GFP_ZERO (e.g. by
> alloc_pool_huge_folio) do not get HPG_zeroed; they are zeroed
> later by folio_zero_user() at fault time.
>
> Note: with __GFP_ZERO, the folio is zeroed before
> mem_cgroup_charge_hugetlb().  If the charge fails, the zeroed
> folio is freed back.  Before this patch it is zeroed after charge, so
> simply freeing after zeroing would be a regression.  Thread a
> zeroed hint through free_huge_folio so surplus pages freed back
> to buddy preserve the zeroed state via free_frozen_pages_zeroed,
> avoiding redundant re-zeroing on the next allocation.
>
> Suggested-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

This whole set of hugetlb changes should be a separate series. Or really
deferred.

You very badly need to pare this down into the _minimum_ changes required rather
than AI go brrrr on everything.

And propagating _yet more_ 'zeroed' state seems unpleasant, do we have to?

> ---
>  fs/hugetlbfs/inode.c    |  3 +-
>  include/linux/hugetlb.h |  5 ++-
>  mm/hugetlb.c            | 78 +++++++++++++++++++++++++++--------------
>  3 files changed, 57 insertions(+), 29 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 78d61bf2bd9b..2c0c51fe9ec3 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -790,13 +790,12 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		 * folios in these areas, we need to consume the reserves
>  		 * to keep reservation accounting consistent.
>  		 */
> -		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false);
> +		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false, __GFP_ZERO);
>  		if (IS_ERR(folio)) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			error = PTR_ERR(folio);
>  			goto out;
>  		}
> -		folio_zero_user(folio, addr);
>  		__folio_mark_uptodate(folio);
>  		error = hugetlb_add_to_page_cache(folio, mapping, index);
>  		if (unlikely(error)) {
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1f7ae6609e51..06d033a57a61 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -593,6 +593,7 @@ enum hugetlb_page_flags {
>  	HPG_vmemmap_optimized,
>  	HPG_raw_hwp_unreliable,
>  	HPG_cma,
> +	HPG_zeroed,
>  	__NR_HPAGEFLAGS,
>  };
>
> @@ -653,6 +654,7 @@ HPAGEFLAG(Freed, freed)
>  HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
>  HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
>  HPAGEFLAG(Cma, cma)
> +HPAGEFLAG(Zeroed, zeroed)

Same comments about this naming as elsewhere. Let's be specific about what
_kind_ of zeroing this is.

>
>  #ifdef CONFIG_HUGETLB_PAGE
>
> @@ -700,7 +702,8 @@ int isolate_or_dissolve_huge_folio(struct folio *folio, struct list_head *list);
>  int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
>  void wait_for_freed_hugetlb_folios(void);
>  struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> -				unsigned long addr, bool cow_from_owner);
> +				unsigned long user_addr, bool cow_from_owner,
> +				gfp_t gfp);

You already started calling into this user_addr stuff in an earlier patch I
believe, so why not rename it then...

>  struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
>  				nodemask_t *nmask, gfp_t gfp_mask,
>  				bool allow_alloc_fallback);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5d7e546565f5..ed00db703911 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1455,7 +1455,8 @@ void add_hugetlb_folio(struct hstate *h, struct folio *folio,
>  }
>
>  static void __update_and_free_hugetlb_folio(struct hstate *h,
> -						struct folio *folio)
> +						struct folio *folio,
> +						bool zeroed)
>  {
>  	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
>
> @@ -1506,6 +1507,8 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>  	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
>  	if (folio_test_hugetlb_cma(folio))
>  		hugetlb_cma_free_frozen_folio(folio);
> +	else if (zeroed)
> +		free_frozen_pages_zeroed(&folio->page, folio_order(folio));
>  	else
>  		free_frozen_pages(&folio->page, folio_order(folio));
>  }
> @@ -1545,7 +1548,7 @@ static void free_hpage_workfn(struct work_struct *work)
>  		 */
>  		h = size_to_hstate(folio_size(folio));
>
> -		__update_and_free_hugetlb_folio(h, folio);
> +		__update_and_free_hugetlb_folio(h, folio, false);
>
>  		cond_resched();
>  	}
> @@ -1559,10 +1562,10 @@ static inline void flush_free_hpage_work(struct hstate *h)
>  }
>
>  static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
> -				 bool atomic)
> +				 bool atomic, bool zeroed)
>  {
>  	if (!folio_test_hugetlb_vmemmap_optimized(folio) || !atomic) {
> -		__update_and_free_hugetlb_folio(h, folio);
> +		__update_and_free_hugetlb_folio(h, folio, zeroed);
>  		return;
>  	}
>
> @@ -1596,7 +1599,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
>  			spin_lock_irq(&hugetlb_lock);
>  			__folio_clear_hugetlb(folio);
>  			spin_unlock_irq(&hugetlb_lock);
> -			update_and_free_hugetlb_folio(h, folio, false);
> +			update_and_free_hugetlb_folio(h, folio, false, false);
>  			cond_resched();
>  		}
>  	} else {
> @@ -1621,7 +1624,7 @@ static void bulk_vmemmap_restore_error(struct hstate *h,
>  				spin_lock_irq(&hugetlb_lock);
>  				__folio_clear_hugetlb(folio);
>  				spin_unlock_irq(&hugetlb_lock);
> -				update_and_free_hugetlb_folio(h, folio, false);
> +				update_and_free_hugetlb_folio(h, folio, false, false);
>  				cond_resched();
>  				break;
>  			}
> @@ -1664,7 +1667,7 @@ static void update_and_free_pages_bulk(struct hstate *h,
>  	}
>
>  	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
> -		update_and_free_hugetlb_folio(h, folio, false);
> +		update_and_free_hugetlb_folio(h, folio, false, false);
>  		cond_resched();
>  	}
>  }
> @@ -1680,7 +1683,7 @@ struct hstate *size_to_hstate(unsigned long size)
>  	return NULL;
>  }
>
> -void free_huge_folio(struct folio *folio)
> +static void __free_huge_folio(struct folio *folio, bool zeroed)

This zeroed flag seems to be used for both hugetlb zeroed flag state and
__GFP_ZERO?

What does it mean? Can we be specific and comment? Because it's very confusing.

>  {
>  	/*
>  	 * Can't pass hstate in here because it is called from the
> @@ -1692,6 +1695,9 @@ void free_huge_folio(struct folio *folio)
>  	bool restore_reserve;
>  	unsigned long flags;
>
> +	/* Page was mapped to userspace; no longer known-zero */

Again, please be specific about the kind of zeroing.

> +	folio_clear_hugetlb_zeroed(folio);
> +
>  	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_mapcount(folio), folio);
>
> @@ -1735,12 +1741,12 @@ void free_huge_folio(struct folio *folio)
>  	if (folio_test_hugetlb_temporary(folio)) {
>  		remove_hugetlb_folio(h, folio, false);
>  		spin_unlock_irqrestore(&hugetlb_lock, flags);
> -		update_and_free_hugetlb_folio(h, folio, true);
> +		update_and_free_hugetlb_folio(h, folio, true, zeroed);
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
>  		remove_hugetlb_folio(h, folio, true);
>  		spin_unlock_irqrestore(&hugetlb_lock, flags);
> -		update_and_free_hugetlb_folio(h, folio, true);
> +		update_and_free_hugetlb_folio(h, folio, true, zeroed);
>  	} else {
>  		arch_clear_hugetlb_flags(folio);
>  		enqueue_hugetlb_folio(h, folio);
> @@ -1748,6 +1754,11 @@ void free_huge_folio(struct folio *folio)
>  	}
>  }
>
> +void free_huge_folio(struct folio *folio)

_Please_ be specific about hugetlb in newer functions. 'Huge' is very
overloaded.

And again you're doing the pattern of adding various 'zeroed' state, but then
_also_ adding a specific flag for hinting zeroed state.

I don't understand why we need both and you're adding complexity here for that.

> +{
> +	__free_huge_folio(folio, false);
> +}
> +
>  /*
>   * Must be called with the hugetlb lock held
>   */
> @@ -2031,7 +2042,7 @@ int dissolve_free_hugetlb_folio(struct folio *folio)
>  			rc = 0;
>  		}
>
> -		update_and_free_hugetlb_folio(h, folio, false);
> +		update_and_free_hugetlb_folio(h, folio, false, false);

More mystery meat boolean flags.

>  		return rc;
>  	}
>  out:
> @@ -2093,6 +2104,10 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
>  	if (!folio)
>  		return NULL;
>
> +	/* Mark as known-zero only if __GFP_ZERO was requested */

This comment is redundant and underspecified.

> +	if (gfp_mask & __GFP_ZERO)
> +		folio_set_hugetlb_zeroed(folio);

So now we're marking zeroed even in cases where it's not the host VM zeroing?

Is this useful?

> +
>  	spin_lock_irq(&hugetlb_lock);
>  	/*
>  	 * nr_huge_pages needs to be adjusted within the same lock cycle
> @@ -2156,11 +2171,11 @@ static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mas
>   */
>  static
>  struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
> -		struct vm_area_struct *vma, unsigned long addr)
> +		struct vm_area_struct *vma, unsigned long addr, gfp_t gfp)

Can we not propagate arbitrary GFP flags if we can avoid it?

>  {
>  	struct folio *folio = NULL;
>  	struct mempolicy *mpol;
> -	gfp_t gfp_mask = htlb_alloc_mask(h);
> +	gfp_t gfp_mask = htlb_alloc_mask(h) | gfp;
>  	int nid;
>  	nodemask_t *nodemask;
>
> @@ -2715,7 +2730,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct folio *old_folio,
>  		 * Folio has been replaced, we can safely free the old one.
>  		 */
>  		spin_unlock_irq(&hugetlb_lock);
> -		update_and_free_hugetlb_folio(h, old_folio, false);
> +		update_and_free_hugetlb_folio(h, old_folio, false, false);
>  	}
>
>  	return ret;
> @@ -2723,7 +2738,7 @@ static int alloc_and_dissolve_hugetlb_folio(struct folio *old_folio,
>  free_new:
>  	spin_unlock_irq(&hugetlb_lock);
>  	if (new_folio)
> -		update_and_free_hugetlb_folio(h, new_folio, false);
> +		update_and_free_hugetlb_folio(h, new_folio, false, false);
>
>  	return ret;
>  }
> @@ -2857,16 +2872,19 @@ typedef enum {
>   * When it's set, the allocation will bypass all vma level reservations.
>   */
>  struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
> -				    unsigned long addr, bool cow_from_owner)
> +				    unsigned long user_addr, bool cow_from_owner,
> +				    gfp_t gfp)
>  {
>  	struct hugepage_subpool *spool = subpool_vma(vma);
>  	struct hstate *h = hstate_vma(vma);
> +	unsigned long addr = user_addr & huge_page_mask(h);
>  	struct folio *folio;
>  	long retval, gbl_chg, gbl_reserve;
>  	map_chg_state map_chg;
>  	int ret, idx;
>  	struct hugetlb_cgroup *h_cg = NULL;
> -	gfp_t gfp = htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> +
> +	gfp |= htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
>
>  	idx = hstate_index(h);
>
> @@ -2934,13 +2952,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
>  	if (!folio) {
>  		spin_unlock_irq(&hugetlb_lock);
> -		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
> +		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, user_addr, gfp);
>  		if (!folio)
>  			goto out_uncharge_cgroup;
>  		spin_lock_irq(&hugetlb_lock);
>  		list_add(&folio->lru, &h->hugepage_activelist);
>  		folio_ref_unfreeze(folio, 1);
> -		/* Fall through */

Why are you dropping this?

>  	}
>
>  	/*
> @@ -2963,6 +2980,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>
>  	spin_unlock_irq(&hugetlb_lock);
>
> +	if ((gfp & __GFP_ZERO) && !folio_test_hugetlb_zeroed(folio))
> +		folio_zero_user(folio, user_addr);
> +	folio_clear_hugetlb_zeroed(folio);

So this represents general zeroed state (not just host VM, based on how you set
it above), but you also clear it when you just zeroed the folio? I'm confused.

What does this flag actually mean?

> +
>  	hugetlb_set_folio_subpool(folio, spool);
>
>  	if (map_chg != MAP_CHG_ENFORCED) {
> @@ -2999,7 +3020,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
>
>  	if (ret == -ENOMEM) {
> -		free_huge_folio(folio);
> +		__free_huge_folio(folio, !!(gfp & __GFP_ZERO));

Is the !! actually necessary?

>  		return ERR_PTR(-ENOMEM);
>  	}
>
> @@ -4971,7 +4992,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  				spin_unlock(src_ptl);
>  				spin_unlock(dst_ptl);
>  				/* Do not use reserve as it's private owned */
> -				new_folio = alloc_hugetlb_folio(dst_vma, addr, false);
> +				new_folio = alloc_hugetlb_folio(dst_vma, addr, false, 0);
>  				if (IS_ERR(new_folio)) {
>  					folio_put(pte_folio);
>  					ret = PTR_ERR(new_folio);
> @@ -5500,7 +5521,7 @@ static vm_fault_t hugetlb_wp(struct vm_fault *vmf)
>  	 * be acquired again before returning to the caller, as expected.
>  	 */
>  	spin_unlock(vmf->ptl);
> -	new_folio = alloc_hugetlb_folio(vma, vmf->address, cow_from_owner);
> +	new_folio = alloc_hugetlb_folio(vma, vmf->address, cow_from_owner, 0);
>
>  	if (IS_ERR(new_folio)) {
>  		/*
> @@ -5760,7 +5781,13 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>  				goto out;
>  		}
>
> -		folio = alloc_hugetlb_folio(vma, vmf->address, false);
> +		/*
> +		 * Passing vmf->real_address would work just as well,
> +		 * but PAGE_MASK helps make sure we never pass
> +		 * USER_ADDR_NONE by mistake.
> +		 */

Wait what??

Your whole thesis is that USER_ADDR_NONE can never possibly get used, and now
you're guarding against that not being true?


> +		folio = alloc_hugetlb_folio(vma, vmf->real_address & PAGE_MASK,
> +					   false, __GFP_ZERO);

OK so we propagate GFP just for __GFP_ZERO... Can we not?

>  		if (IS_ERR(folio)) {
>  			/*
>  			 * Returning error will result in faulting task being
> @@ -5780,7 +5807,6 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>  				ret = 0;
>  			goto out;
>  		}
> -		folio_zero_user(folio, vmf->real_address);
>  		__folio_mark_uptodate(folio);
>  		new_folio = true;
>
> @@ -6219,7 +6245,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  			goto out;
>  		}
>
> -		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
> +		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false, 0);
>  		if (IS_ERR(folio)) {
>  			pte_t *actual_pte = hugetlb_walk(dst_vma, dst_addr, PMD_SIZE);
>  			if (actual_pte) {
> @@ -6266,7 +6292,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  			goto out;
>  		}
>
> -		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false);
> +		folio = alloc_hugetlb_folio(dst_vma, dst_addr, false, 0);

Not loving the '0' on these... Let's find another way to represent that.

>  		if (IS_ERR(folio)) {
>  			folio_put(*foliop);
>  			ret = -ENOMEM;
> --
> MST
>

Thanks, Lorenzo
