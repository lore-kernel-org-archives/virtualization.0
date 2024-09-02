Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016FE1547C3
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262430; cv=none; b=P1Obe2LIlUzIWeRUnNtvA6jk1Ru8rbaDKtM9P3xbvH4htmJBamSPn8/TOCFg7rZby0HeAnGr+8dyd8cchhKR3lhr4YbEPRz++WbvzTCXXwF/bwXgwU+xTZrQpdTdim45WSXzZMm7NULyCgrDzE3vbJJM1NQnSkCqlY5cqI66ho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262430; c=relaxed/simple;
	bh=tzcV1ryyygRnDFoA+s8ax+VKHwGX0nYNIfE5j69FG5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJqIK4k0Bcu6rTuPh4zAuRlpNbjsO9rWJFxmeIdOetUqdBfpz9S3BWW2X1ULT+8TFhAEfW8RsajIzzVN/MVEOQwiN8m4BKiw7U+wvUqro77yfUsBusMQOEEpSQoPFLEWtKeez2PgSrlfzPyGeIXsj0cYVAdEyW5yxvSpm+7eejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpbHEBVi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpbHEBVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725262427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jb0igNjox3SxUu1oB+ccbTFIu0nBFhOjezg09+DB+qI=;
	b=LpbHEBViuqo1UQBe1GaL8ZG+cSW5gxo9t44ubQb9RNw3bVdGO8RaIm1PfSESvClMKJfrsC
	9wHwLkJa3C3bJsUMV5n9Dnf48PJzdyuzls4e3yzqLwnOrVCRi9TsyCk02ji6/aP79qQAE0
	Iu97hV1bHN1i5TmTgoxWDyN0Y7FsTso=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-PArSs1qfO02eCTG8IVZaDQ-1; Mon, 02 Sep 2024 03:33:46 -0400
X-MC-Unique: PArSs1qfO02eCTG8IVZaDQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb9fa67d7so35711745e9.0
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 00:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262425; x=1725867225;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jb0igNjox3SxUu1oB+ccbTFIu0nBFhOjezg09+DB+qI=;
        b=fJCJP55dGAMZcHpIDP3cnQReVRnoONJmHQUlwWPqXKFV+uXsxhmOrxJW/JppVlBC+z
         tTQsAxEG3Gc8/To9yIsNY3/mom9dR7s0rwEyy0tI9/fbufSXMSESrFbiYghKg4BtmKXu
         oqecFXSSeM/INm4OHaoPd7sKeNBrfpYh1F3Va+FgTpnm4u9+qxxty0w9D5zRO84KxBT1
         x5DqZPUoHtWICRwT7JL2B66APl0MSCwwHkW+tVIe7rZOR7Q3ZqM89/v/cICREGOyM2h1
         2lryIjZWnBZx7zwlWiTP8IsHCGuwQZvQdw44FIVtIStAhmglhn2ibVpPaozQT2JLTRir
         kxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaKngXpHQmBvTNHOeZ3T6HCOox4RT2LOBFwxZwxrPnvUtxjXIvRpk9XYi+9wjU4CxbkaEvm3FBSIdjRV9HGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdpBtgwxRjV26qtmdnB19sfz9vW6LUnaT1hb5AsNOypxDQmlnP
	OIx5sO4iN3wXZRw6IvG/5qmZl9mqalBbGqMMsHpOAAAkJeFKcEuI6UYf1fddc1MkFp1X9I5Widu
	Ud25jYN5ObCAWyiZFtm+a53a6aje+SpFfdU56tPWrRN9pYKraSktBZdqBVGZyLbF2
X-Received: by 2002:a05:600c:1d9d:b0:429:d43e:dbc3 with SMTP id 5b1f17b1804b1-42bb020b7efmr137211575e9.34.1725262425279;
        Mon, 02 Sep 2024 00:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErAuCKazvJCSg/ZPbbL9EKhg/S9J8VwrPBFrUEooB6CeM4i/PcytnJ6we1p/xsEmLxRZ7CiQ==
X-Received: by 2002:a05:600c:1d9d:b0:429:d43e:dbc3 with SMTP id 5b1f17b1804b1-42bb020b7efmr137211055e9.34.1725262424343;
        Mon, 02 Sep 2024 00:33:44 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374cbbc8281sm1656354f8f.64.2024.09.02.00.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 00:33:43 -0700 (PDT)
Message-ID: <0804627b-49da-4ee0-a09a-19b87a7fdc3d@redhat.com>
Date: Mon, 2 Sep 2024 09:33:42 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] vduse: avoid using __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, laoar.shao@gmail.com, Jason Wang <jasowang@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>
References: <20240830202823.21478-1-21cnbao@gmail.com>
 <20240830202823.21478-2-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240830202823.21478-2-21cnbao@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.08.24 22:28, Barry Song wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> persisting in providing __GFP_NOFAIL services for non-block users
> who cannot perform direct memory reclaim may only result in an
> endless busy loop.
> 
> Therefore, in such cases, the current mm-core may directly return
> a NULL pointer:
> 
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>                                                  struct alloc_context *ac)
> {
>          ...
>          if (gfp_mask & __GFP_NOFAIL) {
>                  /*
>                   * All existing users of the __GFP_NOFAIL are blockable, so warn
>                   * of any new users that actually require GFP_NOWAIT
>                   */
>                  if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>                          goto fail;
>                  ...
>          }
>          ...
> fail:
>          warn_alloc(gfp_mask, ac->nodemask,
>                          "page allocation failure: order:%u", order);
> got_pg:
>          return page;
> }
> 
> Unfortuantely, vpda does that nofail allocation under non-sleepable
> lock. A possible way to fix that is to move the pages allocation out
> of the lock into the caller, but having to allocate a huge number of
> pages and auxiliary page array seems to be problematic as well per
> Tetsuon: " You should implement proper error handling instead of
> using __GFP_NOFAIL if count can become large."
> 
> So I choose another way, which does not release kernel bounce pages
> when user tries to register userspace bounce pages. Then we can
> avoid allocating in paths where failure is not expected.(e.g in
> the release). We pay this for more memory usage as we don't release
> kernel bounce pages but further optimizations could be done on top.
> 
> Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce buffer")
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Tested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> [v-songbaohua@oppo.com: Refine the changelog]
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   drivers/vdpa/vdpa_user/iova_domain.c | 19 +++++++++++--------
>   drivers/vdpa/vdpa_user/iova_domain.h |  1 +
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 791d38d6284c..58116f89d8da 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -162,6 +162,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>   				enum dma_data_direction dir)
>   {
>   	struct vduse_bounce_map *map;
> +	struct page *page;
>   	unsigned int offset;
>   	void *addr;
>   	size_t sz;
> @@ -178,7 +179,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>   			    map->orig_phys == INVALID_PHYS_ADDR))
>   			return;
>   
> -		addr = kmap_local_page(map->bounce_page);
> +		page = domain->user_bounce_pages ?
> +		       map->user_bounce_page : map->bounce_page;
> +
> +		addr = kmap_local_page(page);
>   		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
>   		kunmap_local(addr);
>   		size -= sz;
> @@ -270,9 +274,8 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
>   				memcpy_to_page(pages[i], 0,
>   					       page_address(map->bounce_page),
>   					       PAGE_SIZE);
> -			__free_page(map->bounce_page);
>   		}
> -		map->bounce_page = pages[i];
> +		map->user_bounce_page = pages[i];
>   		get_page(pages[i]);
>   	}
>   	domain->user_bounce_pages = true;
> @@ -297,17 +300,17 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
>   		struct page *page = NULL;
>   
>   		map = &domain->bounce_maps[i];
> -		if (WARN_ON(!map->bounce_page))
> +		if (WARN_ON(!map->user_bounce_page))
>   			continue;
>   
>   		/* Copy user page to kernel page if it's in use */
>   		if (map->orig_phys != INVALID_PHYS_ADDR) {
> -			page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +			page = map->bounce_page;

Why don't we need a kmap_local_page(map->bounce_page) here, but we might 
perform one / have performed one in vduse_domain_bounce?

Maybe we should simply use

memcpy_page(map->bounce_page, 0, map->user_bounce_page, 0, PAGE_SIZE)

?


-- 
Cheers,

David / dhildenb

