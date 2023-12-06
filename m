Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F117721
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 07:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC21882560
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 07:53:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC21882560
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYnbJwCwncsm
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 07:53:02 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 40CCE8230F
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 07:53:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40CCE8230F
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VxxG6eW_1701849173;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxxG6eW_1701849173)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 15:52:54 +0800
Message-ID: <1701848864.0588148-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 4/4] virtio_net: sq support premapped mode
Date: Wed, 6 Dec 2023 15:47:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com>
 <20231204072331.73776-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvT--4jgba4WHFzSqNgKhExPJVSrmhuUzrbeMf=9XeUGw@mail.gmail.com>
In-Reply-To: <CACGkMEvT--4jgba4WHFzSqNgKhExPJVSrmhuUzrbeMf=9XeUGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 5 Dec 2023 15:12:09 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Dec 4, 2023 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
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
> >  drivers/net/virtio/main.c       | 116 ++++++++++++++++++++++++++++----
> >  drivers/net/virtio/virtio_net.h |   2 +
> >  2 files changed, 105 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index d81ee75142e0..fa77a85d1d37 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -167,13 +167,32 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> >         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FL=
AG);
> >  }
> >
> > +static void virtnet_sq_unmap_buf(struct virtnet_sq *sq, struct virtio_=
dma_head *dma)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < dma->next; ++i)
> > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > +                                                dma->items[i].addr,
> > +                                                dma->items[i].length,
> > +                                                DMA_TO_DEVICE, 0);
> > +       dma->next =3D 0;
>
> I'd suggest to check vring_use_dma_api() then we can avoid the unnecessar=
y loop.

If the virtio core not add items, then the dma->next is 0.

>
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
> > +       dma =3D (typeof(dma))sq->sg;
>
> This seems tricky, people may forget to check the sizeof when they
> want to extend the dma in the future.
>
> Can we use union here?

Yes.


>
> > +       dma->num =3D ARRAY_SIZE(sq->sg);
> > +       dma->next =3D 0;
> > +
> > +       while ((ptr =3D virtqueue_get_buf_ctx_dma(sq->vq, &len, dma, NU=
LL)) !=3D NULL) {
> > +               virtnet_sq_unmap_buf(sq, dma);
>
> Can we allow passing NULL then core can just don't bother with
> collecting DMA information?

Will fix

>
> > +
> >                 if (!is_xdp_frame(ptr)) {
> >                         struct sk_buff *skb =3D ptr;
> >
> > @@ -567,20 +586,79 @@ static void *virtnet_rq_alloc(struct virtnet_rq *=
rq, u32 size, gfp_t gfp)
> >         return buf;
> >  }
> >
> > -static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > +static void virtnet_set_premapped(struct virtnet_info *vi)
> >  {
> > +       struct virtio_dma_head dma;
> > +       struct virtnet_sq *sq;
> >         int i;
> >
> > -       /* disable for big mode */
> > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > -               return;
> > +       sq =3D &vi->sq[0];
> > +
> > +       BUG_ON(sizeof(sq->sg) < sizeof(dma) + sizeof(dma.items[0]) * AR=
RAY_SIZE(sq->sg));
> >
> >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > -                       continue;
> > +               if (!virtqueue_set_dma_premapped(vi->sq[i].vq))
> > +                       vi->sq[i].do_dma =3D true;
> > +
> > +               /* disable for big mode */
> > +               if (vi->mergeable_rx_bufs || !vi->big_packets) {
> > +                       if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
> > +                               vi->rq[i].do_dma =3D true;
> > +               }
> > +       }
> > +}
> > +
> > +static void virtnet_sq_unmap_sg(struct virtnet_sq *sq, u32 num)
> > +{
> > +       struct scatterlist *sg;
> > +       u32 i;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               sg =3D &sq->sg[i];
> > +
> > +               virtqueue_dma_unmap_single_attrs(sq->vq,
> > +                                                sg->dma_address,
> > +                                                sg->length,
> > +                                                DMA_TO_DEVICE, 0);
> > +       }
> > +}
> > +
> > +static int virtnet_sq_map_sg(struct virtnet_sq *sq, u32 num)
> > +{
> > +       struct scatterlist *sg;
> > +       u32 i;
> > +
> > +       for (i =3D 0; i < num; ++i) {
> > +               sg =3D &sq->sg[i];
> > +               sg->dma_address =3D virtqueue_dma_map_single_attrs(sq->=
vq, sg_virt(sg),
> > +                                                                sg->le=
ngth,
> > +                                                                DMA_TO=
_DEVICE, 0);
> > +               if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address=
))
> > +                       goto err;
> > +       }
> > +
> > +       return 0;
> > +
> > +err:
> > +       virtnet_sq_unmap_sg(sq, i);
> > +       return -ENOMEM;
> > +}
> > +
> > +static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *da=
ta)
> > +{
> > +       int ret;
> >
> > -               vi->rq[i].do_dma =3D true;
> > +       if (sq->do_dma) {
> > +               ret =3D virtnet_sq_map_sg(sq, num);
> > +               if (ret)
> > +                       return -ENOMEM;
> >         }
> > +
> > +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATO=
MIC);
> > +       if (ret && sq->do_dma)
> > +               virtnet_sq_unmap_sg(sq, num);
> > +
> > +       return ret;
> >  }
> >
> >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > @@ -686,8 +764,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_in=
fo *vi,
> >                             skb_frag_size(frag), skb_frag_off(frag));
> >         }
> >
> > -       err =3D virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
> > -                                  xdp_to_ptr(xdpf), GFP_ATOMIC);
> > +       err =3D virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
> >         if (unlikely(err))
> >                 return -ENOSPC; /* Caller handle free/refcnt */
> >
> > @@ -2126,7 +2203,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct=
 sk_buff *skb)
> >                         return num_sg;
> >                 num_sg++;
> >         }
> > -       return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_AT=
OMIC);
> > +       return virtnet_add_outbuf(sq, num_sg, skb);
> >  }
> >
> >  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *=
dev)
> > @@ -3852,10 +3929,23 @@ static void virtnet_rq_free_unused_buf(struct v=
irtqueue *vq, void *buf)
> >
> >  static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
> >  {
> > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > +       struct virtio_dma_head *dma;
> > +       struct virtnet_sq *sq;
> > +       int i =3D vq2txq(vq);
> >         void *buf;
> >
> > -       while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL)
> > +       sq =3D &vi->sq[i];
> > +
> > +       dma =3D (typeof(dma))sq->sg;
> > +       dma->num =3D ARRAY_SIZE(sq->sg);
> > +       dma->next =3D 0;
> > +
> > +       while ((buf =3D virtqueue_detach_unused_buf_premapped(vq, dma))=
 !=3D NULL) {
> > +               virtnet_sq_unmap_buf(sq, dma);
> > +
> >                 virtnet_sq_free_unused_buf(vq, buf);
> > +       }
> >  }
> >
> >  static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
> > @@ -4052,7 +4142,7 @@ static int init_vqs(struct virtnet_info *vi)
> >         if (ret)
> >                 goto err_free;
> >
> > -       virtnet_rq_set_premapped(vi);
> > +       virtnet_set_premapped(vi);
> >
> >         cpus_read_lock();
> >         virtnet_set_affinity(vi);
> > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virti=
o_net.h
> > index ebf9f344648a..870855a829a0 100644
> > --- a/drivers/net/virtio/virtio_net.h
> > +++ b/drivers/net/virtio/virtio_net.h
> > @@ -67,6 +67,8 @@ struct virtnet_sq {
> >
> >         /* Record whether sq is in reset state. */
> >         bool reset;
> > +
> > +       bool do_dma;
>
> Could we have a core helper for this? It can benefit for other driver
> like virtio-fs.

I like to let the driver keeps this. But you and Michael both think so. I w=
ill a
helper in next version.

Thanks.


>
> Thanks
>
>
> >  };
> >
> >  /* Internal representation of a receive virtqueue */
> > --
> > 2.32.0.3.g01195cf9f
> >
>
