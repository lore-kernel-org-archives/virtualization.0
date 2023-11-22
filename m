Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216C156D9
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShJeb/mn"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0224A4033F
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 06:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0224A4033F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ShJeb/mn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cmAUyszCGiZH
	for <virtualization@lists.linux-foundation.org>;
	Wed, 22 Nov 2023 06:03:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4297D402A8
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 06:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4297D402A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700633029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQRCKnJXMQ/ZqPDefEh9LAc41YPtySFFdrC77EsFBGI=;
	b=ShJeb/mnsl1joVL2kLbmFm6Xl0xPXMO6maQOi/bmfjxVhqDQN6M/8An6dppaEJVKb/JsFw
	yLvWNfipSxyoI/0fzrElczpKohj+uFG+5Ts1MLocK6E293VaiAQtcaLOHyA2gJyX4B0a+6
	/vHrU13hnUbNUDIm7rRvuM2VjsJVuWM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-4PbFQjzlNmyGes19ocOnXg-1; Wed, 22 Nov 2023 01:03:47 -0500
X-MC-Unique: 4PbFQjzlNmyGes19ocOnXg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50aa7e5bd0aso4014843e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 22:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700633026; x=1701237826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQRCKnJXMQ/ZqPDefEh9LAc41YPtySFFdrC77EsFBGI=;
        b=s5PjBfI5CDdN0K+6OKiXkvUD1+63YeJqDnUMpqQQ0dkMKT69embgS5v/unihVJj9D+
         pj1PCbtxJrZ2aN5/xSozvDOF3fkPGhtl7l9k3T5+yjIK1JY9bj3r1jwAQ7V/xxKTjhOa
         NUe7f18ek1kKqzYnz0qw4LFTxWUsnptTUPa03adqgPNjJsNsWtn1433+6/m+J2ZQmSA2
         RwMEigeqgcXQ8iAhz9ALLWpnofyP9VYVVhpBCo3xeKRHqKqUfQdE6X13l11qVVOEjGSo
         oULAMTfLny7/W8KtO8U+iw/tiqqfj6ORspbJW1VvjeQjqztDV0YfK5emLKABlDe6k/zA
         0qog==
X-Gm-Message-State: AOJu0Yz4pZ4ZBqVgjwxCVjD4hkZDvJM6+Ln2GLGg9ET7AZJ3yczbfBsd
	DBmXi+AaiOtnCPk+zeBbEVbNCLHV8gj6EjXJHkEGeI4d/aP7ZEy28Pa8E4EWI7zJI5FYMYfJEIE
	3bZbWnqPqWPNoETUZzRRgR4MVyVNbxUOmaobfnmftxHMHd4w9y/Ir+efO3w==
X-Received: by 2002:ac2:5472:0:b0:505:7113:1d0f with SMTP id e18-20020ac25472000000b0050571131d0fmr628874lfn.13.1700633025047;
        Tue, 21 Nov 2023 22:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK/wMdJ8Mmn7l1PKUfb+3qmG6b7aatGBzVi7wxlnc3vcE6rlG9iP6LhdTVDDX1syqueEl3TSEU8uX8TQAiuy0=
X-Received: by 2002:ac2:5472:0:b0:505:7113:1d0f with SMTP id
 e18-20020ac25472000000b0050571131d0fmr628855lfn.13.1700633024539; Tue, 21 Nov
 2023 22:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
 <20231114113104.33994-2-xuanzhuo@linux.alibaba.com> <CACGkMEtYxbXwJUVwz-OcT1LybEpHcgWXCzpmrFPgGJo_yP9LWA@mail.gmail.com>
 <1700547126.793057-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1700547126.793057-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Nov 2023 14:03:32 +0800
Message-ID: <CACGkMEuBmkw90XqaVLU-eU1qq1aft9gDf91YGs3umSccdrDYVQ@mail.gmail.com>
Subject: Re: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 16 Nov 2023 16:11:11 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > get buf from virtio core for premapped mode.
> > >
> > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > have many desc. Every desc dma address need to be unmap. So here we
> > > introduce a new helper to collect the dma address of the buffer from
> > > the virtio core.
> >
> > So looking at vring_desc_extra, what we have right now is:
> >
> > struct vring_desc_extra {
> >         dma_addr_t addr;                /* Descriptor DMA addr. */
> >         u32 len;                        /* Descriptor length. */
> >         u16 flags;                      /* Descriptor flags. */
> >         u16 next;                       /* The next desc state in a lis=
t. */
> > };
> >
> > And sg is
> >
> > struct scatterlist {
> >         unsigned long   page_link;
> > unsigned int    offset;
> >         unsigned int    length;
> >         dma_addr_t      dma_address;
> > #ifdef CONFIG_NEED_SG_DMA_LENGTH
> >         unsigned int    dma_length;
> > #endif
> > #ifdef CONFIG_NEED_SG_DMA_FLAGS
> >         unsigned int    dma_flags;
> > #endif
> > };
> >
> > Would it better just store sg?
>
> Do you mean we expose the vring_desc_extra to dirver?

Maybe or not, (or just us sg for desc_extra).

Anyhow, any method needs to be benchmarked to see the performance impact.

>
> How about introducing such a new structure?
>
> struct virtio_dma_item {
>          dma_addr_t addr;
>          u32 len;
> };
>
> struct virtio_dma_head {
>         u32 num;
>         u32 used;
>         struct virtio_dma_item items[];
> };
>
> Then we just need to pass one pointer to the virtio.

Just to make sure I understand here, where did we store those arrays?

> num is used to pass the size of items
> used is used to return the num used by virtio core.
>
> >
> > More below
> >
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 148 ++++++++++++++++++++++++++-------=
--
> > >  include/linux/virtio.h       |   2 +
> > >  2 files changed, 115 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 51d8f3299c10..0b3caee4ef9d 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -362,6 +362,20 @@ static struct device *vring_dma_dev(const struct=
 vring_virtqueue *vq)
> > >         return vq->dma_dev;
> > >  }
> > >
> > > +static void store_dma_to_sg(struct scatterlist **sgp, dma_addr_t add=
r, unsigned int length)
> > > +{
> > > +       struct scatterlist *sg;
> > > +
> > > +       sg =3D *sgp;
> > > +
> > > +       sg->dma_address =3D addr;
> > > +       sg->length =3D length;
> > > +
> > > +       sg =3D sg_next(sg);
> > > +
> > > +       *sgp =3D sg;
> > > +}
> > > +
> > >  /* Map one sg entry. */
> > >  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct=
 scatterlist *sg,
> > >                             enum dma_data_direction direction, dma_ad=
dr_t *addr)
> > > @@ -441,12 +455,18 @@ static void virtqueue_init(struct vring_virtque=
ue *vq, u32 num)
> > >   */
> > >
> > >  static void vring_unmap_one_split_indirect(const struct vring_virtqu=
eue *vq,
> > > -                                          const struct vring_desc *d=
esc)
> > > +                                          const struct vring_desc *d=
esc,
> > > +                                          struct scatterlist **sg)
> > >  {
> > >         u16 flags;
> > >
> > > -       if (!vq->do_unmap)
> > > +       if (!vq->do_unmap) {
> > > +               if (*sg)
> >
> > Can we simply move the
> >
> > if (*sg) to store_dma_to_sg()?
>
> OK
>
>
> >
> > > +                       store_dma_to_sg(sg,
> > > +                                       virtio64_to_cpu(vq->vq.vdev, =
desc->addr),
> > > +                                       virtio32_to_cpu(vq->vq.vdev, =
desc->len));
> > >                 return;
> > > +       }
> > >
> > >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > >
> > > @@ -458,7 +478,7 @@ static void vring_unmap_one_split_indirect(const =
struct vring_virtqueue *vq,
> > >  }
> > >
> > >  static unsigned int vring_unmap_one_split(const struct vring_virtque=
ue *vq,
> > > -                                         unsigned int i)
> > > +                                         unsigned int i, struct scat=
terlist **sg)
> > >  {
> > >         struct vring_desc_extra *extra =3D vq->split.desc_extra;
> > >         u16 flags;
> > > @@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_split(const =
struct vring_virtqueue *vq,
> > >                                  (flags & VRING_DESC_F_WRITE) ?
> > >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >         } else {
> > > -               if (!vq->do_unmap)
> > > +               if (!vq->do_unmap) {
> >
> > The:
> >
> > else {
> >       if {
> >             if {
> > }
> >
> > seems odd. I think I would prefer
> >
> > if (flags & VRING_DESC_F_INDIRECT) {
> > } else if (!vq->do_unmap) {
> > } else {
> > }
>
>
> Will fix.
>
>
> >
> > here
> >
> > Btw, I really think do_unmap is not a good name, we probably need to
> > rename it as "unmap_desc".
>
> How about a separate patch for this?
>
> >
> >
> > > +                       if (*sg)
> > > +                               store_dma_to_sg(sg, extra[i].addr, ex=
tra[i].len);
> >
> > In which case we need to unmap by driver but we don't need a dma addres=
s?
>
> Sorry, do not get it.

I meant, I don't get how we can reach to this check.

>
> >
> > >                         goto out;
> > > +               }
> > >
> > >                 dma_unmap_page(vring_dma_dev(vq),
> > >                                extra[i].addr,
> > > @@ -717,10 +740,10 @@ static inline int virtqueue_add_split(struct vi=
rtqueue *_vq,
> > >                 if (i =3D=3D err_idx)
> > >                         break;
> > >                 if (indirect) {
> > > -                       vring_unmap_one_split_indirect(vq, &desc[i]);
> > > +                       vring_unmap_one_split_indirect(vq, &desc[i], =
NULL);
> > >                         i =3D virtio16_to_cpu(_vq->vdev, desc[i].next=
);
> > >                 } else
> > > -                       i =3D vring_unmap_one_split(vq, i);
> > > +                       i =3D vring_unmap_one_split(vq, i, NULL);
> > >         }
> > >
> > >  free_indirect:
> > > @@ -763,7 +786,7 @@ static bool virtqueue_kick_prepare_split(struct v=
irtqueue *_vq)
> > >  }
> > >
> > >  static void detach_buf_split(struct vring_virtqueue *vq, unsigned in=
t head,
> > > -                            void **ctx)
> > > +                            struct scatterlist *sg, void **ctx)
> > >  {
> > >         unsigned int i, j;
> > >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DE=
SC_F_NEXT);
> > > @@ -775,12 +798,12 @@ static void detach_buf_split(struct vring_virtq=
ueue *vq, unsigned int head,
> > >         i =3D head;
> > >
> > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > -               vring_unmap_one_split(vq, i);
> > > +               vring_unmap_one_split(vq, i, &sg);
> > >                 i =3D vq->split.desc_extra[i].next;
> > >                 vq->vq.num_free++;
> > >         }
> > >
> > > -       vring_unmap_one_split(vq, i);
> > > +       vring_unmap_one_split(vq, i, &sg);
> > >         vq->split.desc_extra[i].next =3D vq->free_head;
> > >         vq->free_head =3D head;
> > >
> > > @@ -794,7 +817,7 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> > >
> > >                 /* Free the indirect table, if any, now that it's unm=
apped. */
> > >                 if (!indir_desc)
> > > -                       return;
> > > +                       goto end;
> > >
> > >                 len =3D vq->split.desc_extra[head].len;
> > >
> > > @@ -802,9 +825,10 @@ static void detach_buf_split(struct vring_virtqu=
eue *vq, unsigned int head,
> > >                                 VRING_DESC_F_INDIRECT));
> > >                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc=
));
> > >
> > > -               if (vq->do_unmap) {
> > > +               if (vq->do_unmap || sg) {
> > >                         for (j =3D 0; j < len / sizeof(struct vring_d=
esc); j++)
> > > -                               vring_unmap_one_split_indirect(vq, &i=
ndir_desc[j]);
> > > +                               vring_unmap_one_split_indirect(vq, &i=
ndir_desc[j], &sg);
> > > +
> > >                 }
> > >
> > >                 kfree(indir_desc);
> > > @@ -812,6 +836,11 @@ static void detach_buf_split(struct vring_virtqu=
eue *vq, unsigned int head,
> > >         } else if (ctx) {
> > >                 *ctx =3D vq->split.desc_state[head].indir_desc;
> > >         }
> > > +
> > > +end:
> > > +       /* sg point to the next. So we mark the last one as the end. =
*/
> > > +       if (!vq->do_unmap && sg)
> > > +               sg_mark_end(sg - 1);
> > >  }
> > >
> > >  static bool more_used_split(const struct vring_virtqueue *vq)
> > > @@ -822,6 +851,7 @@ static bool more_used_split(const struct vring_vi=
rtqueue *vq)
> > >
> > >  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >                                          unsigned int *len,
> > > +                                        struct scatterlist *sg,
> > >                                          void **ctx)
> > >  {
> > >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > @@ -862,7 +892,7 @@ static void *virtqueue_get_buf_ctx_split(struct v=
irtqueue *_vq,
> > >
> > >         /* detach_buf_split clears data, so grab it now. */
> > >         ret =3D vq->split.desc_state[i].data;
> > > -       detach_buf_split(vq, i, ctx);
> > > +       detach_buf_split(vq, i, sg, ctx);
> > >         vq->last_used_idx++;
> > >         /* If we expect an interrupt for the next entry, tell host
> > >          * by writing event index and flush out the write before
> > > @@ -984,7 +1014,7 @@ static void *virtqueue_detach_unused_buf_split(s=
truct virtqueue *_vq)
> > >                         continue;
> > >                 /* detach_buf_split clears data, so grab it now. */
> > >                 buf =3D vq->split.desc_state[i].data;
> > > -               detach_buf_split(vq, i, NULL);
> > > +               detach_buf_split(vq, i, NULL, NULL);
> > >                 vq->split.avail_idx_shadow--;
> > >                 vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq->v=
dev,
> > >                                 vq->split.avail_idx_shadow);
> > > @@ -1221,7 +1251,8 @@ static u16 packed_last_used(u16 last_used_idx)
> > >  }
> > >
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *v=
q,
> > > -                                    const struct vring_desc_extra *e=
xtra)
> > > +                                    const struct vring_desc_extra *e=
xtra,
> > > +                                    struct scatterlist **sg)
> > >  {
> > >         u16 flags;
> > >
> > > @@ -1236,8 +1267,11 @@ static void vring_unmap_extra_packed(const str=
uct vring_virtqueue *vq,
> > >                                  (flags & VRING_DESC_F_WRITE) ?
> > >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >         } else {
> > > -               if (!vq->do_unmap)
> > > +               if (!vq->do_unmap) {
> > > +                       if (*sg)
> > > +                               store_dma_to_sg(sg, extra->addr, extr=
a->len);
> > >                         return;
> > > +               }
> > >
> > >                 dma_unmap_page(vring_dma_dev(vq),
> > >                                extra->addr, extra->len,
> > > @@ -1247,12 +1281,17 @@ static void vring_unmap_extra_packed(const st=
ruct vring_virtqueue *vq,
> > >  }
> > >
> > >  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq=
,
> > > -                                   const struct vring_packed_desc *d=
esc)
> > > +                                   const struct vring_packed_desc *d=
esc,
> > > +                                   struct scatterlist **sg)
> > >  {
> >
> > Interesting, I think this is only needed for indirect descriptors?
> >
> > If yes, why do we care about the dma addresses of indirect descriptors?
> > If not, it's a bug that we should use desc_extra, otherwise it's a
> > device-triggerable unmap which has security implications (we need to
> > use vring_extra in this case).
>
> Sorry, I do not get.
>
>                             indirect desc(alloc by virtio core)
>        virtio-desc ------> |  | -------------------------------------> dm=
a address of buffer
>                            |  | -------------------------------------> dm=
a address of buffer
>                            |  | -------------------------------------> dm=
a address of buffer
>                            |  | -------------------------------------> dm=
a address of buffer
>                            |  | -------------------------------------> dm=
a address of buffer
>                            |  | -------------------------------------> dm=
a address of buffer
>
> For vring_unmap_desc_packed the desc is the indirect desc(alloc by virtio=
 core,
> not the virtio desc), which record the dma address of buffer that is pass=
ed by
> the driver. Here we need to record the dma address to back to the driver.

I meant why should we return this to the driver? It is allocated by
the vitio core and should be transparent to the driver.

Thanks

