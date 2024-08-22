Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37914EC5E
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318332; cv=none; b=FwiZmjKuN+5ucUWKtLlPCLubIrc3+C5dmdCLl8qb26LXtwHlyJXoSAej8/fpOaQV70XMbZ9ZCBmFooWp5/uGpKgatBJwU37bxTe2jtuwon2PZV7OLImN88/UFxZVQgP9LoOIycHkrSKhvlm1rds8FS5qF6YpEUK3gpcL/7ZtMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318332; c=relaxed/simple;
	bh=oJabG+KKZg717YFICtDvmuQ5XUlgbFamZVXJjDE1hNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibgljqGx8EKNbm+WtdrGfjR/PnT64QHdibJHUTKuzpjKKTxlpsNmrvYuhwEZjmApJL3AxlKd02ySeLhW2LnWoMf99cUZkG32ogcKKBmzbVd+raBS98zAJRta9wjOy5vtx4uYDXJ7YBpoZzzDqirblBAV1GqiyOJ1BL0Kr2K4AxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FPCduD2C; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FPCduD2C"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so900893a12.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724318328; x=1724923128; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nU7/OYYCQK/B/2wvApljuzGowQlcivw9aGVqENCfq/I=;
        b=FPCduD2CiVoD0+j1qzi3vrQHn1D+oV4G3hYhrFW1kplyjdEWQTRJKibJM13CEwEJk+
         CQaKiL/JdrMuk0eI69f9XutxLqoE5Slah/w53a7AoXg4HwL0dw1+4HpjvVz4xof2fBek
         l1bY3n7YNitgeCL6ja9a/zU/VrQINVAjHPjRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318328; x=1724923128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nU7/OYYCQK/B/2wvApljuzGowQlcivw9aGVqENCfq/I=;
        b=tou/tO7w9CFc5uQ26HhpwSRO4dibbTdihsH98w7DyuzwOeh+XZ9UYoqt3PyLtRyoHm
         Bmu3KyNKH9SrwT8HLavpJkovAznz8Pc8Rvwy4zRduofRHULN5WcHPGBhJzEspdu+K5Dc
         lAl9BiEop0LjNZtCoYnDBekh5Yd07G9ZsL67um4V/mvnujBU3CDAYVx/dtjIcD8SFceG
         tuNYGMmmbJ1rBYWcHbIZfypZ9e/oN4hiZCINceDQXb8rmxaH88WSRVuQKaOjH0Y/eIlY
         QG8YkhnfQbefyWBCaHO35vvLYkRlAPueIAP4T8LreZScW6atiToX9xjJsz87MZdyLXnj
         2vOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOGnLd0ZaK4lot0grLipFIcLtK+HMIqnfF4YjJYK5navfRpQOxC8wLMVDA9WZQa0BlxqaC3Wiq1CBULawDqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQYaOhoQZpQuujabkHdgpuxQ1Igt3rpK+NiVk22KQxJ0scX4ID
	xLmg39nctwUwjB1mS1WKXUe+uB/mHzy5+NLs4mGRuri2ocETdj1cXXuDN95KJX2Hw/7ws/u9Wgv
	59nmQAA==
X-Google-Smtp-Source: AGHT+IEZtTFvOQem/IRUU6g7VmQstCDuiYz/tyr08J2puWvH4THAemrx2nh9yEqJ525Ty7sFMDGjBw==
X-Received: by 2002:a17:907:6d17:b0:a86:7bda:d996 with SMTP id a640c23a62f3a-a867bdadbf5mr299580366b.35.1724318328120;
        Thu, 22 Aug 2024 02:18:48 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f507facsm89801266b.225.2024.08.22.02.18.47
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:18:47 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so831415a12.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:18:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNjHfFAxtGEdJRrEg+JxTSUwZzLAR9p9K0zsvTGLMyW4hcO3dmEsBrmRVCPNDPu40IgnV0iL2blDmZmyKprg==@lists.linux.dev
X-Received: by 2002:a05:6402:354c:b0:5be:ccde:c433 with SMTP id
 4fb4d7f45d1cf-5bf1f25e4bdmr3078535a12.34.1724318326990; Thu, 22 Aug 2024
 02:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka> <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka> <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
In-Reply-To: <ZscAtVskxgONe3gT@tiehlicka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 17:18:29 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>
Message-ID: <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 17:11, Michal Hocko <mhocko@suse.com> wrote:
>
> Let's put whishful thinking aside. Unless somebody manages to go over
> all existing NOFAIL users and fix them then we should better focus on
> providing a reasonable clearly documented and enforced semantic.

I do like changing the naming to make it clear that it's not some kind
of general MM guarantee for any random allocation.

So that's why I liked the NOFAIL_SMALL_ALLOC just to make people who
use it aware that no, they aren't getting a "get out of jail free"
card.

Admittedly that's probably _too_ long a name, but conceptually...

              Linus
