Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB531166F39
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068653; cv=none; b=JvYHBpLuFqvuT1DFJvydC/IqIq1CsOvk1oJsyzS4Oi+2mUdfFOY9KOPHMojhopGaU4rkMzbQAIuOXm9ACU0v0gu5Zja8I2s0b0c3El6yCPuB07BoG2WB8Rx/ETQMsFRtJnHCa2i2jIddfuyLPBXbX1lHo8ubxXukXwIGJV6H0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068653; c=relaxed/simple;
	bh=jmvXWWgUwiUEVQ92lccr9gSSUyO4blOb2kEr4+Bp58I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahIQxR4save8tWZcTNqjqypjUkW8VX6VGxz4v2+sgmn0sQIlnAGngxSNPY8awM2OhIux3FrP9dObQg+UddKtpq44pHlEbxaTGrA1p3+dE3HvDtCLI2qoDvB7yRgA8WROPbjenZmugt2g1cWbqLjtCH5S0FXfVj/ycqst70wk5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGBvpj1A; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGBvpj1A"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4139576276.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068650; x=1724673450; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXfL86t3Z+jcKcbaIzRv07HiHvdjxdQowzTrEPH4qKA=;
        b=VGBvpj1ALWTjMnLF1z4XActSTvaiMZx4Z4yN7K2sm1lDMPP8yEcLmrrerpuiCbnyr8
         CpRQZDpvLNFFu8oakdMicUpWW2CkTQU7pT7eQ0ysy9503kVYzgsgbWfWdXJeRPKq5sVO
         RdwX4t3HpTgXDR3MsHXJgzrxOrRH6yuNxpMjp6LDvkCiIsxeq4uGdp+N9h2XOCe74TXp
         BMrAHTlG9Fh/kzRM6B3nh2eIchLlcz1ZoKj9LJ1AyyEsn+2k3pkdsjMNRwJ64N4Crjjg
         oTmsGbEM7kqtuMDWj+pnS0lWlnicggJzDPH3uKOf8Sm9AZdDwFUaH9MrbdW8MPXY8uAh
         JCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068650; x=1724673450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXfL86t3Z+jcKcbaIzRv07HiHvdjxdQowzTrEPH4qKA=;
        b=Y738ySQhfPL2gGR3YVj0VKctk+3rlO7GdfRIy1QMQytthcllNwn2ZULVZR9ns/lcDR
         7QBwTw4X5SpqLK6UxQfWLEOcMsPBmS7R6Hr9i4fS/BmZKk5rLKEpysNzwgYsNEmMFtsZ
         niOxJVvps6EcPwtGStRr673A2kGEBw5kf7L9HGb3TGcMiI+0lyRdEbQOnhBqc5hhjM28
         PvW7ymi5mmdhqhUeaY+XbV/GcW2l8eEKVlFNaOS8QHS8PWrJf8ySuUw9gOelfhb+bjvP
         pGSzosctD81luRzaS1pyqJ73sghj68AUokJ/Pu0WMyqSJ6toTGEuzi11zHvnlmEbACAt
         T9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW0uEBMOdh+tncc5/YSqxRhcE7wvnI7d1uXqnrgHeB9d3aHlpTbfNXs1sYUi7Kf4n2Wa/RWIElgqf5MSZryyuPULSrBXCoh0TLiYa9Ex04=
X-Gm-Message-State: AOJu0YwP20vzVRQMG3J0mI2pSvdsKLInU+peCsNAKUOFK+Gpb418MgSn
	OWyHT3yXmZvrLrSndl59Z3P1vsjQ/O/gAFEz1205ZZtpmeRcw5vuuqxc4w0aLxbyZjPpDS0N77/
	M6p6aVgF1XzM96q2OMjXhJI3nxF8=
X-Google-Smtp-Source: AGHT+IE8YG5pmyFM3Gt3hUzOIz0+yzyv7VRZmBp1lKn/TW1F90p6br2E0LiamSC9AepikX1hz6cwIjxvmy9llhLFOho=
X-Received: by 2002:a05:6902:1248:b0:e0e:cd17:610a with SMTP id
 3f1490d57ef6-e1180e6b2b6mr13912288276.6.1724068649755; Mon, 19 Aug 2024
 04:57:29 -0700 (PDT)
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
 <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com> <CAGsJ_4yyYaPSG+aRQdFqh+Yk-gN4Ah=d7FxmUVdSU5H3Aeo7pw@mail.gmail.com>
In-Reply-To: <CAGsJ_4yyYaPSG+aRQdFqh+Yk-gN4Ah=d7FxmUVdSU5H3Aeo7pw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Aug 2024 19:56:53 +0800
Message-ID: <CALOAHbCG=_W9rrf+hgkFYF6+1LZuEeEjpyiexu9iseGOaDJ+QA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Barry Song <21cnbao@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
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

On Mon, Aug 19, 2024 at 6:10=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Aug 19, 2024 at 9:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Mon, Aug 19, 2024 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Mon, Aug 19, 2024 at 3:50=E2=80=AFPM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
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
> > > > > > __GFP_DIRECT_RECLAIM, right?
> > > > >
> > > > > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take=
 a long
> > > > > time to satisfy the allocation but it will reclaim to get the mem=
ory, it
> > > > > will sleep if necessary and it will will trigger OOM killer if th=
ere is
> > > > > no other option. __GFP_DIRECT_RECLAIM is a completely different s=
tory
> > > > > than without it which means _no_sleeping_ is allowed and therefor=
e only
> > > > > a busy loop waiting for the allocation to proceed is allowed.
> > > >
> > > > That could be a livelock.
> > > > From the user's perspective, there's no noticeable difference betwe=
en
> > > > a livelock, soft lockup, or hard lockup.
> > >
> > > This is certainly different. A lockup occurs when tasks can't be sche=
duled,
> > > causing the entire system to stop functioning.
> >
> > When a livelock occurs, your only options are to migrate your
> > applications to other servers or reboot the system=E2=80=94there=E2=80=
=99s no other
> > resolution (except for using oomd, which is difficult for users
> > without cgroup2 or swap).
> >
> > So, there's effectively no difference.
>
> Could you express your options more clearly? I am guessing two
> possibilities?
> 1. entirely drop __GFP_NOFAIL and require all users who are
> using __GFP_NOFAIL to add error handlers instead?

When the system is unstable=E2=80=94such as after reaching the maximum retr=
ies
without successfully allocating pages=E2=80=94simply failing the operation
might be the better option.

>
> 2. no matter if it is an unsupported case, such as, GFP_ATOMIC|
> __GFP_NOFAIL, we always loop till a soft or hard lockup?

--
Regards
Yafang
