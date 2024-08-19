Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8514AD02
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087575; cv=none; b=PnuNq27o46Kre0JGB3ym0cRBg9+Lgvjwlv7fyUGMpM3JhKV1stAwWuTspt6LLOJyZmvcNxFxw7go2daJnDEirFJja8CpoeUBfE2EjDH021k2JsozWjFM2ML7XQXs6sk5KqudjVgp4bMGnvqCf46hPZKQih4hLdUhl1i/JYdNdlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087575; c=relaxed/simple;
	bh=opL2GzK3ufH486x/uAH8uXJejXo0LPJOf5K/TaBEkf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ixn79v0eQBpCyX7AeQqQcEaBOHJ27cJ6n5JS4bCCdqHRfBhBujfERVyYzBcawJ2X1xyU12GEZNBEh+lbqlwaHN74f3x9dyAhQMaBLAZnJ60ZaNKdClCl5vsiuZ6SI0XbrjHXv1L8DyMQLf2b8eXhYHHSlnafOy4PXSBPLpwlF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DgsSQd+r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DgsSQd+r"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so5960165e87.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724087571; x=1724692371; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AN5zhCn+htt3noRzaKCJLW9ql26hNTmL7gyUWJWJMns=;
        b=DgsSQd+rmcjxoOJYOBBdxngDWKdADrsCdrxT2HltuKTfJvQHmZ8GB0GrKxonExySZH
         tN6XsXA6mg2SpCfchHxAbpF4mOa13vqRHDnOyEJGm2XuDpG/lL13GmTxyV01StrXmnnc
         ulTTz6iIyzr2tduH3dJDxiMv92OHaD/7lZvlIh/VZYzyTRmA0tjGeSN1E9EGMgcqqC35
         4H8Ckn20ag1JKvF38OtgRO3Eh3S5GTPDVcmu6qiRAvdbKodL8VGKFBRzo+NZTrNdYjMh
         VIU/LmuK7ymwlEKOVvMIHbuq7FAmoPIetzC/yMfnuvN42xe/c7oUWS2yQwnc8GJENNx6
         H3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087571; x=1724692371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN5zhCn+htt3noRzaKCJLW9ql26hNTmL7gyUWJWJMns=;
        b=spaxeMYxLClJb9pcs4D13+dHDwyEtXVd0uXmaUUDoBhyCe5g/lmQOyoCRzllaXcpkI
         YfY90zKwgwZE6eBlmT8/dHTko+G/E4lZ7qccOXn1T1BgxxZEX7zAPO/JrRl64WKqcxiq
         UOz8Ew8boxMRjOw9nN8wYTJbk2vZgEjyqOgFEEV93IfmV8Du06EfvIj3oGXYjGaebQfN
         uTzlohJveq11Ja+F1D1ECzSlq0Y4RYRyV7j1mcludgBj1y/Uw/RYzeXltD5ynAlHVA3B
         jdCNUP+qqWkISamTFOxJcee9N2cYayhafFd+iNscLOLgwVFCHvfIFf/frB7zl5sLSLjy
         NTvA==
X-Forwarded-Encrypted: i=1; AJvYcCXhBow6i06fdl2Tm7eb9yXIrIM5UMPD3/vuPq/w9250inUEdjylQQg43w0dzgqoI7df7Y9T+ynOmSiKxgtYwqd/yQaUtLOFmlYuWHZQFf4=
X-Gm-Message-State: AOJu0YwyMwHwQx2G6sV2Xk2JoaXf+OT7KSYCHBA++Vg8pvAbcxKsiRRR
	55KCx2nCcwLx4D3AUy1HJllGwGJllqgFbfXrhNC9jFy75YuFyCWST6MKMHgnPr4=
X-Google-Smtp-Source: AGHT+IG2U2zQoNGTqC2ysJvFQAGTwJhpWlG5Siw96cD6hn+S1RR1nspkMAdoDrgkzNNMOIQ0bz4RaQ==
X-Received: by 2002:a05:6512:33d6:b0:52f:ca2b:1d33 with SMTP id 2adb3069b0e04-5332df41e54mr4774582e87.20.1724087571066;
        Mon, 19 Aug 2024 10:12:51 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394723asm665069066b.171.2024.08.19.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:12:50 -0700 (PDT)
Date: Mon, 19 Aug 2024 19:12:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <ZsN9Eo8HWdEgqpf3@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-4-21cnbao@gmail.com>
 <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com>
 <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com>
 <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com>
 <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com>
 <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
 <CAGsJ_4zWNgA1OZJ-iAa4KhDY9TuGb2vji4=FJ=Vn7ve5uF6XzQ@mail.gmail.com>
 <5424dfa3-03db-4a82-a08e-fb31285774b3@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5424dfa3-03db-4a82-a08e-fb31285774b3@redhat.com>

On Mon 19-08-24 14:49:55, David Hildenbrand wrote:
> On 19.08.24 14:48, Barry Song wrote:
[...]
> > > > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > > > index 60742d057b05..d2c37f8f8d09 100644
> > > > > > > > --- a/mm/page_alloc.c
> > > > > > > > +++ b/mm/page_alloc.c
> > > > > > > > @@ -4668,8 +4668,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
> > > > > > > >           * There are several places where we assume that the order value is sane
> > > > > > > >           * so bail out early if the request is out of bound.
> > > > > > > >           */
> > > > > > > > -     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> > > > > > > > +     if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)) {
> > > > > > > > +             BUG_ON(gfp & __GFP_NOFAIL);
> > > > > > > >                  return NULL;
> > > > > > > > +     }
[...]
> > Returning NULL doesn't necessarily crash the caller's process, p->field,
> > *(p + offset) deference could be used by hackers to exploit the system.
> 
> See my other reply to Michal: why do we even allow to specify them
> separately and not simply let one enforce the other?

Are you replying to this patch? This is not about a combination of
flags. This is about the above (and other similar) boundary checks which
return NULL if the size is deemed incorrect. I think those are potential
problems because it could be a lack of input check which could be turned
into a potentially malicious code. Because unchecked (return value
because NOFAIL never fails, right?) return value might even not OOPs and
become a silent read/write into memory.

Whether to BUG_ON or simply loop for ever in the allocator if somebody
requests non-sleeping NOFAIL allocation is a different story.
-- 
Michal Hocko
SUSE Labs
