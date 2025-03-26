Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2751E1E08
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992240; cv=none; b=Zuworu6Bt4gSn3VqgGKJJsC3hDeD1MBlNIHuzGV/AKy/yNKETQUhSBzHAridxqcD2ItSzcX+ripgPVUd+9bmFYgdl/9Yk+0L/+4VyAQ32RLbBfjvUCGGDUpRLaii5VJq4OXMZQGSY0vX8D7P701WNgFLY7iEoN6xt97srSe4U1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992240; c=relaxed/simple;
	bh=LgtmqNrSHlnKtvwzHXwk58TV85eQJsA8R8IafG/GEpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFtAOB8+NPBjMCT2yksFhbnrLRB+e9Qq4QQRQA7Amd75lqqxsUNVAjU6LFyyFogWHKwklKIpGKga2YhyMmWAyI5sbuNT1rYIwo780pEq/jT+xon2CE61zS7VQKYrXj9sSSmhF1SYkyKLGzMFifTUFKk4Mby6FmKndOlzfMjiUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zog9NndO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zog9NndO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG4hOSlV51433RbXLsoSL52zL91v7u43plwp/pvXVeM=;
	b=Zog9NndOJps+nPSrCxM9aCXqD6mn49BImCEmd5kkZsFt009djBK3P4x/ze7Moa2AUIOmlr
	AKRsYTubd8Kv/sf4VIPN8uKHmVRGaOdWKSLfa9gcsogzeNVH/BiwCP6Htv5TjpIJQB9UZE
	/F9ttbwg2gKOSHazJDTcmO9xL6WG4LM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-mTfQC8omPC6qGkKHw3M4UA-1; Wed, 26 Mar 2025 08:30:35 -0400
X-MC-Unique: mTfQC8omPC6qGkKHw3M4UA-1
X-Mimecast-MFC-AGG-ID: mTfQC8omPC6qGkKHw3M4UA_1742992234
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so12033712a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 05:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992234; x=1743597034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG4hOSlV51433RbXLsoSL52zL91v7u43plwp/pvXVeM=;
        b=Z99/VnRLGvpTPNGWTjtjhzr2jOt2yr9IdsWpjK7qFRvuEFJC0V0Gi4hXSUNSVYvp9F
         UhY/q+mtHQPMRq1Lm0BimUrb9fdPECK8Znm8ZdYC0v2V956n37BwOSpgfi016pqnW1qS
         T5zgTE+72Cb3MKoqsb4P3El4JN7PNBtJL97Wf578iA30RHSGOwrU7bo7YW2sNYld8bSp
         8rO7bVMVO406c1Tj3KqGtFlvMvXLHLyuQ2teAO4W9sFNjPUTgQXWxanjL47yPDzfjAAn
         Zu8udE3dPHCJoUclTQWq65P4W07LeBCrIZM55jkHeKMOUB9LdvUvYtAF+qjpFSDBL9As
         24rA==
X-Forwarded-Encrypted: i=1; AJvYcCVSepJdBd60pPwFwWU7gxNQtuOmkXHFMIKXW/ec/dZj29k4aPnF32We3l8g8+ZzFAjPOdnZYimCQPVWEKR1VA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxjl/qKR3KfNfEBhnil9Jx7mfMLFV9XNxcllPbkIw9cehsNwHIX
	1dKIAPQVea3Ww96PcTkKqkRy3aFYwP6QtDY1dDLule6SPrvKqdJQTc2Vl8m12XODWBbpvUpgSms
	GJxudA5V9Acq8LVukPY9S1tz4Wp13Lykn90HHCY79/hAb29TKEdzbKBghbl1xDk4LLk9dmY7cvJ
	nVq06Ax/s2KeOrqtt79xnYWr9jzzIQ/vLMOqohoZ4=
X-Gm-Gg: ASbGnctfXSWu8sKPZqvqBFxnI49HRFXlb8fhWhuDLZ45KxzCbEBNAZp24+g1Xh9u91l
	hadicCyQW6tVZs+5AdSaiZp/i7RnBZmrFQKMadAsFKscrjmw4Clf31H71srrF8tCLZyPdMpg=
X-Received: by 2002:a17:90a:ec8c:b0:2ff:6e72:b8e9 with SMTP id 98e67ed59e1d1-3030fee7104mr34945067a91.25.1742992233907;
        Wed, 26 Mar 2025 05:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENhAMc3YEZ16YS5Hn9AKnW3lSqkO1WfZupLXyfCcU2r3XX6V/bDRqpagDOibCkDJsx9sj5B4/JsX9eOaiRgPA=
X-Received: by 2002:a17:90a:ec8c:b0:2ff:6e72:b8e9 with SMTP id
 98e67ed59e1d1-3030fee7104mr34944996a91.25.1742992233257; Wed, 26 Mar 2025
 05:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-7-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-7-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:29:57 +0100
X-Gm-Features: AQ5f1JpJ342Eh2KHZtcoMs5FNlOUTtFbR-VB9AcdClCRputrNawo7spgsqwBruw
Message-ID: <CAJaqyWeE2FnhF5kMV2NneWa4Fp6NK03NO=h_BcB1=3JUDpjUiA@mail.gmail.com>
Subject: Re: [PATCH 06/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_add variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wV5ngdWxMojsUbPGdz_YWEbNaLGwGSJZv4OhB5h60Nw_1742992234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cf3ab6404698..619869e80309 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -472,7 +472,7 @@ static unsigned int vring_unmap_one_split(const struc=
t vring_virtqueue *vq,
>         return extra->next;
>  }
>
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *v=
q,
>                                                unsigned int total_sg,
>                                                gfp_t gfp)
>  {
> @@ -501,7 +501,7 @@ static struct vring_desc *alloc_indirect_split(struct=
 virtqueue *_vq,
>         return desc;
>  }
>
> -static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq=
,
> +static inline unsigned int virtqueue_add_desc_split(struct vring_virtque=
ue *vq,
>                                                     struct vring_desc *de=
sc,
>                                                     struct vring_desc_ext=
ra *extra,
>                                                     unsigned int i,
> @@ -509,11 +509,12 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
>                                                     unsigned int len,
>                                                     u16 flags, bool prema=
pped)
>  {
> +       struct virtio_device *vdev =3D vq->vq.vdev;
>         u16 next;
>
> -       desc[i].flags =3D cpu_to_virtio16(vq->vdev, flags);
> -       desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
> -       desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
> +       desc[i].flags =3D cpu_to_virtio16(vdev, flags);
> +       desc[i].addr =3D cpu_to_virtio64(vdev, addr);
> +       desc[i].len =3D cpu_to_virtio32(vdev, len);
>
>         extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
>         extra[i].len =3D len;
> @@ -521,12 +522,12 @@ static inline unsigned int virtqueue_add_desc_split=
(struct virtqueue *vq,
>
>         next =3D extra[i].next;
>
> -       desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
> +       desc[i].next =3D cpu_to_virtio16(vdev, next);
>
>         return next;
>  }
>
> -static inline int virtqueue_add_split(struct virtqueue *_vq,
> +static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>                                       struct scatterlist *sgs[],
>                                       unsigned int total_sg,
>                                       unsigned int out_sgs,
> @@ -536,7 +537,6 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                                       bool premapped,
>                                       gfp_t gfp)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct vring_desc_extra *extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
> @@ -561,7 +561,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         head =3D vq->free_head;
>
>         if (virtqueue_use_indirect(vq, total_sg))
> -               desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> +               desc =3D alloc_indirect_split(vq, total_sg, gfp);
>         else {
>                 desc =3D NULL;
>                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indir=
ect);
> @@ -608,7 +608,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> +                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
>                                                      VRING_DESC_F_NEXT,
>                                                      premapped);
>                 }
> @@ -625,14 +625,14 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
> -                       i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, len,
> +                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
>                                                      VRING_DESC_F_NEXT |
>                                                      VRING_DESC_F_WRITE,
>                                                      premapped);
>                 }
>         }
>         /* Last one doesn't continue. */
> -       desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> +       desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
>         if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
>                         ~VRING_DESC_F_NEXT;
> @@ -645,7 +645,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                 if (vring_mapping_error(vq, addr))
>                         goto unmap_release;
>
> -               virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> +               virtqueue_add_desc_split(vq, vq->split.vring.desc,
>                                          vq->split.desc_extra,
>                                          head, addr,
>                                          total_sg * sizeof(struct vring_d=
esc),
> @@ -671,13 +671,13 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>         /* Put entry in available array (but don't update avail->idx unti=
l they
>          * do sync). */
>         avail =3D vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> -       vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(_vq->vdev,=
 head);
> +       vq->split.vring.avail->ring[avail] =3D cpu_to_virtio16(vq->vq.vde=
v, head);
>
>         /* Descriptors and available array need to be set before we expos=
e the
>          * new available array entries. */
>         virtio_wmb(vq->weak_barriers);
>         vq->split.avail_idx_shadow++;
> -       vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
> +       vq->split.vring.avail->idx =3D cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_idx_shado=
w);
>         vq->num_added++;
>
> @@ -687,7 +687,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         /* This is very unlikely, but theoretically possible.  Kick
>          * just in case. */
>         if (unlikely(vq->num_added =3D=3D (1 << 16) - 1))
> -               virtqueue_kick(_vq);
> +               virtqueue_kick(&vq->vq);
>
>         return 0;
>
> @@ -702,7 +702,6 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> -
>                 i =3D vring_unmap_one_split(vq, &extra[i]);
>         }
>
> @@ -1441,7 +1440,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         return -ENOMEM;
>  }
>
> -static inline int virtqueue_add_packed(struct virtqueue *_vq,
> +static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>                                        struct scatterlist *sgs[],
>                                        unsigned int total_sg,
>                                        unsigned int out_sgs,
> @@ -1451,7 +1450,6 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                                        bool premapped,
>                                        gfp_t gfp)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, c, descs_used, err_idx, len;
> @@ -2263,9 +2261,9 @@ static inline int virtqueue_add(struct virtqueue *_=
vq,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
> +       return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
>                                         out_sgs, in_sgs, data, ctx, prema=
pped, gfp) :
> -                                virtqueue_add_split(_vq, sgs, total_sg,
> +                                virtqueue_add_split(vq, sgs, total_sg,
>                                         out_sgs, in_sgs, data, ctx, prema=
pped, gfp);
>  }
>
> --
> 2.42.0
>

