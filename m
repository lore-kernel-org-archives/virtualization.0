Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CC33F6
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256072; cv=none; b=Scb6gPrxjpPDJ6xPjBqulYD3DJN4Z4NoFjK3f6SMcfazX3vu0wLEMim/Thpd3Ma+kLh0AeEpc/LJpVArkQg+aYyKYUuhYdp0+gBlhUjrWvaQjPYXb9ROEJa9CUBqPqtBqxf2hHNCuwL+RT05wTOlaplqNGabjzb9y8vpOfuFU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256072; c=relaxed/simple;
	bh=XRgx6l6Ouz4dFOn2rowmUJdENg17O0UPOTtj0T0iIUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGdAERxrcW+H6pVYKSEAGvunwbnYK78UT2y8sxhFzQjHlRVAGrEAXBkV447BQxxPV/LTYufRX5xoBbxLuay509Izt4kVq5TN6/IUqOSi6ZovdFNpYR90+davdnEKNmHL+/nRRYvPw6aADlh6ChBjlkAPkH1N3mopH/6NWhvGTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icOyV1Lv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icOyV1Lv"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c331543ef0so21551956d6.1
        for <virtualization@lists.linux.dev>; Sun, 01 Sep 2024 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725256070; x=1725860870; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/WIGvVQ42vNYGJNdFf3Oc9aHSeA4jiKtJQlg8xSf3w=;
        b=icOyV1Lv8s3I1ytA/+29o3FC0OwP/cSyicgeXSZSt07yuX1an99tt60+EOyp94P8Jo
         mEE1Ga4VvR9nbRP7tehn1kOI25xXdqWyn3FEaL8Nzxpl0ElugEQkVSwp+cRU52kU+PY7
         8gHRlCGC8M2/p5hMYYxO/zLfvMwn33+jFUzHsIXSubJfg+9PMVIaFpY66z9q7u4k13Pr
         cmeRp5o4ueNVfOqXbS6+/v7s5/vthyPmrneXTC7BxqWUyBJO8dBB7Zal1RBFUu+OCrxH
         YFNKYQafVdl81wttEBrSSpIr8jhBz649nDVmUJIP3B5o9Y8+XZuEDv4HKb10jnVnsJY/
         sFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725256070; x=1725860870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/WIGvVQ42vNYGJNdFf3Oc9aHSeA4jiKtJQlg8xSf3w=;
        b=JE4nmAE+81YbnOqaVepoWhbQU3w9VRumYdZZhrzUw2W4AYHOCpRN6PY6kS0S/O6jL1
         2HWLVHdQx7zAj4JsAofFbGAUss+89XMvOtabud1jewxb2TtFI6VKCAR/Udm3j5zL2zOk
         mJeHy/rEjPeOEEh3UDoJPAOUNGE1B+YkJJ3sFozJ3Zv5ohOK+G5kbEnY59suYMd6VdVP
         tTn38+WN9nsmr1ttqN7R/gIi5YOhi4djoXZCv80fLajFm4Z4uUMFi7ykd9B6pF/i8Erf
         CEXQXC8zm1iGQhbnxmBn9igHxzW7kdLPwQR1Ix/QLX2iAOD6kWcqHE6Yjb13AhhLDMsB
         i8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJlohtOHMXb4y9aTQAV2AdUw+E2Xc0AIRVsjCy+Ys8hfzIV95p9qx+/qF+TDc6p71pAevNPCM4+fwN8B33iw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyeb3zKSqWelv38X1woHbsRx6A4OKGFUCO6ZD5b4DhJYgrvQKw4
	RJhZ3y9CB4EHH6aPZzY4qt2jBql1dzCQPv+BEDP4GE2XTy60FLpmr4AkS+huwaLA24dghadYUOe
	KLRkK5hRSlZJJjIkpuaS83niOnAc=
X-Google-Smtp-Source: AGHT+IH8h/peDYpdP4NKFa5wZZUVkjANuvU8ugP9rHzKGMtxZfDV+MPy1Hc1uEWSoB2fp58ia8x6fGds1P0k6PCU5Ik=
X-Received: by 2002:a05:6214:2dc1:b0:6c3:657a:cbb9 with SMTP id
 6a1803df08f44-6c3657acd86mr38481226d6.34.1725256069695; Sun, 01 Sep 2024
 22:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240830202823.21478-1-21cnbao@gmail.com> <20240830202823.21478-4-21cnbao@gmail.com>
 <CALOAHbBpw20ma7=ccc3qotnqZ=v5KDkuisMKzwr0QSv_DvkWEw@mail.gmail.com> <CAGsJ_4wrDi6CVPF7DBF3WJXKfv-tKqz1hmw0D+SOt7SdUqw7tA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wrDi6CVPF7DBF3WJXKfv-tKqz1hmw0D+SOt7SdUqw7tA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 2 Sep 2024 13:47:13 +0800
Message-ID: <CALOAHbCEVmvy=PVWP-oLjRxYiAWaj7H-qDw+P9VNMAf=Qzzhpg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a
 more appropriate location and manner
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, david@redhat.com, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Sep 2, 2024 at 3:23=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Sat, Aug 31, 2024 at 4:29=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > Three points for this change:
> > >
> > > 1. We should consolidate all warnings in one place. Currently, the
> > >    order > 1 warning is in the hotpath, while others are in less
> > >    likely scenarios. Moving all warnings to the slowpath will reduce
> > >    the overhead for order > 1 and increase the visibility of other
> > >    warnings.
> > >
> > > 2. We currently have two warnings for order: one for order > 1 in
> > >    the hotpath and another for order > costly_order in the laziest
> > >    path. I suggest standardizing on order > 1 since it=E2=80=99s been=
 in
> > >    use for a long time.
> > >
> > > 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
> > >    is meant to suppress allocation failure reports, but here we're
> > >    dealing with bug detection, not allocation failures. So replace
> > >    WARN_ON_ONCE_GFP by WARN_ON_ONCE.
> > >
> > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  mm/page_alloc.c | 50 ++++++++++++++++++++++++-----------------------=
--
> > >  1 file changed, 25 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index c81ee5662cc7..e790b4227322 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zo=
ne,
> > >  {
> > >         struct page *page;
> > >
> > > -       /*
> > > -        * We most definitely don't want callers attempting to
> > > -        * allocate greater than order-1 page units with __GFP_NOFAIL=
.
> > > -        */
> > > -       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > > -
> > >         if (likely(pcp_allowed_order(order))) {
> > >                 page =3D rmqueue_pcplist(preferred_zone, zone, order,
> > >                                        migratetype, alloc_flags);
> > > @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned=
 int order,
> > >  {
> > >         bool can_direct_reclaim =3D gfp_mask & __GFP_DIRECT_RECLAIM;
> > >         bool can_compact =3D gfp_compaction_allowed(gfp_mask);
> > > +       bool nofail =3D gfp_mask & __GFP_NOFAIL;
> > >         const bool costly_order =3D order > PAGE_ALLOC_COSTLY_ORDER;
> > >         struct page *page =3D NULL;
> > >         unsigned int alloc_flags;
> > > @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigne=
d int order,
> > >         unsigned int zonelist_iter_cookie;
> > >         int reserve_flags;
> > >
> > > +       if (unlikely(nofail)) {
> > > +               /*
> > > +                * We most definitely don't want callers attempting t=
o
> > > +                * allocate greater than order-1 page units with __GF=
P_NOFAIL.
> > > +                */
> > > +               WARN_ON_ONCE(order > 1);
> > > +               /*
> > > +                * Also we don't support __GFP_NOFAIL without __GFP_D=
IRECT_RECLAIM,
> > > +                * otherwise, we may result in lockup.
> > > +                */
> > > +               WARN_ON_ONCE(!can_direct_reclaim);
> > > +               /*
> > > +                * PF_MEMALLOC request from this context is rather bi=
zarre
> > > +                * because we cannot reclaim anything and only can lo=
op waiting
> > > +                * for somebody to do a work for us.
> > > +                */
> > > +               WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> >
> > I believe we should add below warning as well:
> >
> >   WARN_ON_ONCE(gfp_mask & __GFP_NOMEMALLOC);
> >   WARN_ON_ONCE(gfp_mask & __GFP_NORETRY);
> >   WARN_ON_ONCE(gfp_mask & __GFP_RETRY_MAYFAIL);
> >   ...
> >
> > I'm not sure if that is enough.
> > __GFP_NOFAIL is a really horrible thing.
>
> Thanks! I'd prefer to keep this patchset focused on the existing
> warnings and bugs. Any new warnings about size limits or checks
> for new flags can be addressed separately.

OK
Thanks for your work.

--=20
Regards
Yafang
