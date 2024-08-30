Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F0155A32
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002692; cv=none; b=Lab/Gh721KFjcGzjNGr+mpCVJABqCpdonYekdbR5OyNFbPvGiCVs1rTWuWJOqTQ1FEln4hukSbLfLcmQLmMvKfpfptk6fjCU9jNSIJJzpS6K6Db8BNcyVgk3mG0W/SJyTMR3uwB/aGEKxWDWITsBPQkwzzmNbGty1YxrNDJ8dWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002692; c=relaxed/simple;
	bh=tWyjjYxHBns2cctAaoyvYs8zJycR53/wZQdhmHSBxGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnXnmcXKxsBldSEgsCLrhv0NVDklUshsPB2TY3ky+BTCItwN3fNbea3zu5ejdi3LzrGvTC3oN+ly8+Vs40qT7ZeLMhrEyr1wFOuYfTk+Ktk6vDzVOOkruHlox3HwlpbbPa9iUOTLPKi3Wo5zDmQIsEFJEWLVOfjN/YpsVyJuOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GmXuSrgG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GmXuSrgG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so1041135e9.3
        for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725002687; x=1725607487; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecl9V3mHP2TroPJgyQO8RmF2Y8C5vbk13wxZrIkGuAw=;
        b=GmXuSrgG7OMhqB7ls5i8amcvAmY2tIz7pTiOdpvvFPdnl1fbe8EGDLKAlsNW+fMiPx
         SSIqPmIS2djvUD0rjfJlgbcfFU5ELlozRgbeX9na5bZg3/Qk6TT4btYltSbMwtXN92/c
         EcLwjQkvBip2yDRXQjwoYaGOmjbu7z2i9yH7urdFgSV5OdgBRalmeFOkpA9+dkNhXqZO
         ot721U/F3VvSwZzpdlWQku/Mj1DRRdDAN2c9J6KeuspHdEpnAFvYofQVv/a/Lw2AiFhe
         uo53MR1EyAk7UQ8KjKCUAAgxVa/QLMkkOfGFKk6TAmlYYpVNejAZ+j/LiX4+/7PInCmd
         LQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002687; x=1725607487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecl9V3mHP2TroPJgyQO8RmF2Y8C5vbk13wxZrIkGuAw=;
        b=tUNyjoo/ec/DwYrszgdGeIgXNGYXCf24zgOy23cUqnVyT5AmADFxFZmd+YunvsW1g5
         O08ff55e01uf8+k2AkyOlWOFf+oWmCblwdgP/c2jqvkJd5jMSzwHzCW1tqYocSGeidLa
         XNOVJ2c0fQp/QD5hHA7LMQYWWmfbweLMRpNssg9j5q7NfuP/qUKdpqdWg49xDxf77LAY
         OGcqxjEabMGEPaTirxH97GbSFsRb8mS4E6P/j6F0VXHaKUWWnhm1HPbd2+HJW33ReE7M
         86swV+qTFKJqMmt/A9VU34Mr/h6XTtPX/pUHBxvpV6NRwYGHrzqUCq2JSyvm9JPvTWZs
         RNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyd3pvhPei8izQJIt9J7VYJ9VtJuU0itwZCuAA3rLvFRgpRJ3dWsVgDDDTtN20yb0W3897NeTkP3v28KO//A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTAp8lCYHTy9rFv2WrMeHso0f/BH3j1OkD/4LLySGb0/qjgeIf
	diP1/xgJRdrTPqPq5WTKkAqaErDQ6K65dutN3gk0TIoDHwvDHSXushq7lg2s2jI=
X-Google-Smtp-Source: AGHT+IGd+v4gw5NFrcdO2V0+lNAzqgrBBOAwStEmLuvRWpuojLyJlgncKQDgdAUlXD0sjILmrgTK8w==
X-Received: by 2002:a05:600c:4693:b0:426:63b4:73b0 with SMTP id 5b1f17b1804b1-42bb01fd12dmr45492325e9.34.1725002687187;
        Fri, 30 Aug 2024 00:24:47 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb3efsm37586855e9.6.2024.08.30.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:24:46 -0700 (PDT)
Date: Fri, 30 Aug 2024 09:24:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: vbabka@suse.cz, 42.hyeyoo@gmail.com, akpm@linux-foundation.org,
	cl@linux.com, david@redhat.com, hailong.liu@oppo.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, laoar.shao@gmail.com,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZtFzvU1wiBSlhzzY@tiehlicka>
References: <CAGsJ_4wZiE08XDjNAPENwH=KQEzdm2FB_bMDi0b7PJx+e7ydrA@mail.gmail.com>
 <20240829223114.1102-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829223114.1102-1-21cnbao@gmail.com>

On Fri 30-08-24 10:31:14, Barry Song wrote:
> > > > Patch 4/4: We will move the order > 1 check from the current fast path
> > > > to the slow path and extend
> > > >                  the check of gfp_direct_reclaim flag also in the slow path.
> > >
> > > OK, let's have that go in now as well.
> 
> Hi Michal and Vlastimil,
> Could you please review the changes below before I send v4 for patch 4/4?
> 
> 1. We should consolidate all warnings in one place. Currently, the order > 1 warning is
> in the hotpath, while others are in less likely scenarios. Moving all warnings to the
> slowpath will reduce the overhead for order > 1 and increase the visibility of other
> warnings.
> 
> 2. We currently have two warnings for order: one for order > 1 in the hotpath and another
> for order > costly_order in the laziest path. I suggest standardizing on order > 1 since
> it’s been in use for a long time.
> 
> 3.I don't think we need to check for __GFP_NOWARN in this case. __GFP_NOWARN is
> meant to suppress allocation failure reports, but here we're dealing with bug detection, not
> allocation failures.
> So I'd rather use WARN_ON_ONCE than WARN_ON_ONCE_GFP.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c81ee5662cc7..0d3dd679d0ab 100644
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
> @@ -4174,6 +4168,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  						struct alloc_context *ac)
>  {
>  	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
> +	bool nofail = gfp_mask & __GFP_DIRECT_RECLAIM;
>  	bool can_compact = gfp_compaction_allowed(gfp_mask);
>  	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
>  	struct page *page = NULL;
> @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	unsigned int zonelist_iter_cookie;
>  	int reserve_flags;
>  
> +	if (nofail) {
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

Yes, this makes sense. Any reason you have not put that int the nofail
branch below?

> +
>  restart:
>  	compaction_retries = 0;
>  	no_progress_loops = 0;
> @@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
>  	 * we always retry
>  	 */
> -	if (gfp_mask & __GFP_NOFAIL) {
> +	if (nofail) {
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
> 
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
> 
> Thanks
> Barry

-- 
Michal Hocko
SUSE Labs
