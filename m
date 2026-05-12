Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488F3B8407
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601962; cv=none; b=syFH0IDY+5UElII11yEHyHTPRzzlcZsEH0YnqolaUmZgoYDijuBbAy4R6rHltmB9F9RLBLqZr7crHFlht2iS4FIvuUzZf7GenEJdLhrX+sZAxtRTMaXFfv2wS/lLB9JL5c7B+AiyU/sdJ7LaBlw3NdTQW3opVTqRB8Was3S3Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601962; c=relaxed/simple;
	bh=Yi6Rp7UIARB3eBJI/atclf4lpHati2LJs9UFypZbkaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThwaHBtbt4QXHT6NhRkOqFLuXUbJif0FF9VZgxf+tPWPWexsbQn2PHFIuOJq7GM3g0ZrdCWGrLwevjQtVoZXCJf3paHqwrUvMRBScAL3cmzpH/byyi5OSs6U4Wz5xJvxYsY3g5t5T59qf6BU/bUZ/QIEcCaH1xD4dWTptVUMZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=S85VesGK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="S85VesGK"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ef2118b478so586559485a.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778601959; x=1779206759; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vN4J9MHI2MOI8oQ+XLl0/GT7idJevwCHKcj7tn/iahY=;
        b=S85VesGKvydPY08iKvuqAnseqIjCR1STB94gaTxuc/iOJLI26XLcKFEMGhTZUa1Srn
         iYUZZMWXO3esWMPBpd0r7HmQB4eNVYYq9wI3pXF8YzRsvniN8s4hr12LU0p8Pu5Zk4cN
         mjykmKAQIXoeYPsKtCKKRib7zV1Sn5qxG+NkYCZFeJtZMoKrVMa1uWebCKWhOb2mVZrp
         TxhK8gHKx26zxrEmZo+E+IKyF9CaFMUm4AJx+Jo72ARfabXVB+oAnmgsdM2DRWopEqu/
         GBVWb95VoqMkZMh7pJu1WTPbABtzv9MpezMkoCy7qqtP0LfpVOsapGAPb/u4Cv+YKg2D
         3svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601959; x=1779206759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN4J9MHI2MOI8oQ+XLl0/GT7idJevwCHKcj7tn/iahY=;
        b=GLy59/WYh+FFBM65sSQF1Dat1ZssnpnTzsj8FdjBpCWh4iR90L4c0PHk92LH/bZThz
         RczPtGWkxKyOxcuxQ+6T5fGItoZ1AQ3x31MfJ/v0g5+/dsn2XeYZWeoNeXhZwZOIHAXE
         oGxlyTzIfXs+Dcug4cPZRO/qipY6hdcByX5gFOVPRrJqH/SJy8vpHhX03m1A0QKW55xS
         LHlW2ansBZuI0GwsdK5FBHx7JHjpZjWiDOaOwGlcK9yUXxSD0b13VF8H1hEEMrQmr2Lh
         AJPMQdehPIXYtLfQDxvuwcszDkyjrij7Lnn/iI+9FzyvP4BZG2gMuD/l/lYqW4ITeomT
         tS+A==
X-Forwarded-Encrypted: i=1; AFNElJ/M5Zk3o45+R6WgyLlYfPuPSYhFbJ4KCNmIgytEsnH0G9ZKypwlPaWIxKxImUKPIEaOtbzUbB9rA02x4/hWGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVmHk2e/2BBpwuQAtJnl/vInfuCJvemuIlJG/GqLpqIY0/E1u9
	luSC/3SMm8pEPN70KWcyZDd+BCvmJ4OY4mCoFzv3jUJuX1XZYSV8sfp3HH3v1G7FlvY=
X-Gm-Gg: Acq92OFm/MXN4nSHk0nM6tMB0/1LS/YTjdETewblvuYJXbA+KLhQa8TMVwwDBSK2WxW
	0irGvtpkPQR89F2sManpThudlgS2QkEqatx4i1SWxRxS8TnKLgrkFq2oIOkNvMjgMBH32H45EZE
	YZGJrN4bIx2JtOB4Qjme9/lKc5IcBQyUyjP14PClICcHck2/F+h+US1arvoW+kVJiWkqC4jm1Cr
	urUYlGvVuYjKQMhZ47dEsB3Bqbo9hVL1NNC2Wjrq1ZwPKYp8ZlD0PyJfusACNbU925xf7mu8C+d
	2n/uYt0faSwC6KVLXl+Hh92lg6oi4R0WohCechqPYs9urc8DyQBcUG7YLea/qF4OdaXQPGs/Sxh
	iw6iab7qMhsFYNVm013q96CrK2i+cmq4wC18nFKh7YXn2mnh1EyallnlhsxPGR7KmjUX5455shz
	fGSzblQrcl7rBWu3Uc3hFzt2FrtE5WgZu4ElYReIuBVKFGK03tjjEyMBaAHs5gTOZ9TZa1AAUOc
	cqcJbrOdAkv
X-Received: by 2002:a05:620a:2584:b0:8f8:d217:f46a with SMTP id af79cd13be357-904d3fa500bmr4114490285a.8.1778601959278;
        Tue, 12 May 2026 09:05:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c807sm3755667685a.32.2026.05.12.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:05:58 -0700 (PDT)
Date: Tue, 12 May 2026 12:05:55 -0400
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
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH resend v6 28/30] mm: add put_page_zeroed and
 folio_put_zeroed
Message-ID: <agNP4x4oobMra1PH@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <450465e4a03e63381a4bb8a1799a25859d7fdd83.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450465e4a03e63381a4bb8a1799a25859d7fdd83.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:04:19AM -0400, Michael S. Tsirkin wrote:
> Add put_page_zeroed() / folio_put_zeroed() for callers that hold
> a reference to a page known to be zeroed.
> 
> If this drops the last reference, the page goes through
> __folio_put_zeroed() which calls free_frozen_pages_zeroed() so
> the zeroed hint is preserved.  If someone else still holds a
> reference, the hint is simply lost - this is best-effort.
> 
> This is useful for balloon drivers during deflation: the host
> has already zeroed the pages, and the balloon is typically the
> sole owner.  But if the page happens to be shared, silently
> dropping the hint is safe and avoids the need for callers to
> check the refcount.
> 

I see this gets used in mm/balloon.c not the driver itself,
should these be in include/linux/mm.h or mm/internal.h ?

Just wondering the utility of this being exported for drivers.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  include/linux/mm.h | 12 ++++++++++++
>  mm/swap.c          | 18 ++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3b1ca90fd435..4c51b7bd7576 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1913,6 +1913,7 @@ static inline struct folio *virt_to_folio(const void *x)
>  }
>  
>  void __folio_put(struct folio *folio);
> +void __folio_put_zeroed(struct folio *folio);
>  
>  void split_page(struct page *page, unsigned int order);
>  void folio_copy(struct folio *dst, struct folio *src);
> @@ -2090,6 +2091,17 @@ static inline void folio_put(struct folio *folio)
>  		__folio_put(folio);
>  }
>  
> +static inline void folio_put_zeroed(struct folio *folio)
> +{
> +	if (folio_put_testzero(folio))
> +		__folio_put_zeroed(folio);
> +}
> +
> +static inline void put_page_zeroed(struct page *page)
> +{
> +	folio_put_zeroed(page_folio(page));
> +}
> +
>  /**
>   * folio_put_refs - Reduce the reference count on a folio.
>   * @folio: The folio.
> diff --git a/mm/swap.c b/mm/swap.c
> index 5cc44f0de987..8d57223dfe34 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -94,7 +94,7 @@ static void page_cache_release(struct folio *folio)
>  		lruvec_unlock_irqrestore(lruvec, flags);
>  }
>  
> -void __folio_put(struct folio *folio)
> +static void ___folio_put(struct folio *folio, bool zeroed)
>  {
>  	if (unlikely(folio_is_zone_device(folio))) {
>  		free_zone_device_folio(folio);
> @@ -109,10 +109,24 @@ void __folio_put(struct folio *folio)
>  	page_cache_release(folio);
>  	folio_unqueue_deferred_split(folio);
>  	mem_cgroup_uncharge(folio);
> -	free_frozen_pages(&folio->page, folio_order(folio));
> +	if (zeroed)
> +		free_frozen_pages_zeroed(&folio->page, folio_order(folio));
> +	else
> +		free_frozen_pages(&folio->page, folio_order(folio));
> +}
> +
> +void __folio_put(struct folio *folio)
> +{
> +	___folio_put(folio, false);
>  }
>  EXPORT_SYMBOL(__folio_put);
>  
> +void __folio_put_zeroed(struct folio *folio)
> +{
> +	___folio_put(folio, true);
> +}
> +EXPORT_SYMBOL(__folio_put_zeroed);
> +
>  typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
>  
>  static void lru_add(struct lruvec *lruvec, struct folio *folio)
> -- 
> MST
> 
