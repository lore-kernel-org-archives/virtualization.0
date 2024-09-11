Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1573FB30
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027475; cv=none; b=On69SYgleJSq/Ozxsd3J/k8iWqshtYH5WfiE7taYoVVbZc4u7HldhBYNaL5kx1yBrfZvxTFchBMnn24nnwDb0qEP0iQ+HzfvjLbyFumA6qGIB3DAp3TlA5wMJWKoAk/Dp6IRBBVDjlIiSa8Dod8c5hUul4of0nMwLHfKIsKp8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027475; c=relaxed/simple;
	bh=8936+OIhb+uMPun+w3L6EWWJjUeY2JQzf90eB6Yzngk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ri/tUC3YpCvDWG3ICzosgaS/Kk6gX56XHjhHfAzXUlk+6tOnmu19YtY+DYDnF2CR6QmdkHIhng3KMW29gnp7Zu4T4kL9ZFEOKchMtbkpHF8UwGrlCvVtIS5XDW4D1zMtTLvefBaFhoSHjS+f/QxvotFrAgW0ASJXVznHaQpBFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jl/1ih3G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jl/1ih3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726027472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzSW+E+Jz/kR7XTFG/m5PWYT4kdd+KhWrA2O/rdkOVM=;
	b=Jl/1ih3GkeMDyWhNqW7oKB09GsjZMiZjsieBbRNEhcP8DK6Dclzv1IoODX8ZnMJ9xPWqRP
	ZHdE0TcNwHlN5cCr5UK5fGUZNKAKyfAN06T/HpCBSMFu7x385V5BEDshKnIR+D5p+RyfP2
	DQggD+Sqw+uL6CH6KIRVH46g51i/ZZ4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-nQLRRFXMOaS2GD6gCjXJSg-1; Wed, 11 Sep 2024 00:04:29 -0400
X-MC-Unique: nQLRRFXMOaS2GD6gCjXJSg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d89b31e942so6427848a91.1
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 21:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726027468; x=1726632268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzSW+E+Jz/kR7XTFG/m5PWYT4kdd+KhWrA2O/rdkOVM=;
        b=QccIKGEZSxA+SspktO0NuY0KNMOE88grd1xgTdWElEnA6IbXPJyFjnDWiYxzvAZuyo
         MZFEr0Jr0p2NQq2o7UqXp8A52j1GeKtlknZaFjnb5vvRGpABRN9YTz7qwNtf+vpa75Tj
         BpOp3x7KDq+zs6HcrBwz3NTt6NFASSTTVbne/a+nx4buCB+MLNBRNb6R446LD+7I/3ak
         KyoJ+jLh/c2l+uuC0DKf07ghh/z1GXg9UKl/xFbg8XnsGP1k2d8lZt6hYjmskEk46UUo
         ViOaXxzj4r2h2Kkx+uxAalu+pTZfGNe8cNSIeHNGMEwVjY1g92f3HnIR8VTpY80GzIcy
         FwEw==
X-Forwarded-Encrypted: i=1; AJvYcCWL3l0wk1n6WU8+1clnhV9vwmnIc2LRD8Dw9ohHrzgIDye2TNJik7yaY4utBlWTcICzFyEGdxQV5gA3me2YZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq04GBEox4jyTUD6SUI7mb6lubR84UXZFh0p9oZQDzdQku5ES+
	YuVu/5dvC5hGGtXVFZGTQ0JzG4VZG+zl5sB8JxLD+33JxgFvzP5GGlJS5CpRn7eFYTh7Jo2ow1O
	qgfL9V9Gxgz1CNs4wMMjSOBwFOxvBnwCH1p0i4x9nCH/g/JwCzq7Zbpz9Ig47pPAUcc0jRgLO49
	A7iZg+OnIzLKuQ8iysLRY2JPUQZkZAYgGptos0s98=
X-Received: by 2002:a17:90b:3015:b0:2d6:1981:bbf7 with SMTP id 98e67ed59e1d1-2dad5181bfemr16679836a91.32.1726027468249;
        Tue, 10 Sep 2024 21:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb5ERYVZIhS1ZSZArbyypF0+/B6vZIXPq1Li7NtejkdYm0blEMvtBFn9Klw+kUI9oLAdvQbfhWl/ec7G4c7Xo=
X-Received: by 2002:a17:90b:3015:b0:2d6:1981:bbf7 with SMTP id
 98e67ed59e1d1-2dad5181bfemr16679795a91.32.1726027467697; Tue, 10 Sep 2024
 21:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:04:16 +0800
Message-ID: <CACGkMEuDg800zy+-W7VRY5Ns4COsmvMP_kpHdzJ-ws8PuMoGhA@mail.gmail.com>
Subject: Re: [PATCH net-next 07/13] virtio_net: refactor the xmit type
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Because the af-xdp will introduce a new xmit type, so I refactor the
> xmit type mechanism first.
>
> We use the last two bits of the pointer to distinguish the xmit type,
> so we can distinguish four xmit types. Now we have three types: skb,
> orphan and xdp.

And if I was not wrong, we do not anymore use bitmasks. If yes, let's
explain the reason here.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 41aaea3b90fd..96abee36738b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> -#define VIRTIO_XDP_FLAG                BIT(0)
> -#define VIRTIO_ORPHAN_FLAG     BIT(1)
> -
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -509,34 +506,35 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>
> -static bool is_xdp_frame(void *ptr)
> -{
> -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> -}
> +enum virtnet_xmit_type {
> +       VIRTNET_XMIT_TYPE_SKB,
> +       VIRTNET_XMIT_TYPE_ORPHAN,

Let's rename this to SKB_ORPHAN?

> +       VIRTNET_XMIT_TYPE_XDP,
> +};
>
> -static void *xdp_to_ptr(struct xdp_frame *ptr)
> -{
> -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> -}
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYP=
E_ORPHAN \
> +                               | VIRTNET_XMIT_TYPE_XDP)

I may miss something but it seems not a correct bitmask definition as
each member is not a bit actually?

>
> -static struct xdp_frame *ptr_to_xdp(void *ptr)
> +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
> -       return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
> -}
> +       unsigned long p =3D (unsigned long)*ptr;
>
> -static bool is_orphan_skb(void *ptr)
> -{
> -       return (unsigned long)ptr & VIRTIO_ORPHAN_FLAG;
> +       *ptr =3D (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
> +
> +       return p & VIRTNET_XMIT_TYPE_MASK;
>  }
>
> -static void *skb_to_ptr(struct sk_buff *skb, bool orphan)
> +static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type=
)
>  {
> -       return (void *)((unsigned long)skb | (orphan ? VIRTIO_ORPHAN_FLAG=
 : 0));
> +       return (void *)((unsigned long)ptr | type);
>  }
>
> -static struct sk_buff *ptr_to_skb(void *ptr)
> +static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data=
,
> +                             enum virtnet_xmit_type type)
>  {
> -       return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLA=
G);
> +       return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> +                                   virtnet_xmit_ptr_mix(data, type),
> +                                   GFP_ATOMIC);
>  }
>
>  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> @@ -549,29 +547,37 @@ static void sg_fill_dma(struct scatterlist *sg, dma=
_addr_t addr, u32 len)
>  static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *=
txq,
>                             bool in_napi, struct virtnet_sq_free_stats *s=
tats)
>  {
> +       struct xdp_frame *frame;
> +       struct sk_buff *skb;
>         unsigned int len;
>         void *ptr;
>
>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> -               if (!is_xdp_frame(ptr)) {
> -                       struct sk_buff *skb =3D ptr_to_skb(ptr);
> +               switch (virtnet_xmit_ptr_strip(&ptr)) {
> +               case VIRTNET_XMIT_TYPE_SKB:
> +                       skb =3D ptr;
>
>                         pr_debug("Sent skb %p\n", skb);
> +                       stats->napi_packets++;
> +                       stats->napi_bytes +=3D skb->len;
> +                       napi_consume_skb(skb, in_napi);
> +                       break;
>
> -                       if (is_orphan_skb(ptr)) {
> -                               stats->packets++;
> -                               stats->bytes +=3D skb->len;
> -                       } else {
> -                               stats->napi_packets++;
> -                               stats->napi_bytes +=3D skb->len;
> -                       }
> +               case VIRTNET_XMIT_TYPE_ORPHAN:
> +                       skb =3D ptr;
> +
> +                       stats->packets++;
> +                       stats->bytes +=3D skb->len;
>                         napi_consume_skb(skb, in_napi);
> -               } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +                       break;
> +
> +               case VIRTNET_XMIT_TYPE_XDP:
> +                       frame =3D ptr;
>
>                         stats->packets++;
>                         stats->bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
> +                       break;
>                 }
>         }
>         netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_b=
ytes);
> @@ -1421,8 +1427,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_in=
fo *vi,
>                             skb_frag_size(frag), skb_frag_off(frag));
>         }
>
> -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT_T=
YPE_XDP);
>         if (unlikely(err))
>                 return -ENOSPC; /* Caller handle free/refcnt */
>
> @@ -3028,8 +3033,9 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>                         return num_sg;
>                 num_sg++;
>         }
> -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
> -                                   skb_to_ptr(skb, orphan), GFP_ATOMIC);
> +
> +       return virtnet_add_outbuf(sq, num_sg, skb,
> +                                 orphan ? VIRTNET_XMIT_TYPE_ORPHAN : VIR=
TNET_XMIT_TYPE_SKB);
>  }
>
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> @@ -5906,10 +5912,16 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!is_xdp_frame(buf))
> +       switch (virtnet_xmit_ptr_strip(&buf)) {
> +       case VIRTNET_XMIT_TYPE_SKB:
> +       case VIRTNET_XMIT_TYPE_ORPHAN:
>                 dev_kfree_skb(buf);
> -       else
> -               xdp_return_frame(ptr_to_xdp(buf));
> +               break;
> +
> +       case VIRTNET_XMIT_TYPE_XDP:
> +               xdp_return_frame(buf);
> +               break;
> +       }
>  }

Others look fine.

Thanks

>
>  static void free_unused_bufs(struct virtnet_info *vi)
> --
> 2.32.0.3.g01195cf9f
>

