Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918623AD
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723960304; cv=none; b=hqPwFICWJRlkLK9ort+HLrsDXnaKeUl0ytTewtmUAPqumeJQ2n3+LemJt0CoVhUgbKxXnds+wcFFGmvDmX38hxpN+JXjGAWF3eFNHP09DPUsZ0bXaLc2X6Xe+voe6CFzfJ4EX5PeSBVpxK8RflvESidejljcb+4Q/AIvGOL86Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723960304; c=relaxed/simple;
	bh=dJLtz3NuhenJP6+qSOGG1szfDV1WCv40CayRoRrJB9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJSUW9HjkKbvac20r0G0nhEY+Fkc08f2zLDQ3ilkRiJfXRjYvmYzrDV2d3hoX9zJh4V79vYl3C8Kpz5VNNvGbx9nfkPPR3Scvnd4E0sLAqZI0XSrwsJAkPQsKU/9o1RqtG0N9XTL0GcHlkKQehQAmmABYNUmAui/s5uLb4xBjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3gbdO6L; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3gbdO6L"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5c324267aso1967643eaf.0
        for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 22:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723960301; x=1724565101; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIHCMVLYSWDGTFiX/5gV5EGGfwfZsiyvSNR7GSXZziI=;
        b=Q3gbdO6LlWEBEK+Gi3ZI2XMPyxywwOjxdjFmbot4vI8TTaZjiw9jDnbFFcMyuspF09
         qV9VO8uo61rl3HwbdldcF/pWLb/LaYDdHUHQP7Z7A+++sGX5Quf7wJpQpbuMZc/GvkjT
         1cUoWJYs/OBHHUya5qQ4jdLDRHzPa90UKmk2GzD3mBNjuru9CRqWYTWx88+JOBY1dHIh
         6wxWxM6nIVg45DeNr0SBi3GYu4PTLCXIFbdpzarmkXmVNu25rrsalHQxqow3MH1Baob2
         y5gbdLPp08vQgaCPBLiKpAk+E5Ly+S/gU/TSMEaDIVEcKCmcSz4HkaWCl6jTTJ2h0Uri
         BCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723960301; x=1724565101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIHCMVLYSWDGTFiX/5gV5EGGfwfZsiyvSNR7GSXZziI=;
        b=ny+qcwQlYj35WFoySEkcE6WLV5yY8paE7/sOqmIzOBxQJLEaf3HM5Ns0XHzgT2h5YP
         Lx5MKC+lW7kdVZ5HT9kMiAwbINevDvN9vv61Dez9cO78t8gpnpss8pztumaGf2c18Tcl
         8/XghBPc9Kk8miZLDJ43J3GSwXoCGYodiS4/0x/cWDyQtkU+OA9jMWT91p+jS8q141Ss
         VKPMKesmLp0REBEaqiIT6DFPiWlDtqnqlvSonFRTU8t1yt8obE9OzOtgk2tP+SoceCuY
         rJ7boUfl+82HB7iaMjVE8ehukcvWx8+Ude+x+izdMyC1PsRJ2Np/OSTmBRYL2qvyNaDq
         krgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb6SQAgoyUPY2oUQKRlpBoQbXL6FD2YhI56U3hNPlF5Y+HkQqPdCJdWUbhQco9N0lCMkPVsqlPqX+dOTR33WD9tpOva3CNhMkqpSGuNjU=
X-Gm-Message-State: AOJu0YzH48syyNyoHJ5/aVVuGTKK8a9BmQCBLiH2qS1Jz/ykrWED9mbA
	F6y0cVPOd/gOjz4xiQ9q5F1eRgUK5w6b/Fpfia0dkToRLg7cTh+QsJKkV0BZRs5vkkehB7/bbdz
	enX8iv2jJlO/BQxnzD7iPVzBq3zw=
X-Google-Smtp-Source: AGHT+IH9swZscxh4sskHiB4R3YL/stqfyl/AbcynGeDKsMxPlP0B7CAHA/3mszIw/oAe1Ba8pf73ix3TeqtLAtUjnK4=
X-Received: by 2002:a05:6358:599b:b0:1ac:ed54:224d with SMTP id
 e5c5f4694b2df-1b3931a52bamr960549355d.11.1723960301160; Sat, 17 Aug 2024
 22:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com> <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 18 Aug 2024 13:51:04 +0800
Message-ID: <CALOAHbBLF-Rt-RML=oOAkwW6PJDoMRTdV_6itw69xJLBrERGmQ@mail.gmail.com>
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

On Sun, Aug 18, 2024 at 11:48=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Sun, Aug 18, 2024 at 2:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This kind =
of
> > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If we
> > > attempt and still fail to allocate memory for these users, we have tw=
o
> > > choices:
> > >
> > >     1. We could busy-loop and hope that some other direct reclamation=
 or
> > >     kswapd rescues the current process. However, this is unreliable
> > >     and could ultimately lead to hard or soft lockups,
> >
> > That can occur even if we set both __GFP_NOFAIL and
> > __GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is related
> > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > design of __GFP_NOFAIL itself.
>
> the point of GFP_NOFAIL is that it won't fail and its user won't check
> the return value. without direct_reclamation, it is sometimes impossible.
> but with direct reclamation, users constantly wait and finally they can

So, what exactly is the difference between 'constantly waiting' and
'busy looping'? Could you please clarify? Also, why can't we
'constantly wait' when __GFP_DIRECT_RECLAIM is not set?

> get memory. if you read the doc of __GFP_NOFAIL you will find it.
> it is absolutely clearly documented.
>
> >
> > > which might not
> > >     be well supported by some architectures.
> > >
> > >     2. We could use BUG_ON to trigger a reliable system crash, avoidi=
ng
> > >     exposing NULL dereference.
> > >
> > > Neither option is ideal, but both are improvements over the existing =
code.
> > > This patch selects the second option because, with the introduction o=
f
> > > scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct reclama=
tion for
> > > nofail users(which is in my plan), non-blockable nofail allocations w=
ill
> > > no longer be possible.
> > >
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Cc: Christoph Lameter <cl@linux.com>
> > > Cc: Pekka Enberg <penberg@kernel.org>
> > > Cc: David Rientjes <rientjes@google.com>
> > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Kees Cook <kees@kernel.org>
> > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  mm/page_alloc.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index d2c37f8f8d09..fb5850ecd3ae 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsign=
ed int order,
> > >          */
> > >         if (gfp_mask & __GFP_NOFAIL) {
> > >                 /*
> > > -                * All existing users of the __GFP_NOFAIL are blockab=
le, so warn
> > > -                * of any new users that actually require GFP_NOWAIT
> > > +                * All existing users of the __GFP_NOFAIL are blockab=
le
> > > +                * otherwise we introduce a busy loop with inside the=
 page
> > > +                * allocator from non-sleepable contexts
> > >                  */
> > > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > > -                       goto fail;
> > > +               BUG_ON(!can_direct_reclaim);
> >
> > I'm not in favor of using BUG_ON() here, as many call sites already
> > handle the return value of __GFP_NOFAIL.
> >
>
> it is not correct to handle the return value of __GFP_NOFAIL.
> if you check the ret, don't use __GFP_NOFAIL.

If so, you have many code changes to make in the linux kernel ;)

>
> > If we believe BUG_ON() is necessary, why not place it at the beginning
> > of __alloc_pages_slowpath() instead of after numerous operations,
> > which could potentially obscure the issue?
>
> to some extent I agree with you. but the point here is that we might
> want to avoid this check in the hot path. so basically, we check when
> we have to check. in 99%+ case, this check can be avoided.

It's on the slow path, but that's not the main point here.

--
Regards
Yafang
