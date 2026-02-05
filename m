Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59913B293
	for <virtualization@lists.linux.dev>; Thu,  5 Feb 2026 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263707; cv=none; b=H/DCJ60Tg8CZW1popHhl2rlEXVjdkZ8Dy2mBwg38wV34ZWueMU8aCmquiUTmqUk+PTh9ZIyr+JJRCPxf58Oue3P92u62dhe4T6SqcoiYHLaOYIOkwcx+dT1gCyXUaOYaaGymdnIaPl+Y5artrh2qs+QiMDnfzrDdXd1zDZB2eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263707; c=relaxed/simple;
	bh=yQ+/qIdsSrnwbr6nE+vWLrH8Nj+O4Y7hs/EbVrwH9Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3tomEy5Or+27einkoZmrmHwZp0BxY80hLNH0wa3/ZILg5GS29ugkFw1Bwm4uGxZh5ugHO9v5ItDUFyKmdvdiYr+Sm/FSgylSHtz74q9VnlpalcZegCs3QIRuX4glfNaVqHCWdQqb/UokHqKZT/ptW3opoXboQjtR7KlGKwqw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCdSkl7g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCdSkl7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770263705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3I4wiHK4vuKnP4ath3SaZ9xx45LrwQZ1CCNfZkbkb7c=;
	b=RCdSkl7g1QuCV+c55+mEC5QYiAoUrnzQebFWOIeVPAU984CFNYfJPiiKkrkUwPfXfhuejH
	SJvrtfp3Wh70cStcSR0YuNg4E+4sI6/FkVDHn+OsDEf8GqsYx3iUZlCPkMw6GtOa5o2J9w
	+5zeUIPPbzAGbVlwR2WP2o0D9z/OW/U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-guHtFI2zNB2W7n0_N3icNQ-1; Wed, 04 Feb 2026 22:55:04 -0500
X-MC-Unique: guHtFI2zNB2W7n0_N3icNQ-1
X-Mimecast-MFC-AGG-ID: guHtFI2zNB2W7n0_N3icNQ_1770263704
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a943529ff5so4481565ad.1
        for <virtualization@lists.linux.dev>; Wed, 04 Feb 2026 19:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263703; x=1770868503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3I4wiHK4vuKnP4ath3SaZ9xx45LrwQZ1CCNfZkbkb7c=;
        b=CpnQzVFAlrGXcCf1+RPq7xfoaadShyBUw1G9CbQBdQa5Scy6r5BXmn5fGMsy1obIVj
         wIsrDV3qmHafJReJOOgWrrjxWyQ1jJAqBQ1pj+89LCy8KXo2Ialx7PwHUvcEeD+C3iIi
         rrY4d+wRQSHvoFaFip6EFEmbw//28tnSzZGTbtOJWI3T8nbZA2RkX57/hYRkFeWgWAC2
         UJLEt2cVaojmadBeoklXZeK5VAPCGITEF9Hdgh25EU4p/BnAWFgXMFl+Di/itwnQzAvY
         LhpTiXf7gY40aWofa86440Z0tYxMYrEojDk/LaA4ychyId+RZfcNfBQskmWEiMVhd8wI
         S3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZzhVDgkl61iTMaGT6pF83kgFG5Nevd2pRzrPTbWtvQwYVOucK4WEZ31VFH8G8giDOjldMEN7LJMPfb71d/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfksdxqgLGHtzsF3JZbU5kRB/4zoFe7fRVKOjBQLh1lSdW3fD8
	i5oJP+/1iFDYknHNj40Hp33SsoZzUw3a0kF3G/blnJ9F5aw5X6EWffIP26obC/q7YzPsrVjgQ5j
	YDok10a4A2zYYdlC/D8Zh8ZU/mAb6dV2PP9e58VrqgAN97MjFTamNlLNLdfq9EdZXV6KbkIj/N4
	aruXEGWfOKHJ7GmU7wzvniMm0dIgHE8AuVx/6idzxqXGA=
X-Gm-Gg: AZuq6aInP2WbUIr3A301j196aKNNc38HZv9mHepICWg7HeR4qJLAAvxhTkfNq3gDvB3
	EDH3L7iQK5PmEWTV6ETY9bNb0hPXITUQqmxoBB58i42S7KbSTs4hHP41rXDyZRtTZsI0rRCyyfD
	1VWn9uDoY71KPgLPOJtXhxf5AGW0+VqKMP9beaiqqlwXRmIvUShjDe9h5iES1mQOIkcg==
X-Received: by 2002:a17:902:ef07:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a933fbb91bmr55342325ad.34.1770263703498;
        Wed, 04 Feb 2026 19:55:03 -0800 (PST)
X-Received: by 2002:a17:902:ef07:b0:2a1:3e15:380e with SMTP id
 d9443c01a7336-2a933fbb91bmr55341925ad.34.1770263702958; Wed, 04 Feb 2026
 19:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204193617.1200752-1-vishs@meta.com> <20260204193617.1200752-2-vishs@meta.com>
In-Reply-To: <20260204193617.1200752-2-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Feb 2026 11:54:51 +0800
X-Gm-Features: AZwV_QiGiEnnkcU-RVALFrf_34MIEhko_WcvnVlIybPAOQb-EXjvuh7K8OffMaM
Message-ID: <CACGkMEuJ1LXg+WOryC9Fnk3NRJVhvzy+h8p5-fJFWUu1z8Yqtg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] virtio_net: add page_pool support for
 buffer allocation
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ERt50Sph6j6_XXo19iaGUTBYYVFPAWs7p1eTcga2aHk_1770263704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:36=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.com=
> wrote:
>
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.
>
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
>
> Implement conditional DMA premapping using virtqueue_dma_dev():
> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>   handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>   submit via virtqueue_add_inbuf_ctx()
>
> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
> support as a prerequisite for future zero-copy features (devmem TCP,
> io_uring ZCRX).
>
> Page pools are created in probe and destroyed in remove (not open/close),
> following existing driver behavior where RX buffers remain in virtqueues
> across interface state changes.
>
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 351 ++++++++++++++++++++++-----------------
>  2 files changed, 201 insertions(+), 151 deletions(-)
>

Looks good overall, just one spot.

> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
> -{
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct virtnet_rq_dma *dma;
> -       dma_addr_t addr;
> -       u32 offset;
> -       void *head;
> -
> -       BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -       head =3D page_address(rq->alloc_frag.page);
> -
> -       offset =3D buf - head;
> -
> -       dma =3D head;
> -
> -       addr =3D dma->addr - sizeof(*dma) + offset;
> -
> -       sg_init_table(rq->sg, 1);
> -       sg_fill_dma(rq->sg, addr, len);
> -}
> -
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t =
gfp)
> -{
> -       struct page_frag *alloc_frag =3D &rq->alloc_frag;
> -       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> -       struct virtnet_rq_dma *dma;
> -       void *buf, *head;
> -       dma_addr_t addr;
>
>         BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
>
> -       head =3D page_address(alloc_frag->page);
> -
> -       dma =3D head;
> -
> -       /* new pages */
> -       if (!alloc_frag->offset) {
> -               if (rq->last_dma) {
> -                       /* Now, the new page is allocated, the last dma
> -                        * will not be used. So the dma can be unmapped
> -                        * if the ref is 0.
> -                        */
> -                       virtnet_rq_unmap(rq, rq->last_dma, 0);
> -                       rq->last_dma =3D NULL;
> -               }
> -
> -               dma->len =3D alloc_frag->size - sizeof(*dma);
> -
> -               addr =3D virtqueue_map_single_attrs(rq->vq, dma + 1,
> -                                                 dma->len, DMA_FROM_DEVI=
CE, 0);
> -               if (virtqueue_map_mapping_error(rq->vq, addr))
> -                       return NULL;
> -
> -               dma->addr =3D addr;
> -               dma->need_sync =3D virtqueue_map_need_sync(rq->vq, addr);
> -
> -               /* Add a reference to dma to prevent the entire dma from
> -                * being released during error handling. This reference
> -                * will be freed after the pages are no longer used.
> -                */
> -               get_page(alloc_frag->page);
> -               dma->ref =3D 1;
> -               alloc_frag->offset =3D sizeof(*dma);
> -
> -               rq->last_dma =3D dma;
> -       }
> -
> -       ++dma->ref;

This patch still uses virtnet_rq_unmap() for free_receive_page_frags()
which looks like a bug.

Thanks

