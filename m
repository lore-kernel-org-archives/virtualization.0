Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31125D527;
	Mon,  8 Jun 2026 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919236; cv=none; b=qIRWTfPKgdEHEclhTf1NI6jJ5cFWMbl/Zl3jShnnDA4fjO5dIKiCzc2InuzsG5dIvV72HATikOXTbFSXZm4p3UVOR5N1BZxWYZpQ0YN6T3fHJQK5jdXkYhMsYUFVh13n+76cmYXCtOP/rteObASio/wG/4027A4xYCWXSUMDPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919236; c=relaxed/simple;
	bh=yCBnlbbF2Q1VsdScngj4qtOfJQwqOY9HaGbwKdO89i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0X1Bb8oyCKW++UdWOiSkzB+8U5TcV8JFUnViAb66qQw/Mp/iBZSRQ6suh3FAgEOv8akVCEqm3hXkNKd09NnWluXIr7lbHmyL9GkYr7PNbCGzra9mjeqx+J/dQSSU6rvvk7gtTmusF8hpJiRwSABr2C3tRZ9G2y8h2ulBzttWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSdkhYB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSdkhYB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A0B1F00893;
	Mon,  8 Jun 2026 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780919235;
	bh=XYBSlu0D8nqZHl8IsBFYqN57OEwm5p6GA9bMuLV8h3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSdkhYB+h5nSqBOocM55VeVktciFWgwSVnAwGDNXjJ6v9AOxi/mcvgqVl0O23Zt9D
	 rI49yCjv1zm3CN4Gt8yWDwuJkyziTaNExRTEew34/k2iNz0/Dv8+3f1+j6f5SSRBbk
	 L8azeh8QnmhqEKzHKSrC86RBNlDkbpegBfN4+Dr+zJJMfk3SsOM+2wdlfgRbHskyTp
	 88waY2q0XSyxY6uuYjeF3H0vqzXhiw0F2Ebklodbyyu2o2FgT91sRDMGKdcnZMK2us
	 wj8lwU1YosFD65co8DZa7+499Gd9OggnXIN8ObP/f/g37R0tuo2HQRDMwH4wYYGyvd
	 KekWOT4YI8tKQ==
Date: Mon, 8 Jun 2026 12:47:01 +0100
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
Subject: Re: [PATCH v10 19/37] mm: page_alloc: clear PG_zeroed on buddy merge
 if not both zero
Message-ID: <aiaqGiwF_BR9TyCx@lucifer>
References: <cover.1780906288.git.mst@redhat.com>
 <918897302a4cab9f476625adc238ec65a688d1d7.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918897302a4cab9f476625adc238ec65a688d1d7.1780906288.git.mst@redhat.com>

On Mon, Jun 08, 2026 at 04:38:08AM -0400, Michael S. Tsirkin wrote:
> When two buddy pages merge in __free_one_page(), preserve
> PG_zeroed on the merged page only if both buddies have the
> flag set.  Otherwise clear it.
>
> The merged page would inherit PG_zeroed, and a later __GFP_ZERO
> allocation would skip zeroing stale data in the non-zero half.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  include/linux/page-flags.h |  1 +
>  mm/page_alloc.c            | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 91f8ddb1d512..9365d59ac1d6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -680,6 +680,7 @@ FOLIO_FLAG_FALSE(idle)
>   * uses this to skip redundant zeroing in post_alloc_hook().
>   */
>  __PAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
> +CLEARPAGEFLAG(Zeroed, zeroed, PF_NO_COMPOUND)
>  #define __PG_ZEROED (1UL << PG_zeroed)
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index edfc83571985..a90bca5317c1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -941,10 +941,14 @@ static inline void __free_one_page(struct page *page,
>  	unsigned long buddy_pfn = 0;
>  	unsigned long combined_pfn;
>  	struct page *buddy;
> +	bool buddy_zeroed;
> +	bool page_zeroed;
>  	bool to_tail;
>
>  	VM_BUG_ON(!zone_is_initialized(zone));
> -	VM_BUG_ON_PAGE(page->flags.f & PAGE_FLAGS_CHECK_AT_PREP, page);
> +	/* PG_zeroed (aliased to PG_private) is valid on free-list pages */
> +	VM_BUG_ON_PAGE(page->flags.f &

NIT: We don't add new VM_BUG_ON()'s, please use VM_WARN_ON().

> +		       (PAGE_FLAGS_CHECK_AT_PREP & ~__PG_ZEROED), page);
>
>  	VM_BUG_ON(migratetype == -1);
>  	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
> @@ -979,6 +983,8 @@ static inline void __free_one_page(struct page *page,
>  				goto done_merging;
>  		}
>
> +		buddy_zeroed = PageZeroed(buddy);
> +
>  		/*
>  		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
>  		 * merge with it and move up one order.
> @@ -997,10 +1003,17 @@ static inline void __free_one_page(struct page *page,
>  			change_pageblock_range(buddy, order, migratetype);
>  		}
>
> +		page_zeroed = PageZeroed(page);
> +		__ClearPageZeroed(page);
> +		__ClearPageZeroed(buddy);
> +
>  		combined_pfn = buddy_pfn & pfn;
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;
>  		order++;
> +
> +		if (page_zeroed && buddy_zeroed)
> +			__SetPageZeroed(page);
>  	}
>
>  done_merging:
> --
> MST
>
