Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB735C77B7E
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 06:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3743F83BEB;
	Sun, 28 May 2023 06:25:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3743F83BEB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yde5E0i+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAo9BWsRzyRK; Sun, 28 May 2023 06:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7184283C02;
	Sun, 28 May 2023 06:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7184283C02
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 383EAC0036;
	Sun, 28 May 2023 06:25:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F9F0C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B128402E6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:25:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B128402E6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yde5E0i+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSL8igwxgJOj
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:25:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38E50400D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38E50400D0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 06:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685255128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHipMSXfUIdhSOH+8qGLOxioNKl7RNvsZumZazeEfOg=;
 b=Yde5E0i+AZLcpf8okGjZ6nJA8bCQFxUMxuXr/yir8ByT8M1jharWyAxmlyZlS051t3mala
 p2fIVL5HXAM63DrMWtrbeQGGQ7DmyxvdROnPUnvy06l7/9ud27GkHKLAkndwpsCe/kQBiC
 eQiMtJH7QDNaDyJggAB0VBsh0/XYukY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-7zHwTCxgOA25M-CuSuAp_g-1; Sun, 28 May 2023 02:25:27 -0400
X-MC-Unique: 7zHwTCxgOA25M-CuSuAp_g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30940b01998so737530f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 May 2023 23:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685255126; x=1687847126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHipMSXfUIdhSOH+8qGLOxioNKl7RNvsZumZazeEfOg=;
 b=TjjV5PWR60mgtlmZ8wSLlKPiZwCjdwZXUnFAX/QtMTfxDRS+tucPjMr3N0wrc6GjyO
 KId0ZjWPHiUj9CKd3eShLM/qpWBsjy7Qlb63XkVi3TdHbkWwKD2Mssm7LWk9qUJlgHW5
 XrBzMVuABWoserebbUuYEPaIk+RBX8qBs9TCIpILmORn3qJTJVIFklYGyip7Rf+6dJ9M
 rE6FRIzf9Hb4h4/G5sNBZfJ2v1inv2GTydulSWfzMojPKiHHG8UgB2o9OaSmgH+HzUoA
 FSHUKGynnxVDETqb506oZK8JaaFzrJjpgaU3aR0xSrIV+ai/Ikmg8nSZXDeXkzJmEAG0
 QJ/w==
X-Gm-Message-State: AC+VfDyS9+tP35O7LMq8qnUVzWwDq/cqzyBJO2OWHqfBhpUcgvjPBHX4
 fLzX4KSAAP4c0jUA+YOMVDjgSXbfXzqoy8GiW3n9FMMLShyKVcUZ90RHkxB/+3hv99QACXC9fLf
 ftCBzkoGMUjnum17BpnZGIDoO6jWVO96oKRR6CgDm9w==
X-Received: by 2002:a5d:6690:0:b0:30a:e542:c5c9 with SMTP id
 l16-20020a5d6690000000b0030ae542c5c9mr3915875wru.24.1685255126197; 
 Sat, 27 May 2023 23:25:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zXf8FKRnuiMacq3JFo2VMQNt26z0deMI/xaaBhsgbJfThXFXDGW6PlXgF+aQ6SUOij8zjog==
X-Received: by 2002:a5d:6690:0:b0:30a:e542:c5c9 with SMTP id
 l16-20020a5d6690000000b0030ae542c5c9mr3915862wru.24.1685255125858; 
 Sat, 27 May 2023 23:25:25 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 u10-20020a5d514a000000b00307b5376b2csm9843188wrt.90.2023.05.27.23.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 23:25:25 -0700 (PDT)
Date: Sun, 28 May 2023 02:25:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liang Chen <liangchen.linux@gmail.com>
Subject: Re: [PATCH net-next 3/5] virtio_net: Add page pool fragmentation
 support
Message-ID: <20230528022057-mutt-send-email-mst@kernel.org>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-3-liangchen.linux@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230526054621.18371-3-liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Fri, May 26, 2023 at 01:46:19PM +0800, Liang Chen wrote:
> To further enhance performance, implement page pool fragmentation
> support and introduce a module parameter to enable or disable it.
> 
> In single-core vm testing environments, there is an additional performance
> gain observed in the normal path compared to the one packet per page
> approach.
>   Upstream codebase: 47.5 Gbits/sec
>   Upstream codebase with page pool: 50.2 Gbits/sec
>   Upstream codebase with page pool fragmentation support: 52.3 Gbits/sec
> 
> There is also some performance gain for XDP cpumap.
>   Upstream codebase: 1.38 Gbits/sec
>   Upstream codebase with page pool: 9.74 Gbits/sec
>   Upstream codebase with page pool fragmentation: 10.3 Gbits/sec
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

I think it's called fragmenting not fragmentation.


> ---
>  drivers/net/virtio_net.c | 72 ++++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 99c0ca0c1781..ac40b8c66c59 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -32,7 +32,9 @@ module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>  
>  static bool page_pool_enabled;
> +static bool page_pool_frag;
>  module_param(page_pool_enabled, bool, 0400);
> +module_param(page_pool_frag, bool, 0400);
>  
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)

So here again same questions.

-when is this a net perf gain when does it have no effect?
-can be on by default
- can we get rid of the extra modes?


> @@ -909,23 +911,32 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  				       struct page *p,
>  				       int offset,
>  				       int page_off,
> -				       unsigned int *len)
> +				       unsigned int *len,
> +					   unsigned int *pp_frag_offset)
>  {
>  	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  	struct page *page;
> +	unsigned int pp_frag_offset_val;
>  
>  	if (page_off + *len + tailroom > PAGE_SIZE)
>  		return NULL;
>  
>  	if (rq->page_pool)
> -		page = page_pool_dev_alloc_pages(rq->page_pool);
> +		if (rq->page_pool->p.flags & PP_FLAG_PAGE_FRAG)
> +			page = page_pool_dev_alloc_frag(rq->page_pool, pp_frag_offset,
> +							PAGE_SIZE);
> +		else
> +			page = page_pool_dev_alloc_pages(rq->page_pool);
>  	else
>  		page = alloc_page(GFP_ATOMIC);
>  
>  	if (!page)
>  		return NULL;
>  
> -	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
> +	pp_frag_offset_val = pp_frag_offset ? *pp_frag_offset : 0;
> +
> +	memcpy(page_address(page) + page_off + pp_frag_offset_val,
> +	       page_address(p) + offset, *len);
>  	page_off += *len;
>  
>  	while (--*num_buf) {
> @@ -948,7 +959,7 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>  			goto err_buf;
>  		}
>  
> -		memcpy(page_address(page) + page_off,
> +		memcpy(page_address(page) + page_off + pp_frag_offset_val,
>  		       page_address(p) + off, buflen);
>  		page_off += buflen;
>  		virtnet_put_page(rq, p);
> @@ -1029,7 +1040,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>  			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  		xdp_page = xdp_linearize_page(rq, &num_buf, page,
>  					      offset, header_offset,
> -					      &tlen);
> +					      &tlen, NULL);
>  		if (!xdp_page)
>  			goto err_xdp;
>  
> @@ -1323,6 +1334,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>  	struct page *xdp_page;
>  	unsigned int xdp_room;
> +	unsigned int page_frag_offset = 0;
>  
>  	/* Transient failure which in theory could occur if
>  	 * in-flight packets from before XDP was enabled reach
> @@ -1356,7 +1368,8 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  		xdp_page = xdp_linearize_page(rq, num_buf,
>  					      *page, offset,
>  					      VIRTIO_XDP_HEADROOM,
> -					      len);
> +					      len,
> +						  &page_frag_offset);
>  		if (!xdp_page)
>  			return NULL;
>  	} else {
> @@ -1366,14 +1379,19 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  			return NULL;
>  
>  		if (rq->page_pool)
> -			xdp_page = page_pool_dev_alloc_pages(rq->page_pool);
> +			if (rq->page_pool->p.flags & PP_FLAG_PAGE_FRAG)
> +				xdp_page = page_pool_dev_alloc_frag(rq->page_pool,
> +								    &page_frag_offset, PAGE_SIZE);
> +			else
> +				xdp_page = page_pool_dev_alloc_pages(rq->page_pool);
>  		else
>  			xdp_page = alloc_page(GFP_ATOMIC);
> +
>  		if (!xdp_page)
>  			return NULL;
>  
> -		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
> -		       page_address(*page) + offset, *len);
> +		memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM +
> +				page_frag_offset, page_address(*page) + offset, *len);
>  	}
>  
>  	*frame_sz = PAGE_SIZE;
> @@ -1382,7 +1400,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>  
>  	*page = xdp_page;
>  
> -	return page_address(*page) + VIRTIO_XDP_HEADROOM;
> +	return page_address(*page) + VIRTIO_XDP_HEADROOM + page_frag_offset;
>  }
>  
>  static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
> @@ -1762,6 +1780,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	void *ctx;
>  	int err;
>  	unsigned int len, hole;
> +	unsigned int pp_frag_offset;
>  
>  	/* Extra tailroom is needed to satisfy XDP's assumption. This
>  	 * means rx frags coalescing won't work, but consider we've
> @@ -1769,13 +1788,29 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  	if (rq->page_pool) {
> -		struct page *page;
> +		if (rq->page_pool->p.flags & PP_FLAG_PAGE_FRAG) {
> +			if (unlikely(!page_pool_dev_alloc_frag(rq->page_pool,
> +							       &pp_frag_offset, len + room)))
> +				return -ENOMEM;
> +			buf = (char *)page_address(rq->page_pool->frag_page) +
> +				pp_frag_offset;
> +			buf += headroom; /* advance address leaving hole at front of pkt */
> +			hole = (PAGE_SIZE << rq->page_pool->p.order)
> +				- rq->page_pool->frag_offset;
> +			if (hole < len + room) {
> +				if (!headroom)
> +					len += hole;
> +				rq->page_pool->frag_offset += hole;
> +			}
> +		} else {
> +			struct page *page;
>  
> -		page = page_pool_dev_alloc_pages(rq->page_pool);
> -		if (unlikely(!page))
> -			return -ENOMEM;
> -		buf = (char *)page_address(page);
> -		buf += headroom; /* advance address leaving hole at front of pkt */
> +			page = page_pool_dev_alloc_pages(rq->page_pool);
> +			if (unlikely(!page))
> +				return -ENOMEM;
> +			buf = (char *)page_address(page);
> +			buf += headroom; /* advance address leaving hole at front of pkt */
> +		}
>  	} else {
>  		if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
>  			return -ENOMEM;
> @@ -3800,13 +3835,16 @@ static void virtnet_alloc_page_pool(struct receive_queue *rq)
>  	struct virtio_device *vdev = rq->vq->vdev;
>  
>  	struct page_pool_params pp_params = {
> -		.order = 0,
> +		.order = page_pool_frag ? SKB_FRAG_PAGE_ORDER : 0,
>  		.pool_size = rq->vq->num_max,
>  		.nid = dev_to_node(vdev->dev.parent),
>  		.dev = vdev->dev.parent,
>  		.offset = 0,
>  	};
>  
> +	if (page_pool_frag)
> +		pp_params.flags |= PP_FLAG_PAGE_FRAG;
> +
>  	rq->page_pool = page_pool_create(&pp_params);
>  	if (IS_ERR(rq->page_pool)) {
>  		dev_warn(&vdev->dev, "page pool creation failed: %ld\n",
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
