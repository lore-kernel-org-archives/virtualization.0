Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE281494D8
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060772; cv=none; b=O03TuYPkMaN7W/sLxHWkOhjfGxoEozoU3Az22dGpmPjxn6YE8EASKrt0ZzXl6Farx1jaXs4Ni6tS1G6D1tAzuD5HMppb73TZbqzYQIqNz8D/vliK2Mce55Q/c0ynbY82avyzXIk2/EnoFe0+Bb+mkCGnanGQFW1BycEHXDAWOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060772; c=relaxed/simple;
	bh=pHBfcC7picVIPpDhcv625iqF7xwAimFxg9DsUR7kyIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwdzcjcCs5YlTjzcig3vMJLRhdYN3E3ZfMA4X3+kwpAdWAlN+DbU3OknJRHP1hW2E00G16J4i0+rXB7bpRIwP6oNuLD69gut6svLuu0hdTwBJ6ponbfOXCDqMiyqrsVphE096ZeDYV2nEZFPSTL+A680EHo5AIPLNossu4HIkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK/PwLPl; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK/PwLPl"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf9ac165d3so5564806d6.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724060770; x=1724665570; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXCBzcxXQZDKDh5jvG0krAECq5GkrwQb/bMSCsqxdTg=;
        b=KK/PwLPllUBxsopo+midNdLiqp6XN596KXvh+jPIREFfLyfrAQmwSWTwLCIhHCR9x1
         IGACm+jtTqMQWuitWGWA3ELb0Vk2CpUT/TjK3sMfY6GsprRROFvAh0x6TikcRXlATqAd
         nr2yX43QhFiPmGMvvpOLjKCU06DZujU8juSjXc8TsDGxKOR4OsNRE5U9g1AxqybuLAQE
         yIRu43kmLXVFyh1B40NzNCecEq47Wi2oRpv3v8zTiA8f4gRKyoXTI0AnqobwlIvmf3zP
         XqPJM2zov9EqHxEub9n2a6OBjSy3Zjyf0HK5FtNXr64NUoAxpyePg3RGyORwI8RVFUPb
         C6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060770; x=1724665570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXCBzcxXQZDKDh5jvG0krAECq5GkrwQb/bMSCsqxdTg=;
        b=RpBE/ODph2ahgTqEHsHEPDf8sEWq7bgPZKuGitmlHgL1DQcSINRhQcjICsmR4U5M2y
         DakoG5m6RayRWqzG39Hcdc3OnrKtWGqff27g5yvhDa0GDRuL16bxO7UD3edjLt7qehC0
         zIj20aqkkjdA6xyPxqp7X12EFcF71VrBfOsrjLwSjwphJJhyyfpMfwFBLHBlDZn52Hqg
         25iiTz47HdWvk23+alRNE/hvujTSOdY3bHOad15ho+RteLa4ogo9dBWx9v6pKwCUrvKi
         DbU83NBXaJRSzpCGeV4YT1ecWPoystp/5X18Sx4BTWIesUGop1djq5PaLXCj9N5NWEbX
         tV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfkUq/1kNS0QP21mpI/eDt7DvRTacfiHbf3BK7aRGdQUJzWzp0HWXbz84B7zpr64GZZP+shm7B6M15s/BGDALI3Gux25ORaUT4+mOofrQ=
X-Gm-Message-State: AOJu0Yyxw95XinptQ4H09N9vxJ+Vhc9zHaQepp4XahfjJoKM567OnLCd
	wM6UCr1ioQiov3/ILn0py6QvXUU9+lYvl/nbqcFA/JBUdJewK4MoRS9/UUNgFO/dbvS3YoKatr8
	4sds+VKz+/VbxZzhlXzu+vqQgHko=
X-Google-Smtp-Source: AGHT+IE7Pi3RcMcMogobI6rI3YXFsgqP3OWgMvEQsKsPBWROiJJfxBP7HuGKH3+n1F5ADFzhiLI0CUa0SKUPwdh9CrA=
X-Received: by 2002:a05:6214:5890:b0:6bf:9281:96b0 with SMTP id
 6a1803df08f44-6bf92819984mr60124336d6.33.1724060769602; Mon, 19 Aug 2024
 02:46:09 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4yS=8kXruzVxzx+u+nyXG-5OfdjxSZeq_WzyOGfpu5btw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 19 Aug 2024 17:45:33 +0800
Message-ID: <CALOAHbDKwmtRcowx=V9Qfk2AF5=gg6_kTZC=jfPcB7=fmd65LQ@mail.gmail.com>
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

On Mon, Aug 19, 2024 at 5:39=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Aug 19, 2024 at 9:25=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
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
> > From the user's perspective, there's no noticeable difference between
> > a livelock, soft lockup, or hard lockup.
>
> This is certainly different. A lockup occurs when tasks can't be schedule=
d,
> causing the entire system to stop functioning.

When a livelock occurs, your only options are to migrate your
applications to other servers or reboot the system=E2=80=94there=E2=80=99s =
no other
resolution (except for using oomd, which is difficult for users
without cgroup2 or swap).

So, there's effectively no difference.

>
> >
> > >
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
> I don't see "numerous issues", only two issues:
>
> 1. allocation size overflow with __GFP_NOFAIL
> 2. unsupported case: __GFP_NOWAIT/ATOMIC | __GFP_NOFAIL.
>
> for 1, it has been a BUG to require an overflowed size to always succeed.
>
> for 2,  it is an unsupported case. we just need to hide __GFP_NOFAIL
> and only expose GFP_NOFAIL(which definitely includes blockable) so
> any unsupported case like vdpa will no longer occur.  I would greatly
> appreciate it if you or someone else could take over this task, as I am
> currently extremely busy.
>
> >
> > --
> > Regards
> > Yafang
>
> Thanks
> Barry



--
Regards
Yafang
