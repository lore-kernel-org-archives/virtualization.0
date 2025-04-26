Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290478F2D
	for <virtualization@lists.linux.dev>; Sat, 26 Apr 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745656398; cv=none; b=vAfv4jZJNT5qOXUN2WzIu+U5TWEfjDhtMWyrTTYnd8l0FF6SOOe6YeYf4aw4ikE2ZadD22RlrPQWrTVRMbovbF8bCcO7JIPmP1o/cHZq0VAjKopssOTqudxxOIKIb6PqzdLsKadMcWMqqffp2m2k3q0xv5YS0xwiFBLw7HQoHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745656398; c=relaxed/simple;
	bh=cq/kgfvwWTD+KOCGbdVDLUFl6oNg/Ou2BRx0e32C2q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXVqvNlDHqZDBAxejrz5rui+UYfVaCBuUO43/bgmDVVGkoePQWS+z1HpoIAkRLwqQaCvftweV9lijWVBdDY4i/Ab9nSugNV4Pf7BB41ZGGpH/j/gjIqV2nBAzftXB7gQzpxT4E3uaTJJkxbWgpRkrr+ArHVSXiJrsywYiSDQQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8K0jyGG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8K0jyGG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739be717eddso2439139b3a.2
        for <virtualization@lists.linux.dev>; Sat, 26 Apr 2025 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745656396; x=1746261196; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7xDbNUtc3GNk6oeUFqhP9sjyvenI2ax5rh3mY81Ris=;
        b=Q8K0jyGGfjNnYZXqgVHsWu68QA7Ci/Z0thWI/3jatuIwnHdhmTD1nuNlWRlDWIzj4S
         AKh+4nxyI0h23L44b1bAj2T2b3wDnb59OAI++v2kwmb7auiViiW48EqdYTYzI5wXfGuo
         mrUYHOn/7E7Fl5qRbS7Sge1Jpcwc9NL9uaW5ptAdyZ/8edoBAV4UamQENx8SUl1cUFEJ
         lFCwE4cgLC+Zjv5guRgGz+IWr8rD0ZeBJTK07NGoStFqchAEbswKMTvyDhant8B7MRh0
         CyN11uZZRdq3gKPPSstFuDPqYB1ptnkiXwD15PL4+EQB5LEgvNia3ohPjTmzbFzOooO1
         Y8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745656396; x=1746261196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7xDbNUtc3GNk6oeUFqhP9sjyvenI2ax5rh3mY81Ris=;
        b=LeDXkwB90fZxEjiRyp0BLPVGFsCplk13a08ugLYe+CzgaaFibFDVT4oswWEYeA7L0K
         Xl8pSCR2BGKeMF09piQGgakDS6hdpUf326Z+BTQG2v2A16scJNXK5g+s+Okj78ugHH6w
         gCdDUBm8MFgUrlZb1Z8OF0amT6Eb7EkkrWWH/GztGl6iUyXNK9FGJvDCEPuXDkeXoZZu
         91IPqqev9qL+5RAnPV92BpuwFfKVqZHEYYMJ8HawVf5JnM9fRZMmpQC46Vhz5A1KXwAg
         pxYYd430WWE5dnd8zH9+ROY/Ud0owpfcv+IKymL6Cs8uI0hnUKi+Us/0zLFuksjEGbcB
         yXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2H9IGDuUPDofLUfb/TsFM5+rk3f+dd7LIvCmFYz4pghbQm0aFnSLqdO8KpRIgqGFk8xaormbXqCMR1gzgcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2h3oc9DJqiEZwRiafqYYzBra3AYWnSohGtoYpATqydnSGy2af
	jHm1UM4w4oyHB2EPPLDTqITlrtJgtWKGrlikO3WTRRgLWPV3Ys17
X-Gm-Gg: ASbGncv8GEJjnQXHswVxx7a8bMvuoaggMEPLjePT0vpLzKR2FMGStVKKOs/4jDBukFn
	MEiStjNJlt0grJ7ug2njwl0tRUBwVrxF4ZTA/K1xPqr4djtU2SPw1FLo+4tBzh98jgELlyzZpVG
	0GVHY8qrK/YPih08nsYPGYiZtMH3VhEoxnl1YaTxbwEj2E/0ILJTuKFBFIJWHMvdwBoo1g/Q8r1
	jZRjFq1XHl2CAbJogo7xJS6xFlNezzNZNWYBsIwM22sK6o8qoQw3jcomGjPJyR460yidZteS2wP
	w/uqqSwRpSdSxryqZqxCLdlQ6eqSJO8EEQClbOcUufl8kuh5/71ekZNAf6k9VuDIzADT4acZivL
	PQIo8X8x5IAmDoEdkZjE8avgK68FdOw==
X-Google-Smtp-Source: AGHT+IFFzdieNjceqUWjKCn57tE0HAT55Xq8uc8EhTbvjF77l7dXFwaf0Cd4FmYWkJbLx3Eoywyfvg==
X-Received: by 2002:a05:6a00:4606:b0:736:5dae:6b0d with SMTP id d2e1a72fcca58-73fd72c7c31mr7101427b3a.10.1745656395842;
        Sat, 26 Apr 2025 01:33:15 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:52b1:1f45:145e:af27? ([2001:ee0:4f0e:fb30:52b1:1f45:145e:af27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25912ad3sm4546267b3a.13.2025.04.26.01.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 01:33:15 -0700 (PDT)
Message-ID: <6b918a27-4c87-4c8c-bb31-7a5cca15844f@gmail.com>
Date: Sat, 26 Apr 2025 15:33:07 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] virtio-net: support zerocopy multi buffer
 XDP in mergeable
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250426082752.43222-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250426082752.43222-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 15:27, Bui Quang Minh wrote:
> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
> does not support multi buffer but a single buffer only. This commit adds
> support for multi mergeable receive buffer in the zerocopy XDP path by
> utilizing XDP buffer with frags.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>   drivers/net/virtio_net.c | 107 +++++++++++++++++++--------------------
>   1 file changed, 51 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..8d21767dd607 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>   #define VIRTIO_XDP_TX		BIT(0)
>   #define VIRTIO_XDP_REDIR	BIT(1)
>   
> +#define VIRTNET_MAX_ZC_SEGS	8
> +
>   /* RX packet size EWMA. The average packet size is used to determine the packet
>    * buffer size when refilling RX rings. As the entire RX ring may be refilled
>    * at once, the weight is chosen so that the EWMA will be insensitive to short-
> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct net_device *dev,
>   	}
>   }
>   
> -static int xsk_append_merge_buffer(struct virtnet_info *vi,
> -				   struct receive_queue *rq,
> -				   struct sk_buff *head_skb,
> -				   u32 num_buf,
> -				   struct virtio_net_hdr_mrg_rxbuf *hdr,
> -				   struct virtnet_rq_stats *stats)
> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
> +				      struct receive_queue *rq,
> +				      u32 num_buf,
> +				      struct xdp_buff *xdp,
> +				      struct virtnet_rq_stats *stats)
>   {
> -	struct sk_buff *curr_skb;
> -	struct xdp_buff *xdp;
> -	u32 len, truesize;
> -	struct page *page;
> +	unsigned int len;
>   	void *buf;
>   
> -	curr_skb = head_skb;
> +	if (num_buf < 2)
> +		return 0;
> +
> +	while (num_buf > 1) {
> +		struct xdp_buff *new_xdp;
>   
> -	while (--num_buf) {
>   		buf = virtqueue_get_buf(rq->vq, &len);
> -		if (unlikely(!buf)) {
> -			pr_debug("%s: rx error: %d buffers out of %d missing\n",
> -				 vi->dev->name, num_buf,
> -				 virtio16_to_cpu(vi->vdev,
> -						 hdr->num_buffers));
> +		if (!unlikely(buf)) {
> +			pr_debug("%s: rx error: %d buffers missing\n",
> +				 vi->dev->name, num_buf);
>   			DEV_STATS_INC(vi->dev, rx_length_errors);
> -			return -EINVAL;
> -		}
> -
> -		u64_stats_add(&stats->bytes, len);
> -
> -		xdp = buf_to_xdp(vi, rq, buf, len);
> -		if (!xdp)
> -			goto err;
> -
> -		buf = napi_alloc_frag(len);
> -		if (!buf) {
> -			xsk_buff_free(xdp);
> -			goto err;
> +			return -1;
>   		}
>   
> -		memcpy(buf, xdp->data - vi->hdr_len, len);
> -
> -		xsk_buff_free(xdp);
> +		new_xdp = buf_to_xdp(vi, rq, buf, len);
> +		if (!new_xdp)
> +			goto drop_bufs;
>   
> -		page = virt_to_page(buf);
> +		/* In virtnet_add_recvbuf_xsk(), we ask the host to fill from
> +		 * xdp->data - vi->hdr_len with both virtio_net_hdr and data.
> +		 * However, only the first packet has the virtio_net_hdr, the
> +		 * following ones do not. So we need to adjust the following
> +		 * packets' data pointer to the correct place.
> +		 */
> +		new_xdp->data -= vi->hdr_len;
> +		new_xdp->data_end = new_xdp->data + len;
>   
> -		truesize = len;
> +		if (!xsk_buff_add_frag(xdp, new_xdp))
> +			goto drop_bufs;
>   
> -		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
> -						    buf, len, truesize);
> -		if (!curr_skb) {
> -			put_page(page);
> -			goto err;
> -		}
> +		num_buf--;
>   	}
>   
>   	return 0;
>   
> -err:
> +drop_bufs:
>   	xsk_drop_follow_bufs(vi->dev, rq, num_buf, stats);
> -	return -EINVAL;
> +	return -1;
>   }
>   
>   static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct virtnet_info *vi,
> @@ -1307,23 +1297,28 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>   	num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>   
>   	ret = XDP_PASS;
> +	if (virtnet_build_xsk_buff_mrg(vi, rq, num_buf, xdp, stats))
> +		goto drop;
> +
>   	rcu_read_lock();
>   	prog = rcu_dereference(rq->xdp_prog);
> -	/* TODO: support multi buffer. */
> -	if (prog && num_buf == 1)
> +	if (prog)
>   		ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>   	rcu_read_unlock();
>   
>   	switch (ret) {
>   	case XDP_PASS:
> -		skb = xsk_construct_skb(rq, xdp);
> +		skb = xdp_build_skb_from_zc(xdp);

This function has a bug which needs this fix commit to be applied to 
work correctly: 
https://lore.kernel.org/netdev/20250426081220.40689-2-minhquangbui99@gmail.com/

>   		if (!skb)
> -			goto drop_bufs;
> +			break;
>   
> -		if (xsk_append_merge_buffer(vi, rq, skb, num_buf, hdr, stats)) {
> -			dev_kfree_skb(skb);
> -			goto drop;
> -		}
> +		/* Later, in virtnet_receive_done(), eth_type_trans()
> +		 * is called. However, in xdp_build_skb_from_zc(), it is called
> +		 * already. As a result, we need to reset the data to before
> +		 * the mac header so that the later call in
> +		 * virtnet_receive_done() works correctly.
> +		 */
> +		skb_push(skb, ETH_HLEN);
>   
>   		return skb;
>   
> @@ -1332,14 +1327,11 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>   		return NULL;
>   
>   	default:
> -		/* drop packet */
> -		xsk_buff_free(xdp);
> +		break;
>   	}
>   
> -drop_bufs:
> -	xsk_drop_follow_bufs(dev, rq, num_buf, stats);
> -
>   drop:
> +	xsk_buff_free(xdp);
>   	u64_stats_inc(&stats->drops);
>   	return NULL;
>   }
> @@ -1396,6 +1388,8 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   		return -ENOMEM;
>   
>   	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +	/* Reserve some space for skb_shared_info */
> +	len -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>   
>   	for (i = 0; i < num; ++i) {
>   		/* Use the part of XDP_PACKET_HEADROOM as the virtnet hdr space.
> @@ -6721,6 +6715,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   	dev->netdev_ops = &virtnet_netdev;
>   	dev->stat_ops = &virtnet_stat_ops;
>   	dev->features = NETIF_F_HIGHDMA;
> +	dev->xdp_zc_max_segs = VIRTNET_MAX_ZC_SEGS;
>   
>   	dev->ethtool_ops = &virtnet_ethtool_ops;
>   	SET_NETDEV_DEV(dev, &vdev->dev);

