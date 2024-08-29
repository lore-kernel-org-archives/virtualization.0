Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5354446DC
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907110; cv=none; b=q5/oz/Ss8W6QAH63ETOmbtoYbjQ6p7x9V12yrXcom5TozitkGC8Mwvpgyl1MCZ3wve5lkX4pT28JFpgHoEpqGXjhGSvrtusbeCS4Fe51EHC8qpzpURqX7OhjTY5rb7ydL2EmexB+qy6dwKHoDKU7uFi+VNKYpTlVuiS0lE+VJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907110; c=relaxed/simple;
	bh=YhxMI0LsBfN49HvJaFYhxQofXvaG2yb/5hqsoUCqmVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc/6AuOt1b7+tns7Rjnf1dwFsCEfe1MuGo+6PHSMHGhc3ZJ2XNL1a9bWZCZMyZGQlkIA+utOZV5Kgxt7ubPrbYAGmgjRiuCIerNRjsQyG10XOWqxlE1PDds2FHcQtez22c6gtiP3ZH8oBQs4dXbug2b0FRe3DYOOjMFltf2VG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gm7jSRgM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gm7jSRgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724907107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhJ0Qjxb5tXC1uW65ocyRUhVdCNqtk3iaFeONESG9MU=;
	b=gm7jSRgM1mPG2fboXjfYqorXMbZ2vmvr39v8psHKGFQDckove72oeR+q0UUuyGSKc6TQXS
	tuJa8VhHJGGvWbaGRD4QLAZAXbOm/AsdZj2QNvskTz89YaiCpiUrsF/HJURSW6CS7LmDzd
	pHHsFuW5l5RfGg4tCzj6VVT2E5fPXjE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-jIxjxMZmNLSCoenZGjBMOw-1; Thu, 29 Aug 2024 00:51:46 -0400
X-MC-Unique: jIxjxMZmNLSCoenZGjBMOw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71447057259so299910b3a.0
        for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 21:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724907105; x=1725511905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhJ0Qjxb5tXC1uW65ocyRUhVdCNqtk3iaFeONESG9MU=;
        b=ZYVW+114GsDG/mijPGQN7OGs7XqAwR32XQMAFa9RlhCLMRNGj/Sgbcit+KPCEFu6z3
         ifagdvacQSa7JcIDrv2Ljveely/CHERBYQ8ahdVK+BmAuuVGIzCBFZHBKQUjRrjCA602
         3izLbLaFyrwBleznPk1HYm6aSkvD2CJXHJOvmqzB9s50hbJsdtYES64VD0cgYDjSb9up
         9+k4l7FNekDmY6Oi0M2pnPm9YLLLdPEYFwlyCg6Hysm7+9JFF8wwIFq+jmsFTVHFHUn7
         zcEQC9a0ynXuadxtDg1MwRODsaGQWRWADumUxctrI65VWMqo9879jaL3rOkaZGtUJmnM
         tC2g==
X-Forwarded-Encrypted: i=1; AJvYcCU6fauorm3PDC8VRwjpQXtfpTxj4asfbdph22KtJ7W6aIIAFSbT/XRzE6nuLCG9UVQRzkv/WkjXaavm7E4IcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk45ESKYCQLopXr7EYLMXB0hkAmbmFH5FhOC7AEcFKXd/YFoMf
	awcSDwhOVST7EC6sfWc6QcAKeBn0wjYAi5PspI4Sn3JUonzXr0NkO1hhXgl4Jt8qiZ+Ysyc7J9A
	My999KKYDWCZ/xk81awGsh9RjlLSYyxqH7ieS+sq/e7CjG3M67GnEkwH2Qfstm/7GVDfJgD3edk
	ncRaSeBi767L8oXXygk+FcVUbHBXvltKFF6ZkCDio=
X-Received: by 2002:a05:6a21:6711:b0:1cc:d73a:93f1 with SMTP id adf61e73a8af0-1cce10c4e32mr1346537637.42.1724907105253;
        Wed, 28 Aug 2024 21:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFetl4p/YRIvZmyYOe98zWjnjcjZE1mv3eFU10B5RS9pekPiEJe+4GFJBpmrCWROhYz8S7iCF9lMcyRsarBoUk=
X-Received: by 2002:a05:6a21:6711:b0:1cc:d73a:93f1 with SMTP id
 adf61e73a8af0-1cce10c4e32mr1346517637.42.1724907104650; Wed, 28 Aug 2024
 21:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsJ2sckV5S1nGF+MrTgScVTTuwv6PHuLZARusJsFpf58g@mail.gmail.com> <1724843499.0572476-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1724843499.0572476-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Aug 2024 12:51:31 +0800
Message-ID: <CACGkMEsNk7iYti3hSJ0EiXfusF8Kw9YEJjXFH-DApQaEY6o-cQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 7:21=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 27 Aug 2024 11:38:45 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 20, 2024 at 3:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > leads to regression on VM with the sysctl value of:
> > >
> > > - net.core.high_order_alloc_disable=3D1
> > >
> > > which could see reliable crashes or scp failure (scp a file 100M in s=
ize
> > > to VM):
> > >
> > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginni=
ng
> > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > everything is fine. However, if the frag is only one page and the
> > > total size of the buffer and virtnet_rq_dma is larger than one page, =
an
> > > overflow may occur. In this case, if an overflow is possible, I adjus=
t
> > > the buffer size. If net.core.high_order_alloc_disable=3D1, the maximu=
m
> > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D0, o=
nly
> > > the first buffer of the frag is affected.
> >
> > I wonder instead of trying to make use of headroom, would it be
> > simpler if we allocate dedicated arrays of virtnet_rq_dma=EF=BC=9F
>
> Sorry for the late reply. My mailbox was full, so I missed the reply to t=
his
> thread. Thanks to Si-Wei for reminding me.
>
> If the virtnet_rq_dma is at the headroom, we can get the virtnet_rq_dma b=
y buf.
>
>         struct page *page =3D virt_to_head_page(buf);
>
>         head =3D page_address(page);
>
> If we use a dedicated array, then we need pass the virtnet_rq_dma pointer=
 to
> virtio core, the array has the same size with the rx ring.
>
> The virtnet_rq_dma will be:
>
> struct virtnet_rq_dma {
>         dma_addr_t addr;
>         u32 ref;
>         u16 len;
>         u16 need_sync;
> +       void *buf;
> };
>
> That will be simpler.

I'm not sure I understand here, did you mean using a dedicated array is sim=
pler?

>
> >
> > Btw, I see it has a need_sync, I wonder if it can help for performance
> > or not? If not, any reason to keep that?
>
> I think yes, we can skip the cpu sync when we do not need it.

I meant it looks to me the needs_sync is not necessary in the
structure as we can call need_sync() any time if we had dma addr.

Thanks

>
> Thanks.
>
>
> >
> > >
> > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use=
_dma_api")
> > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c=
0a@oracle.com
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index c6af18948092..e5286a6da863 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queu=
e *rq, u32 size, gfp_t gfp)
> > >         void *buf, *head;
> > >         dma_addr_t addr;
> > >
> > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > -               return NULL;
> > > -
> > >         head =3D page_address(alloc_frag->page);
> > >
> > >         dma =3D head;
> > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> > >         len =3D SKB_DATA_ALIGN(len) +
> > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > >
> > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)=
))
> > > +               return -ENOMEM;
> > > +
> > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > >         if (unlikely(!buf))
> > >                 return -ENOMEM;
> > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtne=
t_info *vi,
> > >          */
> > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room)=
;
> > >
> > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gf=
p)))
> > > +               return -ENOMEM;
> > > +
> > > +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet=
_rq_dma) > alloc_frag->size)
> > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > +
> > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > >         if (unlikely(!buf))
> > >                 return -ENOMEM;
> > > --
> > > 2.32.0.3.g01195cf9f
> >
> > Thanks
> >
> > >
> >
> >
> >
>

