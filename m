Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD455C3B
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337311; cv=none; b=QBNY+i26m2CxwRDJW7yu3ySMHW6vwutint8sK1xv93vSJqbma22/Soq2kNVRYrsdzmPg/lOvoSAy25YpfmzctmXfSN48Xb/2AWTSTj/3wQiGXjSCyvV39teZiQCSB7eqi6f1AWENEntaSxpVOD3bwMhgvGqOKQ3KQ1c0KP7a/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337311; c=relaxed/simple;
	bh=o6JFuHgOdAawciqY4EZmbjA2eVPuOWiIZa3N6EQKGwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKNHVeB7aRVsjLAOraNd9GLS+qyPoMkPrD3Tr7HdzWk0hzZ5ggo60gEGcRD+Sp0z9v1XseIw26PZ7OkZKWn9wV63V8BcyrAXhBgCqIPJAvdOCFqXfOQWxB4gZ5rYCwHI28rtHKyfmglaRKVcg8BrJr4LAw+fjHhfnYgwuYPHUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IX6AOBmu; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IX6AOBmu"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f60817e34so2248251e87.2
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715337306; x=1715942106; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WF6NXAmShEkLi88sqZOX0cWWafeX5tooo7v0pkI1FQ=;
        b=IX6AOBmuxZ5Wv0d6uGZqzAvQW61H2zt0EJ3/8ABFUzjewputBwqJ5Xsw2DX2+Pd4vp
         mC4YDWadvd0hdYoCejVRbjFwN/VRULAqeTxrWEakCcgpgmDWvOOLbkj79z0gkijGz7Tr
         LKqzKQ4UxevskZGk6QxkFRW/UAGk+/q0gdojPFBIbQ8+2CdgCr/jEnIwSagUOaXxopbc
         nHuI9K8cCIktPFjMYOvmri236oLWI1vbaQ5X0U2AeJ2VK/IhHllReUdJKjAyDq1hwBRQ
         QBFbgQwlSRLIYrTajiAQxN9GyvqEaaQnLgH8ScUXHgjYaFazY1lesizkH2S6CVs2bAg2
         GXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337306; x=1715942106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WF6NXAmShEkLi88sqZOX0cWWafeX5tooo7v0pkI1FQ=;
        b=GIlDE9XIIxKTk2p7YWmVuPI/9kont1tV6CFBBsdm0lGFEjl7pp+B32GiVb87f0ZfM/
         nQD8QcKAaDKerwrajLUTao5Cu0RSOhZMtBtyUJxDEVA47f7rc2BYKu8wyQRCsUisIPHa
         IreLeOU+Qg2nri5zojothUnNz/w/De4/pFA2v2gwvYdv8/2tUOwRnCK7G8BlYMyG3enR
         k0dOLAi4g0cx9ZepAd13GG5L0mdJwgudzeZG98wTEk7OhTV3Dsy8nPN/N49WvsAG6IAh
         Fo0n0PKoaY2fn7AuhRGQX/sPW8FkAiFxbvLN9q8OsyZF9hGSYKwnPXyTsQ02ma44Kmgl
         sYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1P2uV1LSWCMcV6XmHH2vJzE5nmtVvWDTRjrzkw+FFoWnK+816yH4RejldLPKuQ1zIvt9Sxly7I2sEWDqD8QeSs9j9LGGnN5fQkZ7oefg=
X-Gm-Message-State: AOJu0Yy5oMfsQce3Db/8kZ164pAQnnkpmmlfL5cNoEzD0Jori+H9vrSA
	JA2xhlzm/4S61BsZ9sFbleqbcSWWg7zHqngCtHcDTRSTd0zbz1VgFEbaWCsAak0=
X-Google-Smtp-Source: AGHT+IEZdzOLT/qB1CrK1qM4rWDfvvPv8AKWCB3xY0cjp0hEZAQTWGTr+MhRIYstBgqcwctvkewJFw==
X-Received: by 2002:a05:6512:33ce:b0:513:edf4:6f20 with SMTP id 2adb3069b0e04-5220fe79457mr1602566e87.54.1715337306127;
        Fri, 10 May 2024 03:35:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc99sm4190142f8f.11.2024.05.10.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:35:05 -0700 (PDT)
Date: Fri, 10 May 2024 12:35:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj34VgY5yT7259iT@nanopsycho.orion>
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

Thanks for the pointers, will check that out.


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
