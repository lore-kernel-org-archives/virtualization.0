Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0032E13B
	for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465291; cv=none; b=QhZdCzYhhCQ0pnWJmuYzVMwwaCmzTfRa4LOE0VQbhAIFfxmYbss4ElmP/sImBwmmDb58x+zk7o+VIURgVmUCtWoqfE0vkDFaLTJuCvZr5rznk0nov2/HMKjzfiRoM5UJMjv75NjmwYO4yat/ITFYey+b634TK1PNm14JPu6mk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465291; c=relaxed/simple;
	bh=2Et3a03MmMsuReyTQfd81YhGJAVxbzDe7S1pZfy+5xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sv/kHPi+XAGwF93ebynZmzAky2PxaCCN7EuJrtnDn/U2BVxBuJzUONT/+pPfwsGDg6PoUpAnjOXEWv+VIdYM4sVFNRmLZwo16Jw7AFB46JbabLR41nRFnUS8pav1b6zGr+hBYIfwQgpdvV4cZyHzVpckloFACqEHQKGVYCgHeOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RiLTIf1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiLTIf1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768465288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNM3ZGdbidvhtLfoID9qrqWdq+WzdVBipCEx3bVHGAA=;
	b=RiLTIf1N/TekkB6c9r/hRIqgRWEsRpv769TEIU1ygr0xu60qD8xYA8DhnFzVo/XOA4XPgY
	Ek/QGiNphVJ5SXvLtIdlKJg92O1iQUO6DVuN4S5Urh17w9xkVSNfUrF93TUHWFTAiA1Suo
	heAElZx6m4ZZgRuZzArlEGCK2iAiK1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7j095cmgM2-IkQMECTLp_w-1; Thu, 15 Jan 2026 03:21:24 -0500
X-MC-Unique: 7j095cmgM2-IkQMECTLp_w-1
X-Mimecast-MFC-AGG-ID: 7j095cmgM2-IkQMECTLp_w_1768465284
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432586f2c82so457647f8f.0
        for <virtualization@lists.linux.dev>; Thu, 15 Jan 2026 00:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768465283; x=1769070083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNM3ZGdbidvhtLfoID9qrqWdq+WzdVBipCEx3bVHGAA=;
        b=FGt9KPbUvfY4CEXPNKfStjYtHvpqdXJDQRE23G075UOJwhL1+ruoNDTrFw4j7+RM/E
         aq7xcDdIcgOtdb4xUTUBQdI8RwLDLti1E/hMUu02mtDC76fsXAv+5ZxdoZ1aVMhdJhj5
         Kw9e6qI9VSqg1FXbyGcUA1BaY141glW592uCER+MM2U+B9bKUiN8JlNnBzA4jfaovgYq
         mT4AL8cGX2gEHT/PyGH8cfpX21udRDh8BhmzWfSgEMEyEsVXJTvm363P0gVwOyGZV6OI
         ykMqcVwFuqgyh5XIlFGdEBh5azsGkG+7XaH2Vyn67ntrb3IR20EBT74DQJR4H4925zrm
         XmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLsVJ0g1bT4eIKmtR33XFCOpVeYCTjgthZHNDc3RAT4K2GD1JQSxzvt8+QN/9kvchIOs9jMbSuOFKs7BZCsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzC+dczg+4SAy/E4e8FdyFvx0LC/Zzq0nzDpgYziMscHb6Ir8X0
	JssdL2dXr64ZgZKH5PCcOkX+b/gTt0yUWu6IIu6b8DtIuxDh2QNEk0iFEDE0Gl0WqC25ES/9SwW
	Gzks4+Ni/cUKLQ/LK6vL4bu+p9cqWjcNlC3eNb0dS4rJuXsdGbi01VazfKHUPcdWKDIfF
X-Gm-Gg: AY/fxX7Vsrxv1Z6RoGHR71b2uI3yKkJLIQRPIR2NTanRSvZGfNt9lTHyHtz5E7B2K8l
	Y0rY2UddpxlyfQIIFbA18k1smwAn39zBri1MqIpDLGVRARPzBmf4MkgfGdvchX8a+WwIYbSEtlc
	QZ3u3Yi6LPeMF2p7dIoL3020wMSl/1JOV/nutbPPUnRELakp4rWv0faK3BTS1Vyu1FCcixO853D
	PtWmRNp1mhV08tWD5Yus4gEKLqe/M+H57vcICj6OKdvaPgHncg9qOQ87tc8c6MZ/HDq7RRp4srB
	XSDy+iVNxY/F08kiCE29QiA6b7Vbw0MqbD86myp3RYyo+eY21r5YaFtxsL1PHyo5hCV1CWCvJh9
	XMcORvJNWd4ltSiTJ3jQqVShH8qPVuA==
X-Received: by 2002:a05:6000:1a8a:b0:431:cf0:2e8b with SMTP id ffacd0b85a97d-434d75bde70mr2770103f8f.29.1768465283388;
        Thu, 15 Jan 2026 00:21:23 -0800 (PST)
X-Received: by 2002:a05:6000:1a8a:b0:431:cf0:2e8b with SMTP id ffacd0b85a97d-434d75bde70mr2770068f8f.29.1768465282883;
        Thu, 15 Jan 2026 00:21:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b2988sm4184084f8f.28.2026.01.15.00.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:21:22 -0800 (PST)
Date: Thu, 15 Jan 2026 03:21:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, tanglongjun@kylinos.cn
Subject: Re: [PATCH v1] virtio_net: add traces for tx/rx and INT response
 events.
Message-ID: <20260115031728-mutt-send-email-mst@kernel.org>
References: <20260114123627.102579-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260114123627.102579-1-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zDpLOpnnGcsoAEOHfWZtGaYyxTa2LTik79L26NP26cc_1768465284
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 14, 2026 at 08:36:27PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> To facilitate tracking the status of virtqueue during rx/tx and
> interrupt response, add trace point at  corresponding func.
> 
> Also,to avoid perf hured,it olny available under debug condition.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
> v1：
> I did some tests with iperf3, as follow:
> host <---> vm
> 
> oringnal:
> rx pps: 90915  rx bitrate: 28.5 Gbits/s
> tx pps: 54659   tx bitrate: 26.4 Gbits/s
> 
> added trace:
> rx pps: 76810  rx bitrate: 26.7 Gbits/s
> tx pps: 54455   tx bitrate: 26.4 Gbits/s

probably because you are reading a lot of cache cold
data and copying it to stack just to discard it when
trace is disabled?

what if the tracepoints are much ligher weigh, just recording
the vq number?


> Based on the results of the above tests, adding tracing has a
> performance hurt, especially on the rx side. Therefore, these
> traces should only be added to the debug virtio_net.
> 
> When these traces are needed, uncomment the DEBUG macro definition
> in driver/net/virtio_net.c.
> ---
>  drivers/net/virtio_net.c       |  21 ++++-
>  drivers/net/virtio_net_trace.h | 124 ++++++++++++++++++++++++++
>  drivers/virtio/virtio_ring.c   | 155 --------------------------------
>  include/linux/virtio_ring.h    | 156 +++++++++++++++++++++++++++++++++
>  4 files changed, 297 insertions(+), 159 deletions(-)
>  create mode 100644 drivers/net/virtio_net_trace.h
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 22d894101c01..fabd3e8acb36 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -27,6 +27,11 @@
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
>  
> +#if defined(DEBUG)
> +#define CREATE_TRACE_POINTS
> +#include "virtio_net_trace.h"
> +#endif
> +
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
>  
> @@ -795,7 +800,9 @@ static void skb_xmit_done(struct virtqueue *vq)
>  	unsigned int index = vq2txq(vq);
>  	struct send_queue *sq = &vi->sq[index];
>  	struct napi_struct *napi = &sq->napi;
> -
> +#if defined(DEBUG)
> +	trace_skb_xmit_done(napi, vq);
> +#endif
>  	/* Suppress further interrupts. */
>  	virtqueue_disable_cb(vq);
>  
> @@ -2671,7 +2678,9 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  
>  	if (unlikely(!skb))
>  		return;
> -
> +#if defined(DEBUG)
> +	trace_receive_buf(rq->vq, skb);
> +#endif
>  	virtnet_receive_done(vi, rq, skb, flags);
>  }
>  
> @@ -2877,7 +2886,9 @@ static void skb_recv_done(struct virtqueue *rvq)
>  {
>  	struct virtnet_info *vi = rvq->vdev->priv;
>  	struct receive_queue *rq = &vi->rq[vq2rxq(rvq)];
> -
> +#if defined(DEBUG)
> +	trace_skb_recv_done(&rq->napi, rvq);
> +#endif
>  	rq->calls++;
>  	virtqueue_napi_schedule(&rq->napi, rvq);
>  }
> @@ -3389,7 +3400,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
> -
> +#if defined(DEBUG)
> +	trace_start_xmit(sq->vq, skb);

Pls prefix APIs with virtio_net or something.

> +#endif
>  	/* Try to transmit */
>  	err = xmit_skb(sq, skb, !use_napi);
>  

> diff --git a/drivers/net/virtio_net_trace.h b/drivers/net/virtio_net_trace.h
> new file mode 100644
> index 000000000000..0a008cb8f51d
> --- /dev/null
> +++ b/drivers/net/virtio_net_trace.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if defined(DEBUG)
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM virtio_net
> +
> +#if !defined(_TRACE_VIRTIO_NET_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_VIRTIO_NET_H
> +
> +#include <linux/virtio.h>
> +#include <linux/tracepoint.h>
> +#include <linux/virtio_ring.h>
> +
> +DECLARE_EVENT_CLASS(virtio_net_rxtx_temp,
> +
> +	TP_PROTO(struct virtqueue *vq, const struct sk_buff *skb),
> +
> +	TP_ARGS(vq, skb),
> +
> +	TP_STRUCT__entry(
> +		__string(	name,	vq->name	)
> +		__field(	unsigned int, num_free	)
> +		__field(	unsigned int, index	)
> +		__field(	bool, packed_ring	)
> +		__field(	bool, broken	)
> +		__field(	bool, event	)
> +		__field(	u16, last_used_idx	)
> +		__field(	__virtio16, avail_flags	)
> +		__field(	__virtio16, avail_idx	)
> +		__field(	__virtio16, used_idx	)
> +		__field(	const void *, skbaddr	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->skbaddr = skb;
> +
> +		__assign_str(name);
> +		__entry->num_free = vq->num_free;
> +		__entry->index = vq->index;
> +
> +		struct vring_virtqueue *vvq;
> +
> +		vvq = container_of_const(vq, struct vring_virtqueue, vq);
> +
> +		__entry->packed_ring = vvq->packed_ring;
> +		__entry->broken = vvq->broken;
> +		__entry->event = vvq->event;
> +		if (!vvq->packed_ring) {
> +			__entry->last_used_idx = vvq->last_used_idx;
> +			__entry->avail_flags = vvq->split.vring.avail->flags;
> +			__entry->avail_idx = vvq->split.vring.avail->idx;
> +			__entry->used_idx = vvq->split.vring.used->idx;
> +		}
> +	),
> +
> +	TP_printk("skbaddr=%p vq=%s num_free=%u index=%u packed=%d broken=%d event=%d last_used_idx=%u avail_flags=%u avail_idx=%u used_idx=%u",
> +		__entry->skbaddr, __get_str(name), __entry->num_free, __entry->index,
> +		__entry->packed_ring, __entry->broken, __entry->event, __entry->last_used_idx,
> +		__entry->avail_flags, __entry->avail_idx, __entry->used_idx)
> +)
> +
> +DEFINE_EVENT(virtio_net_rxtx_temp, receive_buf,
> +
> +	TP_PROTO(struct virtqueue *vq, const struct sk_buff *skb),
> +
> +	TP_ARGS(vq, skb)
> +);
> +
> +DEFINE_EVENT(virtio_net_rxtx_temp, start_xmit,
> +
> +	TP_PROTO(struct virtqueue *vq, const struct sk_buff *skb),
> +
> +	TP_ARGS(vq, skb)
> +);
> +
> +DECLARE_EVENT_CLASS(virtio_net_int_temp,
> +
> +	TP_PROTO(struct napi_struct *napi, struct virtqueue *vq),
> +
> +	TP_ARGS(napi, vq),
> +
> +	TP_STRUCT__entry(
> +		__string(	dev_name,	napi->dev->name	)
> +		__string(	vq_name,	vq->name)
> +		__field(	u32,	napi_id	)
> +		__field(	int,	weight	)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name);
> +		__assign_str(vq_name);
> +		__entry->napi_id = napi->napi_id;
> +		__entry->weight = napi->weight;
> +	),
> +
> +	TP_printk("dev=%s vq=%s napi_id=%u weight=%d",
> +		__get_str(dev_name), __get_str(vq_name), __entry->napi_id, __entry->weight)
> +)
> +
> +DEFINE_EVENT(virtio_net_int_temp, skb_xmit_done,
> +
> +	TP_PROTO(struct napi_struct *napi, struct virtqueue *vq),
> +
> +	TP_ARGS(napi, vq)
> +);
> +
> +DEFINE_EVENT(virtio_net_int_temp, skb_recv_done,
> +
> +	TP_PROTO(struct napi_struct *napi, struct virtqueue *vq),
> +
> +	TP_ARGS(napi, vq)
> +);
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH ../../drivers/net/
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE virtio_net_trace
> +
> +#endif /* _TRACE_VIRTIO_NET_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> +
> +#endif
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ddab68959671..d413ebb42729 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,161 +67,6 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif
>  
> -struct vring_desc_state_split {
> -	void *data;			/* Data for callback. */
> -
> -	/* Indirect desc table and extra table, if any. These two will be
> -	 * allocated together. So we won't stress more to the memory allocator.
> -	 */
> -	struct vring_desc *indir_desc;
> -};
> -
> -struct vring_desc_state_packed {
> -	void *data;			/* Data for callback. */
> -
> -	/* Indirect desc table and extra table, if any. These two will be
> -	 * allocated together. So we won't stress more to the memory allocator.
> -	 */
> -	struct vring_packed_desc *indir_desc;
> -	u16 num;			/* Descriptor list length. */
> -	u16 last;			/* The last desc state in a list. */
> -};
> -
> -struct vring_desc_extra {
> -	dma_addr_t addr;		/* Descriptor DMA addr. */
> -	u32 len;			/* Descriptor length. */
> -	u16 flags;			/* Descriptor flags. */
> -	u16 next;			/* The next desc state in a list. */
> -};
> -
> -struct vring_virtqueue_split {
> -	/* Actual memory layout for this queue. */
> -	struct vring vring;
> -
> -	/* Last written value to avail->flags */
> -	u16 avail_flags_shadow;
> -
> -	/*
> -	 * Last written value to avail->idx in
> -	 * guest byte order.
> -	 */
> -	u16 avail_idx_shadow;
> -
> -	/* Per-descriptor state. */
> -	struct vring_desc_state_split *desc_state;
> -	struct vring_desc_extra *desc_extra;
> -
> -	/* DMA address and size information */
> -	dma_addr_t queue_dma_addr;
> -	size_t queue_size_in_bytes;
> -
> -	/*
> -	 * The parameters for creating vrings are reserved for creating new
> -	 * vring.
> -	 */
> -	u32 vring_align;
> -	bool may_reduce_num;
> -};
> -
> -struct vring_virtqueue_packed {
> -	/* Actual memory layout for this queue. */
> -	struct {
> -		unsigned int num;
> -		struct vring_packed_desc *desc;
> -		struct vring_packed_desc_event *driver;
> -		struct vring_packed_desc_event *device;
> -	} vring;
> -
> -	/* Driver ring wrap counter. */
> -	bool avail_wrap_counter;
> -
> -	/* Avail used flags. */
> -	u16 avail_used_flags;
> -
> -	/* Index of the next avail descriptor. */
> -	u16 next_avail_idx;
> -
> -	/*
> -	 * Last written value to driver->flags in
> -	 * guest byte order.
> -	 */
> -	u16 event_flags_shadow;
> -
> -	/* Per-descriptor state. */
> -	struct vring_desc_state_packed *desc_state;
> -	struct vring_desc_extra *desc_extra;
> -
> -	/* DMA address and size information */
> -	dma_addr_t ring_dma_addr;
> -	dma_addr_t driver_event_dma_addr;
> -	dma_addr_t device_event_dma_addr;
> -	size_t ring_size_in_bytes;
> -	size_t event_size_in_bytes;
> -};
> -
> -struct vring_virtqueue {
> -	struct virtqueue vq;
> -
> -	/* Is this a packed ring? */
> -	bool packed_ring;
> -
> -	/* Is DMA API used? */
> -	bool use_map_api;
> -
> -	/* Can we use weak barriers? */
> -	bool weak_barriers;
> -
> -	/* Other side has made a mess, don't try any more. */
> -	bool broken;
> -
> -	/* Host supports indirect buffers */
> -	bool indirect;
> -
> -	/* Host publishes avail event idx */
> -	bool event;
> -
> -	/* Head of free buffer list. */
> -	unsigned int free_head;
> -	/* Number we've added since last sync. */
> -	unsigned int num_added;
> -
> -	/* Last used index  we've seen.
> -	 * for split ring, it just contains last used index
> -	 * for packed ring:
> -	 * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
> -	 * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.
> -	 */
> -	u16 last_used_idx;
> -
> -	/* Hint for event idx: already triggered no need to disable. */
> -	bool event_triggered;
> -
> -	union {
> -		/* Available for split ring */
> -		struct vring_virtqueue_split split;
> -
> -		/* Available for packed ring */
> -		struct vring_virtqueue_packed packed;
> -	};
> -
> -	/* How to notify other side. FIXME: commonalize hcalls! */
> -	bool (*notify)(struct virtqueue *vq);
> -
> -	/* DMA, allocation, and size information */
> -	bool we_own_ring;
> -
> -	union virtio_map map;
> -
> -#ifdef DEBUG
> -	/* They're supposed to lock for us. */
> -	unsigned int in_use;
> -
> -	/* Figure out if their kicks are too delayed. */
> -	bool last_add_time_valid;
> -	ktime_t last_add_time;
> -#endif
> -};
> -
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>  static void vring_free(struct virtqueue *_vq);
>  
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index c97a12c1cda3..1442a02209ec 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -121,4 +121,160 @@ void vring_transport_features(struct virtio_device *vdev);
>  irqreturn_t vring_interrupt(int irq, void *_vq);
>  
>  u32 vring_notification_data(struct virtqueue *_vq);
> +
> +struct vring_desc_state_split {
> +	void *data;			/* Data for callback. */
> +
> +	/* Indirect desc table and extra table, if any. These two will be
> +	 * allocated together. So we won't stress more to the memory allocator.
> +	 */
> +	struct vring_desc *indir_desc;
> +};
> +
> +struct vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +
> +	/* Indirect desc table and extra table, if any. These two will be
> +	 * allocated together. So we won't stress more to the memory allocator.
> +	 */
> +	struct vring_packed_desc *indir_desc;
> +	u16 num;			/* Descriptor list length. */
> +	u16 last;			/* The last desc state in a list. */
> +};
> +
> +struct vring_desc_extra {
> +	dma_addr_t addr;		/* Descriptor DMA addr. */
> +	u32 len;			/* Descriptor length. */
> +	u16 flags;			/* Descriptor flags. */
> +	u16 next;			/* The next desc state in a list. */
> +};
> +
> +struct vring_virtqueue_split {
> +	/* Actual memory layout for this queue. */
> +	struct vring vring;
> +
> +	/* Last written value to avail->flags */
> +	u16 avail_flags_shadow;
> +
> +	/*
> +	 * Last written value to avail->idx in
> +	 * guest byte order.
> +	 */
> +	u16 avail_idx_shadow;
> +
> +	/* Per-descriptor state. */
> +	struct vring_desc_state_split *desc_state;
> +	struct vring_desc_extra *desc_extra;
> +
> +	/* DMA address and size information */
> +	dma_addr_t queue_dma_addr;
> +	size_t queue_size_in_bytes;
> +
> +	/*
> +	 * The parameters for creating vrings are reserved for creating new
> +	 * vring.
> +	 */
> +	u32 vring_align;
> +	bool may_reduce_num;
> +};
> +
> +struct vring_virtqueue_packed {
> +	/* Actual memory layout for this queue. */
> +	struct {
> +		unsigned int num;
> +		struct vring_packed_desc *desc;
> +		struct vring_packed_desc_event *driver;
> +		struct vring_packed_desc_event *device;
> +	} vring;
> +
> +	/* Driver ring wrap counter. */
> +	bool avail_wrap_counter;
> +
> +	/* Avail used flags. */
> +	u16 avail_used_flags;
> +
> +	/* Index of the next avail descriptor. */
> +	u16 next_avail_idx;
> +
> +	/*
> +	 * Last written value to driver->flags in
> +	 * guest byte order.
> +	 */
> +	u16 event_flags_shadow;
> +
> +	/* Per-descriptor state. */
> +	struct vring_desc_state_packed *desc_state;
> +	struct vring_desc_extra *desc_extra;
> +
> +	/* DMA address and size information */
> +	dma_addr_t ring_dma_addr;
> +	dma_addr_t driver_event_dma_addr;
> +	dma_addr_t device_event_dma_addr;
> +	size_t ring_size_in_bytes;
> +	size_t event_size_in_bytes;
> +};
> +
> +struct vring_virtqueue {
> +	struct virtqueue vq;
> +
> +	/* Is this a packed ring? */
> +	bool packed_ring;
> +
> +	/* Is DMA API used? */
> +	bool use_map_api;
> +
> +	/* Can we use weak barriers? */
> +	bool weak_barriers;
> +
> +	/* Other side has made a mess, don't try any more. */
> +	bool broken;
> +
> +	/* Host supports indirect buffers */
> +	bool indirect;
> +
> +	/* Host publishes avail event idx */
> +	bool event;
> +
> +	/* Head of free buffer list. */
> +	unsigned int free_head;
> +	/* Number we've added since last sync. */
> +	unsigned int num_added;
> +
> +	/* Last used index  we've seen.
> +	 * for split ring, it just contains last used index
> +	 * for packed ring:
> +	 * bits up to VRING_PACKED_EVENT_F_WRAP_CTR include the last used index.
> +	 * bits from VRING_PACKED_EVENT_F_WRAP_CTR include the used wrap counter.
> +	 */
> +	u16 last_used_idx;
> +
> +	/* Hint for event idx: already triggered no need to disable. */
> +	bool event_triggered;
> +
> +	union {
> +		/* Available for split ring */
> +		struct vring_virtqueue_split split;
> +
> +		/* Available for packed ring */
> +		struct vring_virtqueue_packed packed;
> +	};
> +
> +	/* How to notify other side. FIXME: commonalize hcalls! */
> +	bool (*notify)(struct virtqueue *vq);
> +
> +	/* DMA, allocation, and size information */
> +	bool we_own_ring;
> +
> +	union virtio_map map;
> +
> +#ifdef DEBUG
> +	/* They're supposed to lock for us. */
> +	unsigned int in_use;
> +
> +	/* Figure out if their kicks are too delayed. */
> +	bool last_add_time_valid;
> +	ktime_t last_add_time;
> +#endif
> +};
> +

Not excited about exporting all this stuff from virtio-ring
internals.


>  #endif /* _LINUX_VIRTIO_RING_H */
> -- 
> 2.48.1

