Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186BD282
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906498; cv=none; b=U0dxSsWN+3F5MEZE4TuHSqSrJ0Bdo53uFV1dPJey9a9TKfp8mCBDXB35LbijRDbBLxcrq4OoMtz2ScuEnVASvgc4UnW/U+gMlo3FlRGx3wFUAt2snqUs9KeJ8M1kJprQVJAi5vc7X6Fi/0z0h5e2CJ9H/ob5zg5o+0GyCc9mywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906498; c=relaxed/simple;
	bh=7E8E53K2VKxfUU8hm5+y8DQdxN4b4jDzMb6j3B0gODo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJPFOlz4s+C8LLnyuWSYbmp11tj6ABgJGg9U4D77RCXnzLPqVSSMrfhrZqVdHsSjzMBmd7UZc299Cxka9CdKtthXKAYAnVky/XXyElDL2fGbuz0RbSxzJpSlWjSTMj3ppyCouxt6BRYk+cOVyna6nbkyLrjc1oa24uflH2nZrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Io8sGADF; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io8sGADF"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F45E60A74
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 06:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F45E60A74
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Io8sGADF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CKsgqiq_cQUf
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 06:54:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B085360592
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 06:54:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B085360592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705906494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvL0EYk0yA8VZbOmPDp1AqJR4YUQln1x+o2jxPOvKjI=;
	b=Io8sGADFjBccMs4DsJxNUNl9RH/WT2DjWJFsMVYi1mRSyHBK0UAclQ7vyQS+7iklaCzljU
	oBu2T14effK830Yrr3E4VHYoeWNsdcj44qnV94MM75velRycxrn8nzCrRt9f4Vr70IvnBf
	OsPQXvcal+xo8DC7odfdycElUKSu5mM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ilVFP4A7MpCiqQjBuP4Jug-1; Mon, 22 Jan 2024 01:54:52 -0500
X-MC-Unique: ilVFP4A7MpCiqQjBuP4Jug-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd97c17091so4029625b6e.3
        for <virtualization@lists.linux-foundation.org>; Sun, 21 Jan 2024 22:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705906492; x=1706511292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvL0EYk0yA8VZbOmPDp1AqJR4YUQln1x+o2jxPOvKjI=;
        b=YwjKPmuS9YUwBvoRW4RZLEpXjuRXWXB5gLHtwb0JrYGludiP2C1kzreEsHjRxeHkrR
         neU6MyckDwYme3XlZuJPhmE7w1XuhFKuc8RaB2l91kJDsjvx2Pk49Ge3qZrVVWmkmHvg
         hDMQmTwGzq2kdCagwtA4IZW62LNP2XjT0K7z2fmeZVHQj/i7wuZUpAP6RGm/w31gP/tw
         lE69ZDU6P2Hi//EOcL/Ms9KLOrJeRPXDyUCLSG4yX4NDNo7iaiA4qsrAvMXRZ+hyoNdp
         YJz+kgyKgQ0alJsQPTU89Spsqrfn5SkKay+ZFGof4byP5NXhaHaWmiEJlW29tjkCk3I9
         HaHw==
X-Gm-Message-State: AOJu0Ywz196Gh5z7zc7x58H0s1QkBwue2hM/zacPuWGj624666UHWXTy
	dPVXT4RmK1atANkTf4kSF/Rdlfx/mi3Hq78k9derSpMRrEuAM298DQHiLCFlEVVnGBPAZivFbfs
	GT038HZATn1ASR27hXXht3OY491xuSZXOiZElIcw3QXTzTLyO8AxTPqEDTEhyko/FWte4YGlEC4
	eC+99Nioaz3FnwM5eOhrmE3B3y8v4siJz9fDWsJx0jpZSVVpHhX7NJJg==
X-Received: by 2002:a05:6808:21a0:b0:3bc:25c4:d85f with SMTP id be32-20020a05680821a000b003bc25c4d85fmr5424218oib.74.1705906492069;
        Sun, 21 Jan 2024 22:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ8nvL3dGIQKuKlrjshwdncUFX/FxBnfNVdQigOwtAGbOH4UeeQB6L5XfmdlUoZquf1YQ7U/anP2pr+KQ9PzI=
X-Received: by 2002:a05:6808:21a0:b0:3bc:25c4:d85f with SMTP id
 be32-20020a05680821a000b003bc25c4d85fmr5424214oib.74.1705906491848; Sun, 21
 Jan 2024 22:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
 <20231229073108.57778-7-xuanzhuo@linux.alibaba.com> <CACGkMEvaTr1iT1M7DXN1PNOAZPM75BGv-wTOkyqb-7Sgjshwaw@mail.gmail.com>
 <1705390340.4814627-3-xuanzhuo@linux.alibaba.com> <CACGkMEuo7m82cTxFSeryyYemMP8AgeKgE6kKYqoFGChTZ7KNWA@mail.gmail.com>
 <1705903444.5368986-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705903444.5368986-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 14:54:39 +0800
Message-ID: <CACGkMEsYs3zKVNxzDMtAHZKAUEFppxBvWb0LMGDWVMwQqvX83Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/27] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:12=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 22 Jan 2024 12:18:51 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 16, 2024 at 3:47=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 11 Jan 2024 16:34:09 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Dec 29, 2023 at 3:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info whe=
n
> > > > > get buf from virtio core for premapped mode.
> > > > >
> > > > > If the virtio queue is premapped mode, the virtio-net send buf ma=
y
> > > > > have many desc. Every desc dma address need to be unmap. So here =
we
> > > > > introduce a new helper to collect the dma address of the buffer f=
rom
> > > > > the virtio core.
> > > > >
> > > > > Because the BAD_RING is called (that may set vq->broken), so
> > > > > the relative "const" of vq is removed.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 174 +++++++++++++++++++++++++----=
------
> > > > >  include/linux/virtio.h       |  16 ++++
> > > > >  2 files changed, 142 insertions(+), 48 deletions(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 51d8f3299c10..1374b3fd447c 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -362,6 +362,45 @@ static struct device *vring_dma_dev(const st=
ruct vring_virtqueue *vq)
> > > > >         return vq->dma_dev;
> > > > >  }
> > > > >
> > > > > +/*
> > > > > + *     use_dma_api premapped -> do_unmap
> > > > > + *  1. false       false        false
> > > > > + *  2. true        false        true
> > > > > + *  3. true        true         false
> > > > > + *
> > > > > + * Only #3, we should return the DMA info to the driver.
> > > >
> > > > Btw, I guess you meant "#3 is false" here?
> > > >
> > > > And could we reduce the size of these 3 * 3 matrices? It's usually =
a
> > > > hint that the code is not optmized.
> > >
> > > On the process of doing dma map, we force the (use_dma_api, premapped=
).
> > >
> > > if premapped:
> > >      virtio core skip dma map
> > > else:
> > >         if use_dma_api:
> > >                 do dma map
> > >         else:
> > >                 work with the physical address.
> > >
> > > Here we force the (premapped, do_unmap).
> > >
> > > do_unmap is an optimization. We just check this to know should we do =
dma unmap
> > > or not.
> > >
> > > Now, we introduced an new case, when the virtio core skip dma unmap,
> > > we may need to return the dma info to the driver. That just occur whe=
n
> > > the (premapped, do_unmap) is (true, false). Because that the (premmap=
ed,
> > > do_unmap) may be (false, false).
> > >
> > > For the matrices, I just want to show where the do_unmap comes from.
> > > That is a optimization, we use this many places, not to check (use_dm=
a_api,
> > > premapped) on the process of doing unmap. And only for the case #3, w=
e should
> > > return the dma info to drivers.
> >
> > Ok, it tries to ease the life of the readers.
> >
> > I wonder if something like
> >
> > bool virtqueue_needs_unmap() can help, it can judge based on the value
> > of use_dma_api and premapped.
>
>
> I think not too much.
>
> Because do_unmap is for this.
>
>
>
> +static bool vring_need_unmap(struct vring_virtqueue *vq,
> +                            struct virtio_dma_head *dma,
> +                            dma_addr_t addr, unsigned int length)
> +{
> +       if (vq->do_unmap)
> +               return true;
>
> Before this, we is to judge whether we should do unmap or not.
> After this, we is to judge whehter we should return dma info to driver or=
 not.
>
> If you want to simplify this function, I will say no.
>
> If you want to replace "do_unmap" with virtqueue_needs_unmap(), I will sa=
y ok.

That's my point.

> But I think we donot need to do that.

Just a suggestion, and you can move the comment above there.

Thanks

>
> +
> +       if (!vq->premapped)
> +               return false;
> +
> +       if (!dma)
> +               return false;
> +
> +       if (unlikely(dma->next >=3D dma->num)) {
> +               BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u=
\n",
> +                        &addr, length);
> +               return false;
> +       }
> +
> +       dma->items[dma->next].addr =3D addr;
> +       dma->items[dma->next].length =3D length;
> +
> +       ++dma->next;
> +
> +       return false;
> +}
>
>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > >
> >
>

