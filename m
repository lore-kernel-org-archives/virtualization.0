Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C412C526
	for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235723; cv=none; b=jZPvb6AYhyX1mcjcGbmA7NF7Pr+/gzU/wUy7F9vPVC8RnvQhTzSLJzQhl4zi/5RuaQypZgm6zYGqUHIhgTeE9eYPgaIDeKcA79GmC6BQ10XO0BH08P6uOIJPEBQR6o5+fF2pYCwZi9E6kU0+VeMtwFK6nC7Yb0LvMxkm/5U+xQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235723; c=relaxed/simple;
	bh=2LMCnFagc3/S/uTR6COrLsXNubgLTq1UhtjQxfpTjNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T5hl4SWOWd8dmGI/Rje+BD+gEzpPiemMPhBxlw3LhEA27DsdLqSZ2CuXNT9dK185xeb1XuAD2KeYHOGoeJfFnNn0WJGELuBbtcl1dZ0u+w2wBjWN6pqUJYqOaALZJoajPLmj7NQTznKNRt+cEFgme2ZIYu81enfyRwcr+TZbm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxMdKS/9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxMdKS/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718235720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9pH2zPG8Vr2PNZCVlKQqJC3r20KYd9dC3U6iqsOmIU=;
	b=gxMdKS/9P96k9Hf1KhCN8SBHN+cO4gGAOm0s12ESRuAforEEJ1mUtqtK3OWCL4t0sGvSmA
	XGVGqiX6+cnpFYCpfqE+YM7Cg5EpsS6SdBdrZyts9WcorH61SOs/TWtnB0RNtkRezpvOF0
	jXOWdtX3wDRnB4DpQUIIQsa55JMl4SA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-mj0zEK_kNZuFXLdnGeXEIA-1; Wed, 12 Jun 2024 19:41:58 -0400
X-MC-Unique: mj0zEK_kNZuFXLdnGeXEIA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3605cad23e0so578471f8f.0
        for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 16:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235717; x=1718840517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9pH2zPG8Vr2PNZCVlKQqJC3r20KYd9dC3U6iqsOmIU=;
        b=Wnn0BCIdbLmik/FAFQ7UPqX9INgdqfIVNrqXT0gx7HeSNoCrtH/+cZ86GDDM/LNlC3
         8zjH9jY7LgcLya0W24W1jvZ/DUSRTTZxq/u4wiqvYQs2kU3wqj8nsnN2Q8TwkDuvI+0S
         sLewIQctbJdDsrUjH0+it/lUWl6KjX59cu1awcSLb/YgZIIhpg9rqVd6cc5pnUvScEdv
         TwvzfD4uTa5Mbrv5fbe8UZ3RORNDqE7NGLDg6p1EF0Jr3+YDsBA9VYxx5M9h6WJf8oDz
         9MzHbRSaCs/NxqLc0TVE1bdAgv7aJo0FibL5inpZU8lEg7O8rpb64fMQvPspMJINAuuh
         BwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz82twcJxa8ypsmFBVAuTby+hMjvNippD41LdIV0AJLvX0Fa7BFPDxDIQ26MVln1SVD0FmOBCI7LBqnXeuhskvvID9n6mgAzZO/aPzoBI=
X-Gm-Message-State: AOJu0YwIsfpKnANN3lapVQWSBAXJ29fbwhTHCydcfgjGoayi7PKLxuTe
	exBeZzaGMjJjQ7asJ1+HKyzmPk0pWe/WERHllBJl+8DcMhuq8Ra28Pibo0cG6J+WeMg2Ry7q0n2
	Dk7NcvQKWO8VpRjYBgWBFklGYzOxyDeK+XXkzV2+uk0wBep7C1VgKDzU+Km5OrtEr
X-Received: by 2002:adf:f647:0:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-360718f19b7mr686308f8f.35.1718235717161;
        Wed, 12 Jun 2024 16:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdpH9p4R25Q9HiTif7qjUXuqjJgSmu8vlRLbpWpYil17LYYYHX6iHquScBCA9dx7p6kB7+uA==
X-Received: by 2002:adf:f647:0:b0:35f:fd7:6102 with SMTP id ffacd0b85a97d-360718f19b7mr686303f8f.35.1718235716625;
        Wed, 12 Jun 2024 16:41:56 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d58sm118181f8f.4.2024.06.12.16.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 16:41:55 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:41:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 08/15] virtio_net: sq support premapped mode
Message-ID: <20240612193142-mutt-send-email-mst@kernel.org>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240611114147.31320-9-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 07:41:40PM +0800, Xuan Zhuo wrote:
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode when it is bound to
> af-xdp.
> 
> * virtnet_sq_set_premapped(sq, true) is used to enable premapped mode.
> 
>     In this mode, the driver will record the dma info when skb or xdp
>     frame is sent.
> 
>     Currently, the SQ premapped mode is operational only with af-xdp. In
>     this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
>     the same SQ. Af-xdp independently manages its DMA. The kernel stack
>     and xdp tx/redirect utilize this DMA metadata to manage the DMA
>     info.
> 
>     If the indirect descriptor feature be supported, the volume of DMA
>     details we need to maintain becomes quite substantial. Here, we have
>     a cap on the amount of DMA info we manage.
> 
>     If the kernel stack and xdp tx/redirect attempt to use more
>     descriptors, virtnet_add_outbuf() will return an -ENOMEM error. But
>     the af-xdp can work continually.
> 
> * virtnet_sq_set_premapped(sq, false) is used to disable premapped mode.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 219 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 215 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e84a4624549b..4968ab7eb5a4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -25,6 +25,7 @@
>  #include <net/net_failover.h>
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
> +#include <uapi/linux/virtio_ring.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -276,6 +277,25 @@ struct virtnet_rq_dma {
>  	u16 need_sync;
>  };
>  
> +struct virtnet_sq_dma {
> +	union {
> +		struct virtnet_sq_dma *next;

Maybe:

struct llist_node node;   

I'd like to avoid growing our own single linked list
implementation if at all possible.



> +		void *data;
> +	};
> +	dma_addr_t addr;
> +	u32 len;
> +	u8 num;
> +};
> +
> +struct virtnet_sq_dma_info {
> +	/* record for kfree */
> +	void *p;
> +
> +	u32 free_num;
> +
> +	struct virtnet_sq_dma *free;
> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>  	/* Virtqueue associated with this send _queue */
> @@ -295,6 +315,11 @@ struct send_queue {
>  
>  	/* Record whether sq is in reset state. */
>  	bool reset;
> +
> +	/* SQ is premapped mode or not. */
> +	bool premapped;
> +
> +	struct virtnet_sq_dma_info dmainfo;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -492,9 +517,11 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
>  	VIRTNET_XMIT_TYPE_XDP,
> +	VIRTNET_XMIT_TYPE_DMA,
>  };
>  
> -#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP \
> +				| VIRTNET_XMIT_TYPE_DMA)
>  
>  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>  {
> @@ -510,12 +537,178 @@ static void *virtnet_xmit_ptr_mix(void *ptr, enum virtnet_xmit_type type)
>  	return (void *)((unsigned long)ptr | type);
>  }
>  
> +static void virtnet_sq_unmap(struct send_queue *sq, void **data)
> +{
> +	struct virtnet_sq_dma *head, *tail, *p;
> +	int i;
> +
> +	head = *data;
> +
> +	p = head;
> +
> +	for (i = 0; i < head->num; ++i) {
> +		virtqueue_dma_unmap_page_attrs(sq->vq, p->addr, p->len,
> +					       DMA_TO_DEVICE, 0);
> +		tail = p;
> +		p = p->next;
> +	}
> +
> +	*data = tail->data;
> +
> +	tail->next = sq->dmainfo.free;
> +	sq->dmainfo.free = head;
> +	sq->dmainfo.free_num += head->num;
> +}
> +
> +static void *virtnet_dma_chain_update(struct send_queue *sq,
> +				      struct virtnet_sq_dma *head,
> +				      struct virtnet_sq_dma *tail,
> +				      u8 num, void *data)
> +{
> +	sq->dmainfo.free = tail->next;
> +	sq->dmainfo.free_num -= num;
> +	head->num = num;
> +
> +	tail->data = data;
> +
> +	return virtnet_xmit_ptr_mix(head, VIRTNET_XMIT_TYPE_DMA);
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, int num, void *data)
> +{
> +	struct virtnet_sq_dma *head, *tail, *p;
> +	struct scatterlist *sg;
> +	dma_addr_t addr;
> +	int i, err;
> +
> +	if (num > sq->dmainfo.free_num)
> +		return NULL;
> +
> +	head = sq->dmainfo.free;
> +	p = head;
> +
> +	tail = NULL;
> +
> +	for (i = 0; i < num; ++i) {
> +		sg = &sq->sg[i];
> +
> +		addr = virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg),
> +						    sg->offset,
> +						    sg->length, DMA_TO_DEVICE,
> +						    0);
> +		err = virtqueue_dma_mapping_error(sq->vq, addr);
> +		if (err)
> +			goto err;
> +
> +		sg->dma_address = addr;
> +
> +		tail = p;
> +		tail->addr = sg->dma_address;
> +		tail->len = sg->length;
> +
> +		p = p->next;
> +	}
> +
> +	return virtnet_dma_chain_update(sq, head, tail, num, data);
> +
> +err:
> +	if (tail) {
> +		virtnet_dma_chain_update(sq, head, tail, i, data);
> +		virtnet_sq_unmap(sq, (void **)&head);
> +	}
> +
> +	return NULL;
> +}
> +
>  static int virtnet_add_outbuf(struct send_queue *sq, int num, void *data,
>  			      enum virtnet_xmit_type type)
>  {
> -	return virtqueue_add_outbuf(sq->vq, sq->sg, num,
> -				    virtnet_xmit_ptr_mix(data, type),
> -				    GFP_ATOMIC);
> +	int ret;
> +
> +	data = virtnet_xmit_ptr_mix(data, type);
> +
> +	if (sq->premapped) {
> +		data = virtnet_sq_map_sg(sq, num, data);
> +		if (!data)
> +			return -ENOMEM;
> +	}
> +
> +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> +	if (ret && sq->premapped) {
> +		virtnet_xmit_ptr_strip(&data);
> +		virtnet_sq_unmap(sq, &data);
> +	}
> +
> +	return ret;
> +}
> +
> +static int virtnet_sq_alloc_dma_meta(struct send_queue *sq)
> +{
> +	struct virtnet_sq_dma *d;
> +	int num, i;
> +
> +	num = virtqueue_get_vring_size(sq->vq);
> +
> +	/* Currently, the SQ premapped mode is operational only with af-xdp. In
> +	 * this mode, af-xdp, the kernel stack, and xdp tx/redirect will share
> +	 * the same SQ. Af-xdp independently manages its DMA. The kernel stack
> +	 * and xdp tx/redirect utilize this DMA metadata to manage the DMA info.
> +	 *
> +	 * If the indirect descriptor feature be supported, the volume of DMA
> +	 * details we need to maintain becomes quite substantial. Here, we have
> +	 * a cap on the amount of DMA info we manage, effectively limiting it to
> +	 * twice the size of the ring buffer.
> +	 *
> +	 * If the kernel stack and xdp tx/redirect attempt to use more
> +	 * descriptors than allowed by this double ring buffer size,
> +	 * virtnet_add_outbuf() will return an -ENOMEM error. But the af-xdp can
> +	 * work continually.
> +	 */
> +	if (virtio_has_feature(sq->vq->vdev, VIRTIO_RING_F_INDIRECT_DESC))
> +		num = num * 2;
> +
> +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);

Can be large. kvmalloc seems more appropriate.


> +	if (!sq->dmainfo.free)
> +		return -ENOMEM;
> +
> +	sq->dmainfo.p = sq->dmainfo.free;
> +	sq->dmainfo.free_num = num;
> +
> +	for (i = 0; i < num; ++i) {
> +		d = &sq->dmainfo.free[i];
> +		d->next = d + 1;
> +	}
> +
> +	d->next = NULL;
> +
> +	return 0;
> +}
> +
> +static void virtnet_sq_free_dma_meta(struct send_queue *sq)
> +{
> +	kfree(sq->dmainfo.p);
> +
> +	sq->dmainfo.p = NULL;
> +	sq->dmainfo.free = NULL;
> +	sq->dmainfo.free_num = 0;
> +}
> +
> +/* This function must be called immediately after creating the vq, or after vq
> + * reset, and before adding any buffers to it.
> + */
> +static int virtnet_sq_set_premapped(struct send_queue *sq, bool premapped)
> +{
> +	if (premapped) {
> +		if (virtnet_sq_alloc_dma_meta(sq))
> +			return -ENOMEM;

I would just return what virtnet_sq_alloc_dma_meta returns.
	int r = virtnet_sq_alloc_dma_meta();

	if (r)
		return r;

> +	} else {
> +		virtnet_sq_free_dma_meta(sq);
> +	}
> +
> +	BUG_ON(virtqueue_set_dma_premapped(sq->vq, premapped));
> +
> +	sq->premapped = premapped;
> +	return 0;
>  }
>  
>  static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> @@ -529,6 +722,7 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		++stats->packets;
>  
> +retry:
>  		switch (virtnet_xmit_ptr_strip(&ptr)) {
>  		case VIRTNET_XMIT_TYPE_SKB:
>  			skb = ptr;
> @@ -545,6 +739,10 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  			stats->bytes += xdp_get_frame_len(frame);
>  			xdp_return_frame(frame);
>  			break;
> +
> +		case VIRTNET_XMIT_TYPE_DMA:
> +			virtnet_sq_unmap(sq, &ptr);
> +			goto retry;
>  		}
>  	}
>  }
> @@ -5232,6 +5430,8 @@ static void virtnet_free_queues(struct virtnet_info *vi)
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		__netif_napi_del(&vi->rq[i].napi);
>  		__netif_napi_del(&vi->sq[i].napi);
> +
> +		virtnet_sq_free_dma_meta(&vi->sq[i]);
>  	}
>  
>  	/* We called __netif_napi_del(),
> @@ -5280,6 +5480,13 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  {
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	struct send_queue *sq;
> +	int i = vq2rxq(vq);
> +
> +	sq = &vi->sq[i];
> +
> +retry:
>  	switch (virtnet_xmit_ptr_strip(&buf)) {
>  	case VIRTNET_XMIT_TYPE_SKB:
>  		dev_kfree_skb(buf);
> @@ -5288,6 +5495,10 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  	case VIRTNET_XMIT_TYPE_XDP:
>  		xdp_return_frame(buf);
>  		break;
> +
> +	case VIRTNET_XMIT_TYPE_DMA:
> +		virtnet_sq_unmap(sq, &buf);
> +		goto retry;

document what's going on here? why are we retrying?


>  	}
>  }
>  
> -- 
> 2.32.0.3.g01195cf9f

