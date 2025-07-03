Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8ED182D2
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512854; cv=none; b=NkdrzCToCvXUeNeFPzItrlKg89tZ6WHp3bepr7rNDCK34wynuEM+bFybMELqrDieGca958f48L+Idw8dw/7ocjZtW58ZOAT0syP8RfCT2UMOCgXH2n/pQMjHBPghRC5yj9PqAYU71FIP3z8AaP7iuthA3NTpj7QDPQWco9fGev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512854; c=relaxed/simple;
	bh=02SyrTxhDxefPxQZdDhWhN7sw/GWdpZGjBC12Qoo6tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En6vj/fUCE4GaDfCwNqaGXxhS7vP/2heOwULoNKBc9iIDWM8a0vBQ3miy6kRWD1Ip/w77s4rDXrbMxnYzKKuqyDYv+a7A26Y4zvMvVUrL5pPouaDPDYUaTT6l/YOoTGxjTy5Bzq9huE+etn4vCrTJtqxkdt0o6A+GZ5YD65WHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwuIaWXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwuIaWXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751512851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9v7tJEEgqy6VJZUTuanr/kpPOrF6V1sH7tRmF54BHwM=;
	b=LwuIaWXD6LFzjbLgq8mptIBaf9zFOP23pPfPCBTwdDi7OlhohoHUTb6vn52tmmOCLAKQji
	4nUdnnGxXpvnIWNox7jcpddPfeMEK6hkrt8loEwqD81x8lhmepVe6cUYfhXRB53Xd9MS0R
	Yns2vRzQp9R3ajmdkMC+NNxAWCTTtE0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-nJfyWk2ZPmScRrzaByuwug-1; Wed, 02 Jul 2025 23:20:50 -0400
X-MC-Unique: nJfyWk2ZPmScRrzaByuwug-1
X-Mimecast-MFC-AGG-ID: nJfyWk2ZPmScRrzaByuwug_1751512849
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2365ab89b52so58167855ad.2
        for <virtualization@lists.linux.dev>; Wed, 02 Jul 2025 20:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512849; x=1752117649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9v7tJEEgqy6VJZUTuanr/kpPOrF6V1sH7tRmF54BHwM=;
        b=IvWPEVpdruH1te4pW37uWOaUi/zcGznwGqtfuY3f/iC6QPUzibCyhDyCY7M5NbIURX
         150jB4qorhptLNI++0UMDTu2nmJw97cDBarP9XwYw52zaIDDnr4oBXR5LEo6WFGlvs/b
         sQGIq1Oyary3qrTCWJoWJUEiYpbC8DkFBJniJE+wa8svjumCwyyuNTzelax4Q1mXYY4e
         KRXkY/8vRvv5mFY7jrAnvG6WPQ6Pyzgoz+OLsOsENGPllLX2Bws88UUkGJaEsw8xiIjG
         ORyBJM8Rj/7SZLoEIFKx1uFzoLxbVm162YAaJ9GVBK2HqFsqrEJ3esaFEpKPGNpbdECL
         J6JA==
X-Forwarded-Encrypted: i=1; AJvYcCWhGq3ROxxJsH0Qa5yw+ulQCv9enS0zrIM0w22deUTUS/C5pJvuEy6sna07ywf2Hpsdz5MYC83TzI0Io1f9Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCGqV49M8qhIY5oAcqh82OBVCzBT81kzHhkhsCwPp0Iuiq9vnI
	RrYfjCHBLlXlA4S1GvoSqYzZE5fqBaYmfjKOBMsUzXva/fQD+GfvxJycunIdE8e82tGDvGVT+NR
	vQDM1pEosSsvnV82WcgAvERhIr5oitD7PcFwmx+ifCzhWGq/ydfbw2rAMaQE6k9EeIyx6nt3iHh
	OuAy3idWLVVa6E90tXTFs0XhVZCPiBr6NNsb2d0NETDCxgXlWpf2uV7//1
X-Gm-Gg: ASbGncvdGwZh+AwAVmqA05V49PRlrC06CkXpiaCQGbj7i1kV7XmU1VDK/v9VOiV/xjY
	Ut2g0OVG+kYvO24t/5g2oFVDUseofeU9wrVC8h1/mGtaF2aIoCotfhQN2nX1WffOuqHTmvQPAs1
	y0iQeD
X-Received: by 2002:a17:902:da91:b0:234:bfcb:5c21 with SMTP id d9443c01a7336-23c797b28efmr26082265ad.19.1751512849107;
        Wed, 02 Jul 2025 20:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg2pIZBjOK/FqaU85rpiYhc/c8RAys2kXuUcQ4lOX92J/XbhJ0fdtIc+TGgTNJfl5liSoKWQbXchamvBGnT8I=
X-Received: by 2002:a17:902:da91:b0:234:bfcb:5c21 with SMTP id
 d9443c01a7336-23c797b28efmr26081905ad.19.1751512848627; Wed, 02 Jul 2025
 20:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616082518.10411-1-jasowang@redhat.com> <20250616082518.10411-14-jasowang@redhat.com>
 <20250701021229-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250701021229-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 3 Jul 2025 11:20:37 +0800
X-Gm-Features: Ac12FXxbljZdRCM4OW6C1KgmjHwBFTe8wRkTLkKm8PQXcJtS6sc3GylASsGsIvI
Message-ID: <CACGkMEvXTBNK2wxaxw3nDLBrA47WToPkpLLgVXxA7d=X8C6O-w@mail.gmail.com>
Subject: Re: [PATCH V3 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NVWd7HtXqIhNgsfZO7Df6xR3yGazeDXZLBfAb7IBBRg_1751512849
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Jun 16, 2025 at 04:25:11PM +0800, Jason Wang wrote:
> > This patch introduces virtqueue ops which is a set of the callbacks
> > that will be called for different queue layout or features. This would
> > help to avoid branches for split/packed and will ease the future
> > implementation like in order.
> >
> > Note that in order to eliminate the indirect calls this patch uses
> > global array of const ops to allow compiler to avoid indirect
> > branches.
> >
> > Tested with CONFIG_MITIGATION_RETPOLINE, no performance differences
> > were noticed.
> >
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 172 ++++++++++++++++++++++++++---------
> >  1 file changed, 129 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index b14bbb4d6713..af32d1a1a1db 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -67,6 +67,12 @@
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >
> > +enum vq_layout {
> > +     SPLIT =3D 0,
> > +     PACKED,
> > +     VQ_TYPE_MAX,
> > +};
> > +
> >  struct vring_desc_state_split {
> >       void *data;                     /* Data for callback. */
> >
> > @@ -159,12 +165,28 @@ struct vring_virtqueue_packed {
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
> > +
> >  struct vring_virtqueue {
> >       struct virtqueue vq;
> >
> > -     /* Is this a packed ring? */
> > -     bool packed_ring;
> > -
> >       /* Is DMA API used? */
> >       bool use_dma_api;
> >
> > @@ -180,6 +202,8 @@ struct vring_virtqueue {
> >       /* Host publishes avail event idx */
> >       bool event;
> >
> > +     enum vq_layout layout;
> > +
> >       /* Head of free buffer list. */
> >       unsigned int free_head;
> >       /* Number we've added since last sync. */
> > @@ -232,6 +256,12 @@ static void vring_free(struct virtqueue *_vq);
> >
> >  #define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq=
)
> >
> > +
>
> Why two empty lines?

Let me fix that.

>
> > +static inline bool virtqueue_is_packed(const struct vring_virtqueue *v=
q)
> > +{
> > +     return vq->layout =3D=3D PACKED;
> > +}
> > +
>
> So why still have this?
> Let's replace all uses with a per layout
> callback. None of them seem to be on the data path.
> Well, with one exception - there is

I actually start with that but the problem is a lot of codes could be
duplicated that needs more refactoring which will end up with a pretty
giant series:

+static const struct virtqueue_ops split_in_order_ops =3D {
+       .add =3D virtqueue_add_split,
+       .get =3D virtqueue_get_buf_ctx_split_in_order,
+       .kick_prepare =3D virtqueue_kick_prepare_split,
+       .disable_cb =3D virtqueue_disable_cb_split,
+       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
+       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
+       .poll =3D virtqueue_poll_split,
+       .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
+       .more_used =3D more_used_split_in_order,
+       .resize =3D virtqueue_resize_split,
+       .reset =3D virtqueue_reset_split,
+};

So I start with the function that has sufficient difference:

virtqueue_get_buf_ctx_split_in_order
more_used_split_in_order

And leave the rest for the future if we can see performance improvement.


>         > @@ -2921,7 +3006,7 @@ u32 vring_notification_data(struct virtqu=
eue *_vq)
>         >       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         >       u16 next;
>         >
>         > -     if (vq->packed_ring)
>         > +     if (virtqueue_is_packed(vq))
>         >               next =3D (vq->packed.next_avail_idx &
>         >                               ~(-(1 << VRING_PACKED_EVENT_F_WRA=
P_CTR))) |
>         >                       vq->packed.avail_wrap_counter <<
>
> I think it's the only one? Are we trying to save a function call there?
> I am fine to keep it as in this patch, or if we do change it,
> maybe with a separate patch, so if there is a regression we can bisect
> more easily.
>

Yes.

>
>
>
> For example, for the chunk below, we could have:
>         .init_last_used
>
> having said that, this patchset is already big, so let us do it with a se=
parate patch -
> but if so, the way to split would be in patch 1 to just leave vq->packed_=
ring
> in place, gradually replace call sites, and in patch N drop
> vq->packed_ring.

Ok, let me do that.

>
>
> >  static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
> >                                  unsigned int total_sg)
> >  {
> > @@ -422,7 +452,7 @@ static void virtqueue_init(struct vring_virtqueue *=
vq, u32 num)
> >  {
> >       vq->vq.num_free =3D num;
> >
> > -     if (vq->packed_ring)
> > +     if (virtqueue_is_packed(vq))
> >               vq->last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP=
_CTR);
> >       else
> >               vq->last_used_idx =3D 0;
> > @@ -1116,6 +1146,8 @@ static int vring_alloc_queue_split(struct vring_v=
irtqueue_split *vring_split,
> >       return 0;
> >  }
> >
> > +static const struct virtqueue_ops split_ops;
> > +
> >  static struct virtqueue *__vring_new_virtqueue_split(unsigned int inde=
x,
> >                                              struct vring_virtqueue_spl=
it *vring_split,
> >                                              struct virtio_device *vdev=
,
> > @@ -1133,7 +1165,7 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >       if (!vq)
> >               return NULL;
> >
> > -     vq->packed_ring =3D false;
> > +     vq->layout =3D SPLIT;
> >       vq->vq.callback =3D callback;
> >       vq->vq.vdev =3D vdev;
> >       vq->vq.name =3D name;
> > @@ -2076,6 +2108,8 @@ static void virtqueue_reset_packed(struct vring_v=
irtqueue *vq)
> >       virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> >  }
> >
> > +static const struct virtqueue_ops packed_ops;
> > +
> >  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int ind=
ex,
> >                                              struct vring_virtqueue_pac=
ked *vring_packed,
> >                                              struct virtio_device *vdev=
,
> > @@ -2106,7 +2140,7 @@ static struct virtqueue *__vring_new_virtqueue_pa=
cked(unsigned int index,
> >  #else
> >       vq->broken =3D false;
> >  #endif
> > -     vq->packed_ring =3D true;
> > +     vq->layout =3D PACKED;
> >       vq->dma_dev =3D dma_dev;
> >       vq->use_dma_api =3D vring_use_dma_api(vdev);
> >
> > @@ -2194,6 +2228,39 @@ static int virtqueue_resize_packed(struct vring_=
virtqueue *vq, u32 num)
> >       return -ENOMEM;
> >  }
> >
> > +static const struct virtqueue_ops split_ops =3D {
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
> > +static const struct virtqueue_ops packed_ops =3D {
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
> > +static const struct virtqueue_ops *const all_ops[VQ_TYPE_MAX] =3D {
> > +     [SPLIT] =3D &split_ops,
> > +     [PACKED] =3D &packed_ops
> > +};
> > +
> >  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
> >                                        void (*recycle)(struct virtqueue=
 *vq, void *buf))
> >  {
> > @@ -2236,6 +2303,38 @@ static int virtqueue_enable_after_reset(struct v=
irtqueue *_vq)
> >   * Generic functions and exported symbols.
> >   */
> >
> > +#define VIRTQUEUE_CALL(vq, op, ...)                                  \
> > +     ({                                                              \
> > +     typeof(all_ops[SPLIT]->op(vq, ##__VA_ARGS__)) ret;              \
>
> we need an empty line here, after the declaration.

Ok.

Thanks

