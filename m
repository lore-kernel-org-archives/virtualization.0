Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86940208D7
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597116; cv=none; b=ZU7Ih+J9sfgIgq7sDSE7ZUYGZde8rWknnWMRdUNn5j74FrDUg4s2iMXnyV/EbAQ3bywrR32V1F5B+KAoTeAAQxvFw/Ooi1T2Lase0M5aSIPOJJBX/cYsJA+LXC87BX3cHYvJ/heWgxJ9qiB8ACNjKeMUeNzAkBqK6qt7+R/XHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597116; c=relaxed/simple;
	bh=ZcyTqy+lMg2R0u6jr+lP1ejhIChizmbUSMh8y7o+oHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDWpgxZCUmOBCQts2Cp+QbzkHcKK8Ti7NhhNJSGdFQErdvuZvE5FTqqI4D5TKqBbPFTAMxlCVZlZyczvkusF/8LcB+9Vdp/ciD75g28QMWJ+gpA0mPn/iJ+g6uQxgKVPmoaHsSMCEOaxaLg9z6NHuyfUxIMBX4Uc2q9qZU5kbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Exfmt9fk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Exfmt9fk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737597113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V09D+KKA5Dgw5rUKPJ691xHkgwz9//N9bqe9oIBAWgo=;
	b=Exfmt9fkwDFJhjJkc4axzQutvviOZw2vpB0CgMAQdreLHAhK+LtwbxhBgTTmNct5GByoIr
	FGeiPdaUsrjheBpBKoheHkL76EGVwjxN1udWKvmaMBOOP0eHE+OwfrnQRcTfDb+f5tfkJx
	A9Q8KBiQcKcKpgE51kpVkxvT7iN0UeM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-EV4hXGPsNCCMCJkNLKAy3g-1; Wed, 22 Jan 2025 20:51:48 -0500
X-MC-Unique: EV4hXGPsNCCMCJkNLKAy3g-1
X-Mimecast-MFC-AGG-ID: EV4hXGPsNCCMCJkNLKAy3g
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166a1a5cc4so7017685ad.3
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737597107; x=1738201907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V09D+KKA5Dgw5rUKPJ691xHkgwz9//N9bqe9oIBAWgo=;
        b=HOFqBy34Q3xG4B9zFMCM77YMZqMXjgoBMfWbPrUHoHOmoKnvTumfXBqD6MYoymLkEk
         FA7uQ5ytGI4Ew6nS+Ju3JLR+hh4i3Qn5IC7B/33StZ55qQcPPBgLWGdUXRseyMptaV7S
         iJ1jvNgPcVROHZkZY09Yqajo6koIhhSgh/jzcbfX2swLgk3hrWjbUJGUbyBhgOGQQZOj
         A4M9ZdoQoXEwC9+Bhh8I0GBcp6T3FeFgz9Uz0/J8qtqheJCBOslQfrYIKDJvZZFK6LC5
         yAZJRfNB32FTuOSc5Ot24VMJ8xrVKJe2jrLU78/9hnch5S2Lu6+O/mxyyMqIBVqF1sEZ
         lYGw==
X-Forwarded-Encrypted: i=1; AJvYcCUNWJM6tPV9CEpdw7+pj0tWen/4ZXnrj19ffF7rMbUQ/aPsnnYUb99OZWOtl7RGLkzt1YmZJ4HM0r+kDfULGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnmKK/mvqslUOsylHJizhgEkJrEJeYlWU7/AvCdozj1LyrwNUt
	fRL2hunnQZf78PWmVd+CGSC+em1trzKtCQudNGWzC/+//XtTLUcgJI1VeL24+hGjPvQya9Fu5rP
	I66ZFLYv2w4rsIBVpUmZI/cih8Aqg9UrluuqJdj6zu812qOqoZRAxCD615+9m9ZAWczRLFInzg+
	H32OzkeMQuuFnbFHMyy2iR33V/U1f2EU0bz8ZvIkg=
X-Gm-Gg: ASbGnct7jnRN578P6T/KIRH63p5waRv8JuSUtIyeaDLOuAHmNLsR7TpHHv6DmuujCML
	LQIUK+64fOYuID8Kl/f3lcxuFCvujZWBXpFxsa/FqdDxpSL5DDA==
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id d2e1a72fcca58-72dafbdacadmr35789268b3a.21.1737597107077;
        Wed, 22 Jan 2025 17:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpT71OuH7ttb0KyESH3qemQI1oIg5xRpgPRbug2riFyJ6Dx5Oq9eHw2z5+bxRD+btSWAgxYLMXZdYu6oaYltE=
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id
 d2e1a72fcca58-72dafbdacadmr35789240b3a.21.1737597106648; Wed, 22 Jan 2025
 17:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-3-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:51:17 +0800
X-Gm-Features: AbW1kvYvUN0njsyvnqkMiTaL7m11XfaDtOBivX4-up_uqkmnnMPgszT6vhqc43g
Message-ID: <CACGkMEt8djYRdSvwBK7QGoNV1iG-8nafOox0=pt6ix1m0NOZtA@mail.gmail.com>
Subject: Re: [RFC 2/5] virtio_ring: introduce virtqueue_map/unmap_sgs()
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ba2C1Zj0tmVbU4yFTC2WVDBoVtTsNAfC2GrAKha9FCk_1737597107
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> From: Jason Wang <jasowang@redhat.com>
>
> Introduce new virtqueue DMA operations which allows the drivers that
> want to make use of the premapping API but operate at the sg level.
>
> Note that we still follow the assumtions if virtqueue_add() so
> dma_map_sg() is not used. This could be optimized in the future.
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> --
> Eugenio's changes: Remove blank
> TODO: Should we call directly dma_map instead of this? XDP do the direct
> call.

Note that we should have an indirection layer as the device is not
necessarily DMA capable.

And we probably need to rename the virtqueue_dma_map_XXX() to
virtqueue_map_XXX()

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 128 +++++++++++++++++++++++++++++++----
>  include/linux/virtio.h       |  10 +++
>  2 files changed, 125 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a..05729bc5cbb1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -359,6 +359,26 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +static int __vring_map_one_sg(const struct vring_virtqueue *vq,
> +                             struct scatterlist *sg,
> +                             enum dma_data_direction direction,
> +                             dma_addr_t *addr)
> +{
> +       /*
> +        * We can't use dma_map_sg, because we don't use scatterlists in
> +        * the way it expects (we don't guarantee that the scatterlist
> +        * will exist for the lifetime of the mapping).
> +        */
> +       *addr =3D dma_map_page(vring_dma_dev(vq),
> +                           sg_page(sg), sg->offset, sg->length,
> +                           direction);
> +
> +       if (dma_mapping_error(vring_dma_dev(vq), *addr))
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr,
> @@ -383,19 +403,7 @@ static int vring_map_one_sg(const struct vring_virtq=
ueue *vq, struct scatterlist
>                 return 0;
>         }
>
> -       /*
> -        * We can't use dma_map_sg, because we don't use scatterlists in
> -        * the way it expects (we don't guarantee that the scatterlist
> -        * will exist for the lifetime of the mapping).
> -        */
> -       *addr =3D dma_map_page(vring_dma_dev(vq),
> -                           sg_page(sg), sg->offset, sg->length,
> -                           direction);
> -
> -       if (dma_mapping_error(vring_dma_dev(vq), *addr))
> -               return -ENOMEM;
> -
> -       return 0;
> +       return __vring_map_one_sg(vq, sg, direction, addr);
>  }
>
>  static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
> @@ -526,6 +534,100 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
>         return next;
>  }
>
> +void virtqueue_unmap_sgs(struct virtqueue *_vq,
> +                        struct scatterlist *sgs[],
> +                        unsigned int out_sgs,
> +                        unsigned int in_sgs)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       struct scatterlist *sg;
> +       int n;
> +
> +       for (n =3D 0; n < out_sgs; n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       dma_unmap_page(vring_dma_dev(vq),
> +                                      sg_dma_address(sg),
> +                                      sg->length,
> +                                      DMA_TO_DEVICE);
> +               }
> +       }
> +
> +       for (; n < (out_sgs + in_sgs); n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       dma_unmap_page(vring_dma_dev(vq),
> +                                      sg_dma_address(sg),
> +                                      sg->length,
> +                                      DMA_FROM_DEVICE);
> +               }
> +       }
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_unmap_sgs);
> +
> +int virtqueue_map_sgs(struct virtqueue *_vq,
> +                     struct scatterlist *sgs[],
> +                     unsigned int out_sgs,
> +                     unsigned int in_sgs)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       int i, n, mapped_sg =3D 0;
> +       struct scatterlist *sg;
> +
> +       for (n =3D 0; n < out_sgs; n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       dma_addr_t addr;
> +
> +                       if (__vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &ad=
dr))
> +                               goto unmap_release;
> +
> +                       sg_dma_address(sg) =3D addr;
> +                       mapped_sg++;
> +               }
> +       }
> +
> +       for (; n < (out_sgs + in_sgs); n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       dma_addr_t addr;
> +
> +                       if (__vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &=
addr))
> +                               goto unmap_release;
> +
> +                       sg_dma_address(sg) =3D addr;
> +                       mapped_sg++;
> +               }
> +       }
> +
> +       return 0;
> +
> +unmap_release:
> +       i =3D 0;
> +
> +       for (n =3D 0; n < out_sgs; n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       if (i++ =3D=3D mapped_sg)
> +                               goto out;
> +                       dma_unmap_page(vring_dma_dev(vq),
> +                                      sg_dma_address(sg),
> +                                      sg->length,
> +                                      DMA_TO_DEVICE);
> +               }
> +       }
> +
> +       for (; n < (out_sgs + in_sgs); n++) {
> +               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +
> +                       if (i++ =3D=3D mapped_sg)
> +                               goto out;
> +                       dma_unmap_page(vring_dma_dev(vq),
> +                                      sg_dma_address(sg),
> +                                      sg->length,
> +                                      DMA_FROM_DEVICE);
> +               }
> +       }
> +out:
> +       return -ENOMEM;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_map_sgs);
> +
>  static inline int virtqueue_add_split(struct virtqueue *_vq,
>                                       struct scatterlist *sgs[],
>                                       unsigned int total_sg,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index dd88682e27e3..28db998d691e 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -67,6 +67,16 @@ int virtqueue_add_outbuf_premapped(struct virtqueue *v=
q,
>                                    void *data,
>                                    gfp_t gfp);
>
> +int virtqueue_map_sgs(struct virtqueue *_vq,
> +                     struct scatterlist *sgs[],
> +                     unsigned int out_sgs,
> +                     unsigned int in_sgs);
> +
> +void virtqueue_unmap_sgs(struct virtqueue *_vq,
> +                        struct scatterlist *sgs[],
> +                        unsigned int out_sgs,
> +                        unsigned int in_sgs);
> +
>  int virtqueue_add_sgs(struct virtqueue *vq,
>                       struct scatterlist *sgs[],
>                       unsigned int out_sgs,
> --
> 2.48.1
>

