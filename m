Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630A523A
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723952913; cv=none; b=JmJzyaooJWNVI7ibV+FjmAs5SIUsiLtsymNguFtj6Qqr906X5ahenFifZSAbtmpc3RnX4D/9gKtc6p9Fwz2Ww5Ebfal5dU/M0hnT4WoBkM5frjb+KhOXKe05IiNmHa2itmUiB6R0CZ4MTAAbsr4g0JTqV0xBDHOp0I8PgbJu9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723952913; c=relaxed/simple;
	bh=R6EbZUQ8bYFFcyJhSnEbkcyBw5QWjreRWsDMaAhkCvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMZBkdG4EEmmSayjhSxUzY5plehQ+U/nhh5RPhixIl2j1VGrA6WDcWttTMGrWCrKw0UiJtUCIbnNG5QibU9fPqxFy9mrKjHmA+qu7EsO3+KRoUCzOksbsict9EDL7Rca5zeRw3Y9cj/E3BCePLQoRBTIIcwx2Qmg5wpLfN4d9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyEJo/dQ; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyEJo/dQ"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so1030382e0c.1
        for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723952907; x=1724557707; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnZmf45fz3PM9gKoePM/MMyRox7MihfS8oHTnz5nu7g=;
        b=WyEJo/dQKCPkqt0n3bnjYm80LbE073q43vdjpoQ4qCHz5YFc0q866IsL2RNjdwgqMR
         3hjecJ5VIHOHkYFTkQlENedKVXWCB2FKW7SJ7bYFa8nvY8ah3nwbXdMpblil4AniKVJw
         W9W7VNp/Ch8hIux7XVsux/bdgd8AbXUEKuQGmv5S2porRqhxE6PwD9qLu1BoxXIBtJsN
         TIyDQGChGG6Hah5qqWU1c8rF7iNiwAt4z/T3JZMd2o632T/8UVCkBUO3YFLBQCjYWqJI
         R4SZSCWUtINuRVYxWKng4+YGIwEr7TwmE1XVhbM+RhA8WXjEAmIAmN/wS1uiVWN1xbiD
         5mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723952907; x=1724557707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnZmf45fz3PM9gKoePM/MMyRox7MihfS8oHTnz5nu7g=;
        b=PQOuAc3D+yJbanWiU4ii4EF5OgZPSYUNrdVwsHFG63EIqBZsMZXEP2YMixt1wZJf9h
         R0K17oYFUv2r4dlAuE3NkERcAZquYdZiBSPekRqShisPAXu2mzhsbZZe0R73G5JdwASs
         nPEIr0ZNpb2OKLcFwLf4OviKsb1U5pdXRCqMQWcQA76cI8MqR4e3oxjxeJAeW6uv5pny
         xOLNau6PXJdUf5lGGV04NV3sEourUd4sF2XfGVNBFHdRdMuRMi7fv7dEVp/xd2XktnY+
         ldnn1JX+DItj8yp7gQKKd1g5fJHZbHAniUY1u0Vi7quqFLKZTHZlUCr+WeXJswJ46jE7
         Mckw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJ8fmR1X+GPGyAkHkxWMDI6P7xg+yVO91XOuyRNjxdKC1tuWa/KBiWZDlLo7TBAvrFdSxhxbK8Jny1QFQ8VsR2DgoCyZQcM1x5C9bTXY=
X-Gm-Message-State: AOJu0YyYHV02yMagSh4cPfc5NXq8WZvavkvg2d0Zqw1vuNAAt7ZyyzvA
	OO1IVsGpMcp1B18XeYWRUfs2lCN8UhCZ+UM33WTnPjW3HmNACpVdY13BgzMu6bHHXakk31zvvpg
	EQiKuEWJ7HSF+h5JKLhUQAG8FzIg=
X-Google-Smtp-Source: AGHT+IF0vb8HaZxLXeN34r97OuKqCjfQS41R6la06AtydAkWgvADr91Ik3BiUM8rwXY2Q/ljZO39IxZNuxrCJJQ4Kqk=
X-Received: by 2002:a05:6122:d04:b0:4ef:280f:96ea with SMTP id
 71dfb90a1353d-4fc6c5fef4emr8869145e0c.4.1723952907430; Sat, 17 Aug 2024
 20:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
In-Reply-To: <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Aug 2024 15:48:16 +1200
Message-ID: <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com>
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

On Sun, Aug 18, 2024 at 2:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When users allocate memory with the __GFP_NOFAIL flag, they might
> > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind of
> > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > attempt and still fail to allocate memory for these users, we have two
> > choices:
> >
> >     1. We could busy-loop and hope that some other direct reclamation o=
r
> >     kswapd rescues the current process. However, this is unreliable
> >     and could ultimately lead to hard or soft lockups,
>
> That can occur even if we set both __GFP_NOFAIL and
> __GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is related
> to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> design of __GFP_NOFAIL itself.

the point of GFP_NOFAIL is that it won't fail and its user won't check
the return value. without direct_reclamation, it is sometimes impossible.
but with direct reclamation, users constantly wait and finally they can
get memory. if you read the doc of __GFP_NOFAIL you will find it.
it is absolutely clearly documented.

>
> > which might not
> >     be well supported by some architectures.
> >
> >     2. We could use BUG_ON to trigger a reliable system crash, avoiding
> >     exposing NULL dereference.
> >
> > Neither option is ideal, but both are improvements over the existing co=
de.
> > This patch selects the second option because, with the introduction of
> > scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct reclamati=
on for
> > nofail users(which is in my plan), non-blockable nofail allocations wil=
l
> > no longer be possible.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  mm/page_alloc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index d2c37f8f8d09..fb5850ecd3ae 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned=
 int order,
> >          */
> >         if (gfp_mask & __GFP_NOFAIL) {
> >                 /*
> > -                * All existing users of the __GFP_NOFAIL are blockable=
, so warn
> > -                * of any new users that actually require GFP_NOWAIT
> > +                * All existing users of the __GFP_NOFAIL are blockable
> > +                * otherwise we introduce a busy loop with inside the p=
age
> > +                * allocator from non-sleepable contexts
> >                  */
> > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > -                       goto fail;
> > +               BUG_ON(!can_direct_reclaim);
>
> I'm not in favor of using BUG_ON() here, as many call sites already
> handle the return value of __GFP_NOFAIL.
>

it is not correct to handle the return value of __GFP_NOFAIL.
if you check the ret, don't use __GFP_NOFAIL.

> If we believe BUG_ON() is necessary, why not place it at the beginning
> of __alloc_pages_slowpath() instead of after numerous operations,
> which could potentially obscure the issue?

to some extent I agree with you. but the point here is that we might
want to avoid this check in the hot path. so basically, we check when
we have to check. in 99%+ case, this check can be avoided.

>
>
> >
> >                 /*
> >                  * PF_MEMALLOC request from this context is rather biza=
rre
> > @@ -4434,7 +4434,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned i=
nt order,
> >                 cond_resched();
> >                 goto retry;
> >         }
> > -fail:
> > +
> >         warn_alloc(gfp_mask, ac->nodemask,
> >                         "page allocation failure: order:%u", order);
> >  got_pg:
> > --
> > 2.39.3 (Apple Git-146)
> >
> >
>
>
> --
> Regards
> Yafang
