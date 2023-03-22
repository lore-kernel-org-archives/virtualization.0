Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BAAC6FD1D
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 01:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 391A3611E2;
	Wed, 22 Mar 2023 01:52:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 391A3611E2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDiFAYLkVJDG; Wed, 22 Mar 2023 01:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C64F960BFC;
	Wed, 22 Mar 2023 01:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C64F960BFC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14DC5C0071;
	Wed, 22 Mar 2023 01:52:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35998C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 01:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1800A40320
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 01:52:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1800A40320
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GbQ40JFpzbL4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 01:52:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E550401C9
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E550401C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 01:52:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeOjpo-_1679449947; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeOjpo-_1679449947) by smtp.aliyun-inc.com;
 Wed, 22 Mar 2023 09:52:27 +0800
Message-ID: <1679449936.023117-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 04/11] virtio_ring: split: support premapped
Date: Wed, 22 Mar 2023 09:52:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230321093506.6546-1-xuanzhuo@linux.alibaba.com>
 <20230321093506.6546-5-xuanzhuo@linux.alibaba.com>
 <20230321164343-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321164343-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org
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

On Tue, 21 Mar 2023 16:45:21 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Mar 21, 2023 at 05:34:59PM +0800, Xuan Zhuo wrote:
> > virtio core only supports virtual addresses, dma is completed in virtio
> > core.
> >
> > In some scenarios (such as the AF_XDP), the memory is allocated
> > and DMA mapping is completed in advance, so it is necessary for us to
> > support passing the DMA address to virtio core.
> >
> > Drives can use sg->dma_address to pass the mapped dma address to virtio
> > core. If one sg->dma_address is used then all sgs must use
> > sg->dma_address, otherwise all must be null when passing it to the APIs
> > of virtio.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c8ed4aef9462..be2ff96964c3 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -70,6 +70,7 @@
> >  struct vring_desc_state_split {
> >  	void *data;			/* Data for callback. */
> >  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> > +	bool map_inter;			/* Do dma map internally. */
>
> I prefer a full name. E.g. "dma_map_internal". Eschew abbreviation.


Will fix.

Thanks.


>
>
> >  };
> >
> >  struct vring_desc_state_packed {
> > @@ -448,7 +449,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> >  }
> >
> >  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> > -					  unsigned int i)
> > +					  unsigned int i, bool map_inter)
> >  {
> >  	struct vring_desc_extra *extra = vq->split.desc_extra;
> >  	u16 flags;
> > @@ -465,6 +466,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> >  				 (flags & VRING_DESC_F_WRITE) ?
> >  				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >  	} else {
> > +		if (!map_inter)
> > +			goto out;
> > +
> >  		dma_unmap_page(vring_dma_dev(vq),
> >  			       extra[i].addr,
> >  			       extra[i].len,
> > @@ -615,7 +619,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	struct scatterlist *sg;
> >  	struct vring_desc *desc;
> >  	unsigned int i, n, avail, descs_used, prev;
> > -	bool indirect;
> > +	bool indirect, map_inter;
> >  	int head;
> >
> >  	START_USE(vq);
> > @@ -668,7 +672,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  		return -ENOSPC;
> >  	}
> >
> > -	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
> > +	map_inter = !sgs[0]->dma_address;
> > +	if (map_inter && virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
> >  		return -ENOMEM;
> >
> >  	for (n = 0; n < out_sgs; n++) {
> > @@ -734,6 +739,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  		vq->split.desc_state[head].indir_desc = desc;
> >  	else
> >  		vq->split.desc_state[head].indir_desc = ctx;
> > +	vq->split.desc_state[head].map_inter = map_inter;
> >
> >  	/* Put entry in available array (but don't update avail->idx until they
> >  	 * do sync). */
> > @@ -759,7 +765,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	return 0;
> >
> >  unmap_release:
> > -	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> > +	if (map_inter)
> > +		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
> >
> >  	if (indirect)
> >  		kfree(desc);
> > @@ -804,20 +811,22 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  {
> >  	unsigned int i, j;
> >  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> > +	bool map_inter;
> >
> >  	/* Clear data ptr. */
> >  	vq->split.desc_state[head].data = NULL;
> > +	map_inter = vq->split.desc_state[head].map_inter;
> >
> >  	/* Put back on free list: unmap first-level descriptors and find end */
> >  	i = head;
> >
> >  	while (vq->split.vring.desc[i].flags & nextflag) {
> > -		vring_unmap_one_split(vq, i);
> > +		vring_unmap_one_split(vq, i, map_inter);
> >  		i = vq->split.desc_extra[i].next;
> >  		vq->vq.num_free++;
> >  	}
> >
> > -	vring_unmap_one_split(vq, i);
> > +	vring_unmap_one_split(vq, i, map_inter);
> >  	vq->split.desc_extra[i].next = vq->free_head;
> >  	vq->free_head = head;
> >
> > @@ -839,8 +848,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  				VRING_DESC_F_INDIRECT));
> >  		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> >
> > -		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> > -			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> > +		if (map_inter) {
> > +			for (j = 0; j < len / sizeof(struct vring_desc); j++)
> > +				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> > +		}
> >
> >  		kfree(indir_desc);
> >  		vq->split.desc_state[head].indir_desc = NULL;
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
