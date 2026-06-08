Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C42331A76;
	Mon,  8 Jun 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912363; cv=none; b=s9oNi8qr+30abHV7lD74h9RKci0+flajsqijVRQkAsNaVcpqKhdCxtpL9Zd7Shbs2PYO8ZxUxfABSEcJRMmCa9M/ODsdVz8VFv997KyNjwsUo1QL2zEm3yEUYbHCi5ftRs/4AkPbOgXkDZD9Nxh8yrchRftAWe+kxOWUVljZagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912363; c=relaxed/simple;
	bh=8vdlPVQUZ1/uJgHdT+HSrjGE+nEVtNmhygbIlkO6kWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/KX7+Spc0c5iW4t6LUDBlKNayooYz7WxIy9btX9SQdCNxTyrMGt+Y0OJxYXkgBxFT5eOrrnm+uQIDuEROycYgreeC5frUm6U/AwFDM2oCI1UctupA8QDIrH+fY4oycWNQ5DlHFZDY2noPiRkHL/+J0WlSSVBXHBtMf/5FbEMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhbmsSQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhbmsSQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AB61F00893;
	Mon,  8 Jun 2026 09:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780912361;
	bh=JFcb5wznsh7Dtoc8obtApEc1nOCjqE6tfgXIvwztLZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MhbmsSQbAP4dukA9xxTpQlDXZRzK7wZ9UBnUq/Nbt7QXRBpCZg3VoUk7r3WaeT2OM
	 ooYYM4FdktOUtjWi7lLhZl0JcIlO1nCd0f86FsX4i/pdBZebuGRSBnOd+POhDIjr5V
	 KbIJDt1l0UppECkj7VM40TFGhRaYQXY1kqONZOHlF7G1MaAXoVLlFasBN5VEKN1tMq
	 QtqNrCL/uN6Ozex01tpu9Ho6NVJgNlK6kTaFseku2BgUhT6Mo7MZROwYlFYm3R8s3w
	 Q7Q5LJF8lJtcjfy9Wrnb6HOyoW1Ei891MjFn8OQw5IjRjHztdcbolIY2MAkGq2MucI
	 XE6+0HSbWekWw==
Date: Mon, 8 Jun 2026 10:52:28 +0100
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
Subject: Re: [PATCH v10 03/37] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <aiaPBRm0Mp_WDPFa@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <1a407d39a9ebd95e9de67e44f9ad2db37c9f31e9.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a407d39a9ebd95e9de67e44f9ad2db37c9f31e9.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:34:39AM -0400, Michael S. Tsirkin wrote:
> When a reported free page is split via expand() to satisfy a
> smaller allocation, the sub-pages placed back on the free lists
> lose the PageReported flag.  This means they will be unnecessarily
> re-reported to the hypervisor in the next reporting cycle, wasting
> work.
>
> While I was unable to quantify the performance difference, it is
> an obvious waste, even if small.

Hmm, that makes me wonder if this is really worth it?

You're making everything more complicated propagating yet another parameter
around (which could actually in itself cause perf/bloat issues) for
something you say yourself isn't really doing much?

>
> Propagate the PageReported flag to sub-pages during expand(),
> both in page_del_and_expand() and try_to_claim_block(), so
>
> split_large_buddy() also propagates PageReported via a bool
> parameter: the caller saves PageReported before
> del_page_from_free_list() clears it, then passes the saved
> value. The flag is set after __free_one_page() with a
> PageBuddy check, matching the page_reporting_drain() pattern.
> Free-path callers pass false (freshly freed pages are never
> reported).
> that they are recognized as already-reported.

The sentence is completely garbled?

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Again this really doesn't feel like it belongs to this series.

If it's really a bug, it should have fixes/Cc: stable, but honestly my
assessment here is this doesn't seem worthwhile at all.

You're not making a case for it and you're adding complexity. We don't just
take AI-reported bugs at face value (if this was indeed one).

(If sashiko-reported some people do Reported-by: sashiko-bot@kernel.org
now)

> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/page_alloc.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d49c254174da..8dae5b3f5876 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1502,7 +1502,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>
>  /* Split a multi-block free page into its individual pageblocks. */
>  static void split_large_buddy(struct zone *zone, struct page *page,
> -			      unsigned long pfn, int order, fpi_t fpi)
> +			      unsigned long pfn, int order, fpi_t fpi,
> +			      bool reported)
>  {
>  	unsigned long end = pfn + (1 << order);
>
> @@ -1517,6 +1518,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
>  		int mt = get_pfnblock_migratetype(page, pfn);
>
>  		__free_one_page(page, pfn, zone, order, mt, fpi);
> +		if (reported && PageBuddy(page) && buddy_order(page) == order)

Isn't this racey? We just freed this page to the buddy allocator, couldn't
it be allocated before we set this flag?

> +			__SetPageReported(page);
>  		pfn += 1 << order;
>  		if (pfn == end)
>  			break;
> @@ -1559,11 +1562,12 @@ static void free_one_page(struct zone *zone, struct page *page,
>  		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
>  			unsigned int p_order = p->private;
>
> -			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
> +			split_large_buddy(zone, p, page_to_pfn(p), p_order,
> +					  fpi_flags, false);

I don't love adding a mystery meat boolean parameter like this.

>  			__count_vm_events(PGFREE, 1 << p_order);
>  		}
>  	}
> -	split_large_buddy(zone, page, pfn, order, fpi_flags);
> +	split_large_buddy(zone, page, pfn, order, fpi_flags, false);
>  	spin_unlock_irqrestore(&zone->lock, flags);
>
>  	__count_vm_events(PGFREE, 1 << order);
> @@ -1694,7 +1698,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>   * -- nyc
>   */
>  static inline unsigned int expand(struct zone *zone, struct page *page, int low,
> -				  int high, int migratetype)
> +				  int high, int migratetype, bool reported)
>  {
>  	unsigned int size = 1 << high;
>  	unsigned int nr_added = 0;
> @@ -1716,6 +1720,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
>  		__add_to_free_list(&page[size], zone, high, migratetype, false);
>  		set_buddy_order(&page[size], high);
>  		nr_added += size;
> +
> +		/*
> +		 * The parent page has been reported to the host.  The
> +		 * sub-pages are part of the same reported block, so mark
> +		 * them reported too.  This avoids re-reporting pages that
> +		 * the host already knows about.
> +		 */

This comment seems entirely redundant (and very much like something claude would
add, it's too verbose like this).

> +		if (reported)
> +			__SetPageReported(&page[size]);
>  	}
>
>  	return nr_added;
> @@ -1726,9 +1739,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  						int high, int migratetype)
>  {
>  	int nr_pages = 1 << high;
> +	bool was_reported = page_reported(page);
>
>  	__del_page_from_free_list(page, zone, high, migratetype);
> -	nr_pages -= expand(zone, page, low, high, migratetype);
> +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);

I don't love propagating yet another parameter like this.

>  	account_freepages(zone, -nr_pages, migratetype);
>  }
>
> @@ -2116,11 +2130,13 @@ static bool __move_freepages_block_isolate(struct zone *zone,
>  	/* We're a part of a larger buddy */
>  	if (PageBuddy(buddy) && buddy_order(buddy) > pageblock_order) {
>  		int order = buddy_order(buddy);
> +		bool reported = PageReported(buddy);
>
>  		del_page_from_free_list(buddy, zone, order,
>  					get_pfnblock_migratetype(buddy, buddy_pfn));
>  		toggle_pageblock_isolate(page, isolate);
> -		split_large_buddy(zone, buddy, buddy_pfn, order, FPI_NONE);
> +		split_large_buddy(zone, buddy, buddy_pfn, order, FPI_NONE,
> +				  reported);
>  		return true;
>  	}
>
> @@ -2283,10 +2299,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
>  	/* Take ownership for orders >= pageblock_order */
>  	if (current_order >= pageblock_order) {
>  		unsigned int nr_added;
> +		bool was_reported = page_reported(page);
>
>  		del_page_from_free_list(page, zone, current_order, block_type);
>  		change_pageblock_range(page, current_order, start_type);
> -		nr_added = expand(zone, page, order, current_order, start_type);
> +		nr_added = expand(zone, page, order, current_order, start_type,
> +				  was_reported);
>  		account_freepages(zone, nr_added, start_type);
>  		return page;
>  	}
> --
> MST
>

Thanks, Lorenzo
