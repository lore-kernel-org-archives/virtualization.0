Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A153BA
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJp+V++t"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 522C760ED1
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 522C760ED1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fJp+V++t
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DEEzw0mz5dJB
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 06:37:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33D4960A9F
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 06:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33D4960A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699511875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtKHEENZYDYmMBeXLLs50ZBkd/xYn42eF6UW6agfhl4=;
	b=fJp+V++tVg848Ql87Cnjrzw5CNP9OXT/f9KKyOFtMRwbnPZ2kf9HRDuiqZ4o1jfomB0e3g
	Zs3L3zBVeuf97MoxBPcKL8dSyfIIOTn4NLFn7aRrWWQCtEuufweQexaYLvaShFPPDZlGwO
	DHe0cy1G4AVALmS1JsnzgWfYNyynsgE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-AQ3wuMDoNHueNuwxF1OLMQ-1; Thu, 09 Nov 2023 01:37:51 -0500
X-MC-Unique: AQ3wuMDoNHueNuwxF1OLMQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507cee14477so505109e87.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Nov 2023 22:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511870; x=1700116670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtKHEENZYDYmMBeXLLs50ZBkd/xYn42eF6UW6agfhl4=;
        b=mxVSm5MZS5lpsDiUdeLYXk4qmQqHyG22OXNiU1AgorSd1QIfzDrEa2VrNWi5wUzOpG
         p3ZwYwdqE3QGz3wiQWzkhApdLeStKKznhltv1A9CISXVqukPBI+S10ltlYZlA+rkkYns
         mmJVdAyJpU3qCJMEOGheKd1i1khlhYLgSSvceNXCL8oOAGzCQLFw/J/7EC0dHW4Rvqyk
         PCgs5+H+m4+Kt/taqcIZLoeGOyV4dyXHQuT1gxn4fnh+mxPxpjKF8weo/K6u5jwvCRZt
         aE+saMHPFtEjKNpRtOo2jzSxuM+B1LG1FNPJpAZbWBj91SMdI05FfjK+uDY1hzgHlXOW
         IPyA==
X-Gm-Message-State: AOJu0Yyx9Fplw9exYQOcrCrUXftRMHIJpdhdQMsQKCsKjF0P3dPqYWo4
	cqnQA44ffh8F2ByN1spDpoSdcxISa4QYGoNS8e3UYrsf1XLBZNbbwSoemOX4YLGmMxnLjKL4RKt
	rriyprK3q6HqTpJYTjrR8KI/dritpfyt2cjfvP/vMvAxUhHMTwjwKDq19nQ==
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id d23-20020a194f17000000b005032debbbc1mr457032lfb.22.1699511869962;
        Wed, 08 Nov 2023 22:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrnU37I8RO39L7e5VLqPopqt9qCt9JcGusGlz8jhqNX/DaVFn8ZE8ly03jmSQHtSQeYD7ZRfU/yMYJ5WzpZtw=
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id
 d23-20020a194f17000000b005032debbbc1mr457015lfb.22.1699511869594; Wed, 08 Nov
 2023 22:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:37:38 +0800
Message-ID: <CACGkMEtLee8ELzqFnV_zOu3p5tU6hivouKM=WjtNAq+2wQzAFQ@mail.gmail.com>
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

On Tue, Nov 7, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 163 ++++++++++++++++++++++++++++----
>  drivers/net/virtio/virtio_net.h |  16 ++++
>  2 files changed, 163 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 16e75c08639e..f052db459156 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
> +#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
>
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>
> @@ -167,6 +168,29 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
> +{
> +       struct virtnet_sq_dma *next, *head;
> +
> +       head =3D (void *)((unsigned long)data & ~VIRTIO_XMIT_DATA_MASK);
> +
> +       data =3D head->data;
> +
> +       while (head) {
> +               virtqueue_dma_unmap_single_attrs(sq->vq, head->addr, head=
->len,
> +                                                DMA_TO_DEVICE, 0);
> +
> +               next =3D head->next;
> +
> +               head->next =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D head;
> +
> +               head =3D next;
> +       }
> +
> +       return data;
> +}
> +
>  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
>                             u64 *bytes, u64 *packets)
>  {
> @@ -175,14 +199,24 @@ static void __free_old_xmit(struct virtnet_sq *sq, =
bool in_napi,
>
>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
>                 if (!is_xdp_frame(ptr)) {
> -                       struct sk_buff *skb =3D ptr;
> +                       struct sk_buff *skb;
> +
> +                       if (sq->do_dma)
> +                               ptr =3D virtnet_sq_unmap(sq, ptr);
> +
> +                       skb =3D ptr;
>
>                         pr_debug("Sent skb %p\n", skb);
>
>                         *bytes +=3D skb->len;
>                         napi_consume_skb(skb, in_napi);
>                 } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +                       struct xdp_frame *frame;
> +
> +                       if (sq->do_dma)
> +                               ptr =3D virtnet_sq_unmap(sq, ptr);
> +
> +                       frame =3D ptr_to_xdp(ptr);
>
>                         *bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
> @@ -567,22 +601,104 @@ static void *virtnet_rq_alloc(struct virtnet_rq *r=
q, u32 size, gfp_t gfp)
>         return buf;
>  }
>
> -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +static int virtnet_sq_set_premapped(struct virtnet_sq *sq)
>  {
> -       int i;
> +       struct virtnet_sq_dma *d;
> +       int err, size, i;
>
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       size =3D virtqueue_get_vring_size(sq->vq);
> +
> +       size +=3D MAX_SKB_FRAGS + 2;

Btw, the dmainfo seems per sg? If I'm correct, how can vq_size +
MAX_SKB_FRAGS + 2 work?

> +
> +       sq->dmainfo.head =3D kcalloc(size, sizeof(*sq->dmainfo.head), GFP=
_KERNEL);
> +       if (!sq->dmainfo.head)
> +               return -ENOMEM;
> +
> +       err =3D virtqueue_set_dma_premapped(sq->vq);
> +       if (err) {
> +               kfree(sq->dmainfo.head);
> +               return err;
> +       }

Allocating after set_dma_premapped() seems easier.

Btw, is there a benchmark of TX PPS just for this patch to demonstrate
the impact of the performance?

> +
> +       sq->dmainfo.free =3D NULL;
> +
> +       sq->do_dma =3D true;
> +
> +       for (i =3D 0; i < size; ++i) {
> +               d =3D &sq->dmainfo.head[i];
> +
> +               d->next =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D d;
> +       }
> +
> +       return 0;
> +}
> +
> +static void virtnet_set_premapped(struct virtnet_info *vi)
> +{
> +       int i;
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> +               virtnet_sq_set_premapped(&vi->sq[i]);
>
> -               vi->rq[i].do_dma =3D true;
> +               /* disable for big mode */
> +               if (vi->mergeable_rx_bufs || !vi->big_packets) {
> +                       if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> +                               vi->rq[i].do_dma =3D true;

How about sticking a virtnet_rq_set_premapped() and calling it here?

It seems more clean.

Btw, the big mode support for pre mapping is still worthwhile
regardless whether or not XDP is supported. It has a page pool so we
can avoid redundant DMA map/unmap there.

> +               }
>         }
>  }
>
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct virtnet_sq *sq, i=
nt nents, void *data)
> +{
> +       struct virtnet_sq_dma *d, *head;
> +       struct scatterlist *sg;
> +       int i;
> +
> +       head =3D NULL;
> +
> +       for_each_sg(sq->sg, sg, nents, i) {
> +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->vq=
, sg_virt(sg),
> +                                                                sg->leng=
th,
> +                                                                DMA_TO_D=
EVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
> +                       goto err;
> +
> +               d =3D sq->dmainfo.free;
> +               sq->dmainfo.free =3D d->next;
> +
> +               d->addr =3D sg->dma_address;
> +               d->len =3D sg->length;
> +
> +               d->next =3D head;
> +               head =3D d;
> +       }
> +
> +       head->data =3D data;
> +
> +       return (void *)((unsigned long)head | ((unsigned long)data & VIRT=
IO_XMIT_DATA_MASK));

So head contains a pointer to data, any reason we still need to pack a
data pointer here?


> +err:
> +       virtnet_sq_unmap(sq, head);
> +       return NULL;
> +}
> +
> +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data=
)
> +{
> +       int ret;
> +
> +       if (sq->do_dma) {
> +               data =3D virtnet_sq_map_sg(sq, num, data);
> +               if (!data)
> +                       return -ENOMEM;
> +       }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && sq->do_dma)
> +               virtnet_sq_unmap(sq, data);
> +
> +       return ret;
> +}
> +
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
>  {
>         u64 bytes, packets =3D 0;
> @@ -686,8 +802,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info=
 *vi,
>                             skb_frag_size(frag), skb_frag_off(frag));
>         }
>
> -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
>         if (unlikely(err))
>                 return -ENOSPC; /* Caller handle free/refcnt */
>
> @@ -2126,7 +2241,8 @@ static int xmit_skb(struct virtnet_sq *sq, struct s=
k_buff *skb)
>                         return num_sg;
>                 num_sg++;
>         }
> -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOM=
IC);
> +
> +       return virtnet_add_outbuf(sq, num_sg, skb);
>  }
>
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> @@ -3818,6 +3934,8 @@ static void virtnet_free_queues(struct virtnet_info=
 *vi)
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
>                 __netif_napi_del(&vi->rq[i].napi);
>                 __netif_napi_del(&vi->sq[i].napi);
> +
> +               kfree(vi->sq[i].dmainfo.head);
>         }
>
>         /* We called __netif_napi_del(),
> @@ -3866,10 +3984,23 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!is_xdp_frame(buf))
> +       struct virtnet_info *vi =3D vq->vdev->priv;
> +       struct virtnet_sq *sq;
> +       int i =3D vq2rxq(vq);
> +
> +       sq =3D &vi->sq[i];
> +
> +       if (!is_xdp_frame(buf)) {
> +               if (sq->do_dma)
> +                       buf =3D virtnet_sq_unmap(sq, buf);
> +
>                 dev_kfree_skb(buf);
> -       else
> +       } else {
> +               if (sq->do_dma)
> +                       buf =3D virtnet_sq_unmap(sq, buf);
> +
>                 xdp_return_frame(ptr_to_xdp(buf));
> +       }
>  }
>
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> @@ -4075,7 +4206,7 @@ static int init_vqs(struct virtnet_info *vi)
>         if (ret)
>                 goto err_free;
>
> -       virtnet_rq_set_premapped(vi);
> +       virtnet_set_premapped(vi);
>
>         cpus_read_lock();
>         virtnet_set_affinity(vi);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index d814341d9f97..ce806afb6d64 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -48,6 +48,18 @@ struct virtnet_rq_dma {
>         u16 need_sync;
>  };
>
> +struct virtnet_sq_dma {
> +       struct virtnet_sq_dma *next;
> +       dma_addr_t addr;
> +       u32 len;
> +       void *data;

I think we need to seek a way to reuse what has been stored by virtio
core. It should be much more efficient.

Thanks

> +};
> +
> +struct virtnet_sq_dma_head {
> +       struct virtnet_sq_dma *free;
> +       struct virtnet_sq_dma *head;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct virtnet_sq {
>         /* Virtqueue associated with this virtnet_sq */
> @@ -67,6 +79,10 @@ struct virtnet_sq {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       bool do_dma;
> +
> +       struct virtnet_sq_dma_head dmainfo;
>  };
>
>  /* Internal representation of a receive virtqueue */
> --
> 2.32.0.3.g01195cf9f
>

