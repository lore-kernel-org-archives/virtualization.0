Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576AC3FD135
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768181; cv=none; b=FceT3ybwQCE6Oc7vG3dHGHIMKbE8/n8vb6lJ1U/6Aif4IjIp3hOvZxLKjZXD5ycqnuQF1CZNSw8rN/WlOXrK0dKe4JoKAwdi4qYysPSE9s04roNXvuteirYW0OhcFZVsmHiNFUROjzsNLmDn6LLoCOpmzOl92OiOTrDy5deCY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768181; c=relaxed/simple;
	bh=7LY9rfL74rDmyNKIONUHS+WulH4uKCOzdJH8u/psLT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2VND8B70oCQTu3xuOksz1KxX8kO1NLQ5/ZxizONs60EaYcO4selFuzdwtB1WXBGTWPo233Zyk0qcqLyJ1+RJH4Io1WjJGR0v8tpcUTcPGClTScJ7C+c6fK7Y/e65dBasDWdT+ejKH/h78UXmYpANTwfSmYz9QNhI/WqGUk5SsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qdxE6Q4u; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qdxE6Q4u"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6969c864c89so4544785eaf.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778768177; x=1779372977; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/aRcyReAB/yBt5Ujgx4hlVRsrvunB+iUEF0sUUUSTA=;
        b=qdxE6Q4uZXg0I4BkgTNDGM+rx0Pn0MF62EDYDYCwG6prsYnDT/efGWP5tEOd2k1nlB
         QuR1h8dVnvEZCEKxUyWW4MojwgXtuaJQsOmjSON5+xNcJ54dq0w7ZxZfXLMNhqdKhnmH
         5a/G9E4DOZ7nh1FaxneSuAxGtGSgh6xKYKGOAKO5cFlIgzyrzLzhNIVDZd9pU79f/kvX
         fFPx0U62fcV7Bp9rA01zFKgUfLmuBlOW23X8dIO526E/24EvQtXJprkhPN3QgQTpa4t/
         qWHqin4GLMAvrFIx/Tm5Xjxqzt7jVbEJuPlxws573AUm7N3FkTI/hkdVM2H43Q38WWtX
         AU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768177; x=1779372977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/aRcyReAB/yBt5Ujgx4hlVRsrvunB+iUEF0sUUUSTA=;
        b=oKBotl2gK4dXVOAcceVrk7YDJVIB7wFNcpVMzT9BRUcxE5fQciNRga1CA9QLF+u3kq
         PLnG3JZX1AdJvBHgUfyXUSqT4aFb4KSbxPM/zGfx93fmHo+d54aITK0776VSQkumyxdu
         8rpq02TeqhaYKdpno5Z6v8zboYQ19dk6fJR/agJ8VWAdNWax4a6s2m6cLTzTVuHBeOs8
         He7XQJoLrvi8M97z1tnkZ/S+HdjdUtcW+Q2+jqO1smVt1Y88c7jtnT1ozshARdOS8Xtg
         liC6bjK1weB0FjLJIyin3/IxQZead/P1jFnapzDsPAR3gVK61j1kbkJkjuXHRtKdMccO
         0gTg==
X-Forwarded-Encrypted: i=1; AFNElJ94st4pM+c1kD39ilvcmUZY040UChUfIKoS+r45AIqTd8rF7ZFAHoms71TkNzqH/89KJe2fdShWjDrB3CTUkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEqV0UstSciUBruHTszrm9o1uSMSR6zMqziTBEzt65kClCHRV6
	l2IwK+D0/zXVEfCjwt4sOh8a61/K5VldKtDOszJXzcndA/ReEJlRbRs9Y3rDuE7wlrDUaGSUeU5
	lY+DN
X-Gm-Gg: Acq92OEcUlatD/pO3tYUw1KCzFl3kurX1KJJrT1bYwDsFfJrI/PSuOu2Ry6ubE/qELd
	wbDYtOQaH1EKUfWlEMKxcHCczyMBBoHKbrSqGSOodRly3dO45B7rmFBybi0ySani7S7PTtEM/eD
	MG6TUN8bvl0OUG4KQgb4X3UBu3zc4RNp9RenLebSqjCtMZzrW/YeM11+93IWGjCKRD8s/Q2n4vy
	fSxByJ/LNS1UVPZ0AYWv+bNl0mEZ/rbkIQMzBSRv3+8O4g3YMuu0D8eZNbK+MIIGLRiVx3ogszb
	eXTnnNfMFbhJSMojNUj9rcJsqLwUpGu32v+YBxmXD+B1IrUYRFEBnmiGfonW/NSbE2484kjuSIb
	B74bBWd8lHaoXO3NY3mNJ1RtEwCBJZmIkp/koORg6Vki3h3lylgU2ROtiBj2aaYg5iuqSKyNbKA
	gCF9gxXnPZb8RnWbunFxv97bz+XMSyVgxp9C73Vrpq0QwJFtC8vGAT5qCv99ZOf86jVMg8N8IKr
	d3NM/tQn3Ue
X-Received: by 2002:a05:6214:4291:b0:8ae:6460:c544 with SMTP id 6a1803df08f44-8c7bc05a2b9mr122449846d6.41.1778768157667;
        Thu, 14 May 2026 07:15:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c359c74sm24280456d6.45.2026.05.14.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:15:57 -0700 (PDT)
Date: Thu, 14 May 2026 10:15:55 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 22/31] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <agXZGjyvs0AHCpnZ@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:07:05PM -0400, Michael S. Tsirkin wrote:
> Propagate PG_zeroed through buddy splits in page_del_and_expand()
> and try_to_claim_block().  When a zeroed high-order page is split
> to satisfy a smaller allocation, the sub-pages placed back on the
> free lists keep PG_zeroed.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

Already reviewed this, but noticing the same pattern - wondering if we
should just snapshot all the flags and plumb it through instead of just
extending functions like this to have infinite bools.

> ---
>  mm/page_alloc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d70c9ba6b329..468e8bde7d34 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1712,7 +1712,8 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>   * -- nyc
>   */
>  static inline unsigned int expand(struct zone *zone, struct page *page, int low,
> -				  int high, int migratetype, bool reported)
> +				  int high, int migratetype, bool reported,
> +				  bool zeroed)
>  {
>  	unsigned int size = 1 << high;
>  	unsigned int nr_added = 0;
> @@ -1743,6 +1744,8 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
>  		 */
>  		if (reported)
>  			__SetPageReported(&page[size]);
> +		if (zeroed)
> +			__SetPageZeroed(&page[size]);
>  	}
>  
>  	return nr_added;
> @@ -1754,10 +1757,12 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  {
>  	int nr_pages = 1 << high;
>  	bool was_reported = page_reported(page);
> +	bool was_zeroed = PageZeroed(page);
>  
>  	__del_page_from_free_list(page, zone, high, migratetype);
>  
> -	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
> +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported,
> +			   was_zeroed);
>  	account_freepages(zone, -nr_pages, migratetype);
>  }
>  
> @@ -2335,11 +2340,12 @@ try_to_claim_block(struct zone *zone, struct page *page,
>  	if (current_order >= pageblock_order) {
>  		unsigned int nr_added;
>  		bool was_reported = page_reported(page);
> +		bool was_zeroed = PageZeroed(page);
>  
>  		del_page_from_free_list(page, zone, current_order, block_type);
>  		change_pageblock_range(page, current_order, start_type);
>  		nr_added = expand(zone, page, order, current_order, start_type,
> -				  was_reported);
> +				  was_reported, was_zeroed);
>  		account_freepages(zone, nr_added, start_type);
>  		return page;
>  	}
> -- 
> MST
> 
