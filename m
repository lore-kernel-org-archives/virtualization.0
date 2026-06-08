Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7691E51E0;
	Mon,  8 Jun 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921954; cv=none; b=AoJ3BZ/bcvyNh2pQh4zpkoH3e39eQsytDE2agj1yT1fcOjrN1hoYFVtTiSomMlBfDUwgK/sEuK90bY31i3BHvm24dyN38eDT9F4clv9LVf0+s+BJvOnTDtip3srqf/DzizADOBDcRbLLcIh4oQWsauyPcHGqcQRtuCNIy1XLz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921954; c=relaxed/simple;
	bh=En4dpqm/oYQNj7mJPfouCI/rOj/SbRBe5Fz6PfdqinI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A22FrENCD61+ukqlGqJVOmn2GTk3GLGaHXfqa+06Y/g7HW24E7lU4xJ54o1AcdmAWRXQeJHhbc6BleJmihtpL31zCAsxFLquVwKlJZJFco3Vr/8xnqV+M1rRbyAVyyRXDk1ioR8Kua4hKLuCNQY1TL6nJrpueFxCAHI/y2ldpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BokOJ/53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BokOJ/53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689F31F00893;
	Mon,  8 Jun 2026 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780921953;
	bh=0S/mGlm2XVUNmf88aZNmWlasF/PmDk0YOd5RS53eddI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BokOJ/53zXQSSC08VD4iug5xPluwrLQ0Ns/1S+/wn18UiuwksvNkniq3qN2FiyewF
	 GMuvCqRpVL0AlJs6aH6tV8YnDN6p+tnV36+1VnBfbTg0jLsYa8433FvIyLHiH3L8yt
	 htaAfUxpnK80iRWeE/PmXHjXPd4o8iNJJ3tVHTfoDnfYO85+edAF3UZK+nO5rForZG
	 /e0J1UFqLl49pfl5O5uW9t+z+yty8dCmRSFwYT4x34bo+/LfAw2X0dBGkMs0gnUA5O
	 LsnRz9VdOFvVPpU9ZGJJYEmusi3LUDyWanA4z1E41tVtyd4j0FxP+4OJa44yqGoh7E
	 qNprUiV5urzPg==
Date: Mon, 8 Jun 2026 13:32:20 +0100
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
Subject: Re: [PATCH v10 27/37] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <aia2G06-ZjsTSD2u@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <2ee827fed4765a155d2b56bb0e13d7ee5fc6dce8.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee827fed4765a155d2b56bb0e13d7ee5fc6dce8.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:39:18AM -0400, Michael S. Tsirkin wrote:
> Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
> zeroing at the callsite. post_alloc_hook uses the fault address
> passed through vma_alloc_folio for cache-friendly zeroing.
>
> Note: before this series, replacing folio_zero_user() with
> __GFP_ZERO was unsafe on cache-aliasing architectures because
> __GFP_ZERO uses clear_page() without a dcache flush. With this
> series, it is safe if the caller passes a valid user address
> (not USER_ADDR_NONE) to vma_alloc_folio() etc., which delivers
> it to post_alloc_hook() for the dcache flush via
> folio_zero_user(). It is only unsafe if USER_ADDR_NONE is passed.
>
> Note: with __GFP_ZERO, the folio is zeroed before
> mem_cgroup_charge().  If the charge fails, the zeroing work is
> wasted.  Previously zeroing was done after a successful charge.
> This is inherent to moving zeroing into the allocator.
> Charge failures are rare (only at cgroup limits).
>
> Use folio_put_zeroed() on charge failure so the zeroed hint
> propagates to the buddy allocator, avoiding redundant re-zeroing
> on the next allocation attempt.

Again, is this worth it?...

Every bit of code added increases risks of bugs, maintenance burden,
etc. let's just not do stuff because we can.

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/huge_memory.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d689e6491ddb..0dec3c717ff2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1333,7 +1333,7 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>  static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>  		unsigned long addr)
>  {
> -	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
>  	const int order = HPAGE_PMD_ORDER;
>  	struct folio *folio;
>
> @@ -1347,7 +1347,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>
>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> -		folio_put(folio);
> +		folio_put_zeroed(folio);

Same comments as previously.

>  		count_vm_event(THP_FAULT_FALLBACK);
>  		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>  		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> @@ -1356,17 +1356,9 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>  	}
>  	folio_throttle_swaprate(folio, gfp);
>
> -       /*
> -	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
> -	* or user folios require special handling, folio_zero_user() is used to
> -	* make sure that the page corresponding to the faulting address will be
> -	* hot in the cache after zeroing.
> -	*/
> -	if (user_alloc_needs_zeroing())
> -		folio_zero_user(folio, addr);
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
> -	 * folio_zero_user writes become visible before the set_pmd_at()
> +	 * page zeroing becomes visible before the set_pmd_at()

folio zeroing?

>  	 * write.
>  	 */
>  	__folio_mark_uptodate(folio);
> --
> MST
>

Thanks, Lorenzo
