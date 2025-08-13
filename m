Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887F1E9919
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071255; cv=none; b=SFeThr3RB7uiaoG5SZ4HHjw7Z4RiMDcMUW2CeFMqwdYLYqdz6/28mYTFoekDD3+I/XHAC/c4xuTCXzA0lWfweCp018QxtyCLBYgz5+5/C9MHa5k2gwyTc3ZE68o9HpOE7ZaoIePz8HEC7D3O98m0ujXyvIsSMcp5XqOgwX4D3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071255; c=relaxed/simple;
	bh=awFNGMlN2X64hkwWj8xl/xwBt2TFhkAw9jKo42o03FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dc2jFCqPgZqo0d6cc90o75NU1/JGANkhikzLr/VTuMelnP+RggPI1GIPA5Xyzv9pqMTHZrVX3ia5ReEd9sqFLCY5RgO+EIPVTX021jrvbs2FYJlK1vd93pmN2J4SJhiAXzWv9b5HDJe06Y8ElghW7T0IaUaURcOW7fT5vemR3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLFj+9rb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLFj+9rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755071250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X1QZTCr0YATDHf0cQKpOItz1U3gPuKBBWWk+1JO1pU=;
	b=dLFj+9rbKwsng2WFfQREqpdjnU2PGslWPflA+ftnUi793bXuqeltJX9R971/LvlYA09HSj
	bj4qCk9Eq2ZoONstqvTJ0eGWLvy9E05Iy0oa9BkmuJNRSbPFGLtlZv3Rt/y5+uQoG97ZjJ
	n62FKspvykxg8/hRk9ofG83SHEumuDc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-IEnyextlMC-jD725DDhCBQ-1; Wed, 13 Aug 2025 03:47:29 -0400
X-MC-Unique: IEnyextlMC-jD725DDhCBQ-1
X-Mimecast-MFC-AGG-ID: IEnyextlMC-jD725DDhCBQ_1755071248
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31ed9a17f22so10639895a91.0
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 00:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071248; x=1755676048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X1QZTCr0YATDHf0cQKpOItz1U3gPuKBBWWk+1JO1pU=;
        b=Pd6rqrpDzAx6eYocCjKImUboZWkhRWAQ62GJdf8hk5N+vQakfzqqW57I5/iUFmCJ76
         wiiusT17oa9efZrf6DvXlbQq4Jo1Ru38gW1OQDFQbuZR/g6988Oj+h16iHzayVCaTQju
         aHv6fwMtb40DUSJMMOB0OfCGQb55wHMOb9ewgZnaFHfUROenUiEsKkBig2CDXUyMItqW
         Rwk2vRXeIWD4lM94LEa47I/KLOUaveCuXRAGyRKu+dHc682UkPyASIIgpg1ZqjAhF/w6
         TgbCv3yqdKxtZTpuHGB4mrEe4j+dZzWQnGyFmxGIZkpyFKmCnv9szOta3p+HlZJwpHWh
         XESQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2qHVN6+JENriVcbyCGWAnzjr391wL2MkctW7jvkkgrETXo6F6arGpzpairTAx7KKGbIdVNCG4eRnccaxURg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbuBoZd+K2HbbXCMBizlPvwmkXhhtaZL5Y/yxLBocCxGkcM3oA
	eO5S53DZGtzMU46AvATTHU21hpqyciYgb3U7u0dSfZwg0+pBlqM+wHG7cfTPU9DP1vuLyKNRHTc
	WuhwJCje4wU/J9GGHWntVc9/qJQRgDRoT22qVqV1PcZ6M8MxMI0tX1aGKbyT6SPMBIkM/HoJm0S
	LStSY1Baq7zemsZ4m6VXaq+xs/RwbMt38BZnrJ6rhlMy0=
X-Gm-Gg: ASbGncsrw4fEYsJy5n6PhIJkXp/hktoWfX5jpCXlyZUZ2DgTs7OF7uA6V4M6/zoK5Wh
	tnBvpeJen9P+lQ7QDGpLwr2yG9xqtL/8xwQ5fYl+agnWGO8raBhifcf0Z/2CNGuB6qJp+oS5oGp
	hBsOAXPM+sHPT1fu1ODOiOFnLcJl6202ZvoQYHnOr1cB0PIb4W6NGZtwQ=
X-Received: by 2002:a17:90b:2808:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-321d0da48c2mr2553630a91.13.1755071247871;
        Wed, 13 Aug 2025 00:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYPbfrJ4gxqwP3tRK1Ty4iiu6KwUGUHk10YDp3Q+T9uZFbgHP9WTBCLlN3uFTf/zfgXFMxaJCEM6a3LvON80U=
X-Received: by 2002:a17:90b:2808:b0:311:a4d6:30f8 with SMTP id
 98e67ed59e1d1-321d0da48c2mr2553612a91.13.1755071247274; Wed, 13 Aug 2025
 00:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-5-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-5-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:46:51 +0200
X-Gm-Features: Ac12FXwzn-XJcr3MgloPhq-zNX8LGG-5_NBmsGd-cx-XhIx8Tum72PVlqG-wFj4
Message-ID: <CAJaqyWdrQTXDBC4tTLsMhVng5NdJp7_CbJf25BrMu+nW6U0isw@mail.gmail.com>
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Sl7tqSnSUt_qvHkGoowmDkBOdPcEybcztbx6bVphVQ_1755071248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Following patch will introduce the mapping operations for virtio
> device. In order to achieve this, besides the dma device, virtio core
> needs to support a transport or device specific mapping token as well.
> So this patch introduces a union container of a dma device and opaque
> mapping token. The idea is the allow the transport layer to pass
> device specific mapping token which will be used as a parameter for
> the virtio mapping operations. For the transport or device that is
> using DMA, dma device is still being used.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

But some nits:

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++-----------------
>  drivers/virtio/virtio_vdpa.c |   6 +-
>  include/linux/virtio.h       |   7 +++
>  include/linux/virtio_ring.h  |   7 ++-
>  4 files changed, 72 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 482a268af851..fb1d407d5f1b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -210,8 +210,7 @@ struct vring_virtqueue {
>         /* DMA, allocation, and size information */
>         bool we_own_ring;
>
> -       /* Device used for doing DMA */
> -       struct device *dma_dev;
> +       union vring_mapping_token mapping_token;
>
>  #ifdef DEBUG
>         /* They're supposed to lock for us. */
> @@ -307,10 +306,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>                                dma_addr_t *dma_handle, gfp_t flag,
> -                              struct device *dma_dev)
> +                              union vring_mapping_token *mapping_token)

I think the compiler will omit it but we're adding another pointer
indirection here.

>  {
>         if (vring_use_map_api(vdev)) {
> -               return dma_alloc_coherent(dma_dev, size,
> +               return dma_alloc_coherent(mapping_token->dma_dev, size,
>                                           dma_handle, flag);
>         } else {
>                 void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), flag)=
;
> @@ -341,22 +340,22 @@ static void *vring_alloc_queue(struct virtio_device=
 *vdev, size_t size,
>
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
>                              void *queue, dma_addr_t dma_handle,
> -                            struct device *dma_dev)
> +                            union vring_mapping_token *mapping_token)
>  {
>         if (vring_use_map_api(vdev))
> -               dma_free_coherent(dma_dev, size, queue, dma_handle);
> +               dma_free_coherent(mapping_token->dma_dev, size, queue, dm=
a_handle);
>         else
>                 free_pages_exact(queue, PAGE_ALIGN(size));
>  }
>
>  /*
> - * The DMA ops on various arches are rather gnarly right now, and
> - * making all of the arch DMA ops work on the vring device itself
> + * The map ops on various arches are rather gnarly right now, and
> + * making all of the arch map ops work on the vring device itself
>   * is a mess.
>   */
>  static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
>  {
> -       return vq->dma_dev;
> +       return vq->mapping_token.dma_dev;
>  }
>
>  /* Map one sg entry. */
> @@ -1056,12 +1055,13 @@ static int vring_alloc_state_extra_split(struct v=
ring_virtqueue_split *vring_spl
>  }
>
>  static void vring_free_split(struct vring_virtqueue_split *vring_split,
> -                            struct virtio_device *vdev, struct device *d=
ma_dev)
> +                            struct virtio_device *vdev,
> +                            union vring_mapping_token *mapping_token)
>  {
>         vring_free_queue(vdev, vring_split->queue_size_in_bytes,
>                          vring_split->vring.desc,
>                          vring_split->queue_dma_addr,
> -                        dma_dev);
> +                        mapping_token);
>
>         kfree(vring_split->desc_state);
>         kfree(vring_split->desc_extra);
> @@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring_vir=
tqueue_split *vring_split,
>                                    u32 num,
>                                    unsigned int vring_align,
>                                    bool may_reduce_num,
> -                                  struct device *dma_dev)
> +                                  union vring_mapping_token *mapping_tok=
en)
>  {
>         void *queue =3D NULL;
>         dma_addr_t dma_addr;
> @@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring_vir=
tqueue_split *vring_split,
>                 queue =3D vring_alloc_queue(vdev, vring_size(num, vring_a=
lign),
>                                           &dma_addr,
>                                           GFP_KERNEL | __GFP_NOWARN | __G=
FP_ZERO,
> -                                         dma_dev);
> +                                         mapping_token);
>                 if (queue)
>                         break;
>                 if (!may_reduce_num)
> @@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring_vir=
tqueue_split *vring_split,
>                 /* Try to get a single page. You are my only hope! */
>                 queue =3D vring_alloc_queue(vdev, vring_size(num, vring_a=
lign),
>                                           &dma_addr, GFP_KERNEL | __GFP_Z=
ERO,
> -                                         dma_dev);
> +                                         mapping_token);
>         }
>         if (!queue)
>                 return -ENOMEM;
> @@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>                                                bool (*notify)(struct virt=
queue *),
>                                                void (*callback)(struct vi=
rtqueue *),
>                                                const char *name,
> -                                              struct device *dma_dev)
> +                                              union vring_mapping_token =
*mapping_token)
>  {
>         struct vring_virtqueue *vq;
>         int err;
> @@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>  #else
>         vq->broken =3D false;
>  #endif
> -       vq->dma_dev =3D dma_dev;
> +       vq->mapping_token =3D *mapping_token;
>         vq->use_map_api =3D vring_use_map_api(vdev);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> @@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtqueue_s=
plit(
>         bool (*notify)(struct virtqueue *),
>         void (*callback)(struct virtqueue *),
>         const char *name,
> -       struct device *dma_dev)
> +       union vring_mapping_token *mapping_token)
>  {
>         struct vring_virtqueue_split vring_split =3D {};
>         struct virtqueue *vq;
>         int err;
>
>         err =3D vring_alloc_queue_split(&vring_split, vdev, num, vring_al=
ign,
> -                                     may_reduce_num, dma_dev);
> +                                     may_reduce_num, mapping_token);
>         if (err)
>                 return NULL;
>
>         vq =3D __vring_new_virtqueue_split(index, &vring_split, vdev, wea=
k_barriers,
> -                                  context, notify, callback, name, dma_d=
ev);
> +                                  context, notify, callback, name, mappi=
ng_token);
>         if (!vq) {
> -               vring_free_split(&vring_split, vdev, dma_dev);
> +               vring_free_split(&vring_split, vdev, mapping_token);
>                 return NULL;
>         }
>
> @@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqueue =
*_vq, u32 num)
>         err =3D vring_alloc_queue_split(&vring_split, vdev, num,
>                                       vq->split.vring_align,
>                                       vq->split.may_reduce_num,
> -                                     vring_dma_dev(vq));
> +                                     &vq->mapping_token);
>         if (err)
>                 goto err;
>
> @@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqueue =
*_vq, u32 num)
>         return 0;
>
>  err_state_extra:
> -       vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
> +       vring_free_split(&vring_split, vdev, &vq->mapping_token);
>  err:
>         virtqueue_reinit_split(vq);
>         return -ENOMEM;
> @@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_desc_=
extra(unsigned int num)
>
>  static void vring_free_packed(struct vring_virtqueue_packed *vring_packe=
d,
>                               struct virtio_device *vdev,
> -                             struct device *dma_dev)
> +                             union vring_mapping_token *mapping_token)
>  {
>         if (vring_packed->vring.desc)
>                 vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
>                                  vring_packed->vring.desc,
>                                  vring_packed->ring_dma_addr,
> -                                dma_dev);
> +                                mapping_token);
>
>         if (vring_packed->vring.driver)
>                 vring_free_queue(vdev, vring_packed->event_size_in_bytes,
>                                  vring_packed->vring.driver,
>                                  vring_packed->driver_event_dma_addr,
> -                                dma_dev);
> +                                mapping_token);
>
>         if (vring_packed->vring.device)
>                 vring_free_queue(vdev, vring_packed->event_size_in_bytes,
>                                  vring_packed->vring.device,
>                                  vring_packed->device_event_dma_addr,
> -                                dma_dev);
> +                                mapping_token);
>
>         kfree(vring_packed->desc_state);
>         kfree(vring_packed->desc_extra);
> @@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virtqueu=
e_packed *vring_packed,
>
>  static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring=
_packed,
>                                     struct virtio_device *vdev,
> -                                   u32 num, struct device *dma_dev)
> +                                   u32 num, union vring_mapping_token *m=
apping_token)
>  {
>         struct vring_packed_desc *ring;
>         struct vring_packed_desc_event *driver, *device;
> @@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vring_vi=
rtqueue_packed *vring_packed,
>         ring =3D vring_alloc_queue(vdev, ring_size_in_bytes,
>                                  &ring_dma_addr,
>                                  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
> -                                dma_dev);
> +                                mapping_token);
>         if (!ring)
>                 goto err;
>
> @@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vring_vi=
rtqueue_packed *vring_packed,
>         driver =3D vring_alloc_queue(vdev, event_size_in_bytes,
>                                    &driver_event_dma_addr,
>                                    GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO=
,
> -                                  dma_dev);
> +                                  mapping_token);
>         if (!driver)
>                 goto err;
>
> @@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vring_vi=
rtqueue_packed *vring_packed,
>         device =3D vring_alloc_queue(vdev, event_size_in_bytes,
>                                    &device_event_dma_addr,
>                                    GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO=
,
> -                                  dma_dev);
> +                                  mapping_token);
>         if (!device)
>                 goto err;
>
> @@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vring_vi=
rtqueue_packed *vring_packed,
>         return 0;
>
>  err:
> -       vring_free_packed(vring_packed, vdev, dma_dev);
> +       vring_free_packed(vring_packed, vdev, mapping_token);
>         return -ENOMEM;
>  }
>
> @@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_pack=
ed(unsigned int index,
>                                                bool (*notify)(struct virt=
queue *),
>                                                void (*callback)(struct vi=
rtqueue *),
>                                                const char *name,
> -                                              struct device *dma_dev)
> +                                              union vring_mapping_token =
*mapping_token)
>  {
>         struct vring_virtqueue *vq;
>         int err;
> @@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_pack=
ed(unsigned int index,
>         vq->broken =3D false;
>  #endif
>         vq->packed_ring =3D true;
> -       vq->dma_dev =3D dma_dev;
> +       vq->mapping_token =3D *mapping_token;
>         vq->use_map_api =3D vring_use_map_api(vdev);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
> @@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtqueue_p=
acked(
>         bool (*notify)(struct virtqueue *),
>         void (*callback)(struct virtqueue *),
>         const char *name,
> -       struct device *dma_dev)
> +       union vring_mapping_token *mapping_token)
>  {
>         struct vring_virtqueue_packed vring_packed =3D {};
>         struct virtqueue *vq;
>
> -       if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
> +       if (vring_alloc_queue_packed(&vring_packed, vdev, num, mapping_to=
ken))
>                 return NULL;
>
>         vq =3D __vring_new_virtqueue_packed(index, &vring_packed, vdev, w=
eak_barriers,
> -                                       context, notify, callback, name, =
dma_dev);
> +                                       context, notify, callback, name, =
mapping_token);
>         if (!vq) {
> -               vring_free_packed(&vring_packed, vdev, dma_dev);
> +               vring_free_packed(&vring_packed, vdev, mapping_token);
>                 return NULL;
>         }
>
> @@ -2185,7 +2185,8 @@ static int virtqueue_resize_packed(struct virtqueue=
 *_vq, u32 num)
>         struct virtio_device *vdev =3D _vq->vdev;
>         int err;
>
> -       if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_=
dev(vq)))
> +       if (vring_alloc_queue_packed(&vring_packed, vdev,
> +                                    num, &vq->mapping_token))
>                 goto err_ring;
>
>         err =3D vring_alloc_state_extra_packed(&vring_packed);
> @@ -2202,7 +2203,7 @@ static int virtqueue_resize_packed(struct virtqueue=
 *_vq, u32 num)
>         return 0;
>
>  err_state_extra:
> -       vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
> +       vring_free_packed(&vring_packed, vdev, &vq->mapping_token);
>  err_ring:
>         virtqueue_reinit_packed(vq);
>         return -ENOMEM;
> @@ -2423,6 +2424,7 @@ int virtqueue_add_inbuf_premapped(struct virtqueue =
*vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
>
> +
>  /**
>   * virtqueue_dma_dev - get the dma dev
>   * @_vq: the struct virtqueue we're talking about.
> @@ -2434,7 +2436,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *=
_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (vq->use_map_api)
> -               return vring_dma_dev(vq);
> +               return vq->mapping_token.dma_dev;
>         else
>                 return NULL;
>  }
> @@ -2719,19 +2721,20 @@ struct virtqueue *vring_create_virtqueue(
>         void (*callback)(struct virtqueue *),
>         const char *name)
>  {
> +       union vring_mapping_token mapping_token =3D {.dma_dev =3D vdev->d=
ev.parent};
>
>         if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>                 return vring_create_virtqueue_packed(index, num, vring_al=
ign,
>                                 vdev, weak_barriers, may_reduce_num,
> -                               context, notify, callback, name, vdev->de=
v.parent);
> +                               context, notify, callback, name, &mapping=
_token);
>
>         return vring_create_virtqueue_split(index, num, vring_align,
>                         vdev, weak_barriers, may_reduce_num,
> -                       context, notify, callback, name, vdev->dev.parent=
);
> +                       context, notify, callback, name, &mapping_token);
>  }
>  EXPORT_SYMBOL_GPL(vring_create_virtqueue);
>
> -struct virtqueue *vring_create_virtqueue_dma(
> +struct virtqueue *vring_create_virtqueue_map(
>         unsigned int index,
>         unsigned int num,
>         unsigned int vring_align,
> @@ -2742,19 +2745,19 @@ struct virtqueue *vring_create_virtqueue_dma(
>         bool (*notify)(struct virtqueue *),
>         void (*callback)(struct virtqueue *),
>         const char *name,
> -       struct device *dma_dev)
> +       union vring_mapping_token *mapping_token)
>  {
>
>         if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>                 return vring_create_virtqueue_packed(index, num, vring_al=
ign,
>                                 vdev, weak_barriers, may_reduce_num,
> -                               context, notify, callback, name, dma_dev)=
;
> +                               context, notify, callback, name, mapping_=
token);
>
>         return vring_create_virtqueue_split(index, num, vring_align,
>                         vdev, weak_barriers, may_reduce_num,
> -                       context, notify, callback, name, dma_dev);
> +                       context, notify, callback, name, mapping_token);
>  }
> -EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
> +EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
>
>  /**
>   * virtqueue_resize - resize the vring of vq
> @@ -2865,6 +2868,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int =
index,
>                                       const char *name)
>  {
>         struct vring_virtqueue_split vring_split =3D {};
> +       union vring_mapping_token mapping_token =3D {.dma_dev =3D vdev->d=
ev.parent};
>
>         if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>                 struct vring_virtqueue_packed vring_packed =3D {};
> @@ -2874,13 +2878,13 @@ struct virtqueue *vring_new_virtqueue(unsigned in=
t index,
>                 return __vring_new_virtqueue_packed(index, &vring_packed,
>                                                     vdev, weak_barriers,
>                                                     context, notify, call=
back,
> -                                                   name, vdev->dev.paren=
t);
> +                                                   name, &mapping_token)=
;
>         }
>
>         vring_init(&vring_split.vring, num, pages, vring_align);
>         return __vring_new_virtqueue_split(index, &vring_split, vdev, wea=
k_barriers,
>                                      context, notify, callback, name,
> -                                    vdev->dev.parent);
> +                                    &mapping_token);
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>
> @@ -2894,19 +2898,19 @@ static void vring_free(struct virtqueue *_vq)
>                                          vq->packed.ring_size_in_bytes,
>                                          vq->packed.vring.desc,
>                                          vq->packed.ring_dma_addr,
> -                                        vring_dma_dev(vq));
> +                                        &vq->mapping_token);
>
>                         vring_free_queue(vq->vq.vdev,
>                                          vq->packed.event_size_in_bytes,
>                                          vq->packed.vring.driver,
>                                          vq->packed.driver_event_dma_addr=
,
> -                                        vring_dma_dev(vq));
> +                                        &vq->mapping_token);
>
>                         vring_free_queue(vq->vq.vdev,
>                                          vq->packed.event_size_in_bytes,
>                                          vq->packed.vring.device,
>                                          vq->packed.device_event_dma_addr=
,
> -                                        vring_dma_dev(vq));
> +                                        &vq->mapping_token);
>
>                         kfree(vq->packed.desc_state);
>                         kfree(vq->packed.desc_extra);
> @@ -2915,7 +2919,7 @@ static void vring_free(struct virtqueue *_vq)
>                                          vq->split.queue_size_in_bytes,
>                                          vq->split.vring.desc,
>                                          vq->split.queue_dma_addr,
> -                                        vring_dma_dev(vq));
> +                                        &vq->mapping_token);
>                 }
>         }
>         if (!vq->packed_ring) {
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e25610e3393a..acea98ab08ee 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -139,6 +139,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>         struct vdpa_callback cb;
>         struct virtqueue *vq;
>         u64 desc_addr, driver_addr, device_addr;
> +       union vring_mapping_token mapping_token =3D {0};
>         /* Assume split virtqueue, switch to packed if necessary */
>         struct vdpa_vq_state state =3D {0};
>         u32 align, max_num, min_num =3D 1;
> @@ -185,9 +186,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, uns=
igned int index,
>                 dma_dev =3D ops->get_vq_dma_dev(vdpa, index);
>         else
>                 dma_dev =3D vdpa_get_dma_dev(vdpa);
> -       vq =3D vring_create_virtqueue_dma(index, max_num, align, vdev,
> +       mapping_token.dma_dev =3D dma_dev;
> +       vq =3D vring_create_virtqueue_map(index, max_num, align, vdev,
>                                         true, may_reduce_num, ctx,
> -                                       notify, callback, name, dma_dev);
> +                                       notify, callback, name, &mapping_=
token);
>         if (!vq) {
>                 err =3D -ENOMEM;
>                 goto error_new_virtqueue;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index addbc209275a..37029df94aaf 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -40,6 +40,13 @@ struct virtqueue {
>         void *priv;
>  };
>

I would add some doc here like "vq uses dma_dev if vq->use_map_api,
opaque is used otherwise". Maybe we can move use_map_api here
actually, like:

struct vring_mapping_token {
  bool use_map_api;
  union {
    struct device *dma_dev;
    void *opaque;
  };
}

What do you think?

> +union vring_mapping_token {
> +       /* Device that performs DMA */
> +       struct device *dma_dev;
> +       /* Transport specific token used for doing map */
> +       void *opaque;
> +};
> +
>  int virtqueue_add_outbuf(struct virtqueue *vq,
>                          struct scatterlist sg[], unsigned int num,
>                          void *data,
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 9b33df741b63..fd997178da2a 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_RING_H
>
>  #include <asm/barrier.h>
> +#include <linux/virtio.h>
>  #include <linux/irqreturn.h>
>  #include <uapi/linux/virtio_ring.h>
>
> @@ -79,9 +80,9 @@ struct virtqueue *vring_create_virtqueue(unsigned int i=
ndex,
>
>  /*
>   * Creates a virtqueue and allocates the descriptor ring with per
> - * virtqueue DMA device.
> + * virtqueue mapping operations.
>   */
> -struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
> +struct virtqueue *vring_create_virtqueue_map(unsigned int index,
>                                              unsigned int num,
>                                              unsigned int vring_align,
>                                              struct virtio_device *vdev,
> @@ -91,7 +92,7 @@ struct virtqueue *vring_create_virtqueue_dma(unsigned i=
nt index,
>                                              bool (*notify)(struct virtqu=
eue *vq),
>                                              void (*callback)(struct virt=
queue *vq),
>                                              const char *name,
> -                                            struct device *dma_dev);
> +                                            union vring_mapping_token *m=
apping_token);
>
>  /*
>   * Creates a virtqueue with a standard layout but a caller-allocated
> --
> 2.31.1
>

