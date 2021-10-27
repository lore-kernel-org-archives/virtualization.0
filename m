Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB24EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 09:12:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636786103C
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 09:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 636786103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 182F38191E;
	Wed, 27 Oct 2021 09:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFkR5OWuCNiV; Wed, 27 Oct 2021 09:12:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3229781A29;
	Wed, 27 Oct 2021 09:12:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B6BFC0019;
	Wed, 27 Oct 2021 09:12:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3DE4C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D09640286
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:12:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bA4gNQwuHS3m
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:12:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F36D8401A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 09:12:03 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UtsJzZf_1635325919; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UtsJzZf_1635325919) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 27 Oct 2021 17:11:59 +0800
MIME-Version: 1.0
message-id: <1635325418.7795458-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 1/3] virtio: cache indirect desc for split
date: Wed, 27 Oct 2021 17:03:38 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211027043851-mutt-send-email-mst@kernel.org>
x-mailing-list: netdev@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 27 Oct 2021 04:55:16 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Oct 27, 2021 at 02:19:11PM +0800, Xuan Zhuo wrote:
> > In the case of using indirect, indirect desc must be allocated and
> > released each time, which increases a lot of cpu overhead.
> >
> > Here, a cache is added for indirect. If the number of indirect desc to be
> > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio.c      |  6 ++++
> >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++------
> >  include/linux/virtio.h       | 10 ++++++
> >  3 files changed, 70 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 0a5b54034d4b..04bcb74e5b9a 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(is_virtio_device);
> >
> > +void virtio_use_desc_cache(struct virtio_device *dev, bool val)
> > +{
> > +	dev->desc_cache = val;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_use_desc_cache);
> > +
> >  void unregister_virtio_device(struct virtio_device *dev)
> >  {
> >  	int index = dev->index; /* save for after device release */
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dd95dfd85e98..0b9a8544b0e8 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -117,6 +117,10 @@ struct vring_virtqueue {
> >  	/* Hint for event idx: already triggered no need to disable. */
> >  	bool event_triggered;
> >
> > +	/* Is indirect cache used? */
> > +	bool use_desc_cache;
> > +	void *desc_cache_chain;
> > +
> >  	union {
> >  		/* Available for split ring */
> >  		struct {
>
> Let's use llist_head and friends please (I am guessing we want
> single-linked to avoid writing into indirect buffer after use,
> invalidating the cache, but please document why in a comment).  Do not
> open-code it.
>
> Also hide all casts in inline wrappers.
>
>
> > @@ -423,12 +427,47 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> >  	return extra[i].next;
> >  }
> >
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > +#define VIRT_QUEUE_CACHE_DESC_NUM 4
>
> Add an inline wrapper for checking sg versus VIRT_QUEUE_CACHE_DESC_NUM.
>
> > +
> > +static void desc_cache_chain_free_split(void *chain)
> > +{
> > +	struct vring_desc *desc;
> > +
> > +	while (chain) {
> > +		desc = chain;
> > +		chain = (void *)desc->addr;
> > +		kfree(desc);
> > +	}
> > +}
> > +
> > +static void desc_cache_put_split(struct vring_virtqueue *vq,
> > +				 struct vring_desc *desc, int n)
> > +{
> > +	if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > +		desc->addr = (u64)vq->desc_cache_chain;
> > +		vq->desc_cache_chain = desc;
> > +	} else {
> > +		kfree(desc);
> > +	}
> > +}
>
>
> > +
> > +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
> >  					       unsigned int total_sg,
> >  					       gfp_t gfp)
> >  {
> >  	struct vring_desc *desc;
> > -	unsigned int i;
> > +	unsigned int i, n;
> > +
> > +	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > +		if (vq->desc_cache_chain) {
> > +			desc = vq->desc_cache_chain;
> > +			vq->desc_cache_chain = (void *)desc->addr;
> > +			goto got;
> > +		}
> > +		n = VIRT_QUEUE_CACHE_DESC_NUM;
>
> Hmm. This will allocate more entries than actually used. Why do it?

If total_sg here is 2, we only allocate two desc here, but if total_sg is 3
later, it will be difficult to use the desc allocated this time.

So if total_sg is less than or equal to 4, a desc array of size 4 is allocated,
so that subsequent desc arrays can be reused when total_sg is less than or
equal to 4. If total_sg is greater than 4, use kmalloc_array to allocate
directly without using the cache.

Thanks.

>
> > +	} else {
> > +		n = total_sg;
> > +	}
> >
> >  	/*
> >  	 * We require lowmem mappings for the descriptors because
> > @@ -437,12 +476,13 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> >  	 */
> >  	gfp &= ~__GFP_HIGHMEM;
> >
> > -	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> > +	desc = kmalloc_array(n, sizeof(struct vring_desc), gfp);
> >  	if (!desc)
> >  		return NULL;
> >
> > +got:
> >  	for (i = 0; i < total_sg; i++)
> > -		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
> > +		desc[i].next = cpu_to_virtio16(vq->vq.vdev, i + 1);
> >  	return desc;
> >  }
> >
> > @@ -508,7 +548,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	head = vq->free_head;
> >
> >  	if (virtqueue_use_indirect(_vq, total_sg))
> > -		desc = alloc_indirect_split(_vq, total_sg, gfp);
> > +		desc = alloc_indirect_split(vq, total_sg, gfp);
> >  	else {
> >  		desc = NULL;
> >  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> > @@ -652,7 +692,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	}
> >
> >  	if (indirect)
> > -		kfree(desc);
> > +		desc_cache_put_split(vq, desc, total_sg);
> >
> >  	END_USE(vq);
> >  	return -ENOMEM;
> > @@ -717,7 +757,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  	if (vq->indirect) {
> >  		struct vring_desc *indir_desc =
> >  				vq->split.desc_state[head].indir_desc;
> > -		u32 len;
> > +		u32 len, n;
> >
> >  		/* Free the indirect table, if any, now that it's unmapped. */
> >  		if (!indir_desc)
> > @@ -729,10 +769,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  				VRING_DESC_F_INDIRECT));
> >  		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> >
> > -		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> > +		n = len / sizeof(struct vring_desc);
> > +
> > +		for (j = 0; j < n; j++)
> >  			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> >
> > -		kfree(indir_desc);
> > +		desc_cache_put_split(vq, indir_desc, n);
> >  		vq->split.desc_state[head].indir_desc = NULL;
> >  	} else if (ctx) {
> >  		*ctx = vq->split.desc_state[head].indir_desc;
> > @@ -2199,6 +2241,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >  		!context;
> >  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > +	vq->desc_cache_chain = NULL;
> > +	vq->use_desc_cache = vdev->desc_cache;
> >
> >  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >  		vq->weak_barriers = false;
> > @@ -2329,6 +2373,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  	if (!vq->packed_ring) {
> >  		kfree(vq->split.desc_state);
> >  		kfree(vq->split.desc_extra);
> > +		desc_cache_chain_free_split(vq->desc_cache_chain);
> >  	}
> >  	kfree(vq);
> >  }
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..d84b7b8f4070 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -109,6 +109,7 @@ struct virtio_device {
> >  	bool failed;
> >  	bool config_enabled;
> >  	bool config_change_pending;
> > +	bool desc_cache;
> >  	spinlock_t config_lock;
> >  	spinlock_t vqs_list_lock; /* Protects VQs list access */
> >  	struct device dev;
> > @@ -130,6 +131,15 @@ int register_virtio_device(struct virtio_device *dev);
> >  void unregister_virtio_device(struct virtio_device *dev);
> >  bool is_virtio_device(struct device *dev);
> >
> > +/**
> > + * virtio_use_desc_cache - virtio ring use desc cache
> > + *
> > + * virtio will cache the allocated indirect desc.
> > + *
> > + * This function must be called before find_vqs.
> > + */
> > +void virtio_use_desc_cache(struct virtio_device *dev, bool val);
> > +
> >  void virtio_break_device(struct virtio_device *dev);
> >
> >  void virtio_config_changed(struct virtio_device *dev);
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
