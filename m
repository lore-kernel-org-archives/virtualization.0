Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766F1917FB
	for <virtualization@lists.linux.dev>; Tue, 18 Feb 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868596; cv=none; b=Xo4q5b4cJRPKq5q0QQnaMoOz3zhuEuJkIAA+Nh2ZwFB4INFRiFWahz29lRxjEOx8FSgOLNcK1VFFh0ACcDSu/L4kGGoJFCk7/E42b4hzKzqHD6XfSdPbf2VQkhIf8R/1UIepbbnRu6tPMWecu64uwHJ14Yrsdgf2jboj0tCXoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868596; c=relaxed/simple;
	bh=dXoEOkK2zL7ZpgMh1uya9jJKqyfmFRh3MsQ3mafOb6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I/y/Ssdp+4zm5UwbrthbyCCVuqkG8h3WQECzp1Rk+R6kx0UmKnf9B3Em7oMJntF5+G2ir5RuNq/1a1e0BInnz+x0IUlUKKdUlB6OpPf0grmKmLA2OwbNospMEeYvQX/Xi6WrgbLJrjuDfvuayM326j5il0adD5Jfj8FN59OeqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVna3gbo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVna3gbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2LzTC5dXVKNPAth+Ux9LT9Nh8e/89qeI4vDz/bFUhw=;
	b=LVna3gboG5g+LY+k48LnrJO+qMKYZqhrbqPAUe32q+FwC3WykB++7yayV0eVz5awbpu6Qh
	6F3k7VbQUQZs0TlLTqGcobv3axowvG0uEAXviG1jIU9vXR46mQBcULCIXyLTwiOC5XYnGX
	6en7+czN0MwjtHeEzFooPUwSemMoFow=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ALLgOFFaOEyTgC-Njb1PRA-1; Tue, 18 Feb 2025 03:49:50 -0500
X-MC-Unique: ALLgOFFaOEyTgC-Njb1PRA-1
X-Mimecast-MFC-AGG-ID: ALLgOFFaOEyTgC-Njb1PRA_1739868589
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso37900105e9.1
        for <virtualization@lists.linux.dev>; Tue, 18 Feb 2025 00:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868589; x=1740473389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2LzTC5dXVKNPAth+Ux9LT9Nh8e/89qeI4vDz/bFUhw=;
        b=RaF11qk2I1oMY+iaS9qvJN3lQ/sHxJ12rF5moiC92+gUr/5AE+whYp939zzOe4bReN
         qjOim3nXSx6mvIyITv+PI+6v1QPprLCP+tvZFJ14nhjIOkZpAbqy25LYR+EUlhGIlQG7
         bsxplcOZTBcm2sYX0o3ifkvcURUBBKmDBNKaqwVASYqviMdXFUjXN2MI//NNom3VKTEE
         Vunw+Zh6P/8FPcZNKA5wu7Szrx/eosz5tcXKu8iTl5Ot2bjTeyDVGepsms+em+mjVSIE
         mi66/UD7xOnhTw9vaCaaqZt0kVGyA+aa9X+bIvmNEVlUk1U7owynE+53iSY8fMFS50ht
         NPRw==
X-Forwarded-Encrypted: i=1; AJvYcCWMJjrR45Ud2aMoBo+7bSKRTw2a073Gt1mHpvlY1z4vksX+Qb3OW9p4z74deoEt2Ma6F6vCi0gCGxyjPyoBzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5glIYizMBqRmfQGy2gq4RAA0sn7lv7+EhLlLBO1HOr+vNbXDz
	QTY8CFWCjnxNYV1LJ7t5Jpr8KYWrjLJrwjYCMpiYfRmyDTUti7pgMB1Z8EHlIXltJ2SZOpwIBfY
	YRhjY7HitNqfPZR9veAHrTnwGcJKVB+d5bakOpNUoQjVev47SoCnE8r+L1eanyCkfSrn42Bxu
X-Gm-Gg: ASbGnctnkGHotnM5Kpg0zvYaw6mdtv9ewkBp94Jb0yjdvdyVVcxFXFxrOILjN7Z7NU9
	vXY8y67BKEBHMcZNbJy73FIwWE7Nk6S7/IBV9JFUXXVL75oV6gwZxAUnmpte6pq1NpnMHTLejgc
	+udWEHgOhxyLOXS+mvHfvFr3iKL5N+GkR8YPoMCL2aKIQ0H1nNphvlyMjjx37ZE/itnmk25CbQF
	TcmjxXHAsT4cWnjY3SfI9ZYlNXT9BkBYtUvK0jdBiq9PQ5MOIFJx2puPHNyke9SlIeFk6E=
X-Received: by 2002:a05:600c:1d26:b0:439:6a40:4860 with SMTP id 5b1f17b1804b1-4396e75cea1mr107159325e9.28.1739868588916;
        Tue, 18 Feb 2025 00:49:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwjS+nR/wHh1APBF9u+K9/mt1qqaSj+MqVMyzeTqVCHDHhclsydu5xCXA8WU4A9dOyCXmxgQ==
X-Received: by 2002:a05:600c:1d26:b0:439:6a40:4860 with SMTP id 5b1f17b1804b1-4396e75cea1mr107159005e9.28.1739868588502;
        Tue, 18 Feb 2025 00:49:48 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:7ef9:8f0d:a8:10c1:4db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b84bcsm181214165e9.40.2025.02.18.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:49:47 -0800 (PST)
Date: Tue, 18 Feb 2025 03:49:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
Message-ID: <20250218034919-mutt-send-email-mst@kernel.org>
References: <20250218023908.1755-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250218023908.1755-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lba9Gz8SRzda-vhXBNTFTmh1U-WClePOyI_4IYTQR8Q_1739868589
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

can you pls also test perf with tx irq disabled mode, to be sure?

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

