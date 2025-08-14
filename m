Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012325A2C4
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142612; cv=none; b=ddeDtpb74rNGDW7gBANRROo0JHubODFQgwtmQIYtI7Rnezi3jK4RU0h2Hyxh54k6uh2T91+0Yq8gxaSe/IxqzC8Vh1UUnsB74eihPvqf4ayFFDtjj9qsG5hdzH6hScVqdMlewiCicnd2r/MvoBSYrl7M+gUrb8liLY8zYjSzj1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142612; c=relaxed/simple;
	bh=GuAuBIj9XQNG9mMRz/440rAtdVYQf9cLZ5PNrs2fFWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+2kDj5vC4mDB020nm4NB4vCVCVuss+l6tI7MfdnCwhESDX7RL7ZJ70VZwVYDScjPxKC66KyEzmoSxKMplEOH03yGfLIHUZkIrmAz8uiKz3ctU0ULpvw24l1VU2UFU55LO8lO4SnXhY3lPMfvnYdRbP1lIi16ZBbep64T/RIlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROetM0DJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROetM0DJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zb7enfW56MeLiO1K0PJJfGgeDm8eD5i7qWDpfvf17TA=;
	b=ROetM0DJ1IcjJxonTS1OCOXU4bP5QstPYRmcnoUZ398tnJIqt1WUeaWT9zh7f6TcDcNX9L
	R9hk8yARbldwtWOzv05jUAOqamYFUPj4Duoy1MuqZSPb+0K1xMrUerOUqUgO9UvoriGeL8
	BndiSXbb6MhKLPmqTd8ZWTeFni+zm8g=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-K3huUk9IOmS9y0YrhjfSUA-1; Wed, 13 Aug 2025 23:36:38 -0400
X-MC-Unique: K3huUk9IOmS9y0YrhjfSUA-1
X-Mimecast-MFC-AGG-ID: K3huUk9IOmS9y0YrhjfSUA_1755142597
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4719db6b29so127498a12.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 20:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142597; x=1755747397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zb7enfW56MeLiO1K0PJJfGgeDm8eD5i7qWDpfvf17TA=;
        b=gEROJLPmKBkrftyaZ+XKuqyeqDjcL7309D7RKEBot+OHr7igCd/7OlkZVhXBLACv8h
         /dSD1OFaO4TBYqqZarldvo21XiE8KdcO3s01z+Z2AWXavCmybrkJ8sCrNPlF+4EaKg1z
         VCqhePV8zd7msjLZnFrv7b7cttFmBWyiSKi+PzFaEj0aSI0l55C24lqIXAZZTsx9o1l6
         gVQTMImYe5yetRZv2DIQ4kTMxGrtei1Sct/H/ziwzGzcJizg0RpFQVZEoHSejH788JXq
         vDZkRwUDXULR66i980PA00re84zGIRbsajo5vsl00i3G1E0DCYM4P1Q86djHSFrVnt97
         qrwg==
X-Forwarded-Encrypted: i=1; AJvYcCVE3jxLHpZ5kfOTyukA2iIUspxFt0MrLQhWDZIHsko8z4THrzPj7TYPewn9WGuMGl7sn8jT35wFwZHzPnTOqA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5CsyROZOpQRVRHmmfglSlXaSTpXM8c9lCuMYUfKJmdJAuH2n2
	wxT2Jh15nrAq6spXhVr+ZJgDCz6ZSOSep49z2dj0N/id5IXQctEcwC6GSr5ZApxmgEsd3X0NDkF
	xxsDr4eg4ITf7RSsCwxvWOStCSWXJVJ4MS54BBV4IEn1c0uiNky68aPs6m97HrNKNL5TEonj3Hu
	i+h1Bt1ez07mu+yY+MOmM0ym4zPsx4Yi6eqSVxHUhoc6Y=
X-Gm-Gg: ASbGncuCsbql6uNaCnH2XuTTiqNNaDmZ4i3dPC09XMqMWHlwnfJYrfqCVUEZOL5Dshk
	wbt8xDMKSBMXfYY0+1nCNySGnM0N15gAKv8qKWmkOmxxLLEjGtX0ZPRKOZ/onDU3qBGTT1NK6bJ
	BsDhXqtDZQkERjLzhuFs26tA==
X-Received: by 2002:a17:903:22c5:b0:240:9d6:4554 with SMTP id d9443c01a7336-24459837018mr17229955ad.21.1755142596415;
        Wed, 13 Aug 2025 20:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg9HmlkpF5HcDBD0oMvHnRIk3hrJV9EsUF4vCIFS8CIEC+fEnjqswZKNhIdJ85IPNXtsAgyY5QAqapAikiFgc=
X-Received: by 2002:a17:903:22c5:b0:240:9d6:4554 with SMTP id
 d9443c01a7336-24459837018mr17229535ad.21.1755142595736; Wed, 13 Aug 2025
 20:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250813043151-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:36:22 +0800
X-Gm-Features: Ac12FXxZk5CvHO-96EP3yfjPoyEYZiLerpOyVVmscXdPokRRiqaCT6rzCyGDb-U
Message-ID: <CACGkMEuKmn4f9spFT1YxjVPxBFkdGVCTQEUpNG=xHd6hcL-a8w@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LrWtuv15WZTwscMUHjaSOqROphVy1SbdIS61aYydTZI_1755142597
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Aug 13, 2025 at 01:48:26PM +0800, Jason Wang wrote:
> > Following patch will introduce the mapping operations for virtio
> > device. In order to achieve this, besides the dma device, virtio core
> > needs to support a transport or device specific mapping token as well.
> > So this patch introduces a union container of a dma device and opaque
> > mapping token. The idea is the allow the transport layer to pass
> > device specific mapping token which will be used as a parameter for
> > the virtio mapping operations. For the transport or device that is
> > using DMA, dma device is still being used.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++-----------------
> >  drivers/virtio/virtio_vdpa.c |   6 +-
> >  include/linux/virtio.h       |   7 +++
> >  include/linux/virtio_ring.h  |   7 ++-
> >  4 files changed, 72 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 482a268af851..fb1d407d5f1b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -210,8 +210,7 @@ struct vring_virtqueue {
> >       /* DMA, allocation, and size information */
> >       bool we_own_ring;
> >
> > -     /* Device used for doing DMA */
> > -     struct device *dma_dev;
> > +     union vring_mapping_token mapping_token;
> >
> >  #ifdef DEBUG
> >       /* They're supposed to lock for us. */
> > @@ -307,10 +306,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> >
> >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size=
,
> >                              dma_addr_t *dma_handle, gfp_t flag,
> > -                            struct device *dma_dev)
> > +                            union vring_mapping_token *mapping_token)
>
> Why are you passing it by pointer? It's just an 8 bit value, pass it
> as is.

Sure.

>
>
> >  {
> >       if (vring_use_map_api(vdev)) {
> > -             return dma_alloc_coherent(dma_dev, size,
> > +             return dma_alloc_coherent(mapping_token->dma_dev, size,
> >                                         dma_handle, flag);
> >       } else {
> >               void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), flag)=
;
> > @@ -341,22 +340,22 @@ static void *vring_alloc_queue(struct virtio_devi=
ce *vdev, size_t size,
> >
> >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> >                            void *queue, dma_addr_t dma_handle,
> > -                          struct device *dma_dev)
> > +                          union vring_mapping_token *mapping_token)
> >  {
> >       if (vring_use_map_api(vdev))
> > -             dma_free_coherent(dma_dev, size, queue, dma_handle);
> > +             dma_free_coherent(mapping_token->dma_dev, size, queue, dm=
a_handle);
> >       else
> >               free_pages_exact(queue, PAGE_ALIGN(size));
> >  }
> >
> >  /*
> > - * The DMA ops on various arches are rather gnarly right now, and
> > - * making all of the arch DMA ops work on the vring device itself
> > + * The map ops on various arches are rather gnarly right now, and
>
>
> how does this make sense?

Let me fix that.

>
> > + * making all of the arch map ops work on the vring device itself
> >   * is a mess.
> >   */
> >  static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
> >  {
> > -     return vq->dma_dev;
> > +     return vq->mapping_token.dma_dev;
> >  }
> >
> >  /* Map one sg entry. */
> > @@ -1056,12 +1055,13 @@ static int vring_alloc_state_extra_split(struct=
 vring_virtqueue_split *vring_spl
> >  }
> >
> >  static void vring_free_split(struct vring_virtqueue_split *vring_split=
,
> > -                          struct virtio_device *vdev, struct device *d=
ma_dev)
> > +                          struct virtio_device *vdev,
> > +                          union vring_mapping_token *mapping_token)
> >  {
> >       vring_free_queue(vdev, vring_split->queue_size_in_bytes,
> >                        vring_split->vring.desc,
> >                        vring_split->queue_dma_addr,
> > -                      dma_dev);
> > +                      mapping_token);
> >
> >       kfree(vring_split->desc_state);
> >       kfree(vring_split->desc_extra);
> > @@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring_v=
irtqueue_split *vring_split,
> >                                  u32 num,
> >                                  unsigned int vring_align,
> >                                  bool may_reduce_num,
> > -                                struct device *dma_dev)
> > +                                union vring_mapping_token *mapping_tok=
en)
> >  {
> >       void *queue =3D NULL;
> >       dma_addr_t dma_addr;
> > @@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring_v=
irtqueue_split *vring_split,
> >               queue =3D vring_alloc_queue(vdev, vring_size(num, vring_a=
lign),
> >                                         &dma_addr,
> >                                         GFP_KERNEL | __GFP_NOWARN | __G=
FP_ZERO,
> > -                                       dma_dev);
> > +                                       mapping_token);
> >               if (queue)
> >                       break;
> >               if (!may_reduce_num)
> > @@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring_v=
irtqueue_split *vring_split,
> >               /* Try to get a single page. You are my only hope! */
> >               queue =3D vring_alloc_queue(vdev, vring_size(num, vring_a=
lign),
> >                                         &dma_addr, GFP_KERNEL | __GFP_Z=
ERO,
> > -                                       dma_dev);
> > +                                       mapping_token);
> >       }
> >       if (!queue)
> >               return -ENOMEM;
> > @@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >                                              bool (*notify)(struct virt=
queue *),
> >                                              void (*callback)(struct vi=
rtqueue *),
> >                                              const char *name,
> > -                                            struct device *dma_dev)
> > +                                            union vring_mapping_token =
*mapping_token)
> >  {
> >       struct vring_virtqueue *vq;
> >       int err;
> > @@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_sp=
lit(unsigned int index,
> >  #else
> >       vq->broken =3D false;
> >  #endif
> > -     vq->dma_dev =3D dma_dev;
> > +     vq->mapping_token =3D *mapping_token;
> >       vq->use_map_api =3D vring_use_map_api(vdev);
> >
> >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> > @@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtqueue=
_split(
> >       bool (*notify)(struct virtqueue *),
> >       void (*callback)(struct virtqueue *),
> >       const char *name,
> > -     struct device *dma_dev)
> > +     union vring_mapping_token *mapping_token)
> >  {
> >       struct vring_virtqueue_split vring_split =3D {};
> >       struct virtqueue *vq;
> >       int err;
> >
> >       err =3D vring_alloc_queue_split(&vring_split, vdev, num, vring_al=
ign,
> > -                                   may_reduce_num, dma_dev);
> > +                                   may_reduce_num, mapping_token);
> >       if (err)
> >               return NULL;
> >
> >       vq =3D __vring_new_virtqueue_split(index, &vring_split, vdev, wea=
k_barriers,
> > -                                context, notify, callback, name, dma_d=
ev);
> > +                                context, notify, callback, name, mappi=
ng_token);
> >       if (!vq) {
> > -             vring_free_split(&vring_split, vdev, dma_dev);
> > +             vring_free_split(&vring_split, vdev, mapping_token);
> >               return NULL;
> >       }
> >
> > @@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqueu=
e *_vq, u32 num)
> >       err =3D vring_alloc_queue_split(&vring_split, vdev, num,
> >                                     vq->split.vring_align,
> >                                     vq->split.may_reduce_num,
> > -                                   vring_dma_dev(vq));
> > +                                   &vq->mapping_token);
> >       if (err)
> >               goto err;
> >
> > @@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqueu=
e *_vq, u32 num)
> >       return 0;
> >
> >  err_state_extra:
> > -     vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
> > +     vring_free_split(&vring_split, vdev, &vq->mapping_token);
> >  err:
> >       virtqueue_reinit_split(vq);
> >       return -ENOMEM;
> > @@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_des=
c_extra(unsigned int num)
> >
> >  static void vring_free_packed(struct vring_virtqueue_packed *vring_pac=
ked,
> >                             struct virtio_device *vdev,
> > -                           struct device *dma_dev)
> > +                           union vring_mapping_token *mapping_token)
> >  {
> >       if (vring_packed->vring.desc)
> >               vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
> >                                vring_packed->vring.desc,
> >                                vring_packed->ring_dma_addr,
> > -                              dma_dev);
> > +                              mapping_token);
> >
> >       if (vring_packed->vring.driver)
> >               vring_free_queue(vdev, vring_packed->event_size_in_bytes,
> >                                vring_packed->vring.driver,
> >                                vring_packed->driver_event_dma_addr,
> > -                              dma_dev);
> > +                              mapping_token);
> >
> >       if (vring_packed->vring.device)
> >               vring_free_queue(vdev, vring_packed->event_size_in_bytes,
> >                                vring_packed->vring.device,
> >                                vring_packed->device_event_dma_addr,
> > -                              dma_dev);
> > +                              mapping_token);
> >
> >       kfree(vring_packed->desc_state);
> >       kfree(vring_packed->desc_extra);
> > @@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virtqu=
eue_packed *vring_packed,
> >
> >  static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vri=
ng_packed,
> >                                   struct virtio_device *vdev,
> > -                                 u32 num, struct device *dma_dev)
> > +                                 u32 num, union vring_mapping_token *m=
apping_token)
> >  {
> >       struct vring_packed_desc *ring;
> >       struct vring_packed_desc_event *driver, *device;
> > @@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vring_=
virtqueue_packed *vring_packed,
> >       ring =3D vring_alloc_queue(vdev, ring_size_in_bytes,
> >                                &ring_dma_addr,
> >                                GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
> > -                              dma_dev);
> > +                              mapping_token);
> >       if (!ring)
> >               goto err;
> >
> > @@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vring_=
virtqueue_packed *vring_packed,
> >       driver =3D vring_alloc_queue(vdev, event_size_in_bytes,
> >                                  &driver_event_dma_addr,
> >                                  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO=
,
> > -                                dma_dev);
> > +                                mapping_token);
> >       if (!driver)
> >               goto err;
> >
> > @@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vring_=
virtqueue_packed *vring_packed,
> >       device =3D vring_alloc_queue(vdev, event_size_in_bytes,
> >                                  &device_event_dma_addr,
> >                                  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO=
,
> > -                                dma_dev);
> > +                                mapping_token);
> >       if (!device)
> >               goto err;
> >
> > @@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vring_=
virtqueue_packed *vring_packed,
> >       return 0;
> >
> >  err:
> > -     vring_free_packed(vring_packed, vdev, dma_dev);
> > +     vring_free_packed(vring_packed, vdev, mapping_token);
> >       return -ENOMEM;
> >  }
> >
> > @@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_pa=
cked(unsigned int index,
> >                                              bool (*notify)(struct virt=
queue *),
> >                                              void (*callback)(struct vi=
rtqueue *),
> >                                              const char *name,
> > -                                            struct device *dma_dev)
> > +                                            union vring_mapping_token =
*mapping_token)
> >  {
> >       struct vring_virtqueue *vq;
> >       int err;
> > @@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_pa=
cked(unsigned int index,
> >       vq->broken =3D false;
> >  #endif
> >       vq->packed_ring =3D true;
> > -     vq->dma_dev =3D dma_dev;
> > +     vq->mapping_token =3D *mapping_token;
> >       vq->use_map_api =3D vring_use_map_api(vdev);
> >
> >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> > @@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtqueue=
_packed(
> >       bool (*notify)(struct virtqueue *),
> >       void (*callback)(struct virtqueue *),
> >       const char *name,
> > -     struct device *dma_dev)
> > +     union vring_mapping_token *mapping_token)
> >  {
> >       struct vring_virtqueue_packed vring_packed =3D {};
> >       struct virtqueue *vq;
> >
> > -     if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
> > +     if (vring_alloc_queue_packed(&vring_packed, vdev, num, mapping_to=
ken))
> >               return NULL;
> >
> >       vq =3D __vring_new_virtqueue_packed(index, &vring_packed, vdev, w=
eak_barriers,
> > -                                     context, notify, callback, name, =
dma_dev);
> > +                                     context, notify, callback, name, =
mapping_token);
> >       if (!vq) {
> > -             vring_free_packed(&vring_packed, vdev, dma_dev);
> > +             vring_free_packed(&vring_packed, vdev, mapping_token);
> >               return NULL;
> >       }
> >
> > @@ -2185,7 +2185,8 @@ static int virtqueue_resize_packed(struct virtque=
ue *_vq, u32 num)
> >       struct virtio_device *vdev =3D _vq->vdev;
> >       int err;
> >
> > -     if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_=
dev(vq)))
> > +     if (vring_alloc_queue_packed(&vring_packed, vdev,
> > +                                  num, &vq->mapping_token))
> >               goto err_ring;
> >
> >       err =3D vring_alloc_state_extra_packed(&vring_packed);
> > @@ -2202,7 +2203,7 @@ static int virtqueue_resize_packed(struct virtque=
ue *_vq, u32 num)
> >       return 0;
> >
> >  err_state_extra:
> > -     vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
> > +     vring_free_packed(&vring_packed, vdev, &vq->mapping_token);
> >  err_ring:
> >       virtqueue_reinit_packed(vq);
> >       return -ENOMEM;
> > @@ -2423,6 +2424,7 @@ int virtqueue_add_inbuf_premapped(struct virtqueu=
e *vq,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
> >
> > +
> >  /**
> >   * virtqueue_dma_dev - get the dma dev
> >   * @_vq: the struct virtqueue we're talking about.
>
>
> and this?

Will fix.

>
> > @@ -2434,7 +2436,7 @@ struct device *virtqueue_dma_dev(struct virtqueue=
 *_vq)
> >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> >       if (vq->use_map_api)
> > -             return vring_dma_dev(vq);
> > +             return vq->mapping_token.dma_dev;
> >       else
> >               return NULL;
> >  }
> > @@ -2719,19 +2721,20 @@ struct virtqueue *vring_create_virtqueue(
> >       void (*callback)(struct virtqueue *),
> >       const char *name)
> >  {
> > +     union vring_mapping_token mapping_token =3D {.dma_dev =3D vdev->d=
ev.parent};
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> >               return vring_create_virtqueue_packed(index, num, vring_al=
ign,
> >                               vdev, weak_barriers, may_reduce_num,
> > -                             context, notify, callback, name, vdev->de=
v.parent);
> > +                             context, notify, callback, name, &mapping=
_token);
> >
> >       return vring_create_virtqueue_split(index, num, vring_align,
> >                       vdev, weak_barriers, may_reduce_num,
> > -                     context, notify, callback, name, vdev->dev.parent=
);
> > +                     context, notify, callback, name, &mapping_token);
> >  }
> >  EXPORT_SYMBOL_GPL(vring_create_virtqueue);
> >
> > -struct virtqueue *vring_create_virtqueue_dma(
> > +struct virtqueue *vring_create_virtqueue_map(
> >       unsigned int index,
> >       unsigned int num,
> >       unsigned int vring_align,
> > @@ -2742,19 +2745,19 @@ struct virtqueue *vring_create_virtqueue_dma(
> >       bool (*notify)(struct virtqueue *),
> >       void (*callback)(struct virtqueue *),
> >       const char *name,
> > -     struct device *dma_dev)
> > +     union vring_mapping_token *mapping_token)
> >  {
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> >               return vring_create_virtqueue_packed(index, num, vring_al=
ign,
> >                               vdev, weak_barriers, may_reduce_num,
> > -                             context, notify, callback, name, dma_dev)=
;
> > +                             context, notify, callback, name, mapping_=
token);
> >
> >       return vring_create_virtqueue_split(index, num, vring_align,
> >                       vdev, weak_barriers, may_reduce_num,
> > -                     context, notify, callback, name, dma_dev);
> > +                     context, notify, callback, name, mapping_token);
> >  }
> > -EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
> > +EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
> >
> >  /**
> >   * virtqueue_resize - resize the vring of vq
> > @@ -2865,6 +2868,7 @@ struct virtqueue *vring_new_virtqueue(unsigned in=
t index,
> >                                     const char *name)
> >  {
> >       struct vring_virtqueue_split vring_split =3D {};
> > +     union vring_mapping_token mapping_token =3D {.dma_dev =3D vdev->d=
ev.parent};
> >
> >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >               struct vring_virtqueue_packed vring_packed =3D {};
> > @@ -2874,13 +2878,13 @@ struct virtqueue *vring_new_virtqueue(unsigned =
int index,
> >               return __vring_new_virtqueue_packed(index, &vring_packed,
> >                                                   vdev, weak_barriers,
> >                                                   context, notify, call=
back,
> > -                                                 name, vdev->dev.paren=
t);
> > +                                                 name, &mapping_token)=
;
> >       }
> >
> >       vring_init(&vring_split.vring, num, pages, vring_align);
> >       return __vring_new_virtqueue_split(index, &vring_split, vdev, wea=
k_barriers,
> >                                    context, notify, callback, name,
> > -                                  vdev->dev.parent);
> > +                                  &mapping_token);
> >  }
> >  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
> >
> > @@ -2894,19 +2898,19 @@ static void vring_free(struct virtqueue *_vq)
> >                                        vq->packed.ring_size_in_bytes,
> >                                        vq->packed.vring.desc,
> >                                        vq->packed.ring_dma_addr,
> > -                                      vring_dma_dev(vq));
> > +                                      &vq->mapping_token);
> >
> >                       vring_free_queue(vq->vq.vdev,
> >                                        vq->packed.event_size_in_bytes,
> >                                        vq->packed.vring.driver,
> >                                        vq->packed.driver_event_dma_addr=
,
> > -                                      vring_dma_dev(vq));
> > +                                      &vq->mapping_token);
> >
> >                       vring_free_queue(vq->vq.vdev,
> >                                        vq->packed.event_size_in_bytes,
> >                                        vq->packed.vring.device,
> >                                        vq->packed.device_event_dma_addr=
,
> > -                                      vring_dma_dev(vq));
> > +                                      &vq->mapping_token);
> >
> >                       kfree(vq->packed.desc_state);
> >                       kfree(vq->packed.desc_extra);
> > @@ -2915,7 +2919,7 @@ static void vring_free(struct virtqueue *_vq)
> >                                        vq->split.queue_size_in_bytes,
> >                                        vq->split.vring.desc,
> >                                        vq->split.queue_dma_addr,
> > -                                      vring_dma_dev(vq));
> > +                                      &vq->mapping_token);
> >               }
> >       }
> >       if (!vq->packed_ring) {
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.=
c
> > index e25610e3393a..acea98ab08ee 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -139,6 +139,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, un=
signed int index,
> >       struct vdpa_callback cb;
> >       struct virtqueue *vq;
> >       u64 desc_addr, driver_addr, device_addr;
> > +     union vring_mapping_token mapping_token =3D {0};
> >       /* Assume split virtqueue, switch to packed if necessary */
> >       struct vdpa_vq_state state =3D {0};
> >       u32 align, max_num, min_num =3D 1;
> > @@ -185,9 +186,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, u=
nsigned int index,
> >               dma_dev =3D ops->get_vq_dma_dev(vdpa, index);
> >       else
> >               dma_dev =3D vdpa_get_dma_dev(vdpa);
> > -     vq =3D vring_create_virtqueue_dma(index, max_num, align, vdev,
> > +     mapping_token.dma_dev =3D dma_dev;
> > +     vq =3D vring_create_virtqueue_map(index, max_num, align, vdev,
> >                                       true, may_reduce_num, ctx,
> > -                                     notify, callback, name, dma_dev);
> > +                                     notify, callback, name, &mapping_=
token);
> >       if (!vq) {
> >               err =3D -ENOMEM;
> >               goto error_new_virtqueue;
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index addbc209275a..37029df94aaf 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -40,6 +40,13 @@ struct virtqueue {
> >       void *priv;
> >  };
> >
> > +union vring_mapping_token {
> > +     /* Device that performs DMA */
> > +     struct device *dma_dev;
> > +     /* Transport specific token used for doing map */
> > +     void *opaque;
>
> Please just declare whatever structure you want it to be.

It's an opaque one and so

1) the virtio core knows nothing about that because it could be
transport or device specific
2) no assumption of the type and usage, it just receive it from the
transport and pass it back when doing the mapping

It should work like page->private etc.

Does this make sense?

Thanks

>
> > +};
> > +
> >  int virtqueue_add_outbuf(struct virtqueue *vq,
> >                        struct scatterlist sg[], unsigned int num,
> >                        void *data,
> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index 9b33df741b63..fd997178da2a 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -3,6 +3,7 @@
> >  #define _LINUX_VIRTIO_RING_H
> >
> >  #include <asm/barrier.h>
> > +#include <linux/virtio.h>
> >  #include <linux/irqreturn.h>
> >  #include <uapi/linux/virtio_ring.h>
> >
> > @@ -79,9 +80,9 @@ struct virtqueue *vring_create_virtqueue(unsigned int=
 index,
> >
> >  /*
> >   * Creates a virtqueue and allocates the descriptor ring with per
> > - * virtqueue DMA device.
> > + * virtqueue mapping operations.
> >   */
> > -struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
> > +struct virtqueue *vring_create_virtqueue_map(unsigned int index,
> >                                            unsigned int num,
> >                                            unsigned int vring_align,
> >                                            struct virtio_device *vdev,
> > @@ -91,7 +92,7 @@ struct virtqueue *vring_create_virtqueue_dma(unsigned=
 int index,
> >                                            bool (*notify)(struct virtqu=
eue *vq),
> >                                            void (*callback)(struct virt=
queue *vq),
> >                                            const char *name,
> > -                                          struct device *dma_dev);
> > +                                          union vring_mapping_token *m=
apping_token);
> >
> >  /*
> >   * Creates a virtqueue with a standard layout but a caller-allocated
> > --
> > 2.31.1
>

