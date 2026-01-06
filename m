Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735829BD91
	for <virtualization@lists.linux.dev>; Tue,  6 Jan 2026 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713355; cv=none; b=VWpFhmdrZlO3y5xYAPb/1H6KnnpOGWovWDOsp6gyTlcEg1wyTkypK8n0aYACaHczBstSIpaqvvsqakPWvUjPR47YAo8uoLVVCwQiVWqOnam/iuSksLtJgn7WrsX4XTy4gofFpHG8RX7dTG3HmgJWRZlNtfQ+z/45XsP4gCuzeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713355; c=relaxed/simple;
	bh=ORBUTAza06yVYLn8Gg5h7JdLV16kPZGZnkfL1uLRIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n2zoEnUlULYVeju7EIEIJuI1EwVssaJaOBsEI+y6zZbvnPKOwQUDqBz3HEi2GmDfH9FitZA7qCp8DsJdbM1/NRUzIJQNSvJfwPMnDXymBz2/EDHbSwmxuYP1UgloJIYilx3pZSzHr5KCzSDDMDH4mCA698PSrt3e9EIcqgHGZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2yrldDq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2yrldDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767713352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
	b=a2yrldDqBs69zbkz3iUaSTBqaGGB5t44t3qZtUhpLz29YrJ/roSt1mtE3ojdUQgryx+Chj
	BO0CWHhSOfgCATLIAUXlI9KVlahGrmZgzk7cWjIzOzE1od3Qlewrxah6ILoCfKxwd6rTeL
	HFeTHs8DrZaff9+5PJ68bZmloFJIHuA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-BrsQa1jsM8yEJ9tx9M7iOQ-1; Tue, 06 Jan 2026 10:29:11 -0500
X-MC-Unique: BrsQa1jsM8yEJ9tx9M7iOQ-1
X-Mimecast-MFC-AGG-ID: BrsQa1jsM8yEJ9tx9M7iOQ_1767713350
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8395cae8c8so123300366b.3
        for <virtualization@lists.linux.dev>; Tue, 06 Jan 2026 07:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713350; x=1768318150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mutPiJahqf07tX0K9jDs+Vqe+Q2f0S7Ia0chn9JrkM=;
        b=sW7ZdyQHRpoL/VsXpJoXrMaEQ5WvFTD7bMtNz46gvDh3HVqKpiR+5o3ws1frmHFHEm
         9qiirp0i3Rdl0dWXgbQECZQQaILJhHP8aeQVTAXv8/V1TDKKdzNhxSFsyzgyzO39UDZj
         XzXqteHGLS8Pjnzc+6N3phyLi/rp1abqTMNglXT6ghKQJfi3pwOA9f7ocwcm2jwHa7Cm
         3hplREGCRUfhOMNrqS/XX7Qw0b0sJcLdAWa4uSoZanRTU+djsSIlRDVyHzuNmmn7lwYc
         5yG+YRf3xaD+YbRawHOitZhWHap9Z6Tzb2EfvgIg3fsTKkliBlviDweeRmO0TFBOhu6T
         QVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoEIudVo3y+79N6LwxY0mC1UOQRioaiQ0wvO0E+7AqqLoJkTbfRco0NwykmyAh0qRldB4Dg9oXCehQ6s4LAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWZUWhff8BnuA1pg6iQUTTDqpoT6ID2nHfgpd0NmwjlerPv0Sw
	xSZ3tU599Jezz0HQwkN5DhIamwO08yV1i9ElZEjFgVE4L9M3jHfXQnXemh/190H72NI7ZFbVCuB
	P5Ht3f7LVnzpUnV2SqpbSoH05hBhX2Bp3XoinY9kSV6EQk5QgmT6pXmCgzJA4UIMUGahp
X-Gm-Gg: AY/fxX5FyeA4pcn/uzayYe76qy6mUukOtF2cr94DMDda0Ihs6Vw1J7trh22ea3QM25D
	0J/So+SAZS8f6Bas2jUDBMC+dv8p/b524cWSigd9yYspuBXtuFlWvRqRYRF6zrO3qqIwAV+V2Do
	rwxO9Tn6uLQ0E4D4wbkBraT7oAOqldLIu/NaL6NaMarQtlmxz/fm/jQTRQkFrW9p8fU8PA3ml4T
	4mPpn775/qh8h8MvF0IsXQYTsHLPBl9qV6r+MLeoIRF0YIGTMgruAdphMAoe6seusYHLT9eakpn
	nF/3hP26Ryp2xGnAT+rHiVGRHW9GLM/09xiMalP0AubiQx2twIgxTJQRtO8s3XZpdBEUCfGcDbl
	uyCX/RMSzJOfpk2QESrJvvpXjvQaiWNiJaQ==
X-Received: by 2002:a17:907:97c7:b0:b80:11fd:793b with SMTP id a640c23a62f3a-b8426a6849bmr317261666b.19.1767713349829;
        Tue, 06 Jan 2026 07:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWb6y9xsvseC+MSQM10NdjJ3BS0aRkbGgQvy+bzZrBc9IB4ICJIxfQsaMFe9coDqIqquWjJA==
X-Received: by 2002:a17:907:97c7:b0:b80:11fd:793b with SMTP id a640c23a62f3a-b8426a6849bmr317258866b.19.1767713349329;
        Tue, 06 Jan 2026 07:29:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c760sm261977866b.24.2026.01.06.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:29:08 -0800 (PST)
Date: Tue, 6 Jan 2026 10:29:05 -0500
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
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260106100959-mutt-send-email-mst@kernel.org>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260106150438.7425-2-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U6w8HaxmrMRgfw_YJpYxxOT2uQn23j0uklxhN2cfvec_1767713350
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 10:04:36PM +0700, Bui Quang Minh wrote:
> When we fail to refill the receive buffers, we schedule a delayed worker
> to retry later. However, this worker creates some concurrency issues.
> For example, when the worker runs concurrently with virtnet_xdp_set,
> both need to temporarily disable queue's NAPI before enabling again.
> Without proper synchronization, a deadlock can happen when
> napi_disable() is called on an already disabled NAPI. That
> napi_disable() call will be stuck and so will the subsequent
> napi_enable() call.
> 
> To simplify the logic and avoid further problems, we will instead retry
> refilling in the next NAPI poll.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Cc: stable@vger.kernel.org
> Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and CC stable I think. Can you do that pls?

> ---
>  drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..f986abf0c236 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	else
>  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>  
> +	u64_stats_set(&stats.packets, packets);
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -			spin_lock(&vi->refill_lock);
> -			if (vi->refill_enabled)
> -				schedule_delayed_work(&vi->refill, 0);
> -			spin_unlock(&vi->refill_lock);
> -		}
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +			/* We need to retry refilling in the next NAPI poll so
> +			 * we must return budget to make sure the NAPI is
> +			 * repolled.
> +			 */
> +			packets = budget;
>  	}
>  
> -	u64_stats_set(&stats.packets, packets);
>  	u64_stats_update_begin(&rq->stats.syncp);
>  	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
>  		size_t offset = virtnet_rq_stats_desc[i].offset;
> @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> +			/* Pre-fill rq agressively, to make sure we are ready to
> +			 * get packets immediately.
> +			 */
> +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
> @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				struct receive_queue *rq,
>  				bool refill)
>  {
> -	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
> +	if (netif_running(vi->dev)) {
> +		/* Pre-fill rq agressively, to make sure we are ready to get
> +		 * packets immediately.
> +		 */
> +		if (refill)
> +			try_fill_recv(vi, rq, GFP_KERNEL);
>  
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> -	if (running)
>  		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> +	}
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	}
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
> -	/* virtnet_open() will refill when device is going to up. */
> -	spin_lock_bh(&vi->refill_lock);
> -	if (dev->flags & IFF_UP && vi->refill_enabled)
> -		schedule_delayed_work(&vi->refill, 0);
> -	spin_unlock_bh(&vi->refill_lock);
> +	if (dev->flags & IFF_UP) {
> +		local_bh_disable();
> +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> +
> +		local_bh_enable();
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0

