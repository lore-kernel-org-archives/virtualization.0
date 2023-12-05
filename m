Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488415481
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fxh/Qvoa"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 208C2821AB
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 208C2821AB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fxh/Qvoa
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F03otmowZ7wM
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 07:12:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B86282197
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B86282197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701760339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFq15hHkVnxmyhCAcLm2BpVJs+0GNqy27ILIQPZtlGk=;
	b=Fxh/QvoavRV6KkL3JqgsmmtS3ZGjWTBWSE2NSgK8hxcNr/TwzqWOhzM+h1SlkpT94wm2Bt
	ApOEeo3KMHrfcn21SFLeRPluVttADBOeylfkNDAFOpWVmjoGAWsjN0pSD3EFLhVViDTzVU
	15U4TJ04/ew3WFWdPzRF1xrNRD/L8+g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-ACJEcIG7NoCF56_gVC1N9A-1; Tue, 05 Dec 2023 02:12:18 -0500
X-MC-Unique: ACJEcIG7NoCF56_gVC1N9A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bf7c5c732so1405986e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 23:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701760336; x=1702365136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFq15hHkVnxmyhCAcLm2BpVJs+0GNqy27ILIQPZtlGk=;
        b=KuYCCSYAurjJHX3yZ/EmhE0Hkp1UX0hekx4jdzNMRMm1YLNF3TeVKOsF0ad6KPky41
         oc9H9aRC03uVmvpiRdQn7DSRQmHoLZ0eAXliplKTQrea3l4bfnv/ADpNE0yHlPpsR+d7
         dEONEAhGV5nW7zOyDKdfpzzj9dp9eOYBG0Hm1CDWDEJbP66C6rR3I4Z/uMZAGtWhpVqo
         Zy4BywzlL6aP3B0NPm1MpElUhXuLfcc0IaN/vMqF2Lrb+5UHECk6E5lBdGGNUiobzQTc
         fxbrTgtSfOcgQhnJAYZD1ef3xtdLGi8uj0ivxCsxFMJLLz7Dt3RQLNIMKGOsWZ0QcL68
         yWLw==
X-Gm-Message-State: AOJu0YxhzNlmrPPLH08Xj/V581tgpE4nUOsL4p8hxTrQ8xkAc7Q0Cdh3
	IblYqWDB4pi6/7pvShSVImZzMzt1ke29JIVMWkeKAlPK48rfjRBWCFYsiPyhuTtA5fYKN5EvBKr
	wIVn8fUIShGQqHcuyGcrblX568s9cthVGJGcnrEH/qf0Cfddnt/sHLAxXCuO8zmwP+NhBmgs=
X-Received: by 2002:ac2:52b8:0:b0:50b:e73c:ff55 with SMTP id r24-20020ac252b8000000b0050be73cff55mr806422lfm.250.1701760336429;
        Mon, 04 Dec 2023 23:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiUh40h6VFz7b+AEtZfcHeuvX/iAS9BCaELMJuw3PPnOziKOTGAhAKjWfFPhlOFku3PcAg4L8FwD0T2pWJSQI=
X-Received: by 2002:ac2:52b8:0:b0:50b:e73c:ff55 with SMTP id
 r24-20020ac252b8000000b0050be73cff55mr806417lfm.250.1701760335890; Mon, 04
 Dec 2023 23:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com> <20231204072331.73776-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231204072331.73776-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Dec 2023 15:12:03 +0800
Message-ID: <CACGkMEtGob7VDCgmGoLxR0FpAngKVx8iAVWcQ1v3gCFzeMg_hw@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
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
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 157 +++++++++++++++++++++++------------
>  include/linux/virtio.h       |  16 ++++
>  2 files changed, 121 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..103d181f05bb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -362,6 +362,26 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>         return vq->dma_dev;
>  }
>
> +static void collect_dma_info(const struct vring_virtqueue *vq,

Not a native speaker, but it looks to me like "get_dma_info" is better here=
.

> +                            struct virtio_dma_head *dma,
> +                            dma_addr_t addr, unsigned int length)
> +{
> +       if (WARN_ON_ONCE(!dma))
> +               return;

So all the callers did:

if (!vq->do_unmap)
    collect_dma_info()

It's a strong hint that we should move the vq->do_unmap inside
collect_dma_info()?

> +
> +       if (unlikely(dma->next >=3D dma->num)) {
> +               dev_warn_once(&vq->vq.vdev->dev,
> +                             "premapped vq: collect dma miss: %pad %u\n"=
,
> +                             &addr, length);

Let's use BAD_RING() for consistency.

Btw, the message seems ambiguous here.

> +               return;
> +       }
> +
> +       dma->items[dma->next].addr =3D addr;
> +       dma->items[dma->next].length =3D length;
> +
> +       ++dma->next;
> +}
> +
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
> @@ -441,12 +461,17 @@ static void virtqueue_init(struct vring_virtqueue *=
vq, u32 num)
>   */
>
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue =
*vq,
> -                                          const struct vring_desc *desc)
> +                                          const struct vring_desc *desc,
> +                                          struct virtio_dma_head *dma)
>  {
>         u16 flags;
>
> -       if (!vq->do_unmap)
> +       if (!vq->do_unmap) {
> +               collect_dma_info(vq, dma,
> +                                virtio64_to_cpu(vq->vq.vdev, desc->addr)=
,
> +                                virtio32_to_cpu(vq->vq.vdev, desc->len))=
;
>                 return;
> +       }
>
>         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
>
> @@ -458,7 +483,7 @@ static void vring_unmap_one_split_indirect(const stru=
ct vring_virtqueue *vq,
>  }
>
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *=
vq,
> -                                         unsigned int i)
> +                                         unsigned int i, struct virtio_d=
ma_head *dma)
>  {
>         struct vring_desc_extra *extra =3D vq->split.desc_extra;
>         u16 flags;
> @@ -466,18 +491,15 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>         flags =3D extra[i].flags;
>
>         if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       goto out;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra[i].addr,
> -                                extra[i].len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +               if (vq->use_dma_api)
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra[i].addr,
> +                                        extra[i].len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +       } else if (!vq->do_unmap) {
> +               collect_dma_info(vq, dma, extra[i].addr, extra[i].len);
>         } else {
> -               if (!vq->do_unmap)
> -                       goto out;
> -
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra[i].addr,
>                                extra[i].len,
> @@ -485,7 +507,6 @@ static unsigned int vring_unmap_one_split(const struc=
t vring_virtqueue *vq,
>                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         }
>
> -out:
>         return extra[i].next;
>  }
>
> @@ -717,10 +738,10 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                 if (i =3D=3D err_idx)
>                         break;
>                 if (indirect) {
> -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> +                       vring_unmap_one_split_indirect(vq, &desc[i], NULL=
);

So this will trigger the WARN_ON_ONCE() in collect_dma_info()?

>                         i =3D virtio16_to_cpu(_vq->vdev, desc[i].next);
>                 } else
> -                       i =3D vring_unmap_one_split(vq, i);
> +                       i =3D vring_unmap_one_split(vq, i, NULL);
>         }
>
>  free_indirect:
> @@ -763,7 +784,7 @@ static bool virtqueue_kick_prepare_split(struct virtq=
ueue *_vq)
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
> @@ -775,12 +796,12 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>         i =3D head;
>
>         while (vq->split.vring.desc[i].flags & nextflag) {
> -               vring_unmap_one_split(vq, i);
> +               vring_unmap_one_split(vq, i, dma);
>                 i =3D vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
>
> -       vring_unmap_one_split(vq, i);
> +       vring_unmap_one_split(vq, i, dma);
>         vq->split.desc_extra[i].next =3D vq->free_head;
>         vq->free_head =3D head;
>
> @@ -802,10 +823,8 @@ static void detach_buf_split(struct vring_virtqueue =
*vq, unsigned int head,
>                                 VRING_DESC_F_INDIRECT));
>                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
>
> -               if (vq->do_unmap) {
> -                       for (j =3D 0; j < len / sizeof(struct vring_desc)=
; j++)
> -                               vring_unmap_one_split_indirect(vq, &indir=
_desc[j]);
> -               }
> +               for (j =3D 0; j < len / sizeof(struct vring_desc); j++)
> +                       vring_unmap_one_split_indirect(vq, &indir_desc[j]=
, dma);
>
>                 kfree(indir_desc);
>                 vq->split.desc_state[head].indir_desc =3D NULL;
> @@ -822,6 +841,7 @@ static bool more_used_split(const struct vring_virtqu=
eue *vq)
>
>  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>                                          unsigned int *len,
> +                                        struct virtio_dma_head *dma,
>                                          void **ctx)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> @@ -862,7 +882,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtq=
ueue *_vq,
>
>         /* detach_buf_split clears data, so grab it now. */
>         ret =3D vq->split.desc_state[i].data;
> -       detach_buf_split(vq, i, ctx);
> +       detach_buf_split(vq, i, dma, ctx);
>         vq->last_used_idx++;
>         /* If we expect an interrupt for the next entry, tell host
>          * by writing event index and flush out the write before
> @@ -984,7 +1004,7 @@ static void *virtqueue_detach_unused_buf_split(struc=
t virtqueue *_vq)
>                         continue;
>                 /* detach_buf_split clears data, so grab it now. */
>                 buf =3D vq->split.desc_state[i].data;
> -               detach_buf_split(vq, i, NULL);
> +               detach_buf_split(vq, i, NULL, NULL);
>                 vq->split.avail_idx_shadow--;
>                 vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->vdev,
>                                 vq->split.avail_idx_shadow);
> @@ -1221,7 +1241,8 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -                                    const struct vring_desc_extra *extra=
)
> +                                    const struct vring_desc_extra *extra=
,
> +                                    struct virtio_dma_head *dma)
>  {
>         u16 flags;
>
> @@ -1235,10 +1256,9 @@ static void vring_unmap_extra_packed(const struct =
vring_virtqueue *vq,
>                                  extra->addr, extra->len,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +       } else if (!vq->do_unmap) {
> +               collect_dma_info(vq, dma, extra->addr, extra->len);
>         } else {
> -               if (!vq->do_unmap)
> -                       return;
> -
>                 dma_unmap_page(vring_dma_dev(vq),
>                                extra->addr, extra->len,
>                                (flags & VRING_DESC_F_WRITE) ?
> @@ -1247,12 +1267,15 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>  }
>
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -                                   const struct vring_packed_desc *desc)
> +                                   const struct vring_packed_desc *desc,
> +                                   struct virtio_dma_head *dma)
>  {
>         u16 flags;
>
> -       if (!vq->do_unmap)
> +       if (!vq->do_unmap) {
> +               collect_dma_info(vq, dma, le64_to_cpu(desc->addr), le32_t=
o_cpu(desc->len));
>                 return;
> +       }
>
>         flags =3D le16_to_cpu(desc->flags);
>
> @@ -1389,7 +1412,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         err_idx =3D i;
>
>         for (i =3D 0; i < err_idx; i++)
> -               vring_unmap_desc_packed(vq, &desc[i]);
> +               vring_unmap_desc_packed(vq, &desc[i], NULL);
>
>  free_desc:
>         kfree(desc);
> @@ -1539,7 +1562,7 @@ static inline int virtqueue_add_packed(struct virtq=
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
> @@ -1600,7 +1623,9 @@ static bool virtqueue_kick_prepare_packed(struct vi=
rtqueue *_vq)
>  }
>
>  static void detach_buf_packed(struct vring_virtqueue *vq,
> -                             unsigned int id, void **ctx)
> +                             unsigned int id,
> +                             struct virtio_dma_head *dma,
> +                             void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
> @@ -1615,13 +1640,10 @@ static void detach_buf_packed(struct vring_virtqu=
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
, dma);
> +               curr =3D vq->packed.desc_extra[curr].next;

I wonder if !dma && vq->do_unmap is valid, we need to document it somewhere=
.

And we can keep the unlikely() optimization as is.


>         }
>
>         if (vq->indirect) {
> @@ -1632,12 +1654,9 @@ static void detach_buf_packed(struct vring_virtque=
ue *vq,
>                 if (!desc)
>                         return;
>
> -               if (vq->do_unmap) {
> -                       len =3D vq->packed.desc_extra[id].len;
> -                       for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc);
> -                                       i++)
> -                               vring_unmap_desc_packed(vq, &desc[i]);
> -               }
> +               len =3D vq->packed.desc_extra[id].len;
> +               for (i =3D 0; i < len / sizeof(struct vring_packed_desc);=
 i++)
> +                       vring_unmap_desc_packed(vq, &desc[i], dma);
>                 kfree(desc);
>                 state->indir_desc =3D NULL;
>         } else if (ctx) {
> @@ -1672,6 +1691,7 @@ static bool more_used_packed(const struct vring_vir=
tqueue *vq)
>
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>                                           unsigned int *len,
> +                                         struct virtio_dma_head *dma,
>                                           void **ctx)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> @@ -1712,7 +1732,7 @@ static void *virtqueue_get_buf_ctx_packed(struct vi=
rtqueue *_vq,
>
>         /* detach_buf_packed clears data, so grab it now. */
>         ret =3D vq->packed.desc_state[id].data;
> -       detach_buf_packed(vq, id, ctx);
> +       detach_buf_packed(vq, id, dma, ctx);
>
>         last_used +=3D vq->packed.desc_state[id].num;
>         if (unlikely(last_used >=3D vq->packed.vring.num)) {
> @@ -1877,7 +1897,7 @@ static void *virtqueue_detach_unused_buf_packed(str=
uct virtqueue *_vq)
>                         continue;
>                 /* detach_buf clears data, so grab it now. */
>                 buf =3D vq->packed.desc_state[i].data;
> -               detach_buf_packed(vq, i, NULL);
> +               detach_buf_packed(vq, i, NULL, NULL);
>                 END_USE(vq);
>                 return buf;
>         }
> @@ -2417,11 +2437,44 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq=
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
> + * @dma: the head of the array to store the dma info
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
> + * We store the dma info of every descriptor of this buf to the dma->ite=
ms
> + * array. If the array size is too small, some dma info may be missed, s=
o
> + * the caller must ensure the array is enough.

large enough?

> The dma->next is the out value
> + * to the caller,

What do you mean by "out value to the caller" ?

Thanks


> indicates the num of the used items.
> + *
> + * Returns NULL if there are no used buffers, or the "data" token
> + * handed to virtqueue_add_*().
> + */
> +void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len=
,
> +                               struct virtio_dma_head *dma, void **ctx)
> +{
> +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, d=
ma, ctx) :
> +                                virtqueue_get_buf_ctx_split(_vq, len, dm=
a, ctx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx_dma);
> +
>  void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
>  {
>         return virtqueue_get_buf_ctx(_vq, len, NULL);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 4cc614a38376..572aecec205b 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -75,6 +75,22 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned=
 int *len);
>  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
>                             void **ctx);
>
> +struct virtio_dma_item {
> +       dma_addr_t addr;
> +       unsigned int length;
> +};
> +
> +struct virtio_dma_head {
> +       /* total num of items. */
> +       u16 num;
> +       /* point to the next item to store dma info. */
> +       u16 next;
> +       struct virtio_dma_item items[];
> +};
> +
> +void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned int *len=
,
> +                               struct virtio_dma_head *dma, void **ctx);
> +
>  void virtqueue_disable_cb(struct virtqueue *vq);
>
>  bool virtqueue_enable_cb(struct virtqueue *vq);
> --
> 2.32.0.3.g01195cf9f
>

