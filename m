Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8815B111
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069895; cv=none; b=K4zjLyje7V5dAln8HiJ1rngDYurY9U2gGv8sx0Fw/EZN/F6+hxnPFfHXRnOAD994v6WFeCSGVbU8+Jk+BlDF/FCYSv++yyErONkQJiRIVhCwK+zhcGdgzKqqNtiIB0dyjPeML01/OYYBAy/BZE7HAXIluqVG1fZaPvp6+zNQxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069895; c=relaxed/simple;
	bh=PF6fcs94BzxY6K4LfNKCVPejKExHv9UHs6fAYMmA8CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyM0Oug+m+DSMPX26e0uhdDUCY3XqY7YVTBotI1FrIs4T4hMYPs0YmXNFAVgbukag7UBeKqS6QbuX7wxYnrZvxA+UFzsPqGMrYpAvZ4goOzq1nemw+qmFMGxWPuadrhW7aLmFjq5k+SecqZiIXx0dLmzebVdMiRqwOvlcdHjXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDxvw2G6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDxvw2G6"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf953cb5d3so6900926d6.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724069892; x=1724674692; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3WXgd7jOIC9DgakPiboiUDw3XFWqCJ/GAfcLSTu3LA=;
        b=XDxvw2G686rSHQDug84G7aYzR+nNbcdHpF3LOJZyCxUlPLCdIgOMNOFtilhxsBvp60
         pxatn8WGrOY7YTbECvkB0TwDdjH5ysyivX3m7d6QE4GbK7iy4VcZm+8iYDfzsoaNNT8N
         nqbU3WG5qmV/9MUi1YUVv5TD+r9sSEdD+vdFepkkdg0SncTr9ftbFz+0Nvn3jqWyCvub
         RW8LuurEOwpH7BW82NAO7Az4qCp+5zmrifl3xX7CHuEs4UbWsq/dXcHiaHATfygCP5pS
         IQSoSg1sX5eJmtpikE+vQSFjxVCy6TLFEOd/8S641cPVQEvBcEXS/Di4VTd0xEm690um
         tGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724069892; x=1724674692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3WXgd7jOIC9DgakPiboiUDw3XFWqCJ/GAfcLSTu3LA=;
        b=i+slbrWT+FIZd9xXpv0JDZCleMReq89R37nnIlkqrzeEpCIv0p83b0z5U8KHk6m4LL
         EM+cw/P1FVnlWIb6sPohSygEunE2Zaex3EMdN/x1ueCoaD6NjXv/+YtJsgv8akbEnEVf
         NI4WtoOmk1IM99TI96W6L6HXoZWA6CdGhbIJXYX6PcM1Dj/9GpXMD90uTPT4C/snFWBX
         dR/XdMjnZFoaurcYlNnAXh618PM4HhWVkKJRMdzXvFAy/08uH+gmG0HtGT7iNV4uffHy
         DRsks6L8PRg5D8PeB/+E1D5g95jRRXRNsqXuMYe6no7LGv/ly06KXe62ciuDyumvLTHC
         GREA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Hp4a+ffOjJ1tgrwWkJebN5GaYFNRZh6+imKVXJHUqatW8uSz0MaexmYpHLn5JDOIwOBuxqji6sKtzAkKTpLzKIZAUobf43Vd8dqH33Q=
X-Gm-Message-State: AOJu0YxS2GcsYurFt1S5k6XNYUjsynJLnAHSKZ2BGGaLLj7ZXulAq7EM
	AHHfDmaprVU5yCq0/ErrUqfTkVBpAtwAaoBw6ZZiy185GQ801Lc/WwIV4c88lw2HlpIalJMHNQc
	fF6ai0lic/aVx0guxlZN1YlHqxRY=
X-Google-Smtp-Source: AGHT+IEN60bau7NvabOoijHRAzYIqifLLZmMVxSw4a2WQLNMA4HqbGgiTdnrSYlccxxg9C6eUVTTphqCRMiRyMMk+rA=
X-Received: by 2002:a05:6214:4a83:b0:6bd:7373:8c8c with SMTP id
 6a1803df08f44-6bf7cd79ea0mr122499716d6.11.1724069892067; Mon, 19 Aug 2024
 05:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka> <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
 <CAGsJ_4yS=8kXruzVxzx+u+nyXG-5OfdjxSZeq_WzyOGfpu5btw@mail.gmail.com>
 <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com>
 <CAGsJ_4yyYaPSG+aRQdFqh+Yk-gN4Ah=d7FxmUVdSU5H3Aeo7pw@mail.gmail.com>
 <CALOAHbCG=_W9rrf+hgkFYF6+1LZuEeEjpyiexu9iseGOaDJ+QA@mail.gmail.com> <ZsM2De5v06eJsiG3@tiehlicka>
In-Reply-To: <ZsM2De5v06eJsiG3@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Aug 2024 20:17:36 +0800
Message-ID: <CALOAHbDCpxV=5raOB=t8Xtnxb9fZu_uaC3TmKvY767SDRJQvPw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, hch@infradead.org, 
	iamjoonsoo.kim@lge.com, penberg@kernel.org, rientjes@google.com, 
	roman.gushchin@linux.dev, torvalds@linux-foundation.org, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:09=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 19-08-24 19:56:53, Yafang Shao wrote:
> > On Mon, Aug 19, 2024 at 6:10=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Mon, Aug 19, 2024 at 9:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > On Mon, Aug 19, 2024 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@g=
mail.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 19, 2024 at 3:50=E2=80=AFPM Michal Hocko <mhocko@su=
se.com> wrote:
> > > > > > >
> > > > > > > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
> > > > > > > > On Sat, Aug 17, 2024 at 2:25=E2=80=AFPM Barry Song <21cnbao=
@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > > > > >
> > > > > > > > > When users allocate memory with the __GFP_NOFAIL flag, th=
ey might
> > > > > > > > > incorrectly use it alongside GFP_ATOMIC, GFP_NOWAIT, etc.=
  This kind of
> > > > > > > > > non-blockable __GFP_NOFAIL is not supported and is pointl=
ess.  If we
> > > > > > > > > attempt and still fail to allocate memory for these users=
, we have two
> > > > > > > > > choices:
> > > > > > > > >
> > > > > > > > >     1. We could busy-loop and hope that some other direct=
 reclamation or
> > > > > > > > >     kswapd rescues the current process. However, this is =
unreliable
> > > > > > > > >     and could ultimately lead to hard or soft lockups,
> > > > > > > >
> > > > > > > > That can occur even if we set both __GFP_NOFAIL and
> > > > > > > > __GFP_DIRECT_RECLAIM, right?
> > > > > > >
> > > > > > > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might =
take a long
> > > > > > > time to satisfy the allocation but it will reclaim to get the=
 memory, it
> > > > > > > will sleep if necessary and it will will trigger OOM killer i=
f there is
> > > > > > > no other option. __GFP_DIRECT_RECLAIM is a completely differe=
nt story
> > > > > > > than without it which means _no_sleeping_ is allowed and ther=
efore only
> > > > > > > a busy loop waiting for the allocation to proceed is allowed.
> > > > > >
> > > > > > That could be a livelock.
> > > > > > From the user's perspective, there's no noticeable difference b=
etween
> > > > > > a livelock, soft lockup, or hard lockup.
> > > > >
> > > > > This is certainly different. A lockup occurs when tasks can't be =
scheduled,
> > > > > causing the entire system to stop functioning.
> > > >
> > > > When a livelock occurs, your only options are to migrate your
> > > > applications to other servers or reboot the system=E2=80=94there=E2=
=80=99s no other
> > > > resolution (except for using oomd, which is difficult for users
> > > > without cgroup2 or swap).
> > > >
> > > > So, there's effectively no difference.
> > >
> > > Could you express your options more clearly? I am guessing two
> > > possibilities?
> > > 1. entirely drop __GFP_NOFAIL and require all users who are
> > > using __GFP_NOFAIL to add error handlers instead?
> >
> > When the system is unstable=E2=80=94such as after reaching the maximum =
retries
> > without successfully allocating pages=E2=80=94simply failing the operat=
ion
> > might be the better option.
>
> It seems you are failing to understand the __GFP_NOFAIL semantic and you
> are circling around that. So let me repeat that for you here. Make sure
> you understand before going forward with the discussion. Feel free if
> something is not clear but please do not continue with what-if kind of
> questions.
>
> GFP_NOFAIL means that the caller has no way to deal with the allocation
> strategy. Allocator simply cannot fail the request even if that takes
> ages to succeed! To put it simpler if you have a code like
>
>         while (!(ptr =3D alloc()));
> or
>         BUG_ON(!(ptr =3D alloc()));
>
> then you should better use __GFP_NOFAIL rather than opencode the endless
> loop or the bug on for the failure.
>
> Our (page, vmalloc, kmalloc) allocators do support that node for
> allocation that are allowed to sleep. But those allocators have never
> supported and are unlikely to suppoort atomic non-failing allocations.
>
> More clear?

 * New users should be evaluated carefully (and the flag should be
 * used only when there is no reasonable failure policy) but it is
 * definitely preferable to use the flag rather than opencode endless
 * loop around allocator.

The doc has already expressed what I mean.  My question is why is that
? Why not let it loop around the allocator?

--=20
Regards
Yafang
