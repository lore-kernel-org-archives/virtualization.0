Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304A25782A;
	Mon,  8 Jun 2026 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917802; cv=none; b=Z4tK4CpCsgUMKGO54ACAzWTrNf1QyIaehdF36Uzz/e8iLKvf0Aybw1yaAVzRq023TRE44h7RjR6/OBgJX1Jo8bwLOIOi9n20PmRkSSuehP1otJWvh+4zK5ZMcfkcE6MVGuczhyKyqmuNRqg6k+DcdN+JTEO9/puU4CMu868Pl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917802; c=relaxed/simple;
	bh=XXXkUTsy+rq4L4LeIMO+GBWihNr0ZdCuC9LKU+n6AkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzlRiSXuR7f9ku2jqWGEzoBjs4cXVh9ZL11mWY0+08N8usKm1C0cznLM3g0M/UBHfeSzIEXxDmAFkgmw3wq+EnaPOEq/zH4j+mGH/vTWUZ35cTQP5gNAc4MwRa8ale4jf3qaApch/VgLWzKOq31Sx79vcMqiDITRy6wWfZZd70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2pvxdEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2pvxdEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B449F1F00893;
	Mon,  8 Jun 2026 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917800;
	bh=x0WNa35PkAieRM1DUOHaPgcwBJSjLyea6ACWB1AdAx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W2pvxdEnX5tI57Wohq0lKd2Bw0KQ/2lc2odLZ/D/PYfXgh9m5G3s/Mscjj0hosH9e
	 RYC9mqk9BNr6zEVfKN0sfTzY8ga3xOC/AiYTGAwIaRpBkRwwF/PThgg3VY/Rri4cg5
	 sDGk1ZMjuff+r0bzM878C37tGMb2iXYZ1lOrstFCgl3irbEcdIDFmb9t47/3aZOU9Q
	 aLfqBPSeYhYJVW/luvcXJY8envTbvUqJL8s7O7UuZgbGa9ANcTsXzGwiZRlXK1rRlE
	 kJcAkTiZ7EavrBx5xJze1DCBl0gtOwzEH1kWPBO6ULUUFKmHEpMRpeiuD32SApOhW7
	 YndNpalrnPANw==
Date: Mon, 8 Jun 2026 12:23:07 +0100
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
Subject: Re: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <aiacZ6_7SG3nvVjM@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:36:38AM -0400, Michael S. Tsirkin wrote:
> When post_alloc_hook() needs to zero a page for an explicit
> __GFP_ZERO allocation for a user page (user_addr is set), use folio_zero_user()
> instead of kernel_init_pages().  This zeros near the faulting
> address last, keeping those cachelines hot for the impending
> user access.
>
> folio_zero_user() is only used for explicit __GFP_ZERO, not for
> init_on_alloc.  On architectures with virtually-indexed caches
> (e.g., ARM), clear_user_highpage() performs per-line cache
> operations; using it for init_on_alloc would add overhead that
> kernel_init_pages() avoids (the page fault path flushes the
> cache at PTE installation time regardless).
>
> No functional change yet: current callers do not pass __GFP_ZERO
> for user pages (they zero at the callsite instead).  Subsequent
> patches will convert them.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/page_alloc.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4676fd49819e..d4fbf1861a8a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1861,9 +1861,38 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  		for (i = 0; i != 1 << order; ++i)
>  			page_kasan_tag_reset(page + i);
>  	}
> -	/* If memory is still not initialized, initialize it now. */
> -	if (init)
> -		kernel_init_pages(page, 1 << order);
> +	/*
> +	 * On architectures with cache aliasing, pages zeroed via the
> +	 * kernel direct map (e.g. init_on_free) must be re-zeroed
> +	 * through a user-congruent mapping.  Host-zeroed pages
> +	 * (zeroed flag) don't need this: physical RAM is clean.
> +	 */
> +	if (!init && (gfp_flags & __GFP_ZERO) &&
> +	    user_addr != USER_ADDR_NONE &&
> +	    user_alloc_needs_zeroing())

We check this (gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE thing
twice, can we just put in a 'init_should_folio_zero' const bool or something?

> +		init = true;

As Vlasta says not sure if we want to add complexity just for these arches.

> +	/*
> +	 * If memory is still not initialized, initialize it now.

I kinda hate that 'init' is unclear as to 'do init' or 'was init somewhere
else'... Anwyay.

> +	 * When __GFP_ZERO was explicitly requested and user_addr is set,
> +	 * use folio_zero_user() which zeros near the faulting address
> +	 * last, keeping those cachelines hot.  For init_on_alloc, use
> +	 * kernel_init_pages() to avoid unnecessary cache flush overhead
> +	 * on architectures with virtually-indexed caches.

This whole paragraph seems pretty useless and just describing the code?

> +	 */
> +	if (init) {
> +		if ((gfp_flags & __GFP_ZERO) && user_addr != USER_ADDR_NONE) {
> +			/*
> +			 * folio_zero_user relies on folio_nr_pages which
> +			 * requires __GFP_COMP for order > 0.  All user folio
> +			 * allocations set __GFP_COMP via __folio_alloc.

This whole paragraph is useless and very like the kind of stuff AI generates for
comments, i.e. overly long + entirely unnecessary stuff.

> +			 * user_addr != USER_ADDR_NONE implies sleepable
> +			 * context (user page fault).

Can you safely assume that? Also inferring which context we are in from this
parameter seems risky.

It seems to me that you're now making it such that kernel developers:

- Have to know when and when not to specify a user address, and under what
  circumstances we might consider that to be mapped.

- Need to know to do this correctly for aliasing architectures or have silent
  correctness issues.

- Need to take context into account when specifying this.

We definitely need to find a simpler way to do this!

> +			 */
> +			VM_WARN_ON_ONCE(order && !(gfp_flags & __GFP_COMP));

Surely by now we can assume this?

> +			folio_zero_user(page_folio(page), user_addr);
> +		} else
> +			kernel_init_pages(page, 1 << order);

I hate this hanging else branch... definitely prefer {} on both branches.

But in any case it seems like we could avoid some indentation with something
like:

	if (init && init_should_folio_zero) {
		...
	} else if (init) {
		...
	}

Or even a:

	if (!init)
		goto out;

And stick an out label below?

> +	}

>
>  	set_page_owner(page, order, gfp_flags);
>  	page_table_check_alloc(page, order);
> --
> MST
>

Oh and in general it seems that this conflicts with [0] which removes
kernel_init_pages().

[0];https://lore.kernel.org/all/20260422102729.166599-1-hsalunke@amd.com/

Thanks, Lorenzo
