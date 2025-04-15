Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE942973A0
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723176; cv=none; b=JlukdXLez0nn8hEMHLAKQRlKG8HT/XESXq9OWUYNCe3/dKCP9DbnU9ep19KOOa5tkl1SDi7tpvXy+uiZ1rDS6iXzKfr5ATUTIwqygQC7JtjBBgtvXwWgVmW1OK+cB4+c0pjBlS2urrWIygsVLBuOd8ySYN1fqDn2EgBPfxeQqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723176; c=relaxed/simple;
	bh=e9R32tQBSXYQd8goFfR+Lx7lJByV3tKzSiDQM/hj3JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kuqRWT0w+XeCN7tBgqitx8pWp55m6ljYw3Q6f84GOM0KGRPMjBRRLcSMQS2il7ixAEsXCEh65FXwu93CimL1bjJj8hVi2HzRLKkOs8sZ9C/rC9E5K7VLIQtWRZhASgTqV312AzTkcj8OvrAz9c36aFqa2ARJ57ar8MKUHyEO53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjiiS0uH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjiiS0uH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744723173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDFRVUvYARrrdoMVKwNSz9nrR/1vGVN5NRO4r+H+6kk=;
	b=TjiiS0uH7PjepR7rcajPBTCLIYGdOXmkFJVyHQGAVk2cVnWtVL0AJFsRl3+pdyVflqITKX
	PtMf9ratbKcsB2CnfhHsmbeCKeA0FUYNglxqq5klJTvxGQ/mf0sVvEvgs4M1muEVYPNAuV
	/OsNUWAGser3Vl7T4VGb8G3/kvUQH1M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-C5LIj1mdNRCz92aeyfx0Zw-1; Tue, 15 Apr 2025 09:19:32 -0400
X-MC-Unique: C5LIj1mdNRCz92aeyfx0Zw-1
X-Mimecast-MFC-AGG-ID: C5LIj1mdNRCz92aeyfx0Zw_1744723171
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39143311936so2228670f8f.0
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 06:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723171; x=1745327971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDFRVUvYARrrdoMVKwNSz9nrR/1vGVN5NRO4r+H+6kk=;
        b=hYWqJGfwHhNdOGtdxaRQMGs44ERN4F77NRBbsBw5aC/YyilPKMsMTwuN1vdrB7DR7t
         g+jY2DxMMtGra0hgw8NRAz5KvmWBguUvXzCuovsdj9oWM62Z79IHC7yRwr7ZDuyawe8/
         p9bd0Kqe+GLBmh37R6y5SOsHL8yYt0qnWCtC+FkkznN+qTA49qv/d+Kxr3qLxFEgGbng
         4RgDzwF2BgG8h+UaqEE9Qh60BKKVhDCpWe7SozD170AvwfaTqoBqO6DfQ00FekWYt8ws
         UtX9drJQsbkA0nB9JSCCq4FFZfHlm8iBqlDoejMYfHl37PJ9gryUs2/KNW8DnL7oUqnY
         PxMQ==
X-Gm-Message-State: AOJu0YxcBhtS7iQb4Egl+AUIy9dRiGNIhyuFZ0m5H/og3GMqtDi14Ql8
	ev7YoQEuCUBzc3vSMfx4B72140AqGxzcQjJN3kJo/UeGSn+P900A8QxjQ7RYFFLcI7lIwefPcEJ
	8gKVpi95E3bVAMlYX+EQ3n6AZ2r0/fKEDwNGTyJgFOYFmg5647fWtB9KoIBdNSy7m
X-Gm-Gg: ASbGncsB6AEodKSCkP34Lk3Zxey5Lk52xaQ+oThqG2RFDTlZflpBjW9PufINC+56O1e
	fIyBvr/BRVWKogtBMi55KMxT/+jcY2XuRVKdrDl/7AbC/vHNLF0Q3RwctEny5GRnlidDf5gHj7y
	Et95b0z7KwwxRkSBuQ3TPJdGJ0J2Pnq5ZWlg+D0ArerA/pgCZS3JndDIWFTTFpMfb2bzMCabVMz
	0WUGuAs1nkHBsgPS6CgIkhOqiW5eYgKFD69mFPUAs2EVWzSxxm/cFmsoli64d3FbcZJD1PXt15p
	2Tm33Q==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr14812806f8f.43.1744723171103;
        Tue, 15 Apr 2025 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3g59/gkleqCg6T/d47/qE3AgIRCAsXkZY+0Zs8YtzSwtO0Ld+xwTSwCyCTlke980a+IysoQ==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr14812768f8f.43.1744723170724;
        Tue, 15 Apr 2025 06:19:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206269c8sm217509515e9.16.2025.04.15.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:19:30 -0700 (PDT)
Date: Tue, 15 Apr 2025 09:19:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250415091917-mutt-send-email-mst@kernel.org>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250415074341.12461-2-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GkDKDECmLaGvZ3B7DsQzKG_nu4RkrjE0jxLbu5GEN0Y_1744723171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2025 at 02:43:39PM +0700, Bui Quang Minh wrote:
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi.  When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
> 
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 69 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..848fab51dfa1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3342,7 +3342,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> -static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> +static void __virtnet_rx_pause(struct virtnet_info *vi,
> +			       struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> @@ -3352,17 +3353,63 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	}
>  }
>  
> -static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> +static void virtnet_rx_pause_all(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		__virtnet_rx_pause(vi, &vi->rq[i]);
> +}
> +
> +static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> +{
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	__virtnet_rx_pause(vi, rq);
> +}
> +
> +static void __virtnet_rx_resume(struct virtnet_info *vi,
> +				struct receive_queue *rq,
> +				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
>  
> -	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	if (running)
>  		virtnet_napi_enable(rq);
>  }
>  
> +static void virtnet_rx_resume_all(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (i < vi->curr_queue_pairs)
> +			__virtnet_rx_resume(vi, &vi->rq[i], true);
> +		else
> +			__virtnet_rx_resume(vi, &vi->rq[i], false);
> +	}
> +}
> +
> +static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> +{
> +	enable_delayed_refill(vi);
> +	__virtnet_rx_resume(vi, rq, true);
> +}
> +
>  static int virtnet_rx_resize(struct virtnet_info *vi,
>  			     struct receive_queue *rq, u32 ring_num)
>  {
> @@ -5959,12 +6006,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (prog)
>  		bpf_prog_add(prog, vi->max_queue_pairs - 1);
>  
> +	virtnet_rx_pause_all(vi);
> +
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_disable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_disable(&vi->sq[i]);
> -		}
>  	}
>  
>  	if (!prog) {
> @@ -5996,13 +6043,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		vi->xdp_enabled = false;
>  	}
>  
> +	virtnet_rx_resume_all(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (old_prog)
>  			bpf_prog_put(old_prog);
> -		if (netif_running(dev)) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		if (netif_running(dev))
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  
>  	return 0;
> @@ -6014,11 +6060,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
>  	}
>  
> +	virtnet_rx_resume_all(vi);
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  	if (prog)
>  		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
> -- 
> 2.43.0

