Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802730C61B
	for <virtualization@lists.linux.dev>; Sat,  3 Jan 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767459471; cv=none; b=ReMv7FhwQfN1XnsnU2I2YVTP9FTiyap/StF6YVXFBGiZ876LrXOTLJ4TrJvYez1LCBq3+NofUPb4/Uf1fNfzKcK26pQlflwiL8RqBqqnV33f2+OBIv/e1mg2uzVnOaXexiZMabXiajttzbpMEy9rbf8H4+rEYE9/XHCXHE87M/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767459471; c=relaxed/simple;
	bh=m7kFC8NLRqMykIfn43teN/tTE91nR1HuG4dJPWsxS3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BDLQQOorkiTtwM6O55vOTEpKBbh441rHuDTiroGYq9wdAVESzl11xinw6r0WozdK6QeremjL48yQPMEqpkOKIUYiU8xQQeFJ5WramvhWIW53+KrsSsvWsqd/T+/t1kSndmZaGOQX400X5YkDIbBbe9cATA7Pi4VDec/FYKky8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZUQ06SP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZUQ06SP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767459468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+wZkUF3NRhUPtxghhUm6LslapHbc+LfpmZjiNA6s+nU=;
	b=LZUQ06SPLbG+qqwTowr9uqSlk06blXhbQNJI0DcNpdeHjfSazHeskUGiLdWykLzwHe2RfO
	NqzhlZHxHVm0xt59MvWNiao0NBSMhXfEK4ata24mU4z5tYeDQaXWrFniICjfV6i27At4vo
	dSPQ79Av3YufA9HPDbNbm/IqGpzIh28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-kElyjSGvNL2B1T82IgfTJQ-1; Sat, 03 Jan 2026 11:57:45 -0500
X-MC-Unique: kElyjSGvNL2B1T82IgfTJQ-1
X-Mimecast-MFC-AGG-ID: kElyjSGvNL2B1T82IgfTJQ_1767459464
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fd96b440so6610157f8f.1
        for <virtualization@lists.linux.dev>; Sat, 03 Jan 2026 08:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767459464; x=1768064264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wZkUF3NRhUPtxghhUm6LslapHbc+LfpmZjiNA6s+nU=;
        b=ds0MMxJ4oYFkdQz5X1gRI+snOvtL+/HP/Px2cQkZUpId8y6VExN09P5UUNljno4nrG
         pRfzOgsq+7A5DYNfmXHfGNmiK2s/vGsM/WvLB9g7EfzazHIhYoBBVJAQncL9nb4aYENl
         XsIlDudBEsGEmcEtfJujTo80o4piqzPufo1td+IUyS6ryZaC8Ow7TxX+fI7fTl8SdeWr
         39ZIjczQ7lNNqW2SB/MJbf90gSKGHV+Ux5DizcXIRC+HE05LvPlUnltBZTYxGpYaJiGB
         TN/6iolaDQvPxxH8Cpn93UBWldkSq5eCi+z14eHo2yVgMLGDVaklLchKHLXXr1Q9KkHI
         LICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFOLH5i2xArzpPJFBVpkRN17ycfqG/MmM4sqwvPOygIQ04iAkc2k/SibQhgGzQVw7P9wqwdWLxsVNP6QDftA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEg0StOkrtF75eGcW/VzywIChSGiK22Ubd3A5Ww/mkT34ncSdQ
	FGrulIee6ZmzYTIjcgM5Kx8bhgPBpVbIePQbjdo1fkRhhNiTa4mt86h4KB4Bqxnv9bmfXlAd3MH
	GS1i5pf7EyEcQjJZejf6uybk0DT4VgGwNPI5JY5vG3H1vhdKILyVhzX1lfk3rSBBzJDGZ
X-Gm-Gg: AY/fxX58M7AdhR40KYZylEV0CzH6++LKLmNqu28xYbwVRZA0X1D+hkeQrm3KJAogrs4
	BsuDv54yUcnFKeREsyRW27Kx/GJNs6En3tL3vQfs4UiCUqUvpOOhv6SkEDynff16RcaA5fIkCLr
	6tzCXMmTIcfFsL7/rambNRWqtUxLNhAhUu4JKUN1OiYfkzktz+KR2ZBirg3y9HhplEx7keReRYm
	jspEKqZh2+R+QH63BAiIHpB02bs2ZgCm4K3TSL6sJa/51VKgPN1s6NR9294xF33IjBQUCLwG+qW
	L5Qk+FS7U8LwSCCQThJZld5/cG4vxXhT0CAY9OkjGjDa35Dn2NOwHY8roeOKoxRU5wjB3FzIA4p
	5WI8=
X-Received: by 2002:a05:600c:818f:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d19538725mr584363185e9.3.1767459464023;
        Sat, 03 Jan 2026 08:57:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHusWZ//FZ52Om4ta3xZ2SqfyTWAAUvd8rHgZYV++2oDeDeRRcln+Ih/5srZxMz/V4FtoawtQ==
X-Received: by 2002:a05:600c:818f:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d19538725mr584362855e9.3.1767459463570;
        Sat, 03 Jan 2026 08:57:43 -0800 (PST)
Received: from redhat.com ([147.235.217.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2a94sm90750023f8f.43.2026.01.03.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 08:57:42 -0800 (PST)
Date: Sat, 3 Jan 2026 11:57:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260103115424-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260102152023.10773-2-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p8ducQjCGPn3zXBiTAC8BmFN79nlr9vruni42BoPSaU_1767459464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2026 at 10:20:21PM +0700, Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues
> such as races and deadlocks. To simplify the logic and avoid further
> problems, we will instead retry refilling in the next NAPI poll.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..ac514c9383ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  }
>  
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -			   unsigned int *xdp_xmit)
> +			   unsigned int *xdp_xmit, bool *retry_refill)
>  {
>  	struct virtnet_info *vi = rq->vq->vdev->priv;
>  	struct virtnet_rq_stats stats = {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>  
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> -		}
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +			*retry_refill = true;
>  	}
>  
>  	u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	struct send_queue *sq;
>  	unsigned int received;
>  	unsigned int xdp_xmit = 0;
> -	bool napi_complete;
> +	bool napi_complete, retry_refill = false;
>  
>  	virtnet_poll_cleantx(rq, budget);
>  
> -	received = virtnet_receive(rq, budget, &xdp_xmit);
> +	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>  	rq->packets_in_napi += received;
>  
>  	if (xdp_xmit & VIRTIO_XDP_REDIR)
>  		xdp_do_flush();
>  
>  	/* Out of packets? */
> -	if (received < budget) {
> +	if (received < budget && !retry_refill) {
>  		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>  		/* Intentionally not taking dim_lock here. This may result in a
>  		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
> @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  		virtnet_xdp_put_sq(vi, sq);
>  	}
>  
> -	return received;
> +	return retry_refill ? budget : received;
>  }
>  
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* If this fails, we will retry later in
> +			 * NAPI poll, which is scheduled in the below
> +			 * virtnet_enable_queue_pair

hmm do we even need this, then?

> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
>  
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> +	if (refill)
> +		/* If this fails, we will retry later in NAPI poll, which is
> +		 * scheduled in the below virtnet_napi_enable
> +		 */
> +		try_fill_recv(vi, rq, GFP_KERNEL);


hmm do we even need this, then?

> +
>  	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	struct virtio_net_rss_config_trailer old_rss_trailer;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg;
> +	int i;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
> @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		/* Let the NAPI poll refill the receive buffer for us. We can't
> +		 * safely call try_fill_recv() here because the NAPI might be
> +		 * enabled already.
> +		 */

I'd drop this comment, it does not clarify much.

> +		local_bh_disable();
> +		for (i = 0; i < vi->curr_queue_pairs; i++)
> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +
> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0

