Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54E3074AE
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712224; cv=none; b=apQO2Bluco7vXBzQuXqObEFP/e+MV+SB/U/uhLWluYpjItsTFu1IpdEMIXBrBBKqNQkIXo8uEYVMN/a+ADrqpygEGlOi40ZTjywuKUMMf7OXO7Ej3o6CygcRDvgezlz+Kla+lImVx5XDcyrpM2fz8lRR5QL9m7GXPXDY+58yFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712224; c=relaxed/simple;
	bh=Wx3AaFrtqOiu9PGQ7P0HchX8BTXIVrjnzqVITF2pMZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6WQPxYQuOQ3AKNyr///Ry+B6gobP2z/1dRPglcQYBlSOZX4yseSGNQI6AZ0ZAcer6QLh0clIueTsN5YOltWfcfDnpGLEOvEkBEcMOQAuZ5Ssj5lw8jzNdplHtjg5Ump5UsaD3hAx5I/HP4p7iX6nX3gSYy6SZKHe3pkqQ3wWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYH/qDC4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYH/qDC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772712221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCnysCynxr7A2J5nRy8ilWqWGBCIJ/AwT186rb+PFlE=;
	b=QYH/qDC4yEWJ4u7k5FbG5fxVyb9mjPFg3PG4HZ6V8r5P6Ec+ZfY8KEufqXDxAzwnB6AjfR
	Avg2m6FWfP/dojnk4IeSTcgYL3bFxOqpmWJgVUdBCxvUrsbu+rEkGvK0DXlyhMpCEhJB6m
	uSbv6aUbQWBLDw8GFyuoMDY+SXmjMMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-N-o8hp1tOs-B-C26RlkCrA-1; Thu, 05 Mar 2026 07:03:40 -0500
X-MC-Unique: N-o8hp1tOs-B-C26RlkCrA-1
X-Mimecast-MFC-AGG-ID: N-o8hp1tOs-B-C26RlkCrA_1772712219
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439ae28f5fcso3313370f8f.2
        for <virtualization@lists.linux.dev>; Thu, 05 Mar 2026 04:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772712219; x=1773317019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCnysCynxr7A2J5nRy8ilWqWGBCIJ/AwT186rb+PFlE=;
        b=PsHmzp8GjP5jSskGcSgLOcO1ndcTZUgMpmtke1znOjBeFcPcnQz0tUlpqZkaJz+4D2
         3gj8wqGHnlOvTKyKgZ/zWV2CgIj+PCLji460UDSPGE2UkJqGWXJAkhWUgRo9zXzPJ1Pj
         cRJCSVlkNG74sGBWmyvysY/u38/UQtDRYicKrBs5MQs3C0UGWOzEeRilwFgTAQrO8JvH
         un6eIOFYGbURSP8lOi+/iCmztrPBAfOh6aNm6QXwAswyY4SZfWDcMmb1JPHQ2xNrJ83E
         wugpLk2D7mNS0muRBI/DVg9pT75qhI8gHjo9z2EULRSLs0+35tGRxckP3U028beFR3lS
         UnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCTuHFvxYlfl3Cp1rmalC57fmSriCS48YaEudJCyH20g2WpJQVD28KWFBolux10JLNtf8mH3kbJ1OX4U9qVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCQsGgNN9HRvDFh7rxAJgqrRHGU03Fy4nK8vUkcmc2Vk8V7vwP
	JSjWouw2EQUw5LmBnVo0w/5Y/GP7oceWqkqKvZjbK6livw4Cx6uAweK0a9roHyadBvgTmqdPekd
	GGfK4RklhEdTbJ2oF6BEsCbotvrwrR1GRO5dtZL3YhouVOAjbucM+UwoosVA5ocjc+iVDbqtFI0
	eX
X-Gm-Gg: ATEYQzxQkuGqm42qon2JKzX9nreVCRWtNmmCn63PWPQjnOusjgnhXoOfudGttSRkjYZ
	O7yMZwK4037XGQjXMmxP+Jz9pDzt5TCy745SYWfoFRoadLHUxspaCj24PyzPW98Pjj0LkIucWfF
	bWSptXkfLSGpqbHyxZaicqCwwLRj3KaDCcz2xsW312TO4f36pP9+AaiVAZ2AJ3Yq9PIwrNC1CBB
	eVlZPMbA5LH9zod5xArwGFm0mBLYsfUhAvORBhIhmV1eM2RAkx7qdLIFZ8lyfKaLmYyZoEwCxzm
	u5cJr/nKh/R1bxziCXKQQe0HXg/afo/8laiN0A7PLY1lcoChb4DnFekyDQfE5flNoBddhBdboba
	O0ROi8ZiPVlO8oNFDLoRbhG7ssg==
X-Received: by 2002:a05:6000:2902:b0:435:e3bd:5838 with SMTP id ffacd0b85a97d-439c7f8f92emr10502688f8f.25.1772712218283;
        Thu, 05 Mar 2026 04:03:38 -0800 (PST)
X-Received: by 2002:a05:6000:2902:b0:435:e3bd:5838 with SMTP id ffacd0b85a97d-439c7f8f92emr10502605f8f.25.1772712217535;
        Thu, 05 Mar 2026 04:03:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c4489279sm19569460f8f.20.2026.03.05.04.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:03:36 -0800 (PST)
Message-ID: <dba095d1-6fb7-4a3c-b889-c721e66c7b0d@redhat.com>
Date: Thu, 5 Mar 2026 13:03:34 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10] virtio_net: add page_pool support for buffer
 allocation
To: Vishwanath Seshagiri <vishs@meta.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>,
 Matteo Croce <technoboy85@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260303074253.3449987-1-vishs@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260303074253.3449987-1-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LNcFCOKq3La-InSpLmfxFZo9EGz6FNBwdPKQxYUh72U_1772712219
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 8:42 AM, Vishwanath Seshagiri wrote:
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.
> 
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
> 
> Implement conditional DMA premapping using virtqueue_dma_dev():
> - When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
>   handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
> - When NULL (VDUSE, direct physical): page_pool handles allocation only,
>   submit via virtqueue_add_inbuf_ctx()
> 
> This preserves the DMA premapping optimization from commit 31f3cd4e5756b
> ("virtio-net: rq submits premapped per-buffer") while adding page_pool
> support as a prerequisite for future zero-copy features (devmem TCP,
> io_uring ZCRX).
> 
> Page pools are created in probe and destroyed in remove (not open/close),
> following existing driver behavior where RX buffers remain in virtqueues
> across interface state changes.
> 
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
> Changes in v10:
> - add_recvbuf_small: use alloc_len to avoid clobbering len (Michael S. Tsirkin)
> - v9:
>   https://lore.kernel.org/virtualization/20260302041005.1627210-1-vishs@meta.com/ 
> 
> Changes in v9:
> - Fix virtnet_skb_append_frag() for XSK callers (Michael S. Tsirkin)
> - v8:
>   https://lore.kernel.org/virtualization/e824c5a3-cfe0-4d11-958f-c3ec82d11d37@meta.com/  
> 
> Changes in v8:
> - Remove virtnet_no_page_pool() helper, replace with direct !rq->page_pool
>   checks or inlined conditions (Xuan Zhuo)
> - Extract virtnet_rq_submit() helper to consolidate DMA/non-DMA buffer
>   submission in add_recvbuf_small() and add_recvbuf_mergeable()
> - Add skb_mark_for_recycle(nskb) for overflow frag_list skbs in
>   virtnet_skb_append_frag() to ensure page_pool pages are returned to
>   the pool instead of freed via put_page()
> - Rebase on net-next (kzalloc_objs API)
> - v7:
>   https://lore.kernel.org/virtualization/20260210014305.3236342-1-vishs@meta.com/
> 
> Changes in v7:
> - Replace virtnet_put_page() helper with direct page_pool_put_page()
>   calls (Xuan Zhuo)
> - Add virtnet_no_page_pool() helper to consolidate big_packets mode check
>   (Michael S. Tsirkin)
> - Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() when
>   use_page_pool_dma is set (Michael S. Tsirkin)
> - Remove unused pp_params.dev assignment in non-DMA path
> - Add page pool recreation in virtnet_restore_up() for freeze/restore support (Chris Mason's
> Review Prompt)
> - v6:
>   https://lore.kernel.org/virtualization/20260208175410.1910001-1-vishs@meta.com/
> 
> Changes in v6:
> - Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
>   page_pool_alloc_netmem() already handles internal fragmentation internally
>   (Jakub Kicinski)
> - v5:
>   https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/
> 
> Benchmark results:
> 
> Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP
> 
> Small packets (64 bytes, mrg_rxbuf=off):
>   1Q:  853,493 -> 868,923 pps  (+1.8%)
>   2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
>   4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
>   8Q: 6,082,590 -> 6,156,894 pps (+1.2%)
> 
> Mergeable RX (64 bytes):
>   1Q:   766,168 ->   814,493 pps  (+6.3%)
>   2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
>   4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
>   8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)
> 
> Mergeable RX (1500 bytes):
>   1Q:   741,579 ->   785,442 pps  (+5.9%)
>   2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
>   4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
>   8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)
> 
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 466 ++++++++++++++++++++-------------------
>  2 files changed, 237 insertions(+), 230 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 17108c359216..b2fd90466bab 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -452,6 +452,7 @@ config VIRTIO_NET
>  	depends on VIRTIO
>  	select NET_FAILOVER
>  	select DIMLIB
> +	select PAGE_POOL
>  	help
>  	  This is the virtual network driver for virtio.  It can be used with
>  	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..d722031604bf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -26,6 +26,7 @@
>  #include <net/netdev_rx_queue.h>
>  #include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
> +#include <net/page_pool/helpers.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
>  	u32 max_usecs;
>  };
>  
> -/* The dma information of pages allocated at a time. */
> -struct virtnet_rq_dma {
> -	dma_addr_t addr;
> -	u32 ref;
> -	u16 len;
> -	u16 need_sync;
> -};
> -
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>  	/* Virtqueue associated with this send _queue */
> @@ -356,8 +349,10 @@ struct receive_queue {
>  	/* Average packet length for mergeable receive buffers. */
>  	struct ewma_pkt_len mrg_avg_pkt_len;
>  
> -	/* Page frag for packet buffer allocation. */
> -	struct page_frag alloc_frag;
> +	struct page_pool *page_pool;
> +
> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +	bool use_page_pool_dma;
>  
>  	/* RX: fragments + linear part + virtio header */
>  	struct scatterlist sg[MAX_SKB_FRAGS + 2];
> @@ -370,9 +365,6 @@ struct receive_queue {
>  
>  	struct xdp_rxq_info xdp_rxq;
>  
> -	/* Record the last dma info to free after new pages is allocated. */
> -	struct virtnet_rq_dma *last_dma;
> -
>  	struct xsk_buff_pool *xsk_pool;
>  
>  	/* xdp rxq used by xsk */
> @@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct virtnet_rq_stats *stats);
>  static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
>  				 struct sk_buff *skb, u8 flags);
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +					       struct sk_buff *head_skb,
>  					       struct sk_buff *curr_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize);
>  static void virtnet_xsk_completed(struct send_queue *sq, int num);
> +static void free_unused_bufs(struct virtnet_info *vi);
> +static void virtnet_del_vqs(struct virtnet_info *vi);
>  
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
> @@ -709,12 +704,10 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  				struct receive_queue *rq, void *buf)
>  {
> -	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> -	else if (vi->big_packets)
> +	if (!rq->page_pool)
>  		give_pages(rq, buf);
>  	else
> -		put_page(virt_to_head_page(buf));
> +		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
>  }
>  
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -876,10 +869,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		skb = virtnet_build_skb(buf, truesize, p - buf, len);
>  		if (unlikely(!skb))
>  			return NULL;
> +		/* Big packets mode chains pages via page->private, which is
> +		 * incompatible with the way page_pool uses page->private.
> +		 * Currently, big packets mode doesn't use page pools.
> +		 */
> +		if (!rq->page_pool) {
> +			page = (struct page *)page->private;
> +			if (page)
> +				give_pages(rq, page);
> +		}
>  
> -		page = (struct page *)page->private;
> -		if (page)
> -			give_pages(rq, page);
>  		goto ok;
>  	}
>  
> @@ -925,133 +924,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  	hdr = skb_vnet_common_hdr(skb);
>  	memcpy(hdr, hdr_p, hdr_len);
>  	if (page_to_free)
> -		put_page(page_to_free);
> +		page_pool_put_page(rq->page_pool, page_to_free, -1, true);
>  
>  	return skb;
>  }
>  
> -static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
> -{
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct page *page = virt_to_head_page(buf);
> -	struct virtnet_rq_dma *dma;
> -	void *head;
> -	int offset;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(page);
> -
> -	dma = head;
> -
> -	--dma->ref;
> -
> -	if (dma->need_sync && len) {
> -		offset = buf - (head + sizeof(*dma));
> -
> -		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
> -							offset, len,
> -							DMA_FROM_DEVICE);
> -	}
> -
> -	if (dma->ref)
> -		return;
> -
> -	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
> -				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> -	put_page(page);
> -}
> -
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  {
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	void *buf;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf)
> -		virtnet_rq_unmap(rq, buf, *len);
> -
> -	return buf;
> -}
> -
> -static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> -{
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct virtnet_rq_dma *dma;
> -	dma_addr_t addr;
> -	u32 offset;
> -	void *head;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(rq->alloc_frag.page);
> -
> -	offset = buf - head;
> -
> -	dma = head;
> -
> -	addr = dma->addr - sizeof(*dma) + offset;
> -
> -	sg_init_table(rq->sg, 1);
> -	sg_fill_dma(rq->sg, addr, len);
> -}
> -
> -static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> -{
> -	struct page_frag *alloc_frag = &rq->alloc_frag;
> -	struct virtnet_info *vi = rq->vq->vdev->priv;
> -	struct virtnet_rq_dma *dma;
> -	void *buf, *head;
> -	dma_addr_t addr;
> -
> -	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
> -
> -	head = page_address(alloc_frag->page);
> -
> -	dma = head;
> -
> -	/* new pages */
> -	if (!alloc_frag->offset) {
> -		if (rq->last_dma) {
> -			/* Now, the new page is allocated, the last dma
> -			 * will not be used. So the dma can be unmapped
> -			 * if the ref is 0.
> -			 */
> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> -			rq->last_dma = NULL;
> -		}
> -
> -		dma->len = alloc_frag->size - sizeof(*dma);
> -
> -		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
> -						  dma->len, DMA_FROM_DEVICE, 0);
> -		if (virtqueue_map_mapping_error(rq->vq, addr))
> -			return NULL;
> -
> -		dma->addr = addr;
> -		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
> -
> -		/* Add a reference to dma to prevent the entire dma from
> -		 * being released during error handling. This reference
> -		 * will be freed after the pages are no longer used.
> -		 */
> -		get_page(alloc_frag->page);
> -		dma->ref = 1;
> -		alloc_frag->offset = sizeof(*dma);
> -
> -		rq->last_dma = dma;
> -	}
> -
> -	++dma->ref;
> -
> -	buf = head + alloc_frag->offset;
> -
> -	get_page(alloc_frag->page);
> -	alloc_frag->offset += size;
> +	BUG_ON(!rq->page_pool);
>  
> -	return buf;
> +	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -1067,9 +949,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>  		return;
>  	}
>  
> -	if (!vi->big_packets || vi->mergeable_rx_bufs)
> -		virtnet_rq_unmap(rq, buf, 0);
> -
>  	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  
> @@ -1335,7 +1214,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  
>  		truesize = len;
>  
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>  						    buf, len, truesize);
>  		if (!curr_skb) {
>  			put_page(page);
> @@ -1771,7 +1650,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	return ret;
>  }
>  
> -static void put_xdp_frags(struct xdp_buff *xdp)
> +static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
>  {
>  	struct skb_shared_info *shinfo;
>  	struct page *xdp_page;
> @@ -1781,7 +1660,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
>  		shinfo = xdp_get_shared_info_from_buff(xdp);
>  		for (i = 0; i < shinfo->nr_frags; i++) {
>  			xdp_page = skb_frag_page(&shinfo->frags[i]);
> -			put_page(xdp_page);
> +			page_pool_put_page(rq->page_pool, xdp_page, -1, true);
>  		}
>  	}
>  }
> @@ -1873,7 +1752,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  	if (page_off + *len + tailroom > PAGE_SIZE)
>  		return NULL;
>  
> -	page = alloc_page(GFP_ATOMIC);
> +	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>  	if (!page)
>  		return NULL;
>  
> @@ -1896,8 +1775,12 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  		p = virt_to_head_page(buf);
>  		off = buf - page_address(p);
>  
> +		if (rq->use_page_pool_dma)
> +			page_pool_dma_sync_for_cpu(rq->page_pool, p,
> +						   off, buflen);
> +
>  		if (check_mergeable_len(dev, ctx, buflen)) {
> -			put_page(p);
> +			page_pool_put_page(rq->page_pool, p, -1, true);
>  			goto err_buf;
>  		}
>  
> @@ -1905,21 +1788,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
>  		 * is sending packet larger than the MTU.
>  		 */
>  		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
> -			put_page(p);
> +			page_pool_put_page(rq->page_pool, p, -1, true);
>  			goto err_buf;
>  		}
>  
>  		memcpy(page_address(page) + page_off,
>  		       page_address(p) + off, buflen);
>  		page_off += buflen;
> -		put_page(p);
> +		page_pool_put_page(rq->page_pool, p, -1, true);
>  	}
>  
>  	/* Headroom does not contribute to packet length */
>  	*len = page_off - XDP_PACKET_HEADROOM;
>  	return page;
>  err_buf:
> -	__free_pages(page, 0);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	return NULL;
>  }
>  
> @@ -1996,7 +1879,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  			goto err_xdp;
>  
>  		buf = page_address(xdp_page);
> -		put_page(page);
> +		page_pool_put_page(rq->page_pool, page, -1, true);
>  		page = xdp_page;
>  	}
>  
> @@ -2028,13 +1911,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>  
> +	skb_mark_for_recycle(skb);
> +
>  	return skb;
>  
>  err_xdp:
>  	u64_stats_inc(&stats->xdp_drops);
>  err:
>  	u64_stats_inc(&stats->drops);
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  xdp_xmit:
>  	return NULL;
>  }
> @@ -2056,6 +1941,13 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	 */
>  	buf -= VIRTNET_RX_PAD + xdp_headroom;
>  
> +	if (rq->use_page_pool_dma) {
> +		int offset = buf - page_address(page) +
> +			     VIRTNET_RX_PAD + xdp_headroom;
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +	}
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>  
> @@ -2082,12 +1974,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	}
>  
>  	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
> -	if (likely(skb))
> +	if (likely(skb)) {
> +		skb_mark_for_recycle(skb);
>  		return skb;
> +	}
>  
>  err:
>  	u64_stats_inc(&stats->drops);
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	return NULL;
>  }
>  
> @@ -2142,7 +2036,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
>  		}
>  		u64_stats_add(&stats->bytes, len);
>  		page = virt_to_head_page(buf);
> -		put_page(page);
> +		page_pool_put_page(rq->page_pool, page, -1, true);
>  	}
>  }
>  
> @@ -2252,8 +2146,12 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  		page = virt_to_head_page(buf);
>  		offset = buf - page_address(page);
>  
> +		if (rq->use_page_pool_dma)
> +			page_pool_dma_sync_for_cpu(rq->page_pool, page,
> +						   offset, len);
> +
>  		if (check_mergeable_len(dev, ctx, len)) {
> -			put_page(page);
> +			page_pool_put_page(rq->page_pool, page, -1, true);
>  			goto err;
>  		}
>  
> @@ -2272,7 +2170,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
>  	return 0;
>  
>  err:
> -	put_xdp_frags(xdp);
> +	put_xdp_frags(rq, xdp);
>  	return -EINVAL;
>  }
>  
> @@ -2337,7 +2235,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  		if (*len + xdp_room > PAGE_SIZE)
>  			return NULL;
>  
> -		xdp_page = alloc_page(GFP_ATOMIC);
> +		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
>  		if (!xdp_page)
>  			return NULL;
>  
> @@ -2347,7 +2245,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  
>  	*frame_sz = PAGE_SIZE;
>  
> -	put_page(*page);
> +	page_pool_put_page(rq->page_pool, *page, -1, true);
>  
>  	*page = xdp_page;
>  
> @@ -2393,6 +2291,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
>  		if (unlikely(!head_skb))
>  			break;
> +
> +		skb_mark_for_recycle(head_skb);
>  		return head_skb;
>  
>  	case XDP_TX:
> @@ -2403,10 +2303,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  		break;
>  	}
>  
> -	put_xdp_frags(&xdp);
> +	put_xdp_frags(rq, &xdp);
>  
>  err_xdp:
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	mergeable_buf_free(rq, num_buf, dev, stats);
>  
>  	u64_stats_inc(&stats->xdp_drops);
> @@ -2414,7 +2314,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
>  	return NULL;
>  }
>  
> -static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
> +static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
> +					       struct sk_buff *head_skb,
>  					       struct sk_buff *curr_skb,
>  					       struct page *page, void *buf,
>  					       int len, int truesize)
> @@ -2429,6 +2330,9 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  		if (unlikely(!nskb))
>  			return NULL;
>  
> +		if (head_skb->pp_recycle)
> +			skb_mark_for_recycle(nskb);
> +
>  		if (curr_skb == head_skb)
>  			skb_shinfo(curr_skb)->frag_list = nskb;
>  		else
> @@ -2446,7 +2350,10 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  
>  	offset = buf - page_address(page);
>  	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -		put_page(page);
> +		if (head_skb->pp_recycle)
> +			page_pool_put_page(rq->page_pool, page, -1, true);
> +		else
> +			put_page(page);
>  		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>  				     len, truesize);
>  	} else {
> @@ -2475,6 +2382,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>  
>  	head_skb = NULL;
> +
> +	if (rq->use_page_pool_dma)
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> +
>  	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>  
>  	if (check_mergeable_len(dev, ctx, len))
> @@ -2499,6 +2410,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  	if (unlikely(!curr_skb))
>  		goto err_skb;
> +
> +	skb_mark_for_recycle(head_skb);
>  	while (--num_buf) {
>  		buf = virtnet_rq_get_buf(rq, &len, &ctx);
>  		if (unlikely(!buf)) {
> @@ -2513,11 +2426,17 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		u64_stats_add(&stats->bytes, len);
>  		page = virt_to_head_page(buf);
>  
> +		if (rq->use_page_pool_dma) {
> +			offset = buf - page_address(page);
> +			page_pool_dma_sync_for_cpu(rq->page_pool, page,
> +						   offset, len);
> +		}
> +
>  		if (check_mergeable_len(dev, ctx, len))
>  			goto err_skb;
>  
>  		truesize = mergeable_ctx_to_truesize(ctx);
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> +		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
>  						    buf, len, truesize);
>  		if (!curr_skb)
>  			goto err_skb;
> @@ -2527,7 +2446,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	return head_skb;
>  
>  err_skb:
> -	put_page(page);
> +	page_pool_put_page(rq->page_pool, page, -1, true);
>  	mergeable_buf_free(rq, num_buf, dev, stats);
>  
>  err_buf:
> @@ -2658,6 +2577,24 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	virtnet_receive_done(vi, rq, skb, flags);
>  }
>  
> +static int virtnet_rq_submit(struct receive_queue *rq, char *buf,
> +			     int len, void *ctx, gfp_t gfp)
> +{
> +	if (rq->use_page_pool_dma) {
> +		struct page *page = virt_to_head_page(buf);
> +		dma_addr_t addr = page_pool_get_dma_addr(page) +
> +				  (buf - (char *)page_address(page));
> +
> +		sg_init_table(rq->sg, 1);
> +		sg_fill_dma(rq->sg, addr, len);
> +		return virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
> +						     buf, ctx, gfp);
> +	}
> +
> +	sg_init_one(rq->sg, buf, len);
> +	return virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> +}
> +
>  /* Unlike mergeable buffers, all buffers are allocated to the
>   * same size, except for the headroom. For this reason we do
>   * not need to use  mergeable_len_to_ctx here - it is enough
> @@ -2666,32 +2603,27 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  			     gfp_t gfp)
>  {
> -	char *buf;
>  	unsigned int xdp_headroom = virtnet_get_headroom(vi);
>  	void *ctx = (void *)(unsigned long)xdp_headroom;
> -	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
> +	unsigned int alloc_len;
> +	char *buf;
>  	int err;
>  
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> -		return -ENOMEM;
> -
> -	buf = virtnet_rq_alloc(rq, len, gfp);
> +	alloc_len = len;
> +	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;

As noted by Micheal in the previous revision the above will
skb->truesize under accounting. That is not safe and at least need a
solid explaination, which is still missing.

/P

