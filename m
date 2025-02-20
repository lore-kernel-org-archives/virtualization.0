Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8F1E9B07
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086740; cv=none; b=HoG59x/B7nciRH4bedKdx9F6pYXpc8qfQaEZWCUmBOo5bgS9aEllf5rRd1vJZ72GBzrtaUQxnf6TYbLWifdpjoF4fZhZbSIv0ksRylC0RoAYn999dQRl1UfwU/tDvP0DSRHLWq20CrL37iGwBPHlRgKmpGy6aQIKkI/Ax0skCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086740; c=relaxed/simple;
	bh=x7rBl2z18pUs53vExXjZWpBRXv/IZMZTi6N+JNBqaBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b3bguw2llt1yttJS7fUm+tNToI/VzR9lcq4II6Zc6VN+F0tvF1si0969Z6U5zP7GTLF2ltA/RxnEvKLfBubFP3CQRok5vWB6A2G8mjgIu9sKq+ylgU8PvmspQEp8BtT8wenvvxkYzz3szxhWhISphGofkB9Q/V9TGtddkImUFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoURM7a9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoURM7a9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740086737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unrDTS7QCI25KAS4sCB3l7J3lV8KCBJAU/xxoJQKS8w=;
	b=DoURM7a9tQ72boXi1weGrio/k2A2MpJOVN/xq+A5vJRkhNcIgL1WIEspjY+jXPdMD1+LQa
	iklGRr5U9NklEVCiIQT+9KIUpul5MNTF860hgdQXGhT0lw38vP5ovcyT3dOyA4Xwp7QpoP
	5P54BpuYIoXvq/DRRGpyKRr+Kx5sijg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Z7LTRz5lOem9Fub60FkjPQ-1; Thu, 20 Feb 2025 16:25:35 -0500
X-MC-Unique: Z7LTRz5lOem9Fub60FkjPQ-1
X-Mimecast-MFC-AGG-ID: Z7LTRz5lOem9Fub60FkjPQ_1740086735
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e095e02b69so1731387a12.0
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 13:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086734; x=1740691534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unrDTS7QCI25KAS4sCB3l7J3lV8KCBJAU/xxoJQKS8w=;
        b=iasl5JvO3tDGMK3jSn7uqBNF+xJqy/zblODTmeI4YzZ1qRFCCPEw0jvy3Q5kwHKNLG
         /VO5mn9FYV4ZtIKtjkGu1/CCYg+dv9hGfaD0scnMLoUOonhdV0dbHoCKKnfU4N+TrLEh
         dVGEGMsFksXaggSryycsWJ72Gm34hTQDkljtwR6n6ctOW8wjy+VG5tT13xcPUTSzKke1
         awGJhgPto2ttKYzQfPaXWvkd3s85Fus4kDe90GcCZewPrzF6HQSE2Xy2mA9ghJekpKF5
         wga3M+XSPdmH8dRGz8Qu622+oi4uiS0uSgCFbz1+BFQHSKxWtTNIbGPxeI7beTQ1k5pB
         UJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq+1hqoRBbbh8seOLwRWIuqntV+WHW2voZFE+MLutPn2talK3O2VY+XhkvlAQZL2qCA26J3GfcipWSRZ7UjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywhe6zus+OfaM3N4TZPmGrq3SoWiujZPLo2Wunlbbsw1aCDYQG7
	UlSxay1T/QERBI6jvnWVhI445ZSmAs7Piq+UEpLqLFNiNq5V5s00pJKbshaKDv5UrU4FSgWCmHN
	V2zer6L20QAyZN8eIRLZbUrnNzsUzMZ3Ag3+jEJqPZ36KYIZj4wNy8hmFD638bIbr
X-Gm-Gg: ASbGnctpU+ZvIKN+sJXgB+oilwRauhN33iE1FNF51VXyOAQG4OjBPnIfqo4RuMFtqOu
	LaVsCrZvnwnsfCfcNNwLG2Oz+TS+aRqbwR4QAZujZgiqleMPNicPMPjMhe7jadJosSwfK9SQYV3
	oR00R9PlnewuduCbRL+AZHMfwNcjC7foAnFFGH+XI2yRWsciFm9C/+32NODzBBDz7YFkLzalRhp
	CmEzcu8Y/nwQnCrHPXQ9+grooW5XUQb8JrQI3NTw7N+zjmWD3bh3EdQy7lcp3XgIlnGpQ==
X-Received: by 2002:a05:6402:2381:b0:5dc:8fc1:b3b5 with SMTP id 4fb4d7f45d1cf-5e0b63746femr543899a12.15.1740086734514;
        Thu, 20 Feb 2025 13:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5v3Yl+txcCz5/XdiQPZHOqYI0qvokO2xkWoSI5C9U/U0H41NLIvQ3f0aIpX8wcg7Zxg0iug==
X-Received: by 2002:a05:6402:2381:b0:5dc:8fc1:b3b5 with SMTP id 4fb4d7f45d1cf-5e0b63746femr543882a12.15.1740086734132;
        Thu, 20 Feb 2025 13:25:34 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3624sm12881090a12.40.2025.02.20.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:25:32 -0800 (PST)
Date: Thu, 20 Feb 2025 16:25:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
Message-ID: <20250220162359-mutt-send-email-mst@kernel.org>
References: <20250218023908.1755-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250218023908.1755-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bKPdG479QxrKK456eoTfmxGbuDbCt3K96ytI98cX4Ic_1740086735
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2025 at 10:39:08AM +0800, Jason Wang wrote:
> There are several issues existed in start_xmit():
> 
> - Transmitted packets need to be freed before sending a packet, this
>   introduces delay and increases the average packets transmit
>   time. This also increase the time that spent in holding the TX lock.
> - Notification is enabled after free_old_xmit_skbs() which will
>   introduce unnecessary interrupts if TX notification happens on the
>   same CPU that is doing the transmission now (actually, virtio-net
>   driver are optimized for this case).
> 
> So this patch tries to avoid those issues by not cleaning transmitted
> packets in start_xmit() when TX NAPI is enabled and disable
> notifications even more aggressively. Notification will be since the
> beginning of the start_xmit(). But we can't enable delayed
> notification after TX is stopped as we will lose the
> notifications. Instead, the delayed notification needs is enabled
> after the virtqueue is kicked for best performance.
> 
> Performance numbers:
> 
> 1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
>    (burst 256) + testpmd (rxonly) on the host:
> 
> - When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
>   increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
>   eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
>   10.7 Mpps, 99% TX interrupts were eliminated.
> 
> - When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
>   were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
>   were eliminated; Packed virtqueue PPS were increased 78% from 6.12
>   Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.
> 
> 2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
>    session netperf from guest to host shows 82% improvement from
>    31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
>    of TX interrupts were eliminated.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


okay

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but tell me something, would it be even better to schedule
napi once, and have that deal with enabling notifications?

> ---
>  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..ac26a6201c44 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
>  		return false;
>  }
>  
> -static void check_sq_full_and_disable(struct virtnet_info *vi,
> -				      struct net_device *dev,
> -				      struct send_queue *sq)
> +static bool tx_may_stop(struct virtnet_info *vi,
> +			struct net_device *dev,
> +			struct send_queue *sq)
>  {
> -	bool use_napi = sq->napi.weight;
>  	int qnum;
>  
>  	qnum = sq - vi->sq;
> @@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  		u64_stats_update_begin(&sq->stats.syncp);
>  		u64_stats_inc(&sq->stats.stop);
>  		u64_stats_update_end(&sq->stats.syncp);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void check_sq_full_and_disable(struct virtnet_info *vi,
> +				      struct net_device *dev,
> +				      struct send_queue *sq)
> +{
> +	bool use_napi = sq->napi.weight;
> +	int qnum;
> +
> +	qnum = sq - vi->sq;
> +
> +	if (tx_may_stop(vi, dev, sq)) {
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> +
>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	bool use_napi = sq->napi.weight;
>  	bool kick;
>  
> -	/* Free up any pending old buffers before queueing new ones. */
> -	do {
> -		if (use_napi)
> -			virtqueue_disable_cb(sq->vq);
> -
> +	if (!use_napi)
>  		free_old_xmit(sq, txq, false);
> -
> -	} while (use_napi && !xmit_more &&
> -	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> +	else
> +		virtqueue_disable_cb(sq->vq);
>  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
> @@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		nf_reset_ct(skb);
>  	}
>  
> -	check_sq_full_and_disable(vi, dev, sq);
> +	if (use_napi)
> +		tx_may_stop(vi, dev, sq);
> +	else
> +		check_sq_full_and_disable(vi, dev,sq);
>  
>  	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
>  			  !xmit_more || netif_xmit_stopped(txq);
> @@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  	}
>  
> +	if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +
>  	return NETDEV_TX_OK;
>  }
>  
> -- 
> 2.34.1

