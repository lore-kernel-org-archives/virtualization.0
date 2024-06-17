Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CD1D953D
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640866; cv=none; b=hNh0IpIRj8u2yCZFq526i9AxeBCI4GhghriwtLzFSoaeeEOSN5PHyY+gGjHsM+D5EHHnYiBCLZzbhQqZgGOe0pKVeeWQMod6ve7YnmQJX82Y5NwtsqcXEohpnZJih3Z2taZWrgtJrI8RGQB9bVlp4cPH1SNtzK6ijkzD6BImyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640866; c=relaxed/simple;
	bh=2jMwxQewd+8WDZGv6NOK7cJXTWSPZNZhzGB+cFhY6wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HLNvDQjJQ7znZr1QjM6lR1R05u6+/JY61WrX3uwTU1Yk4RB2U6MjQVOfCcclUdgzzGAyN8zIi0ey734bFgrvuEJ2CFzqoDNxtOoDYfX+8Gjb1BTbr5/B3VSLYeIaqI79UFZAIi8b1Rz7knsP00xt8jFysJ3pyD9Vo0N6REj7gQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dja9Yrut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dja9Yrut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718640863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tdS7HdTjamJqZQvjpytbBcG9HZLsuSC96RMHEWu0PCI=;
	b=dja9YrutJ7oqoGfqbbZy6Sd3aDZapWcQS7ywKxQa9xC+3p+dzXniHitDpIxGwa9bjjsla+
	EGliF0/7B2sFYo1hiisbLKn3e//yoE3fpY4vAE1SW+EJAK5b8YhXkAIExQOJoh/houKGkh
	QYu6EGmGeyCCvLm+ISwxpS7GeSyffqA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-VoUzpNumOyOgT21NEqrfpg-1; Mon, 17 Jun 2024 12:14:19 -0400
X-MC-Unique: VoUzpNumOyOgT21NEqrfpg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4217a6a00d8so29686405e9.0
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 09:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718640858; x=1719245658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdS7HdTjamJqZQvjpytbBcG9HZLsuSC96RMHEWu0PCI=;
        b=raWXri0MmTqOEAMRZMcBaRECMnDc9AxKh2EOqqOQ/p29SUaqU2uKSDEM6T+HjVHzO1
         A3FGj/pqOQM4tkRGqqjXIn/ZB26oc50W7tT5GXll2Qa/caAtF/nqWkLT4fPfRO3HXOXs
         xisOM1Ni9dUMhmSGHuIAnuFv//HQO9BMELu4qWf4kEZnsA026K92C2/i65khFtDkD9/d
         CU0kjyaeqHDFcbenAG4U9WhpkIFNqPI04fcL+GS1EiNRMHL7Yxr7dt0NTaYkphna0gpd
         wzsL4xBdAoz5G4Wxd60YQRU/eK16c+MlJgakcWc4uujFnX+Ec75z5XLqMdfFwb3m6xnD
         7nEg==
X-Forwarded-Encrypted: i=1; AJvYcCX54NHzwYGyIehyDN+ebf3atFQvWEUIkDMSAqQDzv0usimUbeeVWEeLBiM2X0oX9Y8tc5OohjNlIxotv2FimN1YgC4Y69+xj23w3IQUqOY=
X-Gm-Message-State: AOJu0YxmpZ4MQtwwFBJWBArSAqY84ec9WB19blRNkUIHds1q/1c/BFQo
	2rMiZSc4SaizHdwX0ihtMynCy6yBo7E+QlIBdlSHGeYEcjqFQX1Uml7BNBW2HaUl5f5OPplZqLE
	KrnHVlvF3CvOAdWAnmmvrnTCQJg/nWBOzvAuWJoy8HpH1i9u3OMW4EEUhHOkPGtCg
X-Received: by 2002:a05:600c:1d07:b0:421:7435:88d7 with SMTP id 5b1f17b1804b1-42304844106mr94329375e9.26.1718640858304;
        Mon, 17 Jun 2024 09:14:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr87ATNUs/p+ZpcBH8Wairi2HMEiV960OMo2BTrJWfe9r6Tu7Sm7VZx6L0DFFW4J1GkyFwmg==
X-Received: by 2002:a05:600c:1d07:b0:421:7435:88d7 with SMTP id 5b1f17b1804b1-42304844106mr94329095e9.26.1718640857767;
        Mon, 17 Jun 2024 09:14:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320bd8sm162571805e9.32.2024.06.17.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:14:17 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:14:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v2] virtio_net: add support for Byte Queue Limits
Message-ID: <20240617121234-mutt-send-email-mst@kernel.org>
References: <20240612170851.1004604-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240612170851.1004604-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 07:08:51PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add support for Byte Queue Limits (BQL).
> 
> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> running in background. Netperf TCP_RR results:
> 
> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v1->v2:
> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>   propagate use_napi flag to __free_old_xmit() and only call
>   netdev_tx_completed_queue() in case it is true
> - added forgotten call to netdev_tx_reset_queue()
> - fixed stats for xdp packets
> - fixed bql accounting when __free_old_xmit() is called from xdp path
> - handle the !use_napi case in start_xmit() kick section
> ---
>  drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..5863c663ccab 100644
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
> @@ -506,29 +508,33 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>  }
>  
> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> +			    bool in_napi, bool use_napi,
>  			    struct virtnet_sq_free_stats *stats)
>  {
>  	unsigned int len;
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
> +	if (use_napi)
> +		netdev_tx_completed_queue(txq, stats->packets, stats->bytes);
> +
>  }
>  
>  /* Converting between virtqueue no. and kernel tx/rx queue no.
> @@ -955,21 +961,22 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>  	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  
> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> +			  bool in_napi, bool use_napi)
>  {
>  	struct virtnet_sq_free_stats stats = {0};
>  
> -	__free_old_xmit(sq, in_napi, &stats);
> +	__free_old_xmit(sq, txq, in_napi, use_napi, &stats);
>  
>  	/* Avoid overhead when no packets have been processed
>  	 * happens when called speculatively from start_xmit.
>  	 */
> -	if (!stats.packets)
> +	if (!stats.packets && !stats.xdp_packets)
>  		return;
>  
>  	u64_stats_update_begin(&sq->stats.syncp);
> -	u64_stats_add(&sq->stats.bytes, stats.bytes);
> -	u64_stats_add(&sq->stats.packets, stats.packets);
> +	u64_stats_add(&sq->stats.bytes, stats.bytes + stats.xdp_bytes);
> +	u64_stats_add(&sq->stats.packets, stats.packets + stats.xdp_packets);
>  	u64_stats_update_end(&sq->stats.syncp);
>  }
>  
> @@ -1003,7 +1010,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	 * early means 16 slots are typically wasted.
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> -		netif_stop_subqueue(dev, qnum);
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> +
> +		netif_tx_stop_queue(txq);
>  		u64_stats_update_begin(&sq->stats.syncp);
>  		u64_stats_inc(&sq->stats.stop);
>  		u64_stats_update_end(&sq->stats.syncp);
> @@ -1012,7 +1021,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>  			/* More just got used, free them then recheck. */
> -			free_old_xmit(sq, false);
> +			free_old_xmit(sq, txq, false, use_napi);
>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_subqueue(dev, qnum);
>  				u64_stats_update_begin(&sq->stats.syncp);
> @@ -1138,7 +1147,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	}
>  
>  	/* Free up any pending old buffers before queueing new ones. */
> -	__free_old_xmit(sq, false, &stats);
> +	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
> +			false, sq->napi.weight, &stats);


So what happens if sq->napi.weight changes while packet is in the queue?
What prevents that?



>  
>  	for (i = 0; i < n; i++) {
>  		struct xdp_frame *xdpf = frames[i];
> @@ -2313,7 +2323,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  
>  		do {
>  			virtqueue_disable_cb(sq->vq);
> -			free_old_xmit(sq, true);
> +			free_old_xmit(sq, txq, true, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> @@ -2412,6 +2422,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  		goto err_xdp_reg_mem_model;
>  
>  	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
>  	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
>  
>  	return 0;
> @@ -2471,7 +2482,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	txq = netdev_get_tx_queue(vi->dev, index);
>  	__netif_tx_lock(txq, raw_smp_processor_id());
>  	virtqueue_disable_cb(sq->vq);
> -	free_old_xmit(sq, true);
> +	free_old_xmit(sq, txq, true, true);
>  
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
>  		if (netif_tx_queue_stopped(txq)) {
> @@ -2559,17 +2570,18 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct send_queue *sq = &vi->sq[qnum];
>  	int err;
>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> -	bool kick = !netdev_xmit_more();
> +	bool xmit_more = netdev_xmit_more();
>  	bool use_napi = sq->napi.weight;
> +	bool kick;
>  
>  	/* Free up any pending old buffers before queueing new ones. */
>  	do {
>  		if (use_napi)
>  			virtqueue_disable_cb(sq->vq);
>  
> -		free_old_xmit(sq, false);
> +		free_old_xmit(sq, txq, false, use_napi);
>  
> -	} while (use_napi && kick &&
> +	} while (use_napi && !xmit_more &&
>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  	/* timestamp packet in software */
> @@ -2598,7 +2610,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	check_sq_full_and_disable(vi, dev, sq);
>  
> -	if (kick || netif_xmit_stopped(txq)) {
> +	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
> +			  !xmit_more && netif_xmit_stopped(txq);
> +	if (kick) {
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			u64_stats_inc(&sq->stats.kicks);
> -- 
> 2.45.1

