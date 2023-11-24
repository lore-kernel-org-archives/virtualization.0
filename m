Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3A4404
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9515060B3C
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 05:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9515060B3C
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c1RdVTAO0hvI
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 05:55:59 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB72B60B04
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 05:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB72B60B04
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vx0MR5h_1700805350;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vx0MR5h_1700805350)
          by smtp.aliyun-inc.com;
          Fri, 24 Nov 2023 13:55:51 +0800
Message-ID: <1700805079.7386818-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
Date: Fri, 24 Nov 2023 13:51:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
 <20231114113104.33994-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEtYxbXwJUVwz-OcT1LybEpHcgWXCzpmrFPgGJo_yP9LWA@mail.gmail.com>
 <1700547126.793057-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBmkw90XqaVLU-eU1qq1aft9gDf91YGs3umSccdrDYVQ@mail.gmail.com>
 <1700634557.818587-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEusOSqhqcMxcajXKeOGuvoABAyXmBpc-EQMrP2JQEh_Qg@mail.gmail.com>
 <1700635902.0042756-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEv0b6MUcTzvPGBdoqmfUEQ5rwDYfQ7E012gj0zb2SQ02w@mail.gmail.com>
In-Reply-To: <CACGkMEv0b6MUcTzvPGBdoqmfUEQ5rwDYfQ7E012gj0zb2SQ02w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 24 Nov 2023 12:14:57 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Nov 22, 2023 at 2:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 22 Nov 2023 14:47:02 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Nov 22, 2023 at 2:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Wed, 22 Nov 2023 14:03:32 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux=
.alibaba.com> wrote:
> > > > > >
> > > > > > On Thu, 16 Nov 2023 16:11:11 +0800, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@l=
inux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma in=
fo when
> > > > > > > > get buf from virtio core for premapped mode.
> > > > > > > >
> > > > > > > > If the virtio queue is premapped mode, the virtio-net send =
buf may
> > > > > > > > have many desc. Every desc dma address need to be unmap. So=
 here we
> > > > > > > > introduce a new helper to collect the dma address of the bu=
ffer from
> > > > > > > > the virtio core.
> > > > > > >
> > > > > > > So looking at vring_desc_extra, what we have right now is:
> > > > > > >
> > > > > > > struct vring_desc_extra {
> > > > > > >         dma_addr_t addr;                /* Descriptor DMA add=
r. */
> > > > > > >         u32 len;                        /* Descriptor length.=
 */
> > > > > > >         u16 flags;                      /* Descriptor flags. =
*/
> > > > > > >         u16 next;                       /* The next desc stat=
e in a list. */
> > > > > > > };
> > > > > > >
> > > > > > > And sg is
> > > > > > >
> > > > > > > struct scatterlist {
> > > > > > >         unsigned long   page_link;
> > > > > > > unsigned int    offset;
> > > > > > >         unsigned int    length;
> > > > > > >         dma_addr_t      dma_address;
> > > > > > > #ifdef CONFIG_NEED_SG_DMA_LENGTH
> > > > > > >         unsigned int    dma_length;
> > > > > > > #endif
> > > > > > > #ifdef CONFIG_NEED_SG_DMA_FLAGS
> > > > > > >         unsigned int    dma_flags;
> > > > > > > #endif
> > > > > > > };
> > > > > > >
> > > > > > > Would it better just store sg?
> > > > > >
> > > > > > Do you mean we expose the vring_desc_extra to dirver?
> > > > >
> > > > > Maybe or not, (or just us sg for desc_extra).
> > > > >
> > > > > Anyhow, any method needs to be benchmarked to see the performance=
 impact.
> > > > >
> > > > > >
> > > > > > How about introducing such a new structure?
> > > > > >
> > > > > > struct virtio_dma_item {
> > > > > >          dma_addr_t addr;
> > > > > >          u32 len;
> > > > > > };
> > > > > >
> > > > > > struct virtio_dma_head {
> > > > > >         u32 num;
> > > > > >         u32 used;
> > > > > >         struct virtio_dma_item items[];
> > > > > > };
> > > > > >
> > > > > > Then we just need to pass one pointer to the virtio.
> > > > >
> > > > > Just to make sure I understand here, where did we store those arr=
ays?
> > > >
> > > >
> > > > On the stack, or we can reuse the memory space of sq->sg.
> > > >
> > > > dma =3D (struct virtio_dma_head*)sq->sg;
> > >
> > > Ok, we need some benchmark for sure.
> > >
> > > >
> > > >
> > > > >
> > > > > > num is used to pass the size of items
> > > > > > used is used to return the num used by virtio core.
> > > > > >
> > > > > > >
> > > > > > > More below
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > ---
> > > > > > > >  drivers/virtio/virtio_ring.c | 148 +++++++++++++++++++++++=
+++---------
> > > > > > > >  include/linux/virtio.h       |   2 +
> > > > > > > >  2 files changed, 115 insertions(+), 35 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/=
virtio_ring.c
> > > > > > > > index 51d8f3299c10..0b3caee4ef9d 100644
> > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > @@ -362,6 +362,20 @@ static struct device *vring_dma_dev(co=
nst struct vring_virtqueue *vq)
> > > > > > > >         return vq->dma_dev;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void store_dma_to_sg(struct scatterlist **sgp, dma_=
addr_t addr, unsigned int length)
> > > > > > > > +{
> > > > > > > > +       struct scatterlist *sg;
> > > > > > > > +
> > > > > > > > +       sg =3D *sgp;
> > > > > > > > +
> > > > > > > > +       sg->dma_address =3D addr;
> > > > > > > > +       sg->length =3D length;
> > > > > > > > +
> > > > > > > > +       sg =3D sg_next(sg);
> > > > > > > > +
> > > > > > > > +       *sgp =3D sg;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  /* Map one sg entry. */
> > > > > > > >  static int vring_map_one_sg(const struct vring_virtqueue *=
vq, struct scatterlist *sg,
> > > > > > > >                             enum dma_data_direction directi=
on, dma_addr_t *addr)
> > > > > > > > @@ -441,12 +455,18 @@ static void virtqueue_init(struct vri=
ng_virtqueue *vq, u32 num)
> > > > > > > >   */
> > > > > > > >
> > > > > > > >  static void vring_unmap_one_split_indirect(const struct vr=
ing_virtqueue *vq,
> > > > > > > > -                                          const struct vri=
ng_desc *desc)
> > > > > > > > +                                          const struct vri=
ng_desc *desc,
> > > > > > > > +                                          struct scatterli=
st **sg)
> > > > > > > >  {
> > > > > > > >         u16 flags;
> > > > > > > >
> > > > > > > > -       if (!vq->do_unmap)
> > > > > > > > +       if (!vq->do_unmap) {
> > > > > > > > +               if (*sg)
> > > > > > >
> > > > > > > Can we simply move the
> > > > > > >
> > > > > > > if (*sg) to store_dma_to_sg()?
> > > > > >
> > > > > > OK
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > +                       store_dma_to_sg(sg,
> > > > > > > > +                                       virtio64_to_cpu(vq-=
>vq.vdev, desc->addr),
> > > > > > > > +                                       virtio32_to_cpu(vq-=
>vq.vdev, desc->len));
> > > > > > > >                 return;
> > > > > > > > +       }
> > > > > > > >
> > > > > > > >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > > > > > > >
> > > > > > > > @@ -458,7 +478,7 @@ static void vring_unmap_one_split_indir=
ect(const struct vring_virtqueue *vq,
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static unsigned int vring_unmap_one_split(const struct vri=
ng_virtqueue *vq,
> > > > > > > > -                                         unsigned int i)
> > > > > > > > +                                         unsigned int i, s=
truct scatterlist **sg)
> > > > > > > >  {
> > > > > > > >         struct vring_desc_extra *extra =3D vq->split.desc_e=
xtra;
> > > > > > > >         u16 flags;
> > > > > > > > @@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_sp=
lit(const struct vring_virtqueue *vq,
> > > > > > > >                                  (flags & VRING_DESC_F_WRIT=
E) ?
> > > > > > > >                                  DMA_FROM_DEVICE : DMA_TO_D=
EVICE);
> > > > > > > >         } else {
> > > > > > > > -               if (!vq->do_unmap)
> > > > > > > > +               if (!vq->do_unmap) {
> > > > > > >
> > > > > > > The:
> > > > > > >
> > > > > > > else {
> > > > > > >       if {
> > > > > > >             if {
> > > > > > > }
> > > > > > >
> > > > > > > seems odd. I think I would prefer
> > > > > > >
> > > > > > > if (flags & VRING_DESC_F_INDIRECT) {
> > > > > > > } else if (!vq->do_unmap) {
> > > > > > > } else {
> > > > > > > }
> > > > > >
> > > > > >
> > > > > > Will fix.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > here
> > > > > > >
> > > > > > > Btw, I really think do_unmap is not a good name, we probably =
need to
> > > > > > > rename it as "unmap_desc".
> > > > > >
> > > > > > How about a separate patch for this?
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > +                       if (*sg)
> > > > > > > > +                               store_dma_to_sg(sg, extra[i=
].addr, extra[i].len);
> > > > > > >
> > > > > > > In which case we need to unmap by driver but we don't need a =
dma address?
> > > > > >
> > > > > > Sorry, do not get it.
> > > > >
> > > > > I meant, I don't get how we can reach to this check.
> > > >
> > > > This is the main way. I think you miss something.
> > >
> > > Or maybe you can explain the case where vq->do_unmap is false but *sg=
 is NULL?
> >
> >
> > If vq->do_unmap is false, that is premapped mode or use_dma_api is fals=
e.
> > If the *sg is null, that means that the driver call the API
> > virtqueue_get_buf_ctx or virtqueue_get_buf.
> > If the *sg is not null, that means that the driver call the API
> >
> >         void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned=
 int *len,
> >                                         struct scatterlist *sg, void **=
ctx);
> >
> > Thanks.
>
> Ok, but my question still:
>
> 1) you explain one possible way here is use_dma_api is false and the
> driver doesn't call virtqueue_get_buf_ctx_dma().

If the use_dma_api is false, then we cannot set to premapped mode.
If the driver calls virtqueue_get_buf_ctx_dma(), that works as
virtqueue_get_buf_ctx().


> 2) what happens if the driver uses a preamp but doesn't use
> virtqueue_get_buf_ctx_dma()? Should we warn in this case?

The developer should know that he need to do unmap, so I think
that is not needed.

Thanks.



>
> Thanks
>
