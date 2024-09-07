Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47AF9EC
	for <virtualization@lists.linux.dev>; Sat,  7 Sep 2024 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725678998; cv=none; b=qZtn0z4vJ6jWWnwFXWlZ6vp5bd/2x5jAYULSlhr8Iix0h7bOi5iwpVEopJBFsp3n5ucecRbcogmlk+I/JqhJepc1/GNK3tGTP+bl4b98Jpy3WGqgBqHtX5i2FntrHphXbFUICu9KZ2PTsMwXKIS4pxsVwcggYYrA6vQr3pl01Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725678998; c=relaxed/simple;
	bh=vOePgDBg1Nn9/MdMdp+jxzNIw6nOe2LkgwhjMwdKjFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QO/JXXsNFfmE5+gEZh5/Jsyc/PSo5Ao0WSMwhO4ncOvHYMF6xVqePq9EJj6F0Yn5OWWbuN9f0slnl+4ByA3mbyz5BJnwZGoNNfd00peA008rokQ0lnTu2RmfBT8DzzSxmuF6cgP4n8M0SKaQlcvPiPOo9eE7kA+qfHDhdPeEwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ald6Il5k; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ald6Il5k"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1a9b40f6b3so2928931276.1
        for <virtualization@lists.linux.dev>; Fri, 06 Sep 2024 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725678995; x=1726283795; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOePgDBg1Nn9/MdMdp+jxzNIw6nOe2LkgwhjMwdKjFM=;
        b=Ald6Il5kmn+l+hyJsfHAdBEtz8o43oTREjLFom1BsBBGnrPmIcT8WWEyzVkbjh12+l
         AOS690RfxtYdyZ8Ksy4JYj4QXbg0QEbKffOz8oak0RzPePmS7kuGQ92/74LpwLEuG+MW
         JSWbeEKnJOqDTflB6ASY3kkOUS92Oohzx7AMVgRE092JnZBJZP18ja3TCTEdxRJf55TS
         qzexAqJTvTkL6q3yO0gle4U9mvzHmeFyG+Kgurv90DRpw+z1hdXV2S/fzXeVEz4Msnmt
         Q2CNIvz8OKYs9dzsXyMorihRUjdZYgWMPs55aj0gvGTiZ3DK8yGPV4tAr9uaZtE7eQ8M
         a/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725678995; x=1726283795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOePgDBg1Nn9/MdMdp+jxzNIw6nOe2LkgwhjMwdKjFM=;
        b=Shop5DJM/mzZaT3ZehY6Pox6V9Rr0fA08f58J4IHv6mdz13LMUBNQ+S+b3BPbWcvbI
         MoE97F27yfK65ZlmjkGohpXobuH9WzdJxhEhaYQAwmd5rl0xpLW6TmQ8FRqX8GzbT9QO
         b2vcqtGTJj6GLYmP8Rfa+iVa2veyJa0qGvhkS4txvRNISaa8hOwe8g/TEwxrZaGcdCZX
         fxZfFNu0cDOabH879z60uGwJ5YI5TzwVz3sNg8+I1ICsZs+/NfewKgG2y4oJxEfW7uWb
         0jW9gYeiZSvysvM8vOiuuXG8hZYi+LvRmb99O5l8BWdxXjPOTh4UvUCFZbEHj0ircVLG
         S4bg==
X-Forwarded-Encrypted: i=1; AJvYcCXAr/TuDIIovtY8MJyilGI39NNYi6PNB4eTuOGP9pATDhiNVFov+jb0rbMfgX0KcEGGWvUqpi/pLSF/kYBUiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoS+7u5Be7fTKljFo5TXZVacsMGqtsWc4+TqDzqB0hafIrZV0K
	7dhvONThL71sGOfTNS7US+Wdf7RKQhZDfCjXVNNGlIWDJfHFoVqIz/ci0f/kA9HRdjb/SJI03dt
	8CEdo4VhU+yOLajkLmCgAjNl1WIc=
X-Google-Smtp-Source: AGHT+IEgJT/TcGf9mPlTKGK6gyliivAs2kJMdByLUCLCAAYiciJRxPeqtl/FS1znHM477NSLtXCIZOShHnwl2QfJyzs=
X-Received: by 2002:a05:6902:1145:b0:e11:7b7d:bd3a with SMTP id
 3f1490d57ef6-e1d349efc64mr5675831276.36.1725678994993; Fri, 06 Sep 2024
 20:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org> <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org> <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
 <20240906053922-mutt-send-email-mst@kernel.org> <1725615962.9178205-1-xuanzhuo@linux.alibaba.com>
 <20240906055236-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240906055236-mutt-send-email-mst@kernel.org>
From: Takero Funaki <flintglass@gmail.com>
Date: Sat, 7 Sep 2024 12:16:24 +0900
Message-ID: <CAPpodde7Bi4ewzPqPC0ZNAMdy=3LYgzUHsADZKFgGniUCRdrRg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B49=E6=9C=886=E6=97=A5(=E9=87=91) 18:55 Michael S. Tsirkin <mst@=
redhat.com>:
>
> On Fri, Sep 06, 2024 at 05:46:02PM +0800, Xuan Zhuo wrote:
> > On Fri, 6 Sep 2024 05:44:27 -0400, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
> > > On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> > > > On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > > > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@re=
dhat.com> wrote:
> > > > > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > > > > leads to regression on VM with the sysctl value of:
> > > > > > > >
> > > > > > > > - net.core.high_order_alloc_disable=3D1
> > > > > > > >
> > > > > > > > which could see reliable crashes or scp failure (scp a file=
 100M in size
> > > > > > > > to VM):
> > > > > > > >
> > > > > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at t=
he beginning
> > > > > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > > > > everything is fine. However, if the frag is only one page a=
nd the
> > > > > > > > total size of the buffer and virtnet_rq_dma is larger than =
one page, an
> > > > > > > > overflow may occur. In this case, if an overflow is possibl=
e, I adjust
> > > > > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, =
the maximum
> > > > > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disa=
ble=3D0, only
> > > > > > > > the first buffer of the frag is affected.
> > > > > > > >
> > > > > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode wh=
atever use_dma_api")
> > > > > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-=
ba164a540c0a@oracle.com
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > >
> > > > > > >
> > > > > > > Guys where are we going with this? We have a crasher right no=
w,
> > > > > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > > > > work Xuan Zhuo just did.
> > > > > >
> > > > > > I think this patch can fix it and I tested it.
> > > > > > But Darren said this patch did not work.
> > > > > > I need more info about the crash that Darren encountered.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > So what are we doing? Revert the whole pile for now?
> > > > > Seems to be a bit of a pity, but maybe that's the best we can do
> > > > > for this release.
> > > >
> > > > @Jason Could you review this?
> > > >
> > > > I think this problem is clear, though I do not know why it did not =
work
> > > > for Darren.
> > > >
> > > > Thanks.
> > > >
> > >
> > > No regressions is a hard rule. If we can't figure out the regression
> > > now, we should revert and you can try again for the next release.
> >
> > I see. I think I fixed it.
> >
> > Hope Darren can reply before you post the revert patches.
> >
> > Thanks.
> >
>
> It's very rushed anyway. I posted the reverts, but as RFC for now.
> You should post a debugging patch for Darren to help you figure
> out what is going on.
>
>

Hello,

My issue [1], which bisected to the commit f9dac92ba908, was resolved
after applying the patch on v6.11-rc6.
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219154

In my case, random crashes occur when receiving large data under heavy
memory/IO load. Although the crash details differ, the memory
corruption during data transfers is consistent.

If Darren is unable to confirm the fix, would it be possible to
consider merging this patch to close [1] instead?

Thanks.
