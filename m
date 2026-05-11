Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049340243B
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513863; cv=none; b=OBgt/XdO6W51DS3UPqCM4z8Qi92EdVk7qp5sgalIsZvWxPoc4q2JO4bOU85BIUHugiWYcLH3+AOYtb6RGq6xWWQqEkQQ5MhmvrdJaXDlJksrnX1RPTaaLOeNxwe9U7vamf9v/KwQKN1HLVhlqcXJsJC8Q08sHDSHNGNSGxTWQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513863; c=relaxed/simple;
	bh=Yj3LjSZQo7HQJbCpCUOtAzwclCCix2BLoMMa9VEHBsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh+tAI7cVgUkT5FBkbK7Yu+J+ObYrzAm0ffLKl0mvQCsjTfDetFV23hb2Vcf0ZOJGtUG5yd275ZkkyS+bBtnWuDFgGcrU4Nna2SPaoaP0sGOGlh+j2ez7F47LXnHoxuOv8KTl31Sxkpg/kqK3Ky4vd6oRvYhlPl0fOR9VrbiGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ri6cnL0j; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ri6cnL0j"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso2558562241.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778513861; x=1779118661; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4o7InZBqCk+7loPCj3VNzWtQgfmKxcMnRJsXC1AWBtY=;
        b=Ri6cnL0juwzuIQ6dibxJrTndNbnsWXvuorJSFppa7+y9ZShyJ2jgXiPFKzPDcf+sxx
         EZNbHXnV09QTx61hK0OPAq8OlFrEW1aRHYDULeXvmk7XjVTQxzK06bWPpHcRGb+myOrY
         O4QWXDVMxizXGsITBw7nZp2g2ZFxvVOahYNd/kyJ0V2P4vlXeLUx96JrNRqPiuUGKQNL
         ukp5wqxjhWS4furmf6/tg5PjRZmF7R7tBH6dxHa0Z/i4NB+YvGl9/TkjJ8eKtDP3iAvX
         zN8blz1WOEILOxwXEW3YlSdzdiJSbKJ3EDSSpl1AXEWHni/aaK/aQPJFTwLMp7jUuJXq
         3k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513861; x=1779118661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o7InZBqCk+7loPCj3VNzWtQgfmKxcMnRJsXC1AWBtY=;
        b=X4bLD0MLARrw4zk6NH46CGDhE5sCKJtZABPu1YRHInbUdudhU0C9sUyw4rduO37H6E
         GMZpblVbUq80RVGKyil97s8VuJ5PU6eVpCedceS4zxbhFhGW463bOfL0x6ui3zHg5Okb
         qA/yRND48Qr+ekGh5W+QiLtUrhAk/C2d6wiBJIP/extlx4ULI5/EfHiSRe0Wvcy/JNrd
         rUdO5BRY0MZaZWDgdpFUtQ0FLmjpclwobxf7qW0Ra9KKIckqoKD20AvxbnTWr5VhfRdn
         uU9I8J4PRrvicf2Kfh9co5Fwq2TRQ1xMQdMGaJIhPGb4uc83kSnag1KwVKA329RkI8OC
         lu7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9LRtyq/KfZJJPjmwNhMMaiWLe2ZWp4NeX89Uxc3lsbRFcjLNGL/a4l9Jnl96Z0t3Kz1VmWxV3QZROsfyb7uA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycsNytHRhRz0ngsmM3nQ64bvv8R1nSXpQn2Z7DwPU74r1JegFg
	L4HnSDs3NTZtvuuDiotch7qbY3IYhBl6L+B3UCKr/a1xg86nJMjKDk8UeoDmRMdlIkI=
X-Gm-Gg: Acq92OFQjx0Pyy8xSb/AcQhhdps4GN+Cltf1ljUzD27Sv/yyEUwxBxYqzYBmCmtt20P
	RyRhhQxYUt/fXHuTtxEbDHUH/9q2RiNdau9bV6hvciPYqhvSgIdwdItODdtD9E4K4UPt4RXjE7x
	6KzPN3hZBRpoYEwsR4EkuBuHR5Vcgu+ssqUQuuXLXcOXOULyr9tMAV4OvPR5f9AgWm1oS0oCLxd
	H4EqbwRADbtlbnNxybiyh1L/CmDxcJ5JEwuA+HGUdGIT0CEGpsQQ6f2/b+CsY/tdUJhe4jVqyv7
	VSAuj7mOxy6lnrimGJsSoFTwFINi2dAJU3qTeWc+PGsV2GVk1Nz9Y1FwvI87fJ8u6L5z+TmWdo7
	OWOYIgFri9LLLd9rhUGMUd9JbbInxQcmkugi46JB9uaUMJylxs8AYKP95yHdUAh7syhxNIErQVc
	gOuOwatY/j2QDP3Ndnfq79eY5F07fe7SgeYgQOjOnzNNiS3Ad/fm3fyxDlLVQt1I/nXVJpNsWMP
	jT9xE6eEU16Ec6HFAB5GAQ=
X-Received: by 2002:a05:6102:5a85:b0:633:4d1a:65e4 with SMTP id ada2fe7eead31-6334d29b73amr3014460137.12.1778513860817;
        Mon, 11 May 2026 08:37:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c81b1csm97160166d6.28.2026.05.11.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:37:40 -0700 (PDT)
Date: Mon, 11 May 2026 11:37:37 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH resend v6 03/30] mm: thread user_addr through page
 allocator for cache-friendly zeroing
Message-ID: <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:01:55AM -0400, Michael S. Tsirkin wrote:
> Thread a user virtual address from vma_alloc_folio() down through
> the page allocator to post_alloc_hook(). This is plumbing
> preparation for a subsequent patch that will use user_addr to
> call folio_zero_user() for cache-friendly zeroing of user pages.
> 
> The user_addr is stored in struct alloc_context and flows through:
>   vma_alloc_folio -> folio_alloc_mpol -> __alloc_pages_mpol ->
>   __alloc_frozen_pages -> get_page_from_freelist -> prep_new_page ->
>   post_alloc_hook

This is the nitty-est of all nits, but when doing this can we please
prefer stack style?

  vma_alloc_folio 
    folio_alloc_mpol 
      __alloc_pages_mpol 
        __alloc_frozen_pages 
          get_page_from_freelist 
            prep_new_page 
              post_alloc_hook

Claude has a bad habit of writing changelog changes this way, and it's
painful for a human to try to read.

> 
> USER_ADDR_NONE ((unsigned long)-1) is used for non-user
> allocations, since address 0 is a valid userspace mapping.
> 

> +/*
> + * Sentinel for user_addr: indicates a non-user allocation.
> + * Cannot use 0 because address 0 is a valid userspace mapping.
> + */
> +#define USER_ADDR_NONE	((unsigned long)-1)

Ehm, hm.  Does -1 hold as a non-user address across all architectures?

What about in linear addressing / no VM mode?

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

This change seems out of place unless i'm missing something.


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

                       user_addr?  uaddr?

> @@ -1823,7 +1824,7 @@ static struct folio *alloc_buddy_frozen_folio(int order, gfp_t gfp_mask,
>  	if (alloc_try_hard)
>  		gfp_mask |= __GFP_RETRY_MAYFAIL;
>  
> -	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask);
> +	folio = (struct folio *)__alloc_frozen_pages(gfp_mask, order, nid, nmask, addr);

Not on you, but the changes in hugetlb.c as a whole are :[

We do all of this to pass USER_ADDR_NONE all over the place, but the
alternative is having a separate function specifically for user-land
bound allocations.

So the trade off is:
   a) churn the current interface for everyone
   b) add a user_ variant and know people will just get it wrong

IIRC you said the consequence of getting wrong here is subtle corruption
if a caller got it wrong, and this was related to cache flushing for the
provided user address?

Stupid question: Does this not apply to kernel allocations as well? Or
is it simply a matter of the cache having stale data that could leak,
and therefore it's not a concern in-kernel?

~Gregory
