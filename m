Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37535C636CC
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 06:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A659881DA3;
	Mon, 20 Feb 2023 06:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A659881DA3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vFQ-3g16uwY0; Mon, 20 Feb 2023 06:57:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B52181D46;
	Mon, 20 Feb 2023 06:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B52181D46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1515CC0033;
	Mon, 20 Feb 2023 06:57:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D5DBC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF5F141806
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:57:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF5F141806
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8alak-xoi40
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:57:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 610C7417B0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 610C7417B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 06:57:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vc0iS3X_1676876253; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vc0iS3X_1676876253) by smtp.aliyun-inc.com;
 Mon, 20 Feb 2023 14:57:33 +0800
Message-ID: <1676876173.584213-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/10] virtio_ring: packed: separate prepare code
 from virtuque_add_indirect_packed()
Date: Mon, 20 Feb 2023 14:56:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEu9f6kTuMXSk=KguqS3rzYHEx72OjFfFzD=Ao4K33G8=A@mail.gmail.com>
In-Reply-To: <CACGkMEu9f6kTuMXSk=KguqS3rzYHEx72OjFfFzD=Ao4K33G8=A@mail.gmail.com>
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

On Mon, 20 Feb 2023 13:37:41 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Separating the logic of allocating indirect desc and checking queue
> > status to the upper layer function.
> >
> > The proposal of this is convenient to refactor virtqueue_add_packed()
> > for premapped.
> >
>
> Ok, so this is another hint that we should do the same thing for split.


Since split does not have an independent indirect function, both are different
here. Therefore, there will be no the same thing for split.

Thanks.


>
> Thanks
>
>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 29 ++++++++++++-----------------
> >  1 file changed, 12 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 560ee30d942c..42b1ff87518e 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1330,25 +1330,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >                                          unsigned int out_sgs,
> >                                          unsigned int in_sgs,
> >                                          void *data,
> > -                                        gfp_t gfp)
> > +                                        struct vring_packed_desc *desc)
> >  {
> > -       struct vring_packed_desc *desc;
> >         struct scatterlist *sg;
> >         unsigned int i, n, err_idx;
> >         u16 head, id;
> >         dma_addr_t addr;
> >
> >         head = vq->packed.next_avail_idx;
> > -       desc = alloc_indirect_packed(total_sg, gfp);
> > -       if (!desc)
> > -               return -ENOMEM;
> > -
> > -       if (unlikely(vq->vq.num_free < 1)) {
> > -               pr_debug("Can't add buf len 1 - avail = 0\n");
> > -               kfree(desc);
> > -               END_USE(vq);
> > -               return -ENOSPC;
> > -       }
> >
> >         i = 0;
> >         id = vq->free_head;
> > @@ -1470,11 +1459,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >         BUG_ON(total_sg == 0);
> >
> >         if (virtqueue_use_indirect(vq, total_sg)) {
> > -               err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> > -                                                   in_sgs, data, gfp);
> > -               if (err != -ENOMEM) {
> > -                       END_USE(vq);
> > -                       return err;
> > +               desc = alloc_indirect_packed(total_sg, gfp);
> > +               if (desc) {
> > +                       if (unlikely(vq->vq.num_free < 1)) {
> > +                               pr_debug("Can't add buf len 1 - avail = 0\n");
> > +                               kfree(desc);
> > +                               END_USE(vq);
> > +                               return -ENOSPC;
> > +                       }
> > +
> > +                       return virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> > +                                                            in_sgs, data, desc);
> >                 }
> >
> >                 /* fall back on direct */
> > --
> > 2.32.0.3.g01195cf9f
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
