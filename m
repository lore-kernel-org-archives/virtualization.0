Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15840B6DB
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768300; cv=none; b=jf0aXNYsSmlDDMugohFDRZhONUEvDgtr3lHE6WH+Kjw7rLNXk7Z7wDTrcqDLI2SHbWzGTR11j+bfS+AOFYpHsKSFKEG5ggt6AiAAAYBBfm7PvyCPDBnTf79H8V30CibCAJRgGu85kl82D8z4Tnhkpn1TOABI9XgQehKvJYI6BHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768300; c=relaxed/simple;
	bh=tR7HBnXcRvhr9e8wICQVfKt2M4sFwwxii45O/8/lMwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifP4XxxrwxPa3WMrJBKMsAv8yzwetJ1zRMGaBEdtjkkn/0s5zuHE3r4juYzvfZ6vvZ6ORGIVXObzE22q4kX7gJMPbVoeseNbq0ibmk4Oxze3IgMv8TX2aDxOOp+5rBGnSyxH/hzJI4c5uBgqqhDL36dAsUvYNwAxHbTeRzHX3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SmacJFZv; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SmacJFZv"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-512f09ecc67so56399871cf.3
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778768295; x=1779373095; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Udw7U8NEOe8VBRr2vcKKOP0dv7EjKft6lAXRk6WrK8=;
        b=SmacJFZvRfvegdPN7O8kDxbBBsutZ78ikYy4fLLalvpqfcG5gG3l5ccZrr9SizYTMW
         dbbns1EkG3FBxh8Xbr9eyLGIRBNYvhZn7e1FEeKTFlIsV6CQRo/1dQbT/cB9ARrsRO/y
         49KjIBXwpLP+Q43DiB+zw2hs0VCStfCf3Gz6K1Zv/BtjE0tQQVXWdx4Ba3ygZwCvMlMS
         LPK3xurPp2liusH7xph1NwpLnhb6jDI60x3NAz7NNBXlzMMaQhA4SFDiyHFrV2pP8wK8
         OfY1o+zcpUpKatK1JZD4CxW9/XfonjTCrW5DxpSARfkwvyXmLZEruSD2pNWHh+klEtkB
         0bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768295; x=1779373095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Udw7U8NEOe8VBRr2vcKKOP0dv7EjKft6lAXRk6WrK8=;
        b=CiMyiI3p0DJ0UGBysPllpuNLubDmXgBJh4GzpxgaEKO/pMFSBrzFAgdGYlpocJYwhp
         D+Qasy6j5SRL9XF/1xCDugtNr2c7XevR2jYPBQVr0VHHKGnP5wQdR7iv+8Qwwj3kD998
         9NYBUKuD1PEmLB6wPve3KMSKBAG/M2dYbaC9nbUB3v/Xzh61lbSAGQ/czX/oBBayfg9e
         ajdpcweFJp0d3qXtkYX+wltBaJOnPkUCSt9okfDC8kmpPDTvka7pbaXiWCwNBSZXmR0G
         3YvkB09C6K+IrXhHs4czssuVJ8TMxNvuOzvcPmR3eo3u+V9b5CM6vqDeVjijTNBpLIVq
         vLnA==
X-Forwarded-Encrypted: i=1; AFNElJ/+YMztDfKVOgE7aFk9Dt3t+BdB1hEbb6CKAIODrbcQx4Y6DW0ObT1CkPBZ8zHBIeUOuxfCRuXMstlGZooWWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT24tHGtcHbSzqZRc0UKwyMGJG3sRf3NBfcuv3LEXOFuXfp723
	WSLj251DatEY1HAkxYxxVceiEk1KFR1eysuwEn/34/ZuZZH1NwcxOTg0d/ZlqNw3YvM=
X-Gm-Gg: Acq92OHA8xW0qOfI6EpcS7FyKd5vDVc8glNrzOnVYyb2oEgDmQDaMRcg6rNHNGnEELB
	l0ycHZOAYxutY5P5ggB2vLxRMrptW1WQkDtY+1OZgkxTJliBFxDWMhNBsuHoZDc3OKdw8ybBodX
	BTQ0PKiIFqhZeVqDDh/s8+C7NFr8iEyujxXbgq3H8JG7JuRJXKco0ifoU0cD76Vxavfj442XoU6
	XsPcbzWOTSSMYMUjnJVz1v9rnVVR5ewQdxA5q647l7qqRWSoJTaHDo7LW2f4G1g7clh1kFeHMDL
	cNTjBoot4CbCgy/OeL09EqCX8dWok7fOZk2Pnpbj0hQeUc+nf812p8cJhHzVu+9iHnY044+jvOL
	muU/t7RoRUUeCvqN/QZei0cxn4SNivc9V2t6pO263tYQWVNvv2xTfjWsR5QRIbj5AacWZEo+dQF
	bXA9b1PBXv+owYdlqLrYk73MWEyITUHKrqZJ3SZZj21wNaqbwV5GBwcasRzpN2NR+ui4YW73c3+
	Djv4AjMT+gVyWOmPGvs0F8=
X-Received: by 2002:a05:622a:13d2:b0:50f:b904:457 with SMTP id d75a77b69052e-5162fec90b0mr101142431cf.25.1778768294997;
        Thu, 14 May 2026 07:18:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm17671591cf.18.2026.05.14.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:18:14 -0700 (PDT)
Date: Thu, 14 May 2026 10:18:12 -0400
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
Subject: Re: [PATCH v7 25/31] mm: page_alloc: propagate PG_zeroed in
 split_large_buddy
Message-ID: <agXZpHKe6zwxnGgr@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <2db0d124c647e711c0bf95b1c7f1316a0d1408ae.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db0d124c647e711c0bf95b1c7f1316a0d1408ae.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:07:20PM -0400, Michael S. Tsirkin wrote:
> When splitting a large buddy page, propagate the PG_zeroed flag
> to each sub-page before freeing it.  __free_pages_prepare clears
> all flags (including PG_zeroed), so the flag must be re-set on
> each fragment after the split.  This ensures that the buddy merge
> logic can see PG_zeroed on pages that were part of a larger
> zeroed block.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 468e8bde7d34..ce43f5a3dbaa 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1523,6 +1523,7 @@ static void split_large_buddy(struct zone *zone, struct page *page,
>  			      unsigned long pfn, int order, fpi_t fpi)
>  {
>  	unsigned long end = pfn + (1 << order);
> +	bool zeroed = PageZeroed(page);
>  
>  	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>  	/* Caller removed page from freelist, buddy info cleared! */
> @@ -1534,6 +1535,8 @@ static void split_large_buddy(struct zone *zone, struct page *page,
>  	do {
>  		int mt = get_pfnblock_migratetype(page, pfn);
>  
> +		if (zeroed)
> +			__SetPageZeroed(page);
>  		__free_one_page(page, pfn, zone, order, mt, fpi);
>  		pfn += 1 << order;
>  		if (pfn == end)
> -- 
> MST
> 
