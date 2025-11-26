Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1E91799F
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Nov 2025 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115685; cv=none; b=Ek8AhQTAEcCw8cJJjo7o8DeX6nv0M6wSPUmNOgyK+9SYTEr1fVujwD9oTlb+RwVi0OUYp/WYfeAg0wA6c+b+h9edL3tjsD5YvI/t0UQ75xGKfhUo7FtwV7uD8Mr3gi38L0GTPypYbIVsrV79JYmE0DE83YGl7e1iyXqy93OTYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115685; c=relaxed/simple;
	bh=NggLvYCsCYitR7PzyKQAuMZ9PVYDu0g9Y6ARtGEOrhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OFd+mmUnQCsUXyhdxBH0ueZPI11v1TI1QJ6c25AjrovAH8HHeQgqv8JuR9adyXyi87dnSUZD6lFkxx0sJokGvewbsSv3y261ersN3Z+3qTa/ddnBVDGdIQEB/TtRwO25NioKBLYfyPTrCoyQ2pCkx+SkiXiDzvlpc8NAJvUiR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtR9UdVu; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtR9UdVu"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF6E46065A
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Nov 2025 00:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lzp0xnUq4xb5 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Nov 2025 00:08:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AD631605E4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD631605E4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YtR9UdVu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD631605E4
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Nov 2025 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764115679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LfR8L6b81mySpISuZ/q1L5WKsAidakJ+F4/kEKwC3w=;
	b=YtR9UdVu7lMkYK1JaJayQbd6VCax/QJp2UMVKkKAZlVJE54a2CEbp2BRPMDVWQV91YcNUK
	O2/lkfLCLqBUs3p5lLrLZ2hohmzYkbO58eid1/HsmvyXaRARUG3Dr8sS4nH1Kc3jEajhmh
	up6Avip4XELfSx//HebApgyxrqPA4f4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-PTuqxmQEOs6DR0hc8Y7OXw-1; Tue, 25 Nov 2025 19:07:58 -0500
X-MC-Unique: PTuqxmQEOs6DR0hc8Y7OXw-1
X-Mimecast-MFC-AGG-ID: PTuqxmQEOs6DR0hc8Y7OXw_1764115677
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47797caba11so25416135e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Nov 2025 16:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764115677; x=1764720477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LfR8L6b81mySpISuZ/q1L5WKsAidakJ+F4/kEKwC3w=;
        b=tnlnnhmkGtSqdB0HczYMrY7/4zO9UdSZepr7TEN5jH74tMzpl8rpgkfEqXT9QKVq5C
         QjVYWXqG7NlBi/kNKdbY0jASNvzaE6rEcFNoJgj41iCZcPJS1U1+kqPEQ2x5iKvdYSL1
         bZjzKTk1D3lxyYphhJ20val13BVUg2bxEu8E1KZw1MYKudhJMw5YZQs4LHjXDokHW+Jb
         ziRI4Yh7xNwvxrbZqIuAJyaLkh0rKZX2yN1zJQaw/hJ714F9mi/kCd4Zrsy1roTpZKid
         BvFWpMW8aIFewLcmy97qHehVSvoJhVMCG2PCR7UL73jCTuqczf7DEMAns2PSDbvSNCux
         HBkg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/PtiBQWXm7SaLls1GS6H06rhPIwce9WLi00shm+xnB1jmwfR3W5RDqqJc21Vxk1m5I9wAy6cV6s9iDri7A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyMo2VeNq+EV+o37ykq1QkIEcu4hFgXzdVLx035Z1dk29cy7AAd
	KqLXyoij3XCaKZ+PTEYfOwNDdMTn3z4iwY3BSlr4ylqekS3EKQjR4rOBHtZ5m+2GJKb3Afnwv4C
	LIZHPg2/I5F8hGKCrItlNcDmojZnxrftxZSjDtBZHH+hF6EgOhjQYPVygM+C2BF4Y6znhTy2F7b
	GVyLW9RTM=
X-Gm-Gg: ASbGncvRxlscekoTcia/ziOMSRXfDWD9XIC2YaB2R6QcuH6BTjSBZ3A2/1UM/TLkxLm
	ambDwu/oeNhV48BTjn9PrByxXGApKbkT/uBkl/MKaBwvVnqIG/azyNdjwUxs3ddKXow2bs5ExC3
	RMKmp0EnwFhEgTu/9TlphBj+OId74J0bBmHthDxafz9nGqHG2ZJOL2yn6PMaRMx9vt9llEGhbfc
	MxGE9BzbZoTKJQ6JN3AMPtQKvOxANddh6IByI/RLogVSy834jsWFAp+7FlDcOVFw8RWsju/EAXe
	RpAF0t1rtcWpo80qXYWIF74KoWMLROMss5c1shStpCL7qSwkTKD1cizLx/U4OYBzT8DQEelw5Gx
	vV0x1O0PXaimtmSgPvZHn911YYrLl1g==
X-Received: by 2002:a05:600c:474e:b0:477:7523:da8c with SMTP id 5b1f17b1804b1-477c111d3f8mr203494565e9.15.1764115676899;
        Tue, 25 Nov 2025 16:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB3URk6xMwxmshnNVOt6ZVX8qLY09EPucXDJK8VamBZ7pUujQcHsySCZNWix7NvoN/emo4DQ==
X-Received: by 2002:a05:600c:474e:b0:477:7523:da8c with SMTP id 5b1f17b1804b1-477c111d3f8mr203494365e9.15.1764115676418;
        Tue, 25 Nov 2025 16:07:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb919bsm36922863f8f.34.2025.11.25.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 16:07:55 -0800 (PST)
Date: Tue, 25 Nov 2025 19:07:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: liming.wu@jaguarmicro.com
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, angus.chen@jaguarmicro.com
Subject: Re: [PATCH v2] virtio_net: enhance wake/stop tx queue statistics
 accounting
Message-ID: <20251125190743-mutt-send-email-mst@kernel.org>
References: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251120015320.1418-1-liming.wu@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dQR8cUzGmX9Ws7cyPWb38g0cUmYLf61tgJs2GAFuACU_1764115677
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 20, 2025 at 09:53:20AM +0800, liming.wu@jaguarmicro.com wrote:
> From: Liming Wu <liming.wu@jaguarmicro.com>
> 
> This patch refines and strengthens the statistics collection of TX queue
> wake/stop events introduced by commit c39add9b2423 ("virtio_net: Add TX
> stopped and wake counters").
> 
> Previously, the driver only recorded partial wake/stop statistics
> for TX queues. Some wake events triggered by 'skb_xmit_done()' or resume
> operations were not counted, which made the per-queue metrics incomplete.
> 
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 44 ++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e8a179aaa49..b714b190db2a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -775,10 +775,26 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
>  	return false;
>  }
>  
> +static void virtnet_tx_wake_queue(struct virtnet_info *vi,
> +				struct send_queue *sq)
> +{
> +	unsigned int index = vq2txq(sq->vq);
> +	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
> +
> +	if (netif_tx_queue_stopped(txq)) {
> +		u64_stats_update_begin(&sq->stats.syncp);
> +		u64_stats_inc(&sq->stats.wake);
> +		u64_stats_update_end(&sq->stats.syncp);
> +		netif_tx_wake_queue(txq);
> +	}
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;
> -	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> +	unsigned int index = vq2txq(vq);
> +	struct send_queue *sq = &vi->sq[index];
> +	struct napi_struct *napi = &sq->napi;
>  
>  	/* Suppress further interrupts. */
>  	virtqueue_disable_cb(vq);
> @@ -786,8 +802,7 @@ static void skb_xmit_done(struct virtqueue *vq)
>  	if (napi->weight)
>  		virtqueue_napi_schedule(napi, vq);
>  	else
> -		/* We were probably waiting for more output buffers. */
> -		netif_wake_subqueue(vi->dev, vq2txq(vq));
> +		virtnet_tx_wake_queue(vi, sq);
>  }
>  
>  #define MRG_CTX_HEADER_SHIFT 22
> @@ -3068,13 +3083,8 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>  			free_old_xmit(sq, txq, !!budget);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
> -		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2 &&
> -		    netif_tx_queue_stopped(txq)) {
> -			u64_stats_update_begin(&sq->stats.syncp);
> -			u64_stats_inc(&sq->stats.wake);
> -			u64_stats_update_end(&sq->stats.syncp);
> -			netif_tx_wake_queue(txq);
> -		}
> +		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
> +			virtnet_tx_wake_queue(vi, sq);
>  
>  		__netif_tx_unlock(txq);
>  	}
> @@ -3264,13 +3274,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	else
>  		free_old_xmit(sq, txq, !!budget);
>  
> -	if (sq->vq->num_free >= MAX_SKB_FRAGS + 2 &&
> -	    netif_tx_queue_stopped(txq)) {
> -		u64_stats_update_begin(&sq->stats.syncp);
> -		u64_stats_inc(&sq->stats.wake);
> -		u64_stats_update_end(&sq->stats.syncp);
> -		netif_tx_wake_queue(txq);
> -	}
> +	if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
> +		virtnet_tx_wake_queue(vi, sq);
>  
>  	if (xsk_done >= budget) {
>  		__netif_tx_unlock(txq);
> @@ -3521,6 +3526,9 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
>  
>  	/* Prevent the upper layer from trying to send packets. */
>  	netif_stop_subqueue(vi->dev, qindex);
> +	u64_stats_update_begin(&sq->stats.syncp);
> +	u64_stats_inc(&sq->stats.stop);
> +	u64_stats_update_end(&sq->stats.syncp);
>  
>  	__netif_tx_unlock_bh(txq);
>  }
> @@ -3537,7 +3545,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
>  
>  	__netif_tx_lock_bh(txq);
>  	sq->reset = false;
> -	netif_tx_wake_queue(txq);
> +	virtnet_tx_wake_queue(vi, sq);
>  	__netif_tx_unlock_bh(txq);
>  
>  	if (running)
> -- 
> 2.34.1

