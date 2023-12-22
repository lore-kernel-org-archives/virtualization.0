Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98256D50B
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 07:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1442281514
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 07:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1442281514
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NzS8OhMzwrX2
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Dec 2023 07:13:59 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 20E6B81468
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 07:13:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20E6B81468
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vz-.9.J_1703229231;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vz-.9.J_1703229231)
          by smtp.aliyun-inc.com;
          Fri, 22 Dec 2023 15:13:51 +0800
Message-ID: <1703229101.3814943-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 5/5] virtio_net: sq support premapped mode
Date: Fri, 22 Dec 2023 15:11:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com>
 <20231207080353.6575-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEstikKFNTrTeytjrDhuaGxEys=t=ZqGK1Eqv6giemWneQ@mail.gmail.com>
In-Reply-To: <CACGkMEstikKFNTrTeytjrDhuaGxEys=t=ZqGK1Eqv6giemWneQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 21 Dec 2023 11:32:49 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Dec 7, 2023 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > If the xsk is enabling, the xsk tx will share the send queue.
> > But the xsk requires that the send queue use the premapped mode.
> > So the send queue must support premapped mode.
> >
> > command: pktgen_sample01_simple.sh -i eth0 -s 16/1400 -d 10.0.0.123 -m =
00:16:3e:12:e1:3e -n 0 -p 100
> > matchine:  ecs.ebmg6e.26xlarge of Aliyun
> > cpu: Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> > iommu mode: intel_iommu=3Don iommu.strict=3D1 iommu=3Dnopt
> >
> >                       |        iommu off           |        iommu on
> > ----------------------|------------------------------------------------=
-----
> >                       | 16         |  1400         | 16         | 1400
> > ----------------------|------------------------------------------------=
-----
> > Before:               |1716796.00  |  1581829.00   | 390756.00  | 37449=
3.00
> > After(premapped off): |1733794.00  |  1576259.00   | 390189.00  | 37812=
8.00
> > After(premapped on):  |1707107.00  |  1562917.00   | 385667.00  | 37358=
4.00
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c       | 120 ++++++++++++++++++++++++++++----
>
> Any reason to depend this series to the relocation series?

This patch set will be located in the virtio-net support AF_XDP patch set.



>
> >  drivers/net/virtio/virtio_net.h |  10 ++-
> >  2 files changed, 117 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 83f24de00497..9600ffe1af86 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -167,13 +167,39 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FL=
AG);
> >  }
> >
> > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_=
dma_head *dma)
> > +{
> > +       int i;
> > +
> > +       if (!dma)
> > +               return;
> > +
> > +       for (i =3D 0; i < dma->next; ++i)
> > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > +                                                dma->items[i].addr,
> > +                                                dma->items[i].length,
> > +                                                DMA_TO_DEVICE, 0);
> > +       dma->next =3D 0;
> > +}
> > +
> >  static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> >                             u64 *bytes, u64 *packets)
> >  {
> > +       struct virtio_dma_head *dma;
> >         unsigned int len;
> >         void *ptr;
> >
> > -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> > +       if (virtqueue_get_dma_premapped(sq->vq)) {
> > +               dma =3D &sq->dma.head;
> > +               dma->num =3D ARRAY_SIZE(sq->dma.items);
> > +               dma->next =3D 0;
> > +       } else {
> > +               dma =3D NULL;
> > +       }
> > +
> > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NU=
LL)) !=3D NULL) {
> > +               virtnet_sq_unmap_buf(sq, dma);
> > +
> >                 if (!is_xdp_frame(ptr)) {
> >                         struct sk_buff *skb =3D ptr;
> >
> > @@ -567,16 +593,70 @@ static void *virtnet_rq_alloc(struct virtnet_rq *=
rq, u32 size, gfp_t gfp)
> >         return buf;
> >  }
> >
> > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > +static void virtnet_set_premapped(struct virtnet_info *vi)
> >  {
> >         int i;
> >
> > -       /* disable for big mode */
> > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > -               return;
> > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +               virtqueue_set_dma_premapped(vi->sq[i].vq);
> >
> > -       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > -               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > +               /* disable for big mode */
>
> Let's use a TODO here.


This will be fixed.

Thanks.


>
> Other looks good.
>
> Thanks
>
