Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F94AEB64DA
	for <virtualization@archiver.kernel.org>; Sun, 25 Jun 2023 02:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC8D361233;
	Sun, 25 Jun 2023 02:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC8D361233
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrVnrDfEaWvO; Sun, 25 Jun 2023 02:20:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B0346123D;
	Sun, 25 Jun 2023 02:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B0346123D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0242EC007A;
	Sun, 25 Jun 2023 02:20:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0F2C0029
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 02:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EAA540467
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 02:20:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EAA540467
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UsZVLUX_8h6W
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 02:20:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 608F9400F1
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 608F9400F1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 02:20:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R511e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VlqVEkf_1687659632; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VlqVEkf_1687659632) by smtp.aliyun-inc.com;
 Sun, 25 Jun 2023 10:20:33 +0800
Message-ID: <1687659046.7482243-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 05/10] virtio_ring: split-detach: support return
 dma info to driver
Date: Sun, 25 Jun 2023 10:10:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-6-xuanzhuo@linux.alibaba.com>
 <20230622153111-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622153111-mutt-send-email-mst@kernel.org>
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

On Thu, 22 Jun 2023 15:36:41 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Jun 02, 2023 at 05:22:01PM +0800, Xuan Zhuo wrote:
> > Under the premapped mode, the driver needs to unmap the DMA address
> > after receiving the buffer. The virtio core records the DMA address,
> > so the driver needs a way to get the dma info from the virtio core.
> >
> > A straightforward approach is to pass an array to the virtio core when
> > calling virtqueue_get_buf(). However, it is not feasible when there are
> > multiple DMA addresses in the descriptor chain, and the array size is
> > unknown.
> >
> > To solve this problem, a helper be introduced. After calling
> > virtqueue_get_buf(), the driver can call the helper to
> > retrieve a dma info. If the helper function returns -EAGAIN, it means
> > that there are more DMA addresses to be processed, and the driver should
> > call the helper function again. To keep track of the current position in
> > the chain, a cursor must be passed to the helper function, which is
> > initialized by virtqueue_get_buf().
> >
> > Some processes are done inside this helper, so this helper MUST be
> > called under the premapped mode.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 118 ++++++++++++++++++++++++++++++++---
> >  include/linux/virtio.h       |  11 ++++
> >  2 files changed, 119 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dc109fbc05a5..cdc4349f6066 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -754,8 +754,95 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> >  	return needs_kick;
> >  }
> >
> > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > -			     void **ctx)
> > +static void detach_cursor_init_split(struct vring_virtqueue *vq,
> > +				     struct virtqueue_detach_cursor *cursor, u16 head)
> > +{
> > +	struct vring_desc_extra *extra;
> > +
> > +	extra = &vq->split.desc_extra[head];
> > +
> > +	/* Clear data ptr. */
> > +	vq->split.desc_state[head].data = NULL;
> > +
> > +	cursor->head = head;
> > +	cursor->done = 0;
> > +
> > +	if (extra->flags & VRING_DESC_F_INDIRECT) {
> > +		cursor->num = extra->len / sizeof(struct vring_desc);
> > +		cursor->indirect = true;
> > +		cursor->pos = 0;
> > +
> > +		vring_unmap_one_split(vq, head);
> > +
> > +		extra->next = vq->free_head;
> > +
> > +		vq->free_head = head;
> > +
> > +		/* Plus final descriptor */
> > +		vq->vq.num_free++;
> > +
> > +	} else {
> > +		cursor->indirect = false;
> > +		cursor->pos = head;
> > +	}
> > +}
> > +
> > +static int virtqueue_detach_split(struct virtqueue *_vq, struct virtqueue_detach_cursor *cursor,
> > +				  dma_addr_t *addr, u32 *len, enum dma_data_direction *dir)
> > +{
>
> I don't get it. This is generic split vq code?

NO. This is the api for split vq when the address is mapped by the driver.

> Why is it unconditionally
> wasting time with cursors etc? Poking at split.desc_extra when not
> necessary is also not really nice, will cause lots of cache misses.

virtqueue_get_buf_ctx_split() is the generic code.

I just add the checking of vq->premapped.

>
> And it looks like we duplicated a bunch of logic?

Yes.

The detach_buf_split() is the origin logic.
But now, the driver needs to get the dma info of every desc, so
I break the loop of the detach_buf_split().
But, the logic is simple, so I think it is ok.

virtqueue_detach_split() return the dma info of every desc.
detach_cursor_init_split() init the cursor inside virtqueue_get_buf_ctx_split().

>
>
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> > +	int rc = -EAGAIN;
> > +
> > +	if (unlikely(cursor->done))
> > +		return -EINVAL;
> > +
> > +	if (!cursor->indirect) {
> > +		struct vring_desc_extra *extra;
> > +		unsigned int i;
> > +
> > +		i = cursor->pos;
> > +
> > +		extra = &vq->split.desc_extra[i];
> > +
> > +		if (vq->split.vring.desc[i].flags & nextflag) {
> > +			cursor->pos = extra->next;
> > +		} else {
> > +			extra->next = vq->free_head;
> > +			vq->free_head = cursor->head;
> > +			cursor->done = true;
> > +			rc = 0;
> > +		}
> > +
> > +		*addr = extra->addr;
> > +		*len = extra->len;
> > +		*dir = (extra->flags & VRING_DESC_F_WRITE) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> > +
> > +		vq->vq.num_free++;
> > +
> > +	} else {
> > +		struct vring_desc *indir_desc, *desc;
> > +		u16 flags;
> > +
> > +		indir_desc = vq->split.desc_state[cursor->head].indir_desc;
> > +		desc = &indir_desc[cursor->pos];
> > +
> > +		flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
> > +		*addr = virtio64_to_cpu(vq->vq.vdev, desc->addr);
> > +		*len = virtio32_to_cpu(vq->vq.vdev, desc->len);
> > +		*dir = (flags & VRING_DESC_F_WRITE) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> > +
> > +		if (++cursor->pos == cursor->num) {
> > +			kfree(indir_desc);
> > +			cursor->done = true;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head)
> >  {
> >  	unsigned int i, j;
> >  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> > @@ -799,8 +886,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> >
> >  		kfree(indir_desc);
> >  		vq->split.desc_state[head].indir_desc = NULL;
> > -	} else if (ctx) {
> > -		*ctx = vq->split.desc_state[head].indir_desc;
> >  	}
> >  }
> >
> > @@ -812,7 +897,8 @@ static bool more_used_split(const struct vring_virtqueue *vq)
> >
> >  static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >  					 unsigned int *len,
> > -					 void **ctx)
> > +					 void **ctx,
> > +					 struct virtqueue_detach_cursor *cursor)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  	void *ret;
> > @@ -852,7 +938,15 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> >
> >  	/* detach_buf_split clears data, so grab it now. */
> >  	ret = vq->split.desc_state[i].data;
> > -	detach_buf_split(vq, i, ctx);
> > +
> > +	if (!vq->indirect && ctx)
> > +		*ctx = vq->split.desc_state[i].indir_desc;
> > +
> > +	if (vq->premapped)
> > +		detach_cursor_init_split(vq, cursor, i);
> > +	else
> > +		detach_buf_split(vq, i);
> > +
> >  	vq->last_used_idx++;
> >  	/* If we expect an interrupt for the next entry, tell host
> >  	 * by writing event index and flush out the write before
> > @@ -961,7 +1055,8 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> >  	return true;
> >  }
> >
> > -static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> > +static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq,
> > +					       struct virtqueue_detach_cursor *cursor)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  	unsigned int i;
> > @@ -974,7 +1069,10 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> >  			continue;
> >  		/* detach_buf_split clears data, so grab it now. */
> >  		buf = vq->split.desc_state[i].data;
> > -		detach_buf_split(vq, i, NULL);
> > +		if (vq->premapped)
> > +			detach_cursor_init_split(vq, cursor, i);
> > +		else
> > +			detach_buf_split(vq, i);
> >  		vq->split.avail_idx_shadow--;
> >  		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> >  				vq->split.avail_idx_shadow);
> > @@ -2361,7 +2459,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> >  	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> > -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> > +				 virtqueue_get_buf_ctx_split(_vq, len, ctx, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> >
> > @@ -2493,7 +2591,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> >  	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
> > -				 virtqueue_detach_unused_buf_split(_vq);
> > +				 virtqueue_detach_unused_buf_split(_vq, NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 1fc0e1023bd4..eb4a4e4329aa 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -38,6 +38,17 @@ struct virtqueue {
> >  	void *priv;
> >  };
> >
> > +struct virtqueue_detach_cursor {
> > +	unsigned indirect:1;
> > +	unsigned done:1;
> > +	unsigned hole:14;
> > +
> > +	/* for split head */
> > +	unsigned head:16;
> > +	unsigned num:16;
> > +	unsigned pos:16;
> > +};
> > +
>
> is cursor ever stored somewhere? If not don't use bitfields,
> they cause many gcc versions to generate atrocious code.

OK.


Thanks.


>
>
> >  int virtqueue_add_outbuf(struct virtqueue *vq,
> >  			 struct scatterlist sg[], unsigned int num,
> >  			 void *data,
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
