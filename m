Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04018E3F
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7FD781233
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 06:34:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7FD781233
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LLzWD1zncG2d
	for <virtualization@lists.linux-foundation.org>;
	Wed, 22 Nov 2023 06:34:30 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DDDA84081
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 06:34:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DDDA84081
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vwuvf6Y_1700634863;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vwuvf6Y_1700634863)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 14:34:23 +0800
Message-ID: <1700634557.818587-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Wed, 22 Nov 2023 14:29:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
 <20231114113104.33994-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEtYxbXwJUVwz-OcT1LybEpHcgWXCzpmrFPgGJo_yP9LWA@mail.gmail.com>
 <1700547126.793057-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBmkw90XqaVLU-eU1qq1aft9gDf91YGs3umSccdrDYVQ@mail.gmail.com>
In-Reply-To: <CACGkMEuBmkw90XqaVLU-eU1qq1aft9gDf91YGs3umSccdrDYVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 22 Nov 2023 14:03:32 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 16 Nov 2023 16:11:11 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info when
> > > > get buf from virtio core for premapped mode.
> > > >
> > > > If the virtio queue is premapped mode, the virtio-net send buf may
> > > > have many desc. Every desc dma address need to be unmap. So here we
> > > > introduce a new helper to collect the dma address of the buffer from
> > > > the virtio core.
> > >
> > > So looking at vring_desc_extra, what we have right now is:
> > >
> > > struct vring_desc_extra {
> > >         dma_addr_t addr;                /* Descriptor DMA addr. */
> > >         u32 len;                        /* Descriptor length. */
> > >         u16 flags;                      /* Descriptor flags. */
> > >         u16 next;                       /* The next desc state in a l=
ist. */
> > > };
> > >
> > > And sg is
> > >
> > > struct scatterlist {
> > >         unsigned long   page_link;
> > > unsigned int    offset;
> > >         unsigned int    length;
> > >         dma_addr_t      dma_address;
> > > #ifdef CONFIG_NEED_SG_DMA_LENGTH
> > >         unsigned int    dma_length;
> > > #endif
> > > #ifdef CONFIG_NEED_SG_DMA_FLAGS
> > >         unsigned int    dma_flags;
> > > #endif
> > > };
> > >
> > > Would it better just store sg?
> >
> > Do you mean we expose the vring_desc_extra to dirver?
>
> Maybe or not, (or just us sg for desc_extra).
>
> Anyhow, any method needs to be benchmarked to see the performance impact.
>
> >
> > How about introducing such a new structure?
> >
> > struct virtio_dma_item {
> >          dma_addr_t addr;
> >          u32 len;
> > };
> >
> > struct virtio_dma_head {
> >         u32 num;
> >         u32 used;
> >         struct virtio_dma_item items[];
> > };
> >
> > Then we just need to pass one pointer to the virtio.
>
> Just to make sure I understand here, where did we store those arrays?


On the stack, or we can reuse the memory space of sq->sg.

dma =3D (struct virtio_dma_head*)sq->sg;


>
> > num is used to pass the size of items
> > used is used to return the num used by virtio core.
> >
> > >
> > > More below
> > >
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 148 ++++++++++++++++++++++++++-----=
----
> > > >  include/linux/virtio.h       |   2 +
> > > >  2 files changed, 115 insertions(+), 35 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 51d8f3299c10..0b3caee4ef9d 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -362,6 +362,20 @@ static struct device *vring_dma_dev(const stru=
ct vring_virtqueue *vq)
> > > >         return vq->dma_dev;
> > > >  }
> > > >
> > > > +static void store_dma_to_sg(struct scatterlist **sgp, dma_addr_t a=
ddr, unsigned int length)
> > > > +{
> > > > +       struct scatterlist *sg;
> > > > +
> > > > +       sg =3D *sgp;
> > > > +
> > > > +       sg->dma_address =3D addr;
> > > > +       sg->length =3D length;
> > > > +
> > > > +       sg =3D sg_next(sg);
> > > > +
> > > > +       *sgp =3D sg;
> > > > +}
> > > > +
> > > >  /* Map one sg entry. */
> > > >  static int vring_map_one_sg(const struct vring_virtqueue *vq, stru=
ct scatterlist *sg,
> > > >                             enum dma_data_direction direction, dma_=
addr_t *addr)
> > > > @@ -441,12 +455,18 @@ static void virtqueue_init(struct vring_virtq=
ueue *vq, u32 num)
> > > >   */
> > > >
> > > >  static void vring_unmap_one_split_indirect(const struct vring_virt=
queue *vq,
> > > > -                                          const struct vring_desc =
*desc)
> > > > +                                          const struct vring_desc =
*desc,
> > > > +                                          struct scatterlist **sg)
> > > >  {
> > > >         u16 flags;
> > > >
> > > > -       if (!vq->do_unmap)
> > > > +       if (!vq->do_unmap) {
> > > > +               if (*sg)
> > >
> > > Can we simply move the
> > >
> > > if (*sg) to store_dma_to_sg()?
> >
> > OK
> >
> >
> > >
> > > > +                       store_dma_to_sg(sg,
> > > > +                                       virtio64_to_cpu(vq->vq.vdev=
, desc->addr),
> > > > +                                       virtio32_to_cpu(vq->vq.vdev=
, desc->len));
> > > >                 return;
> > > > +       }
> > > >
> > > >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > > >
> > > > @@ -458,7 +478,7 @@ static void vring_unmap_one_split_indirect(cons=
t struct vring_virtqueue *vq,
> > > >  }
> > > >
> > > >  static unsigned int vring_unmap_one_split(const struct vring_virtq=
ueue *vq,
> > > > -                                         unsigned int i)
> > > > +                                         unsigned int i, struct sc=
atterlist **sg)
> > > >  {
> > > >         struct vring_desc_extra *extra =3D vq->split.desc_extra;
> > > >         u16 flags;
> > > > @@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_split(cons=
t struct vring_virtqueue *vq,
> > > >                                  (flags & VRING_DESC_F_WRITE) ?
> > > >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > >         } else {
> > > > -               if (!vq->do_unmap)
> > > > +               if (!vq->do_unmap) {
> > >
> > > The:
> > >
> > > else {
> > >       if {
> > >             if {
> > > }
> > >
> > > seems odd. I think I would prefer
> > >
> > > if (flags & VRING_DESC_F_INDIRECT) {
> > > } else if (!vq->do_unmap) {
> > > } else {
> > > }
> >
> >
> > Will fix.
> >
> >
> > >
> > > here
> > >
> > > Btw, I really think do_unmap is not a good name, we probably need to
> > > rename it as "unmap_desc".
> >
> > How about a separate patch for this?
> >
> > >
> > >
> > > > +                       if (*sg)
> > > > +                               store_dma_to_sg(sg, extra[i].addr, =
extra[i].len);
> > >
> > > In which case we need to unmap by driver but we don't need a dma addr=
ess?
> >
> > Sorry, do not get it.
>
> I meant, I don't get how we can reach to this check.

This is the main way. I think you miss something.


>
> >
> > >
> > > >                         goto out;
> > > > +               }
> > > >
> > > >                 dma_unmap_page(vring_dma_dev(vq),
> > > >                                extra[i].addr,
> > > > @@ -717,10 +740,10 @@ static inline int virtqueue_add_split(struct =
virtqueue *_vq,
> > > >                 if (i =3D=3D err_idx)
> > > >                         break;
> > > >                 if (indirect) {
> > > > -                       vring_unmap_one_split_indirect(vq, &desc[i]=
);
> > > > +                       vring_unmap_one_split_indirect(vq, &desc[i]=
, NULL);
> > > >                         i =3D virtio16_to_cpu(_vq->vdev, desc[i].ne=
xt);
> > > >                 } else
> > > > -                       i =3D vring_unmap_one_split(vq, i);
> > > > +                       i =3D vring_unmap_one_split(vq, i, NULL);
> > > >         }
> > > >
> > > >  free_indirect:
> > > > @@ -763,7 +786,7 @@ static bool virtqueue_kick_prepare_split(struct=
 virtqueue *_vq)
> > > >  }
> > > >
> > > >  static void detach_buf_split(struct vring_virtqueue *vq, unsigned =
int head,
> > > > -                            void **ctx)
> > > > +                            struct scatterlist *sg, void **ctx)
> > > >  {
> > > >         unsigned int i, j;
> > > >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_=
DESC_F_NEXT);
> > > > @@ -775,12 +798,12 @@ static void detach_buf_split(struct vring_vir=
tqueue *vq, unsigned int head,
> > > >         i =3D head;
> > > >
> > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > -               vring_unmap_one_split(vq, i);
> > > > +               vring_unmap_one_split(vq, i, &sg);
> > > >                 i =3D vq->split.desc_extra[i].next;
> > > >                 vq->vq.num_free++;
> > > >         }
> > > >
> > > > -       vring_unmap_one_split(vq, i);
> > > > +       vring_unmap_one_split(vq, i, &sg);
> > > >         vq->split.desc_extra[i].next =3D vq->free_head;
> > > >         vq->free_head =3D head;
> > > >
> > > > @@ -794,7 +817,7 @@ static void detach_buf_split(struct vring_virtq=
ueue *vq, unsigned int head,
> > > >
> > > >                 /* Free the indirect table, if any, now that it's u=
nmapped. */
> > > >                 if (!indir_desc)
> > > > -                       return;
> > > > +                       goto end;
> > > >
> > > >                 len =3D vq->split.desc_extra[head].len;
> > > >
> > > > @@ -802,9 +825,10 @@ static void detach_buf_split(struct vring_virt=
queue *vq, unsigned int head,
> > > >                                 VRING_DESC_F_INDIRECT));
> > > >                 BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_de=
sc));
> > > >
> > > > -               if (vq->do_unmap) {
> > > > +               if (vq->do_unmap || sg) {
> > > >                         for (j =3D 0; j < len / sizeof(struct vring=
_desc); j++)
> > > > -                               vring_unmap_one_split_indirect(vq, =
&indir_desc[j]);
> > > > +                               vring_unmap_one_split_indirect(vq, =
&indir_desc[j], &sg);
> > > > +
> > > >                 }
> > > >
> > > >                 kfree(indir_desc);
> > > > @@ -812,6 +836,11 @@ static void detach_buf_split(struct vring_virt=
queue *vq, unsigned int head,
> > > >         } else if (ctx) {
> > > >                 *ctx =3D vq->split.desc_state[head].indir_desc;
> > > >         }
> > > > +
> > > > +end:
> > > > +       /* sg point to the next. So we mark the last one as the end=
. */
> > > > +       if (!vq->do_unmap && sg)
> > > > +               sg_mark_end(sg - 1);
> > > >  }
> > > >
> > > >  static bool more_used_split(const struct vring_virtqueue *vq)
> > > > @@ -822,6 +851,7 @@ static bool more_used_split(const struct vring_=
virtqueue *vq)
> > > >
> > > >  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > > >                                          unsigned int *len,
> > > > +                                        struct scatterlist *sg,
> > > >                                          void **ctx)
> > > >  {
> > > >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > @@ -862,7 +892,7 @@ static void *virtqueue_get_buf_ctx_split(struct=
 virtqueue *_vq,
> > > >
> > > >         /* detach_buf_split clears data, so grab it now. */
> > > >         ret =3D vq->split.desc_state[i].data;
> > > > -       detach_buf_split(vq, i, ctx);
> > > > +       detach_buf_split(vq, i, sg, ctx);
> > > >         vq->last_used_idx++;
> > > >         /* If we expect an interrupt for the next entry, tell host
> > > >          * by writing event index and flush out the write before
> > > > @@ -984,7 +1014,7 @@ static void *virtqueue_detach_unused_buf_split=
(struct virtqueue *_vq)
> > > >                         continue;
> > > >                 /* detach_buf_split clears data, so grab it now. */
> > > >                 buf =3D vq->split.desc_state[i].data;
> > > > -               detach_buf_split(vq, i, NULL);
> > > > +               detach_buf_split(vq, i, NULL, NULL);
> > > >                 vq->split.avail_idx_shadow--;
> > > >                 vq->split.vring.avail->idx =3D cpu_to_virtio16(_vq-=
>vdev,
> > > >                                 vq->split.avail_idx_shadow);
> > > > @@ -1221,7 +1251,8 @@ static u16 packed_last_used(u16 last_used_idx)
> > > >  }
> > > >
> > > >  static void vring_unmap_extra_packed(const struct vring_virtqueue =
*vq,
> > > > -                                    const struct vring_desc_extra =
*extra)
> > > > +                                    const struct vring_desc_extra =
*extra,
> > > > +                                    struct scatterlist **sg)
> > > >  {
> > > >         u16 flags;
> > > >
> > > > @@ -1236,8 +1267,11 @@ static void vring_unmap_extra_packed(const s=
truct vring_virtqueue *vq,
> > > >                                  (flags & VRING_DESC_F_WRITE) ?
> > > >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > >         } else {
> > > > -               if (!vq->do_unmap)
> > > > +               if (!vq->do_unmap) {
> > > > +                       if (*sg)
> > > > +                               store_dma_to_sg(sg, extra->addr, ex=
tra->len);
> > > >                         return;
> > > > +               }
> > > >
> > > >                 dma_unmap_page(vring_dma_dev(vq),
> > > >                                extra->addr, extra->len,
> > > > @@ -1247,12 +1281,17 @@ static void vring_unmap_extra_packed(const =
struct vring_virtqueue *vq,
> > > >  }
> > > >
> > > >  static void vring_unmap_desc_packed(const struct vring_virtqueue *=
vq,
> > > > -                                   const struct vring_packed_desc =
*desc)
> > > > +                                   const struct vring_packed_desc =
*desc,
> > > > +                                   struct scatterlist **sg)
> > > >  {
> > >
> > > Interesting, I think this is only needed for indirect descriptors?
> > >
> > > If yes, why do we care about the dma addresses of indirect descriptor=
s?
> > > If not, it's a bug that we should use desc_extra, otherwise it's a
> > > device-triggerable unmap which has security implications (we need to
> > > use vring_extra in this case).
> >
> > Sorry, I do not get.
> >
> >                             indirect desc(alloc by virtio core)
> >        virtio-desc ------> |  | -------------------------------------> =
dma address of buffer
> >                            |  | -------------------------------------> =
dma address of buffer
> >                            |  | -------------------------------------> =
dma address of buffer
> >                            |  | -------------------------------------> =
dma address of buffer
> >                            |  | -------------------------------------> =
dma address of buffer
> >                            |  | -------------------------------------> =
dma address of buffer
> >
> > For vring_unmap_desc_packed the desc is the indirect desc(alloc by virt=
io core,
> > not the virtio desc), which record the dma address of buffer that is pa=
ssed by
> > the driver. Here we need to record the dma address to back to the drive=
r.
>
> I meant why should we return this to the driver? It is allocated by
> the vitio core and should be transparent to the driver.

Yes.

So here, we collect the buffer dma address not the address of the indirect =
desc
allocated by the virtio core.

I also think you miss something.

	static void detach_buf_packed(struct vring_virtqueue *vq,
				      unsigned int id, void **ctx)
	{
		struct vring_desc_state_packed *state =3D NULL;
		struct vring_packed_desc *desc;
		unsigned int i, curr;

		state =3D &vq->packed.desc_state[id];

		/* Clear data ptr. */
		state->data =3D NULL;

		vq->packed.desc_extra[state->last].next =3D vq->free_head;
		vq->free_head =3D id;
		vq->vq.num_free +=3D state->num;

		if (unlikely(vq->do_unmap)) {
			curr =3D id;
			for (i =3D 0; i < state->num; i++) {
				vring_unmap_extra_packed(vq,
							 &vq->packed.desc_extra[curr]);
				curr =3D vq->packed.desc_extra[curr].next;
			}
		}

		if (vq->indirect) {
			u32 len;

			/* Free the indirect table, if any, now that it's unmapped. */
			desc =3D state->indir_desc;
			if (!desc)
				return;

			if (vq->do_unmap) {
				len =3D vq->packed.desc_extra[id].len;
				for (i =3D 0; i < len / sizeof(struct vring_packed_desc);
						i++)
-->					vring_unmap_desc_packed(vq, &desc[i]);
			}
			kfree(desc);
			state->indir_desc =3D NULL;
		} else if (ctx) {
			*ctx =3D state->indir_desc;
		}
	}

Thanks.

>
> Thanks
>
