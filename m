Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBAE27280E
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069355; cv=none; b=QwpmCFeXeitgTqvLJkhvmD+lWE8P11Q9cZsUmOHcQCP1FIxb5aZJiGzvF8PtDa4kRZYclJYAwQOAQe11UEcCrsRAfbS2N51FjGEVq2UmBQ2suHCr7ZxcQAzF86Op9sh1PSjqQKexPmbQ0+b7uSzkM1/02NelhCTmJwDtoEd4eOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069355; c=relaxed/simple;
	bh=5tw3NG6slUe/9zPVFbDN/qPtARYE05vHQheAmJtyjTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McKQrvpi/Diok3jNz5siqD/gK+pfUpZZWxG0Aoogxr2e8ZtJ81Icj5K50hgpbrxYvjQNDfumznNwl8pSkpjlblDOJhaFqIIbhaMm9bnGvoiec840/P768bMJHF8+65VDHvi7qT+rqdtZyMsKrL8dsJZQX/ahliMQMt1g7oIHj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYKq1KW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYKq1KW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755069353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iUJDUKPSUZjqYyom4L2qT6NYz7XU0fw6XAj7TVQsKM=;
	b=JYKq1KW36RHMIXz4iG86qEkyrmj5nTvrI3VYokGmWJorTM5UM6T1WYq4C9nSAktP4sCFmy
	rEf/9ynUTqRm6mM/DqgwxH791R+m9vzvyufUgdaHQniq69WNjC4YgUamyzS6HXjlkDMQ+J
	BhfE9vKjHnJePAd4Mo80dMFlxVv9DRI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-glrfCHA0MhSjXoB2B-_S0g-1; Wed, 13 Aug 2025 03:15:52 -0400
X-MC-Unique: glrfCHA0MhSjXoB2B-_S0g-1
X-Mimecast-MFC-AGG-ID: glrfCHA0MhSjXoB2B-_S0g_1755069351
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so13252823a91.2
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 00:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755069350; x=1755674150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iUJDUKPSUZjqYyom4L2qT6NYz7XU0fw6XAj7TVQsKM=;
        b=gputu89wEA8doUpWSkdXb8tF0NoJV7x5P8XlHmajUkC4MHnnFGAk2XsR30e+n1lVFP
         6Tu0RM35NRhACckYmNRyOPQvVKWl5FH5eK4Z6NXOHX5fl6eh54GUTZb+xGp137/lYZK5
         IRMt3HZfIAcHf8nTTJIwN7qYC7JQO9d2Jv1fx/Y9qrt+J88XC1SK2Hm7UzyQLzd4JyLq
         a2bVuHYjsDBNxNFkT8vQUI8Vv5sqm2brHlVxxfMjb67pI+BwdCWMNJVw5TAj1UKU5Tw5
         0eiyjBvoRRCSq6A29dmsqK1cc9jz5QX4RXlC4ygZNdem/GVmDTe7TJhhXutjnNjkYVzX
         iXhA==
X-Forwarded-Encrypted: i=1; AJvYcCURJ8ixG7D5X2U9nGbtnZB8/xmq2D0mTcHZ8CAcEQYMhFYAI2GbidDq5z4R9clWc6+NkC6HQ/obkliRMgh8Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YylbkP6NJVa6GI1nwt5iLFkSGPeatQl5n+anjiWtQPe6qszQQBe
	01oaXYe4rs3EbUcGHbA8SnrxdvEUKtaCrZKlvOcqpXauEwHsvlEtVLfONNs5RvaJ/eWS7S1u7Mq
	xudVOCFtFXqq/GnsxayVlvc6XMC4ywJKxxq7dts9ucO7v31gutOwb7U0q9C08VzLfCSibYMnZDJ
	XYeCQiERerVeFWDZYd8rOXRhZg3ufSn0pOiDwHVh1BLkvg0xRZYEb6dA04
X-Gm-Gg: ASbGncs3pr30IxDn+8g0YkXQmGBGY4Qx0f4b0DrBXZ1FobVbSFKKdEsxU1bnQw70RUM
	1q++jpGVbt+bgK5cluZrqQRGKLdc4JbrO6rOksGSjbVsfplVvKmAO0C2HIZGYT+iY138m+F/Obz
	4jp5N6DSm6TfbQuRJVbsimW/zw+Kyo20Kd8gRiWCXLHCTm2A1BXIUlkq0=
X-Received: by 2002:a17:90b:53cc:b0:321:156f:5c00 with SMTP id 98e67ed59e1d1-321d0d32df0mr2827583a91.1.1755069350398;
        Wed, 13 Aug 2025 00:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG30aL8DwBd2J+i3dLK0+cgvalccG/++ETJ0dYYPaYe0fBSo3sd+UheN8wAZQUnUNpHKqYHmUQ3LLvORgIe82c=
X-Received: by 2002:a17:90b:53cc:b0:321:156f:5c00 with SMTP id
 98e67ed59e1d1-321d0d32df0mr2827554a91.1.1755069349963; Wed, 13 Aug 2025
 00:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-3-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:15:13 +0200
X-Gm-Features: Ac12FXwMYGAaWjAbPLrY3wGijOWbSZQBPgptXx-FzxARpLuCLXJ6Nod1sl-Fl6s
Message-ID: <CAJaqyWeMAVDD+vSNdtCb34Oeh8inAfzYDC4qqT4daqVttcowGw@mail.gmail.com>
Subject: Re: [PATCH V5 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s-wNO89VBOuhTqrLccJuYwLT7BRwaYfkBrMb4LaAOHQ_1755069351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch switches to use dma_{map|unmap}_page() to reduce the
> coverage of DMA operations. This would help for the following rework
> on the virtio map operations.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 103bad8cffff..75e5f6336c8d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -405,8 +405,8 @@ static dma_addr_t vring_map_single(const struct vring=
_virtqueue *vq,
>         if (!vq->use_dma_api)
>                 return (dma_addr_t)virt_to_phys(cpu_addr);
>
> -       return dma_map_single(vring_dma_dev(vq),
> -                             cpu_addr, size, direction);
> +       return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
> +                                             size, direction, 0);
>  }
>
>  static int vring_mapping_error(const struct vring_virtqueue *vq,
> @@ -451,22 +451,14 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>         if (flags & VRING_DESC_F_INDIRECT) {
>                 if (!vq->use_dma_api)
>                         goto out;
> +       } else if (!vring_need_unmap_buffer(vq, extra))
> +               goto out;
>
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr,
> -                                extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq, extra))
> -                       goto out;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr,
> -                              extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr,
> +                      extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>
>  out:
>         return extra->next;
> @@ -1276,20 +1268,13 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>         if (flags & VRING_DESC_F_INDIRECT) {
>                 if (!vq->use_dma_api)
>                         return;
> +       } else if (!vring_need_unmap_buffer(vq, extra))
> +               return;
>
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq, extra))
> -                       return;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr, extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr, extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int tota=
l_sg,
> @@ -3161,7 +3146,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const st=
ruct virtqueue *_vq, void *ptr
>                 return (dma_addr_t)virt_to_phys(ptr);
>         }
>
> -       return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, at=
trs);
> +       /* DMA must never operate on areas that might be remapped. */
> +       if (dev_WARN_ONCE(&_vq->vdev->dev, is_vmalloc_addr(ptr),
> +                         "rejecting DMA map of vmalloc memory\n"))
> +               return DMA_MAPPING_ERROR;
> +
> +       return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
> +                                 offset_in_page(ptr), size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
>
> @@ -3186,7 +3177,7 @@ void virtqueue_dma_unmap_single_attrs(const struct =
virtqueue *_vq,
>         if (!vq->use_dma_api)
>                 return;
>
> -       dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs)=
;
> +       dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
>
> --
> 2.31.1
>

