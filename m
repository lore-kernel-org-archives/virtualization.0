Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F9189905
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997577; cv=none; b=JcsUNjdUkmkbLIWcqCtxT+Zqb9SOUiiltYTBdlJ1Z9dM/SaEMbi5oJHLYKwum8gLcWn3Ftp2mZcqPfg/hAHHTjN6LgSnc7aZoeyUwD1lAN/h/Sr+Kv6rA9+0BLJ6JswzFs6l77RlTTWhvouiGy3V5rP2Fr22Br9jJMeIIEIp3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997577; c=relaxed/simple;
	bh=F7lPxs2XY9HKXK5i6zefE89hoDi9pRJmmFXocmfF4ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+EEWpnqcWJ/VDTEA+jUcqMh3z4KQh0J8+8NOx0g8OoG9enMNwvxMeE+0xQUNw5hgTU2YI2IZ2gXQ9jGfVpiWvIu9uurk2yNFIXUReANv7DQ8aQ0rmRBMhGvo0NCtw2x0xeLrGbhNkInbusiEyRz/LsXryX9Ok5eE2LRpaVt37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPEFLLDV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPEFLLDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc8bRhEtT8in2D0KI4jdlRnEForc3n5J0jJsbqWmeEE=;
	b=dPEFLLDVM7VMdzcDm0UtL4HC2XY5//QAx8cgroBEUeTTE8WJ9i2uzGnpHW65rH3THeukTu
	FElKux/WVGMZPy7YMEnVI98s+hUPtlJjMJFZfZHSrwOWwde+oRp6LrkMYy5BmZtoPiHe+t
	OkdIUwYko7wOzSQfM9rrhYBNoydfa2Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-haVvFyHwMxetGsbwQv5z4g-1; Wed, 26 Mar 2025 09:59:31 -0400
X-MC-Unique: haVvFyHwMxetGsbwQv5z4g-1
X-Mimecast-MFC-AGG-ID: haVvFyHwMxetGsbwQv5z4g_1742997571
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e67df8c373so6830062a12.0
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 06:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997571; x=1743602371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc8bRhEtT8in2D0KI4jdlRnEForc3n5J0jJsbqWmeEE=;
        b=nSlDzcnbXo9z5udQxCIxabng29ycSv5DpFf4FDoTY2sBHo9EOgSvYRd/DRicqWci2g
         oXEZU9Fb2b5+yoxgH7IzGRl9+CXW3EA+RTxHgFyNA9vobTwhzInR5hOpqL3EOFOL3Zco
         isJIeN1poSh0VkaobmG+mw4/rbaiDOdKi/5mli8+7Q2s+KK6HWIYVdPg7oqb3gvQOK6x
         55L226WFbjGwsI4L/1PRq/9GB5ItuvhI3cWPoqmhnIBo6+avnkXVKMh1S6/WQCdN3Zs7
         8bFIk6rmfq3pT/Mcj5Bl5jy8vx8SrWlEhSAAwRWigzqPSjR6NkixM7dDuX4XKghlEvWp
         0rgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWezWibHMXNpAx3tHMYVgBJk4A7azGwPGGJq9CuW8jvl5SxvlQ5vjLjiYXCM3x3P3vqLpyQjWS+3LC0oY7JRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTNedQqLCU1aE1cHI4VLNmq846IOlaovuBhqRpmpi2MBciLwpt
	6jnUBPEoZcvXC85XQ/wEmSYhix9XIiBojKkP3ruKoN17NjcXryqE3hR1NU4PkzH0MccYt8xAtDO
	fJJrvebX/WoQ0fAXhvXV/nWceUaNCfngsgRKqGQM5GZbH77OLGBXY2XNEGqQpMadtrGwBdbKyjS
	0CxWKB87ii0DJ4iHWsOCdxDjFSqI1w5JiK3RVVKcU=
X-Gm-Gg: ASbGncsOJE8ml6ZnyRY5hSfqEo1pxnmO7anlU9XI0R5I/3B3DoOWrXI8yDG7Ke7yT5/
	G/6h+kHhLXIEGDGyNJyFughInJs7W5HHHSk3YD4jLXXkXQlMtJ6CgwGa0Ka3jjLIcf2mdG9g=
X-Received: by 2002:a05:6402:510b:b0:5e6:13bf:2c7c with SMTP id 4fb4d7f45d1cf-5ebcd429dccmr19421050a12.9.1742997570590;
        Wed, 26 Mar 2025 06:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtQhnoDSXCdaIb9VxZA1Q+j1d8ajlR55bECEyQZ4aW+jmA9eDNiaAAMGGCVRDU+yYA/Kuf18qRobOYnsVT4LM=
X-Received: by 2002:a05:6402:510b:b0:5e6:13bf:2c7c with SMTP id
 4fb4d7f45d1cf-5ebcd429dccmr19421026a12.9.1742997570138; Wed, 26 Mar 2025
 06:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-2-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 14:58:35 +0100
X-Gm-Features: AQ5f1JpncU-FFKWRIsRDp1aiOhQu7k5rjdTJWx-XjBKEocYsCXNTfaNMxggVo8M
Message-ID: <CAJaqyWf_-us5TergphezFyVLor-uY3DxWMjF3NbP7kknuNWXrw@mail.gmail.com>
Subject: Re: [PATCH 14/19] virtio_ring: determine descriptor flags at one time
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vngVtqj7ixvmwkRmXNraLSma8xatunAOwSFjrTb5Ces_1742997571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ce1dc90ee89d..31aa4a935c27 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -561,7 +561,7 @@ static inline int virtqueue_add_split(struct vring_vi=
rtqueue *vq,
>         struct vring_desc_extra *extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
> -       unsigned int i, n, avail, descs_used, prev, err_idx;
> +       unsigned int i, n, c, avail, descs_used, err_idx;
>         int head;
>         bool indirect;
>
> @@ -617,46 +617,47 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
>                 return -ENOSPC;
>         }
>
> +       c =3D 0;
>         for (n =3D 0; n < out_sgs; n++) {
> +               sg =3D sgs[n];
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>                         u32 len;
> +                       u16 flags =3D 0;
>
>                         if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
>                                 goto unmap_release;
>
> -                       prev =3D i;
> +                       if (++c !=3D total_sg)
> +                               flags =3D VRING_DESC_F_NEXT;
> +
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
>                         i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> -                                                    VRING_DESC_F_NEXT,
> +                                                    flags,
>                                                      premapped);
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       u16 flags =3D VRING_DESC_F_WRITE;
>                         dma_addr_t addr;
>                         u32 len;
>
>                         if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr, &len, premapped))
>                                 goto unmap_release;
>
> -                       prev =3D i;
> +                       if (++c !=3D total_sg)
> +                               flags |=3D VRING_DESC_F_NEXT;
> +
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
>                         i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> -                                                    VRING_DESC_F_NEXT |
> -                                                    VRING_DESC_F_WRITE,
> -                                                    premapped);
> +                                                    flags, premapped);
>                 }
>         }
> -       /* Last one doesn't continue. */
> -       desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
> -       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> -               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
> -                       ~VRING_DESC_F_NEXT;
>
>         if (indirect) {
>                 /* Now that the indirect table is filled in, map it. */
> --
> 2.42.0
>

