Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23011A4F0A
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409895; cv=none; b=iqQU1MR+aCQDpoaE/Gf0rPpdNFwfKqGjBJeUJMiOnSMK9pMVleaesuRhhbAE7vMgAbyJ1mJMc6BdT/vuQ/PdEfJgAio9gCifWBD7WnIJgXtki5mZJbuynxrumqSQnkEJHlNt+H3s0fXspZcU8RO+8PRXlrnz8LaxX89Ll2P6HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409895; c=relaxed/simple;
	bh=gPha9d3t5/b/YLKEhUw1B4vw5UksGLetVAI2LfL9wQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP4blpLiFh1DyDW/zZMc5VciW8jzhzxeiCPmzhaFsT9bAOnNyVrmM03C/z31k8fgy3QSMlhHxivZxh62SX75xisW3a1ZW+m3Xy5XMOST27W51dnI2c/LJ6RZUEcCFRo5MXEOxnhGIpvRCMsYY/9fQxlPhHGRijmhTdi/tQkomvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsaM2nki; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsaM2nki"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367940c57ddso2681393f8f.3
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722409892; x=1723014692; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7bCfmlE877BhmRYlIJ409tyg+mr+Mk0Kk/ub9KupKM=;
        b=NsaM2nkikJ9jiUJGLlPFZKw6f26Qk9a8QK9hNeNfh+jQkdmYLkk6X6pqS6/Ufs4q3C
         S/jMaYsrMQpBXch6BJI+6QaWRfqaLfl5IyFvaLvo3UbQkEPvqKgpu6p4eZdyXDZh9qt8
         3TZ8jM6xYn+0ZqfQi7SsxyXbWj98ZkoQ4reyVgvHjxrOOmvHvj1fO3h3yWIrBrEkEA+Z
         CIKvmCj7FR1RuEh854gAT4GG3v3xfpD+tJd0MEsV0Cz5PevWMZ0IhaUiT1pQxg09e2y4
         2ZvDwvDNzafJC3Tt+uQIMozws3f9XbnE069O+EZQLeto0o7uYUtdYKmjyKZRiUPYoVsp
         yP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409892; x=1723014692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7bCfmlE877BhmRYlIJ409tyg+mr+Mk0Kk/ub9KupKM=;
        b=tT3ce602/K9H5ENrSQ0Cx5hivKwzcBQUaWT9Q2WIw5a9iWIWdneruw/vaygaVA5MpU
         spHsSfUdnhASAtrWi8h/i+331mm5Zboz6ikPvBWrarLh7u22BiP4126Z2GUbeixbXHmF
         hAO1vWgZq+pfEAGvgn3va23xwoio9vcDaV0lKLUJyD/c/64/pG8mEL1TeCKBoOE4v8x3
         /D3Jw0ZQvh5F6nRgWjrr96VGMJ8fiS4YKA8RyuL5V1311DuT9fYY4NZBNd/frOOCeoU1
         +52mftH8g8Y7/xRbgDcYG0vsQr/MZPPyiN2PjzRgg8+Q+O70AKzjcD7rxVAS+p6JdUmP
         8QgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+yygkDQdHJyy6eI5mukd70x4rRLu94Gqb7kxs0tkWJ0CkyT9xbGIF9Du06foUcQHmKU3DyL7iMOLqkVRE5DFipwMh6OHsIGOev4aWKnY=
X-Gm-Message-State: AOJu0Ywp3JrhlJOB62rp8h1SGP9yY9W8iwOSMEyv/NdcFveJSy+md4FN
	fBtTht9DwFGGwaQ8YvSgyEAs5iqF6z/HY8eg+O4N4LtwOdioqm6i4lrLEWieFNg=
X-Google-Smtp-Source: AGHT+IFPHmzgv0qlkyM4TUCyPsg31JI0gzU3+iiXja8QaEmxeboDo2tgkRQ+Sk8hCi2NE9a/jiP2yg==
X-Received: by 2002:adf:e90b:0:b0:360:7812:6abc with SMTP id ffacd0b85a97d-36b5d0cc62cmr8730220f8f.60.1722409891631;
        Wed, 31 Jul 2024 00:11:31 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857fd1sm16293815f8f.69.2024.07.31.00.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:11:31 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:11:30 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <ZqnjopK0QngjLLZo@tiehlicka>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731000155.109583-4-21cnbao@gmail.com>

On Wed 31-07-24 12:01:54, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> We have cases we still fail though callers might have __GFP_NOFAIL.
> Since they don't check the return, we are exposed to the security
> risks for NULL deference.
> 
> Though BUG_ON() is not encouraged by Linus, this is an unrecoverable
> situation.
> 
> Christoph Hellwig:
> The whole freaking point of __GFP_NOFAIL is that callers don't handle
> allocation failures.  So in fact a straight BUG is the right thing
> here.
> 
> Vlastimil Babka:
> It's just not a recoverable situation (WARN_ON is for recoverable
> situations). The caller cannot handle allocation failure and at the same
> time asked for an impossible allocation. BUG_ON() is a guaranteed oops
> with stracktrace etc. We don't need to hope for the later NULL pointer
> dereference (which might if really unlucky happen from a different
> context where it's no longer obvious what lead to the allocation failing).
> 
> Michal Hocko:
> Linus tends to be against adding new BUG() calls unless the failure is
> absolutely unrecoverable (e.g. corrupted data structures etc.). I am
> not sure how he would look at simply incorrect memory allocator usage to
> blow up the kernel. Now the argument could be made that those failures
> could cause subtle memory corruptions or even be exploitable which might
> be a sufficient reason to stop them early.
> 
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

Thanks for separating overflow/out of bounds checks.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/slab.h | 4 +++-
>  mm/page_alloc.c      | 4 +++-
>  mm/util.c            | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index c9cb42203183..4a4d1fdc2afe 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -827,8 +827,10 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
>  {
>  	size_t bytes;
>  
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +	if (unlikely(check_mul_overflow(n, size, &bytes))) {
> +		BUG_ON(flags & __GFP_NOFAIL);
>  		return NULL;
> +	}
>  
>  	return kvmalloc_node_noprof(bytes, flags, node);
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c700d2598a26..cc179c3e68df 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4708,8 +4708,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>  	 * There are several places where we assume that the order value is sane
>  	 * so bail out early if the request is out of bound.
>  	 */
> -	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> +	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
> +		BUG_ON(gfp & __GFP_NOFAIL);
>  		return NULL;
> +	}
>  
>  	gfp &= gfp_allowed_mask;
>  	/*
> diff --git a/mm/util.c b/mm/util.c
> index 0ff5898cc6de..bad3258523b6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -667,6 +667,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
>  
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
> +		BUG_ON(flags & __GFP_NOFAIL);
>  		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>  		return NULL;
>  	}
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
