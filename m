Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B33B4E8C
	for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733106; cv=none; b=c6LX2jBm8XnM1wqdzqYCooYFjh03aVywp3GIRU6Cld4vDEsetWnIAqSDqVXQNQXdbyDmZpFRySoGQ4JhDD/k9f6HVVH7ti0eZP527zpFQU6kdeRMFCcthRdu8n27KFE7Ntokzh8K9RP6WfS34DRHaLGfIPhuc2PU5iyjDCuO+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733106; c=relaxed/simple;
	bh=WmBMLh9fOW3ulFZCNkqSj5P9KFYq6NqEHsa9honNhkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbSHcmI7DdW/wg9hV8MU4qZFDLG495s9apT9nNeRfbR+pVmWtxV49s4TvPt+46MfoHMH/gIz0gCKWPCQMG/lBtUtvFPmrRxqZa/Py+ZQx1VaVr49BsWcG/K58oCozB3xErrUVXTSKSFPeKOPSpiEegATJfV3EdkNXsiLen+HRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evqLnnqq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evqLnnqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787733101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5+E0CrDcVzKdOOfJ1xFDjBrfYLvEca/2hrgwSPEku4=;
	b=evqLnnqqD/oQfN2x+5sBoW/LJo7rKqFyURU8TCJS4ggqcixhYJ/eXaUNClQHFYrJ6qU63w
	aLU/NC4jtJYZQvbIVCCrhmLFpp25n4p5ILuWh9bXGGaAr2D9GkOlyza0ewVsl1ESS0WGDq
	ZXX33fKWRtshSRizOEG5WLVNEGXPajw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-oGv_sjbANF2EyCJTZlsuaQ-1; Wed, 26 Aug 2026 04:31:40 -0400
X-MC-Unique: oGv_sjbANF2EyCJTZlsuaQ-1
X-Mimecast-MFC-AGG-ID: oGv_sjbANF2EyCJTZlsuaQ_1787733100
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81e735bcceaso12035387b3.3
        for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 01:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733099; x=1788337899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5+E0CrDcVzKdOOfJ1xFDjBrfYLvEca/2hrgwSPEku4=;
        b=C8qEDDYHaURaPw5wwX6lNvpwtjbIs2aZYZMIg6aOLyeq3t2dUcSzdBIDek8+OlbrC8
         ANT4E1Lts3Lea4dCvS0XPQXjzwKeQdyQbg+77Qc8+tLeZzn+6M51fruOIEagwwYiEDhN
         rVEoUGYRBZz2GdX4QBqHrKakmKT8hSQX+kDXDSbdSGaRdI8TDlvQ1V2B/c3RigiN8m8N
         QPDPvTDNPVIQYsND8kQUv9aTy41cJNt63XLnOQHC8OE8EyH3zBWEDMcWjDNzxJ/yRWhl
         k/BslHYqtzRnfP+tvlPPp87PUp83wvre8lwdATKM4iV2dvtCjijE7XOmHZafGRA0vsUN
         5WwA==
X-Forwarded-Encrypted: i=1; AHgh+Rohlif8vl9jV8Umy0xQwrPjeMxdZYU2+rZ7AMob+jhQcWFeyydbOTo17Si/+784uFFVEk4XrYzb/1ZP4Nhjag==@lists.linux.dev
X-Gm-Message-State: AFuF++nL18dHZYn48ffH9U93IPdSF5KZ5lZ8b+cOsuN3t/vQ+rv8AHFS
	Jt/UpK2wPklQ/qWsl9CSU5UzoOamD6mrBCCa6mr5k3FHF4BnwEiFSdiZEzICKS0iduUJt/1ro88
	7FgpzLHwoPALEn5Y7fU6HFXKasf7TySSCSzW+Xy7eF5CIgW0+0R8xwGtvkUkQBwhxO/pD/24cyt
	dhB8PvABiUyjWpyjaobYPY6PfYXchcbuXavp2HS/dWW/Q=
X-Gm-Gg: AR+sD11VOmFU/2AzDwxFMi19ahpnm2WE23BDLVRNv9P2Ah20SenfsJRJOTIAzyirBf/
	4VlMi0aipyx3fk5leWLggQg2uIZkbRseOUm8XnHe1wfZlshnNsMyXBNb1dlX6CpQVdOg9z2pyf6
	rV7jrpjKILgC3P+LCU+jdwgRkCkb0c34DHN6fwOy3RRvGj0UHMFNWkEl91Px807t3lw0fy7yrc1
	+ss3zG2Yzm817TXVdfxzVesjpqg3Bvtu2ajZH3Z7nELbW68BpJGGKiozfE=
X-Received: by 2002:a53:d00e:0:b0:66c:fb45:77e2 with SMTP id 956f58d0204a3-66d2575a752mr1279680d50.28.1787733099285;
        Wed, 26 Aug 2026 01:31:39 -0700 (PDT)
X-Received: by 2002:a53:d00e:0:b0:66c:fb45:77e2 with SMTP id
 956f58d0204a3-66d2575a752mr1279656d50.28.1787733098755; Wed, 26 Aug 2026
 01:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-2-graf@amazon.com>
In-Reply-To: <20260818211425.91009-2-graf@amazon.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Aug 2026 10:31:02 +0200
X-Gm-Features: AcwNN1UkVvtz0AftdF5pqYUDLlDPvjVn0MFdlINFqHbpJay-uZ3ZmdWsHYJsr4c
Message-ID: <CAJaqyWcYqZ7gjtSW=DXeX2gkTij-kO=hc0dOzHAdY7jvTvfsDg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] virtio_ring: remove the unused map sync API
To: Alexander Graf <graf@amazon.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FVj7LBIS4aZvS-DYIzrzsikqmS1xgKxDjQoSlJL6428_1787733100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:14=E2=80=AFPM Alexander Graf <graf@amazon.com> w=
rote:
>
> virtqueue_map_need_sync(), virtqueue_map_sync_single_range_for_cpu() and
> virtqueue_map_sync_single_range_for_device() are exported, but no driver
> in the tree calls them. They are the only path into the sync members of
> struct virtio_map_ops, so whoever implements that struct next has to
> decide what those members do with no caller to learn it from.
>
> Remove the three functions, their prototypes and their exports, and the
> DMA sync shims that the virtio userspace harness kept for them. With
> this, virtio_ring no longer exports a way to sync a mapping.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Assisted-by: Kiro:claude-opus-5 checkpatch
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/virtio/virtio_ring.c     | 89 --------------------------------
>  include/linux/virtio.h           |  8 ---
>  tools/virtio/linux/dma-mapping.h |  7 ---
>  3 files changed, 104 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b438dc2ce1b8..ea8e774b6d8e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3890,94 +3890,5 @@ int virtqueue_map_mapping_error(const struct virtq=
ueue *_vq, dma_addr_t addr)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
>
> -/**
> - * virtqueue_map_need_sync - check a dma address needs sync
> - * @_vq: the struct virtqueue we're talking about.
> - * @addr: DMA address
> - *
> - * Check if the dma address mapped by the virtqueue_map_* APIs needs to =
be
> - * synchronized
> - *
> - * return bool
> - */
> -bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r)
> -{
> -       const struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> -
> -       if (!vq->use_map_api)
> -               return false;
> -
> -       if (vdev->map)
> -               return vdev->map->need_sync(vq->map, addr);
> -       else
> -               return dma_need_sync(vring_dma_dev(vq), addr);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_map_need_sync);
> -
> -/**
> - * virtqueue_map_sync_single_range_for_cpu - map sync for cpu
> - * @_vq: the struct virtqueue we're talking about.
> - * @addr: DMA address
> - * @offset: DMA address offset
> - * @size: buf size for sync
> - * @dir: DMA direction
> - *
> - * Before calling this function, use virtqueue_map_need_sync() to confir=
m that
> - * the DMA address really needs to be synchronized
> - *
> - */
> -void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq=
,
> -                                            dma_addr_t addr,
> -                                            unsigned long offset, size_t=
 size,
> -                                            enum dma_data_direction dir)
> -{
> -       const struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> -
> -       if (!vq->use_map_api)
> -               return;
> -
> -       if (vdev->map)
> -               vdev->map->sync_single_for_cpu(vq->map,
> -                                              addr + offset, size, dir);
> -       else
> -               dma_sync_single_range_for_cpu(vring_dma_dev(vq),
> -                                             addr, offset, size, dir);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_cpu);
> -
> -/**
> - * virtqueue_map_sync_single_range_for_device - map sync for device
> - * @_vq: the struct virtqueue we're talking about.
> - * @addr: DMA address
> - * @offset: DMA address offset
> - * @size: buf size for sync
> - * @dir: DMA direction
> - *
> - * Before calling this function, use virtqueue_map_need_sync() to confir=
m that
> - * the DMA address really needs to be synchronized
> - */
> -void virtqueue_map_sync_single_range_for_device(const struct virtqueue *=
_vq,
> -                                               dma_addr_t addr,
> -                                               unsigned long offset, siz=
e_t size,
> -                                               enum dma_data_direction d=
ir)
> -{
> -       const struct vring_virtqueue *vq =3D to_vvq(_vq);
> -       struct virtio_device *vdev =3D _vq->vdev;
> -
> -       if (!vq->use_map_api)
> -               return;
> -
> -       if (vdev->map)
> -               vdev->map->sync_single_for_device(vq->map,
> -                                                 addr + offset,
> -                                                 size, dir);
> -       else
> -               dma_sync_single_range_for_device(vring_dma_dev(vq), addr,
> -                                                offset, size, dir);
> -}
> -EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
> -
>  MODULE_DESCRIPTION("Virtio ring implementation");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 93e573c56563..3122fc52a7c3 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -312,14 +312,6 @@ void virtqueue_unmap_single_attrs(const struct virtq=
ueue *_vq, dma_addr_t addr,
>                                       unsigned long attrs);
>  int virtqueue_map_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr);
>
> -bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r);
> -void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq=
, dma_addr_t addr,
> -                                            unsigned long offset, size_t=
 size,
> -                                            enum dma_data_direction dir)=
;
> -void virtqueue_map_sync_single_range_for_device(const struct virtqueue *=
_vq, dma_addr_t addr,
> -                                               unsigned long offset, siz=
e_t size,
> -                                               enum dma_data_direction d=
ir);
> -
>  #ifdef CONFIG_VIRTIO_DEBUG
>  void virtio_debug_device_init(struct virtio_device *dev);
>  void virtio_debug_device_exit(struct virtio_device *dev);
> diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-ma=
pping.h
> index b9fc5e8338e3..eae160ce7142 100644
> --- a/tools/virtio/linux/dma-mapping.h
> +++ b/tools/virtio/linux/dma-mapping.h
> @@ -36,16 +36,9 @@ enum dma_data_direction {
>
>  #define sg_dma_address(sg) (0)
>  #define sg_dma_len(sg) (0)
> -#define dma_need_sync(v, a) (0)
>  #define dma_unmap_single_attrs(d, a, s, r, t) do { \
>         (void)(d); (void)(a); (void)(s); (void)(r); (void)(t); \
>  } while (0)
> -#define dma_sync_single_range_for_cpu(d, a, o, s, r) do { \
> -       (void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> -} while (0)
> -#define dma_sync_single_range_for_device(d, a, o, s, r) do { \
> -       (void)(d); (void)(a); (void)(o); (void)(s); (void)(r); \
> -} while (0)
>  #define dma_max_mapping_size(...) SIZE_MAX
>
>  /*
>

