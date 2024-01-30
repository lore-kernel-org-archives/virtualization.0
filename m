Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AFF823D3
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630019; cv=none; b=uIAypfi7J9yG/GItUqXUj+pAxMgi/WGhC/GY8HyHZR4s8TBdygNS6XNMnbelm7Xnv6n6cwtQUpAiBG1be1eRpxZ7dg7OTWYvXl9ArZTFR/TeIkJMO7gPSURy+dPqQJnv1OcyHTelfz8v3VSV8YABhSe0mJ82/YFrldKBRiCaDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630019; c=relaxed/simple;
	bh=2ZfaXeHTDTQIeVg3HDAJLmIdU1OfG4WUV/SoRZgyMDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=osTp7AvVHxztE7ylxsVr83H5K4ckzlp2o2ItglWdrA/1VQw8PcJ9s4Yc532+DY5bvTIgD/eYmS4Baw37gGr/14WjTFl9l4vS8efDzQ/LVGmEB45OkEoRkJpZKdUF795KLryAITsqhkpf6OLjaqpHADWBoaHv7A2Je2KrUsrXLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaadbEO3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaadbEO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706630016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gBVV/KdsxfS9Bhg/h52XINfYssQKsLx0d5Fl8ob/EeI=;
	b=JaadbEO3ioutFxz4o2NhPVRNE/M//eVVbPJ4bbKwzXvxMTSvbCD7doctW9pkilelQfdDy0
	jG2QqsnSuyzOYU1NNa6wXiFDysg5wWR3K+b7BphLNoHI12lMoC91ItZKxrsXtq2Pj538+l
	Nktqsn3YS0yfjb3OqpkErYCvqf0Zqd4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-xQK6v3S0NWOv9884_O5gCA-1; Tue, 30 Jan 2024 10:53:35 -0500
X-MC-Unique: xQK6v3S0NWOv9884_O5gCA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33af3b0371cso757706f8f.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 07:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630014; x=1707234814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBVV/KdsxfS9Bhg/h52XINfYssQKsLx0d5Fl8ob/EeI=;
        b=hObtqD1JjIFbE/kmGZ3DYDze8MFPjGZrKp/632M0EsAfUJLPLQ1GuyxHys1Ieg8VYk
         rkg8WYcc6uLSFpSGdbbByzbMRcl9h8zxkneRir0e0Nbdm0TiQFxvsLhfJG+0NWsgzU9D
         r25AB6/NRUBlXd1DdyIFqETRz773XivzSbXJ9BxEhHxcE+VeLuzdrXbqxMFj2I/0fVvO
         53Jc3jGkA4HC3oBTBr63lUNnlzm9K/B3WoOl5ZiO4LvrAdTr3Q7xspa1ZUKvv8JW/oMm
         n3Zm7/v9b9rnyQYbCbhAfiKRPjFdYjd/GO8yjGeJdrzs9mulTX9DVvXkc3mAlGSDuwPS
         W48w==
X-Gm-Message-State: AOJu0YywmFCA+KFK+QZ4wrOXh3R1nYnQBh6jjCAGSUGyNV4B2AvID8c9
	rDQ1aXNfyZKe7TlQF8OieOyhR0VP8itySXxsngqNXqrd0FjZuaJmH2cYHxBXnXL5Fl9l9Jurtuw
	LrTPkZkLL4PX1I3nhge6zQOCad2LFoEhjjqZMq5v+IX4E28vFXhMnagLyJ7EoKREa
X-Received: by 2002:a5d:47c3:0:b0:33a:f172:82df with SMTP id o3-20020a5d47c3000000b0033af17282dfmr4126678wrc.15.1706630014432;
        Tue, 30 Jan 2024 07:53:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGncGGJB4dlJHwteStDOtdpyZ6TnasUK9AMhmMxjw5DPPiXWwKchPGrStiQ65NpduhYo2tbbQ==
X-Received: by 2002:a5d:47c3:0:b0:33a:f172:82df with SMTP id o3-20020a5d47c3000000b0033af17282dfmr4126655wrc.15.1706630014066;
        Tue, 30 Jan 2024 07:53:34 -0800 (PST)
Received: from redhat.com ([2.52.129.159])
        by smtp.gmail.com with ESMTPSA id ci10-20020a5d5d8a000000b00339281d98c9sm11270327wrb.72.2024.01.30.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 07:53:33 -0800 (PST)
Date: Tue, 30 Jan 2024 10:53:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240130105246-mutt-send-email-mst@kernel.org>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 03:50:29PM +0000, Daniel Jurgens wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 30, 2024 9:42 AM
> > On Tue, Jan 30, 2024 at 03:40:21PM +0000, Daniel Jurgens wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, January 30, 2024 8:58 AM
> > > >
> > > > On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> > > > > Add a tx queue stop and wake counters, they are useful for debugging.
> > > > >
> > > > > 	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> > > > > 	...
> > > > > 	tx_queue_1_tx_stop: 16726
> > > > > 	tx_queue_1_tx_wake: 16726
> > > > > 	...
> > > > > 	tx_queue_8_tx_stop: 1500110
> > > > > 	tx_queue_8_tx_wake: 1500110
> > > > >
> > > > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > >
> > > > Hmm isn't one always same as the other, except when queue is stopped?
> > > > And when it is stopped you can see that in the status?
> > > > So how is having two useful?
> > >
> > > At idle the counters will be the same, unless a tx_timeout occurs. But
> > under load they can be monitored to see which queues are stopped and get
> > an idea of how long they are stopped.
> > 
> > how does it give you the idea of how long they are stopped?
> 
> By serially monitoring the counter you can see stops that persist long intervals that are less than the tx_timeout time.

Why don't you monitor queue status directly?

> > 
> > > Other net drivers (not all), also have the wake counter.
> > 
> > Examples?
> 
> [danielj@sw-mtx-051 upstream]$ ethtool -i ens2f1np1
> driver: mlx5_core                                  
> version: 6.7.0+                                    
> ...
> [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep wake
>      tx_queue_wake: 0
>      tx0_wake: 0

Do they have a stop counter too?

> > 
> > > In my opinion it makes the stop counter more useful, at little cost.
> > >
> > > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> > > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 3cb8aa193884..7e3c31ceaf7e 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> > > > >  	u64_stats_t xdp_tx_drops;
> > > > >  	u64_stats_t kicks;
> > > > >  	u64_stats_t tx_timeouts;
> > > > > +	u64_stats_t tx_stop;
> > > > > +	u64_stats_t tx_wake;
> > > > >  };
> > > > >
> > > > >  struct virtnet_rq_stats {
> > > > > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> > > > virtnet_sq_stats_desc[] = {
> > > > >  	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
> > > > >  	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
> > > > >  	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
> > > > > +	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
> > > > > +	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
> > > > >  };
> > > > >
> > > > >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
> > > > > @@
> > > > > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct
> > > > > virtnet_info
> > > > *vi,
> > > > >  	 */
> > > > >  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > >  		netif_stop_subqueue(dev, qnum);
> > > > > +		u64_stats_update_begin(&sq->stats.syncp);
> > > > > +		u64_stats_inc(&sq->stats.tx_stop);
> > > > > +		u64_stats_update_end(&sq->stats.syncp);
> > > > >  		if (use_napi) {
> > > > >  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > > >  				virtqueue_napi_schedule(&sq->napi, sq- vq);
> > @@ -851,6 +858,9
> > > > >@@  static void check_sq_full_and_disable(struct virtnet_info *vi,
> > > > >  			free_old_xmit_skbs(sq, false);
> > > > >  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> > > > >  				netif_start_subqueue(dev, qnum);
> > > > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > > > +				u64_stats_update_end(&sq->stats.syncp);
> > > > >  				virtqueue_disable_cb(sq->vq);
> > > > >  			}
> > > > >  		}
> > > > > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct
> > > > receive_queue *rq)
> > > > >  			free_old_xmit_skbs(sq, true);
> > > > >  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > > >
> > > > > -		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > > > +		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > > > +			if (netif_tx_queue_stopped(txq)) {
> > > > > +				u64_stats_update_begin(&sq->stats.syncp);
> > > > > +				u64_stats_inc(&sq->stats.tx_wake);
> > > > > +				u64_stats_update_end(&sq->stats.syncp);
> > > > > +			}
> > > > >  			netif_tx_wake_queue(txq);
> > > > > +		}
> > > > >
> > > > >  		__netif_tx_unlock(txq);
> > > > >  	}
> > > > > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct
> > > > > napi_struct
> > > > *napi, int budget)
> > > > >  	virtqueue_disable_cb(sq->vq);
> > > > >  	free_old_xmit_skbs(sq, true);
> > > > >
> > > > > -	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> > > > > +	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> > > > > +		if (netif_tx_queue_stopped(txq)) {
> > > > > +			u64_stats_update_begin(&sq->stats.syncp);
> > > > > +			u64_stats_inc(&sq->stats.tx_wake);
> > > > > +			u64_stats_update_end(&sq->stats.syncp);
> > > > > +		}
> > > > >  		netif_tx_wake_queue(txq);
> > > > > +	}
> > > > >
> > > > >  	opaque = virtqueue_enable_cb_prepare(sq->vq);
> > > > >
> > > > > --
> > > > > 2.42.0

