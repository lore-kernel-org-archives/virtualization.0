Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED6140E50
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060382; cv=none; b=KkyCAI9+TKJVy6KzcrWP38kN/lMOgTDhhOeh4gUhWhU+1RF37sQcw+0uQ6jM+WTm+gb0cJgqVBNdc2tsy6E/hw0UsNwtDHfX//hEn1/rIurzl3S02wMGGD0xjjxSi5AtoNxTNW7gfzq+yUDegm6ox2mKMggGDSipaSkBx5hgR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060382; c=relaxed/simple;
	bh=8NAbCnCS5XCj1Pm4fD5fjkqqoOV52Y6nZ6JYAkJZQNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3VIECh/WYKYrqTV3GtySWZsSihlBp9sMrT9nE+/8y+XUqrnh3GxdT0c462e6wLS0NaXphLdk1JS1K/q7RwRPw9jU8QUglq0s1WUXZuqF6NwP4ijGOxcdSNgrnHbURL7ElXmq2Tx8wnb4SFsLIzwb3VxVKISGNm5SMRLP0ilZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFiqh/9Q; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFiqh/9Q"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-842fe71877cso1201453241.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724060380; x=1724665180; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoSIypTkdSHgxCYznKRlFZjuPRFaRgIlgz1FV3iiul0=;
        b=TFiqh/9Q3eKiSreZEW1mGGB4Mcg1Q6Q+F+zkKY8zf/6Ro+qe3DDL+dj4vDqo4sUqAy
         8/EZxoE+ZdSRFv8JUwplPaC0F7pPSRMuo8/IvhUfn9tjcBSUSHP3c7oSaDmiDnehGcYQ
         U4Z2korfLU+X8bg6+RS42YUMfvANQ810xk9uuyOBHeaDe7WmWmYjSj1B9oLitIfM9LjW
         5XuQOPIhARE35+/jH5yJRGh5KK9049AEZAoXy9ES/7/U+yEbVwLMwuvsSjabfI9UNiDD
         LE2VwBjD/ltWzwwIVbxUL3KMHc9ktFpgc96dvrIZjaSs1SWg+atIcPIT4WGJDepdBHPB
         PR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060380; x=1724665180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoSIypTkdSHgxCYznKRlFZjuPRFaRgIlgz1FV3iiul0=;
        b=NwU2rPPEv3BjWZedF/qf9Cf6I0oZqOXYmLmbMdG0yzvyJhQyJaK9l7JTdb4ARlXodx
         AtJOaOLCDRdsChwivRM/fW2BlIVfzbM9uM8f7AwntPbHvwb3xhoc1p6QmkvdvPfQSoQ/
         KlIHVe1fCBZIwRc9miZvFPJtskPExEoiS5ljLoO69+zJS/50RUkfZ/NGvzYOyGRzG68e
         CauXRB+P4tIHIQw3tX1k+kAZApYOUGgcXFv9/8qv5IcMeaQNEtRRegVba9vgRZvZ55ti
         26MOFmNsXDSYIYOYcG5m7/veJLJZEcqbI764hmYVFSX0EN5FqySuIQn9+XL9IdEWZMEa
         Zxcw==
X-Forwarded-Encrypted: i=1; AJvYcCUbo5CpRoQgSp6C5Hi6/ZPM452qXQWuZXxpL5k0ZCjQYJcI4O29RI/fvF+uRQbt6Rc14oqGn+bAwqz21gvKaZzdXtoSGRZ0Yxib0voCQ1A=
X-Gm-Message-State: AOJu0Yw3Ex7cPZxTW3OAT6um8j62za3cDjfLkYZn7gNojPGdunusrJyK
	edSeOlHNfX3tOcgryThmjRE1jGyEOaazPnY0DgirjIxf9J6JKSXin23xDWfb5L5ZvJPfFoxnVHV
	moIrMHqZS34yUC/pDyTAJqINF8hM=
X-Google-Smtp-Source: AGHT+IHX29MnZ9UrMREVVXwbQctg0qwq8C2OW+jJ6hBslxhJVtXPzAUrhLdm+xUDMkzb+8FMgyYPGJC2mgagbGph09k=
X-Received: by 2002:a05:6122:d99:b0:4ed:14e:9342 with SMTP id
 71dfb90a1353d-4fc6c5c2b6fmr12295328e0c.1.1724060379834; Mon, 19 Aug 2024
 02:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <ZsL5LSK8R3B1HsR1@tiehlicka> <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
In-Reply-To: <CALOAHbBtB40Qth3k2yXM7riPaf3nxP0p4W-Ur=h2UK0BvPg4QA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 19 Aug 2024 21:39:28 +1200
Message-ID: <CAGsJ_4yS=8kXruzVxzx+u+nyXG-5OfdjxSZeq_WzyOGfpu5btw@mail.gmail.com>
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

On Mon, Aug 19, 2024 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Mon, Aug 19, 2024 at 3:50=E2=80=AFPM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > On Sun 18-08-24 10:55:09, Yafang Shao wrote:
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
> > > __GFP_DIRECT_RECLAIM, right?
> >
> > No, it cannot! With __GFP_DIRECT_RECLAIM the allocator might take a lon=
g
> > time to satisfy the allocation but it will reclaim to get the memory, i=
t
> > will sleep if necessary and it will will trigger OOM killer if there is
> > no other option. __GFP_DIRECT_RECLAIM is a completely different story
> > than without it which means _no_sleeping_ is allowed and therefore only
> > a busy loop waiting for the allocation to proceed is allowed.
>
> That could be a livelock.
> From the user's perspective, there's no noticeable difference between
> a livelock, soft lockup, or hard lockup.

This is certainly different. A lockup occurs when tasks can't be scheduled,
causing the entire system to stop functioning.

>
> >
> > > So, I don't believe the issue is related
> > > to setting __GFP_DIRECT_RECLAIM; rather, it stems from the flawed
> > > design of __GFP_NOFAIL itself.
> >
> > Care to elaborate?
>
> I've read the documentation explaining why the busy loop is embedded
> within the page allocation process instead of letting users implement
> it based on their needs. However, the complexity and numerous issues
> suggest that this design might be fundamentally flawed.

I don't see "numerous issues", only two issues:

1. allocation size overflow with __GFP_NOFAIL
2. unsupported case: __GFP_NOWAIT/ATOMIC | __GFP_NOFAIL.

for 1, it has been a BUG to require an overflowed size to always succeed.

for 2,  it is an unsupported case. we just need to hide __GFP_NOFAIL
and only expose GFP_NOFAIL(which definitely includes blockable) so
any unsupported case like vdpa will no longer occur.  I would greatly
appreciate it if you or someone else could take over this task, as I am
currently extremely busy.

>
> --
> Regards
> Yafang

Thanks
Barry
