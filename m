Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7662291E
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609279; cv=none; b=mSH3qwgh4dMevM4bTtmMphGopFqP4w0NQy9sWEflaQgBXt/e4LJ1fpurt2XqQhhzJI3IsuRCo79jlt+zufUZD2OSwj25PX8I9wY+N0uwWksczx2YZSGRrwBb9U6T8ZSuKpi+zdFQwq8WCeYd3AMhd8WzmuygFRWufQEcDh1JTpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609279; c=relaxed/simple;
	bh=AicdXorPeuJyMJdvRikY8cvTus2BX/hzGTwUI0rnkFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YI4VG9dgH4BmGawnea1MgMFHhxa9UPiJkrAAA4aw5hfQ/whVbVpTzMe2c4ee2IaR3Aq2e1PCVJCYBLISJ3rH8pkce6L0Puw3oHSTtFm5nKj55SYY9mAB2+YPrkAMTDDsWS+NWgjzoVaLZeIugzI848fBNfL0UXLnvsV6VMmCnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3LLOttC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3LLOttC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DU+XzrwJDU0PGuTZEC1k1eRTe7sMCBvCFlsaXGs9sr8=;
	b=E3LLOttC2gnPFR6lqd0QhXf1GQe9quqMwiZgR0FRv7/BibyObIEqxGtNGb7Bu0zPnw53+R
	TMWafh/b4Cmt4zEjSoMlkz5kD9Zocnf7a8zp7w4BlmvGk5DYUQTl4/XeYE6TSTKmIaoFnl
	n+qy93+APorvC0N8sACZpIjlio5bKnY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-HbocnsCJPCudUKNrBhrAJQ-1; Thu, 28 Mar 2024 03:01:15 -0400
X-MC-Unique: HbocnsCJPCudUKNrBhrAJQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29f9bffaa42so548001a91.0
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 00:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609274; x=1712214074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DU+XzrwJDU0PGuTZEC1k1eRTe7sMCBvCFlsaXGs9sr8=;
        b=L6aWoGm/jYIXmYmfW08Bl8WL9rwPV9b+UInYcakefbGEMvmvgOeirTB5tfH54LDzrY
         2jkZhWp/4NbQ8IhvbwHPbS8uq9QcrZPZwnO8dxi+lqekjq49ZgkFhxmqzWm6zDZXM5R2
         Rj5wssHdUBt/1AbNUs8gaEzPvjPuGDnlHHfACULlvoOMUZXmWLIfy8mffFM1nPYvW/bi
         fw8L7gIwECJwqQNF7BTld8kP4zHQ2RXwxkCKZd+dCSNwcEaXtBNw6OiXz6S39PHtjaFo
         kCEIYCeSYCyV26UJ7Dr2B2fqbtnout1kJocUnJ60b1M/ZFo0SPFz7mXhIlm9LeIYj+Nn
         I6FQ==
X-Gm-Message-State: AOJu0Yw5aSa3Gwe5PnYQNw189pZzfPQVPHdorrm5vsecBMCmIorzKV6z
	RtEN+KvmsbTiJVLGK9g03iG8KdamkIL8LEqwA78zdiwMu4hUt+GpsUCpvQkGbn0lifnoUb867m+
	L1jRdK+sao25AH4eM5jhdASgacm2NO4mK9QureNw88rYSPqFLOS91YZ4PEslps7gUhLpLU98SNe
	/wg54EyO9gGr1T8ifwePAsy/0+7ZO1tPMPqv+U7zE=
X-Received: by 2002:a17:90a:cb92:b0:29d:dd93:5865 with SMTP id a18-20020a17090acb9200b0029ddd935865mr1608599pju.46.1711609274169;
        Thu, 28 Mar 2024 00:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAX2D7T5LDGSkktbRDQ6FxtVwJlflqd6Uqu3gSkhxvOFb6tqFyLNSaeQQ3H13YcFuJ1dp4EW9mOuN5qdeBxqw=
X-Received: by 2002:a17:90a:cb92:b0:29d:dd93:5865 with SMTP id
 a18-20020a17090acb9200b0029ddd935865mr1608583pju.46.1711609273879; Thu, 28
 Mar 2024 00:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:01:02 +0800
Message-ID: <CACGkMEvKXrw5SPD7YudE4ecsK2Fo5x0n_ROFAp+J8xz=dLvBzQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 05/10] virtio_ring: split: structure the indirect
 desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 87 +++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8170761ab25e..1f7c96543d58 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -69,7 +69,7 @@
>
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any. *=
/
> +       struct vring_desc_extra *indir_desc;    /* Indirect descriptor, i=
f any. */
>  };
>
>  struct vring_desc_state_packed {
> @@ -469,12 +469,16 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>         return extra[i].next;
>  }
>
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> -                                              unsigned int total_sg,
> -                                              gfp_t gfp)
> +static struct vring_desc_extra *alloc_indirect_split(struct virtqueue *_=
vq,
> +                                                    unsigned int total_s=
g,
> +                                                    gfp_t gfp)
>  {
> +       struct vring_desc_extra *in_extra;
>         struct vring_desc *desc;
>         unsigned int i;
> +       u32 size;
> +
> +       size =3D sizeof(*in_extra) + sizeof(struct vring_desc) * total_sg=
;
>
>         /*
>          * We require lowmem mappings for the descriptors because
> @@ -483,13 +487,16 @@ static struct vring_desc *alloc_indirect_split(stru=
ct virtqueue *_vq,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> -       if (!desc)
> +       in_extra =3D kmalloc(size, gfp);
> +       if (!in_extra)
>                 return NULL;
>
> +       desc =3D (struct vring_desc *)(in_extra + 1);
> +
>         for (i =3D 0; i < total_sg; i++)
>                 desc[i].next =3D cpu_to_virtio16(_vq->vdev, i + 1);
> -       return desc;
> +
> +       return in_extra;
>  }
>
>  static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq=
,
> @@ -531,6 +538,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                                       gfp_t gfp)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> +       struct vring_desc_extra *in_extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
>         unsigned int i, n, avail, descs_used, prev, err_idx;
> @@ -553,9 +561,13 @@ static inline int virtqueue_add_split(struct virtque=
ue *_vq,
>
>         head =3D vq->free_head;
>
> -       if (virtqueue_use_indirect(vq, total_sg))
> -               desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> -       else {
> +       if (virtqueue_use_indirect(vq, total_sg)) {
> +               in_extra =3D alloc_indirect_split(_vq, total_sg, gfp);
> +               if (!in_extra)
> +                       desc =3D NULL;
> +               else
> +                       desc =3D (struct vring_desc *)(in_extra + 1);
> +       } else {
>                 desc =3D NULL;
>                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
>         }
> @@ -628,10 +640,10 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                         ~VRING_DESC_F_NEXT;
>
>         if (indirect) {
> +               u32 size =3D total_sg * sizeof(struct vring_desc);
> +
>                 /* Now that the indirect table is filled in, map it. */
> -               dma_addr_t addr =3D vring_map_single(
> -                       vq, desc, total_sg * sizeof(struct vring_desc),
> -                       DMA_TO_DEVICE);
> +               dma_addr_t addr =3D vring_map_single(vq, desc, size, DMA_=
TO_DEVICE);
>                 if (vring_mapping_error(vq, addr)) {
>                         if (!vring_need_unmap_buffer(vq))
>                                 goto free_indirect;
> @@ -639,11 +651,18 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                         goto unmap_release;
>                 }
>
> -               virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> -                                        head, addr,
> -                                        total_sg * sizeof(struct vring_d=
esc),
> -                                        VRING_DESC_F_INDIRECT,
> -                                        false);
> +               desc =3D &vq->split.vring.desc[head];
> +
> +               desc->flags =3D cpu_to_virtio16(_vq->vdev, VRING_DESC_F_I=
NDIRECT);
> +               desc->addr =3D cpu_to_virtio64(_vq->vdev, addr);
> +               desc->len =3D cpu_to_virtio32(_vq->vdev, size);
> +
> +               vq->split.desc_extra[head].flags =3D VRING_DESC_F_INDIREC=
T;
> +
> +               if (vq->use_dma_api) {
> +                       in_extra->addr =3D addr;
> +                       in_extra->len =3D size;
> +               }

I would find ways to reuse virtqueue_add_desc_split instead of open coding =
here.

Thanks

