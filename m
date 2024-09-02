Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57044182D2
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263942; cv=none; b=fYPWKgG/NUIbTipruZoJAnY8TKA50WnWmS24D2prHRp+InOnRqxU+MAHSjuYAojr1b7E0vaTNa9cETdyLeJWr3Czk3dM+qUI2hlbK/0Ho/Z1+hXP7iRqMqYYJH/UFH1dcjxW26iyXe/91noS8SB3JePvar1/xUQcmB+GcUAiS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263942; c=relaxed/simple;
	bh=h7thEfpyXagJ0ez+Im/MSITyKePB33sjh0H0SQDxyNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWxBY0B48hjpi4pGfDdVBprkCCCp0txEepz7I567QjXqx/NsTrpYzsqUWAGlFM2ZZVFRZjzceMfjw6cu74iee0NxhNObo/MxLp6jPE2+a/cAE0D7ZUjFZee6ES8OM4Vx4Rp0Q9I/OevOyBBu67FbeVrxBk3cl5A4En9Ke54Nfa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HTlrfyxW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HTlrfyxW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso423457366b.2
        for <virtualization@lists.linux.dev>; Mon, 02 Sep 2024 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725263938; x=1725868738; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vphCIwTaRUFU4blmExsrKpls/AaTUjrPE8gLIEy8J3k=;
        b=HTlrfyxW3pEM2j3+EzFHYJd1h0wHCoCMUcreBoUKuoLOWj0Zhzrk872PW1YWPDxcX+
         KjD2Jcz0Phl9uVgO66nnYR+8Oolti4S+Mzo0aIiFg/RY24vaK6Tajdh/VZcmcAPXh19j
         bQQTus0c7hGjG4fPDjWW06nJ1FJKLFBePuc8fuv7a+187clNbc31damWYXpIQerrOlgg
         wrOSJblEb1QdpWSAXg6k0K36Mrcj6G9a8QypKaY+jd+5d0BBV4SrY0c8gSK/vakHb88Q
         NBFeaAquHPDAqWLNMo6lQbOTzRhOjhXEdHlRV3byVabZ6dHtJjLnZjJyJznF5e7sYNpk
         a1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725263938; x=1725868738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vphCIwTaRUFU4blmExsrKpls/AaTUjrPE8gLIEy8J3k=;
        b=OtTr16RXcqZ43RoozejgKgPf8UuSwBqX1aHM+cvjUBRr6+6nF7BWKCPyBuQB0YLrjK
         LviiF8we6clGIdi0i+44Sc+6fNIQx49gzrAjQuf9QPrRFkc7GDt7WLtodFji/i2bUb5y
         PJpzSbNyK36mEFuEEGb4lsqyVUuq2y28XZseFsiZewZ52O/CakI/FWDrkcY0qKqG+QAo
         WhCsM+WPpvSuyX5R01HQRC1gtvs3MPgknvfAD7cZUJOsKbV5UEZ99clP/j3LkF4wv5Dt
         4JPOV0MDCA03V3Ok5C4R+GmUhn1xn5E2f+eAEjmv6BjDYxxMC1MTjNPG4uf8c7y4K3CS
         cD3w==
X-Forwarded-Encrypted: i=1; AJvYcCUwB6xD9NMYU906Rvu9K6U15Ca4/kGAQlw2RJ2AGLhQqVYrQ4MiMrWOsIY+m03WOmfNeVrHrTCj7pJHamuoyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiADGiykXq1Q4AZCy1IdEOnK1GA6MA7YzRGy/9Wk9gFIRl6R8V
	f0Hf4ZHczKdF9iXKohIDCbHHMpnoHYPfArHNi2MNxq7vqWfcvtkZPRIkad48hiE=
X-Google-Smtp-Source: AGHT+IGOQxpkEzaJaHfH2XItf5G0tf2oHKzZYsIHrya04Evs+lCIYHbOKyrJgIkWiYuosAqx23TC5g==
X-Received: by 2002:a17:907:7e92:b0:a86:7c6e:2bb9 with SMTP id a640c23a62f3a-a897f7892e8mr1115978666b.2.1725263938450;
        Mon, 02 Sep 2024 00:58:58 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d8117sm529922366b.172.2024.09.02.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 00:58:58 -0700 (PDT)
Date: Mon, 2 Sep 2024 09:58:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, david@redhat.com,
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz, laoar.shao@gmail.com
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a
 more appropriate location and manner
Message-ID: <ZtVwQL52EmIIyDsK@tiehlicka>
References: <20240830202823.21478-1-21cnbao@gmail.com>
 <20240830202823.21478-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240830202823.21478-4-21cnbao@gmail.com>

On Sat 31-08-24 08:28:23, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Three points for this change:
> 
> 1. We should consolidate all warnings in one place. Currently, the
>    order > 1 warning is in the hotpath, while others are in less
>    likely scenarios. Moving all warnings to the slowpath will reduce
>    the overhead for order > 1 and increase the visibility of other
>    warnings.
> 
> 2. We currently have two warnings for order: one for order > 1 in
>    the hotpath and another for order > costly_order in the laziest
>    path. I suggest standardizing on order > 1 since it’s been in
>    use for a long time.
> 
> 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
>    is meant to suppress allocation failure reports, but here we're
>    dealing with bug detection, not allocation failures. So replace
>    WARN_ON_ONCE_GFP by WARN_ON_ONCE.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Updating the doc about order > 1 sounds like it would still fall into
the scope of this patch. I don not think we absolutely have to document
each unsupported gfp flags combination for GFP_NOFAIL but the order is a
good addition with a note that kvmalloc should be used instead in such a
case.

> ---
>  mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81ee5662cc7..e790b4227322 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
>  {
>  	struct page *page;
>  
> -	/*
> -	 * We most definitely don't want callers attempting to
> -	 * allocate greater than order-1 page units with __GFP_NOFAIL.
> -	 */
> -	WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> -
>  	if (likely(pcp_allowed_order(order))) {
>  		page = rmqueue_pcplist(preferred_zone, zone, order,
>  				       migratetype, alloc_flags);
> @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  {
>  	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
>  	bool can_compact = gfp_compaction_allowed(gfp_mask);
> +	bool nofail = gfp_mask & __GFP_NOFAIL;
>  	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
>  	struct page *page = NULL;
>  	unsigned int alloc_flags;
> @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	unsigned int zonelist_iter_cookie;
>  	int reserve_flags;
>  
> +	if (unlikely(nofail)) {
> +		/*
> +		 * We most definitely don't want callers attempting to
> +		 * allocate greater than order-1 page units with __GFP_NOFAIL.
> +		 */
> +		WARN_ON_ONCE(order > 1);
> +		/*
> +		 * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
> +		 * otherwise, we may result in lockup.
> +		 */
> +		WARN_ON_ONCE(!can_direct_reclaim);
> +		/*
> +		 * PF_MEMALLOC request from this context is rather bizarre
> +		 * because we cannot reclaim anything and only can loop waiting
> +		 * for somebody to do a work for us.
> +		 */
> +		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> +	}
> +
>  restart:
>  	compaction_retries = 0;
>  	no_progress_loops = 0;
> @@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
>  	 * we always retry
>  	 */
> -	if (gfp_mask & __GFP_NOFAIL) {
> +	if (unlikely(nofail)) {
>  		/*
> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> -		 * of any new users that actually require GFP_NOWAIT
> +		 * Lacking direct_reclaim we can't do anything to reclaim memory,
> +		 * we disregard these unreasonable nofail requests and still
> +		 * return NULL
>  		 */
> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> +		if (!can_direct_reclaim)
>  			goto fail;
>  
> -		/*
> -		 * PF_MEMALLOC request from this context is rather bizarre
> -		 * because we cannot reclaim anything and only can loop waiting
> -		 * for somebody to do a work for us
> -		 */
> -		WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
> -
> -		/*
> -		 * non failing costly orders are a hard requirement which we
> -		 * are not prepared for much so let's warn about these users
> -		 * so that we can identify them and convert them to something
> -		 * else.
> -		 */
> -		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
> -
>  		/*
>  		 * Help non-failing allocations by giving some access to memory
>  		 * reserves normally used for high priority non-blocking
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
