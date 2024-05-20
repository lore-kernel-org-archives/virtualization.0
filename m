Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47551005
	for <virtualization@lists.linux.dev>; Mon, 20 May 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209305; cv=none; b=WIBMxSTgkFHtKVwVNVqnf6PQoXsVaWwgAJISNDOTRWMr0JiksZIosgvFJ69bTCm2EIzkS74nGeKMlib0PfmCqNnl7p+TZD08etx8nb9dFh6mBn1zIq0aNXddEYz9/rqlopmFoeaOEXCH0SzYYLqlJ1kMoyznZnuzd+n/L7oxBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209305; c=relaxed/simple;
	bh=n2RFJvwuPIY0pWAVGkNT51g+Wyg/oDiKLxR0DAzZ5LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FodE/idNGRGoPG8Xdk9B5EkHTZkUaCFGvAl5yb7H/z+EcKaY/qm6EHA8vK+c6USCSuDyKNGmNYFtr9e/7fz8EMP3+CABs3d3Z98jldlas4dnu5h40Wj96g8GFFRElDjq84YAfXhhqAD0MLw2gvyYzD0O9zLia30RojPpzeTOSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SB6Klba0; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SB6Klba0"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso2625441fa.2
        for <virtualization@lists.linux.dev>; Mon, 20 May 2024 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716209300; x=1716814100; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edD/qHXmTSqUAHK1Fn+uFuuPgu4ZiccB5v7Y6S0pADc=;
        b=SB6Klba0nyOLmcKhFFnYkKU03X+pE5Hj+V9mIQdZBClE1Jz2P9rbCKyIHm5MVU9ax7
         qSGxyR1tLAJd8jA5KL5mCuQxqSAxZUWau3QwVHYdTtACL5LwfVL7Gk86TH7jhSze6KcO
         heEhemeoj5s4i4cYjlTE03ze/72Q3IOyuAxLFdAwC63uwfA5Z1IPhrWTfrREr0UTl/OT
         5dxX+jm0P15fFfzsUBa4vlnSCtg9zDK6uBbHQD5FxgCx2fbsJQWoAR4j8HLFCVsUVxCf
         exE2pO3RkIqh6h5qYCE/ZeNpowRdEHfElwo2qYR5Vud1rfr+jtqPUk3CP6ATskGcQJaJ
         cXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716209300; x=1716814100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edD/qHXmTSqUAHK1Fn+uFuuPgu4ZiccB5v7Y6S0pADc=;
        b=QWcEOx5VPTTFHcN6hkWuBFYkWqGTh8302wBe2zv4SXk1zmORDd/QJATQArVKolrX8T
         7AIZrmRIxCA56CjF37X+pwdUdGql8G5hAiq3d1lKp6abIOwFtGRjkfi1B6D+gxMAifZH
         9B91hYpELYQepys/P5lnMeuSYJAcmeEBXVZBjqkzlok7yHtgTjYpS2aLd5MMaINIawGo
         a4TIBdOcCA1UbreZ29NOUwDfSM7iURQqefPrL2hGhtoxpM5hiHt5TKz76hRkCvNKsklS
         ebe5xnGC6/3t8vSJn+whHVcH6OfKmube+QtkeFpqft6aoWnwMhm1hwrsZ2v9bERpUHe7
         iPTA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Jt8i+Gnf7ISR24M36/WPeGaohplcfw/Djlz9EiMj1OGjebMzArhxBZCJL6TTOgfUQuDTryBvDR4FiKNLTYt3PbiCJBPBlA1wdSSEGv0=
X-Gm-Message-State: AOJu0YzGvJmDA6nK0vOUJ8f/9aEPI5qHzxWqu1LDRliW5YCs+WWNehNj
	RM47gFFYraNs4DBqWOz9ZGKkyLyUkDEunxxm58FDm4lkZ1uGL+izP5o4tdXm71g=
X-Google-Smtp-Source: AGHT+IGdYPl8eqYkpqi+OilcX/LBUQkNnoyVFYuvU6/03Tx9tXlTUEOLOipwDnf8cYej2iCSODVrvw==
X-Received: by 2002:a2e:859:0:b0:2e5:4171:1808 with SMTP id 38308e7fff4ca-2e541711898mr232419261fa.51.1716209300047;
        Mon, 20 May 2024 05:48:20 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c235b4sm453601015e9.11.2024.05.20.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:48:19 -0700 (PDT)
Date: Mon, 20 May 2024 14:48:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715325076.4219763-2-hengqi@linux.alibaba.com>

Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add support for Byte Queue Limits (BQL).
>
>Historically both Jason and Michael have attempted to support BQL
>for virtio-net, for example:
>
>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>
>These discussions focus primarily on:
>
>1. BQL is based on napi tx. Therefore, the transfer of statistical information
>needs to rely on the judgment of use_napi. When the napi mode is switched to
>orphan, some statistical information will be lost, resulting in temporary
>inaccuracy in BQL.
>
>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
>reasonable. This provides good support for BQL.

But when the device does not support dim, the orphan mode is still
needed, isn't it?

>
>Thanks.
>
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 218a446c4c27..c53d6dc6d332 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>>  
>>  struct virtnet_sq_free_stats {
>>  	u64 packets;
>> +	u64 xdp_packets;
>>  	u64 bytes;
>> +	u64 xdp_bytes;
>>  };
>>  
>>  struct virtnet_sq_stats {
>> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>>  	void *ptr;
>>  
>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> -		++stats->packets;
>> -
>>  		if (!is_xdp_frame(ptr)) {
>>  			struct sk_buff *skb = ptr;
>>  
>>  			pr_debug("Sent skb %p\n", skb);
>>  
>> +			stats->packets++;
>>  			stats->bytes += skb->len;
>>  			napi_consume_skb(skb, in_napi);
>>  		} else {
>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>>  
>> -			stats->bytes += xdp_get_frame_len(frame);
>> +			stats->xdp_packets++;
>> +			stats->xdp_bytes += xdp_get_frame_len(frame);
>>  			xdp_return_frame(frame);
>>  		}
>>  	}
>> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>  	virtnet_rq_free_buf(vi, rq, buf);
>>  }
>>  
>> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
>> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> +			  bool in_napi)
>>  {
>>  	struct virtnet_sq_free_stats stats = {0};
>>  
>> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
>>  	/* Avoid overhead when no packets have been processed
>>  	 * happens when called speculatively from start_xmit.
>>  	 */
>> -	if (!stats.packets)
>> +	if (!stats.packets && !stats.xdp_packets)
>>  		return;
>>  
>> +	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
>> +
>>  	u64_stats_update_begin(&sq->stats.syncp);
>>  	u64_stats_add(&sq->stats.bytes, stats.bytes);
>>  	u64_stats_add(&sq->stats.packets, stats.packets);
>> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>>  	 * early means 16 slots are typically wasted.
>>  	 */
>>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>> -		netif_stop_subqueue(dev, qnum);
>> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>> +
>> +		netif_tx_stop_queue(txq);
>>  		if (use_napi) {
>>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>>  			/* More just got used, free them then recheck. */
>> -			free_old_xmit(sq, false);
>> +			free_old_xmit(sq, txq, false);
>>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>>  				netif_start_subqueue(dev, qnum);
>>  				virtqueue_disable_cb(sq->vq);
>> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>>  
>>  		do {
>>  			virtqueue_disable_cb(sq->vq);
>> -			free_old_xmit(sq, true);
>> +			free_old_xmit(sq, txq, true);
>>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>  
>>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>>  	txq = netdev_get_tx_queue(vi->dev, index);
>>  	__netif_tx_lock(txq, raw_smp_processor_id());
>>  	virtqueue_disable_cb(sq->vq);
>> -	free_old_xmit(sq, true);
>> +	free_old_xmit(sq, txq, true);
>>  
>>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>  		netif_tx_wake_queue(txq);
>> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	struct send_queue *sq = &vi->sq[qnum];
>>  	int err;
>>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>> -	bool kick = !netdev_xmit_more();
>> +	bool xmit_more = netdev_xmit_more();
>>  	bool use_napi = sq->napi.weight;
>>  
>>  	/* Free up any pending old buffers before queueing new ones. */
>> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  		if (use_napi)
>>  			virtqueue_disable_cb(sq->vq);
>>  
>> -		free_old_xmit(sq, false);
>> +		free_old_xmit(sq, txq, false);
>>  
>> -	} while (use_napi && kick &&
>> +	} while (use_napi && !xmit_more &&
>>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>  
>>  	/* timestamp packet in software */
>> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  
>>  	check_sq_full_and_disable(vi, dev, sq);
>>  
>> -	if (kick || netif_xmit_stopped(txq)) {
>> +	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
>>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>>  			u64_stats_update_begin(&sq->stats.syncp);
>>  			u64_stats_inc(&sq->stats.kicks);
>> -- 
>> 2.44.0
>> 
>> 
