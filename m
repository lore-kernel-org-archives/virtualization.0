Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4311EDA1A
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069448; cv=none; b=Rka9DcKEcRuqgqbk82LFEaXDmf4tIcuGjlJjbydDaYb1/p0N4sR3pL1B9fqJp2uZsZI+iax5GL/W4Srv8+Y6GRBFB7NZ/qEjbaj2Y1+rSs23EHiEKR0SIg2JzasJnbFJcUR3ObzyhKUhJH4cB52R56cLchtd7v4mtlZKLJBLzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069448; c=relaxed/simple;
	bh=ICl1LAayak7SZdOambDFzQenbkPNFpQ3zDgBBqgwNSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAjIX+rS+Yo/LFXasRCf8XhrduqOskgGC9av7l9+zSyohU7cPRVWIhD566uWmNENZHWcJ+aNuPRmv9FdFFi2iFw9kieYd9jG+4FnYqmxmw8iwcgd8fFCoJyVwM9PBGWszVCVFKuEPFEnSsPSU8t59AiIn78Y1PS0F2gbY2yBNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGdRUcrh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGdRUcrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755069444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36hTIgs+MoxCO35OvOvDl0QZ/qbxE9JXSegRyozzGFA=;
	b=MGdRUcrh9dN3XV4hIXU9n1ltjBKobECvTv+x2wbiXVJughFSFEg1buIV8x0+8wW6Hag2JN
	wSaAbrj4DOKJsB8SX24XuggasCA/c5ZGWS3epNL1AuAN7lDNqPpN52y1jdR+6MKvMJ0JWB
	rrd0X+oVdjufa3kmjfeNAPXkgxbDkXw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-SwZKeRxpP7qv7mKC8UJ2XA-1; Wed, 13 Aug 2025 03:17:22 -0400
X-MC-Unique: SwZKeRxpP7qv7mKC8UJ2XA-1
X-Mimecast-MFC-AGG-ID: SwZKeRxpP7qv7mKC8UJ2XA_1755069441
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-242ffe6d0afso15897675ad.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 00:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069441; x=1755674241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36hTIgs+MoxCO35OvOvDl0QZ/qbxE9JXSegRyozzGFA=;
        b=iooI8X06fzYCR7pHsBSJFbHuRif7oWSOyGJDvkkj01Vn+LeW4Y6c0koJ/wr4t9AucF
         HPP5471fxsDJ8hOvXzCYwVlIEWwr7tlGMuFXqxKniKnXsvhm0TzSU7aC1sdN9sEvJ6S/
         +AIdaZSdFW/6S013EyT2MITiNiB/YjtlJrUbv98luUFS+NKSXshCVWNjqH36ldXSplbe
         i6h/x3dQlx4D6qxGc2KfBwMyXm1x6TXfrvWFfX8tkCrdBPUoqlGmg0hifJD37wJL09id
         NnLqBv9zvEXs0fwLeCVA0zYSCj1MYE+USLUSJnlI1lPMAwtdwrgVe3jTZ3MDqIDzHxg1
         jkWw==
X-Forwarded-Encrypted: i=1; AJvYcCVC4yMJ4fNljNmKQMXanvWnvXxjLo0yfbiwp/HJN7k0WYvMnLJ1aNOnJ/ffNindx0tWUGRa8kixLq7Fikx6fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHVaon81mNN21RJyLDHR7jDSrjLWVLR4BZ5WQmtZKje7syaHa0
	1iVPuGdqcAlDmVAUwEeuPx3/yptYCc2fGhI57XdWRefgQWRN/7HHaMNN0vZ6tdY0pd6BdOHbzOJ
	CYfvAwOIucD8mt9GdEJ+E9dYLVoR12x33uqgNhVHTa/kGuLbrmog7bKJD+hFRj1XirC9N+il1tJ
	IjCD0sP+Hm1kGe7NjI9x3hXVZgu5Kc5FxoJFAajXfRUJg=
X-Gm-Gg: ASbGncu/PoE/RmXdyXUEEMtvZ1OrcGuII85Bo/3N+r8JIXgmOjOoshoEbjfWw0T/itr
	fA/RYJrr/fP0BXW5Qy3zF9CdaFKktlps/K9fk6Jn9NnJGpAFLp3piE4p4dOU/aFcUxuMqaybuGt
	noOEFbDc/IhTF7pXXRYD4n43eGrcxUI4dgW/mDlrUu0HrnKYzDbXeKc0s=
X-Received: by 2002:a17:903:288:b0:242:b42b:1335 with SMTP id d9443c01a7336-2430d12640amr34711845ad.22.1755069441152;
        Wed, 13 Aug 2025 00:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqEZTv/tCK4PnpAaA4ZxI1IviiGeV+r/bdxi10fbmZlZ2gPs9UpWYBMgkc6bdhpuJfZFgQ41uUFK3JjbeHG2c=
X-Received: by 2002:a17:903:288:b0:242:b42b:1335 with SMTP id
 d9443c01a7336-2430d12640amr34711495ad.22.1755069440600; Wed, 13 Aug 2025
 00:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-4-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-4-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:16:44 +0200
X-Gm-Features: Ac12FXzw0NcMrcBDRXMAw4FongxqyYRDPCzUMZi8UXfAtSoZdbvI1eyHuhteTkU
Message-ID: <CAJaqyWd9nfVaukQponSdHi2CDUMLZdej9+HvUZCEs3R4SDWhCA@mail.gmail.com>
Subject: Re: [PATCH V5 3/9] virtio: rename dma helpers
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uo9c8VKsn3l7bnfr65m3bbUX97hWGDZYaoY9dB1HH30_1755069441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Following patch will introduce virtio mapping function to avoid
> abusing DMA API for device that doesn't do DMA. To ease the
> introduction, this patch rename "dma" to "map" for the current dma
> mapping helpers.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c     |  28 ++++-----
>  drivers/virtio/virtio_ring.c | 114 +++++++++++++++++------------------
>  include/linux/virtio.h       |  12 ++--
>  3 files changed, 77 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..929db41a579b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -933,7 +933,7 @@ static void virtnet_rq_unmap(struct receive_queue *rq=
, void *buf, u32 len)
>         if (dma->need_sync && len) {
>                 offset =3D buf - (head + sizeof(*dma));
>
> -               virtqueue_dma_sync_single_range_for_cpu(rq->vq, dma->addr=
,
> +               virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr=
,
>                                                         offset, len,
>                                                         DMA_FROM_DEVICE);
>         }
> @@ -941,8 +941,8 @@ static void virtnet_rq_unmap(struct receive_queue *rq=
, void *buf, u32 len)
>         if (dma->ref)
>                 return;
>
> -       virtqueue_dma_unmap_single_attrs(rq->vq, dma->addr, dma->len,
> -                                        DMA_FROM_DEVICE, DMA_ATTR_SKIP_C=
PU_SYNC);
> +       virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
> +                                    DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_S=
YNC);
>         put_page(page);
>  }
>
> @@ -1009,13 +1009,13 @@ static void *virtnet_rq_alloc(struct receive_queu=
e *rq, u32 size, gfp_t gfp)
>
>                 dma->len =3D alloc_frag->size - sizeof(*dma);
>
> -               addr =3D virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> -                                                     dma->len, DMA_FROM_=
DEVICE, 0);
> -               if (virtqueue_dma_mapping_error(rq->vq, addr))
> +               addr =3D virtqueue_map_single_attrs(rq->vq, dma + 1,
> +                                                 dma->len, DMA_FROM_DEVI=
CE, 0);
> +               if (virtqueue_map_mapping_error(rq->vq, addr))
>                         return NULL;
>
>                 dma->addr =3D addr;
> -               dma->need_sync =3D virtqueue_dma_need_sync(rq->vq, addr);
> +               dma->need_sync =3D virtqueue_map_need_sync(rq->vq, addr);
>
>                 /* Add a reference to dma to prevent the entire dma from
>                  * being released during error handling. This reference
> @@ -5921,9 +5921,9 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>         if (!rq->xsk_buffs)
>                 return -ENOMEM;
>
> -       hdr_dma =3D virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->=
hdr_len,
> -                                                DMA_TO_DEVICE, 0);
> -       if (virtqueue_dma_mapping_error(sq->vq, hdr_dma)) {
> +       hdr_dma =3D virtqueue_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_=
len,
> +                                            DMA_TO_DEVICE, 0);
> +       if (virtqueue_map_mapping_error(sq->vq, hdr_dma)) {
>                 err =3D -ENOMEM;
>                 goto err_free_buffs;
>         }
> @@ -5952,8 +5952,8 @@ static int virtnet_xsk_pool_enable(struct net_devic=
e *dev,
>  err_rq:
>         xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> -       virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> -                                        DMA_TO_DEVICE, 0);
> +       virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> +                                    DMA_TO_DEVICE, 0);
>  err_free_buffs:
>         kvfree(rq->xsk_buffs);
>         return err;
> @@ -5980,8 +5980,8 @@ static int virtnet_xsk_pool_disable(struct net_devi=
ce *dev, u16 qid)
>
>         xsk_pool_dma_unmap(pool, 0);
>
> -       virtqueue_dma_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
> -                                        vi->hdr_len, DMA_TO_DEVICE, 0);
> +       virtqueue_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
> +                                    vi->hdr_len, DMA_TO_DEVICE, 0);
>         kvfree(rq->xsk_buffs);
>
>         return err;
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 75e5f6336c8d..482a268af851 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -166,7 +166,7 @@ struct vring_virtqueue {
>         bool packed_ring;
>
>         /* Is DMA API used? */
> -       bool use_dma_api;
> +       bool use_map_api;
>
>         /* Can we use weak barriers? */
>         bool weak_barriers;
> @@ -268,7 +268,7 @@ static bool virtqueue_use_indirect(const struct vring=
_virtqueue *vq,
>   * unconditionally on data path.
>   */
>
> -static bool vring_use_dma_api(const struct virtio_device *vdev)
> +static bool vring_use_map_api(const struct virtio_device *vdev)
>  {
>         if (!virtio_has_dma_quirk(vdev))
>                 return true;
> @@ -291,14 +291,14 @@ static bool vring_use_dma_api(const struct virtio_d=
evice *vdev)
>  static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring,
>                                     const struct vring_desc_extra *extra)
>  {
> -       return vring->use_dma_api && (extra->addr !=3D DMA_MAPPING_ERROR)=
;
> +       return vring->use_map_api && (extra->addr !=3D DMA_MAPPING_ERROR)=
;
>  }
>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  {
>         size_t max_segment_size =3D SIZE_MAX;
>
> -       if (vring_use_dma_api(vdev))
> +       if (vring_use_map_api(vdev))
>                 max_segment_size =3D dma_max_mapping_size(vdev->dev.paren=
t);
>
>         return max_segment_size;
> @@ -309,7 +309,7 @@ static void *vring_alloc_queue(struct virtio_device *=
vdev, size_t size,
>                                dma_addr_t *dma_handle, gfp_t flag,
>                                struct device *dma_dev)
>  {
> -       if (vring_use_dma_api(vdev)) {
> +       if (vring_use_map_api(vdev)) {
>                 return dma_alloc_coherent(dma_dev, size,
>                                           dma_handle, flag);
>         } else {
> @@ -343,7 +343,7 @@ static void vring_free_queue(struct virtio_device *vd=
ev, size_t size,
>                              void *queue, dma_addr_t dma_handle,
>                              struct device *dma_dev)
>  {
> -       if (vring_use_dma_api(vdev))
> +       if (vring_use_map_api(vdev))
>                 dma_free_coherent(dma_dev, size, queue, dma_handle);
>         else
>                 free_pages_exact(queue, PAGE_ALIGN(size));
> @@ -372,7 +372,7 @@ static int vring_map_one_sg(const struct vring_virtqu=
eue *vq, struct scatterlist
>
>         *len =3D sg->length;
>
> -       if (!vq->use_dma_api) {
> +       if (!vq->use_map_api) {
>                 /*
>                  * If DMA is not used, KMSAN doesn't know that the scatte=
rlist
>                  * is initialized by the hardware. Explicitly check/unpoi=
son it
> @@ -402,17 +402,17 @@ static dma_addr_t vring_map_single(const struct vri=
ng_virtqueue *vq,
>                                    void *cpu_addr, size_t size,
>                                    enum dma_data_direction direction)
>  {
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return (dma_addr_t)virt_to_phys(cpu_addr);
>
> -       return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
> -                                             size, direction, 0);
> +       return virtqueue_map_single_attrs(&vq->vq, cpu_addr,
> +                                         size, direction, 0);
>  }
>
>  static int vring_mapping_error(const struct vring_virtqueue *vq,
>                                dma_addr_t addr)
>  {
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return 0;
>
>         return dma_mapping_error(vring_dma_dev(vq), addr);
> @@ -449,7 +449,7 @@ static unsigned int vring_unmap_one_split(const struc=
t vring_virtqueue *vq,
>         flags =3D extra->flags;
>
>         if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> +               if (!vq->use_map_api)
>                         goto out;
>         } else if (!vring_need_unmap_buffer(vq, extra))
>                 goto out;
> @@ -782,7 +782,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>
>                 extra =3D (struct vring_desc_extra *)&indir_desc[num];
>
> -               if (vq->use_dma_api) {
> +               if (vq->use_map_api) {
>                         for (j =3D 0; j < num; j++)
>                                 vring_unmap_one_split(vq, &extra[j]);
>                 }
> @@ -1150,7 +1150,7 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>         vq->broken =3D false;
>  #endif
>         vq->dma_dev =3D dma_dev;
> -       vq->use_dma_api =3D vring_use_dma_api(vdev);
> +       vq->use_map_api =3D vring_use_map_api(vdev);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -1266,7 +1266,7 @@ static void vring_unmap_extra_packed(const struct v=
ring_virtqueue *vq,
>         flags =3D extra->flags;
>
>         if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> +               if (!vq->use_map_api)
>                         return;
>         } else if (!vring_need_unmap_buffer(vq, extra))
>                 return;
> @@ -1351,7 +1351,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         desc[i].addr =3D cpu_to_le64(addr);
>                         desc[i].len =3D cpu_to_le32(len);
>
> -                       if (unlikely(vq->use_dma_api)) {
> +                       if (unlikely(vq->use_map_api)) {
>                                 extra[i].addr =3D premapped ? DMA_MAPPING=
_ERROR : addr;
>                                 extra[i].len =3D len;
>                                 extra[i].flags =3D n < out_sgs ?  0 : VRI=
NG_DESC_F_WRITE;
> @@ -1373,7 +1373,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vq->use_dma_api) {
> +       if (vq->use_map_api) {
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> @@ -1515,7 +1515,7 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                         desc[i].len =3D cpu_to_le32(len);
>                         desc[i].id =3D cpu_to_le16(id);
>
> -                       if (unlikely(vq->use_dma_api)) {
> +                       if (unlikely(vq->use_map_api)) {
>                                 vq->packed.desc_extra[curr].addr =3D prem=
apped ?
>                                         DMA_MAPPING_ERROR : addr;
>                                 vq->packed.desc_extra[curr].len =3D len;
> @@ -1650,7 +1650,7 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->use_dma_api)) {
> +       if (unlikely(vq->use_map_api)) {
>                 curr =3D id;
>                 for (i =3D 0; i < state->num; i++) {
>                         vring_unmap_extra_packed(vq,
> @@ -1668,7 +1668,7 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                 if (!desc)
>                         return;
>
> -               if (vq->use_dma_api) {
> +               if (vq->use_map_api) {
>                         len =3D vq->packed.desc_extra[id].len;
>                         num =3D len / sizeof(struct vring_packed_desc);
>
> @@ -2121,7 +2121,7 @@ static struct virtqueue *__vring_new_virtqueue_pack=
ed(unsigned int index,
>  #endif
>         vq->packed_ring =3D true;
>         vq->dma_dev =3D dma_dev;
> -       vq->use_dma_api =3D vring_use_dma_api(vdev);
> +       vq->use_map_api =3D vring_use_map_api(vdev);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !context;
> @@ -2433,7 +2433,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *=
_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (vq->use_dma_api)
> +       if (vq->use_map_api)
>                 return vring_dma_dev(vq);
>         else
>                 return NULL;
> @@ -3122,7 +3122,7 @@ const struct vring *virtqueue_get_vring(const struc=
t virtqueue *vq)
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>
>  /**
> - * virtqueue_dma_map_single_attrs - map DMA for _vq
> + * virtqueue_map_single_attrs - map DMA for _vq
>   * @_vq: the struct virtqueue we're talking about.
>   * @ptr: the pointer of the buffer to do dma
>   * @size: the size of the buffer to do dma
> @@ -3132,16 +3132,16 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>   * The caller calls this to do dma mapping in advance. The DMA address c=
an be
>   * passed to this _vq when it is in pre-mapped mode.
>   *
> - * return DMA address. Caller should check that by virtqueue_dma_mapping=
_error().
> + * return DMA address. Caller should check that by virtqueue_mapping_err=
or().
>   */
> -dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, v=
oid *ptr,
> -                                         size_t size,
> -                                         enum dma_data_direction dir,
> -                                         unsigned long attrs)
> +dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void =
*ptr,
> +                                     size_t size,
> +                                     enum dma_data_direction dir,
> +                                     unsigned long attrs)
>  {
>         const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (!vq->use_dma_api) {
> +       if (!vq->use_map_api) {
>                 kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), =
size, dir);
>                 return (dma_addr_t)virt_to_phys(ptr);
>         }
> @@ -3154,85 +3154,85 @@ dma_addr_t virtqueue_dma_map_single_attrs(const s=
truct virtqueue *_vq, void *ptr
>         return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
>                                   offset_in_page(ptr), size, dir, attrs);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
> +EXPORT_SYMBOL_GPL(virtqueue_map_single_attrs);
>
>  /**
> - * virtqueue_dma_unmap_single_attrs - unmap DMA for _vq
> + * virtqueue_unmap_single_attrs - unmap map for _vq
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: the dma address to unmap
>   * @size: the size of the buffer
>   * @dir: DMA direction
>   * @attrs: DMA Attrs
>   *
> - * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> + * Unmap the address that is mapped by the virtqueue_map_* APIs.
>   *
>   */
> -void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> -                                     dma_addr_t addr,
> -                                     size_t size, enum dma_data_directio=
n dir,
> -                                     unsigned long attrs)
> +void virtqueue_unmap_single_attrs(const struct virtqueue *_vq,
> +                                 dma_addr_t addr,
> +                                 size_t size, enum dma_data_direction di=
r,
> +                                 unsigned long attrs)
>  {
>         const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return;
>
>         dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
> +EXPORT_SYMBOL_GPL(virtqueue_unmap_single_attrs);
>
>  /**
> - * virtqueue_dma_mapping_error - check dma address
> + * virtqueue_map_mapping_error - check dma address
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: DMA address
>   *
>   * Returns 0 means dma valid. Other means invalid dma address.
>   */
> -int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr)
> +int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr)
>  {
>         const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return 0;
>
>         return dma_mapping_error(vring_dma_dev(vq), addr);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
> +EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
>
>  /**
> - * virtqueue_dma_need_sync - check a dma address needs sync
> + * virtqueue_map_need_sync - check a dma address needs sync
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: DMA address
>   *
> - * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs=
 to be
> + * Check if the dma address mapped by the virtqueue_map_* APIs needs to =
be
>   * synchronized
>   *
>   * return bool
>   */
> -bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r)
> +bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r)
>  {
>         const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return false;
>
>         return dma_need_sync(vring_dma_dev(vq), addr);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> +EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
>
>  /**
> - * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
> + * virtqueue_map_sync_single_range_for_cpu - map sync for cpu
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: DMA address
>   * @offset: DMA address offset
>   * @size: buf size for sync
>   * @dir: DMA direction
>   *
> - * Before calling this function, use virtqueue_dma_need_sync() to confir=
m that
> + * Before calling this function, use virtqueue_map_need_sync() to confir=
m that
>   * the DMA address really needs to be synchronized
>   *
>   */
> -void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq=
,
> +void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq=
,
>                                              dma_addr_t addr,
>                                              unsigned long offset, size_t=
 size,
>                                              enum dma_data_direction dir)
> @@ -3240,25 +3240,25 @@ void virtqueue_dma_sync_single_range_for_cpu(cons=
t struct virtqueue *_vq,
>         const struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct device *dev =3D vring_dma_dev(vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return;
>
>         dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> +EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
>
>  /**
> - * virtqueue_dma_sync_single_range_for_device - dma sync for device
> + * virtqueue_map_sync_single_range_for_device - map sync for device
>   * @_vq: the struct virtqueue we're talking about.
>   * @addr: DMA address
>   * @offset: DMA address offset
>   * @size: buf size for sync
>   * @dir: DMA direction
>   *
> - * Before calling this function, use virtqueue_dma_need_sync() to confir=
m that
> + * Before calling this function, use virtqueue_map_need_sync() to confir=
m that
>   * the DMA address really needs to be synchronized
>   */
> -void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *=
_vq,
> +void virtqueue_map_sync_single_range_for_device(const struct virtqueue *=
_vq,
>                                                 dma_addr_t addr,
>                                                 unsigned long offset, siz=
e_t size,
>                                                 enum dma_data_direction d=
ir)
> @@ -3266,12 +3266,12 @@ void virtqueue_dma_sync_single_range_for_device(c=
onst struct virtqueue *_vq,
>         const struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct device *dev =3D vring_dma_dev(vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_map_api)
>                 return;
>
>         dma_sync_single_range_for_device(dev, addr, offset, size, dir);
>  }
> -EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
> +EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
>
>  MODULE_DESCRIPTION("Virtio ring implementation");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index cf8def717dfd..addbc209275a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver =
*drv);
>         module_driver(__virtio_driver, register_virtio_driver, \
>                         unregister_virtio_driver)
>
> -dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, v=
oid *ptr, size_t size,
> +dma_addr_t virtqueue_map_single_attrs(const struct virtqueue *_vq, void =
*ptr, size_t size,
>                                           enum dma_data_direction dir, un=
signed long attrs);
> -void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_a=
ddr_t addr,
> +void virtqueue_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_=
t addr,
>                                       size_t size, enum dma_data_directio=
n dir,
>                                       unsigned long attrs);
> -int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr);
> +int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr);
>
> -bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r);
> -void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq=
, dma_addr_t addr,
> +bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r);
> +void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq=
, dma_addr_t addr,
>                                              unsigned long offset, size_t=
 size,
>                                              enum dma_data_direction dir)=
;
> -void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *=
_vq, dma_addr_t addr,
> +void virtqueue_map_sync_single_range_for_device(const struct virtqueue *=
_vq, dma_addr_t addr,
>                                                 unsigned long offset, siz=
e_t size,
>                                                 enum dma_data_direction d=
ir);
>
> --
> 2.31.1
>

