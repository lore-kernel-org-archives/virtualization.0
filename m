Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DD33FE26;
	Mon, 13 Apr 2026 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107520; cv=none; b=KHBNBGTUD1Blm3mwBmeXZVuG4IgukSEBVPNemLtAZaTUjmSJ+stX05uKo2EidBOgrmXOtoAg2d6UC1b20gsHqDZgEslpRvaQJx7Nzn6JjJAgIgmeIGYTuCDxXhQzCReDVjd9Yw2CCVRbLGj3DWz56v+NiQ+n3DCzcSMiVZc7CnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107520; c=relaxed/simple;
	bh=MxX8wt+PtDGl8J/2Seud1f/icOdBa7LsiBhLxw5jILY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9WSWUdsgBekdjI1EvnVRc7OvFDMFhSGlpiA0oFHgkcNDhZFM8ZFT6iGas5PATWxv+0VWerfRLiQHgdraVG/HDLzBoX3OtaYvwQyQLFUP6d+dadvm0REr8sebpHMUGrg040XJdIwTC1qjM4M1rflxcjRRESFH7Gi1F8YFshxSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN2KnZxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN2KnZxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE510C2BCAF;
	Mon, 13 Apr 2026 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776107520;
	bh=MxX8wt+PtDGl8J/2Seud1f/icOdBa7LsiBhLxw5jILY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lN2KnZxkDamOr6ulzzzsOtuWkA9vGRCPVx1F7hCKAlborqdv6Y7xznBREeJUgcwif
	 LfCfPa0d2oFzzrcr5dwMggI6fAmOxdMUL/B21wWunAD9fBqJJpu3xw4uGyvbfBfkxo
	 T+EoaympWixmlhFmF6R8v+zQfFavbTfsTcqf4SMRSsp82C7P9aL5tQSygcgP6gMg9f
	 2DuMDBo7RVVBNlzMnOr0u9YOieF5MWFWZxw5aBrttOe9dyY/pqfq3rSWn1df/I6eiC
	 zNWbe4m5zoZSZ0afgU3Emk1FffKHWsjQosY7C8iczzqPr2cHKw6ygl0MSNTapi6gFM
	 +m+h/e9LvGQ5w==
Message-ID: <b330143f-f3aa-4f4c-8467-d91102094e8d@kernel.org>
Date: Mon, 13 Apr 2026 21:11:51 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/9] mm: page_alloc: propagate PageReported flag
 across buddy splits
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Jason Wang <jasowang@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 linux-mm@kvack.org, virtualization@lists.linux.dev,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
References: <cover.1776033471.git.mst@redhat.com>
 <a74ad3652d9bd68c78fbb5360fa7adfd0606689f.1776033771.git.mst@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <a74ad3652d9bd68c78fbb5360fa7adfd0606689f.1776033771.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/13/26 00:50, Michael S. Tsirkin wrote:
> When a reported free page is split via expand() to satisfy a
> smaller allocation, the sub-pages placed back on the free lists
> lose the PageReported flag.  This means they will be unnecessarily
> re-reported to the hypervisor in the next reporting cycle, wasting
> work.
> 
> Propagate the PageReported flag to sub-pages during expand() so
> that they are recognized as already-reported.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  mm/page_alloc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2d4b6f1a554e..edbb1edf463d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1730,7 +1730,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>   * -- nyc
>   */
>  static inline unsigned int expand(struct zone *zone, struct page *page, int low,
> -				  int high, int migratetype)
> +				  int high, int migratetype, bool reported)
>  {
>  	unsigned int size = 1 << high;
>  	unsigned int nr_added = 0;
> @@ -1752,6 +1752,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
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

The comment is a bit excessive. I'd say you can drop it completely.

> +		if (reported)
> +			__SetPageReported(&page[size]);
>  	}
>  
>  	return nr_added;
> @@ -1762,9 +1771,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  						int high, int migratetype)
>  {
>  	int nr_pages = 1 << high;
> +	bool was_reported = page_reported(page);
>  
>  	__del_page_from_free_list(page, zone, high, migratetype);
> -	nr_pages -= expand(zone, page, low, high, migratetype);
> +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
>  	account_freepages(zone, -nr_pages, migratetype);
>  }
>  
> @@ -2322,7 +2332,8 @@ try_to_claim_block(struct zone *zone, struct page *page,
>  
>  		del_page_from_free_list(page, zone, current_order, block_type);
>  		change_pageblock_range(page, current_order, start_type);
> -		nr_added = expand(zone, page, order, current_order, start_type);
> +		nr_added = expand(zone, page, order, current_order, start_type,
> +				  false);

In MM land we started doing

/* reported= */false


This raises a good question: how does buddy merging handle the reported
flag?

-- 
Cheers,

David
