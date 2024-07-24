Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEB156886
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823035; cv=none; b=IfXpRWeRyYTXSic8Gawg13+LnP0rGuxNKSvZ3Ty/2pPWAPpMQBHMBTiEIW7dMn454dAVTWMzj6KlP+TWhNaBp+EupiLiBCd1xwovCnp4QNF+PL2d722ynXNldTOIrwhWxMt77L22gXJZFmJFZ52e9Kn9h+uSlfsXxBhhLKD2riI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823035; c=relaxed/simple;
	bh=SXd12xPDjqOKUQ/q+y7n++lmeRZ7j1SjDqRav9BMJSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYrDLtPEkYsN9xTxoeNC7uxoVKIJxR5pQ8q+dqAGyi6g+8MSPzQP5NVQxV6Atp8J6j3V8PUSl9htvy8ZI8quFIgq0mIcX6vBM0SJjBx6QcJ4ksp3brzgoVNtAf8EJyWCAcXqCV6WBq4UwOK+yb6PoUk1CiPR6l3pY+y/X18MP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hGdQ4m8I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hGdQ4m8I"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so205935466b.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721823030; x=1722427830; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmjzYU2EWBaeA6HHqDKF1v64IPSOiylq5fYsLCB9w2k=;
        b=hGdQ4m8IEAtHo3E8JZ8su+z9e9UN4bPhudtTip8KfTPUSiH2c8DFPsXsVk/iu+OzVf
         9VVTI0LM7PQbG+n0g/iKAI5QB9auA9r0QBdOHihMmcYtX8iC/5FvAysYwSygVP9V77Dr
         EUq68KdYX1ZcKMl5kFeVza9eQraMBZwE55KJNnANDyjEiXREaiZdpARVFnt6Mux6jWwb
         5VUYqgblYuY2SEf8ybEX1eQtZHL27+gwBcOwIoeDQwo5WJAE/9xq41EX31V1FqKu4TvA
         o5CXX6KsjXRC+JZBsKblMC7qOvJe1SXItfVu8hqzXAGS+LYeBDbAR8O2zw9H6JyYBM5m
         2Azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823030; x=1722427830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmjzYU2EWBaeA6HHqDKF1v64IPSOiylq5fYsLCB9w2k=;
        b=n/BcmL++2OHDY2ilv+AAaDt4ARiqm7E828mwqfT3OqVy5pqPlBh5hTn9cUMJ9KNOmP
         rYv8y6we134JWoKcjfRI8mMNU4kfiV1nvY0TSuzmq0QdP0Om5aLFYFu6oi0jHy6UuCNh
         ZdcJMQqvmL+CxFo0fuRxEQ5NwHI+M8Dz6SacxW00vlwQoeupdYzeQDeeDfRTfG7Jf50u
         wGD0ePFfJmSvRA3nymIQpkSSmlN2//YQ4cco7osmoi5DrJu7MQAt/xKke2BxthlB9c5d
         NfhwTLhZpMqoB5c4MBR5kD8SXo4rmyGqBnbgLNAsaCGiO5m+5aZc6lbdnAx0ObXkkWF8
         zWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3MS9ZsTFFmYKMLPdNTyt+VUUtU9lUpToJXxiqTvMHPwhMZNXirG6vv8DE6EYZpFthB/lKIIShgEZDOnaqjONDeHJq20ukqGtCPyTgFlE=
X-Gm-Message-State: AOJu0YyZsyigeYJ5PNrSLgCdlIJkua5jPDGRoy96CuixweWYAqNy3UJC
	/8juAzvOZhPGiYjqzLv+ESigXXvbJ0Ak27ZVUdUkGX3E8udFfdl/LgCFPgvMHyw=
X-Google-Smtp-Source: AGHT+IGzjeQyB8/dl1lPzvBVM7XthAbOmjwuVzyXWnY8xsK8r3+hn2IIGBuBNGkNEQhpk7RXNQ9QSg==
X-Received: by 2002:a17:907:2d29:b0:a7a:a46e:dc39 with SMTP id a640c23a62f3a-a7ab094a9f3mr141553566b.0.1721823030481;
        Wed, 24 Jul 2024 05:10:30 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8bebe5sm632739266b.119.2024.07.24.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:10:30 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:10:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 3/5] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <ZqDvNZkF93yAm6MJ@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724085544.299090-4-21cnbao@gmail.com>

On Wed 24-07-24 20:55:42, Barry Song wrote:
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

I think it is worth adding that size checks are not really actionable
because they either cause unexpected failure or BUG_ON. It is not too
much of a stretch to expect some of the user triggerable codepaths could
hit this - e.g. when input is not checked properly. Silent failure is
then a potential security risk.

The page allocator, on the other hand, can chose to keep retrying even
if that means that there is not reclaim going on and essentially cause a
busy loop in the kernel space. That would eventually cause soft/hard
lockup detector to fire (if an architecture offers a reliable one).
So essentially there is choice between two bad solutions and you have
chosen one that reliably bugs on rather than rely on something external
to intervene. The reasoning for that should be mentioned in the
changelog.

[...]
> diff --git a/mm/util.c b/mm/util.c
> index 0ff5898cc6de..a1be50c243f1 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -668,6 +668,7 @@ void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
>  		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> +		BUG_ON(flags & __GFP_NOFAIL);

I guess you want to switch the ordering. WARNING on top of BUG on seems
rather pointless IMHO.

>  		return NULL;
>  	}
>  
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
