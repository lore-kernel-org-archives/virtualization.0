Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BC1482F3
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163323; cv=none; b=ngL8iSP1Ov5sjtA5q4vzuRAf0ZIbDeRTYyVQSRkutbFWZ0yzz67nEiWyiTLxOLOM5ruZO4FWw8g1PNsDCG79FP8eY2ToCGb76kJ0v/MXnY4LjtL8x2JQENsIHDv8morAFXQtFUkuEq7gQbZ+4Tus6V//cdNEhptqBDDVIFC/pjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163323; c=relaxed/simple;
	bh=JOzBpmaTzmLzwSByr9HHunTnYotVyhV0Tr9z778H/xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUMIVVv3HcjSR63yAP0W7eV70G9PQXXGouadN6O6TpqERHhaVK+v5bYgwho2243hPjREQiuRlTAJ/y3ko2in0DlCVIfkfB1xofjchThKp5r5y6FKsLuYwfvBAWtiDixSVYbcp1wKJucYO5uQ1s2xgv98MYec1KARNPGKXSklYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPWUQo6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPWUQo6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMLq1dERUaIKsogPS0ztdyTC78eUZtqilgCMzyVl9Bk=;
	b=fPWUQo6jJ/tRvx9kYtCGNLI3i7BRVx+gc/iOUbni0RJxXY61UvHFX+NREbEVzkrs0Ejq0b
	s7H5plmZ1dQoPdtKooxmpQDUrmHEmQMgZFsSE02nAK/tgZtmRR4I27f0TFy3WNCRRPIoGq
	BI2wIMuIMTk0qWThukSWb1gPGONDkoQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-9x_b9Mk3Oamd07Q3mEmRwA-1; Tue, 24 Sep 2024 03:35:20 -0400
X-MC-Unique: 9x_b9Mk3Oamd07Q3mEmRwA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2db446a3d28so7649325a91.2
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 00:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163319; x=1727768119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMLq1dERUaIKsogPS0ztdyTC78eUZtqilgCMzyVl9Bk=;
        b=HER+WBogely8FHRGJwab+RKr9D7Vcea2RBZvox0nmJYcoNXS0kzatjlVRec4VNlscH
         Oo51o03IYKOINVy+LjFz3uPjStuR1DIQWKUlm0DMUhlljVr83AJWaJCQdnalOUxJ1Q/r
         OsQSOUPmKElbcKvgUwpIkgb2S8arN7MDNNf7/osE1ks/Nj6qh8p7XKDWZOcoYcDsqSjv
         S5fMFwiK/e5UQKiqfG5LaRHzvb0RA6tBc9YYd5SAj1D1s3/OuvyOXeufTt8ZTiLjzxvt
         UMDjt1O/yHOX77idnU40a6RyGZMoC66tpt7+dE4F0KUUgQ704vuihB0iQU5jUkwxzv0X
         Cksg==
X-Forwarded-Encrypted: i=1; AJvYcCXsbMmG2zHQ2jDNL4ZIO2lOE+5nLTq/H0pvAodH1NTbumPUAcUp+wVo+ZnWQwdp+NKQHfxE7r17u/wwISdN2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8Ffy4ZDgXn+EhoJatiqbdMSfticmhhGQhY3WVwVWq0qdRCp8m
	+NDpijFai/Qfth5ifVbzGQIhCuXjhW8337kG7vFENNRv0TOkrXwDvLOshd78Ff9orWQawTbQnxI
	LIowHPCg6CEof3dDQVlD/a275b7K23ppk2zazxz7L+VdHReWp1C0U6/Imulx0EcQHWzuvd7r3+A
	S9G5BuLkH2dx0Rmy2FytOwRjNgYjO/2XCD/7LuKaQ=
X-Received: by 2002:a17:90a:9c8:b0:2e0:5959:1414 with SMTP id 98e67ed59e1d1-2e0595917e9mr2146680a91.10.1727163318885;
        Tue, 24 Sep 2024 00:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe50DNaDeyvcCchm9NAfLGNcC32Ud2Mm4+AUKBbVitVveA9Tm2QDEX75dDDoxKs74StXm+QFdjFY48RfujhvU=
X-Received: by 2002:a17:90a:9c8:b0:2e0:5959:1414 with SMTP id
 98e67ed59e1d1-2e0595917e9mr2146654a91.10.1727163318470; Tue, 24 Sep 2024
 00:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:05 +0800
Message-ID: <CACGkMEsTpJV=dQUHMWTnzuSmGTqdEKz4jYygHtbXGtA0q3HnoA@mail.gmail.com>
Subject: Re: [RFC net-next v1 08/12] virtio_net: xsk: bind/unbind xsk for tx
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

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch implement the logic of bind/unbind xsk pool to sq and rq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 41a5ea9b788d..7c379614fd22 100644
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
> @@ -497,6 +501,8 @@ struct virtio_net_common_hdr {
>         };
>  };
>
> +static struct virtio_net_common_hdr xsk_hdr;
> +
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
>                                struct net_device *dev,
> @@ -5488,6 +5494,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet=
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
> @@ -5496,6 +5525,7 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>         struct receive_queue *rq;
>         struct device *dma_dev;
>         struct send_queue *sq;
> +       dma_addr_t hdr_dma;
>         int err, size;
>
>         if (vi->hdr_len > xsk_pool_get_headroom(pool))
> @@ -5533,6 +5563,11 @@ static int virtnet_xsk_pool_enable(struct net_devi=
ce *dev,
>         if (!rq->xsk_buffs)
>                 return -ENOMEM;
>
> +       hdr_dma =3D virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->=
hdr_len,
> +                                                DMA_TO_DEVICE, 0);
> +       if (virtqueue_dma_mapping_error(sq->vq, hdr_dma))
> +               return -ENOMEM;
> +
>         err =3D xsk_pool_dma_map(pool, dma_dev, 0);
>         if (err)
>                 goto err_xsk_map;
> @@ -5541,11 +5576,24 @@ static int virtnet_xsk_pool_enable(struct net_dev=
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

What did you mean by "tx offset" here? (Or I don't see the connection
with vnet hdr).

Anyhow the patch looks good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

