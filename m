Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994E1A3BDE
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410157; cv=none; b=IzH5tIn9vrXfzIYNI58c2vZ0Ltn9lQ/0f85jOsMKBtzceTUaUZziPN/hg57ZAp1nCflPi7KW/L9UeRXUcmTONCBcamFzGgcH5WvsrTcV3Z3aw+3iN8lFC5cunudha7JGFYrU4RDo86yaFNrVgSrMHIeWOad6FGUge1JVmTzTHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410157; c=relaxed/simple;
	bh=ae5PtW070xmXiO1Gi6zB92NIh3x5lIVI9usJV/u7axI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLo61C8hr862qVKBCv/03bEZIPBYTj/mvr9Gz4igpyT26NTwmvv0GPxWOy/AOfMpGfEFBC3KQoJFNq2GCVpC6qnqMpkgZ8Itamtzcx7pbO8QsxFzq2BacX5o0t+Km6JeqL12PUi82JwMxRmF3hKfSXP0eqkJL7/usYRHKumH9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gQuJSWCU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gQuJSWCU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso34784765e9.0
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722410154; x=1723014954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zudpktKJf5WXnSTtb9WADDZ8shOgAvseh08NAfB+ers=;
        b=gQuJSWCUwikVqrrEM0EWLd9b5Ye1bPKn+CTwkFA9vTSuUS4eEURqqXg9qt2TkEvyth
         hXcLRWuIGwsWf/t7dlWDEUEQdRTzERRMmXv0TPrPGyl9zEHz7OKcGAfQWkzTf5vbswVg
         K6XsxhvySJsvycKw1yZ5fFCjQ785MROS8AVSM7fu24tnPmUfkSXZgBozRxhubmKRQnVb
         yHUyjQoeTQM6Fc1+ZNYBEIOQGVkmTK6+25MS3sXXmfG3eRApG6UvY5hTRXgRo3hDFV/h
         kJjFkQH3NKj2JPZFSDCKKDGWEBmA+f/L2XDLDpATJtbKeX1G3OxLkEPDc11FJnTTsbl/
         b6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410154; x=1723014954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zudpktKJf5WXnSTtb9WADDZ8shOgAvseh08NAfB+ers=;
        b=u1gO8KmCSVwFfd6+awXJtIxBu/j1FFHVlu5gHfBO/Rxwn0RpViGxtppKigg8aYOjRY
         2d5Ohm4Xs1zmTHKl1OGbf41GZJ0O4bP+Yuvnll0kWOgYhiKxbGJGTigKuqzomdUumm6x
         bdDwWcj6Ju26im8OjrS+DBjAnSD2fHLKGqe9+n2hrbb5MCXnSIbEBS7bQ4A5gbyCn4UX
         jHYc530f0/CME+vAAjsR54PYocU7LtRd+gqRE/j1imbGeBge+HFrrLepuEEopQmIqWBg
         IkY0C+5LYo22Br0OzCjmNE6RS2OAtSTaLndVlcKVMfLsI+60ziNVarTJpeyShX2Y4YBK
         hwBA==
X-Forwarded-Encrypted: i=1; AJvYcCXW1bLDXlkBDRlP5zXWVy6tPjiex4prurGyuX7MjXCjMCkellLbbT8u7v8G/C/Sn149xm+MtmfL/6p82ucsVs/6VmkRFeQMdixGlMXMxq4=
X-Gm-Message-State: AOJu0YyWJuWnI8iz13zGgG3Zu5OShKyWW/K4KQLc22w1AvCpO8jI9Q7N
	rmQQltFQZEd3C3+SdCcd91HTYCdyv3s76U9N6Bz1KmPG4XvE5T4vPAHlh69L5UM=
X-Google-Smtp-Source: AGHT+IH3SbxOfbCbqfY0UXbai4Q1ROAP4tq/7Y8V9LwUiEQO8fwPL9b5eKCsaKjcznBGEhNvY2lVTA==
X-Received: by 2002:a05:600c:190f:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42811d89fb4mr88528815e9.16.1722410153577;
        Wed, 31 Jul 2024 00:15:53 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0889sm16319146f8f.22.2024.07.31.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:15:53 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:15:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable  __GFP_NOFAIL
Message-ID: <ZqnkqFjS2zeHCc5X@tiehlicka>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-5-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731000155.109583-5-21cnbao@gmail.com>

On Wed 31-07-24 12:01:55, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When users allocate memory with the __GFP_NOFAIL flag, they might
> incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc. This kind
> of non-blockable __GFP_NOFAIL is not supported and is pointless. If
> we attempt and still fail to allocate memory for these users, we have
> two choices:
> 
>     1. We could busy-loop and hope that some other direct reclamation or
>     kswapd rescues the current process. However, this is unreliable
>     and could ultimately lead to hard or soft lockups, which might not
>     be well supported by some architectures.
> 
>     2. We could use BUG_ON to trigger a reliable system crash, avoiding
>     exposing NULL dereference.
> 
> This patch chooses the second option because the first is unreliable. Even
> if the process incorrectly using __GFP_NOFAIL is sometimes rescued, the
> long latency might be unacceptable, especially considering that misusing
> GFP_ATOMIC and __GFP_NOFAIL is likely to occur in atomic contexts with
> strict timing requirements.

Well, any latency arguments are out of table with BUG_ON crashing the
system. So this is not about reliability but rather making those
incorrect uses more obvious.

With your GFP_NOFAIL follow up this should be simply impossible to
trigger though. I am still not sure which of the bad solutions is more
appropriate so I am not giving this an ack. Either of them is better
than allow to fail though.

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/page_alloc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cc179c3e68df..ed1bd8f595bd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4439,11 +4439,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 */
>  	if (gfp_mask & __GFP_NOFAIL) {
>  		/*
> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> -		 * of any new users that actually require GFP_NOWAIT
> +		 * All existing users of the __GFP_NOFAIL are blockable
> +		 * otherwise we introduce a busy loop with inside the page
> +		 * allocator from non-sleepable contexts
>  		 */
> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> -			goto fail;
> +		BUG_ON(!can_direct_reclaim);
>  
>  		/*
>  		 * PF_MEMALLOC request from this context is rather bizarre
> @@ -4474,7 +4474,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		cond_resched();
>  		goto retry;
>  	}
> -fail:
> +
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
