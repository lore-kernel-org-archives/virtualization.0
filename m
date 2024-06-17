Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA9224D5
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600430; cv=none; b=i3gRJf5HwwH/BUB/nu5DvJChusrK9CiP+mepnssQZsLk2JXnvY3VMylXuXVIenO1cajr5vJ6T+jl132koiCkSoD0og2p7kb+bP2q58a8vhfSqnst4UgG28h4hYP0lbLnNjf/ukkUmD0+lzpuhwSyILErB5xqtCoOsyKBrKMkHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600430; c=relaxed/simple;
	bh=xb1xI4o+mP+tw/J/8OUPv0F4S1iWik5ShhecymI34Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O95ZpoYCnsbFqTkMMqGoq/hsuVY7MCE7XBfZkYxGnXhHDwLiq2RF+5mDw5MhwpZkTwzWgSAdhFRf5cNh0nM5aR9VICvlACXQDCjUtb3cSSzuEO1U03lswNqQiygdcoEi3rKbjCyKzAwDjAFlxKqoIoypC2YTih2zONPyM/imrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdoV7J8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdoV7J8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718600427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1x0SllK8/ahZnKq4kjlEZCm9tSmen/C/vMVAEHIPK8=;
	b=NdoV7J8B4NRN3fu7uctfUfp08lu6gTJ8nW7nHOni86noPnNTgYZ3fljf5ucKDLNUy4CqoF
	1/0vK9BnzrCWEgj9mh6N/6boR/ZPeZaE0lwIDbrgX0pgP+VnukxdjKcBqb2Fx9+vHgqiYe
	cwXifdhi99pR6gEkHuBr27oY6dShhps=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-gkVIzADPMhG9TYaBimzc9w-1; Mon, 17 Jun 2024 01:00:26 -0400
X-MC-Unique: gkVIzADPMhG9TYaBimzc9w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c4b0f01581so4015796a91.2
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 22:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718600425; x=1719205225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1x0SllK8/ahZnKq4kjlEZCm9tSmen/C/vMVAEHIPK8=;
        b=bgwSYLThY0cm8u8IsHTiMxcLAVkMg0Zt65f48VwDA+9VmmnrT9wN9gknlzFaORgtOm
         jK6Pmx2NfmYr+YE03YD43ByobBJ/OQnJLDow+0F0ddz84rcR5V5Xbtb2TzScsLTu/Cy3
         GjQy/+qZTUqYnnINTTAvv/IjLVQc30IVkwotGXmAQlMpCTkgMcBRDSwnl6CEs2LfgXRx
         JJXqvASFriQcwJMHSApYkFZsq/VaEOaa5WbE7UuZycEE6pn0KLk7URLshHnskMilQfgf
         0Y3dXM3jue/AasEgQrrFRCQzwTeXIwk/myERZkDFiOTw8/UhEptIWAd5v/RVsHMLWvrE
         BzZA==
X-Forwarded-Encrypted: i=1; AJvYcCVNPp+trEcjnCpIXXDc0u2US+UIP/4XBXsTaZithJ9uLOTvqyVm0w3kcN9htlVUtPe8Q+gal62Qrz/Xb9l0H3yz4xVDfGY2gHFP1gdVPdo=
X-Gm-Message-State: AOJu0Yzs/FWFRwi2l3jiRp8xf80i+3B2sVr7eQNQ9JUbwu8iTbC22Lcr
	yt4nvjUdL2uAoEZGhc6n9HIdtyZrgF5zqrdr9egPJWCB2z4mBLl5XQ/ejL54JELK2SIkCI1CN27
	Vl9TsP9r7g1FYpxohlJ98Mtp59yOTPbkj4Kv6pEd1aIDd60OiD/KaQQxDOy0tOUlFtqFM1y7dlo
	fI7+3qKN851COJqox7GrTnH3Rr0MlvkwCitiI90EI=
X-Received: by 2002:a17:90a:ce96:b0:2c3:1159:2cfe with SMTP id 98e67ed59e1d1-2c4db13571cmr7562845a91.4.1718600424949;
        Sun, 16 Jun 2024 22:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUUSFNeQ/84XnREA5ntZ0/QkJkgvKeU9+DUeYKe+QmfgJsvIz181knXMD+nGrTPtkedvLK3arWY4ATK89TZg4=
X-Received: by 2002:a17:90a:ce96:b0:2c3:1159:2cfe with SMTP id
 98e67ed59e1d1-2c4db13571cmr7562793a91.4.1718600423094; Sun, 16 Jun 2024
 22:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com> <20240614063933.108811-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240614063933.108811-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 13:00:11 +0800
Message-ID: <CACGkMEtUE8CbdLS1c1b++g=ZxO_gDgOidUpWhuv28ZWgWP6uPw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/15] virtio_net: refactor the xmit type
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

On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Because the af-xdp and sq premapped mode will introduce two
> new xmit type, so I refactor the xmit type mechanism first.
>
> We use the last two bits of the pointer to distinguish the xmit type,
> so we can distinguish four xmit types. Now we have two xmit types:
> SKB and XDP.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 58 +++++++++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 161694957065..e84a4624549b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -47,8 +47,6 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> -#define VIRTIO_XDP_FLAG        BIT(0)
> -
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -491,42 +489,62 @@ struct virtio_net_common_hdr {
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
> -static bool is_xdp_frame(void *ptr)
> +enum virtnet_xmit_type {
> +       VIRTNET_XMIT_TYPE_SKB,
> +       VIRTNET_XMIT_TYPE_XDP,
> +};
> +
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYP=
E_XDP)
> +
> +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
> -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> +       unsigned long p =3D (unsigned long)*ptr;
> +
> +       *ptr =3D (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
> +
> +       return p & VIRTNET_XMIT_TYPE_MASK;
>  }
>
> -static void *xdp_to_ptr(struct xdp_frame *ptr)
> +static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type=
)

How about rename this to virtnet_ptr_to_token()?

>  {
> -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> +       return (void *)((unsigned long)ptr | type);
>  }
>
> -static struct xdp_frame *ptr_to_xdp(void *ptr)
> +static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data=
,
> +                             enum virtnet_xmit_type type)
>  {
> -       return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
> +       return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> +                                   virtnet_xmit_ptr_mix(data, type),
> +                                   GFP_ATOMIC);

Nit: I think we can just open-code this instead of using a helper.

Others look good.

Thanks


>  }
>
>  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>                             struct virtnet_sq_free_stats *stats)
>  {
> +       struct xdp_frame *frame;
> +       struct sk_buff *skb;
>         unsigned int len;
>         void *ptr;
>
>         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
>                 ++stats->packets;
>
> -               if (!is_xdp_frame(ptr)) {
> -                       struct sk_buff *skb =3D ptr;
> +               switch (virtnet_xmit_ptr_strip(&ptr)) {
> +               case VIRTNET_XMIT_TYPE_SKB:
> +                       skb =3D ptr;
>
>                         pr_debug("Sent skb %p\n", skb);
>
>                         stats->bytes +=3D skb->len;
>                         napi_consume_skb(skb, in_napi);
> -               } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +                       break;
> +
> +               case VIRTNET_XMIT_TYPE_XDP:
> +                       frame =3D ptr;
>
>                         stats->bytes +=3D xdp_get_frame_len(frame);
>                         xdp_return_frame(frame);
> +                       break;
>                 }
>         }
>  }
> @@ -1064,8 +1082,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_in=
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
> @@ -2557,7 +2574,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb)
>                         return num_sg;
>                 num_sg++;
>         }
> -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOM=
IC);
> +       return virtnet_add_outbuf(sq, num_sg, skb, VIRTNET_XMIT_TYPE_SKB)=
;
>  }
>
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *de=
v)
> @@ -5263,10 +5280,15 @@ static void free_receive_page_frags(struct virtne=
t_info *vi)
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> -       if (!is_xdp_frame(buf))
> +       switch (virtnet_xmit_ptr_strip(&buf)) {
> +       case VIRTNET_XMIT_TYPE_SKB:
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
>
>  static void free_unused_bufs(struct virtnet_info *vi)
> --
> 2.32.0.3.g01195cf9f
>

