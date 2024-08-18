Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CD12B8B
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723965955; cv=none; b=sfFyWgCYYOuQ297hp1i8JejYdHNh3Cmht4krt0UiOnOrHrbN0b580f/u+tcjLiGO8HLxpBTRLiiG1rArSVj2ucbInKMPI0NF6IAplUsZwj0mqDxMvXwZLINQRZ2Ukvq5CwXfGnQB+g5rogl1BXSQnWd9Z0DDhZV5rrNSSlbEK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723965955; c=relaxed/simple;
	bh=fTE9DJ/u1QnoWBifXsyhPLm0u49dURZFXgfRtfrvfEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iduDPUuptYz5PyfJqdts3+tUZzTmQ2bALn4S6xb+jMrTYq4CMg7SrGWQ41uLJolGh9Z8vWmJjeQPeR5wnjhU8IH7bkqpQvdpcr8R9RdVqN9hwsJAsjKvGxIQS6e+bpRHC1BolGr/Mh+YZ3+czVTrozDfEnL64hXiB9SmIaEm1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqh7pdJC; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqh7pdJC"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4928d2f45e2so1248952137.0
        for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723965952; x=1724570752; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXtP4/WEv92yt6xLcDqe/+8SUllrIBXiXRv3KjbK2ZE=;
        b=Rqh7pdJC17C5rFdQ5XiBQPR2pLQrjSJa7D9h0erKdsh4HJLed79vlKSyiSSV1O8mIH
         3noEF9/zFszXuIxul18f1YGyvmVajWTAkTs4TX2H7IT4uEYAlYRjQmP8FCEUXAh5Sig1
         2QLNaSxYEgzQeE41e1MWsNQfLk7eYmJo8ATvrVWh2aGa/gHHCqmlcbuy1qVbG+63t/oF
         gxX1IhMQOwh9WzJgX3lQi4cmktBY6mXkli5HjSjn0UiDPn7e6H3US240zQNEI/6PXeiK
         ZhGwljQ8jhX1LFrEPBaSpZCbR0ACS6Y6vPQkM9WipGYGjptF5bvb0qjH4bN9rOBdNJE4
         B+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723965952; x=1724570752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXtP4/WEv92yt6xLcDqe/+8SUllrIBXiXRv3KjbK2ZE=;
        b=sv52VsnrIDcQptmZeB6OxjSujssfDBTZe8dJvKijSEJnh6w88GwdQTvhJEdwYpIuB0
         layNxEomm4NQUHbeVY3NPJ2d+t6BACZs/6hMCH4YcwqkEIrQcNZo1IUrDyx8ykSx+abL
         tIG0LmWt2CY5c2c2ddBOviynl/slsBqxHaKCZXj2COUBfiBiMysrKT6NEWTGYbBMLkWj
         8G4mF87vLofO99Vjj0T5I8ptCqDixRfC3U6U8RMHd+PnXMPtIxh/OTpz0Hh+GhIlgpn3
         0ah//aAI+ZDGrJpjBVts4w6W6N3sDcjEmfv2U946X8dzQBxGjCkLLgNWcIlKTAxpAbxo
         ww/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJTAyjBwld2IP9VHMS8bc1NnzXIPD4nCnDfO48aW5GjcCm/8L74KrOHL2osmGaRMArl0xaQhTlPPPbC+/XrLeZ2zh6JrsL85Cdniyo+aQ=
X-Gm-Message-State: AOJu0Yxrk/0JF7fgLNE4YG9aq8NN5ex0JuDaAV4xJoog0NRp5uRskV4D
	QIc6ZPoddlR65aV2CA3lv+jpXLkOQkNoUrzuK1KYUm8kctHMFi6OBB/m3ak6z8OSPU+9GpIXl8t
	pXxEqx/ZQj/HOiJuDtPKulgTCnAw=
X-Google-Smtp-Source: AGHT+IEfLK7kifIa+xsC79U/+rehka1BNayB+GioKQk7e69mcx/NsQvfkvbjBPjAC0Su+YovhxbLKk7WOQvGnWTGw3g=
X-Received: by 2002:a05:6102:32d1:b0:48f:e4b0:81b4 with SMTP id
 ada2fe7eead31-497798c3793mr9946848137.7.1723965952235; Sun, 18 Aug 2024
 00:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com>
 <CALOAHbBLF-Rt-RML=oOAkwW6PJDoMRTdV_6itw69xJLBrERGmQ@mail.gmail.com>
 <CAGsJ_4zA60pQ8qS4XzoR7ZFeAw=GmA0Xbwx18pLBR-B+nO4Mjw@mail.gmail.com>
 <CAGsJ_4wHCtkVau=gQRowOaJEYQ4dsSFtYx0rk13cZ+A+9gmm2g@mail.gmail.com> <CALOAHbCcSqZx99zoAzRFHFKbRBXxLFWg=MCXR2-gL6i2bENuaw@mail.gmail.com>
In-Reply-To: <CALOAHbCcSqZx99zoAzRFHFKbRBXxLFWg=MCXR2-gL6i2bENuaw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Aug 2024 19:25:40 +1200
Message-ID: <CAGsJ_4xcahtYsAso3rVkJuYyas9dTd8C+0RCyHcdPJjvpJkG0Q@mail.gmail.com>
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

On Sun, Aug 18, 2024 at 7:07=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sun, Aug 18, 2024 at 2:45=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Sun, Aug 18, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Sun, Aug 18, 2024 at 5:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Sun, Aug 18, 2024 at 11:48=E2=80=AFAM Barry Song <21cnbao@gmail.=
com> wrote:
> > > > >
> > > > > On Sun, Aug 18, 2024 at 2:55=E2=80=AFPM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > >
> > > > > > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gma=
il.com> wrote:
> > > > > > >
> > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > >
> > > > > > > When users allocate memory with the __GFP_NOFAIL flag, they m=
ight
> > > > > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  Th=
is kind of
> > > > > > > non-blockable __GFP_NOFAIL is not supported and is pointless.=
  If we
> > > > > > > attempt and still fail to allocate memory for these users, we=
 have two
> > > > > > > choices:
> > > > > > >
> > > > > > >     1. We could busy-loop and hope that some other direct rec=
lamation or
> > > > > > >     kswapd rescues the current process. However, this is unre=
liable
> > > > > > >     and could ultimately lead to hard or soft lockups,
> > > > > >
> > > > > > That can occur even if we set both __GFP_NOFAIL and
> > > > > > __GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is r=
elated
> > > > > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flaw=
ed
> > > > > > design of __GFP_NOFAIL itself.
> > > > >
> > > > > the point of GFP_NOFAIL is that it won't fail and its user won't =
check
> > > > > the return value. without direct_reclamation, it is sometimes imp=
ossible.
> > > > > but with direct reclamation, users constantly wait and finally th=
ey can
> > > >
> > > > So, what exactly is the difference between 'constantly waiting' and
> > > > 'busy looping'? Could you please clarify? Also, why can't we
> > > > 'constantly wait' when __GFP_DIRECT_RECLAIM is not set?
> > >
> > > I list two options in changelog
> > > 1: busy loop 2. bug_on. I am actually fine with either one. either on=
e is
> > > better than the existing code. but returning null in the current code
> > > is definitely wrong.
> > >
> > > 1 somehow has the attempt to make __GFP_NOFAIL without direct_reclama=
tion
> > > legal. so it is a bit suspicious going in the wrong direction.
> > >
> > > busy-loop is that you are not reclaiming memory you are not sleeping.
> > > cpu is constantly working and busy, so it might result in a lockup, e=
ither
> > > soft lockup or hard lockup.
>
> Thanks for the clarification.
> That can be avoided by a simple cond_resched() if the hard lockup or
> softlockup is the main issue ;)

Is your point to legitimize the combination of gfp_nofail and non-lockable?
I don't think you can simply fix the lockup. A direct example is
single-core, and preemptible kernel. you are calling __gfp_nofail without
direct reclamation in a spinlock,  cond_resched() will do nothing.

it doesn't have to be a single core, for example on phones, cpu hotplug is
used to save power. Sometimes, phones unplug lots of cpus to save
power. and even we are multiple cores, we have cpuset cgroups things
which can prevent async oom from running on other cores.

>
> > >
> > > with direct_reclamation, wait is the case you can sleep. it is not ho=
lding
> > > cpu, not a busy loop. in rare case, users might end in endless wait,
> > > but it matches the doc of __GFP_NOFAIL, never return till memory
> > > is gotten (the current code is implemented in this way unless users
> > > incorrectly combine __GFP_NOFAIL with aotmic/nowait etc.)
> > >
> >
> > and the essential difference between "w/ and w/o direct_reclaim": with
> > direct reclaim, the user is actively reclaiming memory to rescue itself
> > by all kinds of possible ways(compact, oom, reclamation), while without
> > direct reclamation, it can do nothing and just loop (busy-loop).
>
> It can wake up kswapd, which can then reclaim memory. If kswapd can't
> keep up, the system is likely under heavy memory pressure. In such a
> case, it makes little difference whether __GFP_DIRECT_RECLAIM is set
> or not. For reference, see the old issue:
> https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com=
/.
>
> I believe the core issue persists, and the design of __GFP_NOFAIL
> exacerbates it.
>
> By the way, I believe we could trigger an asynchronous OOM kill in the
> case without direct reclaim to avoid busy looping.

This async oom is sometimes impossible with the same reason as
the above example.

>
> >
> > > note, long-term we won't expose __GFP_NOFAIL any more. we
> > > will only expose GFP_NOFAIL which enforces Blockable.  I am
> > > quite busy on other issues, so this won't happen in a short time.
> > >
> > > >
> > > > > get memory. if you read the doc of __GFP_NOFAIL you will find it.
> > > > > it is absolutely clearly documented.
> > > > >
> > > > > >
> > > > > > > which might not
> > > > > > >     be well supported by some architectures.
> > > > > > >
> > > > > > >     2. We could use BUG_ON to trigger a reliable system crash=
, avoiding
> > > > > > >     exposing NULL dereference.
> > > > > > >
> > > > > > > Neither option is ideal, but both are improvements over the e=
xisting code.
> > > > > > > This patch selects the second option because, with the introd=
uction of
> > > > > > > scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct=
 reclamation for
> > > > > > > nofail users(which is in my plan), non-blockable nofail alloc=
ations will
> > > > > > > no longer be possible.
> > > > > > >
> > > > > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > > > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > > > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > > Cc: Christoph Lameter <cl@linux.com>
> > > > > > > Cc: Pekka Enberg <penberg@kernel.org>
> > > > > > > Cc: David Rientjes <rientjes@google.com>
> > > > > > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > > > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > > Cc: Kees Cook <kees@kernel.org>
> > > > > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > > > > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  mm/page_alloc.c | 10 +++++-----
> > > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > > >
> > > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > > index d2c37f8f8d09..fb5850ecd3ae 100644
> > > > > > > --- a/mm/page_alloc.c
> > > > > > > +++ b/mm/page_alloc.c
> > > > > > > @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask=
, unsigned int order,
> > > > > > >          */
> > > > > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > > > > >                 /*
> > > > > > > -                * All existing users of the __GFP_NOFAIL are=
 blockable, so warn
> > > > > > > -                * of any new users that actually require GFP=
_NOWAIT
> > > > > > > +                * All existing users of the __GFP_NOFAIL are=
 blockable
> > > > > > > +                * otherwise we introduce a busy loop with in=
side the page
> > > > > > > +                * allocator from non-sleepable contexts
> > > > > > >                  */
> > > > > > > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp=
_mask))
> > > > > > > -                       goto fail;
> > > > > > > +               BUG_ON(!can_direct_reclaim);
> > > > > >
> > > > > > I'm not in favor of using BUG_ON() here, as many call sites alr=
eady
> > > > > > handle the return value of __GFP_NOFAIL.
> > > > > >
> > > > >
> > > > > it is not correct to handle the return value of __GFP_NOFAIL.
> > > > > if you check the ret, don't use __GFP_NOFAIL.
> > > >
> > > > If so, you have many code changes to make in the linux kernel ;)
> > > >
> > >
> > > Please list those code using __GFP_NOFAIL and check the result
> > > might fail, we should get them fixed. This is insane. NOFAIL means
> > > no fail.
>
> You can find some instances with grep commands, but there's no
> reliable way to capture them all with a single command. Here are a few
> examples:
>
>                 // drivers/infiniband/hw/cxgb4/mem.c
>                 skb =3D alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
>                 if (!skb)
>                         return -ENOMEM;
>

Thanks for pointing out this wrong code.

This is absolutely wrong. with GFP_KERNEL | __GFP_NOFAIL,
mm-core is doing endless retry till direct reclamation gives
memory to itself. there is no possibility to return NULL.

the only possibility is __GFP_NOFAIL | GFP_ATOMIC(NOWAIT),
mm-core is returning NULL incorrectly. actually mm-core just ignores
this __GFP_NOFAIL in this case. with GFP_FAIL enforcing
direct_reclamation done, the wrong case __GFP_NOFAIL |
GFP_ATOMIC(NOWAIT) will no longer exist.

>         // fs/xfs/libxfs/xfs_dir2.c
>         args =3D kzalloc(sizeof(*args), GFP_KERNEL | __GFP_NOFAIL);
>         if (!args)
>                 return -ENOMEM;
>
>
> --
> Regards
> Yafang
