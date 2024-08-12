Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F214B96D
	for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447302; cv=none; b=NbYIyf+gBNJAnaa6VrD9widnvE9fIkyxo3YxGo6vBqj80Z/L2qvn6jMpndUE40wJCr6B/TjfWaX1daxdKPWvrq+RYOAg95/StwAQ7sGAoESs39Gxcv0pI7rVvm9b3xK/9Aj6dtn7EiRuZZ2dt1Dgvy2zNQevOpTgKKf74iPa+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447302; c=relaxed/simple;
	bh=OT9Aw1LBu6ZBlsDRwoCPvZdTNUEIPR2Efs1VpLrgUCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNJcidgPoTYB2puZdQkhhQWuLi9CjaZhRNnhHeLO/Tw+Cx5KJRi4APw4ut1CLN3XmBcQNgg/mTtnsDrHVxGUKBjIZVjizDRh/gBbll8MmsBGavWdZ4VO2SqNVPha9NRaE8NwU3NnfeoL+M8HKDxmNt+f5h4y+3TbRMlOa0NfjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cAtkUnZz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cAtkUnZz"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so2659471a91.0
        for <virtualization@lists.linux.dev>; Mon, 12 Aug 2024 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723447300; x=1724052100; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc9rFMB/nIG43R05ENPWmh8znCe093RvwxOUzoaD3nc=;
        b=cAtkUnZzHrG5CIyT1HjSU9/t4qt1VG2YEzMpbGNFc0d3ceU7KHdW5kQsQgBDnFHQ0j
         J+EpCMiKSLLMoa/VpzSbNrNl2dq6U5kr137EYrz6qqhUNbKF4uDzXi/cZ4sAYrf99DeD
         ZgC0+XHswr2HFYRdy5JsSjuxEpe5TMyZNDKF6ls3+23ysH7RLwSiSYx+0WYnIByICbIu
         okIgHqhUWY5064DKP2d8ypINXA/x23cSsV/3mdBmaONUpPitEi3LKukx0v9VtsGYYrLm
         Nu4y7u9+68ap+H2wA3FmNQFjYxoUae73BbR4gRDpcy+0j9VcJhQHwJlr3sB8OzJaLDWp
         FWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723447300; x=1724052100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc9rFMB/nIG43R05ENPWmh8znCe093RvwxOUzoaD3nc=;
        b=lBXxpCNopeGURoMtCn5OmWeHgQesTBQF3Pu2Do+r4olrbAnpSsOFqd8rSmROzGA7Q2
         UXA9Na40jQDqN9DS8hpCN3BT0ZzXq7G8y3V5aKJ6wQ22gyWwAO7noF085nfWjSDOEQkd
         kHfKECX80OPFwy1cx2JpqJlhvM1p4h0VWLWPRbfmfgarlme9mLs40/sCtaSY1bCTsGfQ
         U/OtS5Ir7DksnaYVuXDpBL+qlxHC2Uko6JzLxgekdtqi9yFICEewd7F1supQey5H92F8
         F0AiODOTyg+c1VNO+v/NY5Z0QGjFYGy/qeS/bVLZh59hYcCyLzGKPbGvrDRc/CCCIo/i
         I4rA==
X-Forwarded-Encrypted: i=1; AJvYcCXBLRYs5d1xvuU+mpVTyzeo9GdZ4Ivw8DexaGE+RVI6N9IvwHJUI/09rYLiwn6OnlSKgc5K6uaJeV743kbVLiOOD13LhdbgRg0R8Vq/uKY=
X-Gm-Message-State: AOJu0YzhKWjNSYVWVLlJCSWTzPS9Kytl2+VtUp9H/YR2VCoNzbGNE2a3
	HXLPqbkeQY8c5pUj+9uuu+/IDsBfj1UscQF1QeO74s/mzWhJ4U64cD1V8BiSP8WJmRIqjtS3/+a
	vDpXlksZxdDm2dfSEC9KFhVsWqyy1oJid+45w
X-Google-Smtp-Source: AGHT+IGQ2qzReh2+VWgM62ZqUt67uGinfqCdpOyHAtZrbUjyZcrygoPn4dl3XzhRPpe+f4DRP+pSYmvPd3hj1Y2rOZA=
X-Received: by 2002:a17:90b:183:b0:2c8:f3b4:a3df with SMTP id
 98e67ed59e1d1-2d1e806a38cmr6050040a91.42.1723447300157; Mon, 12 Aug 2024
 00:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
 <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com>
 <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com> <CACGkMEsYRrzSzNHgN490TDCWFm3EG1ic_-f4F+mu9CNz4uY=iw@mail.gmail.com>
In-Reply-To: <CACGkMEsYRrzSzNHgN490TDCWFm3EG1ic_-f4F+mu9CNz4uY=iw@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 12 Aug 2024 15:21:29 +0800
Message-ID: <CACycT3tE8qb0+X6O27e0KAevA230f8bzqeXh45fHNQOB6a5agA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 3:00=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Aug 8, 2024 at 6:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Thu, Aug 8, 2024 at 10:58=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > Barry said [1]:
> > > > >
> > > > > """
> > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > > loop within non-sleepable contexts.
> > > > > ""=E2=80=9C
> > > > >
> > > > > Unfortuantely, we do that under read lock. A possible way to fix =
that
> > > > > is to move the pages allocation out of the lock into the caller, =
but
> > > > > having to allocate a huge number of pages and auxiliary page arra=
y
> > > > > seems to be problematic as well per Tetsuon [2]:
> > > > >
> > > > > """
> > > > > You should implement proper error handling instead of using
> > > > > __GFP_NOFAIL if count can become large.
> > > > > """
> > > > >
> > > > > So I choose another way, which does not release kernel bounce pag=
es
> > > > > when user tries to register usersapce bounce pages. Then we don't=
 need
> > > > > to do allocation in the path which is not expected to be fail (e.=
g in
> > > > > the release). We pay this for more memory usage but further
> > > > > optimizations could be done on top.
> > > > >
> > > > > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+=
nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6f=
cf8
> > > > > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+=
nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146=
480
> > > > >
> > > > > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bou=
nce buffer")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > >
> > > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > > Tested-by: Xie Yongji <xieyongji@bytedance.com>
> > >
> > > Thanks.
> > >
> > > >
> > > > Have tested it with qemu-storage-daemon [1]:
> > > >
> > > > $ qemu-storage-daemon \
> > > >     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=
=3Don,wait=3Doff \
> > > >     --monitor chardev=3Dcharmonitor \
> > > >     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,=
filename=3D/dev/nullb0,node-name=3Ddisk0
> > > > \
> > > >     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,nod=
e-name=3Ddisk0,writable=3Don
> > > >
> > > > [1] https://github.com/bytedance/qemu/tree/vduse-umem
> > >
> > > Great, would you want to post them to the Qemu?
> > >
> >
> > Looks like qemu-storage-daemon would not benefit from this feature
> > which is designed for some hugepage users such as SPDK/DPDK.
>
> Yes, but maybe for testing purposes like here?
>

OK for me.

Thanks,
Yongji
