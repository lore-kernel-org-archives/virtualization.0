Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097F17983
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRfC5WLt"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4FA442149
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4FA442149
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dRfC5WLt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQA02QOifKdI
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 03:21:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B7EB42147
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B7EB42147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703128873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7RplKxHmoUaZQ1WRbtsZPTOj4P+VwsEvlf1FVkUjqA=;
	b=dRfC5WLtFru6CueI4mv2NfU6Y3cIUOBguaHHwawPUzN2Gx7Xxy3UslSbk/mHMWaVwcWnAM
	+PyArOoPXVcYMO8Kzcw5zVbCak2C4o2X1IfdytsQnHslpDMIo9NySvMxUhkbvfqQwp9KYk
	1JfaTLc408E0DzNvO1g7Ee2TKMuoNTA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-w53jWoCgP--5i2U3mBjaVg-1; Wed, 20 Dec 2023 22:21:11 -0500
X-MC-Unique: w53jWoCgP--5i2U3mBjaVg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d87bcf8a15so448675a34.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 19:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128871; x=1703733671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7RplKxHmoUaZQ1WRbtsZPTOj4P+VwsEvlf1FVkUjqA=;
        b=kuEu1SaoAwB1ay0eCr37qw3wXVCbLuWBbhTMDgSRERYa6cT/S+ozpOEIpJyXE73dGZ
         4iSBtdOS1uocjcDHHXHspbw5HhE2280c7lNJuNDou9KyJeCScihj3/N0saewubmb9aZM
         qIdEOHxpt3pJE7VMc6hCcq/OQ+bZivzU8XoUe/fzvwuPbNcw7RecoZ1zamuNnHL+YKL3
         /gusS8q8acEcln0eKuxglT7WwBIzTBWtQpoJuVX01SE6teyvZyD0avyBzj0jYUtKO9Lw
         RoOQjFzuJfIHK6mvw5cXO5wYrszTFzDnegpHl0kWawvv5wz4DMJwKjfAPbCXTW08rr7g
         Usag==
X-Gm-Message-State: AOJu0YzgFbnsNwf+qS9LDtanZ/JNQlSlIAionKQrLstCMx/qjKY28uXb
	fQOa+0SPHr62d3YUoIewGmi8SpTG6qpX+Wkm+luqCFOGVSdt23mPPfK+CXP03dhagai9Vt23P1a
	HpZ5TwtD3Czrwz5uasCozmYsDPHzY4fhp4udzgc/VoQ7nkAqxJx8cAdO71w==
X-Received: by 2002:a05:6830:12c7:b0:6db:b072:2486 with SMTP id a7-20020a05683012c700b006dbb0722486mr1605289otq.8.1703128870831;
        Wed, 20 Dec 2023 19:21:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOjtEJfE8G7yRaT+b3Hj+ogf6sfq06Bhp+BAlKJMzGD2IFDGsXYlKarUwnQ4r9muGgyHd70GSa2UvGpyExbgQ=
X-Received: by 2002:a05:6830:12c7:b0:6db:b072:2486 with SMTP id
 a7-20020a05683012c700b006dbb0722486mr1605284otq.8.1703128870548; Wed, 20 Dec
 2023 19:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com> <20231207080353.6575-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231207080353.6575-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 11:20:58 +0800
Message-ID: <CACGkMEsHcAaJMUYGW8xpmgG+_XmiNkc2X5b1T-yJYRAPcrSC3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc. Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.
>
> Because the BAD_RING is called (that may set vq->broken), so
> the relative "const" of vq is removed.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Looks good overall. Minor comments.

> ---
>  drivers/virtio/virtio_ring.c | 170 +++++++++++++++++++++++++----------
>  include/linux/virtio.h       |  16 ++++
>  2 files changed, 138 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..3bcf3e6067af 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -362,6 +362,37 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +static bool get_dma_info(struct vring_virtqueue *vq,
> +                        struct virtio_dma_head *dma,
> +                        dma_addr_t addr, unsigned int length)

Rethink about the name, how about vring_need_unmap()?

> +{
> +       if (vq->do_unmap)
> +               return true;
> +
> +       /* Only premapped mode. we should return the dma info to driver.
> +        * If the use_dma_api is false, then do_unmap is false. But
> +        * we should not return the dma info to driver.
> +        */

It might be better to move this above this function? And we can
explain the return value there.

> +       if (!vq->premapped)
> +               return false;
> +
> +       if (!dma)
> +               return false;

It looks to me like it's better to check dma at the beginning.


> +
> +       if (unlikely(dma->next >=3D dma->num)) {
> +               BAD_RING(vq, "premapped vq: collect dma overflow: %pad %u=
\n",
> +                        &addr, length);
> +               return false;
> +       }
> +
> +       dma->items[dma->next].addr =3D addr;
> +       dma->items[dma->next].length =3D length;
> +
> +       ++dma->next;
> +
> +       return false;
> +}
> +
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
> @@ -440,12 +471,14 @@ static void virtqueue_init(struct vring_virtqueue *=
vq, u32 num)
>   * Split ring specific functions - *_split().
>   */
>
> -static void vring_unmap_one_split_indirect(const struct vring_virtqueue =
*vq,
> -                                          const struct vring_desc *desc)
> +static void vring_unmap_one_split_indirect(struct vring_virtqueue *vq,
> +                                          const struct vring_desc *desc,
> +                                          struct virtio_dma_head *dma)
>  {
>         u16 flags;
>
> -       if (!vq->do_unmap)
> +       if (!get_dma_info(vq, dma, virtio64_to_cpu(vq->vq.vdev, desc->add=
r),
> +                         virtio32_to_cpu(vq->vq.vdev, desc->len)))
>                 return;
>
>         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> @@ -457,8 +490,8 @@ static void vring_unmap_one_split_indirect(const stru=
ct vring_virtqueue *vq,
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> -static unsigned int vring_unmap_one_split(const struct vring_virtqueue *=
vq,
> -                                         unsigned int i)
> +static unsigned int vring_unmap_one_split(struct vring_virtqueue *vq,
> +                                         unsigned int i, struct virtio_d=
ma_head *dma)
>  {
>         struct vring_desc_extra *extra =3D vq->split.desc_extra;
>         u16 flags;
> @@ -474,17 +507,16 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>                                  extra[i].len,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vq->do_unmap)
> -                       goto out;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra[i].addr,
> -                              extra[i].len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +               goto out;
>         }
>
> +       if (!get_dma_info(vq, dma, extra[i].addr, extra[i].len))
> +               goto out;
> +
> +       dma_unmap_page(vring_dma_dev(vq), extra[i].addr, extra[i].len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +
>  out:
>         return extra[i].next;
>  }
> @@ -717,10 +749,10 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                 if (i =3D=3D err_idx)
>                         break;
>                 if (indirect) {
> -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> +                       vring_unmap_one_split_indirect(vq, &desc[i], NULL=
);
>                         i =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
>                 } else
> -                       i =3D vring_unmap_one_split(vq, i);
> +                       i =3D vring_unmap_one_split(vq, i, NULL);
>         }
>
>  free_indirect:
> @@ -763,11 +795,13 @@ static bool virtqueue_kick_prepare_split(struct vir=
tqueue *_vq)
>  }
>
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int he=
ad,
> -                            void **ctx)
> +                            struct virtio_dma_head *dma, void **ctx)
>  {
>         unsigned int i, j;
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
>
> +       WARN_ON_ONCE(vq->premapped && !dma);

Let's add a comment here as well as the packed version.

Thanks

