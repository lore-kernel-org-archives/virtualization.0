Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85316156871
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823154; cv=none; b=CyOrABDAd5esYw27wEpvVjtExpTNpFn1eVmv7VUXlHyZSd3BkLu2zGHpQXYZ6E31mSi5QC37KnHzbkAbrFKLhUR2aqYBjABsB+cfXbYP3liF0kOGietPNZYtmOPfdiOfPe2Jkos9vEL+5RSbJJwEyTiFguMWQWqlykNUg1SRMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823154; c=relaxed/simple;
	bh=8d23P+WpUlVVpByMUCawBsaK7f+BG7TCooMSC1ojpoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3vcNbwAXvWgO/VGX73ZVDwHp7ricExsZ6/au09s/JCmvW+IQRE0IbOOtkILY1s0E/exK2pWm/fLCKOw5bZmDCwjWFAxGTq9EpRnjPa8PVGXQ4zwfTq8qyohRKcDfpNjqESUFgY/9KBAXudIehwKes9ivsn95dKDf7LWs71WO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uo/Gje2d; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uo/Gje2d"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a9a369055so175319066b.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721823151; x=1722427951; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghJe96YJfLJ4KqIEOf8cCUZC/HL1XAAC6O7pos/y8DE=;
        b=Uo/Gje2d8I8nG22eVhttdS05Kt+yroDh4ZX4anYFozkfu7FD44WI4h8awp+nXBpozo
         NKE8WsgAKIVnQLsPbuk44d/i8rscSwkLGVt8QYHZ3xjEAJS1aHuTubIQ9kBS00oQt/Ek
         T+5Q2TpMfGz+c6H77JjlBpBZ5nIVomJzxBpdCtHfLWvwfYSxzIgKk0w0HvczY9KulYHR
         8kr/AvxamwQonbsvM4XIJpIKmYsLESDuwj4pwIXp2wqTs1JgChL7SPfT3wP/+s5Synch
         Rt9+DqxFDcqik3Jvcfg34WsBnbHLDmw5HROlSxHLW1jaf3GrnzJV0KdnJj9SJRU5G/Nb
         rQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823151; x=1722427951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghJe96YJfLJ4KqIEOf8cCUZC/HL1XAAC6O7pos/y8DE=;
        b=kHIMygf40AKqpxc27zyKnz+AEG5IbeRmLF76FrZWoroFwtLfQr/9o1zrGznxVc8lkk
         HIpQmNP0wMv9+Jlrihy4HOLWe9vhbc6A0eEcLOLTiWkkz8jUOEntYHbI/8vVsCIHrt8q
         4bmEo9ZQS/wgrm3lGd91ZZLpmIaxZr9aifWxAPbs/ZrUkyem0qbPHz9je6j4gIZVXGpf
         qSqtEorTcmGJCoUrAB8JitKeqXh2X+Nzt+uA3ad4XC6MKNDHM8rtiJOzarAIFB0c+6sS
         I2sAnSmW3WSoZM7YyEK4F29X1yUbesSjd6FgxlTw66SpUM6y09iotR7X1xLBd3CaUoAO
         Epdg==
X-Forwarded-Encrypted: i=1; AJvYcCXfthGINwAghW60eOn/35uJtypiOCWOhZ198CGOAMaiGEdhB279g11R55qitM5PLuDe46Rh1FgLOKD1rUwYqeCwo9QPJ9KKZ6p+o+ZxnQM=
X-Gm-Message-State: AOJu0Yz1ej8GdQ8YkyJ3sSPrT1FTtN6xipgnXLQgNIPdiyhdCUMVqFg1
	wvu3KtZso7K2XNi75LjwH70Rlvh2wf278e9ihQq/ezSghzve8JO29nTstmf/B58=
X-Google-Smtp-Source: AGHT+IErPb2sPBolZaki/APF7JGOMN7AOYwHQhoOiHJyA96Ir8YFs9PrTcbMZwJFV0d8bqL+SzDXgg==
X-Received: by 2002:a17:907:7f24:b0:a7a:ab1a:2d64 with SMTP id a640c23a62f3a-a7ab10ef64amr138491766b.58.1721823149822;
        Wed, 24 Jul 2024 05:12:29 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a4e7a13b5sm544627766b.47.2024.07.24.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:12:29 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:12:28 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 4/5] mm: Introduce GFP_NOFAIL with the inclusion of
 __GFP_RECLAIM
Message-ID: <ZqDvrN73W6F89O6K@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-5-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724085544.299090-5-21cnbao@gmail.com>

On Wed 24-07-24 20:55:43, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Introducing GFP_NOFAIL and gradually increasing enforcement to prevent
> direct use of __GFP_NOFAIL which might be misused within non-sleepable
> contexts with GFP_ATOMIC and GFP_NOWAIT.

I do not think this makes sense without removing __GFP_NOFAIL and
changing existing users because a new flag will very likely not be used
and therefore it will not achieve the ultimate goal to remove a
potential abuse.

> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/gfp_types.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 0dad2c7914be..1666db74f25c 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -339,6 +339,10 @@ enum {
>   * recurse into the FS layer with a short explanation why. All allocation
>   * requests will inherit GFP_NOFS implicitly.
>   *
> + * %GFP_NOFAIL employs direct memory reclaim and continuously retries until
> + * successful memory allocation. It should never be used in contexts where
> + * sleeping is not allowed.
> + *
>   * %GFP_USER is for userspace allocations that also need to be directly
>   * accessibly by the kernel or hardware. It is typically used by hardware
>   * for buffers that are mapped to userspace (e.g. graphics) that hardware
> @@ -378,6 +382,7 @@ enum {
>  #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
>  #define GFP_NOIO	(__GFP_RECLAIM)
>  #define GFP_NOFS	(__GFP_RECLAIM | __GFP_IO)
> +#define GFP_NOFAIL	(__GFP_RECLAIM | __GFP_NOFAIL)
>  #define GFP_USER	(__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
>  #define GFP_DMA		__GFP_DMA
>  #define GFP_DMA32	__GFP_DMA32
> -- 
> 2.34.1

-- 
Michal Hocko
SUSE Labs
