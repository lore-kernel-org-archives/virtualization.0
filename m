Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762AFC433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 08:23:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5AD60F56
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 08:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B5AD60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D29164013F;
	Tue,  2 Nov 2021 08:23:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zq_Z-CUTJ2Ky; Tue,  2 Nov 2021 08:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F16F1400C7;
	Tue,  2 Nov 2021 08:23:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAD53C0012;
	Tue,  2 Nov 2021 08:23:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29ACAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1147780B78
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ggmTo8Nb46u
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:23:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96D4180B00
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 08:23:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UuiTTXm_1635841425; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UuiTTXm_1635841425) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 02 Nov 2021 16:23:46 +0800
MIME-Version: 1.0
message-id: <1635841299.7737284-2-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v2 1/3] virtio: cache indirect desc for split
date: Tue, 02 Nov 2021 16:21:39 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211031033157-mutt-send-email-mst@kernel.org>
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

On Sun, 31 Oct 2021 10:46:12 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Oct 28, 2021 at 06:49:17PM +0800, Xuan Zhuo wrote:
> > In the case of using indirect, indirect desc must be allocated and
> > released each time, which increases a lot of cpu overhead.
> >
> > Here, a cache is added for indirect. If the number of indirect desc to be
> > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> What bothers me here is what happens if cache gets
> filled on one numa node, then used on another?
>
>
> > ---
> >  drivers/virtio/virtio.c      |  6 +++
> >  drivers/virtio/virtio_ring.c | 77 ++++++++++++++++++++++++++++++++----
> >  include/linux/virtio.h       | 14 +++++++
> >  3 files changed, 89 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 0a5b54034d4b..1047149ac2a4 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(is_virtio_device);
> >
> > +void virtio_set_desc_cache(struct virtio_device *dev, u32 thr)
> > +{
> > +	dev->desc_cache_thr = thr;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_set_desc_cache);
> > +
> >  void unregister_virtio_device(struct virtio_device *dev)
> >  {
> >  	int index = dev->index; /* save for after device release */
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dd95dfd85e98..0ebcd4f12d3b 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -117,6 +117,15 @@ struct vring_virtqueue {
> >  	/* Hint for event idx: already triggered no need to disable. */
> >  	bool event_triggered;
> >
> > +	/* desc cache threshold
> > +	 *    0   - disable desc cache
> > +	 *    > 0 - enable desc cache. As the threshold of the desc cache.
> > +	 */
> > +	u32 desc_cache_thr;
>
> not really descriptive. also pls eschew abbreviation.
>
> > +
> > +	/* desc cache chain */
> > +	struct list_head desc_cache;
>
> hmm this puts extra pressure on cache. you never need to drop
> things in the middle. llist_head would be better I
> think ... no?

In fact, I did not increase the allocated space for list_head.

use as desc array: | vring_desc | vring_desc | vring_desc | vring_desc |
use as queue item: | list_head ........................................|

Thanks.

>
>
> > +
> >  	union {
> >  		/* Available for split ring */
> >  		struct {
> > @@ -423,7 +432,53 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> >  	return extra[i].next;
> >  }
> >
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > +static void desc_cache_free(struct list_head *head)
> > +{
> > +	struct list_head *n, *pos;
> > +
> > +	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct vring_desc));
> > +	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct vring_packed_desc));
> > +
> > +	list_for_each_prev_safe(pos, n, head)
> > +		kfree(pos);
> > +}
> > +
> > +static void __desc_cache_put(struct vring_virtqueue *vq,
> > +			     struct list_head *node, int n)
> > +{
> > +	if (n <= vq->desc_cache_thr)
> > +		list_add(node, &vq->desc_cache);
> > +	else
> > +		kfree(node);
>
> this bothers me. Do we really need a full VQ's worth of
> indirect descriptors? Can't we set a limit on how many
> are used?
>
>
> > +}
> > +
> > +#define desc_cache_put(vq, desc, n) \
> > +	__desc_cache_put(vq, (struct list_head *)desc, n)
>
> replace with an inline function pls. in fact we dont need
> __desc_cache_put at all.
>
>
> > +
> > +static void *desc_cache_get(struct vring_virtqueue *vq,
> > +			    int size, int n, gfp_t gfp)
> > +{
> > +	struct list_head *node;
> > +
> > +	if (n > vq->desc_cache_thr)
> > +		return kmalloc_array(n, size, gfp);
> > +
> > +	if (!list_empty(&vq->desc_cache)) {
> > +		node = vq->desc_cache.next;
> > +		list_del(node);
> > +		return node;
> > +	}
> > +
> > +	return kmalloc_array(vq->desc_cache_thr, size, gfp);
> > +}
> > +
> > +#define _desc_cache_get(vq, n, gfp, tp) \
> > +	((tp *)desc_cache_get(vq, (sizeof(tp)), n, gfp))
> > +
> > +#define desc_cache_get_split(vq, n, gfp) \
> > +	_desc_cache_get(vq, n, gfp, struct vring_desc)
> > +
>
> same thing here.
>
> > +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
> >  					       unsigned int total_sg,
> >  					       gfp_t gfp)
> >  {
> > @@ -437,12 +492,12 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> >  	 */
> >  	gfp &= ~__GFP_HIGHMEM;
> >
> > -	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
> > +	desc = desc_cache_get_split(vq, total_sg, gfp);
> >  	if (!desc)
> >  		return NULL;
> >
> >  	for (i = 0; i < total_sg; i++)
> > -		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
> > +		desc[i].next = cpu_to_virtio16(vq->vq.vdev, i + 1);
> >  	return desc;
> >  }
> >
> > @@ -508,7 +563,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	head = vq->free_head;
> >
> >  	if (virtqueue_use_indirect(_vq, total_sg))
> > -		desc = alloc_indirect_split(_vq, total_sg, gfp);
> > +		desc = alloc_indirect_split(vq, total_sg, gfp);
> >  	else {
> >  		desc = NULL;
> >  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> > @@ -652,7 +707,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	}
> >
> >  	if (indirect)
> > -		kfree(desc);
> > +		desc_cache_put(vq, desc, total_sg);
> >
> >  	END_USE(vq);
> >  	return -ENOMEM;
> > @@ -717,7 +772,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >  	if (vq->indirect) {
> >  		struct vring_desc *indir_desc =
> >  				vq->split.desc_state[head].indir_desc;
> > -		u32 len;
> > +		u32 len, n;
> >
> >  		/* Free the indirect table, if any, now that it's unmapped. */
> >  		if (!indir_desc)
> > @@ -729,10 +784,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
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
> > +		desc_cache_put(vq, indir_desc, n);
> >  		vq->split.desc_state[head].indir_desc = NULL;
> >  	} else if (ctx) {
> >  		*ctx = vq->split.desc_state[head].indir_desc;
> > @@ -2199,6 +2256,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> >  		!context;
> >  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> > +	vq->desc_cache_thr = vdev->desc_cache_thr;
> > +
> > +	INIT_LIST_HEAD(&vq->desc_cache);
> >
> >  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >  		vq->weak_barriers = false;
>
> So e.g. for rx, we are wasting memory since indirect isn't used.
>
>
> > @@ -2329,6 +2389,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  	if (!vq->packed_ring) {
> >  		kfree(vq->split.desc_state);
> >  		kfree(vq->split.desc_extra);
> > +		desc_cache_free(&vq->desc_cache);
> >  	}
> >  	kfree(vq);
> >  }
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..bda6f9853e97 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -118,6 +118,7 @@ struct virtio_device {
> >  	struct list_head vqs;
> >  	u64 features;
> >  	void *priv;
> > +	u32 desc_cache_thr;
> >  };
> >
> >  static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> > @@ -130,6 +131,19 @@ int register_virtio_device(struct virtio_device *dev);
> >  void unregister_virtio_device(struct virtio_device *dev);
> >  bool is_virtio_device(struct device *dev);
> >
> > +/**
> > + * virtio_set_desc_cache - set virtio ring desc cache threshold
> > + *
> > + * virtio will cache the allocated indirect desc.
> > + *
> > + * This function must be called before find_vqs.
> > + *
> > + * @thr:
> > + *    0   - disable desc cache
> > + *    > 0 - enable desc cache. As the threshold of the desc cache.
> > + */
> > +void virtio_set_desc_cache(struct virtio_device *dev, u32 thr);
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
