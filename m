Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2A1B1414
	for <virtualization@lists.linux.dev>; Mon,  9 Sep 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871115; cv=none; b=U4OC8PRnKozoCj+XN8BjAkVFestJrIakTnqA0Ap+WBm5WawM9mH5Adh/UvkadnZMcyJSlwD/apf7Vfq9JWZxDfctmv9V4nQLoo7QYutl11gn/EjtAPCakjDYr8oQ8695VA3SY41FpOZPYRD3/JXDnuukVJyvGV+Hm/61z5zAHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871115; c=relaxed/simple;
	bh=zVEcBD+3ykM/XDeE6mmT2VSdshOt2EblcTEOJFfHh5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR1xtx3KZTosm1l1gEch+6K/u1B312KoGNdgBWtgKw//q0AlAk5G9+eqh9TjKHFclnUMLNRe7TSrq05n5olDGuPyB1utniz1unXvc9YeIIqF4KQWT8pwxYKVQoP+AxeqMXB8vEafaw0v2M8haL1ZxOOOHkVf48A+T4GrXypEvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YttxzTkP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YttxzTkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725871112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krv/geMIzelSmSJ8w0OjsqkM55iDto6Ca93etdR5PI8=;
	b=YttxzTkPWXWZ5G5dalNeOVEMNI4hivOVGvPcjtLBsFsQq/R7ExxVBXxcqqkyZI+kRZIieL
	NVG/nELsJJNEzGcrMGfwH620ha+hbE3ve2W1tbem2PQXPXavqGRTcuBxHCQjT1yNYCrpRy
	v6uwChTb8sB5lVR9eB0B8cgaskTCMLs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-qLT32E4BMWaB8z2-Q2zj0Q-1; Mon, 09 Sep 2024 04:38:30 -0400
X-MC-Unique: qLT32E4BMWaB8z2-Q2zj0Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d8a1a63f3dso4388574a91.2
        for <virtualization@lists.linux.dev>; Mon, 09 Sep 2024 01:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871110; x=1726475910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Krv/geMIzelSmSJ8w0OjsqkM55iDto6Ca93etdR5PI8=;
        b=MXGStA5fTdC5QmQ8kk3ja4SU2XFaAm6589DfsN6nCcxstKNEHH+6PB2UCKC7awwoaG
         imTwbEJj+o/hXF3KnS3KJhiZFwiSmZ+ZRiXwE5Nqi/QuutuCz28/VxTHnaRaF34I7QQI
         jYV2mVlkyolvdosi6ljGyLBGe7RCqjKa6QzF6qQcvUN8qpok/65mBApRZRRJMlwYKiTL
         qo/noyWEosK9FsyHnOGA1nnzUWykR8oVxRjpusobr2m4kSOSQtipzMEitSTfeWIOQFOR
         r4FzzjKAGlH5V2F9fCrCRA75qXNOqVKfvoCgGM0RSnWj2lOufK0FFXzwz2tpDLK2/r0Y
         cGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfIiub2T7UOSZ21m5lkjOtvOWkkOXbCzeg4EKYkFMU/XffkRFlPKfT5CWuKOAZ78+xFYrFKMXsysBKOOVwDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNCVwTMkcpEofzrKyegnX3kNYk1VGSR1MKuCqLMv7y0U8DMOZm
	UmclHmMHcR03leCpgSfBw/tn3aIkCZJrk7kOWdqm3i9JNxTZ4AIZaXrdQNu/CmboLIl/ZbRR8mP
	PueB3+NKDebXb8ArdKH4dAWtfwnWd5ZWmXBoHkbzGX5MZIaPyVTvo/z275MP7Y8yJTjV6IfNJPY
	X7ffvj79a1Mr+7mHcxdMsn/pjMi0VLmWscrTNbKnw=
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2dad513a8d5mr7658864a91.40.1725871109700;
        Mon, 09 Sep 2024 01:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiQYgAZQeWv5/kCTe63E0d+azPK0nA5/zjAGcSeHbPrkeYpXNNIwvTRsiLsbwJV7pYomo8GsqnxKmtZW2QW6w=
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id
 98e67ed59e1d1-2dad513a8d5mr7658840a91.40.1725871109068; Mon, 09 Sep 2024
 01:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org> <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org> <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Sep 2024 16:38:16 +0800
Message-ID: <CACGkMEt4XmMnZWEK56npxiA_QB0x48AU9fWfA63y5PHuHpLdBQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 5:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
> > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > leads to regression on VM with the sysctl value of:
> > > > >
> > > > > - net.core.high_order_alloc_disable=3D1
> > > > >
> > > > > which could see reliable crashes or scp failure (scp a file 100M =
in size
> > > > > to VM):
> > > > >
> > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beg=
inning
> > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > everything is fine. However, if the frag is only one page and the
> > > > > total size of the buffer and virtnet_rq_dma is larger than one pa=
ge, an
> > > > > overflow may occur. In this case, if an overflow is possible, I a=
djust
> > > > > the buffer size. If net.core.high_order_alloc_disable=3D1, the ma=
ximum
> > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D=
0, only
> > > > > the first buffer of the frag is affected.
> > > > >
> > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever=
 use_dma_api")
> > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a=
540c0a@oracle.com
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > >
> > > > Guys where are we going with this? We have a crasher right now,
> > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > work Xuan Zhuo just did.
> > >
> > > I think this patch can fix it and I tested it.
> > > But Darren said this patch did not work.
> > > I need more info about the crash that Darren encountered.
> > >
> > > Thanks.
> >
> > So what are we doing? Revert the whole pile for now?
> > Seems to be a bit of a pity, but maybe that's the best we can do
> > for this release.
>
> @Jason Could you review this?

I think we probably need some tweaks for this patch.

For example, the changelog is not easy to be understood especially
consider it starts something like:

"
    leads to regression on VM with the sysctl value of:

    - net.core.high_order_alloc_disable=3D1

    which could see reliable crashes or scp failure (scp a file 100M in siz=
e
    to VM):
"

Need some context and actually sysctl is not a must to reproduce the
issue, it can also happen when memory is fragmented.

Another issue is that, if we move the skb_page_frag_refill() out of
the virtnet_rq_alloc(). The function semantics turns out to be weird:

skb_page_frag_refill(len, &rq->alloc_frag, gfp);
...
virtnet_rq_alloc(rq, len, gfp);

I wonder instead of subtracting the dma->len, how about simply count
the dma->len in len if we call virtnet_rq_aloc() in
add_recvbuf_small()?

>
> I think this problem is clear, though I do not know why it did not work
> for Darren.

I had a try. This issue could be reproduced easily and this patch
seems to fix the issue with a KASAN enabled kernel.

Thanks

>
> Thanks.
>
>
> >
> >
> > > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index c6af18948092..e5286a6da863 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_=
queue *rq, u32 size, gfp_t gfp)
> > > > >         void *buf, *head;
> > > > >         dma_addr_t addr;
> > > > >
> > > > > -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)=
))
> > > > > -               return NULL;
> > > > > -
> > > > >         head =3D page_address(alloc_frag->page);
> > > > >
> > > > >         dma =3D head;
> > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet=
_info *vi, struct receive_queue *rq,
> > > > >         len =3D SKB_DATA_ALIGN(len) +
> > > > >               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > >
> > > > > +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, =
gfp)))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > >         buf =3D virtnet_rq_alloc(rq, len, gfp);
> > > > >         if (unlikely(!buf))
> > > > >                 return -ENOMEM;
> > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct vi=
rtnet_info *vi,
> > > > >          */
> > > > >         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, r=
oom);
> > > > >
> > > > > +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag=
, gfp)))
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       if (!alloc_frag->offset && len + room + sizeof(struct vir=
tnet_rq_dma) > alloc_frag->size)
> > > > > +               len -=3D sizeof(struct virtnet_rq_dma);
> > > > > +
> > > > >         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
> > > > >         if (unlikely(!buf))
> > > > >                 return -ENOMEM;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> >
>

