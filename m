Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BF3B7B79
	for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735197; cv=none; b=tQDvnlnk1WQZgw+aI1CLcU6q60hMHuLGw13EBElSvSoPOOZxVZmcTIdYHfDDox9Oldsa+//PdnreCimIxJeS02+LN1PXoqyacrlrujG2g9YTkHyUV/phHilcopp8cSArATc8Yo9x5QA8uVGNDCczi0VZwrcvUNZgOSeufvbli5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735197; c=relaxed/simple;
	bh=xVXq53IWBG3njT/N8GujFXddmGMQMvs5yba1G40N6xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1k5K6nU2Tc7qSduQBJICNxEOW5Hq4OOjAHvlDdjyoinevYnc7uu51e/RcAvYhB2h7v2z4ANxc/izaV3jiA2CXGPHQJ3SHnfeIY1dD9gEf+33OF8EejintM9zmAQDx4+dJIDBmGKtBYFy0skhohho/Pw1vTeHkjgHbTmzjNRfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUtXSiKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUtXSiKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787735194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab6jUY39RdFxCdjNFLIhzvChS1iPatmkOV4Nf5plJ8I=;
	b=EUtXSiKu+xCqttuxq6eFY/3b1+Kk+gv/dL2Lqv33aK8EYNsNpW6ZAQajfgbuGRa2BV0MND
	Ci1/MoqMo/llcgDqgDEHVo+uxRWawGP1wdRZofirtR0TUrt9nm4huxK4vdbOCs9Bo3eQpF
	EOSIPPpYfY0EsPFe/xJ5UrUD8WbAeoo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-MnvwqY5xMN-SWIp1ZSGlkQ-1; Wed, 26 Aug 2026 05:06:33 -0400
X-MC-Unique: MnvwqY5xMN-SWIp1ZSGlkQ-1
X-Mimecast-MFC-AGG-ID: MnvwqY5xMN-SWIp1ZSGlkQ_1787735193
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66c70bf18a1so1997696d50.0
        for <virtualization@lists.linux.dev>; Wed, 26 Aug 2026 02:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735193; x=1788339993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ab6jUY39RdFxCdjNFLIhzvChS1iPatmkOV4Nf5plJ8I=;
        b=gd+XiXeiWkfhCptdJakIv7wGBBaJY2rtO51M4FTcCjS71Ily6eOHkp9UY85rsoqNqZ
         4UNm2Z205aSJg5AjWkYG2o4X0rqOV9Q0mTG5Xmv/3R6xZiojwEdwAPPaNkvi8ONwfaNy
         c3kxgrEDgJrfCgQMZBAjyV9VSIdTfyLEPzlrV0NK3BYcOGQ7ysKVmxzgpSY+p7zphsKw
         J1mJDWi2vh6l4HFME3sCf/t50nsx78JZUCYfVmtuM04Ki1d7b/bTalrzXoAXlwnhyUbW
         LMe7JlXoLH6A4FA7VTzBRjGM+vE5iKv6i+NWOA8yFi1PSDGpENO6661kIneCtWHynGvh
         dabg==
X-Forwarded-Encrypted: i=1; AHgh+RrowCeSFkCzF4/OY90vx/2CAAm+QsIB4eWHpQ9orHQlxfKYn/kv4FAhEQbDxjU+Ylh7JonrnlJl40V288TOfA==@lists.linux.dev
X-Gm-Message-State: AFuF++msfDXWhWxPcEE9EbyyC6Y6yAItCODhxeKYI4AO9u/d7J+x8C5W
	eaB5EZCqmrxFX3LQAirTKZO3rOlKLdr04dzMt3oprOA6wMB/nCefV125FR3F5Pi6syeFcT6PEYR
	ZpBegTELv5ws+1jDYKYNQF9gBmvhOrFBQcpxO4geOUFMM2ztKlBkouxVKzkJehmzMabNKHKUQk0
	ESdunWnXytLR2unYC+yV27oyp5hwikEnO4xVVqEg8woRsA5KlOn4vzAg==
X-Gm-Gg: AR+sD10syAMQCRo4bhwfkaQI+B+0nlNtQjFTb9G7tc/einKEo3EFXFmFrw0Xtu7xGIp
	f4U4s5WZDDjz6eUekXn0NaAHukFENxu3Mvg/L6tLGfyq7YAPyFCicqJr3hNKtSmgo+vlwiIuKLt
	7P8TxShZ9ClnAiqIU6G0T6kAUOI4aBZ4/+TJQWmUDc6/uoxfON83dg7YnLeu23c/a7+HoC3F71O
	edzQGrp+gciebDT7Q52UUkdrFfj4NufkLTCPxdHbaoyeK5Ea0Th2vy4HyE=
X-Received: by 2002:a05:690e:1182:b0:66c:85e3:7f1a with SMTP id 956f58d0204a3-66d25815694mr1683785d50.50.1787735188152;
        Wed, 26 Aug 2026 02:06:28 -0700 (PDT)
X-Received: by 2002:a05:690e:1182:b0:66c:85e3:7f1a with SMTP id
 956f58d0204a3-66d25815694mr1683770d50.50.1787735187696; Wed, 26 Aug 2026
 02:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260818211425.91009-1-graf@amazon.com> <20260818211425.91009-3-graf@amazon.com>
In-Reply-To: <20260818211425.91009-3-graf@amazon.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Aug 2026 11:05:50 +0200
X-Gm-Features: AcwNN1VaYV146vQFMQPW6JllorS5F5iwyh4-QGaVFkEQ_yrJpiPKMgyNd3rxTNQ
Message-ID: <CAJaqyWeXuDDvS+nswJYoLE3u9dY51uPX3+6y0Kwu2h8VdUy7YA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] virtio: drop the sync operations from virtio_map_ops
To: Alexander Graf <graf@amazon.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, nh-open-source@amazon.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bGzlnV0bVarW6VFlpCbiYNCZRmhIifvIfhC_TsKfj8E_1787735193
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:14=E2=80=AFPM Alexander Graf <graf@amazon.com> w=
rote:
>
> With the map sync API gone, sync_single_for_cpu, sync_single_for_device
> and need_sync in struct virtio_map_ops are members the virtqueue never
> calls. vduse is the only implementation in the tree and provides all
> three, and the next implementer has to decide what to put in them.
>
> Drop the three members and their kernel-doc, and remove the vduse
> functions that provided them. vduse_domain_bounce() stays, because
> vduse_domain_map_page() and vduse_domain_unmap_page() bounce through it
> as well. That way the struct asks an implementation for six operations
> instead of nine.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Assisted-by: Kiro:claude-opus-5 checkpatch
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 20 --------------
>  drivers/vdpa/vdpa_user/iova_domain.h |  8 ------
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 40 ----------------------------
>  include/linux/virtio_config.h        | 20 --------------
>  4 files changed, 88 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 4dc76c0d0d13..094fe1ec02c3 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -424,26 +424,6 @@ static void vduse_domain_free_iova(struct iova_domai=
n *iovad,
>         free_iova_fast(iovad, iova >> shift, iova_len);
>  }
>
> -void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domai=
n,
> -                                     dma_addr_t dma_addr, size_t size,
> -                                     enum dma_data_direction dir)
> -{
> -       read_lock(&domain->bounce_lock);
> -       if (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)
> -               vduse_domain_bounce(domain, dma_addr, size, DMA_TO_DEVICE=
);
> -       read_unlock(&domain->bounce_lock);
> -}
> -
> -void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
> -                                     dma_addr_t dma_addr, size_t size,
> -                                     enum dma_data_direction dir)
> -{
> -       read_lock(&domain->bounce_lock);
> -       if (dir =3D=3D DMA_FROM_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)
> -               vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVI=
CE);
> -       read_unlock(&domain->bounce_lock);
> -}
> -
>  dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
>                                  struct page *page, unsigned long offset,
>                                  size_t size, enum dma_data_direction dir=
,
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index e50e55d1396f..66f14764a5db 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -48,14 +48,6 @@ int vduse_domain_set_map(struct vduse_iova_domain *dom=
ain,
>  void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>                             struct vhost_iotlb *iotlb);
>
> -void vduse_domain_sync_single_for_device(struct vduse_iova_domain *domai=
n,
> -                                     dma_addr_t dma_addr, size_t size,
> -                                     enum dma_data_direction dir);
> -
> -void vduse_domain_sync_single_for_cpu(struct vduse_iova_domain *domain,
> -                                     dma_addr_t dma_addr, size_t size,
> -                                     enum dma_data_direction dir);
> -
>  dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
>                                  struct page *page, unsigned long offset,
>                                  size_t size, enum dma_data_direction dir=
,
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 10dcf016bfb0..7a1a344539b8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -932,34 +932,6 @@ static const struct vdpa_config_ops vduse_vdpa_confi=
g_ops =3D {
>         .free                   =3D vduse_vdpa_free,
>  };
>
> -static void vduse_dev_sync_single_for_device(union virtio_map token,
> -                                            dma_addr_t dma_addr, size_t =
size,
> -                                            enum dma_data_direction dir)
> -{
> -       struct vduse_iova_domain *domain;
> -
> -       if (!token.group)
> -               return;
> -
> -       guard(vq_group_as_read_lock)(token.group);
> -       domain =3D token.group->as->domain;
> -       vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
> -}
> -
> -static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> -                                            dma_addr_t dma_addr, size_t =
size,
> -                                            enum dma_data_direction dir)
> -{
> -       struct vduse_iova_domain *domain;
> -
> -       if (!token.group)
> -               return;
> -
> -       guard(vq_group_as_read_lock)(token.group);
> -       domain =3D token.group->as->domain;
> -       vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> -}
> -
>  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page=
 *page,
>                                      unsigned long offset, size_t size,
>                                      enum dma_data_direction dir,
> @@ -1037,15 +1009,6 @@ static void vduse_dev_free_coherent(union virtio_m=
ap token, size_t size,
>         free_pages_exact(vaddr, size);
>  }
>
> -static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
> -{
> -       if (!token.group)
> -               return false;
> -
> -       guard(vq_group_as_read_lock)(token.group);
> -       return dma_addr < token.group->as->domain->bounce_size;
> -}
> -
>  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dm=
a_addr)
>  {
>         if (unlikely(dma_addr =3D=3D DMA_MAPPING_ERROR))
> @@ -1063,13 +1026,10 @@ static size_t vduse_dev_max_mapping_size(union vi=
rtio_map token)
>  }
>
>  static const struct virtio_map_ops vduse_map_ops =3D {
> -       .sync_single_for_device =3D vduse_dev_sync_single_for_device,
> -       .sync_single_for_cpu =3D vduse_dev_sync_single_for_cpu,
>         .map_page =3D vduse_dev_map_page,
>         .unmap_page =3D vduse_dev_unmap_page,
>         .alloc =3D vduse_dev_alloc_coherent,
>         .free =3D vduse_dev_free_coherent,
> -       .need_sync =3D vduse_dev_need_sync,
>         .mapping_error =3D vduse_dev_mapping_error,
>         .max_mapping_size =3D vduse_dev_max_mapping_size,
>  };
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index 69f84ea85d71..eb38c876a628 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -157,16 +157,6 @@ struct virtio_config_ops {
>   *      size: the buffer size
>   *      dir: mapping direction
>   *      attrs: unmapping attributes
> - * @sync_single_for_cpu: sync a single buffer from device to cpu
> - *      map: metadata for performing mapping
> - *      map_handle: the mapping address to sync
> - *      size: the size of the buffer
> - *      dir: synchronization direction
> - * @sync_single_for_device: sync a single buffer from cpu to device
> - *      map: metadata for performing mapping
> - *      map_handle: the mapping address to sync
> - *      size: the size of the buffer
> - *      dir: synchronization direction
>   * @alloc: alloc a coherent buffer mapping
>   *      map: metadata for performing mapping
>   *      size: the size of the buffer
> @@ -179,10 +169,6 @@ struct virtio_config_ops {
>   *      vaddr: virtual address of the buffer
>   *      map_handle: the mapping address that needs to be freed
>   *      attrs: unmapping attributes
> - * @need_sync: if the buffer needs synchronization
> - *      map: metadata for performing mapping
> - *      map_handle: the mapped address
> - *      Returns whether the buffer needs synchronization
>   * @mapping_error: if the mapping address is error
>   *      map: metadata for performing mapping
>   *      map_handle: the mapped address
> @@ -197,16 +183,10 @@ struct virtio_map_ops {
>         void (*unmap_page)(union virtio_map map, dma_addr_t map_handle,
>                            size_t size, enum dma_data_direction dir,
>                            unsigned long attrs);
> -       void (*sync_single_for_cpu)(union virtio_map map, dma_addr_t map_=
handle,
> -                                   size_t size, enum dma_data_direction =
dir);
> -       void (*sync_single_for_device)(union virtio_map map,
> -                                      dma_addr_t map_handle, size_t size=
,
> -                                      enum dma_data_direction dir);
>         void *(*alloc)(union virtio_map map, size_t size,
>                        dma_addr_t *map_handle, gfp_t gfp);
>         void (*free)(union virtio_map map, size_t size, void *vaddr,
>                      dma_addr_t map_handle, unsigned long attrs);
> -       bool (*need_sync)(union virtio_map map, dma_addr_t map_handle);
>         int (*mapping_error)(union virtio_map map, dma_addr_t map_handle)=
;
>         size_t (*max_mapping_size)(union virtio_map map);
>  };
>

