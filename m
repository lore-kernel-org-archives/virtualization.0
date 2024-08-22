Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B71547C2
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318693; cv=none; b=rbRt7qOw5mqtFFyxudpFYFXsgx2vq1ifETD/YUjEnRCMidxXsyNZRpxkQZ39h+C8d6ytomR2cW/6AkAA9kiq6pUCD1zDFD6WLFairT/rmmsrq7V2PmHftFNkZ0NMWhdDYxPsruN/zae4m2K0pmx7R7j+yDioGqNqhd7Z1ZDYP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318693; c=relaxed/simple;
	bh=ummsXGukwWBkfFU/AVdFqKiH42TpRwXBHKq08XATySY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUCE/MdCWH87D/jCDqki2qVNFw6cYuRUEVa/fRkblLbHJbZCLB9RBV/aGH3o15+DexfJ56vJnUBs17oPEKaPBJmJJbfDelomvFmcBjZ5zC+iXzC217N9QUh33VMEwzqN2k5WRbggh3y2hVQqc/s67NB6Av3/jKmqjB1+zy3E6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hGYaCB72; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hGYaCB72"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso70941166b.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724318690; x=1724923490; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=526Ab/yRd/9DVE03lo/GCJKyCB+VQhiWKCsYcqBZPe4=;
        b=hGYaCB72LJXXTHK6f2njYH4arl0KUGKcXkX5idwwmZ2TDdeFIhnWYS5CQdDE+xZ/Gy
         ru7DNq6l3NZ1zXbpU4uDY8qePJ2/3rHiwtyQ2sCBGjA4aARf8FXdyDczQWP8ophlTv9j
         O/eCOd9486lB1AwU5uwWNG5afszJ/0llmr+EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318690; x=1724923490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=526Ab/yRd/9DVE03lo/GCJKyCB+VQhiWKCsYcqBZPe4=;
        b=UH3NlOO6w473gxFmYlyhmP9fCPcV8SjMCCvMSdcVrB7qaUyou47bG6hmvcQX8KPKho
         ZCJYowU85htrY7zwtu7YSq/VGwnnD2tTjyHMHVhGaJF9NKuI9QtufHMk+A67Yxb4ZBac
         zqST8PmZr1k52QaWDbL0DKY/FMo6VBYNn4ocgc2/5VOZ7F4A/jCOE9YcVQ0XldHD+P0k
         /x9/dHDIRdyVaMcwDKWoY/EvEk2eo3NBYbr0aHHG8nw3GJ6SCQKMLNIxnyfR/azYuYCI
         QK8qygDCVylol1brYh+8K5K1HobNQ1nz3MQr6RhSce0b99B9lMM6mTRzWIXYiv9cLdzD
         ZJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUSMn4v0B909ekRXiJrlk2h4rHhaH0TytMdB58gcHeG435pc2wvbfVQmsFjr3Rz4CgKs/vNyNdU7wzIxnSPzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4j9h8sllaCdDRPagQP2svkR0UJJD8G1ZUXLmm69hdVawk3FRn
	IQfd8N4cKFF9P6e1q3cmEFzuWGEh0XlEe6ub6UN6Piw0j+W4t/HMoxrG8OgbdLNazHQa7s58yuy
	T//PZSQ==
X-Google-Smtp-Source: AGHT+IHEBEWMwB3AgEU4Y5c0NsCjKc2VRyDQW8DGs5VM3o1lERQyPyi1Uj+hjSbepUs6AQDX9G2BfA==
X-Received: by 2002:a17:906:c152:b0:a7a:8da1:eb00 with SMTP id a640c23a62f3a-a866f1479b8mr366108166b.7.1724318689506;
        Thu, 22 Aug 2024 02:24:49 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f486265sm90690966b.161.2024.08.22.02.24.47
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:24:47 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bec7ee6f44so893839a12.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:24:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUw9nPtfFdrHci75apyBbrKLl1S6pwTpHTW5ab1jA06NJi7vqXywZxtO3pfjp54D/iH/AGlGyTDZ72WqFNJ0w==@lists.linux.dev
X-Received: by 2002:a05:6402:3487:b0:5be:de37:80dc with SMTP id
 4fb4d7f45d1cf-5bf1f288a7amr2922233a12.37.1724318687086; Thu, 22 Aug 2024
 02:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka> <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka> <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <CAHk-=wjTTAKRgVD=StNbV1FtPz+a1DHYBbrJuP=kmd_vm8ssFg@mail.gmail.com> <ZscB9xynFs4imkl4@tiehlicka>
In-Reply-To: <ZscB9xynFs4imkl4@tiehlicka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 17:24:30 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgsibi_rsfMtKuLfDgDfjWUU8VAQNBZEVzr1St7tD4crA@mail.gmail.com>
Message-ID: <CAHk-=wgsibi_rsfMtKuLfDgDfjWUU8VAQNBZEVzr1St7tD4crA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:16, Michal Hocko <mhocko@suse.com> wrote:
>
> GFP_USER allocation only impluy __GFP_HARDWALL and that only makes
> difference for cpusets. It doesn't make difference in most cases though.

That's what it does today.

We used to have a very clear notion of "how hard to try". It was
"LOW", "MED" and "HIGH".

And GFP_USER used __GFP_LOW, exactly so that the MM layer knew to not
try very hard.

GFP_ATOMIC used __GFP_HIGH, to say "use the reserved resources".

GFP_KERNEL then at one point used __GF_MED, to say "don't dip into the
reserved pool, but retry harder".

But exactly because people did want kernel allocations to basically
always succeed, then GFP_KERNEL ended up using __GFP_HIGH too.

> There is a fundamental difference here. GPF_NOFAIL _guarantees_ that the
> allocation will not fail so callers do not check for the failure because
> they have (presumably) no (practical) way to handle the failure.

And this mindset needs to go away. That's what I've been trying to say.

It absolutely MUST NOT GUARANTEE THAT.

I've seen crap patche that say "BUG_ON() if we cannot guarantee it",
and I'm NACKing those kinds of completely bogus models.

The hard reality needs to be that GFP_NOFAIL is simply IGNORED if
people mis-use it. It absolutely HAS to be a "conditional no-failure".

And it needs to be conditional on both size and things like "I'm
allowed to do reclaim".

Any discussion that starts with "GFP_NOFAIL is a guarantee" needs to *DIE*.

                  Linus
