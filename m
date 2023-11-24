Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36E23A0
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7/HttBD"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3884B41E7E
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 04:15:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3884B41E7E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7/HttBD
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4LRvQmuJvuaz
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 04:15:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 220C741E79
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 04:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 220C741E79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700799312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkOAWd3WtczE/UVU7ObuvacXzoXdSo7ZbFv9hxco8PI=;
	b=H7/HttBD0BXRUPQuAo7jjre88pE9LZoK8CUXMSbVa6k6+mUiFI1AcFxDe+M1MH0/Nn1C4T
	MGqK2nVOlOJYvgssTI7XY4cVD22Jgiar+vkflCM/HsN9b6cK5O2C1TD/AjPhqmD3OB9C+Q
	MmdB+Z4gkKLJjP4P/wHD0aSPi9fZayE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-AlRIr099MluRl4m0X41tRQ-1; Thu, 23 Nov 2023 23:15:11 -0500
X-MC-Unique: AlRIr099MluRl4m0X41tRQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507d2e150c2so1420538e87.3
        for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 20:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700799309; x=1701404109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkOAWd3WtczE/UVU7ObuvacXzoXdSo7ZbFv9hxco8PI=;
        b=TIWn/00XxygnMQyBKuY/X6pC7Ll6xKJfiSva1kKqwazIkrjvwcxoqJIGq7qetkUywU
         wbsdq5rpVE6LBgG3zeA1sETWLE2lZbnKpmjozaips5kWsLrW7PuY0EWw+xtTvvJ+oSmF
         MjONWdiB3EbIWatDVBDxq0zLBzwD7kHsTYACtKL5m1bSmYwVJYP264nNRsJoZN9qAYBo
         RgdAx565xUigssNu90ZtopG61av+Fa3wrkd9SM0zZ6ghTi/qLhA434JICLAF42sXaHJE
         sncTQP13uQOGumi0HKA0WFRKiLcfGzsNFwEA4225wVbhNQ5lXWtShTx7SzraU4UNJK17
         uYXw==
X-Gm-Message-State: AOJu0YwtfgoScHlC8ltqkd16carjK0Tn87LbtSXD9pgOkRG9xZ0QJavp
	g+oxbc1vJYrXnSkX5esQ4ZPfud5wI6K9+GdsWo9MvTVRPvAIjHkQWLlvtBYWGThZ2YWFlhY1Pw+
	PFPsK3ld6hHCD9q8GE7OJoGecxHVEIgrZI4Dah0o/X2lshP7ORYhbFA+EUw==
X-Received: by 2002:a19:5207:0:b0:509:4530:e7fb with SMTP id m7-20020a195207000000b005094530e7fbmr835364lfb.32.1700799309708;
        Thu, 23 Nov 2023 20:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJN8MblKE4m7YXwz/MbNgt9bOSEpSbLCdmr6FgCCU28bZ8ihVNgsBR84PeFo2midQD5JxQWy3XjHuEG/TUEj4=
X-Received: by 2002:a19:5207:0:b0:509:4530:e7fb with SMTP id
 m7-20020a195207000000b005094530e7fbmr835354lfb.32.1700799309332; Thu, 23 Nov
 2023 20:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
 <20231114113104.33994-2-xuanzhuo@linux.alibaba.com> <CACGkMEtYxbXwJUVwz-OcT1LybEpHcgWXCzpmrFPgGJo_yP9LWA@mail.gmail.com>
 <1700547126.793057-4-xuanzhuo@linux.alibaba.com> <CACGkMEuBmkw90XqaVLU-eU1qq1aft9gDf91YGs3umSccdrDYVQ@mail.gmail.com>
 <1700634557.818587-3-xuanzhuo@linux.alibaba.com> <CACGkMEusOSqhqcMxcajXKeOGuvoABAyXmBpc-EQMrP2JQEh_Qg@mail.gmail.com>
 <1700635902.0042756-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1700635902.0042756-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Nov 2023 12:14:57 +0800
Message-ID: <CACGkMEv0b6MUcTzvPGBdoqmfUEQ5rwDYfQ7E012gj0zb2SQ02w@mail.gmail.com>
Subject: Re: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 2:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 22 Nov 2023 14:47:02 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Nov 22, 2023 at 2:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 22 Nov 2023 14:03:32 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Thu, 16 Nov 2023 16:11:11 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma info=
 when
> > > > > > > get buf from virtio core for premapped mode.
> > > > > > >
> > > > > > > If the virtio queue is premapped mode, the virtio-net send bu=
f may
> > > > > > > have many desc. Every desc dma address need to be unmap. So h=
ere we
> > > > > > > introduce a new helper to collect the dma address of the buff=
er from
> > > > > > > the virtio core.
> > > > > >
> > > > > > So looking at vring_desc_extra, what we have right now is:
> > > > > >
> > > > > > struct vring_desc_extra {
> > > > > >         dma_addr_t addr;                /* Descriptor DMA addr.=
 */
> > > > > >         u32 len;                        /* Descriptor length. *=
/
> > > > > >         u16 flags;                      /* Descriptor flags. */
> > > > > >         u16 next;                       /* The next desc state =
in a list. */
> > > > > > };
> > > > > >
> > > > > > And sg is
> > > > > >
> > > > > > struct scatterlist {
> > > > > >         unsigned long   page_link;
> > > > > > unsigned int    offset;
> > > > > >         unsigned int    length;
> > > > > >         dma_addr_t      dma_address;
> > > > > > #ifdef CONFIG_NEED_SG_DMA_LENGTH
> > > > > >         unsigned int    dma_length;
> > > > > > #endif
> > > > > > #ifdef CONFIG_NEED_SG_DMA_FLAGS
> > > > > >         unsigned int    dma_flags;
> > > > > > #endif
> > > > > > };
> > > > > >
> > > > > > Would it better just store sg?
> > > > >
> > > > > Do you mean we expose the vring_desc_extra to dirver?
> > > >
> > > > Maybe or not, (or just us sg for desc_extra).
> > > >
> > > > Anyhow, any method needs to be benchmarked to see the performance i=
mpact.
> > > >
> > > > >
> > > > > How about introducing such a new structure?
> > > > >
> > > > > struct virtio_dma_item {
> > > > >          dma_addr_t addr;
> > > > >          u32 len;
> > > > > };
> > > > >
> > > > > struct virtio_dma_head {
> > > > >         u32 num;
> > > > >         u32 used;
> > > > >         struct virtio_dma_item items[];
> > > > > };
> > > > >
> > > > > Then we just need to pass one pointer to the virtio.
> > > >
> > > > Just to make sure I understand here, where did we store those array=
s?
> > >
> > >
> > > On the stack, or we can reuse the memory space of sq->sg.
> > >
> > > dma =3D (struct virtio_dma_head*)sq->sg;
> >
> > Ok, we need some benchmark for sure.
> >
> > >
> > >
> > > >
> > > > > num is used to pass the size of items
> > > > > used is used to return the num used by virtio core.
> > > > >
> > > > > >
> > > > > > More below
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_ring.c | 148 +++++++++++++++++++++++++=
+---------
> > > > > > >  include/linux/virtio.h       |   2 +
> > > > > > >  2 files changed, 115 insertions(+), 35 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/vi=
rtio_ring.c
> > > > > > > index 51d8f3299c10..0b3caee4ef9d 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -362,6 +362,20 @@ static struct device *vring_dma_dev(cons=
t struct vring_virtqueue *vq)
> > > > > > >         return vq->dma_dev;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void store_dma_to_sg(struct scatterlist **sgp, dma_ad=
dr_t addr, unsigned int length)
> > > > > > > +{
> > > > > > > +       struct scatterlist *sg;
> > > > > > > +
> > > > > > > +       sg =3D *sgp;
> > > > > > > +
> > > > > > > +       sg->dma_address =3D addr;
> > > > > > > +       sg->length =3D length;
> > > > > > > +
> > > > > > > +       sg =3D sg_next(sg);
> > > > > > > +
> > > > > > > +       *sgp =3D sg;
> > > > > > > +}
> > > > > > > +
> > > > > > >  /* Map one sg entry. */
> > > > > > >  static int vring_map_one_sg(const struct vring_virtqueue *vq=
, struct scatterlist *sg,
> > > > > > >                             enum dma_data_direction direction=
, dma_addr_t *addr)
> > > > > > > @@ -441,12 +455,18 @@ static void virtqueue_init(struct vring=
_virtqueue *vq, u32 num)
> > > > > > >   */
> > > > > > >
> > > > > > >  static void vring_unmap_one_split_indirect(const struct vrin=
g_virtqueue *vq,
> > > > > > > -                                          const struct vring=
_desc *desc)
> > > > > > > +                                          const struct vring=
_desc *desc,
> > > > > > > +                                          struct scatterlist=
 **sg)
> > > > > > >  {
> > > > > > >         u16 flags;
> > > > > > >
> > > > > > > -       if (!vq->do_unmap)
> > > > > > > +       if (!vq->do_unmap) {
> > > > > > > +               if (*sg)
> > > > > >
> > > > > > Can we simply move the
> > > > > >
> > > > > > if (*sg) to store_dma_to_sg()?
> > > > >
> > > > > OK
> > > > >
> > > > >
> > > > > >
> > > > > > > +                       store_dma_to_sg(sg,
> > > > > > > +                                       virtio64_to_cpu(vq->v=
q.vdev, desc->addr),
> > > > > > > +                                       virtio32_to_cpu(vq->v=
q.vdev, desc->len));
> > > > > > >                 return;
> > > > > > > +       }
> > > > > > >
> > > > > > >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > > > > > >
> > > > > > > @@ -458,7 +478,7 @@ static void vring_unmap_one_split_indirec=
t(const struct vring_virtqueue *vq,
> > > > > > >  }
> > > > > > >
> > > > > > >  static unsigned int vring_unmap_one_split(const struct vring=
_virtqueue *vq,
> > > > > > > -                                         unsigned int i)
> > > > > > > +                                         unsigned int i, str=
uct scatterlist **sg)
> > > > > > >  {
> > > > > > >         struct vring_desc_extra *extra =3D vq->split.desc_ext=
ra;
> > > > > > >         u16 flags;
> > > > > > > @@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_spli=
t(const struct vring_virtqueue *vq,
> > > > > > >                                  (flags & VRING_DESC_F_WRITE)=
 ?
> > > > > > >                                  DMA_FROM_DEVICE : DMA_TO_DEV=
ICE);
> > > > > > >         } else {
> > > > > > > -               if (!vq->do_unmap)
> > > > > > > +               if (!vq->do_unmap) {
> > > > > >
> > > > > > The:
> > > > > >
> > > > > > else {
> > > > > >       if {
> > > > > >             if {
> > > > > > }
> > > > > >
> > > > > > seems odd. I think I would prefer
> > > > > >
> > > > > > if (flags & VRING_DESC_F_INDIRECT) {
> > > > > > } else if (!vq->do_unmap) {
> > > > > > } else {
> > > > > > }
> > > > >
> > > > >
> > > > > Will fix.
> > > > >
> > > > >
> > > > > >
> > > > > > here
> > > > > >
> > > > > > Btw, I really think do_unmap is not a good name, we probably ne=
ed to
> > > > > > rename it as "unmap_desc".
> > > > >
> > > > > How about a separate patch for this?
> > > > >
> > > > > >
> > > > > >
> > > > > > > +                       if (*sg)
> > > > > > > +                               store_dma_to_sg(sg, extra[i].=
addr, extra[i].len);
> > > > > >
> > > > > > In which case we need to unmap by driver but we don't need a dm=
a address?
> > > > >
> > > > > Sorry, do not get it.
> > > >
> > > > I meant, I don't get how we can reach to this check.
> > >
> > > This is the main way. I think you miss something.
> >
> > Or maybe you can explain the case where vq->do_unmap is false but *sg i=
s NULL?
>
>
> If vq->do_unmap is false, that is premapped mode or use_dma_api is false.
> If the *sg is null, that means that the driver call the API
> virtqueue_get_buf_ctx or virtqueue_get_buf.
> If the *sg is not null, that means that the driver call the API
>
>         void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsigned i=
nt *len,
>                                         struct scatterlist *sg, void **ct=
x);
>
> Thanks.

Ok, but my question still:

1) you explain one possible way here is use_dma_api is false and the
driver doesn't call virtqueue_get_buf_ctx_dma().
2) what happens if the driver uses a preamp but doesn't use
virtqueue_get_buf_ctx_dma()? Should we warn in this case?

Thanks

