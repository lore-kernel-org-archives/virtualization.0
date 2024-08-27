Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D05A4D5
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745038; cv=none; b=fLJXJXwk651f/lgIL3oozh6TSxaB69pxWhz+Mud0oLrCLcge5JzT/aZRALAvnFYEgfewvIDYTIAg9qqKyXtqfDpZ+oRsbF1f2sLWhYbaJJbjKSO0WlOW4waBlMpxNIDcUygztzBYN5JzUh2LMQo9UjKpivtgh0tjnCjNSGAjms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745038; c=relaxed/simple;
	bh=Jm6KRs27Y9FnzUL0keiTQy1W9sO72aXnxjlqCgCP9AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7QQixXfQak64siw0g4Sazw1kOSwk5FagEKlMUnQQXFdbG67qxMScVnaOYiYVRACI4tdiTlmCHNHGIFEmjLVL9J16p28B4X0iTRAZYsMqwNQ/0vvwPqg96RSaej/YW85IhHFKAi5twuKy/k5UTHVZ4VMGWSyR8ZOR5wEqMIVssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjHNkFDZ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjHNkFDZ"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4fce700765aso1507154e0c.2
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724745035; x=1725349835; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wgvwFwY07qfV5rJ9U1zenMbeFlVV3ehDJ0sYX1Z8kw=;
        b=kjHNkFDZVVl8sYjfaVF38xD/p5p/2tOfikWgRU+atuXyjco60oRK5GqfUYFAGHRDkE
         DtMH9Pztx5M+jt0RP7JknOkqgDfiwO1Uxe3CS5usrkXBliWzUFb7hXpzSaOKXP4Mv80T
         9twLfdj1kReBAjJJTCmZCEe/9Q5/fgEIa2MnXdPrRWxeFdyQkjPVhREuxb9BSVsWM/Vu
         JyH4xJTBYKn9eOoSoAAUoEbHAh9x8yl0kR7UcYxZcsHMrxmyhLla/9toUDNeIEIeEGUy
         urQbJr2rJ9MxBQuJHBe1lAnMc0TGsAIQzLgKQIicm92VGj0Bys1N3bFnheZ5Uo5UlAjW
         Z7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745035; x=1725349835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wgvwFwY07qfV5rJ9U1zenMbeFlVV3ehDJ0sYX1Z8kw=;
        b=wvffcjFqRECFvyosG3R1aJ0Ok28EBs6Dnmdob/ehx5svnpf+Bfjxjp3OyREudozGbr
         gzHE9csKieylTKZa9uky2uhw2GpKneNvyU6GuuKIC5JoBrBe9g4kGOvBHn1ZK3rgTkiv
         X2dSzJMwazdiw9yATydIAjTORCS3E7777RIxAJ6MK3Qbgt3GzmeQ2uaCsNUfCPDT5uTi
         7z4JBxhzHcTFuozFVuDuzHqE6ahZaA/w+z1wgkwUmaUeyxN6shNPp8VS5oWaNFW/q2r8
         8p/thlLxWwNVus+bl78D3WiZEsM2/bQHnjx38WHL/mwy1kn2F80iRksUDYqnhypA6SOD
         SOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdzE4n4DcQ0EcSS8+0g2Sai5ihRLHA2q46AU1b7SvAJGaRyhjQPSTb/sCoJIsVdbGhUsff36g3LINw74/16A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU3QnKW82GpPN3A5JdftEXD00kWhrIyfB1Z8Lw6E9za2ycwJPS
	D5Opdkq3qELmtGHXz5RFGxOtQaSEaPWdiA6foUuwJfaMq4rqrz58d7+NDHUak7Ky2VWK+YQAtd0
	8OcaEPHZcRYbSOSMre5Wq3KYyIck=
X-Google-Smtp-Source: AGHT+IG3l2I8ry4NFwxm4gb/HF0UoyCqgrF6iHGQmn8/QN7HV+MQBXm6HcSR2hyeA4dKqBSXGkiPf8YKtKERe3F5fTA=
X-Received: by 2002:a05:6122:2212:b0:4fc:da8f:c8a8 with SMTP id
 71dfb90a1353d-4fed5d66cadmr2779461e0c.1.1724745035099; Tue, 27 Aug 2024
 00:50:35 -0700 (PDT)
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
 <ZscAtVskxgONe3gT@tiehlicka> <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz> <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
 <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz>
In-Reply-To: <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Aug 2024 19:50:23 +1200
Message-ID: <CAGsJ_4wu3theWe0iyXdBK-JvLfuBh7Qw-B+9Wztm2XyrU1Uzeg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Michal Hocko <mhocko@suse.com>, Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:38=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 8/27/24 09:15, Barry Song wrote:
> > On Tue, Aug 27, 2024 at 12:10=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> >>
> >> On 8/22/24 11:34, Linus Torvalds wrote:
> >> > On Thu, 22 Aug 2024 at 17:27, David Hildenbrand <david@redhat.com> w=
rote:
> >> >>
> >> >> To me, that implies that if you pass in MAX_ORDER+1 the VM will "re=
try
> >> >> infinitely". if that implies just OOPSing or actually be in a busy =
loop,
> >> >> I don't care. It could effectively happen with MAX_ORDER as well, a=
s
> >> >> stated. But certainly not BUG_ON.
> >> >
> >> > No BUG_ON(), but also no endless loop.
> >> >
> >> > Just return NULL for bogus users. Really. Give a WARN_ON_ONCE() to
> >> > make it easy to find offenders, and then let them deal with it.
> >>
> >> Right now we give the WARN_ON_ONCE() (for !can_direct_reclaim) only wh=
en
> >> we're about to actually return NULL, so the memory has to be depleted
> >> already. To make it easier to find the offenders much more reliably, w=
e
> >> should consider doing it sooner, but also not add unnecessary overhead=
 to
> >> allocator fastpaths just because of the potentially buggy users. So ei=
ther
> >> always in __alloc_pages_slowpath(), which should be often enough (unle=
ss the
> >> system never needs to wake up kswapd to reclaim) but with negligible e=
nough
> >> overhead, or on every allocation but only with e.g. CONFIG_DEBUG_VM?
> >
> > We already have a WARN_ON for order > 1 in rmqueue. we might extend
> > the condition there to include checking flags as well?
>
> Ugh, wasn't aware, well spotted. So it means there at least shouldn't be
> existing users of __GFP_NOFAIL with order > 1 :)
>
> But also the check is in the hotpath, even before trying the pcplists, so=
 we
> could move it to __alloc_pages_slowpath() while extending it?

Agreed. I don't think it is reasonable to check the order and flags in
two different places especially rmqueue() has already had
gfp_flags & __GFP_NOFAIL operation and order > 1
overhead.

We can at least extend the current check to make some improvement
though I still believe Michal's suggestion of implementing OOPS_ON is a
better approach to pursue, as it doesn't crash the entire system
while ensuring the problematic process is terminated.

>
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 7dcb0713eb57..b5717c6569f9 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3071,8 +3071,11 @@ struct page *rmqueue(struct zone *preferred_zone=
,
> >   /*
> >   * We most definitely don't want callers attempting to
> >   * allocate greater than order-1 page units with __GFP_NOFAIL.
> > + * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
> > + * which can result in a lockup
> >   */
> > - WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > + WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) &&
> > +     (order > 1 || !(gfp_flags & __GFP_DIRECT_RECLAIM)));
> >
> >   if (likely(pcp_allowed_order(order))) {
> >   page =3D rmqueue_pcplist(preferred_zone, zone, order,
> >
> >>
> >> > Don't take it upon yourself to say "we have to deal with any amount =
of
> >> > stupidity".
> >> >
> >> > The MM layer is not some slave to users. The MM layer is one of the
> >> > most core pieces of code in the kernel, and as such the MM layer is
> >> > damn well in charge.
> >> >
> >> > Nobody has the right to say "I will not deal with allocation
> >> > failures". The MM should not bend over backwards over something like
> >> > that.
> >> >
> >> > Seriously. Get a spine already, people. Tell random drivers that cla=
im
> >> > that they cannot deal with errors to just f-ck off.
> >> >
> >> > And you don't do it by looping forever, and you don't do it by killi=
ng
> >> > the kernel. You do it by ignoring their bullying tactics.
> >> >
> >> > Then you document the *LIMITED* cases where you actually will try fo=
rever.
> >> >
> >> > This discussion has gone on for too damn long.
> >> >
> >> >               Linus
> >>
>

Thanks
Barry
