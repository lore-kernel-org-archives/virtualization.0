Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FE3B813E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601504; cv=none; b=oh+tF5q13eVznrAmH2u4fnm1acmWWa/5x+Yk+9c7WmFb80hMJAzFAkpU9a69/vMtbZmbS0mcBs/oCx8D1tSX2R04K6gHXzZYZth3cUuAAKARRfLPqp5Y5zeRTv90pAIwJ+14v7BPrTmogiHgs247T4qKF2c4dTzpOHfzAr24Ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601504; c=relaxed/simple;
	bh=NzD4h2kSUF+6CRseCSre92wX0gOpPLHk9AG9LuS8TK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkQqA1KZ+4PXX6E5o9Byie64tmIXRuzznHLQ/9oJukylG7pM3fyhujEb5N2mO2pF/O2x4MBRMqvG+EqXggKVrQ01tUQmvfuQD2id0OrMErxGXM/9Uk97kdYjSG9GEblZTRTH7b1THVAfsZFdIKdVUj9n4gfN7dEM17pRIj6SSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H3uYFwo/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H3uYFwo/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8d4f78fc9f6so579579885a.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778601501; x=1779206301; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEDDU+f7CbkQFEw8YKAGo16eQTvjIgO+nLY/Z+AdBuk=;
        b=H3uYFwo/lgmUyyUtek3NPLc6LbOMmyjfRk0EPYSsZvjEX/OltY5hyunGRYIMmdu+wX
         k4r05NThnlGIz4bwkJAStqMdYr+KJA/9+BhTGFcpJJkKlaV1Yt2Ds/YrjRy3LF2XUpFZ
         t6Smr3tKAZoBfmPCpuw2q39U6ybuTGqU5+nYAq9gn/CtBtsxNAHJwr6LqVztFY7P2mcX
         1GytKrrZF+MdHkIzFRQ2zHznSZvBq2eTtnFSGYyb09OttqOq7C1no3lJGkYU9+joEk/4
         jbN5q5JS8bFVHdbDY489CS9nVkPH7WbNUGMaVY1qvHr1BTDa466+1YndIuwyIp4azTfB
         BOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601501; x=1779206301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEDDU+f7CbkQFEw8YKAGo16eQTvjIgO+nLY/Z+AdBuk=;
        b=OlfJTA5hVMh57l/9U7TAyHaShzGbYDn7AZcub3m4VZxbB0QJWiAYVY3n/8lgaGFM7C
         xo26XTVAV6I5UobILYt7nFSfjHqTsEPTFHMg+EMkA2ByuPrZZq2vMflYIbexzAZCLEH5
         2WnJt6xaMCUUvxB3ygEbfc8/nsonK4qltbIDCCseRjaTbzwyG+syO9Sr2qNLIjVcpOOX
         9KBWszQQGb6t9YAvI1joD9Syb7c0rJcvvfj5RiF/wemzKeiBLea5WY4CgHOektzBHiX2
         XByagG9vLsofAHFaQu8WJhp7xrpxo2iD1S3/Qr7lBUk4dGXN0+nCwkHoGW2L4Q2nvxfG
         zFZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SK1YkGv05M1bZVDdpypN2rA4w0QN4lnMKAf95Iw5cLbh9+OGQdsi6z023kUN7Qt9IJ0eCjmP1+Ac/LjAAyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvocEaM/wE6JHvEIH/3EFoYSRX/yVJdLL1pnfu/AUHJT5xZntU
	EfKSHQzCUSOVc4HJX6VZMAHHlfGSR/XsAXBmuHpNzCjiVpGsj/7LLK9lTqa5Gj684c4=
X-Gm-Gg: Acq92OEmDrQuutH/f9Bc3OFnSxgUA8Os3fgYSrMm7AaD8+4DQSMZTKu40yS8sfGHT8u
	U7PhxsYc9YWDoNHbrL1Pwab0hhz2gq7EFEnKRJ9Vq1MDNIcX9TF2D8AtDgooALMBPeh8X8zn9Zy
	B/BZRIsEEYtt3MhzMQ+pEakfsFdawQf7LOlsNt7BlAiTowxOiNoS76Ypn92XTvtdSp/aigITL2z
	SYh/3ixKFioB6OOIxnJgdf+mRv3+CMWK9FaBaD4XV45cj+ElPDonSIvNArO0jhGY7XXpGsYqw40
	oZFL3QrvJayLQ+3o2uqwpxBrPWEWMYNwSRtGaOyb7oBuDxUxxf+VCGH7ZVmaAsjJZbHLXlc+0gd
	V9fyc1JOPuOcSVI66oJ6aOrPKlDguOsuaKyvN/IBd+FANIM2x1u/i+o69EetuymSJu6h3rArfyA
	abm3D7ZygTJ3fC+IbmgDepb2cMeum3pf9Loxu54tTE+TBc5cz7Z35/Amjq8GM+EtByX6lqYqhen
	SQ7G8FAAAzw
X-Received: by 2002:a05:620a:46a5:b0:8cf:d6f8:599f with SMTP id af79cd13be357-90cffa5b9a3mr483433885a.57.1778601500616;
        Tue, 12 May 2026 08:58:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8e9b24asm1421777085a.18.2026.05.12.08.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:58:19 -0700 (PDT)
Date: Tue, 12 May 2026 11:58:17 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH resend v6 21/30] mm: page_alloc: preserve PG_zeroed in
 page_del_and_expand
Message-ID: <agNOGSyndMSU33WO@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <57d30ce615c23d3f3737e38d300f4613b3ebadbc.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d30ce615c23d3f3737e38d300f4613b3ebadbc.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:03:41AM -0400, Michael S. Tsirkin wrote:
> Propagate PG_zeroed through buddy splits in page_del_and_expand()
> and try_to_claim_block().  When a zeroed high-order page is split
> to satisfy a smaller allocation, the sub-pages placed back on the
> free lists keep PG_zeroed.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

Reviewed-by: Gregory Price <gourry@gourry.net>

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
