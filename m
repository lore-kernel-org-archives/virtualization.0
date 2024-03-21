Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C166FBF
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000643; cv=none; b=fX38RVrSOXsEQumxztpPsPGa6tt1NSI8fL3jcM7JlxLT+AZ1bFAJ1flbIm1SjP323fuT6H1fEOvzvhkcqufKHgm10YMaALPXpjAYVHk09m90bqCItkG+sxLFG7KE1wfRVJH6dAhIWExgN+tQMx5OGwQZYRCOW/wGu7WEtQx0Q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000643; c=relaxed/simple;
	bh=ZkCXtl7Wyj/Ulyi97an5B0f6ez4cfoPYlK87QSV8OSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQ1NxPZ94qSWrgnUNkb3deorNs0m5jdjgWXkNGs1WIkcdj5COC94tdiDnZiGEF5bnNRjvav3cX1IzQ7WwpWuaDmvUWYYm/853Xv/R7olo4ktmlT8xFUlMqeqxL8u3HZM9sQ2ZpBtnMY3Djyrh4HRDrr2sHPtZA4JRK54cf8tRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcGYtGBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcGYtGBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711000639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8/Y+EQ9Lzkt9PPoByxYvT4F7ruhVkbKSru1lDPTO3E=;
	b=CcGYtGBq7pdjkLfSh1J4PE56asb1bhHGHcAGAhFxtI1iIVRrxpNnY94kJJZE1MbGqsC+t0
	9TWmtcTiMBXj8AuZe6YcH9l+KfeiygZeGsQoeEYGt9YlMNq5qNyYM07Q0LA4a+rfFeNEeJ
	XEgJsTkUdFfjEaNDrYAXbjgykHP+xqk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-1fSJK3qkNxyt9iS9C71zkw-1; Thu, 21 Mar 2024 01:57:17 -0400
X-MC-Unique: 1fSJK3qkNxyt9iS9C71zkw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dced704f17cso962123276.1
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 22:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000637; x=1711605437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8/Y+EQ9Lzkt9PPoByxYvT4F7ruhVkbKSru1lDPTO3E=;
        b=WaeGBDYDrLQPil5iPSxf4D5EePMBC5t7WBy2IRGYCBNIGT1nM1PGtYnH1M+PoY3DAj
         rjRWs012GsGWgdcAMBAyRsOqYzxobW5cODNl7UC+YZIpwxxbcGk29NL2Vz1v3co2g6OI
         QeQejZgrzzckMrrSK9F3aqtC7Ahz61Wy7nxQ/QGGCiA6yKc8wUI3jsuPhohweBRDxC5o
         IWuoKJ9/IWuK7Jlv6Oeq1/M+/68RWNb7Yse4M2dfLChrCdgegJprtf81YyK2WjdY1dIK
         bIy6r1FO+osC1xUnjd6ZjJxJk2WrIh+Qqxynt55gUqSStNsqG3zqZ0jberkQKJ5AAVDl
         Rf4A==
X-Gm-Message-State: AOJu0YzgN61DsNuTW1/rxQTsV6BZxyqIHsSIqaAUec6wnJ0w0ShQM8z6
	dRW6/NMiWg8Hs4akgm6+OAdHKTmZmpL6JTzmYTQ7odF5mn3hd8dvrTXP3BkMS0jcjJL4YlkPFV3
	JxUq25iGzYVVnG5SzYcCe27NFf2DAkmn0JaXlKwR59DiO1fLrynyhRcvqbI2wwfGFNknW8AIOjP
	5rJAC2Bcnnq1mv9M2zdSnTN+zD0c/bkFCTiUfzMh0=
X-Received: by 2002:a25:ce41:0:b0:dcb:f5f9:c062 with SMTP id x62-20020a25ce41000000b00dcbf5f9c062mr19303850ybe.14.1711000637358;
        Wed, 20 Mar 2024 22:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAgeWX+uvAxexiH0TkGZEbcAN/ujoS4BSpT2aF4lMWLqfRbJEPxRSjvTXMgygwxwjhqLi47bvGr/FXa6HBEsI=
X-Received: by 2002:a25:ce41:0:b0:dcb:f5f9:c062 with SMTP id
 x62-20020a25ce41000000b00dcbf5f9c062mr19303835ybe.14.1711000636921; Wed, 20
 Mar 2024 22:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 13:57:06 +0800
Message-ID: <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> multiple checks are made whether unmap is performed and whether it is
> INDIRECT.
>
> These two functions are usually called in a loop, and we should put the
> check outside the loop.
>
> And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> other descs, that make the thing more complex. If we distinguish the
> descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
>
> 1. only one desc of the desc table is used, we do not need the loop
> 2. the called unmap api is difference from the other desc
> 3. the vq->premapped is not needed to check
> 4. the vq->indirect is not needed to check
> 5. the state->indir_desc must not be null
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c2779e34aac7..0dfbd17e5a87 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
>         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>                                      const struct vring_desc_extra *extra=
)
>  {
> @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>
>         flags =3D extra->flags;
>
> -       if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       return;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq))
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
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>                                     const struct vring_packed_desc *desc)
>  {
>         u16 flags;
>
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
>         flags =3D le16_to_cpu(desc->flags);
>
>         dma_unmap_page(vring_dma_dev(vq),
> @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
>         if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> +               if (!vring_need_unmap_buffer(vq))
>                         goto free_desc;
>
>                 goto unmap_release;
> @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT=
 |
> -                                                 vq->packed.avail_used_f=
lags;
>         }
>
> +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> +               vq->packed.avail_used_flags;
> +
>         /*
>          * A driver MUST NOT make the first descriptor in the list
>          * available before all subsequent descriptors comprising
> @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>  unmap_release:
>         err_idx =3D i;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
> @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
>                         desc[i].len =3D cpu_to_le32(sg->length);
>                         desc[i].id =3D cpu_to_le16(id);
>
> -                       if (unlikely(vq->use_dma_api)) {
> +                       if (vring_need_unmap_buffer(vq)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> -                               vq->packed.desc_extra[curr].flags =3D
> -                                       le16_to_cpu(flags);
>                         }
> +
> +                       vq->packed.desc_extra[curr].flags =3D le16_to_cpu=
(flags);
> +
>                         prev =3D curr;
>                         curr =3D vq->packed.desc_extra[curr].next;
>
> @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>
>         vq->packed.avail_used_flags =3D avail_used_flags;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
> +       u16 flags;
>
> +       flags =3D vq->packed.desc_extra[id].flags;
>         state =3D &vq->packed.desc_state[id];
>
>         /* Clear data ptr. */
> @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->use_dma_api)) {
> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> +               if (vring_need_unmap_buffer(vq)) {
> +                       curr =3D id;
> +                       for (i =3D 0; i < state->num; i++) {
> +                               vring_unmap_extra_packed(vq,
> +                                                        &vq->packed.desc=
_extra[curr]);
> +                               curr =3D vq->packed.desc_extra[curr].next=
;
> +                       }
>                 }
> -       }
>
> -       if (vq->indirect) {
> +               if (ctx)
> +                       *ctx =3D state->indir_desc;
> +       } else {
> +               const struct vring_desc_extra *extra;
>                 u32 len;
>
> +               if (vq->use_dma_api) {
> +                       extra =3D &vq->packed.desc_extra[id];
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra->addr, extra->len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +               }

Theoretically, indirect descriptors could be chained. It is supported
without this patch but not here.

Thanks

> +
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
>                 desc =3D state->indir_desc;
> -               if (!desc)
> -                       return;
>
>                 if (vring_need_unmap_buffer(vq)) {
>                         len =3D vq->packed.desc_extra[id].len;
> @@ -1634,8 +1638,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                 }
>                 kfree(desc);
>                 state->indir_desc =3D NULL;
> -       } else if (ctx) {
> -               *ctx =3D state->indir_desc;
>         }
>  }
>
> --
> 2.32.0.3.g01195cf9f
>

