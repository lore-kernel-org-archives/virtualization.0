Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A821C05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 06:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF5B740B90;
	Mon, 20 Feb 2023 06:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF5B740B90
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRb4wzcs118g; Mon, 20 Feb 2023 06:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E40A0400F3;
	Mon, 20 Feb 2023 06:56:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E40A0400F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92E9FC0033;
	Mon, 20 Feb 2023 06:56:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE9F5C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B644F417B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:56:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B644F417B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxjGW_u4I_qZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17B0C4182C
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17B0C4182C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:56:07 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vc1XHJM_1676876161; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vc1XHJM_1676876161) by smtp.aliyun-inc.com;
 Mon, 20 Feb 2023 14:56:01 +0800
Message-ID: <1676875439.7257378-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 04/10] virtio_ring: split: introduce
 virtqueue_add_split_premapped()
Date: Mon, 20 Feb 2023 14:43:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvWG1VVPHQd64SsdB52tgimoN_Dd6QT2Uvc5S8Qmrdcow@mail.gmail.com>
In-Reply-To: <CACGkMEvWG1VVPHQd64SsdB52tgimoN_Dd6QT2Uvc5S8Qmrdcow@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 20 Feb 2023 13:38:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > virtqueue_add_split() only supports virtual addresses, dma is completed
> > in virtqueue_add_split().
> >
> > In some scenarios (such as the AF_XDP scenario), the memory is allocated
> > and DMA is completed in advance, so it is necessary for us to support
> > passing the DMA address to virtio core.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 100 +++++++++++++++++++++++++++++++++--
> >  include/linux/virtio.h       |   5 ++
> >  2 files changed, 100 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 47b6f9152f9f..a31155abe101 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,6 +70,7 @@
> >  struct vring_desc_state_split {
> >         void *data;                     /* Data for callback. */
> >         struct vring_desc *indir_desc;  /* Indirect descriptor, if any. */
> > +       bool premapped;
>
> Better with a comment.
>
> Not native speaker, but "dma_addr" might be better?
>
> >  };
> >
> >  struct vring_desc_state_packed {
> > @@ -440,7 +441,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> >  }
> >
> >  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> > -                                         unsigned int i)
> > +                                         unsigned int i, bool premapped)
> >  {
> >         struct vring_desc_extra *extra = vq->split.desc_extra;
> >         u16 flags;
> > @@ -457,6 +458,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> >                                  (flags & VRING_DESC_F_WRITE) ?
> >                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >         } else {
> > +               if (premapped)
> > +                       goto out;
> > +
> >                 dma_unmap_page(vring_dma_dev(vq),
> >                                extra[i].addr,
> >                                extra[i].len,
> > @@ -788,6 +792,47 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >         return err;
> >  }
> >
> > +static inline int virtqueue_add_split_premapped(struct virtqueue *_vq,
> > +                                               struct scatterlist *sgs[],
> > +                                               unsigned int total_sg,
> > +                                               unsigned int out_sgs,
> > +                                               unsigned int in_sgs,
> > +                                               void *data,
> > +                                               void *ctx,
> > +                                               gfp_t gfp)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +       struct vring_desc *desc;
> > +       int head;
> > +       int err;
> > +
> > +       START_USE(vq);
> > +
> > +       /* check vq state and try to alloc desc for indirect. */
> > +       err = virtqueue_add_split_prepare(vq, total_sg, out_sgs, data, ctx, gfp, &desc);
> > +       if (err)
> > +               goto end;
> > +
> > +       head = vq->free_head;
> > +       err = virtqueue_add_split_vring(vq, sgs, total_sg, out_sgs, in_sgs, desc);
> > +       if (err)
> > +               goto err;
> > +
> > +       /* Store token and indirect buffer state. */
> > +       vq->split.desc_state[head].data = data;
> > +       vq->split.desc_state[head].indir_desc = desc ? desc : ctx;
> > +       vq->split.desc_state[head].premapped = true;
>
> This function duplicates most of the logic of virtqueue_add_split()
> let's unify it.

I want to know that the __virtqueue_add_split is the original
virtqueue_add_split or my refactor virtqueue_add_split?

>
> probably:
>
> __virtqueue_add_split(..., bool premapped);
> virtqueue_add_split()
> {
>     __virtqueue_add_split(..., false);
> }
>
> virtqueue_add_split_premapped()
> {
>    __virtqueue_add_split(..., true);
> }

I am trying to reduce the inspection of premapped.

In fact, this is Michael's request, although I am not particularly sure that my
implementation has met his requirements.

https://lore.kernel.org/all/20230203041006-mutt-send-email-mst@kernel.org/

Thanks.


>
> ?
>
> And so did for packed (patch 5).
>
> Thanks
>
>
>
> > +
> > +       goto end;
> > +
> > +err:
> > +       kfree(desc);
> > +
> > +end:
> > +       END_USE(vq);
> > +       return err;
> > +}
> > +
> >  static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> > @@ -824,20 +869,23 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  {
> >         unsigned int i, j;
> >         __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> > +       bool premapped;
> >
> >         /* Clear data ptr. */
> >         vq->split.desc_state[head].data = NULL;
> >
> > +       premapped = vq->split.desc_state[head].premapped;
> > +
> >         /* Put back on free list: unmap first-level descriptors and find end */
> >         i = head;
> >
> >         while (vq->split.vring.desc[i].flags & nextflag) {
> > -               vring_unmap_one_split(vq, i);
> > +               vring_unmap_one_split(vq, i, premapped);
> >                 i = vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> >         }
> >
> > -       vring_unmap_one_split(vq, i);
> > +       vring_unmap_one_split(vq, i, premapped);
> >         vq->split.desc_extra[i].next = vq->free_head;
> >         vq->free_head = head;
> >
> > @@ -859,8 +907,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >                                 VRING_DESC_F_INDIRECT));
> >                 BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> >
> > -               for (j = 0; j < len / sizeof(struct vring_desc); j++)
> > -                       vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> > +               if (!premapped) {
> > +                       for (j = 0; j < len / sizeof(struct vring_desc); j++)
> > +                               vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> > +               }
> >
> >                 kfree(indir_desc);
> >                 vq->split.desc_state[head].indir_desc = NULL;
> > @@ -2204,6 +2254,21 @@ static inline int virtqueue_add(struct virtqueue *_vq,
> >                                         out_sgs, in_sgs, data, ctx, gfp);
> >  }
> >
> > +static inline int virtqueue_add_premapped(struct virtqueue *_vq,
> > +                                         struct scatterlist *sgs[],
> > +                                         unsigned int total_sg,
> > +                                         unsigned int out_sgs,
> > +                                         unsigned int in_sgs,
> > +                                         void *data,
> > +                                         void *ctx,
> > +                                         gfp_t gfp)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +       return virtqueue_add_split_premapped(_vq, sgs, total_sg, out_sgs,
> > +                                            in_sgs, data, ctx, gfp);
> > +}
> > +
> >  /**
> >   * virtqueue_add_sgs - expose buffers to other end
> >   * @_vq: the struct virtqueue we're talking about.
> > @@ -2261,6 +2326,31 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
> >
> > +/**
> > + * virtqueue_add_outbuf_premapped - expose output buffers to other end
> > + * @vq: the struct virtqueue we're talking about.
> > + * @sg: scatterlist (must be well-formed and terminated!)
> > + * @num: the number of entries in @sg readable by other side
> > + * @data: the token identifying the buffer.
> > + * @gfp: how to do memory allocations (if necessary).
> > + *
> > + * Caller must ensure we don't call this with other virtqueue operations
> > + * at the same time (except where noted).
> > + *
> > + * It is required that all addrs have completed DMA operations. And use
> > + * sg->dma_address, sg->length to pass addr and length.
> > + *
> > + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> > + */
> > +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> > +                                  struct scatterlist *sg, unsigned int num,
> > +                                  void *data,
> > +                                  gfp_t gfp)
> > +{
> > +       return virtqueue_add_premapped(vq, &sg, num, 1, 0, data, NULL, gfp);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
> > +
> >  /**
> >   * virtqueue_add_inbuf - expose input buffers to other end
> >   * @vq: the struct virtqueue we're talking about.
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index dcab9c7e8784..d8b472a7dcae 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -43,6 +43,11 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
> >                          void *data,
> >                          gfp_t gfp);
> >
> > +int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
> > +                                  struct scatterlist *sg, unsigned int num,
> > +                                  void *data,
> > +                                  gfp_t gfp);
> > +
> >  int virtqueue_add_inbuf(struct virtqueue *vq,
> >                         struct scatterlist sg[], unsigned int num,
> >                         void *data,
> > --
> > 2.32.0.3.g01195cf9f
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
