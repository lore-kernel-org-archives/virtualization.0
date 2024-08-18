Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B5171AF
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962475; cv=none; b=s/OC9PLKrvF0srceoCzmHaT3TXzI2unIAc0HoBFEQj5InC9VihUMISl10+gG1cVsLnPOu7G+TzpwZhiFD0ol4LmDrjwtIuTCzZR4REXfyXdEKVQN4t4TziGuqCeQYVMKa4yCJFsaJhT1ES5Z/E4ac+3NjNO5XjV1B39E5hh4T9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962475; c=relaxed/simple;
	bh=8xwSzIo+MOXtAWfH6M6SpFJ1cG7fzU2PwBQwcK/KMY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhyHGaxChzBm1Qd9Fik1yZfDqqtwO5nr7s/jM3iHWsJv/FLHM+y3vDj6MRvQWKGLXK8xDqpQimm8QTXqU0R9x4YzQbxpr8w08MHjDr6v9rebemm9E44UAvPnjVGWDqbAmfdsjZynsN1M7Abj8JEso+6VGtVJKrX52SO6EEccMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQPMxX0G; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQPMxX0G"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4fc92316dc1so226885e0c.0
        for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723962473; x=1724567273; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgUO+C1zcLo56ERlZysfiwaIZDpxEmG9haOWGH4e9sU=;
        b=gQPMxX0GI4T3hY+aQXhsmN0/4VahFBVIWVwy8qP4BFtK1JqQNRCaHbOUUItnBYRiNX
         eZ49woU6qihxhSAARIrMBosnrXZmRPtCeIqSzJNIjFMmDaij/2An7EuaRXXEYVKnLQKI
         bZFSDvMVksO4mDYnUI5GWN8ZmWA3ArAp1180g+m7uJTCe37+pBFoIyhelxqwLAIEGJM7
         Nw6QwLVEU1RAn42M5bsPbbjOO59+6D7Cxe/eWCRNQnOmff14xWRoapGHoKI2AGB5U5oG
         hC+J2ZSkjRNTWAm22CkHOBFzFoIvj48W/SaYGN+qNkPeYkloZEnv5RXkF1+aWTLr2u9F
         E/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723962473; x=1724567273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgUO+C1zcLo56ERlZysfiwaIZDpxEmG9haOWGH4e9sU=;
        b=idXe6YGrChsIZbafT2HKKg5dBWwbjkLkdvITpjQQ2OPVBS3tUjMH+pntOAbH1J/g2O
         xHMpcMmWwHoB7Z6v6fbrTd2j5+SFKm8EobpYcLSNhp4l5bmuCgyyAi27jYoR9++Ufy+V
         GC4s8Kedak4sD0jxremlRkrDxd9/jiTlAvXbou1NDCAxZ65pCEiiwDnA8u7zTBUqko2E
         WUCQQn8EA4tBwq/+N4SwUnWT48ApoObDbJEh3+ts5VS2SAdsNBeFZ1FsbMOwoHRT1xi+
         p/iVgaqJV7NGCB8Xi9h+Fwa55uUCjMqmdLloL63i40V+Cc4SWFcJgAxWn/jEMF1rNKLK
         8tnA==
X-Forwarded-Encrypted: i=1; AJvYcCXFms8/oSQHWb12+cVyU9KmP8rJRmWnRZPs2XCbiVo+iD52fxwkdm7tXNnO3aH+6NEU3Y/pTr63PbUEdU0/ukb606G2rlLwBGNUTalOqCc=
X-Gm-Message-State: AOJu0YxH1OXxgaKjLqNgg4XIV8gpk/Pv5CfOWCfSDvSMYk0ghSVnds8W
	UJWOOAbIdfCuzaig670Z0w/k5supraGPxRAMWl0t0hWbAqu1yobVwecnsj6Tekgt3+e9Cu3lJxG
	51AaqQQQOL6AvlzPxW0ibb0v10f8=
X-Google-Smtp-Source: AGHT+IE0az6Fv9KhSH8dZbqFWRVPh5tHPlz3b8uITSy7NR/ejGXgglXgk7rO4mWUrhmALYMSWmI1Rdg+8t4bDTfgS/g=
X-Received: by 2002:a05:6122:d99:b0:4f6:ca2:ad0 with SMTP id
 71dfb90a1353d-4fc6c5b6980mr6322928e0c.1.1723962472556; Sat, 17 Aug 2024
 23:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com> <CALOAHbBLF-Rt-RML=oOAkwW6PJDoMRTdV_6itw69xJLBrERGmQ@mail.gmail.com>
In-Reply-To: <CALOAHbBLF-Rt-RML=oOAkwW6PJDoMRTdV_6itw69xJLBrERGmQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Aug 2024 18:27:41 +1200
Message-ID: <CAGsJ_4zA60pQ8qS4XzoR7ZFeAw=GmA0Xbwx18pLBR-B+nO4Mjw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com, 
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com, 
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 5:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sun, Aug 18, 2024 at 11:48=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Sun, Aug 18, 2024 at 2:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kin=
d of
> > > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If w=
e
> > > > attempt and still fail to allocate memory for these users, we have =
two
> > > > choices:
> > > >
> > > >     1. We could busy-loop and hope that some other direct reclamati=
on or
> > > >     kswapd rescues the current process. However, this is unreliable
> > > >     and could ultimately lead to hard or soft lockups,
> > >
> > > That can occur even if we set both __GFP_NOFAIL and
> > > __GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is related
> > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > design of __GFP_NOFAIL itself.
> >
> > the point of GFP_NOFAIL is that it won't fail and its user won't check
> > the return value. without direct_reclamation, it is sometimes impossibl=
e.
> > but with direct reclamation, users constantly wait and finally they can
>
> So, what exactly is the difference between 'constantly waiting' and
> 'busy looping'? Could you please clarify? Also, why can't we
> 'constantly wait' when __GFP_DIRECT_RECLAIM is not set?

I list two options in changelog
1: busy loop 2. bug_on. I am actually fine with either one. either one is
better than the existing code. but returning null in the current code
is definitely wrong.

1 somehow has the attempt to make __GFP_NOFAIL without direct_reclamation
legal. so it is a bit suspicious going in the wrong direction.

busy-loop is that you are not reclaiming memory you are not sleeping.
cpu is constantly working and busy, so it might result in a lockup, either
soft lockup or hard lockup.

with direct_reclamation, wait is the case you can sleep. it is not holding
cpu, not a busy loop. in rare case, users might end in endless wait,
but it matches the doc of __GFP_NOFAIL, never return till memory
is gotten (the current code is implemented in this way unless users
incorrectly combine __GFP_NOFAIL with aotmic/nowait etc.)

note, long-term we won't expose __GFP_NOFAIL any more. we
will only expose GFP_NOFAIL which enforces Blockable.  I am
quite busy on other issues, so this won't happen in a short time.

>
> > get memory. if you read the doc of __GFP_NOFAIL you will find it.
> > it is absolutely clearly documented.
> >
> > >
> > > > which might not
> > > >     be well supported by some architectures.
> > > >
> > > >     2. We could use BUG_ON to trigger a reliable system crash, avoi=
ding
> > > >     exposing NULL dereference.
> > > >
> > > > Neither option is ideal, but both are improvements over the existin=
g code.
> > > > This patch selects the second option because, with the introduction=
 of
> > > > scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct recla=
mation for
> > > > nofail users(which is in my plan), non-blockable nofail allocations=
 will
> > > > no longer be possible.
> > > >
> > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Cc: Christoph Lameter <cl@linux.com>
> > > > Cc: Pekka Enberg <penberg@kernel.org>
> > > > Cc: David Rientjes <rientjes@google.com>
> > > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Cc: Kees Cook <kees@kernel.org>
> > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  mm/page_alloc.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index d2c37f8f8d09..fb5850ecd3ae 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsi=
gned int order,
> > > >          */
> > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > >                 /*
> > > > -                * All existing users of the __GFP_NOFAIL are block=
able, so warn
> > > > -                * of any new users that actually require GFP_NOWAI=
T
> > > > +                * All existing users of the __GFP_NOFAIL are block=
able
> > > > +                * otherwise we introduce a busy loop with inside t=
he page
> > > > +                * allocator from non-sleepable contexts
> > > >                  */
> > > > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask)=
)
> > > > -                       goto fail;
> > > > +               BUG_ON(!can_direct_reclaim);
> > >
> > > I'm not in favor of using BUG_ON() here, as many call sites already
> > > handle the return value of __GFP_NOFAIL.
> > >
> >
> > it is not correct to handle the return value of __GFP_NOFAIL.
> > if you check the ret, don't use __GFP_NOFAIL.
>
> If so, you have many code changes to make in the linux kernel ;)
>

Please list those code using __GFP_NOFAIL and check the result
might fail, we should get them fixed. This is insane. NOFAIL means
no fail.

> >
> > > If we believe BUG_ON() is necessary, why not place it at the beginnin=
g
> > > of __alloc_pages_slowpath() instead of after numerous operations,
> > > which could potentially obscure the issue?
> >
> > to some extent I agree with you. but the point here is that we might
> > want to avoid this check in the hot path. so basically, we check when
> > we have to check. in 99%+ case, this check can be avoided.
>
> It's on the slow path, but that's not the main point here.

I actually recommended the approach, we can do an earlier check in the hotp=
ath.
somehow, in the previous discussion, people didn't like it.

>
> --
> Regards
> Yafang

Thanks
barry
