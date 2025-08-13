Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29461519A0
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071288; cv=none; b=X9ElGmvIzxwssrfs8IM14SOncy4xG/OhRKraHEijQLzidk7RYFGn2oyAD7rkVW1o6IVVYNm4QRr+ha1Boa7FKz2YjPdbbHIgem50vl3nPuLnla5B0eWN4dHOlIfatbsekDtrCduNxjcW7GRcnXIYvjdjvWs/nSjof/n9zDpK1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071288; c=relaxed/simple;
	bh=Li0m0nEg3h+OWe/ICX5PDsk/tGlVW8FeOSB9YpitZNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VruL10/xC9EbWZ1YvO4hk0Kd7h1tjycs6B6zD9Bp+37pw+U4znixPl/vjHUKa+GtCMIm/DIJNlQTdTYNUZnV2GCqaoxZFMuxjak3vca9hhsjI6T2zi0qjTSwK6x59jmwTXWrKOmjPH2sLSrw13t5r1RA1nZLJA3BBWCUnDFplcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrPkk8RX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrPkk8RX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755071285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kl1oltQNBdcY7bflfmWCksbU9W3EJNDDKAdZkMv+0SM=;
	b=UrPkk8RXJAVUwU5VrRuqVDtJJoVthnf8ZfOjNzwC5/0uOaCiD9KBHNep7cBnlbQ7OJ4xw6
	iLi+TEGQg1FAFKuXEGxh4cD9JH7hLFUCCyk+TLnKOEuR/VM3oQXZC7xFT5GtHJMJKVkhJg
	7cM2GV391UNDABgqo9NMlF2tokHN/Cg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MNYH0xNkML6Fd5s0N5MoPg-1; Wed, 13 Aug 2025 03:48:04 -0400
X-MC-Unique: MNYH0xNkML6Fd5s0N5MoPg-1
X-Mimecast-MFC-AGG-ID: MNYH0xNkML6Fd5s0N5MoPg_1755071283
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3215b3229c7so6639975a91.2
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 00:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071283; x=1755676083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kl1oltQNBdcY7bflfmWCksbU9W3EJNDDKAdZkMv+0SM=;
        b=bdS19hOccBHgGmiCIahandyZpWZc1X1RpCwLe7nZGSDDNO2gJdNz9gHOdTGB1nt3zJ
         RzE8tM025NCl/PkMk7kUChVH/UN8mGpZvF3T9dJKQUYjFUT7lS6zDg/kq/l15IgR2X1j
         2XrOeo7CUeiAvHSXc/BBWbyx/8ek9DoCgrQkdKXHt/X/PCITWMn/QTJhkJT1jW/koFOv
         xmM6vH0lJV5oHL/uDp30t4l1hfOboRiGZh2f+zxV6xjeH4FLAlY+xOsUKahkdPpKNzs2
         05IgnLK68WtyHccTkxUZULj5ik14N0NPoJKyDI5DrwP7Ik0UBz55fbfrIjfTYFucvihb
         LzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpBfxMgPaOapPFURjC5ZZEO8LWYyxgzDv5dTPhk6QlJdz+mmuoaCJNQFlTfDQlx8CjVdntW8Q1iV5TsDPZNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCW7vD40H92C7ce/S/CzGeMZEsJyRWWEsj9S0m4U9aqi/Q5lCS
	QnTz/zp0zqGLGcLVHAR/8HkXftyPbAevJ3dmf7vuX61hDRbyEwXIXtJTqEdt2YGmQfl0JdEOXzw
	OyiV60IUpO+pGlYN3w3k/W3rtinX7PfRSk29KYIWTl/3ukHuF7iBHdjDUw2jwhtk/1AePGmoNiR
	z1MNuFxPRSZLuCY0VyHq654pyccgV05nxyw4a47P0T+2Q=
X-Gm-Gg: ASbGncvOGWyVGW5ir+Tf+3rWUAcwNlTuZlG1/Msl3Jbp6+BP9rOVaRvjlsG0ZgbK+yF
	vtq84KVS4ucddQVkfJ0IrUoT2+Dly3wpaflYD7yj9EwRfW8j4ZeLM9z19ZOK/AeSEN9AxayaAYS
	DaHt/gaWZVwaBZzowXgw28InAWDF4pAOVKfZsx8dXIFCuVaHuLeHRL3XI=
X-Received: by 2002:a17:90b:2502:b0:31e:cee1:c5e1 with SMTP id 98e67ed59e1d1-321d0eee53dmr1962320a91.30.1755071283270;
        Wed, 13 Aug 2025 00:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzZg5aAJxu8oHZbbZYEblznlj3j9+IG3S6lcFrXRSMg6BTTQS+li8YaIMOG59wemzWZuExSpHI/1K1jDrNOXk=
X-Received: by 2002:a17:90b:2502:b0:31e:cee1:c5e1 with SMTP id
 98e67ed59e1d1-321d0eee53dmr1962314a91.30.1755071282859; Wed, 13 Aug 2025
 00:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250813054831.25865-1-jasowang@redhat.com> <20250813054831.25865-6-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-6-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 13 Aug 2025 09:47:26 +0200
X-Gm-Features: Ac12FXz6rbnL7HWYdmu-rLjYTyfD5WMOhqztTm1NI_Z6XsclKCE_ao53IAejFro
Message-ID: <CAJaqyWdu=V1AMWf1nDF8v4fZMnZGriRGeJ8ksOPLqNEOpRK5ww@mail.gmail.com>
Subject: Re: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org, 
	Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5gTBLiOKZAp9OlyEdR32FpbYwV1j1HfvNmWRG7_IwUA_1755071283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:49=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Following patch will introduce virtio map opreations which means the
> address is not necessarily used for DMA. Let's rename the dma_handle
> to map_handle first.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fb1d407d5f1b..94b2a8f3acc2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_devi=
ce *vdev)
>  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> -                              dma_addr_t *dma_handle, gfp_t flag,
> +                              dma_addr_t *map_handle, gfp_t flag,
>                                union vring_mapping_token *mapping_token)
>  {
>         if (vring_use_map_api(vdev)) {
>                 return dma_alloc_coherent(mapping_token->dma_dev, size,
> -                                         dma_handle, flag);
> +                                         map_handle, flag);
>         } else {
>                 void *queue =3D alloc_pages_exact(PAGE_ALIGN(size), flag)=
;
>
>                 if (queue) {
>                         phys_addr_t phys_addr =3D virt_to_phys(queue);
> -                       *dma_handle =3D (dma_addr_t)phys_addr;
> +                       *map_handle =3D (dma_addr_t)phys_addr;
>
>                         /*
>                          * Sanity check: make sure we dind't truncate
> @@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *=
vdev, size_t size,
>                          * warning and abort if we end up with an
>                          * unrepresentable address.
>                          */
> -                       if (WARN_ON_ONCE(*dma_handle !=3D phys_addr)) {
> +                       if (WARN_ON_ONCE(*map_handle !=3D phys_addr)) {
>                                 free_pages_exact(queue, PAGE_ALIGN(size))=
;
>                                 return NULL;
>                         }
> @@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device=
 *vdev, size_t size,
>  }
>
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> -                            void *queue, dma_addr_t dma_handle,
> +                            void *queue, dma_addr_t map_handle,
>                              union vring_mapping_token *mapping_token)
>  {
>         if (vring_use_map_api(vdev))
> -               dma_free_coherent(mapping_token->dma_dev, size, queue, dm=
a_handle);
> +               dma_free_coherent(mapping_token->dma_dev, size, queue, ma=
p_handle);
>         else
>                 free_pages_exact(queue, PAGE_ALIGN(size));
>  }
> --
> 2.31.1
>

