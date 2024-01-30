Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E727E783
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626705; cv=none; b=c7owU3BK9xo71PUeb6/8Gvx5Ut9UNqueDmtarzcs/AzgbrigjN0yap/PW3iUPZZKJDhsN7sD/4OhglzlObf5WG3spxZwIe6w3BeMpKxl4D4Oh+SZv2qEuYFJSQdDjgueTKiwDOcRQ/CBSJ6yW3yOc5RIzkQRgBD87mERumg0yZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626705; c=relaxed/simple;
	bh=u8obcy1IgfbkrMDCvicrV9kH2F2/xLok2g82VK77BsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RQFR5/s3LLTm/uDn/e+BM/ufjVGug7RY2jmKpT7eqoqqsOwWKdkK3MJRZF1ELS7Sejll7we/REBxsz5wv9rJt+5zOeLzDdjZ+KykylHZzlgyCiwHZixu2eAlzi+O7CKatm1u9xEPKHEEx3JboaOSw/uUewZNa21/Q7SCResH07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNhYDrtJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNhYDrtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706626702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XI6pMe0kUjVi8EnOOEz1gfLA1PE3+qLt1UlOFkwNfTw=;
	b=aNhYDrtJh3eAntXzxlD9JTUAWO1sl4O/bS2DhH1lqNvMgsSbNSExVUxuEEYL1RGG8F4rp6
	SRGsoixpSB8wnOXe79nYk0Bw8POcLOsDmsFzVcg1ECXR+3y1ceSe+9ECYClgqSN7UZl+rI
	8JwyDNjcm7Kxg2eDjc0WwtqGqGZ9hdM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-fA-ugRXYPt-IXSRzoJRRFQ-1; Tue, 30 Jan 2024 09:58:18 -0500
X-MC-Unique: fA-ugRXYPt-IXSRzoJRRFQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33aebf85ce9so1075244f8f.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 06:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626697; x=1707231497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI6pMe0kUjVi8EnOOEz1gfLA1PE3+qLt1UlOFkwNfTw=;
        b=P7PxZAPfDbh4qHe0CQpPiS8ToOtCtH9LgD+8Co7Af82Ad5eMTfKzN9QOrDaiAzZ3Pd
         D4fnjUf9QwZyEVnAKhmorQn1+ImEkd6SNhw3khk/ic5FPD88CZLuJUYbVANRHkeRD3Me
         QYhkCzqoyErgxWbG6yhHS3JEvCmNwft7PpvyF/xk3gjt6itdUY4MYov09xrN4LYgfDt8
         K70hEOWxbdslMAVP14U+PorYImVg4t/EI5kpjw9NGY5b0sYuARiDx6R0Od6bMXrxlG9L
         PxP8CUHzJTrRPEWBTavyuraGMb9qzvVp/IgcnBNOp6EK93XBNkjT3lDYX2Z+ckOgupqD
         lRPw==
X-Gm-Message-State: AOJu0YzrlbxfO3g2sYLcyD8qRTEf9dwC5z9cn+IOaYCr0RK3TW0uFioQ
	XHAfDfjvtj63UNIftBnlMneHKayIfjlIdkzQrLi20wpK1jSaBmnPekKU0VYvwP03ApvWgfwzOBt
	s47D2KrnQfRk+hvmbIj0/+4jloNTE1PUtqcvub6YDAo70wPMSmty1m1GhEPenIrz3
X-Received: by 2002:a5d:4f8c:0:b0:33a:f6ab:7854 with SMTP id d12-20020a5d4f8c000000b0033af6ab7854mr1942436wru.37.1706626697093;
        Tue, 30 Jan 2024 06:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgfMp95sZl9OlfaM0bE9bV05+rr8FjV4V/yXb7oosR5Khg5bNlBlOlfh7bID4ye6VyV6mm+g==
X-Received: by 2002:a5d:4f8c:0:b0:33a:f6ab:7854 with SMTP id d12-20020a5d4f8c000000b0033af6ab7854mr1942426wru.37.1706626696764;
        Tue, 30 Jan 2024 06:58:16 -0800 (PST)
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm11046946wrb.27.2024.01.30.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 06:58:16 -0800 (PST)
Date: Tue, 30 Jan 2024 09:58:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, abeni@redhat.com,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240130095645-mutt-send-email-mst@kernel.org>
References: <20240130142521.18593-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240130142521.18593-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> Add a tx queue stop and wake counters, they are useful for debugging.
> 
> 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> 	...
> 	tx_queue_1_tx_stop: 16726
> 	tx_queue_1_tx_wake: 16726
> 	...
> 	tx_queue_8_tx_stop: 1500110
> 	tx_queue_8_tx_wake: 1500110
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

Hmm isn't one always same as the other, except when queue is stopped?
And when it is stopped you can see that in the status?
So how is having two useful?


> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3cb8aa193884..7e3c31ceaf7e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
>  	u64_stats_t xdp_tx_drops;
>  	u64_stats_t kicks;
>  	u64_stats_t tx_timeouts;
> +	u64_stats_t tx_stop;
> +	u64_stats_t tx_wake;
>  };
>  
>  struct virtnet_rq_stats {
> @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
>  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
>  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
>  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
>  };
>  
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> @@ -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>  		netif_stop_subqueue(dev, qnum);
> +		u64_stats_update_begin(&sq->stats.syncp);
> +		u64_stats_inc(&sq->stats.tx_stop);
> +		u64_stats_update_end(&sq->stats.syncp);
>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -851,6 +858,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  			free_old_xmit_skbs(sq, false);
>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_subqueue(dev, qnum);
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.tx_wake);
> +				u64_stats_update_end(&sq->stats.syncp);
>  				virtqueue_disable_cb(sq->vq);
>  			}
>  		}
> @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  			free_old_xmit_skbs(sq, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
> -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +			if (netif_tx_queue_stopped(txq)) {
> +				u64_stats_update_begin(&sq->stats.syncp);
> +				u64_stats_inc(&sq->stats.tx_wake);
> +				u64_stats_update_end(&sq->stats.syncp);
> +			}
>  			netif_tx_wake_queue(txq);
> +		}
>  
>  		__netif_tx_unlock(txq);
>  	}
> @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	virtqueue_disable_cb(sq->vq);
>  	free_old_xmit_skbs(sq, true);
>  
> -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> +		if (netif_tx_queue_stopped(txq)) {
> +			u64_stats_update_begin(&sq->stats.syncp);
> +			u64_stats_inc(&sq->stats.tx_wake);
> +			u64_stats_update_end(&sq->stats.syncp);
> +		}
>  		netif_tx_wake_queue(txq);
> +	}
>  
>  	opaque = virtqueue_enable_cb_prepare(sq->vq);
>  
> -- 
> 2.42.0

