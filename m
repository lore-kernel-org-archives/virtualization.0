Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C72E36E6
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673324; cv=none; b=TsQKNLvnoKJxfVflxGYmjDYu8oUM+7InxoekgEIOP9hZG9KHNVlS6bRQZLMSU45yR0K+RAnIpD04DdoWzoXgcOlBjejfOnUQ7TtjLbKovuquSRJycP8wYm09U07rN/+UvdET7bFRK+00TMbba+1i577+GtCB+3PUBq4IxKUQx/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673324; c=relaxed/simple;
	bh=gCmBgqSdPOGx7a1LRs1ysrjxAzAmXzQPjsAzH45QxcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5d+FfG20OaGiuSQvzK5gpEEXtsQpWCmstHcWrybAmiUWDcsI2Su50ccAOrwokhwWQA8NWdTzLQcmFqpLY8C3LB25YJnczdABrQ1Y2/kwqd5oQzD2MgN1QYaxnZzlP4MxCE3cX9vmpi9DfCE0m87DVQba7C3FjOUUp+kChiKy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewMzzQrI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewMzzQrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753673320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8f0NjS475dSijJ2fA+eJGPGEKtjO2u3PdgQWKnQqLvE=;
	b=ewMzzQrIhHZSDHz8FZb03F81dtkPNOz0HzfG592FXqQdxJi6Hk02ZyoBB4gd9zclc8zZLo
	TbL1erbCqrLjI4sPEUinyW1ZcKxVXDn7IkSyorrIyZD5hKOquwjZdoayuxhKkmnC0ecrdq
	21Qz26rgCOGUXO3bGylAgd02/YPgAc4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-bDZrbay6M-ij8B3VfOUduw-1; Sun, 27 Jul 2025 23:28:39 -0400
X-MC-Unique: bDZrbay6M-ij8B3VfOUduw-1
X-Mimecast-MFC-AGG-ID: bDZrbay6M-ij8B3VfOUduw_1753673318
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311d670ad35so3631752a91.3
        for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 20:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753673318; x=1754278118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8f0NjS475dSijJ2fA+eJGPGEKtjO2u3PdgQWKnQqLvE=;
        b=h42c6OacjOq8qD6I59RQ8iR7KTXHYhv7bT9aIU6cdHKhjJ0ywXlOtT2fyCfdNDKWEs
         RF3BWMKANmztxI0V5ZnOhbMud8PjccNvwEKB6uBsIkQGicYQdAPu/4r5yGxMuTjPH9oe
         2nlJ7/ZrUtjNGDW+pt9lNzEFtwZ9pJrXGsInyQ7CertwI9O0nwAaUDlkO0C3vd9U4Xw+
         U8t5C+VzRH/kmT3BQN17Oq1Qm0Rd4FdQBFCDYmK4cIzeWo1pkCtbM3kuqsiCBD3Nxk21
         UXCae6itbPUOh2cLpan13inkoXF3fflfbLqkvHAZH2fAJjPRbXV0r4LS5R+fjdN4V4fy
         pCcg==
X-Gm-Message-State: AOJu0YwnoNOEPJiw6wtbQl0bkyFnd5x3Nq1bvLw7ESwErenWAcqJ7fbV
	8lkptooGe+05yQIKgBsfH4629DSRfxM7r9jDC5hWpPlbLF44ijHwJD386dfu1TziPV28UBM8bLx
	w25YqQT5qIxKGui7/U+9wd6EOYWiZv8c9mnP1Z+4EnnAf5EjE6Qir/ihRNn+HH5IdhUgUXfDEzw
	cUfR8UWbrFgh/B352HbFEp8w6CephcrGX3gPSUiZ833uw=
X-Gm-Gg: ASbGnctEDMSTkAQOfRp7fbT8h4R4Q1knZ2JDtVZqdgJIDCHADK4LM/H5fhxzIaaIYJc
	sMn0UMjQI5YDIIAAoESg2cXAMrGeXSY8VnpGzB9Q4UelLk1+lYVOfiFNH2fSfJWPyWthu7E0ob5
	IGbYquHWJqrBRCJZ5LcXE=
X-Received: by 2002:a17:90a:e7c4:b0:312:639:a058 with SMTP id 98e67ed59e1d1-31e77a143cdmr12724129a91.27.1753673318258;
        Sun, 27 Jul 2025 20:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMcdq+U2T/HnEwydft2v9gyyWoDkvoNMkFuSZYJU28tEnJLCfvKRh+pf1nc22lxIj9ODVE0JLlyUhJD3DKBCk=
X-Received: by 2002:a17:90a:e7c4:b0:312:639:a058 with SMTP id
 98e67ed59e1d1-31e77a143cdmr12724101a91.27.1753673317685; Sun, 27 Jul 2025
 20:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-7-jasowang@redhat.com>
 <1753434835.586962-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1753434835.586962-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:28:26 +0800
X-Gm-Features: Ac12FXxl0u0YgTagADgKG8zyzxFm0sOHZjpEE0lg-XNxLYD-6Jl-0wyVECT4OKY
Message-ID: <CACGkMEvOV9UHPbUx=iq_npcXcHYC2JVa=pZeDWbWmUF8TOgWkw@mail.gmail.com>
Subject: Re: [PATCH V4 6/9] virtio: introduce map ops in virtio core
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>, mst@redhat.com, eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -2kQAhtEnCw6zX1hjlhQRDJanMfSh1tWbW2AAcqKt3U_1753673318
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 18 Jul 2025 17:16:13 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > This patch introduces map operations for virtio device. Virtio use to
> > use DMA API which is not necessarily the case since some devices
> > doesn't do DMA. Instead of using tricks and abusing DMA API, let's
> > simply abstract the current mapping logic into a virtio specific
> > mapping operations. For the device or transport that doesn't do DMA,
> > they can implement their own mapping logic without the need to trick
> > DMA core. In this case the map_token is opaque to the virtio core that
> > will be passed back to the transport or device specific map
> > operations. For other devices, DMA API will still be used, so map
> > token will still be the dma device to minimize the changeset and
> > performance impact.
> >
> > The mapping operations are abstract as a independent structure instead
> > of reusing virtio_config_ops. This allows the transport can simply
> > reuse the structure for lower layers.
> >
> > A set of new mapping helpers were introduced for the device that want
> > to do mapping by themselves.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c  | 174 +++++++++++++++++++++++++++++-----
> >  include/linux/virtio.h        |  22 +++++
> >  include/linux/virtio_config.h |  68 +++++++++++++
> >  3 files changed, 238 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 26ce8a3d6927..3f86e74dd79f 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -298,8 +298,14 @@ size_t virtio_max_dma_size(const struct virtio_dev=
ice *vdev)
> >  {
> >       size_t max_segment_size =3D SIZE_MAX;
> >
> > -     if (vring_use_map_api(vdev))
> > -             max_segment_size =3D dma_max_mapping_size(vdev->dev.paren=
t);
> > +     if (vring_use_map_api(vdev)) {
> > +             if (vdev->map)
> > +                     max_segment_size =3D
> > +                             vdev->map->max_mapping_size(vdev->dev.par=
ent);
> > +             else
> > +                     max_segment_size =3D
> > +                             dma_max_mapping_size(vdev->dev.parent);
> > +     }
> >
> >       return max_segment_size;
> >  }
> > @@ -310,8 +316,8 @@ static void *vring_alloc_queue(struct virtio_device=
 *vdev, size_t size,
> >                              void *map_token)
> >  {
> >       if (vring_use_map_api(vdev)) {
> > -             return dma_alloc_coherent(map_token, size,
> > -                                       map_handle, flag);
> > +             return virtqueue_map_alloc_coherent(vdev, map_token, size=
,
> > +                                                 map_handle, flag);
> >       } else {
> >               void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), flag)=
;
> >
> > @@ -344,7 +350,8 @@ static void vring_free_queue(struct virtio_device *=
vdev, size_t size,
> >                            void *map_token)
> >  {
> >       if (vring_use_map_api(vdev))
> > -             dma_free_coherent(map_token, size, queue, map_handle);
> > +             virtqueue_map_free_coherent(vdev, map_token, size,
> > +                                         queue, map_handle);
> >       else
> >               free_pages_exact(queue, PAGE_ALIGN(size));
> >  }
> > @@ -388,9 +395,9 @@ static int vring_map_one_sg(const struct vring_virt=
queue *vq, struct scatterlist
> >        * the way it expects (we don't guarantee that the scatterlist
> >        * will exist for the lifetime of the mapping).
> >        */
> > -     *addr =3D dma_map_page(vring_map_token(vq),
> > -                         sg_page(sg), sg->offset, sg->length,
> > -                         direction);
> > +     *addr =3D virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
> > +                                      sg->offset, sg->length,
> > +                                      direction, 0);
> >
> >       if (dma_mapping_error(vring_map_token(vq), *addr))
> >               return -ENOMEM;
> > @@ -454,11 +461,12 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >       } else if (!vring_need_unmap_buffer(vq, extra))
> >               goto out;
> >
> > -     dma_unmap_page(vring_map_token(vq),
> > -                    extra->addr,
> > -                    extra->len,
> > -                    (flags & VRING_DESC_F_WRITE) ?
> > -                    DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +     virtqueue_unmap_page_attrs(&vq->vq,
> > +                                extra->addr,
> > +                                extra->len,
> > +                                (flags & VRING_DESC_F_WRITE) ?
> > +                                DMA_FROM_DEVICE : DMA_TO_DEVICE,
> > +                                0);
> >
> >  out:
> >       return extra->next;
> > @@ -1271,10 +1279,11 @@ static void vring_unmap_extra_packed(const stru=
ct vring_virtqueue *vq,
> >       } else if (!vring_need_unmap_buffer(vq, extra))
> >               return;
> >
> > -     dma_unmap_page(vring_map_token(vq),
> > -                    extra->addr, extra->len,
> > -                    (flags & VRING_DESC_F_WRITE) ?
> > -                    DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +     virtqueue_unmap_page_attrs(&vq->vq,
> > +                                extra->addr, extra->len,
> > +                                (flags & VRING_DESC_F_WRITE) ?
> > +                                DMA_FROM_DEVICE : DMA_TO_DEVICE,
> > +                                0);
> >  }
> >
> >  static struct vring_packed_desc *alloc_indirect_packed(unsigned int to=
tal_sg,
> > @@ -3121,6 +3130,105 @@ const struct vring *virtqueue_get_vring(const s=
truct virtqueue *vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >
> > +/**
> > + * virtqueue_map_alloc_coherent - alloc coherent mapping
> > + * @vdev: the virtio device we are talking to
> > + * @token: device specific mapping token
> > + * @size: the size of the buffer
> > + * @map_handle: the pointer to the mapped adress
> > + * @gfp: allocation flag (GFP_XXX)
> > + *
> > + * return virtual address or NULL on error
> > + */
> > +void *virtqueue_map_alloc_coherent(struct virtio_device *vdev,
> > +                                void *map_token, size_t size,
> > +                                dma_addr_t *map_handle, gfp_t gfp)
> > +{
> > +     if (vdev->map)
> > +             return vdev->map->alloc(map_token, size, map_handle, gfp)=
;
> > +     else
> > +             return dma_alloc_coherent(map_token, size,
> > +                                       map_handle, gfp);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_map_alloc_coherent);
> > +
> > +/**
> > + * virtqueue_map_free_coherent - free coherent mapping
> > + * @vdev: the virtio device we are talking to
> > + * @token: device specific mapping token
> > + * @size: the size of the buffer
> > + * @map_handle: the mapped address that needs to be freed
> > + *
> > + */
> > +void virtqueue_map_free_coherent(struct virtio_device *vdev,
> > +                              void *map_token, size_t size, void *vadd=
r,
> > +                              dma_addr_t map_handle)
> > +{
> > +     if (vdev->map)
> > +             vdev->map->free(map_token, size, vaddr, map_handle, 0);
> > +     else
> > +             dma_free_coherent(map_token, size, vaddr, map_handle);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
> > +
> > +/**
> > + * virtqueue_map_page_attrs - map a page to the device
> > + * @_vq: the virtqueue we are talking to
> > + * @page: the page that will be mapped by the device
> > + * @offset: the offset in the page for a buffer
> > + * @size: the buffer size
> > + * @dir: mapping direction
> > + * @attrs: mapping attributes
> > + *
> > + * Returns mapped address. Caller should check that by virtqueue_mappi=
ng_error().
> > + */
> > +dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
> > +                                 struct page *page,
> > +                                 unsigned long offset,
> > +                                 size_t size,
> > +                                 enum dma_data_direction dir,
> > +                                 unsigned long attrs)
> > +{
> > +     const struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +     struct virtio_device *vdev =3D _vq->vdev;
> > +     void *map_token =3D vring_map_token(vq);
> > +
> > +     if (vdev->map)
> > +             return vdev->map->map_page(map_token,
> > +                                        page, offset, size,
> > +                                        dir, attrs);
> > +
> > +     return dma_map_page_attrs(map_token,
> > +                               page, offset, size,
> > +                               dir, attrs);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_map_page_attrs);
> > +
> > +/**
> > + * virtqueue_unmap_page_attrs - map a page to the device
> > + * @_vq: the virtqueue we are talking to
> > + * @map_handle: the mapped address
> > + * @size: the buffer size
> > + * @dir: mapping direction
> > + * @attrs: unmapping attributes
> > + */
> > +void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
> > +                             dma_addr_t map_handle,
> > +                             size_t size, enum dma_data_direction dir,
> > +                             unsigned long attrs)
> > +{
> > +     const struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +     struct virtio_device *vdev =3D _vq->vdev;
> > +     void *map_token =3D vring_map_token(vq);
> > +
> > +     if (vdev->map)
> > +             vdev->map->unmap_page(map_token, map_handle,
> > +                                   size, dir, attrs);
> > +     else
> > +             dma_unmap_page_attrs(map_token, map_handle, size, dir, at=
trs);
>
>
> How about setting dma_unmap_page_attrs as the default value of vdev->map-=
>unmap_page?
>
> Then we can call vdev->map->unmap_page directly.
>
> Thanks.
>

This looks more clean but the problem is that the indirect call might
be slow when mitigation is enabled. So I tend to keep the hard code
condition here.

Thanks

