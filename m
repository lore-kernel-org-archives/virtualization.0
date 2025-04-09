Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AA15F330
	for <virtualization@lists.linux.dev>; Wed,  9 Apr 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744171584; cv=none; b=eifRjd9L1tVMC0bILvMO++SxoXknB90shSKZKLLHl2BrPzDrlnZ8m/PSpNbtzwriT7Ih0z9Ts0gY23wcuJYfYkPzT7ap1krTWXVG3nZpWUQT6sm4cbSt8N7c+SfVzh/JbMoenkE8WLx+qepsxFSR0lJXdO0qVTC4gD5mdY00MP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744171584; c=relaxed/simple;
	bh=2SPu6xhCzaCLCR5+l+uGkKQYmu6+IrftMrFP4K2kLbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWW0bTDGTeffIVoKyVjvhPlLScSVfDaEnP9k7TexGVeiJCZDBlxrTQ7PnHXoKgkixHvj7JPM5h0LXfdkcVLaX33Gr5D416SH6yFyDFTBd+oqJQXQHRivqKO9YXboR6DXolelI49iaXp+jF34UHEN0LEvIxWGmYU+6Vq7wQlyAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AX9NAHpZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX9NAHpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744171578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijXIXd8h6SmnPWZmcUGFMLkscl1xkFT8sup908yrvUs=;
	b=AX9NAHpZVMQijdWk6BZFRw0I77SM3gRTAEMlp9JxIrO+zyPeAZQ0Pk/Xaqbaqn9GKoGv1K
	2qEjni+sa/EeVn1PnuvsUgPmjuu5go0m/vtaIQQgdIp6tQPM1q8BW7D7YzrMneRNtM3y7C
	xEA010Fuys6z1/edgEK8CcfzIfYyzMA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-iLXpzYujPqy2nQO6CngJzw-1; Wed, 09 Apr 2025 00:06:16 -0400
X-MC-Unique: iLXpzYujPqy2nQO6CngJzw-1
X-Mimecast-MFC-AGG-ID: iLXpzYujPqy2nQO6CngJzw_1744171575
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736b2a25d9fso5053922b3a.0
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 21:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744171575; x=1744776375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijXIXd8h6SmnPWZmcUGFMLkscl1xkFT8sup908yrvUs=;
        b=pI1rZKgAAxqmI7HFhSlTQZmYkiL+9fJFnAT1at54gz6o6RhGvxQV+7gZa8SDlcpSmz
         yhnxCTzqFCSPsN6/78AcildzT0X9M16eqWgzzBiuxUxgdT8nefUvs7fiOluiIdZcM9Mc
         V47KFX94OmUq6u3pq86PcugudyYBPyFykcOY4Opk2DVaZgBiRbULHqktlaudexe6OemQ
         1DV0PkR7jruYgPa+DxWSZY6e5TezHmLLYoDI748eKw2NP95/SuDBd/i2fxokvcwaTneF
         eS4oAMe0QecQtorsH7f1xtqm/STq9fZWmnx4WLaj/+LReLZkfQ+ugHt3325u+IckYe+2
         onjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWr0v8+agZAsSeGbvbrIDPnoQRfo1ls1chzKoR50i0OaUym5KtuioKuY7lJD7e/6/a/0F94vY0DErZxQQfMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC9JKHZxZuE//mPQ+q4oZzCkwDTtt6M7qs2V7YSPoqbkigyaJO
	OifbuO2ca/D/SXy9/wKTPJTbwH3vS/lZGYJsl6aUfMCYLPtT+VPZovpy1DS/GL46LNEf/sKTlGV
	zEJvOfjW59XlBTJ/2cChL2DUMJBvZVxF/6buWonAKFxnKXloQBYIhCp2FISoGoq+CAx0MZIwMxF
	ioImtzSFWKMlzb7zbfK99I1AvIMQok2QuVLwSjpiI=
X-Gm-Gg: ASbGncvtBYzZg+PEGY+PInPoxfND0uKLX0JXYnyBa+LpRvqkNVLXcevroe2skv/bvMX
	kkduOloj/BI9JTKuYed69ZVD51F0jki/LgOMuvaRL1nqcC8W7OaIywe8QZEmfbcT7enJ2q3Fu3A
	==
X-Received: by 2002:a05:6a00:1909:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-73bae30a7e1mr1792444b3a.0.1744171575259;
        Tue, 08 Apr 2025 21:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/GK37bglV1sRPs94dgS0EbzNjik/y4s/SyGHaLzsB9g0rDHlXisULL3q2KkdRzji4u9G49VZszDpcHBWQRFQ=
X-Received: by 2002:a05:6a00:1909:b0:735:d89c:4b9f with SMTP id
 d2e1a72fcca58-73bae30a7e1mr1792422b3a.0.1744171574710; Tue, 08 Apr 2025
 21:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-1-jasowang@redhat.com>
 <20250407041729-mutt-send-email-mst@kernel.org> <CACGkMEv-=V0a7jpR9e-i=Oe+PE9pN_cH3yDBmyOYhwPcJXOHPQ@mail.gmail.com>
 <20250408073317-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250408073317-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Apr 2025 12:06:03 +0800
X-Gm-Features: ATxdqUF4O39qPwC7K414J9bQVl-02bUVSNUMKHYcCzPivVN_iNHqERNtrjFk_ZY
Message-ID: <CACGkMEtmDM4_ZbAi4O8OUwZaPZnGLKEhnXkQGStFmeXETJtpkA@mail.gmail.com>
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8CYUIjDRs5X-XZy8Tlg2S7atMiyRBUDW4eoid7Amdik_1744171575
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Apr 08, 2025 at 03:02:35PM +0800, Jason Wang wrote:
> > On Mon, Apr 7, 2025 at 4:20=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Mar 24, 2025 at 02:01:21PM +0800, Jason Wang wrote:
> > > > This patch introduces virtqueue ops which is a set of the callbacks
> > > > that will be called for different queue layout or features. This wo=
uld
> > > > help to avoid branches for split/packed and will ease the future
> > > > implementation like in order.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > >
> > >
> > >
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-------=
----
> > > >  1 file changed, 67 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index a2884eae14d9..ce1dc90ee89d 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
> > > >       size_t event_size_in_bytes;
> > > >  };
> > > >
> > > > +struct vring_virtqueue;
> > > > +
> > > > +struct virtqueue_ops {
> > > > +     int (*add)(struct vring_virtqueue *_vq, struct scatterlist *s=
gs[],
> > > > +                unsigned int total_sg, unsigned int out_sgs,
> > > > +                unsigned int in_sgs, void *data,
> > > > +                void *ctx, bool premapped, gfp_t gfp);
> > > > +     void *(*get)(struct vring_virtqueue *vq, unsigned int *len, v=
oid **ctx);
> > > > +     bool (*kick_prepare)(struct vring_virtqueue *vq);
> > > > +     void (*disable_cb)(struct vring_virtqueue *vq);
> > > > +     bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> > > > +     unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq)=
;
> > > > +     bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_=
idx);
> > > > +     void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> > > > +     bool (*more_used)(const struct vring_virtqueue *vq);
> > > > +     int (*resize)(struct vring_virtqueue *vq, u32 num);
> > > > +     void (*reset)(struct vring_virtqueue *vq);
> > > > +};
> > >
> > > I like it that it's organized but
> > > I worry about the overhead of indirect calls here.
> >
> > We can switch to use INDIRECT_CALL_X() here
>
> If you think it's cleaner.. but INDIRECT_CALL is all chained

Yes, and it would be problematic as the number of ops increased.

> while a switch can do a binary search.
>

Do you mean a nested switch?

>
> > (but I'm not sure we
> > should worry about it too much as ndo_ops or qdiscs doesn't use that).
>
>
> And that's why we ended up with xdp, no? the stack's too heavy ...
>
> > > How about a switch statement instead?
> > >
> > > struct vring_virtqueue {
> > >         enum vring_virtqueue_ops ops;
> > >
> > > }
> > >
> > >
> > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtque=
ue *_vq,
> > >  {
> > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >
> > >         switch (vq->ops) {
> > >          VQ_PACKED:
> > >          VQ_SPLIT:
> > >          VQ_IN_ORDER:
> > >         }
> > >
> > >
> > > }
> > >
> > >
> > > What do you think?
> >
> > Actually, the matrix will be 2*2:
> >
> > PACKED, SPLIT, PACKED_IN_ORDER, SPLIT_IN_ORDER
>
> Confused. Same amount of enums as ops structures in your approach, no?

I meant in this series, we will have 4 ops not 3.

>
>
> > And will be doubled if a new layout is implemented.
> >
> > If we open them such a switch will spread in a lot of places in the cod=
e.
> >
> > Thanks

Thanks

> >
> > >
> > >
> > >
> > > > +
> > > >  struct vring_virtqueue {
> > > >       struct virtqueue vq;
> > > >
> > > > +     struct virtqueue_ops *ops;
> > > > +
> > > >       /* Is this a packed ring? */
> > > >       bool packed_ring;
> > > >
> > > > @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vri=
ng_virtqueue_split *vring_split,
> > > >       return 0;
> > > >  }
> > > >
> > > > +struct virtqueue_ops split_ops;
> > > > +
> > > >  static struct virtqueue *__vring_new_virtqueue_split(unsigned int =
index,
> > > >                                              struct vring_virtqueue=
_split *vring_split,
> > > >                                              struct virtio_device *=
vdev,
> > > > @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueu=
e_split(unsigned int index,
> > > >               return NULL;
> > > >
> > > >       vq->packed_ring =3D false;
> > > > +     vq->ops =3D &split_ops;
> > > >       vq->vq.callback =3D callback;
> > > >       vq->vq.vdev =3D vdev;
> > > >       vq->vq.name =3D name;
> > > > @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vri=
ng_virtqueue *vq)
> > > >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> > > >  }
> > > >
> > > > +struct virtqueue_ops packed_ops;
> > > > +
> > > >  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int=
 index,
> > > >                                              struct vring_virtqueue=
_packed *vring_packed,
> > > >                                              struct virtio_device *=
vdev,
> > > > @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueu=
e_packed(unsigned int index,
> > > >       vq->broken =3D false;
> > > >  #endif
> > > >       vq->packed_ring =3D true;
> > > > +     vq->ops =3D &packed_ops;
> > > >       vq->dma_dev =3D dma_dev;
> > > >       vq->use_dma_api =3D vring_use_dma_api(vdev);
> > > >
> > > > @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vr=
ing_virtqueue *vq, u32 num)
> > > >       return -ENOMEM;
> > > >  }
> > > >
> > > > +struct virtqueue_ops split_ops =3D {
> > > > +     .add =3D virtqueue_add_split,
> > > > +     .get =3D virtqueue_get_buf_ctx_split,
> > > > +     .kick_prepare =3D virtqueue_kick_prepare_split,
> > > > +     .disable_cb =3D virtqueue_disable_cb_split,
> > > > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
> > > > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
> > > > +     .poll =3D virtqueue_poll_split,
> > > > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
> > > > +     .more_used =3D more_used_split,
> > > > +     .resize =3D virtqueue_resize_split,
> > > > +     .reset =3D virtqueue_reset_split,
> > > > +};
> > > > +
> > > > +struct virtqueue_ops packed_ops =3D {
> > > > +     .add =3D virtqueue_add_packed,
> > > > +     .get =3D virtqueue_get_buf_ctx_packed,
> > > > +     .kick_prepare =3D virtqueue_kick_prepare_packed,
> > > > +     .disable_cb =3D virtqueue_disable_cb_packed,
> > > > +     .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
> > > > +     .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
> > > > +     .poll =3D virtqueue_poll_packed,
> > > > +     .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
> > > > +     .more_used =3D more_used_packed,
> > > > +     .resize =3D virtqueue_resize_packed,
> > > > +     .reset =3D virtqueue_reset_packed,
> > > > +};
> > > > +
> > > >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> > > >                                        void (*recycle)(struct virtq=
ueue *vq, void *buf))
> > > >  {
> > > > @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtq=
ueue *_vq,
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_=
sg,
> > > > -                                     out_sgs, in_sgs, data, ctx, p=
remapped, gfp) :
> > > > -                              virtqueue_add_split(vq, sgs, total_s=
g,
> > > > -                                     out_sgs, in_sgs, data, ctx, p=
remapped, gfp);
> > > > +     return vq->ops->add(vq, sgs, total_sg,
> > > > +                         out_sgs, in_sgs, data, ctx, premapped, gf=
p);
> > > >  }
> > > >
> > > >  /**
> > > > @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue =
*_vq)
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> > > > -                              virtqueue_kick_prepare_split(vq);
> > > > +     return vq->ops->kick_prepare(vq);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> > > >
> > > > @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue =
*_vq, unsigned int *len,
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len=
, ctx) :
> > > > -                              virtqueue_get_buf_ctx_split(vq, len,=
 ctx);
> > > > +     return vq->ops->get(vq, len, ctx);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> > > >
> > > > @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *=
_vq)
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     if (vq->packed_ring)
> > > > -             virtqueue_disable_cb_packed(vq);
> > > > -     else
> > > > -             virtqueue_disable_cb_split(vq);
> > > > +     return vq->ops->disable_cb(vq);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > > >
> > > > @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(stru=
ct virtqueue *_vq)
> > > >       if (vq->event_triggered)
> > > >               vq->event_triggered =3D false;
> > > >
> > > > -     return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(v=
q) :
> > > > -                              virtqueue_enable_cb_prepare_split(vq=
);
> > > > +     return vq->ops->enable_cb_prepare(vq);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > > >
> > > > @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, un=
signed int last_used_idx)
> > > >               return false;
> > > >
> > > >       virtio_mb(vq->weak_barriers);
> > > > -     return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_=
idx) :
> > > > -                              virtqueue_poll_split(vq, last_used_i=
dx);
> > > > +     return vq->ops->poll(vq, last_used_idx);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_poll);
> > > >
> > > > @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtq=
ueue *_vq)
> > > >       if (vq->event_triggered)
> > > >               vq->event_triggered =3D false;
> > > >
> > > > -     return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(v=
q) :
> > > > -                              virtqueue_enable_cb_delayed_split(vq=
);
> > > > +     return vq->ops->enable_cb_delayed(vq);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> > > >
> > > > @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct vi=
rtqueue *_vq)
> > > >  {
> > > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > >
> > > > -     return vq->packed_ring ? virtqueue_detach_unused_buf_packed(v=
q) :
> > > > -                              virtqueue_detach_unused_buf_split(vq=
);
> > > > +     return vq->ops->detach_unused_buf(vq);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> > > >
> > > >  static inline bool more_used(const struct vring_virtqueue *vq)
> > > >  {
> > > > -     return vq->packed_ring ? more_used_packed(vq) : more_used_spl=
it(vq);
> > > > +     return vq->ops->more_used(vq);
> > > >  }
> > > >
> > > >  /**
> > > > @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, =
u32 num,
> > > >       if (recycle_done)
> > > >               recycle_done(_vq);
> > > >
> > > > -     if (vq->packed_ring)
> > > > -             err =3D virtqueue_resize_packed(vq, num);
> > > > -     else
> > > > -             err =3D virtqueue_resize_split(vq, num);
> > > > +     err =3D vq->ops->resize(vq, num);
> > > >
> > > >       return virtqueue_enable_after_reset(_vq);
> > > >  }
> > > > @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
> > > >       if (recycle_done)
> > > >               recycle_done(_vq);
> > > >
> > > > -     if (vq->packed_ring)
> > > > -             virtqueue_reset_packed(vq);
> > > > -     else
> > > > -             virtqueue_reset_split(vq);
> > > > +     vq->ops->reset(vq);
> > > >
> > > >       return virtqueue_enable_after_reset(_vq);
> > > >  }
> > > > --
> > > > 2.42.0
> > >
>

