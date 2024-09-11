Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F33A1C9
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027705; cv=none; b=EFf9+hRD+xdzlYfzONIDnXMz4CdsyzEzg+10jcz4vPQ1Ub/Gpen+Hg7HtFfpDSR9ZmxCLYSWNrYOBniDjP/TLAAyaFwZ47x8B+OSMmsYbCmcjG1PZrCA7+TGfT+ShC8vPmGL0zXI1CF2ZYjZcqRUcWg4d0Aq2fiZilPphMRCDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027705; c=relaxed/simple;
	bh=AVhZdGRu8dpeR4b4F2jgIvNalKXiUOled0MascdxuZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcONwTrdYJPubJwghtUEL8xfByTcBPWbBKHWtHh0luBZlyrLYXIbNm3OdlKFnXj9+RAsGh2Ojm/0iEEJhbqa6KSfnbVsrnpXH+YbEklZM/5mucELi7oCkI2jRTrVsdkrqvL1U0g87UrDYvwOr4da0gmJf19zS862X3UlUp27ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjKo1bWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjKo1bWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726027702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0shg6ORiFzwW+Vj2RjyGiWTgW5vV9/QyPqZaO+umrw=;
	b=EjKo1bWp6ixO24GKWJKsGrYqwotLzADCrVPZ9bElTqfzms5ldRwQ3+XBYBQhCIte3Xktw6
	wv7MT+QR3vy0UouYy0WDlA3le3Blt/l9BNDmUa6FldWholTbtnmF7KrkvbOGZ4N6S3kwhJ
	3Qb7wRuI7hPEfIvfnuhdpOxXZ0aHnj0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sdK26LYfMJWUebXlWylytg-1; Wed, 11 Sep 2024 00:08:19 -0400
X-MC-Unique: sdK26LYfMJWUebXlWylytg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d8e7e427d5so522567a91.0
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 21:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726027698; x=1726632498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0shg6ORiFzwW+Vj2RjyGiWTgW5vV9/QyPqZaO+umrw=;
        b=DqEoENpr6KRSW1a0gzLcVWWQ4hLKlvRynjOd5GDWfr+K9cx5au7xbZaHE/17KNtki8
         icJTocas9KzeybMm3/2LyHmnWEFpFL+kyVPuXMvcqZ/nGkm1ggq8qRXxv7PEtc8xqczn
         qK+eadGGYNBbNzKqAmLQBFz64YcVM2o0Z37yp6786dNskxwxUkUwzzte+8+z54H/DVTy
         Nol2kpLF9+gyorgeiaPWM7ZBESFBsauTuy4FA6OINHWRN7hjptOUZq7fFusYNZDC7xfC
         A9fPNkMrivNe1RqzVCYeNxqP7Pg7URLUrjjr0wnmIc5+eHqwb415W05R40h6xtEs8EOf
         AqNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9DTELbSTEK6Sopv8bwFJ807hVtH2Dl1Y+WS2Ejm1X43iARkjncVVvMlGyqQVXwUQMKVMLcIV4+0NwG9eioA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yztywi8MO8yGI96LEshnbtIyST8ejcynFhOl1GxmQxPftSEdz/K
	ZUO76PK825EX3AGAJmtEdi273JdE1A8PeOVPWjl6X0tro/DvwRS98tsNJaLD1am5iGkqPJKoRp0
	LCaNMqasufK6L0fo9EFM9eOwk46CnmaHk694x8diIGu8VbdWRGmuXBcp5+i2s+NS5D+8TBAOo2A
	/Ar7oL0T6rXM6z7dDDweWO6rV75mAvUCn73Q3iUSQ=
X-Received: by 2002:a17:90b:c11:b0:2da:5863:fdbd with SMTP id 98e67ed59e1d1-2db6722519fmr7937417a91.17.1726027698113;
        Tue, 10 Sep 2024 21:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOcqVGVU9kAqU8Id60TW/drK/kX8DW3MCRfobzzdGZzCl0LDs7xbjJclqvOwKSLXmBDAI4DTN/H3ftyXYI1ac=
X-Received: by 2002:a17:90b:c11:b0:2da:5863:fdbd with SMTP id
 98e67ed59e1d1-2db6722519fmr7937359a91.17.1726027697475; Tue, 10 Sep 2024
 21:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:08:06 +0800
Message-ID: <CACGkMEuD9kp5Mgpqu+zszcYsiAyX_H-A-LfPM+YJPijeUtWJcw@mail.gmail.com>
Subject: Re: [PATCH net-next 08/13] virtio_net: xsk: bind/unbind xsk for tx
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
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 54 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 96abee36738b..6a36a204e967 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -295,6 +295,10 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       struct xsk_buff_pool *xsk_pool;
> +
> +       dma_addr_t xsk_hdr_dma_addr;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -494,6 +498,8 @@ struct virtio_net_common_hdr {
>         };
>  };
>
> +static struct virtio_net_common_hdr xsk_hdr;
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
>                                struct net_device *dev,
> @@ -5476,6 +5482,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet=
_info *vi, struct receive_queu
>         return err;
>  }
>
> +static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> +                                   struct send_queue *sq,
> +                                   struct xsk_buff_pool *pool)
> +{
> +       int err, qindex;
> +
> +       qindex =3D sq - vi->sq;
> +
> +       virtnet_tx_pause(vi, sq);
> +
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       if (err) {
> +               netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
> +               pool =3D NULL;
> +       }
> +
> +       sq->xsk_pool =3D pool;
> +
> +       virtnet_tx_resume(vi, sq);
> +
> +       return err;
> +}
> +
>  static int virtnet_xsk_pool_enable(struct net_device *dev,
>                                    struct xsk_buff_pool *pool,
>                                    u16 qid)
> @@ -5484,6 +5513,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>         struct receive_queue *rq;
>         struct device *dma_dev;
>         struct send_queue *sq;
> +       dma_addr_t hdr_dma;
>         int err, size;
>
>         if (vi->hdr_len > xsk_pool_get_headroom(pool))
> @@ -5521,6 +5551,10 @@ static int virtnet_xsk_pool_enable(struct net_devi=
ce *dev,
>         if (!rq->xsk_buffs)
>                 return -ENOMEM;
>
> +       hdr_dma =3D dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO=
_DEVICE);

Let's use the virtqueue_dma_xxx() wrappers here.

> +       if (dma_mapping_error(dma_dev, hdr_dma))
> +               return -ENOMEM;
> +
>         err =3D xsk_pool_dma_map(pool, dma_dev, 0);
>         if (err)
>                 goto err_xsk_map;
> @@ -5529,11 +5563,23 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
>         if (err)
>                 goto err_rq;
>
> +       err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
> +       if (err)
> +               goto err_sq;
> +
> +       /* Now, we do not support tx offset, so all the tx virtnet hdr is=
 zero.
> +        * So all the tx packets can share a single hdr.
> +        */
> +       sq->xsk_hdr_dma_addr =3D hdr_dma;
> +
>         return 0;
>
> +err_sq:
> +       virtnet_rq_bind_xsk_pool(vi, rq, NULL);
>  err_rq:
>         xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> +       dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
>         return err;
>  }
>
> @@ -5542,19 +5588,27 @@ static int virtnet_xsk_pool_disable(struct net_de=
vice *dev, u16 qid)
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         struct xsk_buff_pool *pool;
>         struct receive_queue *rq;
> +       struct device *dma_dev;
> +       struct send_queue *sq;
>         int err;
>
>         if (qid >=3D vi->curr_queue_pairs)
>                 return -EINVAL;
>
> +       sq =3D &vi->sq[qid];
>         rq =3D &vi->rq[qid];
>
>         pool =3D rq->xsk_pool;
>
>         err =3D virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +       err |=3D virtnet_sq_bind_xsk_pool(vi, sq, NULL);
>
>         xsk_pool_dma_unmap(pool, 0);
>
> +       dma_dev =3D virtqueue_dma_dev(sq->vq);
> +
> +       dma_unmap_single(dma_dev, sq->xsk_hdr_dma_addr, vi->hdr_len, DMA_=
TO_DEVICE);

And here.

Thanks

> +
>         kvfree(rq->xsk_buffs);
>
>         return err;
> --
> 2.32.0.3.g01195cf9f
>

