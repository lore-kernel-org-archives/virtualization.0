Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30119470
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317718; cv=none; b=GLHBOM8l1AxNzKo1aJbZDVwD1g+uJT39kWoPE/w5pOzSWcGiKylKn1xinqBEbm0GXOK7qBM7o10LcyfRknOuzTeO3i7Ex/YNa6DW1HGZsiKA1xMaC38VuyBKs6yl6TfDdjxEKDh3V8Fe6nva0YsL+gePR/iPfJ6wNBfHUsWYrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317718; c=relaxed/simple;
	bh=17Ke/pDjfWS9ckuVgiQeJ8DSAJYqi2ZhzXtkd/4hjFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Das9/5VdVxdOwdQu4AlQBHZgSiCIXOeyaTO865WlAPQE8L+SGO6LUuVcbznIWcU9kvNcRabFnnNfVq2Y7o60Ni/d5NzgMp9u9NolgKM1A/RpI50Rn4Fpoh+88sXw4g2sRq6fMD9tgb0uX7FTxEjXmD9XGPpqlxoTdF7F6ddrIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M/XTsQtY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/XTsQtY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so824479a12.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724317714; x=1724922514; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=elPQ+tLq/JngyC9O8ZSXHOeYpkmReJmczepO/zPwyZU=;
        b=M/XTsQtY30I58hEh6u0vfqO834xM9IeWi1Kis8NNVEHFbmTk58qdxhYThnHPWa0rMa
         Pbm7kRaL1pONYwoeCrQPJgqsOjueTXqP3f3qQUXJ1FN8LiHXzq/IwzhrmUtLHO/F2ZDc
         OxBrqROvDeqptsoQ25KEsRQl7On7wtuGIul+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317714; x=1724922514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elPQ+tLq/JngyC9O8ZSXHOeYpkmReJmczepO/zPwyZU=;
        b=M0ZmjCVc8asdvNiZxODelr6Znlj0Unn25EbPQBNkKLedcuyzIvzASdZWZ7NyMbDvQn
         fNReF95b5ApqO0I3yyCw0DjyRxjSTFZZGySNj1hUkI+6dnxgMDygMv5OY22VvJf2WAtf
         UU3hPWtQicq/zgBp+lI0RhSgCh69gD16tOpqIaPH5IeZlORrceXEkeYzs+RGqgMe0VIL
         6gxXmxl6pFMekyq8M4GyJ+EtYrRhn+tFghkQ8+bulQkJYz1wDJYxgZIuCp58e0uSeUjq
         9a0C2jYNN7Jay2vU9K6Twc9lVfzs6BOvTcIp/Rhjy2R0qOnnb/szqfskdBwa6InT3wXD
         S+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUSgBwOr0w/TJf/q2t46XAExbCVDNq4i/NhGrH4Iu6bpQb9gdmsJErSB4XvamKoHR7LMDaEYe22+WuIbhuz8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUTgQvoJ1EAX+r77J6vOdHPwU/vH7qeUZfeaYbYQaiQwOE0AC6
	n0j1qyzCzx2D27Cb5bcyiUzS37TpYpmO8EOmyRmPgXyzWXGhE8j+fMnMomNsGZnSlzPutobAo5H
	Pz8DGfg==
X-Google-Smtp-Source: AGHT+IE3W4z7XR2roKZXPONpkIaPCRzbs29WwNTWxZ1LLd6nIysnIiu6xBrKq94VVBtz4JiUznvEUw==
X-Received: by 2002:a05:6402:3512:b0:5be:ef05:87d with SMTP id 4fb4d7f45d1cf-5c079292fabmr773076a12.24.1724317713213;
        Thu, 22 Aug 2024 02:08:33 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3eb693sm656043a12.53.2024.08.22.02.08.31
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 02:08:31 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so631107a12.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:08:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQ6EcE0WFV+/pghiuCVdI8IRi/q3hd0GW47srAdMr3WFjbDrkFAEWjHO+kQe8XPGF6GXPQAO2sfrMOEbhYqw==@lists.linux.dev
X-Received: by 2002:a05:6402:2686:b0:5bf:a2c:4f35 with SMTP id
 4fb4d7f45d1cf-5c0791ebfa8mr674463a12.10.1724317711442; Thu, 22 Aug 2024
 02:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka> <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka> <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
In-Reply-To: <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Aug 2024 17:08:15 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjTTAKRgVD=StNbV1FtPz+a1DHYBbrJuP=kmd_vm8ssFg@mail.gmail.com>
Message-ID: <CAHk-=wjTTAKRgVD=StNbV1FtPz+a1DHYBbrJuP=kmd_vm8ssFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 16:39, David Hildenbrand <david@redhat.com> wrote:
>
> Linus has a point that "retry forever" can also be nasty. I think the
> important part here is, though, that we report sufficient information
> (stacktrace), such that the problem can be debugged reasonably well, and
> not just having a locked-up system.

Unless I missed some case, I *think* most NOFAIL cases are actually
fairly small.

In fact, I suspect many of them are so small that we already
effectively give that guarantee:

> But then again, sizeof(struct resource) is probably so small that it
> likely would never fail.

Iirc, we had the policy of never failing unrestricted kernel
allocations that are smaller than a page (where "unrestricted" means
that it's a regular GFP_KERNEL, not some NOFS or similar allocation).

In fact, I think we practically speaking still do. We really *really*
tend to try very hard to retry small allocations.

That was one of the things that GFP_USER does - it's identical to
GFP_KERNEL, but it basically tells the MM that it should not try so
hard because an allocation failure was fine.

(I say "was", because the semantics have changed over time.
Originally, GFP_KERNEL had the "GFP_HIGH" bit set that said "access
emergency pools for this allocation", and GFP_USER did not have that
bit set. Now the only difference seems to be GFP_HARDWALL, so a user
allocation the cgroup limits are hard limits etc. I think there's been
other versions of this kind of logic over the years as people try to
make it all work out well in practice).

In fact, kernel allocations try so hard that we have those "opposite
flags" of ___GFP_NORETRY and ___GFP_RETRY_MAYFAIL because we often try
*TOO* hard, and reasonably many code-paths have that whole "let's
optimistically ask for a big allocation, but not try very hard and not
warn if it fails, because we can fall back on a smaller one".

So it's _really_ hard to fail a small GFP_KERNEL allocation. It used
to be practically impossible, and in fact I think GFP_NOFAIL was
originally added long ago when the MM code was going through big
upheavals and one of the things that was mucked around with was the
whole "how hard to retry".

              Linus
