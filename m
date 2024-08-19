Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C315EFA4
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062249; cv=none; b=kefm3Bwu2/NDQKVsyXBjGtIyBxjV8dEAhFruQEImDfXAnbD337TXFhwHyAdN0F0daETJJuVMPXy6aRKkcUX06c0prU7JldGjLU/Pz+hwSzjIEKHrM2qunXvw5m95tkHQlydyqMoHFIthWPv1Lg7xdlC9Dm4HxCpfVToSOCuRTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062249; c=relaxed/simple;
	bh=/Qgv32xCyV6W3RM6WQmIRgAEoHSk2SHMRmILzLKTynM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX6LbbZif7JAcoQbwJI3bFwbGqk70G5xKtgUVCDAnHLZGKA0Ry91z5+i0atOF++MkW/D7FoRphO+EyOEfqq1jMdAyLfVXoZMGTG2IWrWQwW11jggGhFFVJnVnA03Ty7lBgJhgqEtYL57Fxf917tLit8ljXgX6OncFlW39HPK0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuRrw+c4; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuRrw+c4"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4ef76f04977so1353991e0c.2
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724062247; x=1724667047; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0RqpfEc0+4cjxjzidl6yIPtJMbo5w9bV40MgxVYW/0=;
        b=JuRrw+c4omOQ/d2m5+BnTYl6XdkeFqXWdxcTdIhCymU9UHqLUH0cYrIlvLSmSdwDwJ
         oFfMmBF9MPLPo2M66Uq0edBftdK3zadVQl+7Y4pwxFAUjY+QuW0856hVeOulJDk3h8id
         RVeEq3eLiP8bJcuwOSx7/QA+02DjYoVJN5kGThFxTd6/lIkTJHxy9ZVuwJWrpOoWcFAp
         ZOmSUFr7UYUj2pFrrKTwq8ZfoSSEoYY2HRDoClVLRbD0SILlR1n/mqIbh5gk1vzCcwP4
         9VntoQjsDoOiNuF5airA7T7NjCXPNVmo7rrDiVbnwwElIEA9wB9w0B/o/3OlJ+nWtVxf
         po4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062247; x=1724667047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0RqpfEc0+4cjxjzidl6yIPtJMbo5w9bV40MgxVYW/0=;
        b=RDFnrCs6RCLxpRyf4H72TZFiGzcDHCbYAu5AK11TFfVii4AdcLe3LhynjM8RzOoIdC
         AIuIdDHDJJshPRg8G+wOknBit7Idc42O/j61/6i6kxGKhj5cVsv9TWz7dETpLC/2zeCu
         Rmq+H5V30LR91bB1dcMcvLb83Ydob3P3yQvSX4eqBSnxritCNCNQmAVi9dsG8GcGivLQ
         dkRlK5FwdQtjCZ1BhUiJBQV6cagS7Yugh6fCYi3voqsdt9JWE3rnfcA7Nhm5eY56Ry32
         6yIF5wiCWumV3oLJrCkyRZCFVqzFjtzYWLgtTsb2GnMKgOw3jYH5DKehcOzOTVKzYykz
         C1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj2sBHWioynQGPcBxNmZViQKVSyDThLY90kemDEKUK9rU/jymlz0UAEJpHnt1XfgqX0Atlc/s/1X/JNs0nLQNCoGHKNNH8j3qkp3n9UIE=
X-Gm-Message-State: AOJu0Yzc+Idy/3E7+H/cujJJ03qJhdWOK+DssXRh0UiZKKirrMparZ10
	VvUT7HDGs9jRCtqbcPu7v12egHWyq49faQmgxAh86IOfNeNPgKbzv7OCJuDLhJ9I6ZKnfopR84J
	uuAhgRSZsRtz4Fuu1m9mIca6tfQg=
X-Google-Smtp-Source: AGHT+IEGt+a8G8T+r5tvO9Us9hGLofbZ4xz9Y9DYDkWNgf7+D65DfOaCXLqBujLxJDqnjRtosRiavtkGxo1uTooD16k=
X-Received: by 2002:a05:6122:3190:b0:4ec:f8f0:7175 with SMTP id
 71dfb90a1353d-4fc6c99cc45mr12788227e0c.11.1724062246760; Mon, 19 Aug 2024
 03:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka> <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
 <CAGsJ_4yS=8kXruzVxzx+u+nyXG-5OfdjxSZeq_WzyOGfpu5btw@mail.gmail.com> <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com>
In-Reply-To: <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Aug 2024 22:10:35 +1200
Message-ID: <CAGsJ_4yyYaPSG+aRQdFqh+Yk-gN4Ah=d7FxmUVdSU5H3Aeo7pw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Yafang Shao <laoar.shao@gmail.com>
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

On Mon, Aug 19, 2024 at 9:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Mon, Aug 19, 2024 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Mon, Aug 19, 2024 at 3:50=E2=80=AFPM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
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
> > > > > __GFP_DIRECT_RECLAIM, right?
> > > >
> > > > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a=
 long
> > > > time to satisfy the allocation but it will reclaim to get the memor=
y, it
> > > > will sleep if necessary and it will will trigger OOM killer if ther=
e is
> > > > no other option. __GFP_DIRECT_RECLAIM is a completely different sto=
ry
> > > > than without it which means _no_sleeping_ is allowed and therefore =
only
> > > > a busy loop waiting for the allocation to proceed is allowed.
> > >
> > > That could be a livelock.
> > > From the user's perspective, there's no noticeable difference between
> > > a livelock, soft lockup, or hard lockup.
> >
> > This is certainly different. A lockup occurs when tasks can't be schedu=
led,
> > causing the entire system to stop functioning.
>
> When a livelock occurs, your only options are to migrate your
> applications to other servers or reboot the system=E2=80=94there=E2=80=99=
s no other
> resolution (except for using oomd, which is difficult for users
> without cgroup2 or swap).
>
> So, there's effectively no difference.

Could you express your options more clearly? I am guessing two
possibilities?
1. entirely drop __GFP_NOFAIL and require all users who are
using __GFP_NOFAIL to add error handlers instead?

2. no matter if it is an unsupported case, such as, GFP_ATOMIC|
__GFP_NOFAIL, we always loop till a soft or hard lockup?

>
> >
> > >
> > > >
> > > > > So, I don't believe the issue is related
> > > > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > > > design of __GFP_NOFAIL itself.
> > > >
> > > > Care to elaborate?
> > >
> > > I've read the documentation explaining why the busy loop is embedded
> > > within the page allocation process instead of letting users implement
> > > it based on their needs. However, the complexity and numerous issues
> > > suggest that this design might be fundamentally flawed.
> >
> > I don't see "numerous issues", only two issues:
> >
> > 1. allocation size overflow with __GFP_NOFAIL
> > 2. unsupported case: __GFP_NOWAIT/ATOMIC | __GFP_NOFAIL.
> >
> > for 1, it has been a BUG to require an overflowed size to always succee=
d.
> >
> > for 2,  it is an unsupported case. we just need to hide __GFP_NOFAIL
> > and only expose GFP_NOFAIL(which definitely includes blockable) so
> > any unsupported case like vdpa will no longer occur.  I would greatly
> > appreciate it if you or someone else could take over this task, as I am
> > currently extremely busy.
> >
> > >
> > > --
> > > Regards
> > > Yafang
> >
> > Thanks
> > Barry
>
>
>
> --
> Regards
> Yafang

Thanks
Barry
