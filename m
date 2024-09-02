Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4E3BBD8
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725249650; cv=none; b=cHP7M+NelG3KLS9njYfHG/5SpHdkVbLtQPPLcqHnxuUsB+zDJzTUWhqAZ7ofjuEOQwzm+nzjybFowTzCq1CMDlk9q5g7raQZilQ1g9siWq8oeQqyCaVVf3QPKgcHGto/LRGZCdeoQvlMPRTyOdjda47D0Rf/iyofGcEmdsrvYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725249650; c=relaxed/simple;
	bh=6V5DLvfdNY3qeXBjR09QVxyMN+O9Y4hh/5DJ7mRuFm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udOUwgjXAIugFMUbW5obHuiWRi2C6/neK6TgDhH/qSAZTT0bWSHdv+zGjkfJssYRSaepjEFf8s5LoDrb9wedkfad3J85Vp4xEe8M8KYnJuHLnr48bziZJdgUm/Z8lVQ2KK3Yv2bv4pNpZsb/qn6A/HEPn+/6Fj3JlY1/PawHqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdCBVh1b; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdCBVh1b"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-498e1e3bee8so1156355137.0
        for <virtualization@lists.linux.dev>; Sun, 01 Sep 2024 21:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725249648; x=1725854448; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmDB7V2FAlLppJcv6qEB74wU6sInJM9aiR+Q1vjKiCc=;
        b=bdCBVh1bYJnPC13+dR+mOZ8MpnIlNHFGqRMKnpwQYV9UVs81SG5yYwYDFT2f3RxSCt
         OvEteK2HpGz7KpYwJrfcbZpv7HbQUMnEufSyTlFIIniF6+OqA21l+vGRuv+ukAyjnKrq
         8iRfJSam80kWnE/tf9YwZAqDrs9Ii4lRm++zGWs1uVpJNtrpR/h4NDUUmlwB34NG1Qna
         mnsPTChS0al7Cv9iDaH+xKHLV0kpENWfM4iY9LhFRbZ0FK1LcVWax7JGwf8Ej85aM/HI
         zurqE5ftoKTL87vp/JsIiVM8t0LG15lD1dcdojOev/CpVIdslL3zlAYYdfD84YR9JsT9
         cIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725249648; x=1725854448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmDB7V2FAlLppJcv6qEB74wU6sInJM9aiR+Q1vjKiCc=;
        b=p8Lz9AGc/gQuKwTXfvyhTPOToZkRaax2xM0E4mu9PsR+1k/Dw9ELtKqbOvNc5M+6wk
         Gfw+UG3T69NYOEI85Qx+16gLQy359iAgOo3yF87wNMo0QWiMav21B3cOGIf86bNhPo8l
         +TtDfYGuaPlofI8RPHEJ3/5z6ozSoptuOv/XZE1Xj6FjAM0f7fyXddMFRKDT9SOosGGQ
         sKWxNZuW0q/ia1Py6kYKYWM9HIPF6dz9tjxlTZzoAkQ/+SbeEiLOmdo0cKqG8Abmz+3/
         0Vbe7Rh62nfVpTqDIxPY1lc3OjOL1dK49a4NTeY9V0yOaFCVl0rka9EN615u4rNSFGZk
         tY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0tT9qcmVX5hHVPMHJ3mgAFzbe7lSzu9kaUSLcNYf8w5Vlc3UBGgaB35XjL6sVMvW14dWNqlc0bU0ryc8eEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0/rxNan0qEG2BifvNScKQ9518h0QZ/0x6iIVD3NV0GSORbk1V
	Thd1zHqpPAiamU53px0D/OWy8wiIrPGvp/XpC3B2/uEC6TpQTzNX6vuHZ8yUPf5Y1BvvTSuSgNI
	LU3rsCWuEkjduQtjoWtd25+B4tho=
X-Google-Smtp-Source: AGHT+IHcq8/uECWUpxFQ8vHMJBMh+xl0lDhReLp2jQiO2kwJXnwdTQuwwl+JZEev+2M1ZKM3xHuXJ1pGGPfwswIq7Uw=
X-Received: by 2002:a05:6102:3909:b0:498:e7fc:d273 with SMTP id
 ada2fe7eead31-49a779b9db0mr3923783137.18.1725249647656; Sun, 01 Sep 2024
 21:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830202823.21478-1-21cnbao@gmail.com> <20240830202823.21478-4-21cnbao@gmail.com>
 <CALOAHbBpw20ma7=ccc3qotnqZ=v5KDkuisMKzwr0QSv_DvkWEw@mail.gmail.com>
In-Reply-To: <CALOAHbBpw20ma7=ccc3qotnqZ=v5KDkuisMKzwr0QSv_DvkWEw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 2 Sep 2024 16:00:36 +1200
Message-ID: <CAGsJ_4wrDi6CVPF7DBF3WJXKfv-tKqz1hmw0D+SOt7SdUqw7tA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a
 more appropriate location and manner
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, david@redhat.com, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:23=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Sat, Aug 31, 2024 at 4:29=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Three points for this change:
> >
> > 1. We should consolidate all warnings in one place. Currently, the
> >    order > 1 warning is in the hotpath, while others are in less
> >    likely scenarios. Moving all warnings to the slowpath will reduce
> >    the overhead for order > 1 and increase the visibility of other
> >    warnings.
> >
> > 2. We currently have two warnings for order: one for order > 1 in
> >    the hotpath and another for order > costly_order in the laziest
> >    path. I suggest standardizing on order > 1 since it=E2=80=99s been i=
n
> >    use for a long time.
> >
> > 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
> >    is meant to suppress allocation failure reports, but here we're
> >    dealing with bug detection, not allocation failures. So replace
> >    WARN_ON_ONCE_GFP by WARN_ON_ONCE.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c81ee5662cc7..e790b4227322 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone=
,
> >  {
> >         struct page *page;
> >
> > -       /*
> > -        * We most definitely don't want callers attempting to
> > -        * allocate greater than order-1 page units with __GFP_NOFAIL.
> > -        */
> > -       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > -
> >         if (likely(pcp_allowed_order(order))) {
> >                 page =3D rmqueue_pcplist(preferred_zone, zone, order,
> >                                        migratetype, alloc_flags);
> > @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned i=
nt order,
> >  {
> >         bool can_direct_reclaim =3D gfp_mask & __GFP_DIRECT_RECLAIM;
> >         bool can_compact =3D gfp_compaction_allowed(gfp_mask);
> > +       bool nofail =3D gfp_mask & __GFP_NOFAIL;
> >         const bool costly_order =3D order > PAGE_ALLOC_COSTLY_ORDER;
> >         struct page *page =3D NULL;
> >         unsigned int alloc_flags;
> > @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned =
int order,
> >         unsigned int zonelist_iter_cookie;
> >         int reserve_flags;
> >
> > +       if (unlikely(nofail)) {
> > +               /*
> > +                * We most definitely don't want callers attempting to
> > +                * allocate greater than order-1 page units with __GFP_=
NOFAIL.
> > +                */
> > +               WARN_ON_ONCE(order > 1);
> > +               /*
> > +                * Also we don't support __GFP_NOFAIL without __GFP_DIR=
ECT_RECLAIM,
> > +                * otherwise, we may result in lockup.
> > +                */
> > +               WARN_ON_ONCE(!can_direct_reclaim);
> > +               /*
> > +                * PF_MEMALLOC request from this context is rather biza=
rre
> > +                * because we cannot reclaim anything and only can loop=
 waiting
> > +                * for somebody to do a work for us.
> > +                */
> > +               WARN_ON_ONCE(current->flags & PF_MEMALLOC);
>
> I believe we should add below warning as well:
>
>   WARN_ON_ONCE(gfp_mask & __GFP_NOMEMALLOC);
>   WARN_ON_ONCE(gfp_mask & __GFP_NORETRY);
>   WARN_ON_ONCE(gfp_mask & __GFP_RETRY_MAYFAIL);
>   ...
>
> I'm not sure if that is enough.
> __GFP_NOFAIL is a really horrible thing.

Thanks! I'd prefer to keep this patchset focused on the existing
warnings and bugs. Any new warnings about size limits or checks
for new flags can be addressed separately.

>
> --
> Regards
> Yafang

Thanks
Barry
