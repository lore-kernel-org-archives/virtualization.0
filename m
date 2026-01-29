Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21313783D1
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769668219; cv=none; b=YeCpBRdBGbizDP8FjSUQIZ+oP/t/hqT59Tw7ruTK5GlheXsn2Lnw6uWQJImQ0LFvZr0NNhtERQW8K70rZhIIiFNah8lN6S40k62TKwypeI2JpwgkfIY/+48DgSeolO+5Q0jTyhSDYmF2yfPEvbV8cuJUnqAaQ4XNssXSjtNUJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769668219; c=relaxed/simple;
	bh=8QClyySW+wJVgknArgrur9ktWhv9cOQWP2hM9vwZEUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p+RaDLJA7Uf7AtgqiaNnM3AAteu8M2Ogqlq3SZ5F/jHTLO7mGABXuhapJTRyPwW4IhUrcsXMf2gePYsW4XH315zWdRT5LilWo4VqFvXBPlmSb56M/Z4/IWsaF2HirhfOFbZ2zLvae3jnzccAb3nd2qzbzayY2sUMWXrKlT5oXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzu0YFgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzu0YFgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769668216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYa8EZaTCN3bCG6/fsxPsqgYySk+lPWQCwt/l6kwY1g=;
	b=gzu0YFgShXS8B5V9wKHYhxngZWvlOebAkntsF189Iuz6VqFoZSJm999qHwZU4X9n6o96XT
	96NxTCMFvoN4bbh0niq8Gwc+gNf8lEkqgEVVUd6+BYPu7KjAvYj7k8YVHmBp0sBevSbFqD
	XWrkV4Nqhg3Xpx5AHYh+N6yXDCbODSM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-qAwoSAxkPjeaMRQWftjGTQ-1; Thu, 29 Jan 2026 01:30:13 -0500
X-MC-Unique: qAwoSAxkPjeaMRQWftjGTQ-1
X-Mimecast-MFC-AGG-ID: qAwoSAxkPjeaMRQWftjGTQ_1769668212
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so4615225e9.2
        for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 22:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769668212; x=1770273012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYa8EZaTCN3bCG6/fsxPsqgYySk+lPWQCwt/l6kwY1g=;
        b=uBhcXslj1+tcckFJD0tnS03K/3dlmuuFqpHAW9iUDRu9WKPVhE4eNo/1ywWZFF8uDD
         2OFFPziyV/Q4eM3FBkm0ScZt58Q1mn01w0nbc4SHTabuKBNk6AEruSPKiwx4car3t1Ui
         sQrmrzf6XygCCw7+U+C9hDcISBpKGie/GkG+0dtqI7HHTWnfwgvCzf9wQGaWF9uj/2QB
         KP5x6jMCRirJ4hzRq2PnBMiLDMTMYWKhZ0qQfiPJHuE9ZWGKNjnWnm2p3z22pVU39A8m
         4GEnZvsA7DoxhZ/IZc8x1SqLyQUjMeNx2ro3Fs6/pBpiOa+fc0bRnrVaIGJhwc92H0JT
         0NCw==
X-Forwarded-Encrypted: i=1; AJvYcCUQPaL/k6GdKC8ln0qNXiUUsZuU2TC/T/pcCCVrGPMh7Xj8O5u6Fd3YgVnLDoGgNWdgzoVazksgbuNORdTYtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHPvXP//oNf2Na8y+Wks917qY1tcgDv2SuQLMwQbrVVDZsdCfR
	z0YjVgMm9ellHge7Cn+tfHgoN0BDeLY7w/NtTvvgMhDnlEhxD19HOjvijVjeEnrzAY+D3E8ctX6
	atpyBsB+OrqXa4B7rNES/cHHYQaebjEjppJXHJcfbTAvfEuTNcwL4xF/P0MEz7S+vpl+h
X-Gm-Gg: AZuq6aJapEflSneB2imtGOJDp8a1UcyMk0KOTpWWJ5rrQR9UAmRXC2fGkJjRUb31CjW
	OhGiZBZ4nBg04W63MwpuKzGoWnk8Mncd6aBdkY7Olt3ZTYCE58CHePEew/glH1PHk+/qHpggicm
	DVSmb73tBVeoXIncEtycuauQzjm/DrEKrpZp2+On5S8NKXMt7NUMgjyZC2owFLN1e6bDOQy9Hcv
	0YSNr5szs28VsmbbvhnN43mPVWZwNH74TS6d9ngoxbEnY/kJ/omCFQeXtbEDDSuCu4Qd3X4n1/a
	kY8QviAkVYPEf350x4l1pJxjxjMcw9jJq3Dp43wJ1uXLmPk8GbWYgTF7nawRP7zBP9bbHcJh4s9
	1RPZrRJYdl6WLbL/4mO5q6s3kZpEXKBhWSA==
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-48069c16459mr88749065e9.5.1769668211909;
        Wed, 28 Jan 2026 22:30:11 -0800 (PST)
X-Received: by 2002:a05:600c:458a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-48069c16459mr88748675e9.5.1769668211366;
        Wed, 28 Jan 2026 22:30:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d3199csm2677665e9.3.2026.01.28.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:30:10 -0800 (PST)
Date: Thu, 29 Jan 2026 01:30:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/2] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260129012534-mutt-send-email-mst@kernel.org>
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128212031.1431746-2-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260128212031.1431746-2-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: imWgmk8reA833m0AmvFwFq05uPHfBhF6lr5oyI1Rxlk_1769668212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2026 at 01:20:30PM -0800, Vishwanath Seshagiri wrote:
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
> The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
> sending control virtqueue commands while ndo_close is tearing down
> device state, avoiding virtqueue corruption during concurrent operations.
> 
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  drivers/net/Kconfig      |   1 +
>  drivers/net/virtio_net.c | 353 ++++++++++++++++++++++-----------------
>  2 files changed, 203 insertions(+), 151 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index ac12eaf11755..f1e6b6b0a86f 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -450,6 +450,7 @@ config VIRTIO_NET
>  	depends on VIRTIO
>  	select NET_FAILOVER
>  	select DIMLIB
> +	select PAGE_POOL
>  	help
>  	  This is the virtual network driver for virtio.  It can be used with
>  	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..df2a5fc5187e 100644
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
> @@ -359,6 +360,11 @@ struct receive_queue {
>  	/* Page frag for packet buffer allocation. */
>  	struct page_frag alloc_frag;
>  
> +	struct page_pool *page_pool;
> +
> +	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
> +	bool use_page_pool_dma;
> +
>  	/* RX: fragments + linear part + virtio header */
>  	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>  
> @@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
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
>  
>  enum virtnet_xmit_type {
>  	VIRTNET_XMIT_TYPE_SKB,
> @@ -706,15 +714,21 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void virtnet_put_page(struct receive_queue *rq, struct page *page,
> +			     bool allow_direct)
> +{
> +	page_pool_put_page(rq->page_pool, page, -1, allow_direct);
> +}
> +
>  static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  				struct receive_queue *rq, void *buf)
>  {
>  	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>  	else if (vi->big_packets)
>  		give_pages(rq, buf);
>  	else
> -		put_page(virt_to_head_page(buf));
> +		virtnet_put_page(rq, virt_to_head_page(buf), false);
>  }


what I dislike here is how big_packets mode still pokes
at give_pages but other modes use the page pool.

Given all modes operate with struct page it's hard to
shake the feeling we could be trying to put a page
we did not get from the pool back into the pool,
or vice versa.



>  
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -877,9 +891,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  		if (unlikely(!skb))
>  			return NULL;
>  
> -		page = (struct page *)page->private;
> -		if (page)
> -			give_pages(rq, page);
>  		goto ok;
>  	}
>

For example above you did not touch give_pages, here
you are ripping out give_pages. Superficially, weird.


I ask myself whether page pool is not better than the
homegrown linked list that give_pages uses, anyway.

Will need some perf testing though.

-- 
MST

