Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8032FF660
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755142775; cv=none; b=RKqs7s77pXcSqG6ZDd4YZF0zyT+Mz4O+LdRhxkB4L5nTi/uAIvy36aTZRmv8J38H98Lywl1DNY4UdT09OLcJaZBlkMJXfj28giaFnE5pYx1RON8+n3hot0yoJIvafSXb6V8oqnREmuUTjZW7PhNNXH2SQ8OU8LbHhNlEBsut42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755142775; c=relaxed/simple;
	bh=x6Q7Vq/NfbDomm1gHXNxmu18QiSPUEIujMhAlWFrHqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNy/GxkXlOYQIM019rHR/GTWUIK57EKyoyU00AY6xsqGZg26bD+Bs8ZUP8G3xeoMLOI8XlMlJ43nrUVbTYzBfdpj1gsgd2DjTvkmvfOM00XBbCe2P5/4/uMGERfjQQFxl6FhfDK6jz23evIa4/XvQbVi/jVZIYx513+D4Et08xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRZIwEPD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRZIwEPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755142771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQuleDNmdvlGKuIuPyfeFI5TZd8GYOMu99LGJeUVEf4=;
	b=PRZIwEPDi2hAzSz6KoC4mPM7eLiy4vluElAsbs0Qc3ahaUxKOxhUN/Zv/A4p4Jf7fkZnPK
	usPMKmbMB8iMVIuLqAp125sePOL8+FueituhxxQSHHbpYmVjh2/ySSav9dKSYuuWV7WNzl
	lSXhe33c0qw3+pRLRzkkd+rXALLMVRU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-FwkPxuvCM0GPmOGsYAYokA-1; Wed, 13 Aug 2025 23:39:30 -0400
X-MC-Unique: FwkPxuvCM0GPmOGsYAYokA-1
X-Mimecast-MFC-AGG-ID: FwkPxuvCM0GPmOGsYAYokA_1755142769
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323266a1e87so528695a91.0
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 20:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755142769; x=1755747569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQuleDNmdvlGKuIuPyfeFI5TZd8GYOMu99LGJeUVEf4=;
        b=vsQ3hrPq6br0vq5RkFWPv9iPO31trwQWuuH3FcmWL6fQoSY/bWHe7PfISFOM8hylMf
         EvESAWUIWmzY1v7JPyU9BIeIN3v0UeClcUS8MCJqVvENOK9fY3lfCb6YrLsozUnrlA5J
         2TXaTPGICabPTusD5BJSSU9ZhfDbRFNMapS2YTlcjMHMMPwavfDOdo0W101+nzLJ6M9Y
         WM7K/hth7TUlNKUThta2SyjWEjVVrl98o/+zRBdD6YzpkdDXicgMAikuVZlGuPK5V4YQ
         UM1oA0dsPVpqxirca2iKZ/ZSh3EruQJiPMUhtmuip3WksbIxcTgvWvBqhCv9ZEAfD1Ku
         /oTg==
X-Forwarded-Encrypted: i=1; AJvYcCVnVV7MDACjj/svT2/26IsfDssHuXY/owQtGjZFe/LNssPa8ncO1fPtGHPOJn0f0yu3e/wzshMW3qzIdmbngg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7BWZMsqpvVjSqy70VVvQBkwBQLPe5Nggs0mC2x4NPnWLPsf09
	Krp4O2bk8b7BEl1o5WXazwTwdkPtLwdP/MwwEKvZCr5O5SQQ31JHbqVTNMTbdot/dCyZrD/lfti
	SdUB8n4WUXYRew0ywAya6s+54jx0h9sz0b1btvCUWusOWRh3MmL7/ubXtcDBe0Sgf8QhHVZg4ls
	EwJQ/Cng7bgAbha5QNKPLBqq/W3gLEzNEYNbgbAdUVPIY=
X-Gm-Gg: ASbGncsjPMyraCssG1IS0veGRCRf+uRt50kAioKteWZ3HmY8CYMiflOHY4ZdK2MIDVK
	kDEgI/QkNCyu1XxHN9kS7B/XSe8sQ36axUX5kzyml+8r18Bge06vKGkiZFpt+UrVaBIjHoGTrws
	7cc+Wp0ABuN9xfH9tuSz9m4g==
X-Received: by 2002:a17:90b:35cc:b0:311:c939:c851 with SMTP id 98e67ed59e1d1-32327a7c120mr2192031a91.4.1755142768964;
        Wed, 13 Aug 2025 20:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3aa0rxcdHjMe7mJb3s3Sb1/ChGGMarriGgqgya1C/yb2OhSrcwg3h1N0OCiIs7xYIG5paV3YKUIdNQ8HTCeE=
X-Received: by 2002:a17:90b:35cc:b0:311:c939:c851 with SMTP id
 98e67ed59e1d1-32327a7c120mr2191978a91.4.1755142768128; Wed, 13 Aug 2025
 20:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
 <20250813043151-mutt-send-email-mst@kernel.org> <CAJaqyWcPW+e5damPvgcmC_sjs7UoDk+pj-pVHAezaJQO4Ard0A@mail.gmail.com>
In-Reply-To: <CAJaqyWcPW+e5damPvgcmC_sjs7UoDk+pj-pVHAezaJQO4Ard0A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Aug 2025 11:39:16 +0800
X-Gm-Features: Ac12FXxbkBxEp6YqL6Qxa9zNp9VM2uGtM3BPd1VDHzG42iblnDg5VpA5seCB-uc
Message-ID: <CACGkMEsVtEwLv5VZqJc_658PcY6NKhh6iqW2PGCY8e8FV50sMA@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4m0NaIk4weSRcQ4KVuvf4OMFpyWzW1HdGbn0DoEsFoU_1755142769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:14=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Aug 13, 2025 at 10:55=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Wed, Aug 13, 2025 at 01:48:26PM +0800, Jason Wang wrote:
> > > Following patch will introduce the mapping operations for virtio
> > > device. In order to achieve this, besides the dma device, virtio core
> > > needs to support a transport or device specific mapping token as well=
.
> > > So this patch introduces a union container of a dma device and opaque
> > > mapping token. The idea is the allow the transport layer to pass
> > > device specific mapping token which will be used as a parameter for
> > > the virtio mapping operations. For the transport or device that is
> > > using DMA, dma device is still being used.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++---------------=
--
> > >  drivers/virtio/virtio_vdpa.c |   6 +-
> > >  include/linux/virtio.h       |   7 +++
> > >  include/linux/virtio_ring.h  |   7 ++-
> > >  4 files changed, 72 insertions(+), 58 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 482a268af851..fb1d407d5f1b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -210,8 +210,7 @@ struct vring_virtqueue {
> > >       /* DMA, allocation, and size information */
> > >       bool we_own_ring;
> > >
> > > -     /* Device used for doing DMA */
> > > -     struct device *dma_dev;
> > > +     union vring_mapping_token mapping_token;
> > >
> > >  #ifdef DEBUG
> > >       /* They're supposed to lock for us. */
> > > @@ -307,10 +306,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> > >
> > >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t si=
ze,
> > >                              dma_addr_t *dma_handle, gfp_t flag,
> > > -                            struct device *dma_dev)
> > > +                            union vring_mapping_token *mapping_token=
)
> >
> > Why are you passing it by pointer? It's just an 8 bit value, pass it
> > as is.
> >
> >
> > >  {
> > >       if (vring_use_map_api(vdev)) {
> > > -             return dma_alloc_coherent(dma_dev, size,
> > > +             return dma_alloc_coherent(mapping_token->dma_dev, size,
> > >                                         dma_handle, flag);
> > >       } else {
> > >               void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), fla=
g);
> > > @@ -341,22 +340,22 @@ static void *vring_alloc_queue(struct virtio_de=
vice *vdev, size_t size,
> > >
> > >  static void vring_free_queue(struct virtio_device *vdev, size_t size=
,
> > >                            void *queue, dma_addr_t dma_handle,
> > > -                          struct device *dma_dev)
> > > +                          union vring_mapping_token *mapping_token)
> > >  {
> > >       if (vring_use_map_api(vdev))
> > > -             dma_free_coherent(dma_dev, size, queue, dma_handle);
> > > +             dma_free_coherent(mapping_token->dma_dev, size, queue, =
dma_handle);
> > >       else
> > >               free_pages_exact(queue, PAGE_ALIGN(size));
> > >  }
> > >
> > >  /*
> > > - * The DMA ops on various arches are rather gnarly right now, and
> > > - * making all of the arch DMA ops work on the vring device itself
> > > + * The map ops on various arches are rather gnarly right now, and
> >
> >
> > how does this make sense?
> >
> > > + * making all of the arch map ops work on the vring device itself
> > >   * is a mess.
> > >   */
> > >  static struct device *vring_dma_dev(const struct vring_virtqueue *vq=
)
> > >  {
> > > -     return vq->dma_dev;
> > > +     return vq->mapping_token.dma_dev;
> > >  }
> > >
> > >  /* Map one sg entry. */
> > > @@ -1056,12 +1055,13 @@ static int vring_alloc_state_extra_split(stru=
ct vring_virtqueue_split *vring_spl
> > >  }
> > >
> > >  static void vring_free_split(struct vring_virtqueue_split *vring_spl=
it,
> > > -                          struct virtio_device *vdev, struct device =
*dma_dev)
> > > +                          struct virtio_device *vdev,
> > > +                          union vring_mapping_token *mapping_token)
> > >  {
> > >       vring_free_queue(vdev, vring_split->queue_size_in_bytes,
> > >                        vring_split->vring.desc,
> > >                        vring_split->queue_dma_addr,
> > > -                      dma_dev);
> > > +                      mapping_token);
> > >
> > >       kfree(vring_split->desc_state);
> > >       kfree(vring_split->desc_extra);
> > > @@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring=
_virtqueue_split *vring_split,
> > >                                  u32 num,
> > >                                  unsigned int vring_align,
> > >                                  bool may_reduce_num,
> > > -                                struct device *dma_dev)
> > > +                                union vring_mapping_token *mapping_t=
oken)
> > >  {
> > >       void *queue =3D NULL;
> > >       dma_addr_t dma_addr;
> > > @@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring=
_virtqueue_split *vring_split,
> > >               queue =3D vring_alloc_queue(vdev, vring_size(num, vring=
_align),
> > >                                         &dma_addr,
> > >                                         GFP_KERNEL | __GFP_NOWARN | _=
_GFP_ZERO,
> > > -                                       dma_dev);
> > > +                                       mapping_token);
> > >               if (queue)
> > >                       break;
> > >               if (!may_reduce_num)
> > > @@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring=
_virtqueue_split *vring_split,
> > >               /* Try to get a single page. You are my only hope! */
> > >               queue =3D vring_alloc_queue(vdev, vring_size(num, vring=
_align),
> > >                                         &dma_addr, GFP_KERNEL | __GFP=
_ZERO,
> > > -                                       dma_dev);
> > > +                                       mapping_token);
> > >       }
> > >       if (!queue)
> > >               return -ENOMEM;
> > > @@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_=
split(unsigned int index,
> > >                                              bool (*notify)(struct vi=
rtqueue *),
> > >                                              void (*callback)(struct =
virtqueue *),
> > >                                              const char *name,
> > > -                                            struct device *dma_dev)
> > > +                                            union vring_mapping_toke=
n *mapping_token)
> > >  {
> > >       struct vring_virtqueue *vq;
> > >       int err;
> > > @@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_=
split(unsigned int index,
> > >  #else
> > >       vq->broken =3D false;
> > >  #endif
> > > -     vq->dma_dev =3D dma_dev;
> > > +     vq->mapping_token =3D *mapping_token;
> > >       vq->use_map_api =3D vring_use_map_api(vdev);
> > >
> > >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIREC=
T_DESC) &&
> > > @@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtque=
ue_split(
> > >       bool (*notify)(struct virtqueue *),
> > >       void (*callback)(struct virtqueue *),
> > >       const char *name,
> > > -     struct device *dma_dev)
> > > +     union vring_mapping_token *mapping_token)
> > >  {
> > >       struct vring_virtqueue_split vring_split =3D {};
> > >       struct virtqueue *vq;
> > >       int err;
> > >
> > >       err =3D vring_alloc_queue_split(&vring_split, vdev, num, vring_=
align,
> > > -                                   may_reduce_num, dma_dev);
> > > +                                   may_reduce_num, mapping_token);
> > >       if (err)
> > >               return NULL;
> > >
> > >       vq =3D __vring_new_virtqueue_split(index, &vring_split, vdev, w=
eak_barriers,
> > > -                                context, notify, callback, name, dma=
_dev);
> > > +                                context, notify, callback, name, map=
ping_token);
> > >       if (!vq) {
> > > -             vring_free_split(&vring_split, vdev, dma_dev);
> > > +             vring_free_split(&vring_split, vdev, mapping_token);
> > >               return NULL;
> > >       }
> > >
> > > @@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqu=
eue *_vq, u32 num)
> > >       err =3D vring_alloc_queue_split(&vring_split, vdev, num,
> > >                                     vq->split.vring_align,
> > >                                     vq->split.may_reduce_num,
> > > -                                   vring_dma_dev(vq));
> > > +                                   &vq->mapping_token);
> > >       if (err)
> > >               goto err;
> > >
> > > @@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqu=
eue *_vq, u32 num)
> > >       return 0;
> > >
> > >  err_state_extra:
> > > -     vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
> > > +     vring_free_split(&vring_split, vdev, &vq->mapping_token);
> > >  err:
> > >       virtqueue_reinit_split(vq);
> > >       return -ENOMEM;
> > > @@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_d=
esc_extra(unsigned int num)
> > >
> > >  static void vring_free_packed(struct vring_virtqueue_packed *vring_p=
acked,
> > >                             struct virtio_device *vdev,
> > > -                           struct device *dma_dev)
> > > +                           union vring_mapping_token *mapping_token)
> > >  {
> > >       if (vring_packed->vring.desc)
> > >               vring_free_queue(vdev, vring_packed->ring_size_in_bytes=
,
> > >                                vring_packed->vring.desc,
> > >                                vring_packed->ring_dma_addr,
> > > -                              dma_dev);
> > > +                              mapping_token);
> > >
> > >       if (vring_packed->vring.driver)
> > >               vring_free_queue(vdev, vring_packed->event_size_in_byte=
s,
> > >                                vring_packed->vring.driver,
> > >                                vring_packed->driver_event_dma_addr,
> > > -                              dma_dev);
> > > +                              mapping_token);
> > >
> > >       if (vring_packed->vring.device)
> > >               vring_free_queue(vdev, vring_packed->event_size_in_byte=
s,
> > >                                vring_packed->vring.device,
> > >                                vring_packed->device_event_dma_addr,
> > > -                              dma_dev);
> > > +                              mapping_token);
> > >
> > >       kfree(vring_packed->desc_state);
> > >       kfree(vring_packed->desc_extra);
> > > @@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virt=
queue_packed *vring_packed,
> > >
> > >  static int vring_alloc_queue_packed(struct vring_virtqueue_packed *v=
ring_packed,
> > >                                   struct virtio_device *vdev,
> > > -                                 u32 num, struct device *dma_dev)
> > > +                                 u32 num, union vring_mapping_token =
*mapping_token)
> > >  {
> > >       struct vring_packed_desc *ring;
> > >       struct vring_packed_desc_event *driver, *device;
> > > @@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vrin=
g_virtqueue_packed *vring_packed,
> > >       ring =3D vring_alloc_queue(vdev, ring_size_in_bytes,
> > >                                &ring_dma_addr,
> > >                                GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO=
,
> > > -                              dma_dev);
> > > +                              mapping_token);
> > >       if (!ring)
> > >               goto err;
> > >
> > > @@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vrin=
g_virtqueue_packed *vring_packed,
> > >       driver =3D vring_alloc_queue(vdev, event_size_in_bytes,
> > >                                  &driver_event_dma_addr,
> > >                                  GFP_KERNEL | __GFP_NOWARN | __GFP_ZE=
RO,
> > > -                                dma_dev);
> > > +                                mapping_token);
> > >       if (!driver)
> > >               goto err;
> > >
> > > @@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vrin=
g_virtqueue_packed *vring_packed,
> > >       device =3D vring_alloc_queue(vdev, event_size_in_bytes,
> > >                                  &device_event_dma_addr,
> > >                                  GFP_KERNEL | __GFP_NOWARN | __GFP_ZE=
RO,
> > > -                                dma_dev);
> > > +                                mapping_token);
> > >       if (!device)
> > >               goto err;
> > >
> > > @@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vrin=
g_virtqueue_packed *vring_packed,
> > >       return 0;
> > >
> > >  err:
> > > -     vring_free_packed(vring_packed, vdev, dma_dev);
> > > +     vring_free_packed(vring_packed, vdev, mapping_token);
> > >       return -ENOMEM;
> > >  }
> > >
> > > @@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_=
packed(unsigned int index,
> > >                                              bool (*notify)(struct vi=
rtqueue *),
> > >                                              void (*callback)(struct =
virtqueue *),
> > >                                              const char *name,
> > > -                                            struct device *dma_dev)
> > > +                                            union vring_mapping_toke=
n *mapping_token)
> > >  {
> > >       struct vring_virtqueue *vq;
> > >       int err;
> > > @@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_=
packed(unsigned int index,
> > >       vq->broken =3D false;
> > >  #endif
> > >       vq->packed_ring =3D true;
> > > -     vq->dma_dev =3D dma_dev;
> > > +     vq->mapping_token =3D *mapping_token;
> > >       vq->use_map_api =3D vring_use_map_api(vdev);
> > >
> > >       vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIREC=
T_DESC) &&
> > > @@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtque=
ue_packed(
> > >       bool (*notify)(struct virtqueue *),
> > >       void (*callback)(struct virtqueue *),
> > >       const char *name,
> > > -     struct device *dma_dev)
> > > +     union vring_mapping_token *mapping_token)
> > >  {
> > >       struct vring_virtqueue_packed vring_packed =3D {};
> > >       struct virtqueue *vq;
> > >
> > > -     if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev)=
)
> > > +     if (vring_alloc_queue_packed(&vring_packed, vdev, num, mapping_=
token))
> > >               return NULL;
> > >
> > >       vq =3D __vring_new_virtqueue_packed(index, &vring_packed, vdev,=
 weak_barriers,
> > > -                                     context, notify, callback, name=
, dma_dev);
> > > +                                     context, notify, callback, name=
, mapping_token);
> > >       if (!vq) {
> > > -             vring_free_packed(&vring_packed, vdev, dma_dev);
> > > +             vring_free_packed(&vring_packed, vdev, mapping_token);
> > >               return NULL;
> > >       }
> > >
> > > @@ -2185,7 +2185,8 @@ static int virtqueue_resize_packed(struct virtq=
ueue *_vq, u32 num)
> > >       struct virtio_device *vdev =3D _vq->vdev;
> > >       int err;
> > >
> > > -     if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dm=
a_dev(vq)))
> > > +     if (vring_alloc_queue_packed(&vring_packed, vdev,
> > > +                                  num, &vq->mapping_token))
> > >               goto err_ring;
> > >
> > >       err =3D vring_alloc_state_extra_packed(&vring_packed);
> > > @@ -2202,7 +2203,7 @@ static int virtqueue_resize_packed(struct virtq=
ueue *_vq, u32 num)
> > >       return 0;
> > >
> > >  err_state_extra:
> > > -     vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
> > > +     vring_free_packed(&vring_packed, vdev, &vq->mapping_token);
> > >  err_ring:
> > >       virtqueue_reinit_packed(vq);
> > >       return -ENOMEM;
> > > @@ -2423,6 +2424,7 @@ int virtqueue_add_inbuf_premapped(struct virtqu=
eue *vq,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
> > >
> > > +
> > >  /**
> > >   * virtqueue_dma_dev - get the dma dev
> > >   * @_vq: the struct virtqueue we're talking about.
> >
> >
> > and this?
> >
> > > @@ -2434,7 +2436,7 @@ struct device *virtqueue_dma_dev(struct virtque=
ue *_vq)
> > >       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > >
> > >       if (vq->use_map_api)
> > > -             return vring_dma_dev(vq);
> > > +             return vq->mapping_token.dma_dev;
> > >       else
> > >               return NULL;
> > >  }
> > > @@ -2719,19 +2721,20 @@ struct virtqueue *vring_create_virtqueue(
> > >       void (*callback)(struct virtqueue *),
> > >       const char *name)
> > >  {
> > > +     union vring_mapping_token mapping_token =3D {.dma_dev =3D vdev-=
>dev.parent};
> > >
> > >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> > >               return vring_create_virtqueue_packed(index, num, vring_=
align,
> > >                               vdev, weak_barriers, may_reduce_num,
> > > -                             context, notify, callback, name, vdev->=
dev.parent);
> > > +                             context, notify, callback, name, &mappi=
ng_token);
> > >
> > >       return vring_create_virtqueue_split(index, num, vring_align,
> > >                       vdev, weak_barriers, may_reduce_num,
> > > -                     context, notify, callback, name, vdev->dev.pare=
nt);
> > > +                     context, notify, callback, name, &mapping_token=
);
> > >  }
> > >  EXPORT_SYMBOL_GPL(vring_create_virtqueue);
> > >
> > > -struct virtqueue *vring_create_virtqueue_dma(
> > > +struct virtqueue *vring_create_virtqueue_map(
> > >       unsigned int index,
> > >       unsigned int num,
> > >       unsigned int vring_align,
> > > @@ -2742,19 +2745,19 @@ struct virtqueue *vring_create_virtqueue_dma(
> > >       bool (*notify)(struct virtqueue *),
> > >       void (*callback)(struct virtqueue *),
> > >       const char *name,
> > > -     struct device *dma_dev)
> > > +     union vring_mapping_token *mapping_token)
> > >  {
> > >
> > >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> > >               return vring_create_virtqueue_packed(index, num, vring_=
align,
> > >                               vdev, weak_barriers, may_reduce_num,
> > > -                             context, notify, callback, name, dma_de=
v);
> > > +                             context, notify, callback, name, mappin=
g_token);
> > >
> > >       return vring_create_virtqueue_split(index, num, vring_align,
> > >                       vdev, weak_barriers, may_reduce_num,
> > > -                     context, notify, callback, name, dma_dev);
> > > +                     context, notify, callback, name, mapping_token)=
;
> > >  }
> > > -EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
> > > +EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
> > >
> > >  /**
> > >   * virtqueue_resize - resize the vring of vq
> > > @@ -2865,6 +2868,7 @@ struct virtqueue *vring_new_virtqueue(unsigned =
int index,
> > >                                     const char *name)
> > >  {
> > >       struct vring_virtqueue_split vring_split =3D {};
> > > +     union vring_mapping_token mapping_token =3D {.dma_dev =3D vdev-=
>dev.parent};
> > >
> > >       if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> > >               struct vring_virtqueue_packed vring_packed =3D {};
> > > @@ -2874,13 +2878,13 @@ struct virtqueue *vring_new_virtqueue(unsigne=
d int index,
> > >               return __vring_new_virtqueue_packed(index, &vring_packe=
d,
> > >                                                   vdev, weak_barriers=
,
> > >                                                   context, notify, ca=
llback,
> > > -                                                 name, vdev->dev.par=
ent);
> > > +                                                 name, &mapping_toke=
n);
> > >       }
> > >
> > >       vring_init(&vring_split.vring, num, pages, vring_align);
> > >       return __vring_new_virtqueue_split(index, &vring_split, vdev, w=
eak_barriers,
> > >                                    context, notify, callback, name,
> > > -                                  vdev->dev.parent);
> > > +                                  &mapping_token);
> > >  }
> > >  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
> > >
> > > @@ -2894,19 +2898,19 @@ static void vring_free(struct virtqueue *_vq)
> > >                                        vq->packed.ring_size_in_bytes,
> > >                                        vq->packed.vring.desc,
> > >                                        vq->packed.ring_dma_addr,
> > > -                                      vring_dma_dev(vq));
> > > +                                      &vq->mapping_token);
> > >
> > >                       vring_free_queue(vq->vq.vdev,
> > >                                        vq->packed.event_size_in_bytes=
,
> > >                                        vq->packed.vring.driver,
> > >                                        vq->packed.driver_event_dma_ad=
dr,
> > > -                                      vring_dma_dev(vq));
> > > +                                      &vq->mapping_token);
> > >
> > >                       vring_free_queue(vq->vq.vdev,
> > >                                        vq->packed.event_size_in_bytes=
,
> > >                                        vq->packed.vring.device,
> > >                                        vq->packed.device_event_dma_ad=
dr,
> > > -                                      vring_dma_dev(vq));
> > > +                                      &vq->mapping_token);
> > >
> > >                       kfree(vq->packed.desc_state);
> > >                       kfree(vq->packed.desc_extra);
> > > @@ -2915,7 +2919,7 @@ static void vring_free(struct virtqueue *_vq)
> > >                                        vq->split.queue_size_in_bytes,
> > >                                        vq->split.vring.desc,
> > >                                        vq->split.queue_dma_addr,
> > > -                                      vring_dma_dev(vq));
> > > +                                      &vq->mapping_token);
> > >               }
> > >       }
> > >       if (!vq->packed_ring) {
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdp=
a.c
> > > index e25610e3393a..acea98ab08ee 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -139,6 +139,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, =
unsigned int index,
> > >       struct vdpa_callback cb;
> > >       struct virtqueue *vq;
> > >       u64 desc_addr, driver_addr, device_addr;
> > > +     union vring_mapping_token mapping_token =3D {0};
> > >       /* Assume split virtqueue, switch to packed if necessary */
> > >       struct vdpa_vq_state state =3D {0};
> > >       u32 align, max_num, min_num =3D 1;
> > > @@ -185,9 +186,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev,=
 unsigned int index,
> > >               dma_dev =3D ops->get_vq_dma_dev(vdpa, index);
> > >       else
> > >               dma_dev =3D vdpa_get_dma_dev(vdpa);
> > > -     vq =3D vring_create_virtqueue_dma(index, max_num, align, vdev,
> > > +     mapping_token.dma_dev =3D dma_dev;
> > > +     vq =3D vring_create_virtqueue_map(index, max_num, align, vdev,
> > >                                       true, may_reduce_num, ctx,
> > > -                                     notify, callback, name, dma_dev=
);
> > > +                                     notify, callback, name, &mappin=
g_token);
> > >       if (!vq) {
> > >               err =3D -ENOMEM;
> > >               goto error_new_virtqueue;
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index addbc209275a..37029df94aaf 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -40,6 +40,13 @@ struct virtqueue {
> > >       void *priv;
> > >  };
> > >
> > > +union vring_mapping_token {
> > > +     /* Device that performs DMA */
> > > +     struct device *dma_dev;
> > > +     /* Transport specific token used for doing map */
> > > +     void *opaque;
> >
> > Please just declare whatever structure you want it to be.
> >
>
> The type would be backend-specific in the future. HW vdpa will not
> have the same type here as VDUSE, and they contain backend-specific
> information.

Yes.

>
> If we want to be 100% type safe we could declare an empty or small
> struct and make the backend "inherit" (as "make the empty struct a
> member of the backend struct") at the backend so we can cast them with
> container_of or similar. Would that work?

I'm fine with this but I don't see an obvious difference.

Thanks

