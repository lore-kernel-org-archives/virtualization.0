Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FA6FAE
	for <virtualization@lists.linux.dev>; Thu, 25 Jan 2024 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153961; cv=none; b=sxBHyKTd2F7aNE6tClbF109OPE9m2p55IAuTRGBUNYRU9dKALXRvF9L3Ak/OYultagdIHZ4pd6tpIcj4TvLNbgZ9LrKTDK4kNsb+7kyTyaSQO8vTLR/l0EFLOIvjjCpAiF2+zDOi7uxPwF8NYUtugEF3zwQkRL3H61Yj8vk3uEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153961; c=relaxed/simple;
	bh=aYtraKeg/phW07/7iPMWoTxqzaJdJOv0+Sxt7exwBJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYiMzUJFrIlkezfOujzcJvCRv/Zgj8+MCXKiUJ+N6yHQezUXtiUv3QzaISkwhHin536ocNEbR1Hl8oTNSHB78R6v+v4mpLan1r46xvEWJcJ739PfTGOATY22dr/YlzvtGFEFTN4buZyO8Pz3MNKKObfFtpjz0gqxCU/xEyGJkdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHy9lIB/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHy9lIB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706153958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+kv1E8M93VST5z9hGMNp++MAPNLoKeq0RXuFtSVRPM=;
	b=VHy9lIB/8j8ZlgqWfAC2o5Ee0qR3aT3XvK1ll3WmvcPm289JNJnb5DAdsuZO9OwfGz/bhd
	pMNbO5sibE3T6LW/4Gztxp14fgw5AJQoKVboNCrzBXmLfeWJm/V/fOB9DTz4Tm6Jhstb1R
	M6pEI0xgq37YtdpfKqJB559GfXE5VTY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-METGoC5LPg-hLD8E3Vv0vg-1; Wed, 24 Jan 2024 22:39:16 -0500
X-MC-Unique: METGoC5LPg-hLD8E3Vv0vg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5ce10b4cea9so276032a12.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 19:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706153955; x=1706758755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+kv1E8M93VST5z9hGMNp++MAPNLoKeq0RXuFtSVRPM=;
        b=Q2isduIyIEmOEDgFnLF4CtZ7PnfiYffw4odsNlPV07PW5YjYa3/98bAUJEtcQAeAyQ
         ydzUIqwhKbbHxcR3BnRf3xh04o407JijFPVOgB/bCV0aW3tcyXR3ua3SGhinBiDnu0bA
         nv4xpBU3G8o+WGUtqGlcl45E7biLUPjDm9WTA6D5d5QvBnozqAUx7KfmASUlNfo1On0o
         nAsFMqBohty/DSjCk7CK8jOhglJd6/szBrycVOqvJAgfdZVeeK3mE1Dd4qi2pbZp3hTG
         9Njd5bVSVP7yFY0gmGbImfwHCj1qqNV3ZiVyXvtajbZhSFpR3VYrhqLKWeDNuAWeuA6F
         q78Q==
X-Gm-Message-State: AOJu0YzspumXdySwuzUZhbekeTY8/WJtq7TRJhLC0BGV57sozoFhzJGq
	f8KwEjHcLs73Vk9Pwagtu7ve08mNEKCfjC2o9kSXQBVWwQK+/QlUnITTMiDsKFsvd2EzdwGPSjp
	s99GtEWKFyKlK2t/Dw2VQhk42rS2Fzj/99vUVicibRg9qssqhkUq5XulyokuSGXq2JgrBmome+a
	WyMSW+J7MPCLOMfBYQhM5F9dTMHocBjlqnl5L+2Uo=
X-Received: by 2002:a05:6a20:938d:b0:19a:f0ef:ffc with SMTP id x13-20020a056a20938d00b0019af0ef0ffcmr561791pzh.3.1706153954772;
        Wed, 24 Jan 2024 19:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVvYsNNKLu8vKw6h7D0IpqxiuwRhcQvL/n+p++mwu2Jx6DGQNuoinfcujLAu57LUqNpXdniTVSTxpEPUGA4Ms=
X-Received: by 2002:a05:6a20:938d:b0:19a:f0ef:ffc with SMTP id
 x13-20020a056a20938d00b0019af0ef0ffcmr561774pzh.3.1706153954482; Wed, 24 Jan
 2024 19:39:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com> <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240116075924.42798-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:39:03 +0800
Message-ID: <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Introduce helper virtqueue_get_dma_premapped(), then the driver
> can know whether dma unmap is needed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c       | 22 +++++++++-------------
>  drivers/net/virtio/virtio_net.h |  3 ---
>  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
>  include/linux/virtio.h          |  1 +
>  4 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 186b2cf5d8fc..4fbf612da235 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq=
, u32 *len, void **ctx)
>         void *buf;
>
>         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -       if (buf && rq->do_dma)
> +       if (buf && virtqueue_get_dma_premapped(rq->vq))
>                 virtnet_rq_unmap(rq, buf, *len);
>
>         return buf;
> @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct virtnet_rq =
*rq, void *buf, u32 len)
>         u32 offset;
>         void *head;
>
> -       if (!rq->do_dma) {
> +       if (!virtqueue_get_dma_premapped(rq->vq)) {
>                 sg_init_one(rq->sg, buf, len);
>                 return;
>         }
> @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, =
u32 size, gfp_t gfp)
>
>         head =3D page_address(alloc_frag->page);
>
> -       if (rq->do_dma) {
> +       if (virtqueue_get_dma_premapped(rq->vq)) {
>                 dma =3D head;
>
>                 /* new pages */
> @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct virtnet_=
info *vi)
>         if (!vi->mergeable_rx_bufs && vi->big_packets)
>                 return;
>
> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> -
> -               vi->rq[i].do_dma =3D true;
> -       }
> +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> +               virtqueue_set_dma_premapped(vi->rq[i].vq);
>  }
>
>  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct virtnet_rq *rq,
>
>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>         if (err < 0) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>                 put_page(virt_to_head_page(buf));
>         }
> @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>         if (err < 0) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>                 put_page(virt_to_head_page(buf));
>         }
> @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct virtnet_=
info *vi)
>         int i;
>         for (i =3D 0; i < vi->max_queue_pairs; i++)
>                 if (vi->rq[i].alloc_frag.page) {
> -                       if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> +                       if (virtqueue_get_dma_premapped(vi->rq[i].vq) && =
vi->rq[i].last_dma)
>                                 virtnet_rq_unmap(&vi->rq[i], vi->rq[i].la=
st_dma, 0);
>                         put_page(vi->rq[i].alloc_frag.page);
>                 }
> @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(struct virt=
queue *vq)
>         rq =3D &vi->rq[i];
>
>         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> -               if (rq->do_dma)
> +               if (virtqueue_get_dma_premapped(rq->vq))
>                         virtnet_rq_unmap(rq, buf, 0);
>
>                 virtnet_rq_free_buf(vi, rq, buf);
> diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_=
net.h
> index b28a4d0a3150..066a2b9d2b3c 100644
> --- a/drivers/net/virtio/virtio_net.h
> +++ b/drivers/net/virtio/virtio_net.h
> @@ -115,9 +115,6 @@ struct virtnet_rq {
>
>         /* Record the last dma info to free after new pages is allocated.=
 */
>         struct virtnet_rq_dma *last_dma;
> -
> -       /* Do dma by self */
> -       bool do_dma;
>  };
>
>  struct virtnet_info {
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2c5089d3b510..9092bcdebb53 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtqueue *=
_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
>
> +/**
> + * virtqueue_get_dma_premapped - get the vring premapped mode
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Get the premapped mode of the vq.
> + *
> + * Returns bool for the vq premapped mode.
> + */
> +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       bool premapped;
> +
> +       START_USE(vq);
> +       premapped =3D vq->premapped;
> +       END_USE(vq);

Why do we need to protect premapped like this? Is the user allowed to
change it on the fly?

Thanks

