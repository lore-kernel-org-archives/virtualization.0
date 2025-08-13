Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE12BE045
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069320; cv=none; b=CRV1Dh09UGDF+/3UlhfLgoHdFqZxAXunftCCNK3+FSDOX4GUgb+nP72Z/YuxgPE9tWvNrqq5WlL6sigF1MGtqIAdlFuxQmNtIwThckfPRWFom1OD4fHIyDJ8ezjDXXNWR+xu0BM6fpti1TMCU0pkFDKibwzLG+tg0HNw9zEtV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069320; c=relaxed/simple;
	bh=y26v0V7s3iGAuBSrKXUAstUvcTB+s5bChxCunkbC0r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m43Z6ID4Rgs6KtxjXUpACkaNosYaqzdvXQ5AS4fkUMIPXRyPtT4TYYVYEcXKM1bjahGBtMhY9C2xNWyNI+gw9l3boPnYAgy5GXemDhSqmb+zMn+WlyqvFho7QX/lq8NGPVZ/emuWC4uCj4NGFJmtSsaK8UnikwqR1itsz2cN/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZViytRmp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZViytRmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755069317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j22/vlxbgZewQq+2BkVTztlbPB3/Pt1Gm8og/omOcJs=;
	b=ZViytRmpEfxL8W3O1GatpJpKkhVAcv/taeblBtVt3ZxkZMsEbZZoOH1uBI0bn6bm/r0uUk
	yk3tckbES1XHCthLMgnNJxrhtNS2xmgnt+/tsm0WhuKx5wJH2oQf26N6WDmO2ZKaP1sD0N
	p6IghXSiCxXcHJ5eHsYEmeV6kyNDNY4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-TSvk4BwiONOJCvIhOUGXJQ-1; Wed, 13 Aug 2025 03:15:14 -0400
X-MC-Unique: TSvk4BwiONOJCvIhOUGXJQ-1
X-Mimecast-MFC-AGG-ID: TSvk4BwiONOJCvIhOUGXJQ_1755069313
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4293085605so6000458a12.2
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 00:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069313; x=1755674113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j22/vlxbgZewQq+2BkVTztlbPB3/Pt1Gm8og/omOcJs=;
        b=bEmpqxPlTg8WmbCMaQSyqKbDnbpekfooa1wvz8WPrRYkN26POOeqn/RuOkY8cESmrH
         VAroZnaCjZxJ1GonbzUn8wb+3OcTU6z5vnyQpheGZTiuxneiYXVcJFjvOU6qOx6veHia
         c320WsdZrrJxmbAhSYXW3NwF4DFGop7WMIzgswnA3EQCR9JuxX4Par3cYx6875f1IM9G
         SqG91fU1OhrcJiBycUrutwqGH08c5BOilPQBjzkpjob/5epLTYVP1Kg6R81Rl8bTTYvx
         MfrU7+gBFVeV8Nf7nykkmfZSoKk5nQL7V+hfrqaE6X8EoB7Xe5oQC43YDeegluzh6ET3
         ABew==
X-Forwarded-Encrypted: i=1; AJvYcCW2jQxE9KA3NiyTMnsc5B5SBlocq0b3WofMoxHjPrVIv+HypgmjDuFYL/n7nJKFxWtmP1U9ESwQHcEIyljnaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAxZvqr8GxWQRS0UZOvcCWwrMe0+7ZF7ra/Zc6es/WTJzuDP3a
	Xgw9tLN+l8uACiMQXOjlHYQgWYc2GUIm0pE9HI1rbtCJP+pQ+63jap9MMOi0FU5zQtJcKTx8X5z
	lCRueg35m/ZPkN07EaJMYYt4xS0HUN+6QEF65p6rXtEnRQji96mci+2hdYM0N1ocCxYWv9wSSf1
	idh4cIDf3zxssWdGm69TRG2IU+dK538PtBkS+i9MsyBe4=
X-Gm-Gg: ASbGncvmAdBoYhNosGzbfZk3UjPo5hjjxOfxGuRST3hbqmzCgtbsAC0GnpThoxzjUpQ
	ARpnUattVta19NJbwU9afVimmkuTpE4490hmy1NK0ZY4uzMpEzhPXlsXjqPF/yFnnR41RyhyfUg
	F/kA4H17MD5QATc3MTfIPlajmbfF+O0VMPDu1ZJwTMAxKy+OWfuViyrEw=
X-Received: by 2002:a17:902:ec85:b0:23f:ecf6:463b with SMTP id d9443c01a7336-2430d224901mr35063755ad.45.1755069312919;
        Wed, 13 Aug 2025 00:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF48cGlFDnLEX9VoOq+NnLcpHQcDjQviYJ0rwpDN3nUccZ4JSexKB+sW1cyJ9IoDV1jj64zMumFmb3K72xCJSc=
X-Received: by 2002:a17:902:ec85:b0:23f:ecf6:463b with SMTP id
 d9443c01a7336-2430d224901mr35063355ad.45.1755069312478; Wed, 13 Aug 2025
 00:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-2-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:14:36 +0200
X-Gm-Features: Ac12FXz2yP8POKqHq5p9pzviM2xNHLsxaW7X3Xm17rGiZUFa5EQ7EQVenYKJjm4
Message-ID: <CAJaqyWcuMVz6eTbwcCDd=F1gqyXmQOZRD=1ronWAqke5xa01Mw@mail.gmail.com>
Subject: Re: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA helpers
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oz9ixHzQhzHBsw4P4TVFpAAZSwzs_8ARhYTG5CSvq5c_1755069313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch consities virtqueue point for DMA helpers.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

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
> index 8b745ce0cf5f..cf8def717dfd 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver =
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
> 2.31.1
>

