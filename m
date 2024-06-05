Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C61EB27
	for <virtualization@lists.linux.dev>; Wed,  5 Jun 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587060; cv=none; b=NzWp9rbK88iGvT2465Uf1npSVcLaHGr+qWGdEsrKn8mAWYEmraQktsrwvXXX62jIFLcb48cew0z3VaVfO7zuoyRg+8b3+aShs47m/NpL+Eg1mAZpujnXOLCes9JMrT0J6fq3Wszs/Im9jGwESemazu3XmU9z4+R9tUeGfBsftqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587060; c=relaxed/simple;
	bh=We5opLWy7VSuhbIfPgcRvEpu2bynphyAOWJP0WxhwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDft8/Mw8qzw3Qp+AxuKy+2ISs1GYujvAN3bEDQ6P+RW7QTeASb/BtBSfOc2THEsE/pQUj38k74SchASPGNmDCPzvSF1MLZsiq/LvZ/kgaV+ctVE8SHge67WR5LbnB5G6V6qw8UbXE81rIJgkm46RBPynEqRxAcwusMJ8ZkyPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bid9djy8; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bid9djy8"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-42155143cb0so15203255e9.2
        for <virtualization@lists.linux.dev>; Wed, 05 Jun 2024 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717587056; x=1718191856; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dI5cNg2pQS1K+SK1Dh8USe6ne1W8c1tbvQXgIdRfh6c=;
        b=bid9djy8ptoFXJxlTr5RpMJil7W2WltiU1hGN7YRiwYUPSK+PCYOn8r0MgK9iEWtsn
         A2s2C7kCNytkco15VI6c+mWRO4++zmp/A3OzdxcdHnb5SOCArNx4lVyIxctHW/wtufNC
         h/jowa/dynhqLqvHv6Vzo9QlcB9HlcTG/MpL0JIVv6N2chHNuC1OUnWZKzpgd2EcLrrO
         R4cbiLHY+Mfsa9NuhdBPW6bv6KtHc+nuJqVCNkb/XCPqi/e5y0MCre2/1Kodi/6BXKlQ
         WxHGkpu3eTmZ8tSLtWUMtELsTvevL4eF/azoIdZKTgp/4GzHW1nisiPB7RxmQbDl161D
         WH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587056; x=1718191856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI5cNg2pQS1K+SK1Dh8USe6ne1W8c1tbvQXgIdRfh6c=;
        b=dXkq3/sQfMLqMLFT/kuz3cAYLCTYYc614YJdetbQzclUBmpq1XvwcktH5+/vV7Tyxd
         shmMprRMeweFduTKu5VnFyFTYoF66KnMyKPZYFDNv6NDg8M6KsPoSNN67sZ3nkej7F6b
         P5X2kRGnEnDz6Mc4vdG9j0d51D5OeFXdsXZdDeKbWbpvgALRn8goynl6rTGRhQSMCGr/
         /FTy52ifqmppS+mHgLPXEEn1bynAJbcYCR/LDdB98e7di3AnkFO0ri/rcO6rOxQ8r2WQ
         nyJmnf0a09UBgthDCn4vinQYO5CCJO8E43ZsCrabqr8sZ44PtGLRsPRmzerGD4jkHEzv
         Lbag==
X-Forwarded-Encrypted: i=1; AJvYcCXxXQox9LdP0vgvgzK8zWoZjDNRmIvDrdcf8PHmco8eLqFe6qoi/WG4OkLBjhYeuksj/8uI7INqN8TQH09tAIoJ7Zo0Ajzl9yWx/gcfxcs=
X-Gm-Message-State: AOJu0Yw8YJ5vYLcAxKyCsaT4iN6/IbYXptMnTxENvmqljWsrM+UCTB3j
	OMR4+3isuzAwzJmNJUOyBzv5oRPaTx3Ne7d5UXO+Eh1yA6NLgTw1LhTBKqZtC2I=
X-Google-Smtp-Source: AGHT+IHnLX9QfM04CGs0aTWeZ6fYFqn170weZqx+exS7IbQLTKyYFBDBcHm0DfVPHq7ray8i0QJPLA==
X-Received: by 2002:a05:6000:2a2:b0:35e:ebe7:de43 with SMTP id ffacd0b85a97d-35eebe7e01fmr1338482f8f.21.1717587055500;
        Wed, 05 Jun 2024 04:30:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d3csm14338107f8f.19.2024.06.05.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:30:54 -0700 (PDT)
Date: Wed, 5 Jun 2024 13:30:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktGj4nDU4X0Lxtx@nanopsycho.orion>

Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
>Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
>>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>> 
>>> Add support for Byte Queue Limits (BQL).
>>
>>Historically both Jason and Michael have attempted to support BQL
>>for virtio-net, for example:
>>
>>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>>
>>These discussions focus primarily on:
>>
>>1. BQL is based on napi tx. Therefore, the transfer of statistical information
>>needs to rely on the judgment of use_napi. When the napi mode is switched to
>>orphan, some statistical information will be lost, resulting in temporary
>>inaccuracy in BQL.
>>
>>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
>>reasonable. This provides good support for BQL.
>
>But when the device does not support dim, the orphan mode is still
>needed, isn't it?

Heng, is my assuption correct here? Thanks!

>
>>
>>Thanks.
>>
>>> 
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
>>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>> 
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 218a446c4c27..c53d6dc6d332 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>>>  
>>>  struct virtnet_sq_free_stats {
>>>  	u64 packets;
>>> +	u64 xdp_packets;
>>>  	u64 bytes;
>>> +	u64 xdp_bytes;
>>>  };
>>>  
>>>  struct virtnet_sq_stats {
>>> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>>>  	void *ptr;
>>>  
>>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>>> -		++stats->packets;
>>> -
>>>  		if (!is_xdp_frame(ptr)) {
>>>  			struct sk_buff *skb = ptr;
>>>  
>>>  			pr_debug("Sent skb %p\n", skb);
>>>  
>>> +			stats->packets++;
>>>  			stats->bytes += skb->len;
>>>  			napi_consume_skb(skb, in_napi);
>>>  		} else {
>>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>>>  
>>> -			stats->bytes += xdp_get_frame_len(frame);
>>> +			stats->xdp_packets++;
>>> +			stats->xdp_bytes += xdp_get_frame_len(frame);
>>>  			xdp_return_frame(frame);
>>>  		}
>>>  	}
>>> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>  	virtnet_rq_free_buf(vi, rq, buf);
>>>  }
>>>  
>>> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
>>> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>>> +			  bool in_napi)
>>>  {
>>>  	struct virtnet_sq_free_stats stats = {0};
>>>  
>>> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
>>>  	/* Avoid overhead when no packets have been processed
>>>  	 * happens when called speculatively from start_xmit.
>>>  	 */
>>> -	if (!stats.packets)
>>> +	if (!stats.packets && !stats.xdp_packets)
>>>  		return;
>>>  
>>> +	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
>>> +
>>>  	u64_stats_update_begin(&sq->stats.syncp);
>>>  	u64_stats_add(&sq->stats.bytes, stats.bytes);
>>>  	u64_stats_add(&sq->stats.packets, stats.packets);
>>> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>>>  	 * early means 16 slots are typically wasted.
>>>  	 */
>>>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>>> -		netif_stop_subqueue(dev, qnum);
>>> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>>> +
>>> +		netif_tx_stop_queue(txq);
>>>  		if (use_napi) {
>>>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>>>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>>>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>>>  			/* More just got used, free them then recheck. */
>>> -			free_old_xmit(sq, false);
>>> +			free_old_xmit(sq, txq, false);
>>>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>>>  				netif_start_subqueue(dev, qnum);
>>>  				virtqueue_disable_cb(sq->vq);
>>> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>>>  
>>>  		do {
>>>  			virtqueue_disable_cb(sq->vq);
>>> -			free_old_xmit(sq, true);
>>> +			free_old_xmit(sq, txq, true);
>>>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>>  
>>>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>>>  	txq = netdev_get_tx_queue(vi->dev, index);
>>>  	__netif_tx_lock(txq, raw_smp_processor_id());
>>>  	virtqueue_disable_cb(sq->vq);
>>> -	free_old_xmit(sq, true);
>>> +	free_old_xmit(sq, txq, true);
>>>  
>>>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>>  		netif_tx_wake_queue(txq);
>>> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  	struct send_queue *sq = &vi->sq[qnum];
>>>  	int err;
>>>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>>> -	bool kick = !netdev_xmit_more();
>>> +	bool xmit_more = netdev_xmit_more();
>>>  	bool use_napi = sq->napi.weight;
>>>  
>>>  	/* Free up any pending old buffers before queueing new ones. */
>>> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  		if (use_napi)
>>>  			virtqueue_disable_cb(sq->vq);
>>>  
>>> -		free_old_xmit(sq, false);
>>> +		free_old_xmit(sq, txq, false);
>>>  
>>> -	} while (use_napi && kick &&
>>> +	} while (use_napi && !xmit_more &&
>>>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>>  
>>>  	/* timestamp packet in software */
>>> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  
>>>  	check_sq_full_and_disable(vi, dev, sq);
>>>  
>>> -	if (kick || netif_xmit_stopped(txq)) {
>>> +	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
>>>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>>>  			u64_stats_update_begin(&sq->stats.syncp);
>>>  			u64_stats_inc(&sq->stats.kicks);
>>> -- 
>>> 2.44.0
>>> 
>>> 
