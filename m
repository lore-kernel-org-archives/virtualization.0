Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911864C98
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672827; cv=none; b=UMYHf7HwJLAOTIJHhgtMHQYmYltVDITLTo9sklM0qt8JqobogB3caz+nr0T2nWk53r7+X4X5EcjdalNRDGGpgYAbxHcCIB9TwU64w403HEWY5GCOrIn6+jL+weGorHK0k3XETVgQZqlxaPXrGwk9hKlyNF5xEVgqa2dUzZxdgTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672827; c=relaxed/simple;
	bh=OeFN/Da5Q8phnx7MVIdysihrxHvERcfcSQjubW6FFD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWCcrK/doaIWgAQcW/rPMlweqYiBXkuNmkG3LXOJfHiZZ5N3bCGP0AXsKe6Mm89jezGldLbMqISRsydwOGTPX3hiBVXve0VEhVw7SOMcmM//KPiRsn6UCwMmZ2GXFaBqwdSqY82alt396HCkppiaQI1TeTSwVBhx6Kzot4hSwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeQ0dVGw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeQ0dVGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718672824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxiYubBucaBft9XfwB5Gxylwl4qnbab41nUg4J+Iq0U=;
	b=OeQ0dVGwhgrzQEv6vmwmPjlOXZKGyLIrvVKz+axxJGRPZ9/cQZi+Z/WNK9CWFuXu11W1Nb
	m5JwK0FZzos4aWCnXJWjLQKImPlEaexZXjB/Gjx35GDBBgKSq4/R6T8gZhf9HkqYFboZSD
	DRDvltJScD1cqP8WAJF4dCmfJj/zwB0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-d12tNBxSNQy1_A7HYRk-Iw-1; Mon, 17 Jun 2024 21:07:03 -0400
X-MC-Unique: d12tNBxSNQy1_A7HYRk-Iw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6e79f0ff303so4021423a12.2
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 18:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718672822; x=1719277622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxiYubBucaBft9XfwB5Gxylwl4qnbab41nUg4J+Iq0U=;
        b=JHE1l36/7qI9+kKkHYsCd/LIcXxjl9cIfQ6aFRY2n7lwfF0di4NwQ4f/vdmvmrYKxj
         G6ZozX8SAxVDTUPHE2RarDjo6o1xpNUwqVu+Pne07t382WoeL+QrKtoNnaTswj6BUfkK
         H6XPehqEPXOmPV8wB8JUwR5rHkBH/moW6OsLccweTOt1stI9W6Rt2v5lZKmgSGo+oOxd
         oRGBqT76mdtHhReAMg8xMCaYTCU6/k/p37ix0wA8JiZ0ZlmcxcoSJzvkExW0vUqMTyCT
         zagU9JbFZREIdyIFEKy8zpIrrH1DNK9fdZUn86PKSNkA+YNxaJrss/SFs7sfjeu0Kbdv
         ignQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/TSAZAq40GPRggrP5fAYmdVae5zVhXkPtax6mr8yNMcmrobjkaeR2QQI7B0BZg/m6FBlaYOzN43vfrlrWE6vceDC1bR6wAvZZPj72DD0=
X-Gm-Message-State: AOJu0YzPAIGQWF9VwlRtNF3TyQ0oYecXILvnODppjg08IE1mAG5TJcKu
	AgyJw1gAgK0NcL6vKpQA3p5af8eoe/AYXQ+Xo9RsyORMv1y5fQehHcWV22+WPdRpcL1WLyO9JgG
	ZXKP5Ce4hU+2BC6C2t47EiQMxeTjakRkJfKYitNAHHrCvPFV7mjuYhq9SPd7cskzQFRqJDS/Hrz
	aDZvNkDA/m1UKLipN6EJ3wyfJ0uVvkKJzVkNUgoI8=
X-Received: by 2002:a05:6a20:3d81:b0:1b5:d173:338c with SMTP id adf61e73a8af0-1bae7ec2a28mr11600568637.23.1718672822399;
        Mon, 17 Jun 2024 18:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvf4Etp1GzcVYx2dfIeUkqzF/pKBrSFdI6jBLG6222RdaiDikMU2wm6YBHe9aht4nrx27/ai4QkQoeb5S+6PE=
X-Received: by 2002:a05:6a20:3d81:b0:1b5:d173:338c with SMTP id
 adf61e73a8af0-1bae7ec2a28mr11600545637.23.1718672822012; Mon, 17 Jun 2024
 18:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
 <20240614063933.108811-12-xuanzhuo@linux.alibaba.com> <CACGkMEsWg95zXVsnDWrAU1qRS0uuEJJR0rw7LVOV-fGuBGzQCQ@mail.gmail.com>
 <1718610681.9219804-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1718610681.9219804-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:06:50 +0800
Message-ID: <CACGkMEsn8h9UCy66i_N6zOPbW7V=fSswPWRjsjJFKc310YUu3g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 11/15] virtio_net: xsk: tx: support xmit xsk buffer
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

On Mon, Jun 17, 2024 at 3:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 17 Jun 2024 14:30:07 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Jun 14, 2024 at 2:40=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The driver's tx napi is very important for XSK. It is responsible for
> > > obtaining data from the XSK queue and sending it out.
> > >
> > > At the beginning, we need to trigger tx napi.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 121 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 119 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 2767338dc060..7e811f392768 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -535,10 +535,13 @@ enum virtnet_xmit_type {
> > >         VIRTNET_XMIT_TYPE_SKB,
> > >         VIRTNET_XMIT_TYPE_XDP,
> > >         VIRTNET_XMIT_TYPE_DMA,
> > > +       VIRTNET_XMIT_TYPE_XSK,
> > >  };
> > >
> > >  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_XDP \
> > > -                               | VIRTNET_XMIT_TYPE_DMA)
> > > +                               | VIRTNET_XMIT_TYPE_DMA | VIRTNET_XMI=
T_TYPE_XSK)
> > > +
> > > +#define VIRTIO_XSK_FLAG_OFFSET 4
> > >
> > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > >  {
> > > @@ -768,6 +771,10 @@ static void __free_old_xmit(struct send_queue *s=
q, bool in_napi,
> > >                          * func again.
> > >                          */
> > >                         goto retry;
> > > +
> > > +               case VIRTNET_XMIT_TYPE_XSK:
> > > +                       /* Make gcc happy. DONE in subsequent commit =
*/
> >
> > This is probably a hint that the next patch should be squashed here.
>
> The code for the xmit patch is more. So I separate the code out.
>
> >
> > > +                       break;
> > >                 }
> > >         }
> > >  }
> > > @@ -1265,6 +1272,102 @@ static void check_sq_full_and_disable(struct =
virtnet_info *vi,
> > >         }
> > >  }
> > >
> > > +static void *virtnet_xsk_to_ptr(u32 len)
> > > +{
> > > +       unsigned long p;
> > > +
> > > +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> > > +
> > > +       return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XSK)=
;
> > > +}
> > > +
> > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > > +{
> > > +       sg->dma_address =3D addr;
> > > +       sg->length =3D len;
> > > +}
> > > +
> > > +static int virtnet_xsk_xmit_one(struct send_queue *sq,
> > > +                               struct xsk_buff_pool *pool,
> > > +                               struct xdp_desc *desc)
> > > +{
> > > +       struct virtnet_info *vi;
> > > +       dma_addr_t addr;
> > > +
> > > +       vi =3D sq->vq->vdev->priv;
> > > +
> > > +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> > > +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> > > +
> > > +       sg_init_table(sq->sg, 2);
> > > +
> > > +       sg_fill_dma(sq->sg, sq->xsk.hdr_dma_address, vi->hdr_len);
> > > +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> > > +
> > > +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> > > +                                   virtnet_xsk_to_ptr(desc->len), GF=
P_ATOMIC);
> > > +}
> > > +
> > > +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> > > +                                 struct xsk_buff_pool *pool,
> > > +                                 unsigned int budget,
> > > +                                 u64 *kicks)
> > > +{
> > > +       struct xdp_desc *descs =3D pool->tx_descs;
> > > +       bool kick =3D false;
> > > +       u32 nb_pkts, i;
> > > +       int err;
> > > +
> > > +       budget =3D min_t(u32, budget, sq->vq->num_free);
> > > +
> > > +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
> > > +       if (!nb_pkts)
> > > +               return 0;
> > > +
> > > +       for (i =3D 0; i < nb_pkts; i++) {
> > > +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> > > +               if (unlikely(err)) {
> > > +                       xsk_tx_completed(sq->xsk.pool, nb_pkts - i);
> > > +                       break;
> >
> > Any reason we don't need a kick here?
>
> After the loop, I checked the kick.
>
> Do you mean kick for the packet that encountered the error?

Nope, I mis-read the code but kick is actually i =3D=3D 0 here.

>
>
> >
> > > +               }
> > > +
> > > +               kick =3D true;
> > > +       }
> > > +
> > > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notif=
y(sq->vq))
> > > +               (*kicks)++;
> > > +
> > > +       return i;
> > > +}
> > > +
> > > +static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_=
pool *pool,
> > > +                            int budget)
> > > +{
> > > +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > > +       struct virtnet_sq_free_stats stats =3D {};
> > > +       u64 kicks =3D 0;
> > > +       int sent;
> > > +
> > > +       __free_old_xmit(sq, true, &stats);
> > > +
> > > +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > > +
> > > +       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > > +               check_sq_full_and_disable(vi, vi->dev, sq);
> > > +
> > > +       u64_stats_update_begin(&sq->stats.syncp);
> > > +       u64_stats_add(&sq->stats.packets, stats.packets);
> > > +       u64_stats_add(&sq->stats.bytes,   stats.bytes);
> > > +       u64_stats_add(&sq->stats.kicks,   kicks);
> > > +       u64_stats_add(&sq->stats.xdp_tx,  sent);
> > > +       u64_stats_update_end(&sq->stats.syncp);
> > > +
> > > +       if (xsk_uses_need_wakeup(pool))
> > > +               xsk_set_tx_need_wakeup(pool);
> > > +
> > > +       return sent =3D=3D budget;
> > > +}
> > > +
> > >  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> > >                                    struct send_queue *sq,
> > >                                    struct xdp_frame *xdpf)
> > > @@ -2707,6 +2810,7 @@ static int virtnet_poll_tx(struct napi_struct *=
napi, int budget)
> > >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > >         unsigned int index =3D vq2txq(sq->vq);
> > >         struct netdev_queue *txq;
> > > +       bool xsk_busy =3D false;
> > >         int opaque;
> > >         bool done;
> > >
> > > @@ -2719,7 +2823,11 @@ static int virtnet_poll_tx(struct napi_struct =
*napi, int budget)
> > >         txq =3D netdev_get_tx_queue(vi->dev, index);
> > >         __netif_tx_lock(txq, raw_smp_processor_id());
> > >         virtqueue_disable_cb(sq->vq);
> > > -       free_old_xmit(sq, true);
> > > +
> > > +       if (sq->xsk.pool)
> > > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk.pool, budge=
t);
> >
> > How about rename this to "xsk_sent"?
>
>
> OK
>
> Thanks.
>
>
> >
> > > +       else
> > > +               free_old_xmit(sq, true);
> > >
> > >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > >                 if (netif_tx_queue_stopped(txq)) {
> > > @@ -2730,6 +2838,11 @@ static int virtnet_poll_tx(struct napi_struct =
*napi, int budget)
> > >                 netif_tx_wake_queue(txq);
> > >         }
> > >
> > > +       if (xsk_busy) {
> > > +               __netif_tx_unlock(txq);
> > > +               return budget;
> > > +       }
> > > +
> > >         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > >
> > >         done =3D napi_complete_done(napi, 0);
> > > @@ -5715,6 +5828,10 @@ static void virtnet_sq_free_unused_buf(struct =
virtqueue *vq, void *buf)
> > >         case VIRTNET_XMIT_TYPE_DMA:
> > >                 virtnet_sq_unmap(sq, &buf);
> > >                 goto retry;
> > > +
> > > +       case VIRTNET_XMIT_TYPE_XSK:
> > > +               /* Make gcc happy. DONE in subsequent commit */
> > > +               break;
> > >         }
> > >  }
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
> > Thanks
> >
>

