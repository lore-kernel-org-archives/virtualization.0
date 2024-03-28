Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83844654B
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612706; cv=none; b=qSlzpAZnooNYIh5S7X+iYLQDmMs8MoVPzkUU/n41H2EbrR8McoUIMZIqQJh49UE+PO7oRK5Rc/PeXrwpfBAssM39ckg4pyfW4H4r1ghbgUcZEisrayLQMt/EXE5LMfstVUPKg+SzOta7GggKX7N0OmNVe1qUZu72xbhrA5wzYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612706; c=relaxed/simple;
	bh=wgar9MFt+ebTKBR0AhWjQsDpdIJDQJ/4kaniC1csFIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuc+9U56ljuLZMStzFGi73U2yDhcvihPEmPbsCEDhgUWKKrMNDzHdLdRbAMy4LnIOp/HqfUocUF+G2VRCLOlH0pwM0hW4JBs0c0rK4tjYSFtmZtGw0eMH4o1HONyohp4o3qeY3NyXiA0owWboRR7TyoT+wJ5nVm6Lwx1VEcdOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ddl8Djyq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ddl8Djyq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711612702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/6Ik9J8vGv/Si18wlwWefqXsxMxZ3gle8zHK3RoExc=;
	b=Ddl8DjyqSgjQ/yTN12ubNCZErQGiuGGwWtWea766+qUNXItBbmLpUUwhbTm1GO7zLEAjrn
	+YFc8ZnYu/rhAS26dQTEmW2VR9HZm/0aDgKDSYaxP90BvWOF85tA2FZA2BHPRM1fz0dXF7
	ZXpOEujGHlhHNGb69ETGdiKogrOfI9c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-ofFunOgmPgGAZYm857pdrw-1; Thu, 28 Mar 2024 03:58:21 -0400
X-MC-Unique: ofFunOgmPgGAZYm857pdrw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29de8002b0bso584007a91.3
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 00:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612700; x=1712217500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/6Ik9J8vGv/Si18wlwWefqXsxMxZ3gle8zHK3RoExc=;
        b=VzvFQMiknO0/t6/q4qjP8JT94N8xC8ZwjflerIeYeOuZzvV45xRML/Mdc1UBtLOCtT
         qnROM0FOH7YkR9iLsYlBOBLWYOcBY0MIycA6Mjor5xROWpcViy1KvO1wkNSWPt5/JmOH
         5GkXYZwttvcgdBkDWBlcG3Att7FHtpVITdCQlhotWJh3X0GIKY0Z7qOM+wRsBVKgdpHS
         PzQ7nD3EocSpyz535yQwjX1nkK3wdDXisdiF+8pF8pIzVpSOuGBEiHGwyyvhgMBBzqDm
         7/yaLEX00ZiSCOcOn2cBfFkmvgHBAHA1s+m6dVEauKK2xSPM7M3zxoLswc2EldROq6R2
         d98g==
X-Gm-Message-State: AOJu0Yy5rcxNIQfRW3g1eR/6DFE19lHEQJ+E4jRbpn2n3ftDVgprApBA
	ufhpLoDA7U4uML7rQGiNVquWzVYd8giidXBL9X532MeDbkNisekvzhryi9UyBBXnncvToY7v7nf
	IR+2CsnX5Q7Tk9uipgCiLKiINQdU0gVOHfIHwp25V5KM37NC3tAffCkom2mj3+C10dj6tCI/UhJ
	aBdZ7LYaHmSC4v/69CTpPnQlFdwoDo8txsA76x4fRQEiEO73I=
X-Received: by 2002:a17:90a:4586:b0:29c:7592:febf with SMTP id v6-20020a17090a458600b0029c7592febfmr1690148pjg.16.1711612699663;
        Thu, 28 Mar 2024 00:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFblJp9w0pny5TjOhPfMS/kOyIQGBRDXwLRHifvEJFIeWVGOgBsTHymmXZIkSJ83ttYn4rXXzxGFePsKH9/fyA=
X-Received: by 2002:a17:90a:4586:b0:29c:7592:febf with SMTP id
 v6-20020a17090a458600b0029c7592febfmr1690136pjg.16.1711612699330; Thu, 28 Mar
 2024 00:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:58:08 +0800
Message-ID: <CACGkMEv9YCaWAPhcFcLkHaHMz-A6mHyM3pqHjYKooEpNkFn0CQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/10] virtio_ring: export premapped to driver by
 struct virtqueue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Export the premapped to drivers, then drivers can check
> the vq premapped mode after the find_vqs().
> Because the find_vqs() just try to enable the vq premapped mode,
> the driver must check that after find_vqs().

What's the reason for this? For example, we never export use_dma_api.

Thanks

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 13 +++++--------
>  include/linux/virtio.h       |  1 +
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index bbdeab3a9648..543204e26c5a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -177,9 +177,6 @@ struct vring_virtqueue {
>         /* Host publishes avail event idx */
>         bool event;
>
> -       /* Do DMA mapping by driver */
> -       bool premapped;
> -
>         /* Head of free buffer list. */
>         unsigned int free_head;
>         /* Number we've added since last sync. */
> @@ -297,7 +294,7 @@ static bool vring_use_dma_api(const struct virtio_dev=
ice *vdev)
>
>  static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
>  {
> -       return vring->use_dma_api && !vring->premapped;
> +       return vring->use_dma_api && !vring->vq.premapped;
>  }
>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev)
> @@ -369,7 +366,7 @@ static struct device *vring_dma_dev(const struct vrin=
g_virtqueue *vq)
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
>  {
> -       if (vq->premapped) {
> +       if (vq->vq.premapped) {
>                 *addr =3D sg_dma_address(sg);
>                 return 0;
>         }
> @@ -2148,7 +2145,7 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(struct virtio_device *vde
>         vq->packed_ring =3D true;
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> -       vq->premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, premappe=
d);
> +       vq->vq.premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, prema=
pped);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !cfg_vq_get(cfg, vq, ctx);
> @@ -2696,7 +2693,7 @@ static struct virtqueue *__vring_new_virtqueue(stru=
ct virtio_device *vdev,
>  #endif
>         vq->dma_dev =3D tp_cfg->dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> -       vq->premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, premappe=
d);
> +       vq->vq.premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, prema=
pped);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !cfg_vq_get(cfg, vq, ctx);
> @@ -2832,7 +2829,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_=
vq)
>                 return -EINVAL;
>         }
>
> -       vq->premapped =3D true;
> +       vq->vq.premapped =3D true;
>
>         if (vq->packed_ring) {
>                 kfree(vq->packed.desc_dma);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b0201747a263..407277d5a16b 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -36,6 +36,7 @@ struct virtqueue {
>         unsigned int num_free;
>         unsigned int num_max;
>         bool reset;
> +       bool premapped;
>         void *priv;
>  };
>
> --
> 2.32.0.3.g01195cf9f
>

