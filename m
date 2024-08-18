Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85610A1E
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964860; cv=none; b=RAbUVE0gtYvAAa1NabCAxmLlkvn/j4F9CnlHDWLPIYq7gjBZGtp8pAsUds03XJMyhh/0hnMnf7slWNV0nuM2E3VkV5Jx5lBGXIt6eESMZnOzT6U61ohrmspR8GUFgtJKcX9Ko0mRsw5rEkh60ak9Y1UdMjhRuGFqCy4owdm1oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964860; c=relaxed/simple;
	bh=RyF6+KmDn672m1rLf0UBoD+FPBKcm4ijwGzBAotOYCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbYMQKyCSdZwYZdMMxsCKIL5/YOUMAPCjVtWyB0TcNlrPDaZ9UB/cS43UWiZ6uaemPnT6jrCa4k2woce9uCFBWvZtl+etHVkdBLBO6/NQ7HSY3kmejEJlYrxZ9b8TjE91BM03fQ1h+bfc341eOM6HTpP5NdxiYOwvvy068dhIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URIhJ57h; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URIhJ57h"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e162df8bab4so8667276.0
        for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723964857; x=1724569657; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz/w/7aMh+rwPp/zbjE/lpS1G5EmTh/C0/ZB753IjuE=;
        b=URIhJ57hpj8p3XdMoz6r+p+w1+mrqfJCOzNeXrlNLsaYu5rKHw7qNKokI4AY8Hwfc/
         2lLzohnx6LssK2daxpEpdWMSmIh8eJdC2YK9h5HO/phAbhBICwOsSxeyeEIkEFuGaSHx
         xmARSwKCUC/WFieSJyZhgVULVFhjSw0Xayh3xDzbHaPjwY0/rWhbyWMQexNymwtXgK29
         Z+kEWCe8IGWY50J6Gbn+OH41h6DP2gMg6TiJjndlosZN4Zc+NSbsi4yPdATgTbNqqAGK
         9FA+57yyOEpDCesg0pKUgGEBcKsREn7sbK1jMOhCQmBjnY7X7sA+8V3BkIbpp47E9E0X
         PZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723964857; x=1724569657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz/w/7aMh+rwPp/zbjE/lpS1G5EmTh/C0/ZB753IjuE=;
        b=T6cRUo49Tv3OQBITSr8ZOfi+6P4HwW7nZkJbI5b+sHY9MSw/9rRp8ADRjk9EBO4cl1
         gZUH2rX7Almp6qqpYmHQxIYZmNNsky6ChxtGy3ixXORos4XgXT1t7AJCgtSYSiIw/BNh
         FAu4zyWUgm1bcT28H9ojIPmDqL5TUyxyRiH3zaVwgxO5uKg2PVUx6BcnRRthLM800/0Z
         Nk4Q84aRrWdK8gKDxngYyxVn0MxEagSEcNxqI45K/edB+QCsADpFNgPRD1X56Ox4vZ+C
         0e3RGkkyUZiNNnTkB3cEI1TQVbsmYL6HYZ4sLaKW257lpL77f2NkI5y0EFUoSsCYRnLS
         V4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXGp+bgDCH32V7WQ+M7z4cGEQ2kUcYepvdtPqqGnN4JHj5g1et+X2/CwzpJpWmKJyBiHALWpL23xk5i0Fb+rXbPM8DeFZsgBdsGraYguqY=
X-Gm-Message-State: AOJu0Yzpg2uqjihIg68jMsa3ZUylW4SZDuIyLvfI9+/vYwcY/lpuALU2
	CxL+aTHVDcaBULYOtr21hmXr0KfeSYeM14vWrstEO7gIVNC1Fka9AVtOqC+BiV7jvCAJwWvloeM
	A7KJpeVan/cx3iqt2jxplS4gt9uc=
X-Google-Smtp-Source: AGHT+IEOfwtacAGNpo2AtWA6BFDlLTMS64eflyJpNpn1WwCNEuZFsHYCTVY07cswdoiGqINujJOB8B3xP3Y1YgXRurY=
X-Received: by 2002:a25:d801:0:b0:e13:c739:5b56 with SMTP id
 3f1490d57ef6-e13c7395d0bmr5831421276.40.1723964857145; Sun, 18 Aug 2024
 00:07:37 -0700 (PDT)
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
 <CAGsJ_4zA60pQ8qS4XzoR7ZFeAw=GmA0Xbwx18pLBR-B+nO4Mjw@mail.gmail.com> <CAGsJ_4wHCtkVau=gQRowOaJEYQ4dsSFtYx0rk13cZ+A+9gmm2g@mail.gmail.com>
In-Reply-To: <CAGsJ_4wHCtkVau=gQRowOaJEYQ4dsSFtYx0rk13cZ+A+9gmm2g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 18 Aug 2024 15:07:00 +0800
Message-ID: <CALOAHbCcSqZx99zoAzRFHFKbRBXxLFWg=MCXR2-gL6i2bENuaw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
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

On Sun, Aug 18, 2024 at 2:45=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sun, Aug 18, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Sun, Aug 18, 2024 at 5:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Sun, Aug 18, 2024 at 11:48=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> > > >
> > > > On Sun, Aug 18, 2024 at 2:55=E2=80=AFPM Yafang Shao <laoar.shao@gma=
il.com> wrote:
> > > > >
> > > > > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > >
> > > > > > When users allocate memory with the __GFP_NOFAIL flag, they mig=
ht
> > > > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This=
 kind of
> > > > > > non-blockable __GFP_NOFAIL is not supported and is pointless.  =
If we
> > > > > > attempt and still fail to allocate memory for these users, we h=
ave two
> > > > > > choices:
> > > > > >
> > > > > >     1. We could busy-loop and hope that some other direct recla=
mation or
> > > > > >     kswapd rescues the current process. However, this is unreli=
able
> > > > > >     and could ultimately lead to hard or soft lockups,
> > > > >
> > > > > That can occur even if we set both __GFP_NOFAIL and
> > > > > __GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is rel=
ated
> > > > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > > > design of __GFP_NOFAIL itself.
> > > >
> > > > the point of GFP_NOFAIL is that it won't fail and its user won't ch=
eck
> > > > the return value. without direct_reclamation, it is sometimes impos=
sible.
> > > > but with direct reclamation, users constantly wait and finally they=
 can
> > >
> > > So, what exactly is the difference between 'constantly waiting' and
> > > 'busy looping'? Could you please clarify? Also, why can't we
> > > 'constantly wait' when __GFP_DIRECT_RECLAIM is not set?
> >
> > I list two options in changelog
> > 1: busy loop 2. bug_on. I am actually fine with either one. either one =
is
> > better than the existing code. but returning null in the current code
> > is definitely wrong.
> >
> > 1 somehow has the attempt to make __GFP_NOFAIL without direct_reclamati=
on
> > legal. so it is a bit suspicious going in the wrong direction.
> >
> > busy-loop is that you are not reclaiming memory you are not sleeping.
> > cpu is constantly working and busy, so it might result in a lockup, eit=
her
> > soft lockup or hard lockup.

Thanks for the clarification.
That can be avoided by a simple cond_resched() if the hard lockup or
softlockup is the main issue ;)

> >
> > with direct_reclamation, wait is the case you can sleep. it is not hold=
ing
> > cpu, not a busy loop. in rare case, users might end in endless wait,
> > but it matches the doc of __GFP_NOFAIL, never return till memory
> > is gotten (the current code is implemented in this way unless users
> > incorrectly combine __GFP_NOFAIL with aotmic/nowait etc.)
> >
>
> and the essential difference between "w/ and w/o direct_reclaim": with
> direct reclaim, the user is actively reclaiming memory to rescue itself
> by all kinds of possible ways(compact, oom, reclamation), while without
> direct reclamation, it can do nothing and just loop (busy-loop).

It can wake up kswapd, which can then reclaim memory. If kswapd can't
keep up, the system is likely under heavy memory pressure. In such a
case, it makes little difference whether __GFP_DIRECT_RECLAIM is set
or not. For reference, see the old issue:
https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/.

I believe the core issue persists, and the design of __GFP_NOFAIL
exacerbates it.

By the way, I believe we could trigger an asynchronous OOM kill in the
case without direct reclaim to avoid busy looping.

>
> > note, long-term we won't expose __GFP_NOFAIL any more. we
> > will only expose GFP_NOFAIL which enforces Blockable.  I am
> > quite busy on other issues, so this won't happen in a short time.
> >
> > >
> > > > get memory. if you read the doc of __GFP_NOFAIL you will find it.
> > > > it is absolutely clearly documented.
> > > >
> > > > >
> > > > > > which might not
> > > > > >     be well supported by some architectures.
> > > > > >
> > > > > >     2. We could use BUG_ON to trigger a reliable system crash, =
avoiding
> > > > > >     exposing NULL dereference.
> > > > > >
> > > > > > Neither option is ideal, but both are improvements over the exi=
sting code.
> > > > > > This patch selects the second option because, with the introduc=
tion of
> > > > > > scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct r=
eclamation for
> > > > > > nofail users(which is in my plan), non-blockable nofail allocat=
ions will
> > > > > > no longer be possible.
> > > > > >
> > > > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > Cc: Christoph Lameter <cl@linux.com>
> > > > > > Cc: Pekka Enberg <penberg@kernel.org>
> > > > > > Cc: David Rientjes <rientjes@google.com>
> > > > > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > Cc: Kees Cook <kees@kernel.org>
> > > > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > > > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  mm/page_alloc.c | 10 +++++-----
> > > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > index d2c37f8f8d09..fb5850ecd3ae 100644
> > > > > > --- a/mm/page_alloc.c
> > > > > > +++ b/mm/page_alloc.c
> > > > > > @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, =
unsigned int order,
> > > > > >          */
> > > > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > > > >                 /*
> > > > > > -                * All existing users of the __GFP_NOFAIL are b=
lockable, so warn
> > > > > > -                * of any new users that actually require GFP_N=
OWAIT
> > > > > > +                * All existing users of the __GFP_NOFAIL are b=
lockable
> > > > > > +                * otherwise we introduce a busy loop with insi=
de the page
> > > > > > +                * allocator from non-sleepable contexts
> > > > > >                  */
> > > > > > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_m=
ask))
> > > > > > -                       goto fail;
> > > > > > +               BUG_ON(!can_direct_reclaim);
> > > > >
> > > > > I'm not in favor of using BUG_ON() here, as many call sites alrea=
dy
> > > > > handle the return value of __GFP_NOFAIL.
> > > > >
> > > >
> > > > it is not correct to handle the return value of __GFP_NOFAIL.
> > > > if you check the ret, don't use __GFP_NOFAIL.
> > >
> > > If so, you have many code changes to make in the linux kernel ;)
> > >
> >
> > Please list those code using __GFP_NOFAIL and check the result
> > might fail, we should get them fixed. This is insane. NOFAIL means
> > no fail.

You can find some instances with grep commands, but there's no
reliable way to capture them all with a single command. Here are a few
examples:

                // drivers/infiniband/hw/cxgb4/mem.c
                skb =3D alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
                if (!skb)
                        return -ENOMEM;

        // fs/xfs/libxfs/xfs_dir2.c
        args =3D kzalloc(sizeof(*args), GFP_KERNEL | __GFP_NOFAIL);
        if (!args)
                return -ENOMEM;


--
Regards
Yafang
