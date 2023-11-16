Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665D101EE
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbQBI1uT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFFB481E6B
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFFB481E6B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LbQBI1uT
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OOkIFX6Jkcov
	for <virtualization@lists.linux-foundation.org>;
	Thu, 16 Nov 2023 08:11:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 97C6181CA7
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 08:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97C6181CA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700122287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHEZXU279XsymetKNDPrmelQKKb1BmviqcLgfe4YpqI=;
	b=LbQBI1uTopN7Z3IgXqBNuN+yrtIsE49yrgyJ3IXZLlHGogfXTlLmV0+vlX/eNON0t1JZmv
	LoBJnx0T9BnUnde/bCM+jeJMPYl48jFhtYgdU6iSBsr2qoIuSt+xZzZd5oW6+dISWLL4Gs
	bMxMTiZ7PoqnOywZq9AN7h+tpRHr3fw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-GiAguf6pNUGpH6zLcYAH0w-1; Thu, 16 Nov 2023 03:11:25 -0500
X-MC-Unique: GiAguf6pNUGpH6zLcYAH0w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507cee14477so500432e87.3
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Nov 2023 00:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700122284; x=1700727084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHEZXU279XsymetKNDPrmelQKKb1BmviqcLgfe4YpqI=;
        b=UPW0wALQIvJk80ifE/SHayynsfEKQAEJ+lHUOn1yCxb3b5Vi7r+ejfwNzB8MMPF382
         t4SGOABdesROuDuc7zDyjjma1bOH4pJ01neg2+LKTDsJmG/8QjpJ61c7x7gwWeyaUHcD
         n+ct/5sCfU2NpHTXaXi3eHVS6WH1wDUKPEeoUUw4idEG3CQybGhgXpdfUyJ0x6uZgJOA
         jsQ6jsRmHBEFwJ6fy8mY4O5hVEcZfShiljT6AewCnR7mp9ouHvv0OFisLmyVFIJw5iRv
         cWH4GcNgem2+c3Get5C2tqOhK7bAMw2rT/XTa0s/bySJmfEUpiOh/fEcBOS+15gsQalq
         jQvg==
X-Gm-Message-State: AOJu0Ywtg75jZGSKqPmeYEayCuFm5ixbcYwxoGxTZo6YHFUXNDQjrdj6
	EeFVgBk+yViMyzy6dYKZZqyJxtnbJx0hpepCQZMnaV+W7zQzt+Bv4Qx5TPGJCFx3wSFnK55zFft
	jObpMSul52TNmTqFKDTroWB0MAJ8ZbrzfB15tZB3NoiIUmLWAH2PthKGdaw==
X-Received: by 2002:a05:6512:12cf:b0:509:d962:3c67 with SMTP id p15-20020a05651212cf00b00509d9623c67mr13130767lfg.20.1700122284057;
        Thu, 16 Nov 2023 00:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHERUKwTSqHe39xVYgjtCE99Vz3bHMSZb4xZumaspBlli+fI23I74Hvtz89O2J6p/mpR/KHQ9Xf/MniK7aZWvk=
X-Received: by 2002:a05:6512:12cf:b0:509:d962:3c67 with SMTP id
 p15-20020a05651212cf00b00509d9623c67mr13130746lfg.20.1700122283570; Thu, 16
 Nov 2023 00:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com> <20231114113104.33994-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231114113104.33994-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Nov 2023 16:11:11 +0800
Message-ID: <CACGkMEtYxbXwJUVwz-OcT1LybEpHcgWXCzpmrFPgGJo_yP9LWA@mail.gmail.com>
Subject: Re: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc. Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.

So looking at vring_desc_extra, what we have right now is:

struct vring_desc_extra {
        dma_addr_t addr;                /* Descriptor DMA addr. */
        u32 len;                        /* Descriptor length. */
        u16 flags;                      /* Descriptor flags. */
        u16 next;                       /* The next desc state in a list. *=
/
};

And sg is

struct scatterlist {
        unsigned long   page_link;
unsigned int    offset;
        unsigned int    length;
        dma_addr_t      dma_address;
#ifdef CONFIG_NEED_SG_DMA_LENGTH
        unsigned int    dma_length;
#endif
#ifdef CONFIG_NEED_SG_DMA_FLAGS
        unsigned int    dma_flags;
#endif
};

Would it better just store sg?

More below

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 148 ++++++++++++++++++++++++++---------
>  include/linux/virtio.h       |   2 +
>  2 files changed, 115 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..0b3caee4ef9d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -362,6 +362,20 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +static void store_dma_to_sg(struct scatterlist **sgp, dma_addr_t addr, u=
nsigned int length)
> +{
> +       struct scatterlist *sg;
> +
> +       sg =3D *sgp;
> +
> +       sg->dma_address =3D addr;
> +       sg->length =3D length;
> +
> +       sg =3D sg_next(sg);
> +
> +       *sgp =3D sg;
> +}
> +
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
> @@ -441,12 +455,18 @@ static void virtqueue_init(struct vring_virtqueue *=
vq, u32 num)
>   */
>
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue =
*vq,
> -                                          const struct vring_desc *desc)
> +                                          const struct vring_desc *desc,
> +                                          struct scatterlist **sg)
>  {
>         u16 flags;
>
> -       if (!vq->do_unmap)
> +       if (!vq->do_unmap) {
> +               if (*sg)

Can we simply move the

if (*sg) to store_dma_to_sg()?

> +                       store_dma_to_sg(sg,
> +                                       virtio64_to_cpu(vq->vq.vdev, desc=
->addr),
> +                                       virtio32_to_cpu(vq->vq.vdev, desc=
->len));
>                 return;
> +       }
>
>         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
>
> @@ -458,7 +478,7 @@ static void vring_unmap_one_split_indirect(const stru=
ct vring_virtqueue *vq,
>  }
>
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *=
vq,
> -                                         unsigned int i)
> +                                         unsigned int i, struct scatterl=
ist **sg)
>  {
>         struct vring_desc_extra *extra =3D vq->split.desc_extra;
>         u16 flags;
> @@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_split(const stru=
ct vring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> -               if (!vq->do_unmap)
> +               if (!vq->do_unmap) {

The:

else {
      if {
            if {
}

seems odd. I think I would prefer

if (flags & VRING_DESC_F_INDIRECT) {
} else if (!vq->do_unmap) {
} else {
}

here

Btw, I really think do_unmap is not a good name, we probably need to
rename it as "unmap_desc".


> +                       if (*sg)
> +                               store_dma_to_sg(sg, extra[i].addr, extra[=
i].len);

In which case we need to unmap by driver but we don't need a dma address?

>                         goto out;
> +               }
>
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra[i].addr,
> @@ -717,10 +740,10 @@ static inline int virtqueue_add_split(struct virtqu=
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
> @@ -763,7 +786,7 @@ static bool virtqueue_kick_prepare_split(struct virtq=
ueue *_vq)
>  }
>
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int he=
ad,
> -                            void **ctx)
> +                            struct scatterlist *sg, void **ctx)
>  {
>         unsigned int i, j;
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
> @@ -775,12 +798,12 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>         i =3D head;
>
>         while (vq->split.vring.desc[i].flags & nextflag) {
> -               vring_unmap_one_split(vq, i);
> +               vring_unmap_one_split(vq, i, &sg);
>                 i =3D vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
>
> -       vring_unmap_one_split(vq, i);
> +       vring_unmap_one_split(vq, i, &sg);
>         vq->split.desc_extra[i].next =3D vq->free_head;
>         vq->free_head =3D head;
>
> @@ -794,7 +817,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
>                 if (!indir_desc)
> -                       return;
> +                       goto end;
>
>                 len =3D vq->split.desc_extra[head].len;
>
> @@ -802,9 +825,10 @@ static void detach_buf_split(struct vring_virtqueue =
*vq, unsigned int head,
>                                 VRING_DESC_F_INDIRECT));
>                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
>
> -               if (vq->do_unmap) {
> +               if (vq->do_unmap || sg) {
>                         for (j =3D 0; j < len / sizeof(struct vring_desc)=
; j++)
> -                               vring_unmap_one_split_indirect(vq, &indir=
_desc[j]);
> +                               vring_unmap_one_split_indirect(vq, &indir=
_desc[j], &sg);
> +
>                 }
>
>                 kfree(indir_desc);
> @@ -812,6 +836,11 @@ static void detach_buf_split(struct vring_virtqueue =
*vq, unsigned int head,
>         } else if (ctx) {
>                 *ctx =3D vq->split.desc_state[head].indir_desc;
>         }
> +
> +end:
> +       /* sg point to the next. So we mark the last one as the end. */
> +       if (!vq->do_unmap && sg)
> +               sg_mark_end(sg - 1);
>  }
>
>  static bool more_used_split(const struct vring_virtqueue *vq)
> @@ -822,6 +851,7 @@ static bool more_used_split(const struct vring_virtqu=
eue *vq)
>
>  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>                                          unsigned int *len,
> +                                        struct scatterlist *sg,
>                                          void **ctx)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> @@ -862,7 +892,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>
>         /* detach_buf_split clears data, so grab it now. */
>         ret =3D vq->split.desc_state[i].data;
> -       detach_buf_split(vq, i, ctx);
> +       detach_buf_split(vq, i, sg, ctx);
>         vq->last_used_idx++;
>         /* If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
> @@ -984,7 +1014,7 @@ static void *virtqueue_detach_unused_buf_split(struc=
t virtqueue *_vq)
>                         continue;
>                 /* detach_buf_split clears data, so grab it now. */
>                 buf =3D vq->split.desc_state[i].data;
> -               detach_buf_split(vq, i, NULL);
> +               detach_buf_split(vq, i, NULL, NULL);
>                 vq->split.avail_idx_shadow--;
>                 vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
>                                 vq->split.avail_idx_shadow);
> @@ -1221,7 +1251,8 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -                                    const struct vring_desc_extra *extra=
)
> +                                    const struct vring_desc_extra *extra=
,
> +                                    struct scatterlist **sg)
>  {
>         u16 flags;
>
> @@ -1236,8 +1267,11 @@ static void vring_unmap_extra_packed(const struct =
vring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> -               if (!vq->do_unmap)
> +               if (!vq->do_unmap) {
> +                       if (*sg)
> +                               store_dma_to_sg(sg, extra->addr, extra->l=
en);
>                         return;
> +               }
>
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra->addr, extra->len,
> @@ -1247,12 +1281,17 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>  }
>
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -                                   const struct vring_packed_desc *desc)
> +                                   const struct vring_packed_desc *desc,
> +                                   struct scatterlist **sg)
>  {

Interesting, I think this is only needed for indirect descriptors?

If yes, why do we care about the dma addresses of indirect descriptors?
If not, it's a bug that we should use desc_extra, otherwise it's a
device-triggerable unmap which has security implications (we need to
use vring_extra in this case).

 >         u16 flags;
>
> -       if (!vq->do_unmap)
> +       if (!vq->do_unmap) {
> +               if (*sg)
> +                       store_dma_to_sg(sg, le64_to_cpu(desc->addr),
> +                                       le32_to_cpu(desc->len));
>                 return;
> +       }
>
>         flags =3D le16_to_cpu(desc->flags);
>
> @@ -1389,7 +1428,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         err_idx =3D i;
>
>         for (i =3D 0; i < err_idx; i++)
> -               vring_unmap_desc_packed(vq, &desc[i]);
> +               vring_unmap_desc_packed(vq, &desc[i], NULL);
>
>  free_desc:
>         kfree(desc);
> @@ -1539,7 +1578,7 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> -               vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]=
);
> +               vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]=
, NULL);
>                 curr =3D vq->packed.desc_extra[curr].next;
>                 i++;
>                 if (i >=3D vq->packed.vring.num)
> @@ -1600,7 +1639,9 @@ static bool virtqueue_kick_prepare_packed(struct vi=
rtqueue *_vq)
>  }
>
>  static void detach_buf_packed(struct vring_virtqueue *vq,
> -                             unsigned int id, void **ctx)
> +                             unsigned int id,
> +                             struct scatterlist *sg,
> +                             void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
> @@ -1615,13 +1656,10 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->do_unmap)) {
> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> -               }
> +       curr =3D id;
> +       for (i =3D 0; i < state->num; i++) {
> +               vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]=
, &sg);
> +               curr =3D vq->packed.desc_extra[curr].next;
>         }

Looks like an independent fix or cleanup?


>
>         if (vq->indirect) {
> @@ -1630,19 +1668,24 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
>                 desc =3D state->indir_desc;
>                 if (!desc)
> -                       return;
> +                       goto end;
>
> -               if (vq->do_unmap) {
> +               if (vq->do_unmap || sg) {
>                         len =3D vq->packed.desc_extra[id].len;
>                         for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc);
>                                         i++)
> -                               vring_unmap_desc_packed(vq, &desc[i]);
> +                               vring_unmap_desc_packed(vq, &desc[i], &sg=
);
>                 }
>                 kfree(desc);
>                 state->indir_desc =3D NULL;
>         } else if (ctx) {
>                 *ctx =3D state->indir_desc;
>         }
> +
> +end:
> +       /* sg point to the next. So we mark the last one as the end. */
> +       if (!vq->do_unmap && sg)
> +               sg_mark_end(sg - 1);
>  }
>
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> @@ -1672,6 +1715,7 @@ static bool more_used_packed(const struct vring_vir=
tqueue *vq)
>
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>                                           unsigned int *len,
> +                                         struct scatterlist *sg,
>                                           void **ctx)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> @@ -1712,7 +1756,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>
>         /* detach_buf_packed clears data, so grab it now. */
>         ret =3D vq->packed.desc_state[id].data;
> -       detach_buf_packed(vq, id, ctx);
> +       detach_buf_packed(vq, id, sg, ctx);
>
>         last_used +=3D vq->packed.desc_state[id].num;
>         if (unlikely(last_used >=3D vq->packed.vring.num)) {
> @@ -1877,7 +1921,7 @@ static void *virtqueue_detach_unused_buf_packed(str=
uct virtqueue *_vq)
>                         continue;
>                 /* detach_buf clears data, so grab it now. */
>                 buf =3D vq->packed.desc_state[i].data;
> -               detach_buf_packed(vq, i, NULL);
> +               detach_buf_packed(vq, i, NULL, NULL);
>                 END_USE(vq);
>                 return buf;
>         }
> @@ -2417,11 +2461,45 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq=
, unsigned int *len,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, c=
tx) :
> -                                virtqueue_get_buf_ctx_split(_vq, len, ct=
x);
> +       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, N=
ULL, ctx) :
> +                                virtqueue_get_buf_ctx_split(_vq, len, NU=
LL, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>
> +/**
> + * virtqueue_get_buf_ctx_dma - get the next used buffer with the dma inf=
o
> + * @_vq: the struct virtqueue we're talking about.
> + * @len: the length written into the buffer
> + * @sg: scatterlist array to store the dma info
> + * @ctx: extra context for the token
> + *
> + * If the device wrote data into the buffer, @len will be set to the
> + * amount written.  This means you don't need to clear the buffer
> + * beforehand to ensure there's no data leakage in the case of short
> + * writes.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Only when the vq is in premapped mode and the sg is not null,

So let's fail if the caller is not in those state?

> we store the
> + * dma info of every descriptor of this buf to the sg array. The sg arra=
y must
> + * point to a scatterlist array, with the last element marked as the sg =
last.
> + * Once the function is done, we mark the last sg stored with dma info a=
s the
> + * last one. If the sg array size is too small, some dma info may be mis=
sed.
> + *
> + * Returns NULL if there are no used buffers, or the "data" token
> + * handed to virtqueue_add_*().
> + */
> +void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len=
,
> +                               struct scatterlist *sg, void **ctx)

Or maybe get_buf_ctx_sg() ?

Thanks


> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, s=
g, ctx) :
> +                                virtqueue_get_buf_ctx_split(_vq, len, sg=
, ctx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx_dma);
> +
>  void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  {
>         return virtqueue_get_buf_ctx(_vq, len, NULL);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 4cc614a38376..0b919786ade5 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -74,6 +74,8 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned =
int *len);
>
>  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
>                             void **ctx);
> +void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len=
,
> +                               struct scatterlist *sg, void **ctx);
>
>  void virtqueue_disable_cb(struct virtqueue *vq);
>
> --
> 2.32.0.3.g01195cf9f
>

