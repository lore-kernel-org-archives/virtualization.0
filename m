Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60936171D2
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421392; cv=none; b=Nn2kVJm5BOQQx5f7Cpy36csDyXagDpLBE36uvrHfFP8YQl8pdfqH1CLgZkIfn0o4+DSwCIYzLaxiATdQgA2iRrCa4dydGq4P/nRL4nMTHGemLCXeKtFK5215knTEofy/klAiuHIlhO+S/EtFoxLyi8CGdRtvUkyz4PRbIrSwWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421392; c=relaxed/simple;
	bh=3H8vMevzIvzcJrAIQhm87D6MyRx2wml/VHmQuniqz9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4LRkASEQ4J364zC8YgtmU230eOnWPSqkhlEecIom/lugLwEWsb0iq/0J9ZaEGnW12TrgslwOlDi5vZe/Nbr4AL/0FiBJ42PQSR+FX/p3VFChY5hc+N14aIxVz2luEAqKAp4s6P6WiPUF2KGXAgBczQevhke5fLBfSuVfQWfhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inW4Efpl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inW4Efpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720421390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIbDsP10xfc6NaCkPVB60tYpkZUzdhw3HKdYVd55mQA=;
	b=inW4EfplUMUO/ebqMY+PRfXufmkxoBnLLSAb5SudC8gqlx3ca43+MMJ8pOtK+I1eLHhM9E
	T3Yala/p+y4u2DFAUYvplHWG8/J8JAXKQU+vMaMmrQycSBxTxZ+crqXeZ2iPku7OGZWPzW
	PJ3NSFmyfh4QQWdVkvAjh9lko00yD6o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-C_odZgdwNBWEt4CLEdXtFw-1; Mon, 08 Jul 2024 02:49:48 -0400
X-MC-Unique: C_odZgdwNBWEt4CLEdXtFw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70afd833ba9so1854715b3a.1
        for <virtualization@lists.linux.dev>; Sun, 07 Jul 2024 23:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421387; x=1721026187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIbDsP10xfc6NaCkPVB60tYpkZUzdhw3HKdYVd55mQA=;
        b=WIZwaTfKG98+eRT/Phf/bOYCLA32+LVAmlJoRutMjGCDPAo/S+K23dGy2LGbjTMe2M
         0hxh809D067WsmK0kFV3yABP5OrPSIgGdtmyAubQ3++pARE0bCL4P9cV8N2i11L3U+VB
         hw9Cn0VzNqgL9JHcV/eSrEcCC69PuDvQfdlK1/Ye8AbfTH1phX2S4fLqI2/0mulWtC2o
         PnIAtXjxQNg1FVbTfJOTdO/4sl7bHDZh9iF1nAC4I3Q855PgVzg/ipba5KyBh7renvxD
         4tKfXmB8+tqJD6NLO0v2YtuI37dRKetzD5mexYselGYMScNCVfGCJitHQ+S9oV/3fB2a
         SjNw==
X-Forwarded-Encrypted: i=1; AJvYcCXb0uRtuEVOTJaxuYX+lpJzn8EzVLmj/DudFLZ12KPq5zOCnLxL1hTnRkTE5fHQ/eturrlsYsUbwsnUk20hNEcfI5p5YcAI0cmwDh9Cny0=
X-Gm-Message-State: AOJu0YxDimuA8k62SJCCNktTt3M8f7gDWvQVSpjpUsehUdhWn7INWUK/
	Q8ynlY8gUCKcGoceuDcbMo/9p02h5zZsvS6/gFV5Njf7LfGZ+ArJeMzDFI5ENTfTi7CR+rQKQgu
	fAI8LwDOp/Gy/G1ZLJoyF44xESkr5wJ3JuHPEGpMVdkKY0lKldvYluemctSRu00pXkCoV+yrCmh
	UCbb5iq4wrJA0P60TKG0DIjcBQ6DDqhv+UCphuAGU=
X-Received: by 2002:a05:6a00:1da2:b0:706:6962:4b65 with SMTP id d2e1a72fcca58-70b009520a4mr7278060b3a.14.1720421387503;
        Sun, 07 Jul 2024 23:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiSyNQPaBEraFONt6FsI9Zk4on4jhj/4ZYxZehc8znesk8Dw39LiQoxSTRODV1PG/sr19cHEtsdkkC0A7SZxw=
X-Received: by 2002:a05:6a00:1da2:b0:706:6962:4b65 with SMTP id
 d2e1a72fcca58-70b009520a4mr7278051b3a.14.1720421387131; Sun, 07 Jul 2024
 23:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:49:35 +0800
Message-ID: <CACGkMEvW72oG-HsLiOwKdUkdOdKCFiyUAU6Nhj8Q4FFbnXAAqA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/10] virtio_net: xsk: rx: support fill with
 xsk buffer
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

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>
> v7:
>    1. some small fixes
>
>  drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 29fa25ce1a7f..2b27f5ada64a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -354,6 +354,8 @@ struct receive_queue {
>
>         /* xdp rxq used by xsk */
>         struct xdp_rxq_info xsk_rxq_info;
> +
> +       struct xdp_buff **xsk_buffs;
>  };
>
>  /* This structure can contain rss message with maximum settings for indi=
rection table and keysize
> @@ -1054,6 +1056,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +                                  struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +       struct xdp_buff **xsk_buffs;
> +       dma_addr_t addr;
> +       int err =3D 0;
> +       u32 len, i;
> +       int num;
> +
> +       xsk_buffs =3D rq->xsk_buffs;
> +
> +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> +       if (!num)
> +               return -ENOMEM;
> +
> +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               /* use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space */

It's better to also say we assume hdr->len is larger than
XDP_PACKET_HEADROOM. (see function xyz).

> +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len=
;
> +
> +               sg_init_table(rq->sg, 1);
> +               sg_fill_dma(rq->sg, addr, len);
> +
> +               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_buffs[=
i], gfp);
> +               if (err)
> +                       goto err;
> +       }
> +
> +       return num;
> +
> +err:
> +       if (i)
> +               err =3D i;

Any reason to assign an index to err here?

Others look good.

Thanks

