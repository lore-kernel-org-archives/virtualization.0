Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BB25FA1A
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095774; cv=none; b=r0avyvU7Q3ld5cvWwF97jhR5UNIsSD+mOBp8ui3TmHpiXelZErj1bx7ZeAA+dfM1aeDW3SqpRsHNX8nN/pVEGScnt8yVqTMt3kG8EBpjzHOLSeatfEJWZ9v0UpbD82If+Yx5L51sY0ZEdFa/ANiwVEd0QiZtTVNb68pt7xXCxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095774; c=relaxed/simple;
	bh=cObHrd6kS6Wa6hKiQWWcYfdUbLNkSl/cnBjNj/TjIbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Idm8ALJ9vYJ7Y+4oIGR0K+6gVwz4+enrC3zYsFCvoQb0rc3oUFUJGU1oKECms7ZDaNnKQ0Ul2ylkwXmkVDuw5sgLZmQCDEQSijQkdd948DBoPsOVwoUZG0JAbNAgzH7lXu4e1rozGHQ57Fe4wrqTXa8L88a2v+yW4xNoCs8nvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F35zQGg1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F35zQGg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744095770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GrDpExuf9dXx7fA/D4M3XAaC47fG0gByj9zaTYq3Y0=;
	b=F35zQGg1ZKYycvKRyboDgdRW490thuhQuM4yDJqvjyvujY5CAU0tcjI9KQa0jzOYf8yXjd
	m1GpevY5wg7fZiMfifUWoLxTLEiAB176vlPsLNu4zXfm3QTnz7hM99DW+lCthCpTRJ/e9V
	/oQgF98duEV55tkbkk/+Vu74pa8uGZw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-073pSvSmNP6w5qQILad7Mg-1; Tue, 08 Apr 2025 03:02:49 -0400
X-MC-Unique: 073pSvSmNP6w5qQILad7Mg-1
X-Mimecast-MFC-AGG-ID: 073pSvSmNP6w5qQILad7Mg_1744095768
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso5324027a91.1
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 00:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744095768; x=1744700568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GrDpExuf9dXx7fA/D4M3XAaC47fG0gByj9zaTYq3Y0=;
        b=lf6qdktaU4nL8EzOZAJwxJ18bmH0Q4CP7bPhiGWDnLLE7Yy+xe/ZJbOEtZ3EQS1wNL
         OtCDoZa4/RDzOc0kzqEaEwUr/WiUDCSkvoHRM5FAVmU29VZgc87+MeQm+WezCAwNS8dK
         wlCRxKqvd4YndBKAEfA4WmV3Js1cXmEIAFV9P0qckX/tZfksDkThuDIjTGk6SNofRcov
         jIW9ywrSR85r8WmdpQG0I0y6pp0qldzbDEWMY/nsabwWIyaRDQrMdxzQFEp78kxBNlj6
         +ikwWOHsDo2WB/01Pg15yvgEUhAUzqA0jLSI71fi58lYQQrDK4uRD4PDI0S3XoTlguMy
         0Amw==
X-Forwarded-Encrypted: i=1; AJvYcCWOdyVwDzDo4nz+gHcj+TxJwh9oNNkZIguupQbevHMpxbUCoDonSimW9+SGF6enr/j/LQoF/MfVGTElp6LSJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy5t3eT9hksuEMTIkPFoc/G3mYM2Qu/6MVmNTv8xgJI8PnLX+R
	oR/Ni7KxIPrDnYeiuucyThlqzPCOek8MEZbCSFJl4iKAg7XQZElrv2H+aVOKR1bMdm1TWvfpiRt
	mNS0ZQ2L7fHFilGNqbiw2bzxdYeJ9j6o84Y78byY0HDSzDujDwlBL3JPjGB/s497cHcvfzgxGm5
	tRn+lgCkkjKAyCBUYd/QBHSCopTybzh3WHxwt73XE=
X-Gm-Gg: ASbGncuZwcXj4wRCZspZbak0XkrGRCFzyJ4GDDCS8Iyt9dSeeWOIW8wzaszOvmL2iv+
	v7HpIvGeZ9s7MscnXECmW1+lMXvdTaaPdE1fax3oC6p23qNAKWrSHLKeDAjQFb2fQGj+QoZUF
X-Received: by 2002:a17:90b:524f:b0:2fa:17e4:b1cf with SMTP id 98e67ed59e1d1-306d0be3b2cmr3346739a91.2.1744095768079;
        Tue, 08 Apr 2025 00:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcW2qfntMVnXXig7RNTqcoTx4UFBNaaqWefDiT25vXGp9gw/MrRPsbr9UfeZ8tE8z+GMPL2AJAVJiX/RZaVNM=
X-Received: by 2002:a17:90b:524f:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-306d0be3b2cmr3346693a91.2.1744095767562; Tue, 08 Apr 2025
 00:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-1-jasowang@redhat.com>
 <20250407041729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250407041729-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 15:02:35 +0800
X-Gm-Features: ATxdqUEW3FrH-fu9PB9rJvbJNCvsWMv0KCCTgTRZK7PGRLmCzj6LMvNDFEWkx7w
Message-ID: <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j8nLiS9Bn5IEpmlkYNVXLThM2dnhv1rFpkh1oafgQ_0_1744095768
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 4:20=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of the callbacks
> > that will be called for different queue layout or features. This would
> > help to avoid branches for split/packed and will ease the future
> > implementation like in order.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
>
>
> > ---
> >  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
> >  1 file changed, 67 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index a2884eae14d9..ce1dc90ee89d 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
> >       size_t event_size_in_bytes;
> >  };
> >
> > +struct vring_virtqueue;
> > +
> > +struct virtqueue_ops {
> > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> > +                unsigned int total_sg, unsigned int out_sgs,
> > +                unsigned int in_sgs, void *data,
> > +                void *ctx, bool premapped, gfp_t gfp);
> > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void =
**ctx);
> > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx)=
;
> > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > +     void (*reset)(struct vring_virtqueue *vq);
> > +};
>
> I like it that it's organized but
> I worry about the overhead of indirect calls here.

We can switch to use INDIRECT_CALL_X() here (but I'm not sure we
should worry about it too much as ndo_ops or qdiscs doesn't use that).

> How about a switch statement instead?
>
> struct vring_virtqueue {
>         enum vring_virtqueue_ops ops;
>
> }
>
>
> @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *=
_vq,
>  {
>       struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         switch (vq->ops) {
>          VQ_PACKED:
>          VQ_SPLIT:
>          VQ_IN_ORDER:
>         }
>
>
> }
>
>
> What do you think?

Actually, the matrix will be 2*2:

PACKED, SPLIT, PACKED_IN_ORDER, SPLIT_IN_ORDER

And will be doubled if a new layout is implemented.

If we open them such a switch will spread in a lot of places in the code.

Thanks

>
>
>
> > +
> >  struct vring_virtqueue {
> >       struct virtqueue vq;
> >
> > +     struct virtqueue_ops *ops;
> > +
> >       /* Is this a packed ring? */
> >       bool packed_ring;
> >
> > @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_v=
irtqueue_split *vring_split,
> >       return 0;
> >  }
> >
> > +struct virtqueue_ops split_ops;
> > +
> >  static struct virtqueue *__vring_new_virtqueue_split(unsigned int inde=
x,
> >                                              struct vring_virtqueue_spl=
it *vring_split,
> >                                              struct virtio_device *vdev=
,
> > @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >               return NULL;
> >
> >       vq->packed_ring =3D false;
> > +     vq->ops =3D &split_ops;
> >       vq->vq.callback =3D callback;
> >       vq->vq.vdev =3D vdev;
> >       vq->vq.name =3D name;
> > @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_v=
irtqueue *vq)
> >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> >  }
> >
> > +struct virtqueue_ops packed_ops;
> > +
> >  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int ind=
ex,
> >                                              struct vring_virtqueue_pac=
ked *vring_packed,
> >                                              struct virtio_device *vdev=
,
> > @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_pa=
cked(unsigned int index,
> >       vq->broken =3D false;
> >  #endif
> >       vq->packed_ring =3D true;
> > +     vq->ops =3D &packed_ops;
> >       vq->dma_dev =3D dma_dev;
> >       vq->use_dma_api =3D vring_use_dma_api(vdev);
> >
> > @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_=
virtqueue *vq, u32 num)
> >       return -ENOMEM;
> >  }
> >
> > +struct virtqueue_ops split_ops =3D {
> > +     .add =3D virtqueue_add_split,
> > +     .get =3D virtqueue_get_buf_ctx_split,
> > +     .kick_prepare =3D virtqueue_kick_prepare_split,
> > +     .disable_cb =3D virtqueue_disable_cb_split,
> > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
> > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
> > +     .poll =3D virtqueue_poll_split,
> > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
> > +     .more_used =3D more_used_split,
> > +     .resize =3D virtqueue_resize_split,
> > +     .reset =3D virtqueue_reset_split,
> > +};
> > +
> > +struct virtqueue_ops packed_ops =3D {
> > +     .add =3D virtqueue_add_packed,
> > +     .get =3D virtqueue_get_buf_ctx_packed,
> > +     .kick_prepare =3D virtqueue_kick_prepare_packed,
> > +     .disable_cb =3D virtqueue_disable_cb_packed,
> > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
> > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
> > +     .poll =3D virtqueue_poll_packed,
> > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
> > +     .more_used =3D more_used_packed,
> > +     .resize =3D virtqueue_resize_packed,
> > +     .reset =3D virtqueue_reset_packed,
> > +};
> > +
> >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> >                                        void (*recycle)(struct virtqueue=
 *vq, void *buf))
> >  {
> > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue=
 *_vq,
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> > -                                     out_sgs, in_sgs, data, ctx, prema=
pped, gfp) :
> > -                              virtqueue_add_split(vq, sgs, total_sg,
> > -                                     out_sgs, in_sgs, data, ctx, prema=
pped, gfp);
> > +     return vq->ops->add(vq, sgs, total_sg,
> > +                         out_sgs, in_sgs, data, ctx, premapped, gfp);
> >  }
> >
> >  /**
> > @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq=
)
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> > -                              virtqueue_kick_prepare_split(vq);
> > +     return vq->ops->kick_prepare(vq);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> >
> > @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq=
, unsigned int *len,
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ct=
x) :
> > -                              virtqueue_get_buf_ctx_split(vq, len, ctx=
);
> > +     return vq->ops->get(vq, len, ctx);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> >
> > @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     if (vq->packed_ring)
> > -             virtqueue_disable_cb_packed(vq);
> > -     else
> > -             virtqueue_disable_cb_split(vq);
> > +     return vq->ops->disable_cb(vq);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> >
> > @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct v=
irtqueue *_vq)
> >       if (vq->event_triggered)
> >               vq->event_triggered =3D false;
> >
> > -     return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> > -                              virtqueue_enable_cb_prepare_split(vq);
> > +     return vq->ops->enable_cb_prepare(vq);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> >
> > @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsign=
ed int last_used_idx)
> >               return false;
> >
> >       virtio_mb(vq->weak_barriers);
> > -     return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx)=
 :
> > -                              virtqueue_poll_split(vq, last_used_idx);
> > +     return vq->ops->poll(vq, last_used_idx);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> >
> > @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue=
 *_vq)
> >       if (vq->event_triggered)
> >               vq->event_triggered =3D false;
> >
> > -     return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> > -                              virtqueue_enable_cb_delayed_split(vq);
> > +     return vq->ops->enable_cb_delayed(vq);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> >
> > @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqu=
eue *_vq)
> >  {
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -     return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> > -                              virtqueue_detach_unused_buf_split(vq);
> > +     return vq->ops->detach_unused_buf(vq);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> >
> >  static inline bool more_used(const struct vring_virtqueue *vq)
> >  {
> > -     return vq->packed_ring ? more_used_packed(vq) : more_used_split(v=
q);
> > +     return vq->ops->more_used(vq);
> >  }
> >
> >  /**
> > @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 =
num,
> >       if (recycle_done)
> >               recycle_done(_vq);
> >
> > -     if (vq->packed_ring)
> > -             err =3D virtqueue_resize_packed(vq, num);
> > -     else
> > -             err =3D virtqueue_resize_split(vq, num);
> > +     err =3D vq->ops->resize(vq, num);
> >
> >       return virtqueue_enable_after_reset(_vq);
> >  }
> > @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
> >       if (recycle_done)
> >               recycle_done(_vq);
> >
> > -     if (vq->packed_ring)
> > -             virtqueue_reset_packed(vq);
> > -     else
> > -             virtqueue_reset_split(vq);
> > +     vq->ops->reset(vq);
> >
> >       return virtqueue_enable_after_reset(_vq);
> >  }
> > --
> > 2.42.0
>

