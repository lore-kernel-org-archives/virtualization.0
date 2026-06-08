Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED13BD64D;
	Mon,  8 Jun 2026 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914847; cv=none; b=FemHLEa1PpSC2q0PPAjOK5EtleKQWobNV5mM6bHwIEcDiFfz521ZznTI6TA7GtpP8VAIrnJTG9tPKH0gi10PeyqCX1V7i3p/1/xPTnsTpnPCbBGJshvwjDZ9xrGTuRGiS2Z+mqQVIEnAdHc8fE7U6h/SMoGVt+WVAgfPt0RzbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914847; c=relaxed/simple;
	bh=mbuSFv+i2MN3oDfu42arOz+BtiKLJYZuJE+uFbppcrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuilzqaboJUgMyZ7VyqP19P1JoL7fQUEDdW5iTaFbWrSXtDbtr1ZLg+FQ3B2CwKSvXQuhB5eKe14K3hagv4l1scO+St3PQQJh75ge9kt48M2P3FVm5N6fG6I5uK4VWBa6TZr4fmdRUwCVsgDiy0mkXDYjSZEUab1jRTZ/ef0cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHnYKrz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHnYKrz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74F91F00893;
	Mon,  8 Jun 2026 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780914845;
	bh=MSISkVncYbol5NQ8VxRTT0axoLQuPhRhAriBgGYAZXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZHnYKrz9Qs8aK4+fkFURCjmiiXG1BeMHMEMJ/ZAHTREqJhvUqZrAr7YOLGmfvQ+Ox
	 jVWnmIEpAcv8t5QzkYv5pJGNnGbgq0+Z8YL+zegc7IcwlcZJf4g7FfDplW6wfnYkuf
	 tzr2pEdthhZpjZ2czMDoYlsDicBUOFkXZKeQ6NiMyq9vFkx/kV373PeDHerO0CTTbO
	 sC+n3O7gGJ5Htn2skdyf60ZDotpFXXgU6+nWynLOxt1NNbTw4BY9xzZlxW0Flsih1p
	 jcqXhksxWYI+4Bni/EgC2t9htE27d6iGTlsjvkkC14cy7bBI17c7sTxFUWixl4GOhC
	 0bDP77Dp2wBpw==
Date: Mon, 8 Jun 2026 11:33:52 +0100
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
Subject: Re: [PATCH v10 11/37] mm: page_alloc: move prep_compound_page before
 post_alloc_hook
Message-ID: <aiaZ4vhWq6vl-Yts@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <de0433334a7763b81ce8ca8f8a332c800cfe64ed.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0433334a7763b81ce8ca8f8a332c800cfe64ed.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:36:20AM -0400, Michael S. Tsirkin wrote:
> Move prep_compound_page() before post_alloc_hook() in prep_new_page().
>
> The next patch adds a folio_zero_user() call to post_alloc_hook(),
> which uses folio_nr_pages() to determine how many pages to zero.
> Without compound metadata set up first, folio_nr_pages() returns 1
> for higher-order allocations, so only the first page would be zeroed.
>
> All other operations in post_alloc_hook() (arch_alloc_page, KASAN,
> debug, page owner, etc.) use raw page pointers with explicit order
> counts and are unaffected by this reordering.

I'd put this justification for why this is safe above the 'next patch' stuff.

>
> Also reorder compaction_alloc_noprof() for consistency. Compaction
> currently passes USER_ADDR_NONE so folio_zero_user() is not called

Yeah again, this 'just so' stuff of when or when not an address is passed is
concerning.

> there, but keeping the same ordering avoids a future tripping hazard.

No functional changes or functional changes? If none then say so.

>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  mm/compaction.c | 4 ++--
>  mm/page_alloc.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 72684fe81e83..4336e433c99b 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1849,10 +1849,10 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
>  		set_page_private(&freepage[size], start_order);
>  	}
>  	dst = (struct folio *)freepage;
> -	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
> -	set_page_refcounted(&dst->page);
>  	if (order)
>  		prep_compound_page(&dst->page, order);
> +	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, USER_ADDR_NONE);
> +	set_page_refcounted(&dst->page);
>  	cc->nr_freepages -= 1 << order;
>  	cc->nr_migratepages -= 1 << order;
>  	return page_rmappable_folio(&dst->page);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0943ab724032..4676fd49819e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1874,11 +1874,11 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
>  							unsigned int alloc_flags,
>  							unsigned long user_addr)
>  {
> -	post_alloc_hook(page, order, gfp_flags, user_addr);
> -
>  	if (order && (gfp_flags & __GFP_COMP))
>  		prep_compound_page(page, order);
>
> +	post_alloc_hook(page, order, gfp_flags, user_addr);
> +
>  	/*
>  	 * page is set pfmemalloc when ALLOC_NO_WATERMARKS was necessary to
>  	 * allocate the page. The expectation is that the caller is taking
> --
> MST
>

Thanks, Lorenzo
