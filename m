Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A11CB15D
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336605; cv=none; b=mH2z9/JAHuaViXM5Xgql+Vs80EiTE2+Z6jF7Ik58j5zS05cZNUhvnuGQwdzopvYGWC9b32hQjTCWh4ThbdF3V/kLM+ZIMD3yx//njHz+5DVqbsWwzvEN0Qj8kz3F+4LwRuvMYWq3IilKmZ5uiIXbaeeVFCk04waH0cH2iSYyEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336605; c=relaxed/simple;
	bh=WW3Y0xQ2YsNx5DeV8nHry8ZBJaWErWth6EqTeDUkq+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfHxLpRBMP7y50J1WS/uId8IcsAUFEU6cbyKT2p9IJVktTvU0rWhqYyMkZlIgQQOT8ufWvPx6eesk03U0R9PWm65cKTW3ZPJSy4jYUAf+7t/vlR1G8ujRdh9G0n0cvtWUwQoY99dEaFaG0QtqVoNjrlzlB1VoVaqDoC2G+Q4mpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuuym5Vl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuuym5Vl"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf89e59ff8so4050086d6.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724336603; x=1724941403; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMaAuY7A8lo8j+oYYWlt54g77ZLGhGOJF8yf2vy/BSs=;
        b=Nuuym5VlaaroNX4dx0lqZ0zx+lNyZQoT4dmW5gS70beFlLN46Q6FdX/oyOfg8VtZc0
         /nGnpKjNpYneA17QVglmAJBHCByL1fVdN82InMsOfPmhWhML3pRHRWjLX7ZuxqJ3k60c
         58J1Wq/PXx6aqMkMorwZRrExJRI7PH8U/bDDMESDh5DL9hEsiSKqAfvGMzd9Mhl2RfDO
         EynnRsTm8Tm257OtRX/g+M2xBzetv48twjhs1aXvrR3dOguK8hgRoFnncke+NcuBF2tv
         J0u2IvuSm802ESV3aiCBYlyKgHAREDl7+Flp2YIh5Jrurnj97LVktntHRLGLAUpU9OEI
         9Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336603; x=1724941403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMaAuY7A8lo8j+oYYWlt54g77ZLGhGOJF8yf2vy/BSs=;
        b=lSkRX9CJMdcFSh6RVhHbr0FpraSo/+rpTI5vzrEBcWhO4cmKGM+PpVm+z/cYf5gBG7
         d4qYw+HFa9CVz0eNw4Fu6sREK3ApPoB2jLcVZGyfphDMR1fA8fwSob3KKEs8lTeDs2Ao
         1x6yrdxShEZZtmgwefBw8XPsVN1qfvfZeHnWda6VWoobpX69SKi3kTjfJFKIppKYm9el
         HmWP8rc2+dQCB5E1toEpi5TEvru7U0PqnuVMPsYAg0F/vip2CXNa3qGel8dOa9GuLQbG
         HQ+H3oVuyf9fMAk7+KP0yrHu+DbBYhcjBhYdd6k6TtvgmfipZ+OSoQdjDW6GogVTlRw8
         RRXg==
X-Forwarded-Encrypted: i=1; AJvYcCUFqRadShmmCGmyVeg2GkCdVRobC9ItFi3tIHnTMz3FIdU6+Cn1OvpBOkqvQbd1zOtQ8AyA4iiBxGy0dTaUPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNqYvSprO08Q3AeHLGD+J1OIsX1YFhd90UILiNy/ve3EsENAsb
	DyNef/KTsFNG919WPofc41sVXxWS0ph+RDGjiQvXAM5FYHlQTP95g+VK6BOuh4hC7CYH9Hkvrr0
	/HRy4axXriEEJ6CKsyu64PqV5eSk=
X-Google-Smtp-Source: AGHT+IGgQfgMY3VjBOZ36Vc/z+czott+LzOIrgYtAtIz7ThXSLYFEGgj+qU8JX/hdSDBMQCuyQKUQqtAYqiFBPXsD4w=
X-Received: by 2002:a05:6214:5988:b0:6bf:745e:d48e with SMTP id
 6a1803df08f44-6c15688f48fmr76019766d6.51.1724336602804; Thu, 22 Aug 2024
 07:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com> <CAGsJ_4xbrrOy84CnZ-x1MG9FhBqp8E-bz6KfB9eku+kd_xsWFA@mail.gmail.com>
In-Reply-To: <CAGsJ_4xbrrOy84CnZ-x1MG9FhBqp8E-bz6KfB9eku+kd_xsWFA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 Aug 2024 22:22:44 +0800
Message-ID: <CALOAHbByCJCPzhA_RB-p7Ug7xgx+seeg9BN1wYhq=15VvVsBiQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Barry Song <21cnbao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com, 
	vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:37=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Aug 22, 2024 at 12:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Tue, Aug 20, 2024 at 12:05=E2=80=AFAM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Mon, 19 Aug 2024 at 06:02, David Hildenbrand <david@redhat.com> wr=
ote:
> > > > >
> > > > > If we must still fail a nofail allocation, we should trigger a BU=
G rather
> > > > > than exposing NULL dereferences to callers who do not check the r=
eturn
> > > > > value.
> > > >
> > > > I am not convinced that BUG_ON is the right tool here to save the w=
orld,
> > > > but I see how we arrived here.
> > >
> > > I think the thing to do is to just add a
> > >
> > >      WARN_ON_ONCE((flags & __GFP_NOFAIL) && bad_nofail_alloc(oder, fl=
ags));
> > >
> > > or similar, where that bad_nofail_alloc() checks that the allocation
> > > order is small and that the flags are sane for a NOFAIL allocation.
> > >
> > > Because no, BUG_ON() is *never* the answer. The answer is to make sur=
e
> > > nobody ever sets NOFAIL in situations where the allocation can fail
> > > and there is no way forward.
> > >
> > > A BUG_ON() will quite likely just make things worse. You're better of=
f
> > > with a WARN_ON() and letting the caller just oops.
> > >
> > > Honestly, I'm perfectly fine with just removing that stupid useless
> > > flag entirely. The flag goes back to 2003 and was introduced in
> > > 2.5.69, and was meant to be for very particular uses that otherwise
> > > just looped waiting for memory.
> > >
> > > Back in 2.5.69, there was exactly one user: the jbd journal code, tha=
t
> > > did a buffer head allocation with GFP_NOFAIL.  By 2.6.0 that had
> > > expanded by another user in XFS, and even that one had a comment
> > > saying that it needed to be narrowed down. And in fact, by the 2.6.12
> > > release, that XFS use had been removed, but the jbd journal had grown
> > > another jbd_kmalloc case for transaction data. So at the beginning of
> > > the git archives, we had exactly *one* user (with two places).
> > >
> > > *THAT* is the kind of use that the flag was meant for: small
> > > allocations required to make forward progress in writeout during
> > > memory pressure.
> > >
> > > It has then expanded and is now a problem. The cases using GFP_NOFAIL
> > > for things like vmalloc() - which is by definition not a small
> > > allocation - should be just removed as outright bugs.
> >
> > One potential approach could be to rename GFP_NOFAIL to
> > GFP_NOFAIL_FOR_SMALL_ALLOC, specifically for smaller allocations, and
> > to clear this flag for larger allocations. However, the challenge lies
> > in determining what constitutes a 'small' allocation.
>
> I'm not entirely sure if our concern is with higher order or larger size.

I believe both should be considered. Since the higher-order task might
be easier to address, starting with that seems like the more
straightforward approach.

> Higher
> order might pose a problem, but larger size(not too large) isn't
> always an issue.
> Allocating 100 * 4KiB pages is possibly easier than allocating a single
> 128KB folio.
>
> Are we trying to limit the physical size or the physical order? If the co=
ncern
> is order, vmalloc manages __GFP_NOFAIL by mapping order-0 pages. If the
> concern is higher order, this sounds reasonable.  but it seems the buddy
> system already has code to trigger a warning even for order > 1:

To avoid potential livelock, it may be wise to drop this flag for
higher-order allocations as well. Following Linus's suggestion, we
could start by removing it for "> PAGE_ALLOC_COSTLY_ORDER".

>
> struct page *rmqueue(struct zone *preferred_zone,
>                         struct zone *zone, unsigned int order,
>                         gfp_t gfp_flags, unsigned int alloc_flags,
>                         int migratetype)
> {
>         struct page *page;
>
>         /*
>          * We most definitely don't want callers attempting to
>          * allocate greater than order-1 page units with __GFP_NOFAIL.
>          */
>         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

This line was added by Michal in commit 0f352e5392c8 ("mm: remove
__GFP_NOFAIL is deprecated comment"), but it appears that Michal has
since reconsidered his stance. ;)



--
Regards
Yafang
