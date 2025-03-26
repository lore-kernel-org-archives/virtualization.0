Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560619A298
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992407; cv=none; b=RBmHfb/RmV9RwPx+1BApMkr/l9s5aXlpEdhAdRprt+3E5KmdR5dn2KXJfo8gQUp+pZl7qpO24HqK5NoXSsgb93thvDC7c0BuH0C/naxsmxRmkhPDtkQwLrrM/ibUKzDn8lpEshyOWzetwqecuQFL/oLDxVBCZWlbG6lteHZPYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992407; c=relaxed/simple;
	bh=N3grN2QV7gu6NVwtY15esedESYw549yVIA9oYYKyqvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRXi+W+/q8qznyWzC+xRN/p/y0grQOP1bXM9WpVwJvUB9LYHaOUFAI4GXU12RUAgM6G8/DmHdxY/i8oHoSlqNQ83e3Is/OgNGndG+nuBGximCMYRlRcaYAjhVSQB2H55Bpz6IxmsKLkZHE6kvWr+N3KlKCSveweVo8Jy04rX/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH0IhBn+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH0IhBn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h9zkBtZAENxGAjMf2g3QIo4BYdNbxYuXCOfwd31ChY=;
	b=GH0IhBn+4wiKed0308c7JRQK4NaVyGcvC6acl3sGAmj38hlHG1CxAjX8kb1jxehxvnF6eX
	1yr87B54UkPW7JiYP+ND10rCqyvdNKX4xJKgvn4nOe/U+aryUilHhhEiI0viLJWFNdjADh
	JicJV9sPnOH38vWjVMB9Bs3NQUTHp6Q=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-hizqT5goOmSMwQHRddb9Qw-1; Wed, 26 Mar 2025 08:33:22 -0400
X-MC-Unique: hizqT5goOmSMwQHRddb9Qw-1
X-Mimecast-MFC-AGG-ID: hizqT5goOmSMwQHRddb9Qw_1742992401
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30364fc706fso4383861a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992401; x=1743597201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h9zkBtZAENxGAjMf2g3QIo4BYdNbxYuXCOfwd31ChY=;
        b=L4lMjJ5/3azr0XQ7M8x8xlYTAOjjtcPlwNMxREGxV5f66rja+fbFA/bzcc787P+8SS
         BCfcfXaDCadFLjXZgU6dzffJF3MUX9ZWxwyYjCdTpDcKIsdYd7bZcRozS+kAVfec1f4B
         rtcxgimaMrczV8excEK/wcwiPlDg6Nl7vuvEV28HifM12lJgJyHWSAFKa38SRDzZPfAb
         y4M3Bg9uQPUXL5c8n/4zwfcYgfS7GlUOHsTPgpqFfZHnCLHtr3hbi4ylttn0Lglr/Tec
         YEpPiuZru11ozcg9u7tg8vXeEQ1hq6iLcKCtRPgo/s+Fjp71+tkLCdPlIrhpcZXLNg6y
         KINg==
X-Forwarded-Encrypted: i=1; AJvYcCVibWkC9MTH+TPEu7iJc9vOZvDzv5qUfx7c1Jup8eh/ksGWjPDJ5Tl5x3TSLFSa8XBTmey3mplAgJ4mTBc1OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGlvk20UK3nnLmgbaErDvau0b4w9Cr2MGgICgKIklXrNK9UuaB
	aZT240nvKn5/T/z03oYfm6yNVO7I6UpkMM9Y7ExLMTH19pawIN3aoaDmgs5/iIsTOUel+WI+is3
	yDL68ntQKHEhaKWfy8HrG/DVMojU3FSUTiPRuKiUOaPrlwbwED6CADo8wVJeQq7eXny7AMsdPSb
	/V7p69GdOlHC2CfDoOKMLm1n0vizoBxAXFGKYmFE4=
X-Gm-Gg: ASbGnctX9r+R+d26O7CSk/OXoE+YLqkA2xt+RC0nlAAemgUOGG1LC0cN2AnJZe9rV+9
	ZDR8JVG7uYDXEDG63ERzhTVCNo7Aso0VEPOjuFINGySyJYSrAYi980U1TthGqKGgeJiGI32o=
X-Received: by 2002:a17:90b:51c1:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-3030ff0dfa8mr26773240a91.32.1742992400976;
        Wed, 26 Mar 2025 05:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkJtrTwIWW7ZQ6nbvOaulTxmv88Dab//R+/xNCwb9ubPeaIKEVomqCDml25dXFpJfuz5Ql/72Ydnzl53UzWtg=
X-Received: by 2002:a17:90b:51c1:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-3030ff0dfa8mr26773192a91.32.1742992400385; Wed, 26 Mar 2025
 05:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-1-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:32:44 +0100
X-Gm-Features: AQ5f1JqKF6Qxbf62oUTBAxf2A2BZTLAqOerFJrXaOCoGW8jflzH7dxm2eXZRNOY
Message-ID: <CAJaqyWeCvT0ArsT+K4Of-+kT6uDFAT2v83bKNqKm+OeDBA5kZA@mail.gmail.com>
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AroHxiIxAhzl5RFvwoQmw6o8fV1PdH9P-Uzh8ArFa6M_1742992401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch introduces virtqueue ops which is a set of the callbacks
> that will be called for different queue layout or features. This would
> help to avoid branches for split/packed and will ease the future
> implementation like in order.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
>  1 file changed, 67 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2884eae14d9..ce1dc90ee89d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
>         size_t event_size_in_bytes;
>  };
>
> +struct vring_virtqueue;
> +
> +struct virtqueue_ops {
> +       int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> +                  unsigned int total_sg, unsigned int out_sgs,
> +                  unsigned int in_sgs, void *data,
> +                  void *ctx, bool premapped, gfp_t gfp);
> +       void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void =
**ctx);
> +       bool (*kick_prepare)(struct vring_virtqueue *vq);
> +       void (*disable_cb)(struct vring_virtqueue *vq);
> +       bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> +       unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> +       bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx)=
;
> +       void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> +       bool (*more_used)(const struct vring_virtqueue *vq);
> +       int (*resize)(struct vring_virtqueue *vq, u32 num);
> +       void (*reset)(struct vring_virtqueue *vq);
> +};
> +
>  struct vring_virtqueue {
>         struct virtqueue vq;
>
> +       struct virtqueue_ops *ops;
> +
>         /* Is this a packed ring? */
>         bool packed_ring;
>
> @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_vir=
tqueue_split *vring_split,
>         return 0;
>  }
>
> +struct virtqueue_ops split_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>                                                struct vring_virtqueue_spl=
it *vring_split,
>                                                struct virtio_device *vdev=
,
> @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>                 return NULL;
>
>         vq->packed_ring =3D false;
> +       vq->ops =3D &split_ops;
>         vq->vq.callback =3D callback;
>         vq->vq.vdev =3D vdev;
>         vq->vq.name =3D name;
> @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_vir=
tqueue *vq)
>         virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
>  }
>
> +struct virtqueue_ops packed_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index=
,
>                                                struct vring_virtqueue_pac=
ked *vring_packed,
>                                                struct virtio_device *vdev=
,
> @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_pack=
ed(unsigned int index,
>         vq->broken =3D false;
>  #endif
>         vq->packed_ring =3D true;
> +       vq->ops =3D &packed_ops;
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
>
> @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_vi=
rtqueue *vq, u32 num)
>         return -ENOMEM;
>  }
>
> +struct virtqueue_ops split_ops =3D {
> +       .add =3D virtqueue_add_split,
> +       .get =3D virtqueue_get_buf_ctx_split,
> +       .kick_prepare =3D virtqueue_kick_prepare_split,
> +       .disable_cb =3D virtqueue_disable_cb_split,
> +       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
> +       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
> +       .poll =3D virtqueue_poll_split,
> +       .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
> +       .more_used =3D more_used_split,
> +       .resize =3D virtqueue_resize_split,
> +       .reset =3D virtqueue_reset_split,
> +};
> +
> +struct virtqueue_ops packed_ops =3D {
> +       .add =3D virtqueue_add_packed,
> +       .get =3D virtqueue_get_buf_ctx_packed,
> +       .kick_prepare =3D virtqueue_kick_prepare_packed,
> +       .disable_cb =3D virtqueue_disable_cb_packed,
> +       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
> +       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
> +       .poll =3D virtqueue_poll_packed,
> +       .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
> +       .more_used =3D more_used_packed,
> +       .resize =3D virtqueue_resize_packed,
> +       .reset =3D virtqueue_reset_packed,
> +};
> +
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
>                                          void (*recycle)(struct virtqueue=
 *vq, void *buf))
>  {
> @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *=
_vq,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> -                                       out_sgs, in_sgs, data, ctx, prema=
pped, gfp) :
> -                                virtqueue_add_split(vq, sgs, total_sg,
> -                                       out_sgs, in_sgs, data, ctx, prema=
pped, gfp);
> +       return vq->ops->add(vq, sgs, total_sg,
> +                           out_sgs, in_sgs, data, ctx, premapped, gfp);
>  }
>
>  /**
> @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> -                                virtqueue_kick_prepare_split(vq);
> +       return vq->ops->kick_prepare(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>
> @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, =
unsigned int *len,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ct=
x) :
> -                                virtqueue_get_buf_ctx_split(vq, len, ctx=
);
> +       return vq->ops->get(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>
> @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (vq->packed_ring)
> -               virtqueue_disable_cb_packed(vq);
> -       else
> -               virtqueue_disable_cb_split(vq);
> +       return vq->ops->disable_cb(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>
> @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct vir=
tqueue *_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> -                                virtqueue_enable_cb_prepare_split(vq);
> +       return vq->ops->enable_cb_prepare(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>
> @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned=
 int last_used_idx)
>                 return false;
>
>         virtio_mb(vq->weak_barriers);
> -       return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx)=
 :
> -                                virtqueue_poll_split(vq, last_used_idx);
> +       return vq->ops->poll(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>
> @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> -                                virtqueue_enable_cb_delayed_split(vq);
> +       return vq->ops->enable_cb_delayed(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>
> @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueu=
e *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> -                                virtqueue_detach_unused_buf_split(vq);
> +       return vq->ops->detach_unused_buf(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
> -       return vq->packed_ring ? more_used_packed(vq) : more_used_split(v=
q);
> +       return vq->ops->more_used(vq);
>  }
>
>  /**
> @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 nu=
m,
>         if (recycle_done)
>                 recycle_done(_vq);
>
> -       if (vq->packed_ring)
> -               err =3D virtqueue_resize_packed(vq, num);
> -       else
> -               err =3D virtqueue_resize_split(vq, num);
> +       err =3D vq->ops->resize(vq, num);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
>         if (recycle_done)
>                 recycle_done(_vq);
>
> -       if (vq->packed_ring)
> -               virtqueue_reset_packed(vq);
> -       else
> -               virtqueue_reset_split(vq);
> +       vq->ops->reset(vq);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> --
> 2.42.0
>

