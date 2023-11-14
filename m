Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5808C06
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haye2V4e"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05F8681F5C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05F8681F5C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=haye2V4e
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2IP9WNiOVcWx
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 03:26:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4942E81E14
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 03:26:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4942E81E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699932417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFcPdjy5+d+tf/+vj6et1XDBkq3V8/c7Pne4PWzJpCQ=;
	b=haye2V4e1T7CZtK8UMKHwLTCUwe+Sk/3e4k2ufz4VOKrn4qbfUkLv/trBRwjadStHhGJ4n
	D1gkhCTPlcW0+RNf83YMPgQeofASb+in4FgwTFtPcvRP7MIXy/66L+70iA1bEHKzYgthDu
	6PBskRNe/M69DJElQ0K5vDADxhuCJWU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-tb4ffVP7N9aYPEyjEmOh3g-1; Mon, 13 Nov 2023 22:26:55 -0500
X-MC-Unique: tb4ffVP7N9aYPEyjEmOh3g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5090f6a04e1so4697264e87.0
        for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 19:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699932413; x=1700537213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFcPdjy5+d+tf/+vj6et1XDBkq3V8/c7Pne4PWzJpCQ=;
        b=Re8R+wrHIxmixTIbDF7ZyVS9gMHIWaRGggJP3MBPG6ZRVL5wKGrSnU8OQwIZLyONtQ
         aPZaiRGPEuBOZAfVWT6ER6Z6GxwTl38o3jdwcqJICdqWr0C8LGidyuBites3zIKO84gJ
         EuV0C6uBfZawBK3Pe1a0WFUQsOaTnFTvqVG989hoVDZHtkgwIt0q4zWCG1H7oyzGCHNX
         20pWUJ06GkMeRVh6QGcEPgCyZQX8OQJDljtJTMkoANh39QbD0lldt6cpC7sx5Jhi+JNy
         JeRmKEix+LweotWYkqhKKsx7WUaJsVNR1LvnoNfvjsEv+JrWBLr7DYFXxQLrahkeedIg
         5eBQ==
X-Gm-Message-State: AOJu0YyyJ7iIMFDHbfY+QB0+TZTLKWvqHfDnoqqRQDY9Beg2hnBAaBUg
	AHZBczMb5GiLpLExqoct/35sGJm7JFdZZOLc8Ycef3lTYBO7Vu6nOJi5uCzefY/tj54JPIoUg8i
	1tR3FALly7GZMDq/pvmXrNLLFv5qEADvNRhIcyZhV2VCJltyjOMQ5hIarZA==
X-Received: by 2002:a05:6512:3882:b0:509:4ab3:a8a3 with SMTP id n2-20020a056512388200b005094ab3a8a3mr5136887lft.22.1699932413587;
        Mon, 13 Nov 2023 19:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhmSrlbgW0nNy11oPhlKDdNdlJJJmLNfefRnC2KRIc1SICnYkM5FjcrVFXS9lJHu8+THKacv4VxhwwcD4ERkE=
X-Received: by 2002:a05:6512:3882:b0:509:4ab3:a8a3 with SMTP id
 n2-20020a056512388200b005094ab3a8a3mr5136874lft.22.1699932413219; Mon, 13 Nov
 2023 19:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107031227.100015-9-xuanzhuo@linux.alibaba.com> <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
 <1699527528.5637772-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1699527528.5637772-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 11:26:42 +0800
Message-ID: <CACGkMEu4toAuAuJdrXF0AJqsHc-ovPg3vi8=My-+BxaMi+TBSw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/21] virtio_net: sq support premapped mode
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

On Thu, Nov 9, 2023 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 9 Nov 2023 14:37:38 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > If the xsk is enabling, the xsk tx will share the send queue.
> > > But the xsk requires that the send queue use the premapped mode.
> > > So the send queue must support premapped mode.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++++++++--=
--
> > >  drivers/net/virtio/virtio_net.h |  16 ++++
> > >  2 files changed, 163 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index 16e75c08639e..f052db459156 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
> > >  #define VIRTIO_XDP_REDIR       BIT(1)
> > >
> > >  #define VIRTIO_XDP_FLAG        BIT(0)
> > > +#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
> > >
> > >  #define VIRTNET_DRIVER_VERSION "1.0.0"
> > >
> > > @@ -167,6 +168,29 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> > >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_=
FLAG);
> > >  }
> > >
> > > +static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *da=
ta)
> > > +{
> > > +       struct virtnet_sq_dma *next, *head;
> > > +
> > > +       head =3D (void *)((unsigned long)data & ~VIRTIO_XMIT_DATA_MAS=
K);
> > > +
> > > +       data =3D head->data;
> > > +
> > > +       while (head) {
> > > +               virtqueue_dma_unmap_single_attrs(sq->vq, head->addr, =
head->len,
> > > +                                                DMA_TO_DEVICE, 0);
> > > +
> > > +               next =3D head->next;
> > > +
> > > +               head->next =3D sq->dmainfo.free;
> > > +               sq->dmainfo.free =3D head;
> > > +
> > > +               head =3D next;
> > > +       }
> > > +
> > > +       return data;
> > > +}
> > > +
> > >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > >                             u64 *bytes, u64 *packets)
> > >  {
> > > @@ -175,14 +199,24 @@ static void __free_old_xmit(struct virtnet_sq *=
sq, bool in_napi,
> > >
> > >         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> > >                 if (!is_xdp_frame(ptr)) {
> > > -                       struct sk_buff *skb =3D ptr;
> > > +                       struct sk_buff *skb;
> > > +
> > > +                       if (sq->do_dma)
> > > +                               ptr =3D virtnet_sq_unmap(sq, ptr);
> > > +
> > > +                       skb =3D ptr;
> > >
> > >                         pr_debug("Sent skb %p\n", skb);
> > >
> > >                         *bytes +=3D skb->len;
> > >                         napi_consume_skb(skb, in_napi);
> > >                 } else {
> > > -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> > > +                       struct xdp_frame *frame;
> > > +
> > > +                       if (sq->do_dma)
> > > +                               ptr =3D virtnet_sq_unmap(sq, ptr);
> > > +
> > > +                       frame =3D ptr_to_xdp(ptr);
> > >
> > >                         *bytes +=3D xdp_get_frame_len(frame);
> > >                         xdp_return_frame(frame);
> > > @@ -567,22 +601,104 @@ static void *virtnet_rq_alloc(struct virtnet_r=
q *rq, u32 size, gfp_t gfp)
> > >         return buf;
> > >  }
> > >
> > > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > > +static int virtnet_sq_set_premapped(struct virtnet_sq *sq)
> > >  {
> > > -       int i;
> > > +       struct virtnet_sq_dma *d;
> > > +       int err, size, i;
> > >
> > > -       /* disable for big mode */
> > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > -               return;
> > > +       size =3D virtqueue_get_vring_size(sq->vq);
> > > +
> > > +       size +=3D MAX_SKB_FRAGS + 2;
> >
> > Btw, the dmainfo seems per sg? If I'm correct, how can vq_size +
> > MAX_SKB_FRAGS + 2 work?
>
>
> We may alloc dmainfo items when the vq is full. So I prepare more dmainfo=
 items.
>
>
> >
> > > +
> > > +       sq->dmainfo.head =3D kcalloc(size, sizeof(*sq->dmainfo.head),=
 GFP_KERNEL);
> > > +       if (!sq->dmainfo.head)
> > > +               return -ENOMEM;
> > > +
> > > +       err =3D virtqueue_set_dma_premapped(sq->vq);
> > > +       if (err) {
> > > +               kfree(sq->dmainfo.head);
> > > +               return err;
> > > +       }
> >
> > Allocating after set_dma_premapped() seems easier.
>
> Yes. But, we donot has the way to disable premapped mode.
>
> That is my mistake. :)
>
>
> >
> > Btw, is there a benchmark of TX PPS just for this patch to demonstrate
> > the impact of the performance?
>
> We will have that.
>
>
> >
> > > +
> > > +       sq->dmainfo.free =3D NULL;
> > > +
> > > +       sq->do_dma =3D true;
> > > +
> > > +       for (i =3D 0; i < size; ++i) {
> > > +               d =3D &sq->dmainfo.head[i];
> > > +
> > > +               d->next =3D sq->dmainfo.free;
> > > +               sq->dmainfo.free =3D d;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void virtnet_set_premapped(struct virtnet_info *vi)
> > > +{
> > > +       int i;
> > >
> > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > -                       continue;
> > > +               virtnet_sq_set_premapped(&vi->sq[i]);
> > >
> > > -               vi->rq[i].do_dma =3D true;
> > > +               /* disable for big mode */
> > > +               if (vi->mergeable_rx_bufs || !vi->big_packets) {
> > > +                       if (!virtqueue_set_dma_premapped(vi->rq[i].vq=
))
> > > +                               vi->rq[i].do_dma =3D true;
> >
> > How about sticking a virtnet_rq_set_premapped() and calling it here?
> >
> > It seems more clean.
>
> OK.
>
>
> >
> > Btw, the big mode support for pre mapping is still worthwhile
> > regardless whether or not XDP is supported. It has a page pool so we
> > can avoid redundant DMA map/unmap there.
>
> Yes.
>
> I post other patch set to do this.
>
>
> >
> > > +               }
> > >         }
> > >  }
> > >
> > > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct virtnet_sq *s=
q, int nents, void *data)
> > > +{
> > > +       struct virtnet_sq_dma *d, *head;
> > > +       struct scatterlist *sg;
> > > +       int i;
> > > +
> > > +       head =3D NULL;
> > > +
> > > +       for_each_sg(sq->sg, sg, nents, i) {
> > > +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq=
->vq, sg_virt(sg),
> > > +                                                                sg->=
length,
> > > +                                                                DMA_=
TO_DEVICE, 0);
> > > +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_addre=
ss))
> > > +                       goto err;
> > > +
> > > +               d =3D sq->dmainfo.free;
> > > +               sq->dmainfo.free =3D d->next;
> > > +
> > > +               d->addr =3D sg->dma_address;
> > > +               d->len =3D sg->length;
> > > +
> > > +               d->next =3D head;
> > > +               head =3D d;
> > > +       }
> > > +
> > > +       head->data =3D data;
> > > +
> > > +       return (void *)((unsigned long)head | ((unsigned long)data & =
VIRTIO_XMIT_DATA_MASK));
> >
> > So head contains a pointer to data, any reason we still need to pack a
> > data pointer here?
>
> Maybe you are right. We can skip this.
>
>
> >
> >
> > > +err:
> > > +       virtnet_sq_unmap(sq, head);
> > > +       return NULL;
> > > +}
> > > +
> > > +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *=
data)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (sq->do_dma) {
> > > +               data =3D virtnet_sq_map_sg(sq, num, data);
> > > +               if (!data)
> > > +                       return -ENOMEM;
> > > +       }
> > > +
> > > +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_A=
TOMIC);
> > > +       if (ret && sq->do_dma)
> > > +               virtnet_sq_unmap(sq, data);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > >  {
> > >         u64 bytes, packets =3D 0;
> > > @@ -686,8 +802,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_=
info *vi,
> > >                             skb_frag_size(frag), skb_frag_off(frag));
> > >         }
> > >
> > > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf)=
);
> > >         if (unlikely(err))
> > >                 return -ENOSPC; /* Caller handle free/refcnt */
> > >
> > > @@ -2126,7 +2241,8 @@ static int xmit_skb(struct virtnet_sq *sq, stru=
ct sk_buff *skb)
> > >                         return num_sg;
> > >                 num_sg++;
> > >         }
> > > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_=
ATOMIC);
> > > +
> > > +       return virtnet_add_outbuf(sq, num_sg, skb);
> > >  }
> > >
> > >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device=
 *dev)
> > > @@ -3818,6 +3934,8 @@ static void virtnet_free_queues(struct virtnet_=
info *vi)
> > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > >                 __netif_napi_del(&vi->rq[i].napi);
> > >                 __netif_napi_del(&vi->sq[i].napi);
> > > +
> > > +               kfree(vi->sq[i].dmainfo.head);
> > >         }
> > >
> > >         /* We called __netif_napi_del(),
> > > @@ -3866,10 +3984,23 @@ static void free_receive_page_frags(struct vi=
rtnet_info *vi)
> > >
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *b=
uf)
> > >  {
> > > -       if (!is_xdp_frame(buf))
> > > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > > +       struct virtnet_sq *sq;
> > > +       int i =3D vq2rxq(vq);
> > > +
> > > +       sq =3D &vi->sq[i];
> > > +
> > > +       if (!is_xdp_frame(buf)) {
> > > +               if (sq->do_dma)
> > > +                       buf =3D virtnet_sq_unmap(sq, buf);
> > > +
> > >                 dev_kfree_skb(buf);
> > > -       else
> > > +       } else {
> > > +               if (sq->do_dma)
> > > +                       buf =3D virtnet_sq_unmap(sq, buf);
> > > +
> > >                 xdp_return_frame(ptr_to_xdp(buf));
> > > +       }
> > >  }
> > >
> > >  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *b=
uf)
> > > @@ -4075,7 +4206,7 @@ static int init_vqs(struct virtnet_info *vi)
> > >         if (ret)
> > >                 goto err_free;
> > >
> > > -       virtnet_rq_set_premapped(vi);
> > > +       virtnet_set_premapped(vi);
> > >
> > >         cpus_read_lock();
> > >         virtnet_set_affinity(vi);
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/vir=
tio_net.h
> > > index d814341d9f97..ce806afb6d64 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -48,6 +48,18 @@ struct virtnet_rq_dma {
> > >         u16 need_sync;
> > >  };
> > >
> > > +struct virtnet_sq_dma {
> > > +       struct virtnet_sq_dma *next;
> > > +       dma_addr_t addr;
> > > +       u32 len;
> > > +       void *data;
> >
> > I think we need to seek a way to reuse what has been stored by virtio
> > core. It should be much more efficient.
>
>
> Yes.
>
> But that is for net-next branch.
>
> Can we do that as a fix after that is merged to 6.8?

We still have time. I would like to do it from the start.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > > +};
> > > +
> > > +struct virtnet_sq_dma_head {
> > > +       struct virtnet_sq_dma *free;
> > > +       struct virtnet_sq_dma *head;
> > > +};
> > > +
> > >  /* Internal representation of a send virtqueue */
> > >  struct virtnet_sq {
> > >         /* Virtqueue associated with this virtnet_sq */
> > > @@ -67,6 +79,10 @@ struct virtnet_sq {
> > >
> > >         /* Record whether sq is in reset state. */
> > >         bool reset;
> > > +
> > > +       bool do_dma;
> > > +
> > > +       struct virtnet_sq_dma_head dmainfo;
> > >  };
> > >
> > >  /* Internal representation of a receive virtqueue */
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
> >
>

