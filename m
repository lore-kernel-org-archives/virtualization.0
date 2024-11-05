Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4824D9FE
	for <virtualization@lists.linux.dev>; Tue,  5 Nov 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777047; cv=none; b=IVdWgEn4jeD97DeQXMtLzHU0xK/Xxwte8qnym+QcIkJDlHuyJ4EhJj56IgZ6g5pVmf5+4FqRpdRzEdE1Gp8MMB5geY31dDvdwukKHYUT2NI2UpE7rPORC8u5GhpR9CsXL/KsVZRVtZilaiH5pyA9A92Lv914RAhxzyDc31GuKS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777047; c=relaxed/simple;
	bh=5QUHgNsVFQlVu3u6ggbOA3TAqcHXnvWxj+mlox2vBQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh+5JfvVTR3V5/JcqqHfiOF8e80jF3Jg0CutuqToBORZp36jeDetcik5z3xo10DssEl6Ngfy2zu+Xhts8KJWjz3Q8HguY99GAPX5QexpgL9ohEAhJ0p5csZuBrkGkz3gINLJgsHtOCWV0tL/bCbV6ivHv51JkcQHnlDj0avY2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkNy8tPX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkNy8tPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730777045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5n1SqOXBxh35CLZ/E76FYksVvJeG9eAJd+Pgox1e9A=;
	b=DkNy8tPXMj+WsVyqheSyAO+i4iQgTh76ucvF5vSeA+ii+ekepmcDdcqRsTBWozIwfOyRd4
	iwDHwscbkw1ydBOHVTbo6Meo54mQ4qM05PbBtCUTh4KrZxziG+/5Xi/bBOb+JO/F0Lgits
	yk8HF5p3YvJXgCv/pLAOpIu5t0F7k08=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Lefl7zqLOsm-J6RdbtYKKQ-1; Mon, 04 Nov 2024 22:24:03 -0500
X-MC-Unique: Lefl7zqLOsm-J6RdbtYKKQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20c9fe994daso51800835ad.2
        for <virtualization@lists.linux.dev>; Mon, 04 Nov 2024 19:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777043; x=1731381843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5n1SqOXBxh35CLZ/E76FYksVvJeG9eAJd+Pgox1e9A=;
        b=SB2MMW87gKUa15AsPy0kUVrRWiejRB0BTL+5e7/EWr0yBBChHc4ORCEeL5oR41m0ih
         8YhI2BYRaR2lgDv7uF9fh5OHJ/xJljqDtX+Dgaz+yRqGkIXkuKhKIvxdLXMQnOMpbX7R
         nrZXSUKYAP9o+iNUVUtJVNIgGllPldIfP9Bkf7oaWardSA+6trthO/HnLC9BuT6IizhX
         acFraYnHQBIp2bcCcCHhH0EaBXASx/Ez4igXRdlxG649T32WzfMluyazJT+xAHKuiDU2
         H5v/OVHxySfkfslYrxljKZGYz8KOGcUdFfKiR57V4gNLw2xrdhcvlPoXb4QVfePdG9r8
         pqnw==
X-Forwarded-Encrypted: i=1; AJvYcCXYPnP4eJmbCmhNkLaFV9Cn6BMoH0C6lFjwhN75FhCIcib3d1tEHiIlje8P28e+nrxkpNa1r3iOztR3ijhrxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDi42oJ8p/9Ql8s5QLh6Aaw62ThUHt9+AApYDl6Mxf5EkUQhXf
	7/wVtZKuYyhIAand1KfliKGAin+CX171FBDlTYDBbi+yQe4hN4nH6aE4brM+523d5Hgp/AoxQjE
	VouSLxFkZG5iGXoHkujQiU0Q2pZvxTZTWqdUG1fOxWdB21dxRLTNYyEEUs3tpao8KT0hb2krJSc
	gKdeX7JS8HqQ2AdlNhuxPBU5qhq64REO0ORD269Qg=
X-Received: by 2002:a17:903:2b06:b0:20c:d5d9:95dc with SMTP id d9443c01a7336-210f76d67cfmr268475865ad.40.1730777042669;
        Mon, 04 Nov 2024 19:24:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaIDVC9Qi5Y2fDkClwQoOViLbl1azvUa3CWlVG9p2ehPtLvN2mbt9WVC/NUU9tEoAThf431M26JAZ/sT5va9E=
X-Received: by 2002:a17:903:2b06:b0:20c:d5d9:95dc with SMTP id
 d9443c01a7336-210f76d67cfmr268475545ad.40.1730777042172; Mon, 04 Nov 2024
 19:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 11:23:50 +0800
Message-ID: <CACGkMEviCSEo4thkFo8gYnv+FCm-v65umJ65fdOwtxbAF_F2Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/13] virtio-net: rq submits premapped per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtio-net rq submits premapped per-buffer by setting sg page to NULL;
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 792e9eadbfc3..09757fa408bd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -542,6 +542,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
>         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLA=
G);
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;

This may work but I think it's better to reuse existing dma sg helpers like=
:

sg_dma_address(sg) =3D addr;
sg_dma_length(sg) =3D len;

And we probably need to fix the virtio core which only uses
sg_dma_address() but not sg_dma_length().

This helps us to avoid future issues when CONFIG_NEED_SG_DMA_LENGTH is set.

Others look good.

Thanks

> +}
> +
>  static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *=
txq,
>                             bool in_napi, struct virtnet_sq_free_stats *s=
tats)
>  {
> @@ -915,8 +921,7 @@ static void virtnet_rq_init_one_sg(struct receive_que=
ue *rq, void *buf, u32 len)
>         addr =3D dma->addr - sizeof(*dma) + offset;
>
>         sg_init_table(rq->sg, 1);
> -       rq->sg[0].dma_address =3D addr;
> -       rq->sg[0].length =3D len;
> +       sg_fill_dma(rq->sg, addr, len);
>  }
>
>  static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t =
gfp)
> @@ -1068,12 +1073,6 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> -static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> -{
> -       sg->dma_address =3D addr;
> -       sg->length =3D len;
> -}
> -
>  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>                                    struct receive_queue *rq, void *buf, u=
32 len)
>  {
> @@ -1354,7 +1353,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_i=
nfo *vi, struct receive_queue
>                 sg_init_table(rq->sg, 1);
>                 sg_fill_dma(rq->sg, addr, len);
>
> -               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[=
i], gfp);
> +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, =
xsk_buffs[i],
> +                                                   NULL, true, gfp);
>                 if (err)
>                         goto err;
>         }
> @@ -2431,7 +2431,8 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
>
>         virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>
> -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
> +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
,
> +                                           rq->do_dma, gfp);
>         if (err < 0) {
>                 if (rq->do_dma)
>                         virtnet_rq_unmap(rq, buf, 0);
> @@ -2546,7 +2547,8 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>         virtnet_rq_init_one_sg(rq, buf, len);
>
>         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
> +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx=
,
> +                                           rq->do_dma, gfp);
>         if (err < 0) {
>                 if (rq->do_dma)
>                         virtnet_rq_unmap(rq, buf, 0);
> --
> 2.32.0.3.g01195cf9f
>

