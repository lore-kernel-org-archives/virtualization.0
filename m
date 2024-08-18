Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB01078F
	for <virtualization@lists.linux.dev>; Sun, 18 Aug 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963522; cv=none; b=tYmgc5Gwnsjv2AknPyyJxQkKMPy5Mre6p1IXFyysoHRuxyqX/OMwY2nKasmdrXLAMokjsaM1y1LGICDFl9x0uf3oQsqMAbQOF3tmZjDL3ZfbU7GsUq87rSB9LRgn0a6gEfrP0IsyMMJ99OwTUEKCqsZJyCHA+x4YZpmOoNddmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963522; c=relaxed/simple;
	bh=G/8e4kfYG1zfHJDPVLN7/+wkf/DmmVD6DEFh/4MApg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq5yoLtdfANGpEcpCKcixxeiYuJNIx4vLHRBj8LOZCXReO8bJudnq3hWPaHkRu1ESkCMNX3yyBcWiXwkkM5V/vUCYtu4u0S4GudEWkcNJCn+g59drg3YQTytCQBcY/NiD0w9LJ5lc1uePpEmoLFCXAhJGf4gTJV4AcxhglaxoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep50q3qG; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep50q3qG"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f51981b1beso1084734e0c.2
        for <virtualization@lists.linux.dev>; Sat, 17 Aug 2024 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723963519; x=1724568319; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGe0T7l9uL3Dzm+n7R4FudLcaAnAIzAU+FrtXP7P/TE=;
        b=ep50q3qGQICo6yZ4TE/1eaPnxTd/wGFssGnQO47e0p1/aS7e2Fu6a3hI8qQieiDDTW
         xHRLPKUrNZ4yF8ZiUpDb8aLqDFWufa08g7qnamJcz9KdmgBoOrlBSS8UydIxJDC5mH9m
         C5mmUwlQMTpYoN1geuwKBrOzVJXevfJFHC4DAWJU2dEtYRQW9fp75nFk6YMklmK1Rzsf
         l+kO8wcpy2XNTIF+MPWPXkP8Pxd2Rx0vtKugPSwqGaWlBLRCiiyCCMUUTxlf07hlA9Ma
         OkqaMfBRTAy2Is+PTMmpAFsWefg3Xif1LT+B3l3PIPdHTopMLq23YHSNNmeQSW2l2qqI
         k7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963519; x=1724568319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGe0T7l9uL3Dzm+n7R4FudLcaAnAIzAU+FrtXP7P/TE=;
        b=VdzMTunTUL1WFu/xIurKfeMEkcr65tNcfCcC/G9tIVqQbT7+8NDtCF596LDOfU3DYQ
         a8t57D5y7z2IMtE4m3nQNTfzPS0cERzLU1dBnd/Hh0THgMSNJRQ9ZzMT3A145nVVABDw
         PLeXFz4LsV8SQq1Jiwldf8x6xsGCofZNzOGdarVzCebP+OQ1slXThdo2LRBjQDrM4oLg
         6+lDN8eDvPPrJzgt7q/8dW7wR2fZ2Mid2zPSQVbSvrMbh7PGYNz39MWLKh9VG2A5Xw6P
         h0czUJAhBh1u4KMkeck+sZE1fDtNBzfaPzjqW2zKOquLg2SgGInaxmFt4cQSKU5WWzJl
         2iVw==
X-Forwarded-Encrypted: i=1; AJvYcCVuRYkaPHWbZ7ltGtVe7khKyabiolKO8EoqmwuqepcV8kmrGbH43WHzwzGuw+bzoOiLeaFXO9KDdYiVqi82NBhRuRT0VQaj8wAIHy9zC5Y=
X-Gm-Message-State: AOJu0Yy5LffuPtYTp490iylW4fo1sKZ1osLNHIvgIYsoWxFr+Iyk4TSE
	jEaYS8N88nD1UtofM2FO8iHWxNFaWxrfyCioPbxkeh2+zW17zv/BeWhVBAFkF6j6XqeBvfrzEWT
	/qHBcNWWgkaQ20Sm3LIEp1cYEw7k=
X-Google-Smtp-Source: AGHT+IEpxFT80QCZFL31v0q3iPKPZK65nLiPytLgDBTnvcLISCQg2QqNS0aoCVe1Zn0+UxiRUAweq1K8cq2A1j9nC2U=
X-Received: by 2002:a05:6122:2a07:b0:4f6:a85d:38b3 with SMTP id
 71dfb90a1353d-4fc6ca10d25mr9619582e0c.13.1723963519091; Sat, 17 Aug 2024
 23:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com>
 <CALOAHbBLF-Rt-RML=oOAkwW6PJDoMRTdV_6itw69xJLBrERGmQ@mail.gmail.com> <CAGsJ_4zA60pQ8qS4XzoR7ZFeAw=GmA0Xbwx18pLBR-B+nO4Mjw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zA60pQ8qS4XzoR7ZFeAw=GmA0Xbwx18pLBR-B+nO4Mjw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Aug 2024 18:45:08 +1200
Message-ID: <CAGsJ_4wHCtkVau=gQRowOaJEYQ4dsSFtYx0rk13cZ+A+9gmm2g@mail.gmail.com>
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

On Sun, Aug 18, 2024 at 6:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Sun, Aug 18, 2024 at 5:51=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Sun, Aug 18, 2024 at 11:48=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> > >
> > > On Sun, Aug 18, 2024 at 2:55=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > >
> > > > > When users allocate memory with the __GFP_NOFAIL flag, they might
> > > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.  This k=
ind of
> > > > > non-blockable __GFP_NOFAIL is not supported and is pointless.  If=
 we
> > > > > attempt and still fail to allocate memory for these users, we hav=
e two
> > > > > choices:
> > > > >
> > > > >     1. We could busy-loop and hope that some other direct reclama=
tion or
> > > > >     kswapd rescues the current process. However, this is unreliab=
le
> > > > >     and could ultimately lead to hard or soft lockups,
> > > >
> > > > That can occur even if we set both __GFP_NOFAIL and
> > > > __GFP_DIRECT_RECLAIM, right? So, I don't believe the issue is relat=
ed
> > > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > > design of __GFP_NOFAIL itself.
> > >
> > > the point of GFP_NOFAIL is that it won't fail and its user won't chec=
k
> > > the return value. without direct_reclamation, it is sometimes impossi=
ble.
> > > but with direct reclamation, users constantly wait and finally they c=
an
> >
> > So, what exactly is the difference between 'constantly waiting' and
> > 'busy looping'? Could you please clarify? Also, why can't we
> > 'constantly wait' when __GFP_DIRECT_RECLAIM is not set?
>
> I list two options in changelog
> 1: busy loop 2. bug_on. I am actually fine with either one. either one is
> better than the existing code. but returning null in the current code
> is definitely wrong.
>
> 1 somehow has the attempt to make __GFP_NOFAIL without direct_reclamation
> legal. so it is a bit suspicious going in the wrong direction.
>
> busy-loop is that you are not reclaiming memory you are not sleeping.
> cpu is constantly working and busy, so it might result in a lockup, eithe=
r
> soft lockup or hard lockup.
>
> with direct_reclamation, wait is the case you can sleep. it is not holdin=
g
> cpu, not a busy loop. in rare case, users might end in endless wait,
> but it matches the doc of __GFP_NOFAIL, never return till memory
> is gotten (the current code is implemented in this way unless users
> incorrectly combine __GFP_NOFAIL with aotmic/nowait etc.)
>

and the essential difference between "w/ and w/o direct_reclaim": with
direct reclaim, the user is actively reclaiming memory to rescue itself
by all kinds of possible ways(compact, oom, reclamation), while without
direct reclamation, it can do nothing and just loop (busy-loop).

> note, long-term we won't expose __GFP_NOFAIL any more. we
> will only expose GFP_NOFAIL which enforces Blockable.  I am
> quite busy on other issues, so this won't happen in a short time.
>
> >
> > > get memory. if you read the doc of __GFP_NOFAIL you will find it.
> > > it is absolutely clearly documented.
> > >
> > > >
> > > > > which might not
> > > > >     be well supported by some architectures.
> > > > >
> > > > >     2. We could use BUG_ON to trigger a reliable system crash, av=
oiding
> > > > >     exposing NULL dereference.
> > > > >
> > > > > Neither option is ideal, but both are improvements over the exist=
ing code.
> > > > > This patch selects the second option because, with the introducti=
on of
> > > > > scoped API and GFP_NOFAIL=E2=80=94capable of enforcing direct rec=
lamation for
> > > > > nofail users(which is in my plan), non-blockable nofail allocatio=
ns will
> > > > > no longer be possible.
> > > > >
> > > > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > > Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > Cc: Christoph Lameter <cl@linux.com>
> > > > > Cc: Pekka Enberg <penberg@kernel.org>
> > > > > Cc: David Rientjes <rientjes@google.com>
> > > > > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > > Cc: Vlastimil Babka <vbabka@suse.cz>
> > > > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > > > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > Cc: Kees Cook <kees@kernel.org>
> > > > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > > > Cc: Hailong.Liu <hailong.liu@oppo.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  mm/page_alloc.c | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > index d2c37f8f8d09..fb5850ecd3ae 100644
> > > > > --- a/mm/page_alloc.c
> > > > > +++ b/mm/page_alloc.c
> > > > > @@ -4399,11 +4399,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, un=
signed int order,
> > > > >          */
> > > > >         if (gfp_mask & __GFP_NOFAIL) {
> > > > >                 /*
> > > > > -                * All existing users of the __GFP_NOFAIL are blo=
ckable, so warn
> > > > > -                * of any new users that actually require GFP_NOW=
AIT
> > > > > +                * All existing users of the __GFP_NOFAIL are blo=
ckable
> > > > > +                * otherwise we introduce a busy loop with inside=
 the page
> > > > > +                * allocator from non-sleepable contexts
> > > > >                  */
> > > > > -               if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mas=
k))
> > > > > -                       goto fail;
> > > > > +               BUG_ON(!can_direct_reclaim);
> > > >
> > > > I'm not in favor of using BUG_ON() here, as many call sites already
> > > > handle the return value of __GFP_NOFAIL.
> > > >
> > >
> > > it is not correct to handle the return value of __GFP_NOFAIL.
> > > if you check the ret, don't use __GFP_NOFAIL.
> >
> > If so, you have many code changes to make in the linux kernel ;)
> >
>
> Please list those code using __GFP_NOFAIL and check the result
> might fail, we should get them fixed. This is insane. NOFAIL means
> no fail.
>
> > >
> > > > If we believe BUG_ON() is necessary, why not place it at the beginn=
ing
> > > > of __alloc_pages_slowpath() instead of after numerous operations,
> > > > which could potentially obscure the issue?
> > >
> > > to some extent I agree with you. but the point here is that we might
> > > want to avoid this check in the hot path. so basically, we check when
> > > we have to check. in 99%+ case, this check can be avoided.
> >
> > It's on the slow path, but that's not the main point here.
>
> I actually recommended the approach, we can do an earlier check in the ho=
tpath.
> somehow, in the previous discussion, people didn't like it.
>
> >
> > --
> > Regards
> > Yafang
>
> Thanks
> barry
