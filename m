Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F04404
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz5LADS+"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6370441DA0
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 06:01:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6370441DA0
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vz5LADS+
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RnEd0qO4e83O
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 06:01:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D47DC418EF
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 06:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D47DC418EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700805666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cxfQzTDsjHzpjDHWEumypP5mVexENR8SQtBgcQpQoQ=;
	b=Vz5LADS+8utmoiGvADAXAZ7PwggNI4ANE1JUJuRSuvhkpI4a521pF5H/LNAQuV1e4NRJM3
	+N4nLBuAHKhvdc394fsSVjaTMvWxYXrLUOjQfTy0rl66WKjc+Faa21RqMl0t2F9cUKbqDv
	511GuYZNqkbzyEAcjeS7axKZdW9adwI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-L4gvInlWMZuq5q1XauMeCA-1; Fri, 24 Nov 2023 01:01:04 -0500
X-MC-Unique: L4gvInlWMZuq5q1XauMeCA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d2e150c2so1489152e87.3
        for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 22:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700805662; x=1701410462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cxfQzTDsjHzpjDHWEumypP5mVexENR8SQtBgcQpQoQ=;
        b=pJ4ng8BrdtrKvUkS4T9v6vSr9W56oYleOK8T2DAihK8aocR6p9f3d+UZ9mJUgJvWkW
         Bu0Y80QgJZxdOW/GehkVXFqjQ8VfLTmeXfO3Zapax+NAxND5DWASyYUH3QdiES6of2q8
         tqUjq8XS4iXkuK4+W4m/ewHRktONqJyoK/5b+wfwNjbECufZkwOu5a3GNA7Ik/IESDXM
         EZj9Sqf4apw+3fIjN/AfjGnuP5q/L5vZ2DpqrrC+6Xpso7RItuWwoZoNzJRQblcEod+p
         6NA71fCc/DyGVEQeBCH/0+XNCePaujyV5x4nm0VAYds3+LydylUFAkxMTmbMRMm/rbzj
         t3pw==
X-Gm-Message-State: AOJu0YyiiC4IKFkTqSMKE2lFr6WymbG4HFCvsWUetrISjG3A8tCJGZ6T
	W7ICQNmfRgBJ5M3FaAaEkig6OBZd2/zZXSi+fyOkTB6Q3lRBAYBGiTeMv+EVNFeBuA/Pk17TE/J
	P67bT5DxbdG181byu5K1nXKjCix8ECPdMJuTnPgAFWDRHnEaYtZPszMvwMQ==
X-Received: by 2002:a19:c20f:0:b0:509:8e81:1aa4 with SMTP id l15-20020a19c20f000000b005098e811aa4mr985290lfc.39.1700805662522;
        Thu, 23 Nov 2023 22:01:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcDiGZARmYzakvibt90WSrhmJugXAiRkdS3BzI/fBhrWZfcMKch8ovRCqPNYQYVSIYQHCs8FSpUzTeNhXJpPI=
X-Received: by 2002:a19:c20f:0:b0:509:8e81:1aa4 with SMTP id
 l15-20020a19c20f000000b005098e811aa4mr985270lfc.39.1700805662126; Thu, 23 Nov
 2023 22:01:02 -0800 (PST)
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
 <1700635902.0042756-4-xuanzhuo@linux.alibaba.com> <CACGkMEv0b6MUcTzvPGBdoqmfUEQ5rwDYfQ7E012gj0zb2SQ02w@mail.gmail.com>
 <1700805079.7386818-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1700805079.7386818-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Nov 2023 14:00:51 +0800
Message-ID: <CACGkMEs5PEN1URObB4UxCJ7LNb4oQeoPmCEQ=L1uCyq8RMcEzQ@mail.gmail.com>
Subject: Re: [RFC 1/4] virtio_ring: introduce virtqueue_get_buf_ctx_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 1:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 24 Nov 2023 12:14:57 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Nov 22, 2023 at 2:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 22 Nov 2023 14:47:02 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Nov 22, 2023 at 2:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Wed, 22 Nov 2023 14:03:32 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Thu, 16 Nov 2023 16:11:11 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Tue, Nov 14, 2023 at 7:31=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > introduce virtqueue_get_buf_ctx_dma() to collect the dma =
info when
> > > > > > > > > get buf from virtio core for premapped mode.
> > > > > > > > >
> > > > > > > > > If the virtio queue is premapped mode, the virtio-net sen=
d buf may
> > > > > > > > > have many desc. Every desc dma address need to be unmap. =
So here we
> > > > > > > > > introduce a new helper to collect the dma address of the =
buffer from
> > > > > > > > > the virtio core.
> > > > > > > >
> > > > > > > > So looking at vring_desc_extra, what we have right now is:
> > > > > > > >
> > > > > > > > struct vring_desc_extra {
> > > > > > > >         dma_addr_t addr;                /* Descriptor DMA a=
ddr. */
> > > > > > > >         u32 len;                        /* Descriptor lengt=
h. */
> > > > > > > >         u16 flags;                      /* Descriptor flags=
. */
> > > > > > > >         u16 next;                       /* The next desc st=
ate in a list. */
> > > > > > > > };
> > > > > > > >
> > > > > > > > And sg is
> > > > > > > >
> > > > > > > > struct scatterlist {
> > > > > > > >         unsigned long   page_link;
> > > > > > > > unsigned int    offset;
> > > > > > > >         unsigned int    length;
> > > > > > > >         dma_addr_t      dma_address;
> > > > > > > > #ifdef CONFIG_NEED_SG_DMA_LENGTH
> > > > > > > >         unsigned int    dma_length;
> > > > > > > > #endif
> > > > > > > > #ifdef CONFIG_NEED_SG_DMA_FLAGS
> > > > > > > >         unsigned int    dma_flags;
> > > > > > > > #endif
> > > > > > > > };
> > > > > > > >
> > > > > > > > Would it better just store sg?
> > > > > > >
> > > > > > > Do you mean we expose the vring_desc_extra to dirver?
> > > > > >
> > > > > > Maybe or not, (or just us sg for desc_extra).
> > > > > >
> > > > > > Anyhow, any method needs to be benchmarked to see the performan=
ce impact.
> > > > > >
> > > > > > >
> > > > > > > How about introducing such a new structure?
> > > > > > >
> > > > > > > struct virtio_dma_item {
> > > > > > >          dma_addr_t addr;
> > > > > > >          u32 len;
> > > > > > > };
> > > > > > >
> > > > > > > struct virtio_dma_head {
> > > > > > >         u32 num;
> > > > > > >         u32 used;
> > > > > > >         struct virtio_dma_item items[];
> > > > > > > };
> > > > > > >
> > > > > > > Then we just need to pass one pointer to the virtio.
> > > > > >
> > > > > > Just to make sure I understand here, where did we store those a=
rrays?
> > > > >
> > > > >
> > > > > On the stack, or we can reuse the memory space of sq->sg.
> > > > >
> > > > > dma =3D (struct virtio_dma_head*)sq->sg;
> > > >
> > > > Ok, we need some benchmark for sure.
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > > num is used to pass the size of items
> > > > > > > used is used to return the num used by virtio core.
> > > > > > >
> > > > > > > >
> > > > > > > > More below
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/virtio/virtio_ring.c | 148 +++++++++++++++++++++=
+++++---------
> > > > > > > > >  include/linux/virtio.h       |   2 +
> > > > > > > > >  2 files changed, 115 insertions(+), 35 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virti=
o/virtio_ring.c
> > > > > > > > > index 51d8f3299c10..0b3caee4ef9d 100644
> > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > @@ -362,6 +362,20 @@ static struct device *vring_dma_dev(=
const struct vring_virtqueue *vq)
> > > > > > > > >         return vq->dma_dev;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void store_dma_to_sg(struct scatterlist **sgp, dm=
a_addr_t addr, unsigned int length)
> > > > > > > > > +{
> > > > > > > > > +       struct scatterlist *sg;
> > > > > > > > > +
> > > > > > > > > +       sg =3D *sgp;
> > > > > > > > > +
> > > > > > > > > +       sg->dma_address =3D addr;
> > > > > > > > > +       sg->length =3D length;
> > > > > > > > > +
> > > > > > > > > +       sg =3D sg_next(sg);
> > > > > > > > > +
> > > > > > > > > +       *sgp =3D sg;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /* Map one sg entry. */
> > > > > > > > >  static int vring_map_one_sg(const struct vring_virtqueue=
 *vq, struct scatterlist *sg,
> > > > > > > > >                             enum dma_data_direction direc=
tion, dma_addr_t *addr)
> > > > > > > > > @@ -441,12 +455,18 @@ static void virtqueue_init(struct v=
ring_virtqueue *vq, u32 num)
> > > > > > > > >   */
> > > > > > > > >
> > > > > > > > >  static void vring_unmap_one_split_indirect(const struct =
vring_virtqueue *vq,
> > > > > > > > > -                                          const struct v=
ring_desc *desc)
> > > > > > > > > +                                          const struct v=
ring_desc *desc,
> > > > > > > > > +                                          struct scatter=
list **sg)
> > > > > > > > >  {
> > > > > > > > >         u16 flags;
> > > > > > > > >
> > > > > > > > > -       if (!vq->do_unmap)
> > > > > > > > > +       if (!vq->do_unmap) {
> > > > > > > > > +               if (*sg)
> > > > > > > >
> > > > > > > > Can we simply move the
> > > > > > > >
> > > > > > > > if (*sg) to store_dma_to_sg()?
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > +                       store_dma_to_sg(sg,
> > > > > > > > > +                                       virtio64_to_cpu(v=
q->vq.vdev, desc->addr),
> > > > > > > > > +                                       virtio32_to_cpu(v=
q->vq.vdev, desc->len));
> > > > > > > > >                 return;
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >         flags =3D virtio16_to_cpu(vq->vq.vdev, desc->flag=
s);
> > > > > > > > >
> > > > > > > > > @@ -458,7 +478,7 @@ static void vring_unmap_one_split_ind=
irect(const struct vring_virtqueue *vq,
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static unsigned int vring_unmap_one_split(const struct v=
ring_virtqueue *vq,
> > > > > > > > > -                                         unsigned int i)
> > > > > > > > > +                                         unsigned int i,=
 struct scatterlist **sg)
> > > > > > > > >  {
> > > > > > > > >         struct vring_desc_extra *extra =3D vq->split.desc=
_extra;
> > > > > > > > >         u16 flags;
> > > > > > > > > @@ -475,8 +495,11 @@ static unsigned int vring_unmap_one_=
split(const struct vring_virtqueue *vq,
> > > > > > > > >                                  (flags & VRING_DESC_F_WR=
ITE) ?
> > > > > > > > >                                  DMA_FROM_DEVICE : DMA_TO=
_DEVICE);
> > > > > > > > >         } else {
> > > > > > > > > -               if (!vq->do_unmap)
> > > > > > > > > +               if (!vq->do_unmap) {
> > > > > > > >
> > > > > > > > The:
> > > > > > > >
> > > > > > > > else {
> > > > > > > >       if {
> > > > > > > >             if {
> > > > > > > > }
> > > > > > > >
> > > > > > > > seems odd. I think I would prefer
> > > > > > > >
> > > > > > > > if (flags & VRING_DESC_F_INDIRECT) {
> > > > > > > > } else if (!vq->do_unmap) {
> > > > > > > > } else {
> > > > > > > > }
> > > > > > >
> > > > > > >
> > > > > > > Will fix.
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > here
> > > > > > > >
> > > > > > > > Btw, I really think do_unmap is not a good name, we probabl=
y need to
> > > > > > > > rename it as "unmap_desc".
> > > > > > >
> > > > > > > How about a separate patch for this?
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > > +                       if (*sg)
> > > > > > > > > +                               store_dma_to_sg(sg, extra=
[i].addr, extra[i].len);
> > > > > > > >
> > > > > > > > In which case we need to unmap by driver but we don't need =
a dma address?
> > > > > > >
> > > > > > > Sorry, do not get it.
> > > > > >
> > > > > > I meant, I don't get how we can reach to this check.
> > > > >
> > > > > This is the main way. I think you miss something.
> > > >
> > > > Or maybe you can explain the case where vq->do_unmap is false but *=
sg is NULL?
> > >
> > >
> > > If vq->do_unmap is false, that is premapped mode or use_dma_api is fa=
lse.
> > > If the *sg is null, that means that the driver call the API
> > > virtqueue_get_buf_ctx or virtqueue_get_buf.
> > > If the *sg is not null, that means that the driver call the API
> > >
> > >         void *virtqueue_get_buf_ctx_dma(struct virtqueue *_vq, unsign=
ed int *len,
> > >                                         struct scatterlist *sg, void =
**ctx);
> > >
> > > Thanks.
> >
> > Ok, but my question still:
> >
> > 1) you explain one possible way here is use_dma_api is false and the
> > driver doesn't call virtqueue_get_buf_ctx_dma().
>
> If the use_dma_api is false, then we cannot set to premapped mode.
> If the driver calls virtqueue_get_buf_ctx_dma(), that works as
> virtqueue_get_buf_ctx().
>
>
> > 2) what happens if the driver uses a preamp but doesn't use
> > virtqueue_get_buf_ctx_dma()? Should we warn in this case?
>
> The developer should know that he need to do unmap, so I think
> that is not needed.

Well, kind of layer violation here. Driver may trust the virtio core
but not verse vica.

E.g there are several WARN_ON() in the virtio_ring.

Thanks

>
> Thanks.
>
>
>
> >
> > Thanks
> >
>

