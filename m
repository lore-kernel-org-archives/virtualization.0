Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E31BC7EE29
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 02:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76D0460B92;
	Mon,  5 Jun 2023 02:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76D0460B92
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PNHf7IsGzFvN; Mon,  5 Jun 2023 02:09:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6AE560BA2;
	Mon,  5 Jun 2023 02:09:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6AE560BA2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D08AC0037;
	Mon,  5 Jun 2023 02:09:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D257C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 02:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37EF0400DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 02:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37EF0400DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZOka6f1kYy8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 02:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7048040017
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7048040017
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 02:09:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R301e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VkIIE19_1685930945; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VkIIE19_1685930945) by smtp.aliyun-inc.com;
 Mon, 05 Jun 2023 10:09:06 +0800
Message-ID: <1685930811.137484-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 07/10] virtio_ring: introduce helpers for
 premapped
Date: Mon, 5 Jun 2023 10:06:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-8-xuanzhuo@linux.alibaba.com>
 <20230604094122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604094122-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Sun, 4 Jun 2023 09:45:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Jun 02, 2023 at 05:22:03PM +0800, Xuan Zhuo wrote:
> > This patch introduces three helpers for premapped mode.
> >
> > * virtqueue_get_buf_premapped
> > * virtqueue_detach_unused_buf_premapped
> >
> > The above helpers work like the non-premapped funcs. But a cursor is
> > passed.
> >
> > virtqueue_detach is used to get the dma info of the last buf by
> >   cursor.
>
> This isn't very clear from the description but virtqueue_detach is
> also introduced by this patch as opposed to being used.
>
>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 83 ++++++++++++++++++++++++++++++++++++
> >  include/linux/virtio.h       | 10 +++++
> >  2 files changed, 93 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cbc22daae7e1..6771b9661798 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2555,6 +2555,66 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
> >  	return virtqueue_get_buf_ctx(_vq, len, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_buf);
> > +
> > +/**
> > + * virtqueue_get_buf_premapped - get the next used buffer
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @len: the length written into the buffer
> > + * @ctx: extra context for the token
> > + * @cursor: detach cursor
> > + *
> > + * If the device wrote data into the buffer, @len will be set to the
> > + * amount written.  This means you don't need to clear the buffer
> > + * beforehand to ensure there's no data leakage in the case of short
> > + * writes.
> > + *
> > + * Caller must ensure we don't call this with other virtqueue
> > + * operations at the same time (except where noted).
> > + *
> > + * This is used for the premapped vq. The cursor is passed by the dirver, that
> > + * is used for virtqueue_detach. That will be initialized by virtio core
> > + * internally.
> > + *
> > + * Returns NULL if there are no used buffers, or the "data" token
> > + * handed to virtqueue_add_*().
> > + */
> > +void *virtqueue_get_buf_premapped(struct virtqueue *_vq, unsigned int *len,
> > +				  void **ctx,
> > +				  struct virtqueue_detach_cursor *cursor)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx, cursor) :
> > +				 virtqueue_get_buf_ctx_split(_vq, len, ctx, cursor);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_get_buf_premapped);
> > +
> > +/**
> > + * virtqueue_detach - get the dma info of last buf
>
> detach what from what then?
> I am guessing this is not the only thing this function does?
> sounds like a bad name for a function.

Let me think of a good name

>
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @cursor: detach cursor
> > + * @addr: the dma address
>
> what address?  it's the 1st time you mention an address ...

Will fix.


>
> > + * @len: the length of the dma address
> > + * @dir: the direction of the dma address
> > + *
> > + * This is used for the premapped vq. The cursor is initialized by
> > + * virtqueue_get_buf_premapped or virtqueue_detach_unused_buf_premapped.
> > + *
> > + * Returns:
> > + * -EAGAIN: there are more dma info, this function should be called more.
>
> here too, pls don't return -EAGAIN not in an error case.
> something like "1" will do.

While I agree with you, -EAGAIN seems to be a commonly used method. How about we
return EAGAIN instead of -EAGAIN ?

Thanks.



>
> > + * -EINVAL: the process is done, should not call this function
> > + * 0: no more dma info
> > + */
> > +int virtqueue_detach(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> > +		     dma_addr_t *addr, u32 *len, enum dma_data_direction *dir)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	return vq->packed_ring ? virtqueue_detach_packed(_vq, cursor, addr, len, dir) :
> > +				 virtqueue_detach_split(_vq, cursor, addr, len, dir);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_detach);
> > +
> >  /**
> >   * virtqueue_disable_cb - disable callbacks
> >   * @_vq: the struct virtqueue we're talking about.
> > @@ -2682,6 +2742,29 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> >
> > +/**
> > + * virtqueue_detach_unused_buf_premapped - detach first unused buffer
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @cursor: detach cursor
> > + *
> > + * This is used for the premapped vq. The cursor is passed by the dirver, that
> > + * is used for virtqueue_detach. That will be initialized by virtio core
> > + * internally.
> > + *
> > + * Returns NULL or the "data" token handed to virtqueue_add_*().
> > + * This is not valid on an active queue; it is useful for device
> > + * shutdown or the reset queue.
> > + */
> > +void *virtqueue_detach_unused_buf_premapped(struct virtqueue *_vq,
> > +					    struct virtqueue_detach_cursor *cursor)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq, cursor) :
> > +				 virtqueue_detach_unused_buf_split(_vq, cursor);
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf_premapped);
> > +
> >  static inline bool more_used(const struct vring_virtqueue *vq)
> >  {
> >  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 7f137c7a9034..0a11c5b32fe5 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -3,6 +3,7 @@
> >  #define _LINUX_VIRTIO_H
> >  /* Everything a virtio driver needs to work with any particular virtio
> >   * implementation. */
> > +#include <linux/dma-mapping.h>
> >  #include <linux/types.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/spinlock.h>
> > @@ -88,6 +89,10 @@ void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
> >  void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> >  			    void **ctx);
> >
> > +void *virtqueue_get_buf_premapped(struct virtqueue *_vq, unsigned int *len,
> > +				  void **ctx,
> > +				  struct virtqueue_detach_cursor *cursor);
> > +
> >  void virtqueue_disable_cb(struct virtqueue *vq);
> >
> >  bool virtqueue_enable_cb(struct virtqueue *vq);
> > @@ -101,6 +106,8 @@ bool virtqueue_poll(struct virtqueue *vq, unsigned);
> >  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
> >
> >  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> > +void *virtqueue_detach_unused_buf_premapped(struct virtqueue *_vq,
> > +					    struct virtqueue_detach_cursor *cursor);
> >
> >  unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
> >
> > @@ -114,6 +121,9 @@ dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
> >  int virtqueue_resize(struct virtqueue *vq, u32 num,
> >  		     void (*recycle)(struct virtqueue *vq, void *buf));
> >
> > +int virtqueue_detach(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> > +		     dma_addr_t *addr, u32 *len, enum dma_data_direction *dir);
> > +
> >  /**
> >   * struct virtio_device - representation of a device using virtio
> >   * @index: unique position on the virtio bus
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
