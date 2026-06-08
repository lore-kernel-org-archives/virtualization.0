Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9AF36828B;
	Mon,  8 Jun 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918783; cv=none; b=T8I4PLZPMb5V0EMkiJThKThAf+v6d1PZNS/tFyTcNNfQ85UloN5loPTXvliQV8mZdtzIz9ubkQ/e8VU0QGuWRHvBPrxv1Y6sQzuFO44JXh8PLmUTs2mt47/cMiTv4lo+XRtcMbr5PmJJ6vSlKQYmAQzyR5rjw91LJC6lZaTkMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918783; c=relaxed/simple;
	bh=BHogtRFRHKcyrU3VmWSRlGusqFr4UILbrgiuunfRlNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9gtNdRVjIM+/97rJ9W899TllUkVuD4TgAKNJjSvHmlZwU9gqPo2WBFVsgfj1USN5+pOp8csi4IEa328p3yAXAjH3VOOT36s8OiuyQ+cZxjwzObGMcNSeKnARUb40uxDXxV26tRVgDxG3BRsVN072qM/IqXMmBebvnIwPllhmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4U0hGyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4U0hGyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEA61F00898;
	Mon,  8 Jun 2026 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780918782;
	bh=ZGVpNatqeAnKrQKe+tVSHeKyDhAqAjd/ZyB79qiaOjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I4U0hGyk+GsJAFicOe2q5eUPxaYhqxAumMWYhao3KXzMNTS9nA3sNxv23AeXksrWd
	 FXKalFf8yQhkj5sh8wg12bZ0SecQtOnXf0ozNeoBO4qTTTzN0c0nx2C0YatsRwmEAb
	 PdidAKdg76E1HGIWFIyYyuH7KQ8GpfNqOppt9b3Hv7jAewH8hKLSdmbYoyZiz4lRvv
	 QQ0xAwY8ym4Yz3EfNKSW7TbYo+hhSNM9ncXC3GIlmBk32mv59bq7CKjntN/OcUf3J0
	 z+GUb8XCScERYztrwnn0So3z59GX/JjrUsl8zuoVT0eHGkVJa7KmYfCb1G6/bE5yaL
	 ZfbynUejkwM4A==
Date: Mon, 8 Jun 2026 12:39:29 +0100
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
Subject: Re: [PATCH v10 18/37] mm: page_alloc: use aliasing checks instead of
 user_alloc_needs_zeroing
Message-ID: <aiapqEiASrriQqnA@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <d9b5fc983725665749024312f9ff5ede4f05e405.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b5fc983725665749024312f9ff5ede4f05e405.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:38:00AM -0400, Michael S. Tsirkin wrote:
> Replace user_alloc_needs_zeroing() with the direct aliasing checks
> (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()) in the
> post_alloc_hook aliasing guard.
>
> user_alloc_needs_zeroing() includes a !init_on_alloc term that
> means "allocator didn't zero this page."  But in this guard's
> context (!zeroed && !init && __GFP_ZERO), we already know the page
> is zero; init incorporates init_on_alloc via want_init_on_alloc().
> The only question left is whether the cache architecture needs
> the data re-zeroed through a congruent mapping, which is purely
> cpu_dcache_is_aliasing() || cpu_icache_is_aliasing().
>
> On non-aliasing architectures with init_on_free=true and
> init_on_alloc=false, this avoids a redundant re-zero of an
> already-zero page.
>
> Note on PowerPC: PowerPC overrides clear_user_page to call
> flush_dcache_page after clear_page, but on freshly allocated
> pages PG_dcache_clean is already clear (cleared by
> __free_pages_prepare), so flush_dcache_page is a no-op.
> Skipping this here thus has no effect.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6

This seems like an odd ordering of patches, can we group like changes
together?

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 45e824b1ec75..edfc83571985 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1880,7 +1880,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
>  	 */
>  	if (!zeroed && !init && (gfp_flags & __GFP_ZERO) &&
>  	    user_addr != USER_ADDR_NONE &&
> -	    user_alloc_needs_zeroing())
> +	    (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()))

Let's try and simplify things rather than adding endlessly huge if conditionals?

It's now incredibly hard to track exactly what's going on here, and that is
bug-bait.

>  		init = true;
>  	/*
>  	 * If memory is still not initialized, initialize it now.
> --
> MST
>

Thanks, Lorenzo
