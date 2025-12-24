Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFF2F39AB
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571580; cv=none; b=gEasTGrkoZQi3B7ymS2KkM3WtzsTmw7LQfJCN9V+1qNDXnd2XXMxAkclnD8HnLmvik1MFZVCzB0weevz0kr4WqA5u4kniXDrNhigtmilIq7DpC0ARGCQqGLf4FXtT8n34n9I1qS7L8Y18Z1wOyDxWleZxl/nDeqsj4avLp63kyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571580; c=relaxed/simple;
	bh=am+gYZV9ZfCUcbmclOH8tQmfbQdi6EY4YxtxHw3YJRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jl2oikXUPItNd05xTC0+Uvor2WxjG957K+p/Eqfmsjw8p4/CV5QfaQiw6g8n7MCL60xhd8KjFcWs+uUhQh2XR+qsRhZ6xfmxp3PjEIdujBWwCLfpBFkqNYG89wTY2VC+ypE39t0hKzSBVsZly0a5V1mEN6HZCA5C3ObsOMMfPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azKIvAl9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azKIvAl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766571577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx1LTt+IOIvJVL78uQXldUrvF0hrWxkn8Odmb29Ytqs=;
	b=azKIvAl98XbirXSn1Lww9ddk7siavcNZTlTADZnfWZJEXzJq5HdtS+UIoaKTNrjAhkZYbE
	jff66E8QhV7vwgKekKKYNwbLcJ7xtHB3KKd72zuMz6c6WXX2AwfiRtDzwrZW1PNI7wbx8F
	3NT3HDL9RE0qEC2gbuzlI44LW1Vn2zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-nkPGatTeMte4v6UClm_t7Q-1; Wed, 24 Dec 2025 05:19:34 -0500
X-MC-Unique: nkPGatTeMte4v6UClm_t7Q-1
X-Mimecast-MFC-AGG-ID: nkPGatTeMte4v6UClm_t7Q_1766571573
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d110fabso47165605e9.1
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 02:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571573; x=1767176373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx1LTt+IOIvJVL78uQXldUrvF0hrWxkn8Odmb29Ytqs=;
        b=xEX7C8Jg7m3aa4yVqEXluyWTUQrjlqC1cFlqH3gy3zqNfvSCYxA+InKB25I8LN3GjA
         3DHUClrg+pOgqgHu/fmp44L6QJr74rudOQ/20QWvz/pArWQYtknPkYRUOh5k0gvVX9yv
         c5p9kHhsMa64Ojm2jAAYSKkvAFQJlTNlgjKdhn0mayYt9HVteShqWczcK9PnnqCbY3Z7
         0tibZjeea9e0dESEirdrEGAo75ZowXzRSfqqYSTYlBJve3z8mGshCR/z6r15Now5STRo
         NxNNh4kJUezc1YnLtCdtKMLvwGMuB0HW7Mf8j1ZSwE/zYMP/DW5m4mInqeUD7qvikkEc
         e3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdtYjwNrwyLfrTCdByuN+8wFIOabS9gn4U3fOwudvjyZLSX3WQDJreIUU9haCe97la8MIbnz8HE8HB53FS5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywyi2G32KYKjas4KEmqFPwmC91FtLhO+c/8zHrWWlSrqqEdWRFo
	HWGbJlMm7GBfHMCbNEMYw17jcNB0RcLOm4vk/1pqt7zoZrglCnSmOWdF7i4hCln4mx2dCX6+YZP
	JFs32FsG2taFnVLZjK0nPKdSKyAq9VkeANNHlIt+p11KeKDVT4AIaoJKPpgxS5yJ4yhkR
X-Gm-Gg: AY/fxX7YCd8l52PXJF+UIo/PiO6m95b1g8iyVem2JXIYiseVz6oqC/KP33fi62AJ7Cp
	qW2rcNZHQ0ZerSQDTrfA0PBrm1MwCbigQR1kC2aBdf4RhMEZOjOJnY+U6EAnr6dIcZBTIhYDhuE
	dLvwdbtUQMYgF/mifZNXeNZQcBlTEY5aMckf1eQDAKfg6Bi7I0/YEE+wbBPaRB6U+FzbHLxcyD9
	2dbpFgoQtQI1NF2ArN1pffbIVNnHStW8lPsSj+AOJ1zVwdBG6lM0OJf/83QeEFvyqeiMM9U6x03
	e8NMjE60ArpzwiUiDGwx0ofvjRQlJgg0P9XL1g0AlNC14O2gnQrtn1bo39DWf+HKAA1lAeR6k8t
	x
X-Received: by 2002:a05:600c:4711:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-47d19596ed2mr188269775e9.35.1766571573064;
        Wed, 24 Dec 2025 02:19:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWh4eB5LClE32541NyP3GYu8yrLTSzO9/oko2wZ9FswtoXx/XEGhT13Drk8XxIX4u7HLPOVA==
X-Received: by 2002:a05:600c:4711:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-47d19596ed2mr188269395e9.35.1766571572577;
        Wed, 24 Dec 2025 02:19:32 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab33f5sm33496423f8f.41.2025.12.24.02.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:19:32 -0800 (PST)
Date: Wed, 24 Dec 2025 05:19:29 -0500
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251224051747-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LtHaHs6ahmoBxVWjhcW1QBmr7RPIUBCzB0t8cj5BqwA_1766571573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:25:31PM +0700, Bui Quang Minh wrote:
> Currently, the refill work is a global delayed work for all the receive
> queues. This commit makes the refill work a per receive queue so that we
> can manage them separately and avoid further mistakes. It also helps the
> successfully refilled queue avoid the napi_disable in the global delayed
> refill work like before.
> 

this commit log is unreadable. before what? what is the problem with
"refilled queue napi_disable" this refers to.

> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 155 ++++++++++++++++++---------------------
>  1 file changed, 72 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..63126e490bda 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -379,6 +379,15 @@ struct receive_queue {
>  	struct xdp_rxq_info xsk_rxq_info;
>  
>  	struct xdp_buff **xsk_buffs;
> +
> +	/* Is delayed refill enabled? */
> +	bool refill_enabled;
> +
> +	/* The lock to synchronize the access to refill_enabled */
> +	spinlock_t refill_lock;
> +
> +	/* Work struct for delayed refilling if we run low on memory. */
> +	struct delayed_work refill;
>  };
>  
>  #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> @@ -441,9 +450,6 @@ struct virtnet_info {
>  	/* Packet virtio header size */
>  	u8 hdr_len;
>  
> -	/* Work struct for delayed refilling if we run low on memory. */
> -	struct delayed_work refill;
> -
>  	/* UDP tunnel support */
>  	bool tx_tnl;
>  
> @@ -451,12 +457,6 @@ struct virtnet_info {
>  
>  	bool rx_tnl_csum;
>  
> -	/* Is delayed refill enabled? */
> -	bool refill_enabled;
> -
> -	/* The lock to synchronize the access to refill_enabled */
> -	spinlock_t refill_lock;
> -
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  
> @@ -720,18 +720,18 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  		put_page(virt_to_head_page(buf));
>  }
>  
> -static void enable_delayed_refill(struct virtnet_info *vi)
> +static void enable_delayed_refill(struct receive_queue *rq)
>  {
> -	spin_lock_bh(&vi->refill_lock);
> -	vi->refill_enabled = true;
> -	spin_unlock_bh(&vi->refill_lock);
> +	spin_lock_bh(&rq->refill_lock);
> +	rq->refill_enabled = true;
> +	spin_unlock_bh(&rq->refill_lock);
>  }
>  
> -static void disable_delayed_refill(struct virtnet_info *vi)
> +static void disable_delayed_refill(struct receive_queue *rq)
>  {
> -	spin_lock_bh(&vi->refill_lock);
> -	vi->refill_enabled = false;
> -	spin_unlock_bh(&vi->refill_lock);
> +	spin_lock_bh(&rq->refill_lock);
> +	rq->refill_enabled = false;
> +	spin_unlock_bh(&rq->refill_lock);
>  }
>  
>  static void enable_rx_mode_work(struct virtnet_info *vi)
> @@ -2950,38 +2950,19 @@ static void virtnet_napi_disable(struct receive_queue *rq)
>  
>  static void refill_work(struct work_struct *work)
>  {
> -	struct virtnet_info *vi =
> -		container_of(work, struct virtnet_info, refill.work);
> +	struct receive_queue *rq =
> +		container_of(work, struct receive_queue, refill.work);
>  	bool still_empty;
> -	int i;
> -
> -	for (i = 0; i < vi->curr_queue_pairs; i++) {
> -		struct receive_queue *rq = &vi->rq[i];
>  
> -		/*
> -		 * When queue API support is added in the future and the call
> -		 * below becomes napi_disable_locked, this driver will need to
> -		 * be refactored.
> -		 *
> -		 * One possible solution would be to:
> -		 *   - cancel refill_work with cancel_delayed_work (note:
> -		 *     non-sync)
> -		 *   - cancel refill_work with cancel_delayed_work_sync in
> -		 *     virtnet_remove after the netdev is unregistered
> -		 *   - wrap all of the work in a lock (perhaps the netdev
> -		 *     instance lock)
> -		 *   - check netif_running() and return early to avoid a race
> -		 */
> -		napi_disable(&rq->napi);
> -		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> -		virtnet_napi_do_enable(rq->vq, &rq->napi);
> +	napi_disable(&rq->napi);
> +	still_empty = !try_fill_recv(rq->vq->vdev->priv, rq, GFP_KERNEL);
> +	virtnet_napi_do_enable(rq->vq, &rq->napi);
>  
> -		/* In theory, this can happen: if we don't get any buffers in
> -		 * we will *never* try to fill again.
> -		 */
> -		if (still_empty)
> -			schedule_delayed_work(&vi->refill, HZ/2);
> -	}
> +	/* In theory, this can happen: if we don't get any buffers in
> +	 * we will *never* try to fill again.
> +	 */
> +	if (still_empty)
> +		schedule_delayed_work(&rq->refill, HZ / 2);
>  }
>  
>  static int virtnet_receive_xsk_bufs(struct virtnet_info *vi,
> @@ -3048,10 +3029,10 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>  		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> +			spin_lock(&rq->refill_lock);
> +			if (rq->refill_enabled)
> +				schedule_delayed_work(&rq->refill, 0);
> +			spin_unlock(&rq->refill_lock);
>  		}
>  	}
>  
> @@ -3226,13 +3207,13 @@ static int virtnet_open(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
>  
> -	enable_delayed_refill(vi);
> -
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs)
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
>  			/* Make sure we have some buffers: if oom use wq. */
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +				schedule_delayed_work(&vi->rq[i].refill, 0);
> +		}
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3251,10 +3232,9 @@ static int virtnet_open(struct net_device *dev)
>  	return 0;
>  
>  err_enable_qp:
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> -
>  	for (i--; i >= 0; i--) {
> +		disable_delayed_refill(&vi->rq[i]);
> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>  		virtnet_disable_queue_pair(vi, i);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
> @@ -3447,14 +3427,15 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
>  {
>  	int i;
>  
> -	/*
> -	 * Make sure refill_work does not run concurrently to
> -	 * avoid napi_disable race which leads to deadlock.
> -	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		/*
> +		 * Make sure refill_work does not run concurrently to
> +		 * avoid napi_disable race which leads to deadlock.
> +		 */
> +		disable_delayed_refill(&vi->rq[i]);
> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>  		__virtnet_rx_pause(vi, &vi->rq[i]);
> +	}
>  }
>  
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> @@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	 * Make sure refill_work does not run concurrently to
>  	 * avoid napi_disable race which leads to deadlock.
>  	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> +	disable_delayed_refill(rq);
> +	cancel_delayed_work_sync(&rq->refill);
>  	__virtnet_rx_pause(vi, rq);
>  }
>  
> @@ -3481,25 +3462,26 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  		virtnet_napi_enable(rq);
>  
>  	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> +		schedule_delayed_work(&rq->refill, 0);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  {
>  	int i;
>  
> -	enable_delayed_refill(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs)
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		else
> +		} else {
>  			__virtnet_rx_resume(vi, &vi->rq[i], false);
> +		}
>  	}
>  }
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(vi);
> +	enable_delayed_refill(rq);
>  	__virtnet_rx_resume(vi, rq, true);
>  }
>  
> @@ -3830,10 +3812,16 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
>  	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		int i;
> +
> +		for (i = 0; i < vi->curr_queue_pairs; i++) {
> +			spin_lock_bh(&vi->rq[i].refill_lock);
> +			if (vi->rq[i].refill_enabled)
> +				schedule_delayed_work(&vi->rq[i].refill, 0);
> +			spin_unlock_bh(&vi->rq[i].refill_lock);
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -3843,10 +3831,6 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> -	/* Make sure NAPI doesn't schedule refill work */
> -	disable_delayed_refill(vi);
> -	/* Make sure refill_work doesn't re-enable napi! */
> -	cancel_delayed_work_sync(&vi->refill);
>  	/* Prevent the config change callback from changing carrier
>  	 * after close
>  	 */
> @@ -3857,6 +3841,10 @@ static int virtnet_close(struct net_device *dev)
>  	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		/* Make sure NAPI doesn't schedule refill work */
> +		disable_delayed_refill(&vi->rq[i]);
> +		/* Make sure refill_work doesn't re-enable napi! */
> +		cancel_delayed_work_sync(&vi->rq[i].refill);
>  		virtnet_disable_queue_pair(vi, i);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
> @@ -5802,7 +5790,6 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	enable_delayed_refill(vi);
>  	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
> @@ -6559,8 +6546,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>  	if (!vi->rq)
>  		goto err_rq;
>  
> -	INIT_DELAYED_WORK(&vi->refill, refill_work);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		INIT_DELAYED_WORK(&vi->rq[i].refill, refill_work);
> +		spin_lock_init(&vi->rq[i].refill_lock);
>  		vi->rq[i].pages = NULL;
>  		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
>  				      i);
> @@ -6901,7 +6889,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
> -	spin_lock_init(&vi->refill_lock);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> @@ -7165,7 +7152,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	net_failover_destroy(vi->failover);
>  free_vqs:
>  	virtio_reset_device(vdev);
> -	cancel_delayed_work_sync(&vi->refill);
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		cancel_delayed_work_sync(&vi->rq[i].refill);
> +
>  	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
>  free:
> -- 
> 2.43.0

