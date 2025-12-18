Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B77E0E8
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766036759; cv=none; b=WkXcvzqHdDYPrKnOX34iBxvRdohvkBT3ZgRcevbKMFVygcoWHDno8+CFQC4CobeCg2vvUuK1VbMVu5be8geyBMW63//x0TX2bcRnm5tH02lJxCOhaLnTk32yH+RJ4ulcq+mq+teI/yUEv+lL7flq9K+FXsCK94cM0eS1tBiaH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766036759; c=relaxed/simple;
	bh=z35jAeKC07ZKa+7m0AimahoaQoQCv5xLkDW5308tvkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGPZjp0Qq5TOAy6jKTmvRTfrKuU648oxrTiQkWV7P5eHiiuBnSy9OOQB1eJc80sn/Lyyhb0rFmReMkudB/oM9MyWuuAWWo7AIaIkymKOVXQ/B98X9TnfpBO2clTBHDJytkYWe3k30Ai+p4UyrMOeNSY41wzteXLxZcB2GXREyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcfnaj5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcfnaj5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766036756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zilHxbX++7A3WYZmqPdwNnQg5K+ZjS8YCq4tdIAhwp4=;
	b=gcfnaj5XNhs3f4Vo6X1MDbvHf9T4wYKqNcAKN/CzEj006woIcXzOrVxmXyD/f/p1qyCMVT
	jUUv/aMkYHshoGXnz9iiiH5ty1WQ4HHJFE1eM6KVAm8lB6uq1vQbEA+pj/PoIEizUy6Z5A
	Cl2EHoBrVSUCa98fIyyNX99fdybatAM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-lhyM-nNNMvGI-_U-SzGHKw-1; Thu, 18 Dec 2025 00:45:53 -0500
X-MC-Unique: lhyM-nNNMvGI-_U-SzGHKw-1
X-Mimecast-MFC-AGG-ID: lhyM-nNNMvGI-_U-SzGHKw_1766036753
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so301354a91.3
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 21:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766036753; x=1766641553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zilHxbX++7A3WYZmqPdwNnQg5K+ZjS8YCq4tdIAhwp4=;
        b=v1tg/+mxm/mI3xAYAdXpYtLQtVECDLfGGFHkbSrXbps9+DxZ9XuoXeA//fxWIxPE6Y
         ggZtVS7VvqrkBrAs7jSQQj4sL83Bl62sJ5DvgIe6naJ1JtOnw5U5d+Ohx4Xi0kffW5dx
         6E2pcCuL0KsgT+FEQ4BA6AXKHfOa9/8/DwRNMV0BUmXmCNB6GQnz4Gugl2mOZsgxSKri
         wZw4b9nfGzZtgjUngn5E17J0siCan5fBxS0TAIC0NXk4E3EdVGft/VsYjGsw1m1pmA/V
         Q8qzYJVdbKC5dxOuE9C+SFY9b5oxDSLyULwoOwp/CBpKF78BY5o1NeJfHUlic7jBzV4V
         wU6A==
X-Forwarded-Encrypted: i=1; AJvYcCVS5hLJJbU8hMr+Ez+c9YMoBNfTbY66jiLpDKuafDFWBfAE1Z7JTr03zQjmqnuYRAUGReHQ7cuP0FKlzIMZhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP/MtwFpDJTD1LxDQc2tV40/XN58IjKR9vBOvnJbCgqREfAEb8
	FTzcarO7SYFUNudDXmsCsAiJwaJyzBDosfnAjlS9iyCYbEI0tcY5Vu9Cjm5IBcI9GIRYSucFfQL
	4BExTSU6Dh0Db6disz7ec2tiYVvzYbxBZe/1Wxw8cZh6oyYheLRe1yc1a7jXFogXPoi8yfU3raT
	mSVEAq8XYrF+XJiGTxEBlw7cNC1KONzUknAbHWgCXTa9U=
X-Gm-Gg: AY/fxX4m4zwbz4IjW9eQf+Bv8DlP8IvOFmWzoMK2eJ4w3UnPQOaN2TIQ4uwLgpOWo+K
	M23oqTEbalMO2llJKBbMq+Kqh4nvzFOuSQa6poezVKeMd0TKHEsxcCNPVZuIMWUEDsVz1+3fPEj
	kE9Wc707GHBNK+1nENInrbxEtqatd5kOo//zvBilzmJYSXhlBuGGFrevkOko2utwV31oU=
X-Received: by 2002:a17:90b:3d0e:b0:341:2141:df76 with SMTP id 98e67ed59e1d1-34abd7be2c2mr17906092a91.13.1766036752771;
        Wed, 17 Dec 2025 21:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3NHYyFYFFZ9LyKH62+cqB38iTzdzfJIaN3cNpVtVkeeO2dW3r9jfvBHIS3nivh6T0P3+UyJiB9J8s6y6YV/g=
X-Received: by 2002:a17:90b:3d0e:b0:341:2141:df76 with SMTP id
 98e67ed59e1d1-34abd7be2c2mr17906079a91.13.1766036752356; Wed, 17 Dec 2025
 21:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251217112414.2374672-1-eperezma@redhat.com> <20251217112414.2374672-7-eperezma@redhat.com>
In-Reply-To: <20251217112414.2374672-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Dec 2025 13:45:41 +0800
X-Gm-Features: AQt7F2roKorGu5-JWJ_7C9k4iA2RQfWKACZpPLO9l8A8-VzspWFfDxTtQmeYJmQ
Message-ID: <CACGkMEsD9h34yAQxZnOnAGZpnxV2Up7ghxdrsfiWE0VY-OCM6w@mail.gmail.com>
Subject: Re: [PATCH v10 6/8] vduse: take out allocations from vduse_dev_alloc_coherent
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lrLU_JYlrGRAAxogc3tIAfQhIoAJl5ht15tPNExM9GY_1766036753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:24=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> The function vduse_dev_alloc_coherent will be called under rwlock in
> next patches.  Make it out of the lock to avoid increasing its fail
> rate.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/iova_domain.c |  7 ++-----
>  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 13 +++++++++++--
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_use=
r/iova_domain.c
> index 309cd5a039d1..0ae52890518c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -495,14 +495,13 @@ void vduse_domain_unmap_page(struct vduse_iova_doma=
in *domain,
>
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>                                   size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag)
> +                                 void *orig)
>  {
>         struct iova_domain *iovad =3D &domain->consistent_iovad;
>         unsigned long limit =3D domain->iova_limit;
>         dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, limit);
> -       void *orig =3D alloc_pages_exact(size, flag);
>
> -       if (!iova || !orig)
> +       if (!iova)
>                 goto err;
>
>         spin_lock(&domain->iotlb_lock);
> @@ -519,8 +518,6 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_d=
omain *domain,
>         return orig;
>  err:
>         *dma_addr =3D DMA_MAPPING_ERROR;
> -       if (orig)
> -               free_pages_exact(orig, size);
>         if (iova)
>                 vduse_domain_free_iova(iovad, iova, size);
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_use=
r/iova_domain.h
> index 42090cd1a622..86b7c7eadfd0 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -69,7 +69,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *=
domain,
>
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>                                   size_t size, dma_addr_t *dma_addr,
> -                                 gfp_t flag);
> +                                 void *orig);
>
>  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t=
 size,
>                                 dma_addr_t dma_addr, unsigned long attrs)=
;
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index a278cff7a4fa..767abcb7e375 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -924,16 +924,24 @@ static void *vduse_dev_alloc_coherent(union virtio_=
map token, size_t size,
>         if (!token.group)
>                 return NULL;
>
> +       addr =3D alloc_pages_exact(size, flag);
> +       if (!addr)
> +               return NULL;
> +
>         vdev =3D token.group->dev;
>         domain =3D vdev->domain;
>         addr =3D vduse_domain_alloc_coherent(domain, size,
> -                                          (dma_addr_t *)&iova, flag);
> +                                          (dma_addr_t *)&iova, addr);
>         if (!addr)
> -               return NULL;
> +               goto err;
>
>         *dma_addr =3D (dma_addr_t)iova;
>
>         return addr;
> +
> +err:
> +       free_pages_exact(addr, size);
> +       return NULL;
>  }
>
>  static void vduse_dev_free_coherent(union virtio_map token, size_t size,
> @@ -950,6 +958,7 @@ static void vduse_dev_free_coherent(union virtio_map =
token, size_t size,
>         domain =3D vdev->domain;
>
>         vduse_domain_free_coherent(domain, size, dma_addr, attrs);
> +       free_pages_exact(vaddr, size);

There looks like a double-free as there's another free_page_exact() in
vduse_domain_free_coherent.

Thanks

>  }
>
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
> --
> 2.52.0
>

