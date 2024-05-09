Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCE1FAA
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258512; cv=none; b=HeKz6+Su6foYPuZOr8iJ9RXCFSNdK9WSSHG/9V6pLNfzkpJ+4/jw9wrKZaxUAs0I5ni0XHVKdiFReuuXoR91GA4YkXZGRG35Tb17iRrd42eqIb2H4777LNviR5OKm+TS/IQOTr/UKnFEQOEKamYPC1bDEb628VZP8hekIQA6mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258512; c=relaxed/simple;
	bh=yYnC64/R3DZoHBW8VtZmqF7HJ1qy3/+tOdqzTPKbFos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GI3zWAvFWwCewTW4r1iKSGOzfNKpvCVKCKic6k0U2HepKZS61fSeHxs0AMaAFZD2OzYyZoikHfS15Chs4KelfA3qvTjPdYRJWykU6Z//t03PyncAURGR2h9f7UIE5XnJyR/oP3SR6LF/ILrZdDMKtSKmUWf9GTwlTNhNQvI+YIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdVXuhY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdVXuhY0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715258509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XopvFSbunVoFlBumBDtvQMYEcEnxHvNmIEMvjUpJMzg=;
	b=hdVXuhY03rzkohQx0kXzLdFFh8upKRDs+3VHKdiEx2/RWSwgEKsV8kp1lwgBcDrjpa2wAW
	7cLcLBxAnDM53gPiB2tsocCaJjGmgrwmNnxeo+K6bmXYl1LWLccO/G0EFR4N/YlLD4grV7
	lollSa7zBf4bssUxHS9ZRNnryHs/duM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-I9hscQM7Oe2g87__IJFv1w-1; Thu, 09 May 2024 08:41:47 -0400
X-MC-Unique: I9hscQM7Oe2g87__IJFv1w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41fd7deabf8so2041875e9.3
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 05:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715258506; x=1715863306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XopvFSbunVoFlBumBDtvQMYEcEnxHvNmIEMvjUpJMzg=;
        b=xROGI4xh34A6BN7Mp1lgWvH+xNjDfYAqNz1seEMdeWxfjRueQguYY4FpyUuxcCfgag
         dGcoZo6muWvNCqpEygCATURAbVvX7RJrBh3CwNlHYHL1KJRdG99w/sahnGapogQhD87C
         lU/x/r590FulC5it/g4L29DICYCH6xi4lVrzVI5s6fzG8W4X362hgMwY3H74Ou81EX60
         j4Eww9gzs0qX0LxeNjs76Cb2CK1wqoIXsybb5kXtmrij/x28dYX7Oxtj6ryH6makLabM
         YFtY3uMpfijnsSFH+raqyZTDlcbfeVm1ms2vzpY8WtaI21qD86f0X9j81/L/0UsDnO3z
         Nhlg==
X-Forwarded-Encrypted: i=1; AJvYcCWN46/DoG2G7miC+5yGxB5Nkr8Z7xwejehRR2tSb4cO/H51F9av8+dJ3t7DAGD/aBkVQercN63wV0AEe/yzGH9Y7vHhvXbqY22jDiOzswA=
X-Gm-Message-State: AOJu0Yx6lsgHRrFfbdvC5EWKNcEIcSt+C0TOZ4ynyPu6QO2M0aS4rWVg
	EFzY7Wz+fv/Doeq/K9ARIpAysqoteLfxjkzhmmeXDjKchmBGtu9tnvtNu6Od4YLCj3XI5LM2t2S
	EtjBXV1Q5IFIpQ2VKqyAtMp5vr0rIiyKXGK68x68P5pacy7yBpgwA481rgYr6+ITg
X-Received: by 2002:a05:600c:46ca:b0:41c:7bd:5a84 with SMTP id 5b1f17b1804b1-41f71bc9fa4mr47556335e9.17.1715258506236;
        Thu, 09 May 2024 05:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuCBFw6U7iMZaMS4x/SFXuxZouu1gJ9UPG87+P3pnlkqCyz6zziQZxU2QofM9KQWpH8K0evw==
X-Received: by 2002:a05:600c:46ca:b0:41c:7bd:5a84 with SMTP id 5b1f17b1804b1-41f71bc9fa4mr47556065e9.17.1715258505624;
        Thu, 09 May 2024 05:41:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3cda:4bef:a79:3f22:9a36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc6csm1621078f8f.21.2024.05.09.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:41:45 -0700 (PDT)
Date: Thu, 9 May 2024 08:41:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240509084050-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240509114615.317450-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add support for Byte Queue Limits (BQL).
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Can we get more detail on the benefits you observe etc?
Thanks!

> ---
>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..c53d6dc6d332 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>  
>  struct virtnet_sq_free_stats {
>  	u64 packets;
> +	u64 xdp_packets;
>  	u64 bytes;
> +	u64 xdp_bytes;
>  };
>  
>  struct virtnet_sq_stats {
> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  	void *ptr;
>  
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> -		++stats->packets;
> -
>  		if (!is_xdp_frame(ptr)) {
>  			struct sk_buff *skb = ptr;
>  
>  			pr_debug("Sent skb %p\n", skb);
>  
> +			stats->packets++;
>  			stats->bytes += skb->len;
>  			napi_consume_skb(skb, in_napi);
>  		} else {
>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>  
> -			stats->bytes += xdp_get_frame_len(frame);
> +			stats->xdp_packets++;
> +			stats->xdp_bytes += xdp_get_frame_len(frame);
>  			xdp_return_frame(frame);
>  		}
>  	}
> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>  	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  
> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> +			  bool in_napi)
>  {
>  	struct virtnet_sq_free_stats stats = {0};
>  
> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
>  	/* Avoid overhead when no packets have been processed
>  	 * happens when called speculatively from start_xmit.
>  	 */
> -	if (!stats.packets)
> +	if (!stats.packets && !stats.xdp_packets)
>  		return;
>  
> +	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
> +
>  	u64_stats_update_begin(&sq->stats.syncp);
>  	u64_stats_add(&sq->stats.bytes, stats.bytes);
>  	u64_stats_add(&sq->stats.packets, stats.packets);
> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	 * early means 16 slots are typically wasted.
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> -		netif_stop_subqueue(dev, qnum);
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> +
> +		netif_tx_stop_queue(txq);
>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>  			/* More just got used, free them then recheck. */
> -			free_old_xmit(sq, false);
> +			free_old_xmit(sq, txq, false);
>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_subqueue(dev, qnum);
>  				virtqueue_disable_cb(sq->vq);
> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  
>  		do {
>  			virtqueue_disable_cb(sq->vq);
> -			free_old_xmit(sq, true);
> +			free_old_xmit(sq, txq, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	txq = netdev_get_tx_queue(vi->dev, index);
>  	__netif_tx_lock(txq, raw_smp_processor_id());
>  	virtqueue_disable_cb(sq->vq);
> -	free_old_xmit(sq, true);
> +	free_old_xmit(sq, txq, true);
>  
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>  		netif_tx_wake_queue(txq);
> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct send_queue *sq = &vi->sq[qnum];
>  	int err;
>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> -	bool kick = !netdev_xmit_more();
> +	bool xmit_more = netdev_xmit_more();
>  	bool use_napi = sq->napi.weight;
>  
>  	/* Free up any pending old buffers before queueing new ones. */
> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		if (use_napi)
>  			virtqueue_disable_cb(sq->vq);
>  
> -		free_old_xmit(sq, false);
> +		free_old_xmit(sq, txq, false);
>  
> -	} while (use_napi && kick &&
> +	} while (use_napi && !xmit_more &&
>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  	/* timestamp packet in software */
> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	check_sq_full_and_disable(vi, dev, sq);
>  
> -	if (kick || netif_xmit_stopped(txq)) {
> +	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			u64_stats_inc(&sq->stats.kicks);
> -- 
> 2.44.0

