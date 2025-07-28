Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547161D6AA
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699491; cv=none; b=NHoLX85WIxSSU7GbtrnPNLUM1Z+mGh2fA8RijquzWrNtU32LLsbfuYoXc0NHFXpucLGBkUYOuy5gW6PtZtLPQLRXCveN3dEa/8GKocL6oCXWu/QwMfNlX1pEl4H775uZ9+9fVPR9UVLEiaa0qt+jdmajs1Xu4FotarDEE2I3A/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699491; c=relaxed/simple;
	bh=jTBFsZykzomy9yBvvbx8S2eVbb4ZYwV0cOOrlSyx9qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CauG83sn9eoF86988kX6PKojd/z1iMxI3S3BU/GTB6Db5s7h2l3WK8DMh1N/wlyzCG37ozdxbAbfsxGRhBIjS/5cq/hx/kaMif7FNWyrR/fWbqzs9YFbbCzvB7DM9DpANTlvbQqvq2UJKHAURTqSeSP03RCmm6kPpEkZD10k0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZTnWov2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZTnWov2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753699488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ro6EJKIXVdo07/JIi8EIXc9nmD2Xi08xWTRlEveDTAM=;
	b=AZTnWov2eM5EWEPtwxzHbAkWooYstRWlTjfTsdalG81b5kRTBVO+tl1dfnR/DxiW2OpHpX
	iOk5Gzhs4nJrv06H4sRjL2o3oYedSKEhdoz/l0eIqehS2l3m0X1RAE/Ovpe7WoZiV9jS0t
	zkX6eRfxlq0TBBl/LXh2o5dkl12uP1k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-SX2v-TI3Pr-jccYfuUswfQ-1; Mon, 28 Jul 2025 06:44:46 -0400
X-MC-Unique: SX2v-TI3Pr-jccYfuUswfQ-1
X-Mimecast-MFC-AGG-ID: SX2v-TI3Pr-jccYfuUswfQ_1753699486
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235eefe6a8fso34103645ad.1
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753699485; x=1754304285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro6EJKIXVdo07/JIi8EIXc9nmD2Xi08xWTRlEveDTAM=;
        b=R8e/2wYdY8iBbOsdjkJdF+xqFWI/B6agbyZ25SQlC4FHx/PI9VU/QuYnVVCpVo9pwy
         nS9sCXUFTMIELijewpaoMhHMVCUC4Fvln/EGg3JAhdpKlGYO/C+mmpofqPlMHTQ2KQp7
         R1QGdjIPdpmPHGf8WNckif0a2V90cifwa8ukuFN40bW5x4Bq4T7h9dYIwUc3nep79dwA
         uf3xMmEnnclDLU29cTJVJulyyDLISpAL5/v7xQN/4MK99M5oaoYFyNW10STnbwJBXsRn
         8LA7caJNSrOYFQ4lLvIj0ipG5ITC6FurVYEhD2jzBDsQKMq8wiesG2urYJ9e/CYIy4Xs
         xPiw==
X-Forwarded-Encrypted: i=1; AJvYcCUiJE8NIgazF6VyaClz/qCe+VJkLAlJrvyDpEiVSFcu2DtGMBJ5fumGag/OkOal8iLon6AqDvbuso9cyM+KMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yylm6jMwQVTXz+dYhsc2Jsco4awvirK2ryeENWIO9rhwcp2GNO0
	KMINPS+Rv8kWTski7VH+p5ix+qoLMR2soHiL1/v4Ib/Be9yAm4h+deVU5XSXTQo4ePuYJS84pJJ
	RclceVbds7Nlgn/QDsF9ypmeJi4/G475iRgz+pfeTqY0Dw2BAN5YvjOlh2Ip0Wr485Xk9fLxqrR
	nulo8emBb+xLrmPYRzJ93dcTt2QOtB6iLtKFuIs/D33xo=
X-Gm-Gg: ASbGncvbkMYAReg5cKXW4kp0hlavfcP3id8kwSbB2KxWn/GZ24IwlUQXZ6XyzCibU6a
	WNFWw2ShnrxtFIwGrk5O2r0pGHEg+Tukuwz2MWNuuCYU7FzsnubiN/SDDgThRF14mlZG+ntA/CL
	E2WK4RNOL2i8WbxFPaoyyx
X-Received: by 2002:a17:902:e80b:b0:23d:fa9a:80ac with SMTP id d9443c01a7336-23fb301007emr176112825ad.16.1753699485531;
        Mon, 28 Jul 2025 03:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGODZrZzarte4tY8t89HGTfuHwdI2hA3Qr+hJBkgvY8q6wUrMo2LqqnI/zzbEdhnjWIiuWV00GlPG5lzDQE5Y4=
X-Received: by 2002:a17:902:e80b:b0:23d:fa9a:80ac with SMTP id
 d9443c01a7336-23fb301007emr176112435ad.16.1753699485043; Mon, 28 Jul 2025
 03:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-2-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 28 Jul 2025 12:44:08 +0200
X-Gm-Features: Ac12FXxtGjHjLhIthLNnPnIq8tmViprM07UqeWy1lt5gfrSNfsIeRw18bBK4m7U
Message-ID: <CAJaqyWc7MjDcJfVAu+8srBn9T+0iQTmpWX+CKX0YVoip-FebaA@mail.gmail.com>
Subject: Re: [PATCH V4 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cYiKxeKqvtbM9NrzxqijSdFbgkmdJzBAsqtVKZSBRgs_1753699486
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 11:16=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> This patch consities virtqueue point for DMA helpers.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  include/linux/virtio.h       | 12 ++++++------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f5062061c408..103bad8cffff 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>   *
>   * return DMA address. Caller should check that by virtqueue_dma_mapping=
_error().
>   */
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *p=
tr,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, v=
oid *ptr,
>                                           size_t size,
>                                           enum dma_data_direction dir,
>                                           unsigned long attrs)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api) {
>                 kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), =
size, dir);
> @@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs)=
;
>   * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
>   *
>   */
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t =
addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> +                                     dma_addr_t addr,
>                                       size_t size, enum dma_data_directio=
n dir,
>                                       unsigned long attrs)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api)
>                 return;
> @@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs)=
;
>   *
>   * Returns 0 means dma valid. Other means invalid dma address.
>   */
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api)
>                 return 0;
> @@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
>   *
>   * return bool
>   */
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (!vq->use_dma_api)
>                 return false;
> @@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
>   * the DMA address really needs to be synchronized
>   *
>   */
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq=
,
>                                              dma_addr_t addr,
>                                              unsigned long offset, size_t=
 size,
>                                              enum dma_data_direction dir)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct device *dev =3D vring_dma_dev(vq);
>
>         if (!vq->use_dma_api)
> @@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range=
_for_cpu);
>   * Before calling this function, use virtqueue_dma_need_sync() to confir=
m that
>   * the DMA address really needs to be synchronized
>   */
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *=
_vq,
>                                                 dma_addr_t addr,
>                                                 unsigned long offset, siz=
e_t size,
>                                                 enum dma_data_direction d=
ir)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       const struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct device *dev =3D vring_dma_dev(vq);
>
>         if (!vq->use_dma_api)
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index dd98cc2b8c18..f2dbd18a2b2e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -264,18 +264,18 @@ void unregister_virtio_driver(struct virtio_driver =
*drv);
>         module_driver(__virtio_driver, register_virtio_driver, \
>                         unregister_virtio_driver)
>
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *p=
tr, size_t size,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, v=
oid *ptr, size_t size,
>                                           enum dma_data_direction dir, un=
signed long attrs);
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t =
addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_a=
ddr_t addr,
>                                       size_t size, enum dma_data_directio=
n dir,
>                                       unsigned long attrs);
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t =
addr);
>
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_=
addr_t addr,
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t add=
r);
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq=
, dma_addr_t addr,
>                                              unsigned long offset, size_t=
 size,
>                                              enum dma_data_direction dir)=
;
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, d=
ma_addr_t addr,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *=
_vq, dma_addr_t addr,
>                                                 unsigned long offset, siz=
e_t size,
>                                                 enum dma_data_direction d=
ir);
>
> --
> 2.47.3
>

