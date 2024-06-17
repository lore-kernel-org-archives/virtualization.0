Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3018C326
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608937; cv=none; b=llD8HKMrJEz4cTB+LAWJe/92QMceOygcVEICldTqF8BiSZZl9eaB0uoLV+jNG7tFMxzfEM6RWFc7aQGT5JK/lUyQQ/KHB56jh7u3Sf6d649yMOAWdNuu5uCLOoVfhyxxbQSQr/2HPvZx4M7RvlTVk/9WvziGVi0NkDbLhzaGczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608937; c=relaxed/simple;
	bh=tVi7jNJkaeFy8cTcTLnbvN92lA8xL4/9/OUc6Cu7kqY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=UXdnzCLxM2PrKR1nR+Jd7zG2e+JCdRu6JimTt0Ns2LVpyNmP+tbt2XQum+4F7CJMG3tjiA+s5rSm2rcglPUvk/1pk+jTPJg68eVHjDu6w62/oW9Xu+mrAlAw1+AB/yuE7/7CsBdZOfhb1qN4xN5HwRtvEEFb4v4We//ylPO4bU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tJzlpZrK; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tJzlpZrK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718608926; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=1QaLwKr7H5/+g568TPRoysKXk6xWc0uXFjBaAtQY75A=;
	b=tJzlpZrK+KdS72ZpAIL3M9F02v/S2f7gNXPtL6lZUE1szHClU/5mbiOHHAEfundIKoD3o2L6hbtZ17i7LB7iGHlB46XS/o2eqH/y5BAvFgf+xzXL/0SH1Wbf5MtEjbJvRDwVoong+UO6vzLBsT63WSy1DSt9KY12uqSS9E/VoNQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8Z.fYo_1718608923;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8Z.fYo_1718608923)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 15:22:04 +0800
Message-ID: <1718608874.0503511-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 07/15] virtio_net: refactor the xmit type
Date: Mon, 17 Jun 2024 15:21:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEtUE8CbdLS1c1b++g=ZxO_gDgOidUpWhuv28ZWgWP6uPw@mail.gmail.com>
In-Reply-To: <CACGkMEtUE8CbdLS1c1b++g=ZxO_gDgOidUpWhuv28ZWgWP6uPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 17 Jun 2024 13:00:11 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Because the af-xdp and sq premapped mode will introduce two
> > new xmit type, so I refactor the xmit type mechanism first.
> >
> > We use the last two bits of the pointer to distinguish the xmit type,
> > so we can distinguish four xmit types. Now we have two xmit types:
> > SKB and XDP.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 58 +++++++++++++++++++++++++++-------------
> >  1 file changed, 40 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 161694957065..e84a4624549b 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -47,8 +47,6 @@ module_param(napi_tx, bool, 0644);
> >  #define VIRTIO_XDP_TX          BIT(0)
> >  #define VIRTIO_XDP_REDIR       BIT(1)
> >
> > -#define VIRTIO_XDP_FLAG        BIT(0)
> > -
> >  /* RX packet size EWMA. The average packet size is used to determine t=
he packet
> >   * buffer size when refilling RX rings. As the entire RX ring may be r=
efilled
> >   * at once, the weight is chosen so that the EWMA will be insensitive =
to short-
> > @@ -491,42 +489,62 @@ struct virtio_net_common_hdr {
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf=
);
> >
> > -static bool is_xdp_frame(void *ptr)
> > +enum virtnet_xmit_type {
> > +       VIRTNET_XMIT_TYPE_SKB,
> > +       VIRTNET_XMIT_TYPE_XDP,
> > +};
> > +
> > +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_T=
YPE_XDP)
> > +
> > +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> >  {
> > -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > +       unsigned long p =3D (unsigned long)*ptr;
> > +
> > +       *ptr =3D (void *)(p & ~VIRTNET_XMIT_TYPE_MASK);
> > +
> > +       return p & VIRTNET_XMIT_TYPE_MASK;
> >  }
> >
> > -static void *xdp_to_ptr(struct xdp_frame *ptr)
> > +static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type ty=
pe)
>
> How about rename this to virtnet_ptr_to_token()?

Will fix.

>
> >  {
> > -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> > +       return (void *)((unsigned long)ptr | type);
> >  }
> >
> > -static struct xdp_frame *ptr_to_xdp(void *ptr)
> > +static int virtnet_add_outbuf(struct send_queue *sq, int num, void *da=
ta,
> > +                             enum virtnet_xmit_type type)
> >  {
> > -       return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FL=
AG);
> > +       return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> > +                                   virtnet_xmit_ptr_mix(data, type),
> > +                                   GFP_ATOMIC);
>
> Nit: I think we can just open-code this instead of using a helper.

Will fix.

Thanks.


>
> Others look good.
>
> Thanks
>
>
> >  }
> >
> >  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >                             struct virtnet_sq_free_stats *stats)
> >  {
> > +       struct xdp_frame *frame;
> > +       struct sk_buff *skb;
> >         unsigned int len;
> >         void *ptr;
> >
> >         while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> >                 ++stats->packets;
> >
> > -               if (!is_xdp_frame(ptr)) {
> > -                       struct sk_buff *skb =3D ptr;
> > +               switch (virtnet_xmit_ptr_strip(&ptr)) {
> > +               case VIRTNET_XMIT_TYPE_SKB:
> > +                       skb =3D ptr;
> >
> >                         pr_debug("Sent skb %p\n", skb);
> >
> >                         stats->bytes +=3D skb->len;
> >                         napi_consume_skb(skb, in_napi);
> > -               } else {
> > -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> > +                       break;
> > +
> > +               case VIRTNET_XMIT_TYPE_XDP:
> > +                       frame =3D ptr;
> >
> >                         stats->bytes +=3D xdp_get_frame_len(frame);
> >                         xdp_return_frame(frame);
> > +                       break;
> >                 }
> >         }
> >  }
> > @@ -1064,8 +1082,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_=
info *vi,
> >                             skb_frag_size(frag), skb_frag_off(frag));
> >         }
> >
> > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdpf, VIRTNET_XMIT=
_TYPE_XDP);
> >         if (unlikely(err))
> >                 return -ENOSPC; /* Caller handle free/refcnt */
> >
> > @@ -2557,7 +2574,7 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb)
> >                         return num_sg;
> >                 num_sg++;
> >         }
> > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_AT=
OMIC);
> > +       return virtnet_add_outbuf(sq, num_sg, skb, VIRTNET_XMIT_TYPE_SK=
B);
> >  }
> >
> >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *=
dev)
> > @@ -5263,10 +5280,15 @@ static void free_receive_page_frags(struct virt=
net_info *vi)
> >
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  {
> > -       if (!is_xdp_frame(buf))
> > +       switch (virtnet_xmit_ptr_strip(&buf)) {
> > +       case VIRTNET_XMIT_TYPE_SKB:
> >                 dev_kfree_skb(buf);
> > -       else
> > -               xdp_return_frame(ptr_to_xdp(buf));
> > +               break;
> > +
> > +       case VIRTNET_XMIT_TYPE_XDP:
> > +               xdp_return_frame(buf);
> > +               break;
> > +       }
> >  }
> >
> >  static void free_unused_bufs(struct virtnet_info *vi)
> > --
> > 2.32.0.3.g01195cf9f
> >
>
