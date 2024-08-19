Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A8166F01
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068615; cv=none; b=lKcCVwXtaa1FEScRAryreHOCTznrLZCUOWkLh4bDrSJeVrEUUbjAQb7+25ug8TSdVZKvep9mo/zbhNXXKvl5f3wc4v41Xgk8xhUTXZmuI0JoUbeu6/clAVieyvwTQrURAZg1CPywhpVNoyoZDseuLVNWGUpUqmUiTL/Cpqv1noc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068615; c=relaxed/simple;
	bh=Ig/O0otqXgRdpSg2279mMYtAOUAMSGPYrbPtnA9Px8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu6pFT1jGGzOCuLUqtTK8yYZ3FFUZ6MfBcTGJesEXRzwLFIz9Dud/V97jG/RXDUEcTE0RhbLS0Ms/GkkHFV16tM5x2sT3ZrthJNqJgJO6mWHq/LkV66WsiSUJbvporX7Wrj0CMa/uD0/g/YLNxO/nE+Eh9K2volqMOxLm5U6wCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epFp/k+k; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epFp/k+k"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b47ff8a595so20099387b3.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724068612; x=1724673412; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zax0iS3R88IPyCYGGTmSynWmp0TtBpfhEgytoqyCcIU=;
        b=epFp/k+k8VVnVQXKtIK7ReSHTuSfApj1453Tt95ZfSvz2jMZkKBPNLvMq+iCidU2Rw
         XZhLvULA3mFQi/Z37fX3L1YCf/9l56H0qI90v3/J9mB3T680lJtR90xkDF+Dmsg3CtgJ
         ekGw/Ou3u+iOtrCnHNf2Qp3snm7Tba5l9yB/eNfIN0PWgPAyd+WtoqlKY5aZ4t+JThvD
         CVUGTUMo9pdjJcmQEFlOXkohkiTq50ZkgxXfJRILZkwxwINR6m+wLJG9WLF4zFKJa+GN
         cgt7+b2tX+LeRR9uRjcvIE+7vbExuA1uiMzi3uYXnBIh1TuN5xdIXn/F5ZMhNrKOFAOT
         8hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068612; x=1724673412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zax0iS3R88IPyCYGGTmSynWmp0TtBpfhEgytoqyCcIU=;
        b=pvg4jZ7dB0mFhz2R3Ge2neunS8AiNokQdy0rw+/zGa0gGDAwu0ALsQ10Xy57Udm4UL
         3fSY10bGOu1QqnzbZS6ZwJd984BrXEIrK6hvUBiLV2u6sfglgFLyRto6J0iXQLytsU1T
         zfUlBV9eDS5ll8z8c5EELjRq7ITNQT1UZdr+oRLl6/dsNCwMp/+hJj9snXMKBrpo/8gy
         mkKBOM7CO0Pl/MfEZoUisCTng+ZNxtZZQ4j0YL8ErjKdw0Oic/ZD0YSWSoVZ3SIuwbfw
         q+UBPmTf+UnfoZ1pEeIKl4al4eeFClRRDJKPotgw8q4M7hoc7Z5cRPSTZ6Z1AHkajvDa
         euiA==
X-Forwarded-Encrypted: i=1; AJvYcCUkfmCZjBkJdtvxpL0RO+Ia8fUHlxvNyjNuuq5BzZZoGyx44OYcjn+xUMCcuilQEuFdj430PRCyXbvZikbg3yX/mIKl4UWGfGoHOisLHoo=
X-Gm-Message-State: AOJu0Yx9pyVA7a84SYEW9N0So7rJf+BqR2dciAi+7L9DchnGgsml1tpo
	SOiCSP5dFyr2y8duWJ9pRZzsMAN97jHirYB5xVsx1LlvBZxdTnaq95Z0Gu1ajMbb0eNHQ0YWaxc
	6AL95Js9vGaZXH+l7TXaUn7GMBV4=
X-Google-Smtp-Source: AGHT+IGY4+ahEENd4tqGGPEWZMtu0Zp7oltkm2wZf64KEdMR+q8B0+xoZWEsOdh01kCr1nnH4wQe9Wjx4OYI52pqXqo=
X-Received: by 2002:a05:690c:6e07:b0:699:7b60:d349 with SMTP id
 00721157ae682-6b1b823ef82mr119570727b3.11.1724068612484; Mon, 19 Aug 2024
 04:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka> <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
 <ZsMb1uU2tp6ULHtG@tiehlicka>
In-Reply-To: <ZsMb1uU2tp6ULHtG@tiehlicka>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Aug 2024 19:56:16 +0800
Message-ID: <CALOAHbD9SPvnmKfL2L_RmGiey=LeuFxRa=AzWG4fK=ZcT3tZng@mail.gmail.com>
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

On Mon, Aug 19, 2024 at 6:18=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 19-08-24 17:25:18, Yafang Shao wrote:
> > On Mon, Aug 19, 2024 at 3:50=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
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
> > > > __GFP_DIRECT_RECLAIM, right?
> > >
> > > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a l=
ong
> > > time to satisfy the allocation but it will reclaim to get the memory,=
 it
> > > will sleep if necessary and it will will trigger OOM killer if there =
is
> > > no other option. __GFP_DIRECT_RECLAIM is a completely different story
> > > than without it which means _no_sleeping_ is allowed and therefore on=
ly
> > > a busy loop waiting for the allocation to proceed is allowed.
> >
> > That could be a livelock.
> > >From the user's perspective, there's no noticeable difference between
> > a livelock, soft lockup, or hard lockup.
>
> Ohh, it very much is different if somebody in a sleepable context is
> taking too long to complete and making a CPU completely unusable for
> anything else.

__alloc_pages_slowpath
retry:
    if (gfp_mask & __GFP_NOFAIL) {
        goto retry;
    }

When the loop continues indefinitely here, it indicates that the
system is unstable. In such a scenario, does it really matter whether
you sleep or not?

>
> Please consider that asking for never failing allocation is a major
> requirement.
>
> > > > So, I don't believe the issue is related
> > > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > > design of __GFP_NOFAIL itself.
> > >
> > > Care to elaborate?
> >
> > I've read the documentation explaining why the busy loop is embedded
> > within the page allocation process instead of letting users implement
> > it based on their needs. However, the complexity and numerous issues
> > suggest that this design might be fundamentally flawed.
>
> I really fail what you mean.

I mean giving the user the option to handle the loop at the call site,
rather than having it loop within __alloc_pages_slowpath().

--
Regards
Yafang
