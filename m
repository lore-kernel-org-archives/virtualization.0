Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466113C9C4
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753673141; cv=none; b=theO1S0/jS9Q1Pamq5nJVWuQp9TueEuCioAMU8g2/PCelBeyXCeVrWHJzGWhil72rzaAbcoEhPlkQzlcVgj1jvori5E0oYqNjgYCKxOT9HAnKMaGrIqpIFR1NCP1MzTBQvVPx15kL3Cs1I7imlYrLssSmWc1E1xUeL6wQ9Nta10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753673141; c=relaxed/simple;
	bh=FgRHq90q4eadp/tKws2HZaOu/ltS4kMcOiS1a7EJCOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJifx2r3XsoTWlauzoivFxCxbBll8m2P66YDS6ik3SDGKWGa8lQj2fCrwnsOlaY5Aqx5MepzgEbv5FXPFmZQIiPHej5wE+ifGI0gY80QbF+9IfYolGkE+MxTNPnvQdHir4JdYKxmlIYMApqZc7O18kJtIFiA9Zw5QEANkkcWq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr6wpe7N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr6wpe7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753673138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4Yxk2eSXzBqK7HVLQsNsf25UXn0Y+Z0zgr/xtufB4Q=;
	b=Xr6wpe7Na+ZVlfUbtcKg86EcfFzo+gRD+ngkOVyyE4kQmv9G1pfi5C7DVSKviyaKknuMft
	bcYCXGSzvLsl02U2SwL9mOaXQF8Mdof5UxR9uRYv+Uov0E4mLJsKJKrK4z1i5MuSz7K+7F
	993pmdI7TqgXRNl1zq31YlsDD3gEs1o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-39KRxsk9PLehK9hkSbovLQ-1; Sun, 27 Jul 2025 23:25:36 -0400
X-MC-Unique: 39KRxsk9PLehK9hkSbovLQ-1
X-Mimecast-MFC-AGG-ID: 39KRxsk9PLehK9hkSbovLQ_1753673135
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso7452361a91.1
        for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 20:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753673135; x=1754277935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4Yxk2eSXzBqK7HVLQsNsf25UXn0Y+Z0zgr/xtufB4Q=;
        b=U2CboV9CvxMKIHBLUiiOx1OvPLnVl0d/WPVjgt7zDlMSUErj6m9lrL+c2GOUqEUNEn
         XYMVJ39187p8zRutN9ID8krD38o+GpFv3krAE3dwWWpX9T7oxPsO3MqeTsjoMIhIMsXr
         6Si5ZO4FiIYnQVZxoGUbQUxByenX28RVoS2sgpAwK8iivhg3ovH8k4mQVeG22AU2YAGI
         qL1FvK5ShRfj/pFWecRnGyLoNXWObqDZIDHZFcK+CujOsMHKZSk9JZ50tnpyUkx+DDGN
         xuWtEDmFJveeZXQBiDyZqi5TucgYA3Nbi+EGepqm+iPVzOtapDS1/++Y6KjH1u/J9jov
         2yvA==
X-Gm-Message-State: AOJu0YxqqUJpFoNOZrImoECim7W+aGpHaj/ZYGBDctNGcDBNpD7pquAX
	7o8VQcxRKYWF24zbiigH+Parx03gAhNyap2/UclKBmQQf94cbEqZWT9Wm2f0J2/kHpYXJxcPfx6
	Hlk4Pcv11NGqfh5Bdnkw4zqQIlZTkkLr6D/CI+Cb46Cc1WSm+CVcNhQ9CyjHp701K6m0Rana0gU
	4x/5XdDbbIiAvfegQwyE9KAswMaBRk3684+aPhQyx81u4=
X-Gm-Gg: ASbGncuXiBUCdplJJ9GM1IlFYTtGQXmK9En+S/jCIkktuO3kA/5Q9WVbhQDGVD9jq+Y
	aSze1N4Z3vEcYA+G6MDfJ74uXtrhPePkHA9fTaOtxgT9Tf3MKBVL1i0qXcQMuP8Zi6XEjf1n/GU
	YTDrUKkC49O/+HXvhjvpE=
X-Received: by 2002:a17:90b:3c04:b0:31e:fe0d:f48f with SMTP id 98e67ed59e1d1-31efe0df8bamr2192984a91.10.1753673135148;
        Sun, 27 Jul 2025 20:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPEh099RCzOysoyJDjGUqNiUs94oOEd9wrHBFflJdX7LL5XAuAS4aDGZOU5ezWNU9CPwEKzj/WikH+jsDgRVw=
X-Received: by 2002:a17:90b:3c04:b0:31e:fe0d:f48f with SMTP id
 98e67ed59e1d1-31efe0df8bamr2192941a91.10.1753673134553; Sun, 27 Jul 2025
 20:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250718091616.6140-1-jasowang@redhat.com> <20250718091616.6140-3-jasowang@redhat.com>
 <1753434567.220294-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1753434567.220294-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:25:23 +0800
X-Gm-Features: Ac12FXzr2QFoh19oAaySFAJIdSHLGCBTVzKPDhK4_DVph8ZCZ8F9-DPNHrs-010
Message-ID: <CACGkMEte6bwUKt=TTKxA=NTWOQOGnoCEEDmvWzMryYBrxzmMtQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/9] virtio_ring: switch to use dma_{map|unmap}_page()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>, mst@redhat.com, eperezma@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HdWaFbL1N-5FAdB--gaBGqNpPD_v9lH-K3z5b_ZXK90_1753673135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:10=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 18 Jul 2025 17:16:09 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > This patch switches to use dma_{map|unmap}_page() to reduce the
> > coverage of DMA operations. This would help for the following rework
> > on the virtio map operations.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 55 +++++++++++++++---------------------
> >  1 file changed, 23 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 103bad8cffff..75e5f6336c8d 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -405,8 +405,8 @@ static dma_addr_t vring_map_single(const struct vri=
ng_virtqueue *vq,
> >       if (!vq->use_dma_api)
> >               return (dma_addr_t)virt_to_phys(cpu_addr);
> >
> > -     return dma_map_single(vring_dma_dev(vq),
> > -                           cpu_addr, size, direction);
> > +     return virtqueue_dma_map_single_attrs(&vq->vq, cpu_addr,
> > +                                           size, direction, 0);
> >  }
> >
> >  static int vring_mapping_error(const struct vring_virtqueue *vq,
> > @@ -451,22 +451,14 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >       if (flags & VRING_DESC_F_INDIRECT) {
> >               if (!vq->use_dma_api)
> >                       goto out;
> > +     } else if (!vring_need_unmap_buffer(vq, extra))
> > +             goto out;
> >
> > -             dma_unmap_single(vring_dma_dev(vq),
> > -                              extra->addr,
> > -                              extra->len,
> > -                              (flags & VRING_DESC_F_WRITE) ?
> > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -     } else {
> > -             if (!vring_need_unmap_buffer(vq, extra))
> > -                     goto out;
> > -
> > -             dma_unmap_page(vring_dma_dev(vq),
> > -                            extra->addr,
> > -                            extra->len,
> > -                            (flags & VRING_DESC_F_WRITE) ?
> > -                            DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -     }
> > +     dma_unmap_page(vring_dma_dev(vq),
> > +                    extra->addr,
> > +                    extra->len,
> > +                    (flags & VRING_DESC_F_WRITE) ?
> > +                    DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >
> >  out:
> >       return extra->next;
> > @@ -1276,20 +1268,13 @@ static void vring_unmap_extra_packed(const stru=
ct vring_virtqueue *vq,
> >       if (flags & VRING_DESC_F_INDIRECT) {
> >               if (!vq->use_dma_api)
> >                       return;
> > +     } else if (!vring_need_unmap_buffer(vq, extra))
> > +             return;
> >
> > -             dma_unmap_single(vring_dma_dev(vq),
> > -                              extra->addr, extra->len,
> > -                              (flags & VRING_DESC_F_WRITE) ?
> > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -     } else {
> > -             if (!vring_need_unmap_buffer(vq, extra))
> > -                     return;
> > -
> > -             dma_unmap_page(vring_dma_dev(vq),
> > -                            extra->addr, extra->len,
> > -                            (flags & VRING_DESC_F_WRITE) ?
> > -                            DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > -     }
> > +     dma_unmap_page(vring_dma_dev(vq),
> > +                    extra->addr, extra->len,
> > +                    (flags & VRING_DESC_F_WRITE) ?
> > +                    DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >  }
> >
> >  static struct vring_packed_desc *alloc_indirect_packed(unsigned int to=
tal_sg,
> > @@ -3161,7 +3146,13 @@ dma_addr_t virtqueue_dma_map_single_attrs(const =
struct virtqueue *_vq, void *ptr
> >               return (dma_addr_t)virt_to_phys(ptr);
> >       }
> >
> > -     return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, at=
trs);
> > +     /* DMA must never operate on areas that might be remapped. */
> > +     if (dev_WARN_ONCE(&_vq->vdev->dev, is_vmalloc_addr(ptr),
> > +                       "rejecting DMA map of vmalloc memory\n"))
> > +             return DMA_MAPPING_ERROR;
>
>
> Why add this check, we never use the vmalloc address?

Yes for current drivers.

Actually, I copy this from dma_map_single_attrs() for extra safety:

static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr=
,
                size_t size, enum dma_data_direction dir, unsigned long att=
rs)
{
        /* DMA must never operate on areas that might be remapped. */
        if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
                          "rejecting DMA map of vmalloc memory\n"))
                return DMA_MAPPING_ERROR;
        debug_dma_map_single(dev, ptr, size);
        return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(pt=
r),
                        size, dir, attrs);
}

Thanks

>
> Thanks.
>
>
> > +
> > +     return dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(ptr),
> > +                               offset_in_page(ptr), size, dir, attrs);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
> >
> > @@ -3186,7 +3177,7 @@ void virtqueue_dma_unmap_single_attrs(const struc=
t virtqueue *_vq,
> >       if (!vq->use_dma_api)
> >               return;
> >
> > -     dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs)=
;
> > +     dma_unmap_page_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
> >
> > --
> > 2.47.3
> >
>

