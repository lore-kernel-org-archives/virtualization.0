Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54F319858
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113062; cv=none; b=psQ7tZksD2M2jOhPCW0n1VFExFIrr8EeKecB1G/DkUdkes3GaKBwRrXggnf2bG9FX2ojP+dC/pdaQvyEB5hRVk1GQ/Iz3c3PlRpUc8eLTQ8a1G/rrOD2iowzMAZGA2NM21Qe64u2/4QzESKCtoJVqRkqcf16naUWRRl2NQnC0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113062; c=relaxed/simple;
	bh=q7NyvwLa9sicZtWBXMJxS7E+6FRDA40em7tVFCO+yco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LZEJ8Cer7/vGF0XbN+pKc2mQVS89DoiwtdJgY0B7ymdXx6RvgcbuyoujVqbFz97+NZea7pr9ayVnNK4vQU0j+Guv/NMgS/j80A6S14vxPqU3CatC5JacekO+Sv6MBtpuqiHYuAa0aW84s8D4cn0MMTeYCmd8KULMWSFp63YShz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3Fq6lQb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3Fq6lQb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767113060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
	b=V3Fq6lQbhYM/PeYM4uO9bzG+TYrii+JCCyab/QrUM7AvEPgSuAgpAkNhieELa5zXw0LkOY
	rzQFipIN5gNZSmUJpVoro/SGEcti+WkdMvkMFgMSGfjkktJduEgZET7GFWRSj1RXsGG1K/
	HQaWyiV7z9ahKEoJItePuDXha4w7B8o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-7NwPqIiMNh-62pcHj7xjMw-1; Tue, 30 Dec 2025 11:44:17 -0500
X-MC-Unique: 7NwPqIiMNh-62pcHj7xjMw-1
X-Mimecast-MFC-AGG-ID: 7NwPqIiMNh-62pcHj7xjMw_1767113055
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so80258275e9.2
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 08:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767113055; x=1767717855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
        b=SdMsKXwAu6UOZnNNzhbfCsq0ZYnFcyYhSAKr3xo6GznBhMwpiOLSsgTsJzN8o68N1o
         PaEK47vIRqdzXUuAzMmeuMxvrOJvgNjpA46VvlCkzEBDKGZTcBraEj15furAI/MlJgNX
         t7nDh29rY2Qu38eBqU5l/PxwXVWw8CKScw8ts6sDtETc0pSkNs8teVcYCJZQMp7V/JFv
         qRFkefWWY2DQBWaR1rvkD+ggg+RXtmiQaAa0z+wVdGpPUaFOz+kpM1JMBvVrYB0WML6f
         vN/u+FqDzG4jDsspcXLBXQnMYsvqgIg8OUgy56Vikq/X4H4S+hk2LpE5kQya6/f39346
         pEfg==
X-Forwarded-Encrypted: i=1; AJvYcCWPE5Fz7SGlNh5T2DjupiB6L6/9e6Ngk1a+O4NDL2Oi6QEjGpOMRNJZa6XVUKMwaRi8xWRsuE/3cDdNJtZw6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqTPmCULsT03hSqPZjNzyK2OFhmbh42SqZm/BkDGE4DqVKZ//e
	XKkqTOWdWbzQYtocP3UD3SvIAA2uf31yHsFSB7f9LpGjHXRjIf2k2dbVDFPY1uhpNmQvJ9lWJhx
	0ZWbAhBWM1IqNzecCuJjh3xfMzvXm5WsMT6JV2b40dhxlXW2zCi2NYbLW30uCS5sXyjZb
X-Gm-Gg: AY/fxX6/0ljKqCo7dbTWJOXjyP8gSTenOh/Bn3/Qwip1TmPQuK8PzIQol8tieEOo944
	unSd+bzh8VjLNVatw3q9uV5jx2ITjZGzsY7+ePoyn2NOkuUNBfndCQba8IvZPSPVgZvIa/v8pRu
	kittrSpk8bCB0ecnSax78ycnuJP6kGzO9v8nQfW7TwFUhjE8pQlITCt7IecLUiDwHmPXh6JgTMS
	M0IwXnI+TvR6wAnE1tRW7CyfJlHaNrfngB+qM0j0/EEGKmSEmP/wd1lxybGvA2wvEnaXkN3Cj/x
	4veicOhDuvLaZ9oEYiru6wSZ6m+Hc2D/bHdhBFD2nEs8We17cAzhPfG2N2QhqSXgy5zSUAYdU9t
	VZhxiVU197FyTRF16pU3xfA7feaJ5QrI9Dg==
X-Received: by 2002:a05:600d:102:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d197fa272mr258316425e9.0.1767113054545;
        Tue, 30 Dec 2025 08:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExM9stLawDuC2XzpEaGqqSH1Qt3OQeeOH56cPRU+M9oRh04T9pEzHr6R7usT5ampfEyN0iTQ==
X-Received: by 2002:a05:600d:102:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d197fa272mr258316135e9.0.1767113054022;
        Tue, 30 Dec 2025 08:44:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm596270045e9.0.2025.12.30.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:44:13 -0800 (PST)
Date: Tue, 30 Dec 2025 11:44:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
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
Message-ID: <20251230114250-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
 <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E-KCpAgh0mz40ZH_HhClGnCbapCymAO16A11FG3FXIo_1767113055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Dec 30, 2025 at 11:28:50PM +0700, Bui Quang Minh wrote:
> On 12/26/25 14:37, Michael S. Tsirkin wrote:
> > On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> > > On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > > > On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > > > > Hi Jason,
> > > > > > > 
> > > > > > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > > > > > the refill on its next run if the refill fails? That would seem much simpler.
> > > > > > > This refill work complicates maintenance and often introduces a lot of
> > > > > > > concurrency issues and races.
> > > > > > > 
> > > > > > > Thanks.
> > > > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > > > > 
> > > > > > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> > > > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > > > mlx5e_napi_poll() did:
> > > > > 
> > > > > busy |= INDIRECT_CALL_2(rq->post_wqes,
> > > > >                                  mlx5e_post_rx_mpwqes,
> > > > >                                  mlx5e_post_rx_wqes,
> > > > > 
> > > > > ...
> > > > > 
> > > > > if (busy) {
> > > > >           if (likely(mlx5e_channel_no_affinity_change(c))) {
> > > > >                  work_done = budget;
> > > > >                  goto out;
> > > > > ...
> > > > 
> > > > is busy a GFP_ATOMIC allocation failure?
> > > Yes, and I think the logic here is to fallback to ksoftirqd if the
> > > allocation fails too much.
> > > 
> > > Thanks
> > 
> > True. I just don't know if this works better or worse than the
> > current design, but it is certainly simpler and we never actually
> > worried about the performance of the current one.
> > 
> > 
> > So you know, let's roll with this approach.
> > 
> > I do however ask that some testing is done on the patch forcing these OOM
> > situations just to see if we are missing something obvious.
> > 
> > 
> > the beauty is the patch can be very small:
> > 1. patch 1 do not schedule refill ever, just retrigger napi
> > 2. remove all the now dead code
> > 
> > this way patch 1 will be small and backportable to stable.
> 
> I've tried 1. with this patch
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..9e890aff2d95 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  }
> 
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -               unsigned int *xdp_xmit)
> +               unsigned int *xdp_xmit, bool *retry_refill)
>  {
>      struct virtnet_info *vi = rq->vq->vdev->priv;
>      struct virtnet_rq_stats stats = {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>          packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> 
>      if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -            spin_lock(&vi->refill_lock);
> -            if (vi->refill_enabled)
> -                schedule_delayed_work(&vi->refill, 0);
> -            spin_unlock(&vi->refill_lock);
> -        }
> +        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +            *retry_refill = true;
>      }
> 
>      u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>      struct send_queue *sq;
>      unsigned int received;
>      unsigned int xdp_xmit = 0;
> -    bool napi_complete;
> +    bool napi_complete, retry_refill = false;
> 
>      virtnet_poll_cleantx(rq, budget);
> 
> -    received = virtnet_receive(rq, budget, &xdp_xmit);
> +    received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>      rq->packets_in_napi += received;
> 
>      if (xdp_xmit & VIRTIO_XDP_REDIR)
>          xdp_do_flush();
> 
>      /* Out of packets? */
> -    if (received < budget) {
> +    if (received < budget && !retry_refill) {
>          napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>          /* Intentionally not taking dim_lock here. This may result in a
>           * spurious net_dim call. But if that happens virtnet_rx_dim_work
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> 
>      for (i = 0; i < vi->max_queue_pairs; i++) {
>          if (i < vi->curr_queue_pairs)
> -            /* Make sure we have some buffers: if oom use wq. */
> -            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                schedule_delayed_work(&vi->refill, 0);
> +            /* If this fails, we will retry later in
> +             * NAPI poll, which is scheduled in the below
> +             * virtnet_enable_queue_pair
> +             */
> +            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
>          err = virtnet_enable_queue_pair(vi, i);
>          if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>                  bool refill)
>  {
>      bool running = netif_running(vi->dev);
> -    bool schedule_refill = false;
> 
> -    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -        schedule_refill = true;
> +    if (refill)
> +        /* If this fails, we will retry later in NAPI poll, which is
> +         * scheduled in the below virtnet_napi_enable
> +         */
> +        try_fill_recv(vi, rq, GFP_KERNEL);
> +
>      if (running)
>          virtnet_napi_enable(rq);
> -
> -    if (schedule_refill)
> -        schedule_delayed_work(&vi->refill, 0);
>  }
> 
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>      struct virtio_net_rss_config_trailer old_rss_trailer;
>      struct net_device *dev = vi->dev;
>      struct scatterlist sg;
> +    int i;
> 
>      if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>          return 0;
> @@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>      }
>  succ:
>      vi->curr_queue_pairs = queue_pairs;
> -    /* virtnet_open() will refill when device is going to up. */
> -    spin_lock_bh(&vi->refill_lock);
> -    if (dev->flags & IFF_UP && vi->refill_enabled)
> -        schedule_delayed_work(&vi->refill, 0);
> -    spin_unlock_bh(&vi->refill_lock);
> +    for (i = 0; i < vi->curr_queue_pairs; i++)
> +        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
>      return 0;
>  }
> 
> 
> But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
> test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
> the fill ring. So xsk_pool does not have any descriptors and
> try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
> we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,
> 
> virtnet_xsk_pool_disable
> -> virtnet_rq_bind_xsk_pool
>   -> virtnet_rx_pause
>     -> __virtnet_rx_pause
>       -> virtnet_napi_disable
>         -> napi_disable
> 
> We get stuck in napi_disable because the RX NAPI is still polling.
> 
> In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
> synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
> (mlx5e_napi_poll) without using napi_disable/enable. However, in
> drivers/net/ethernet/intel/ice,
> 
> ice_xsk_pool_setup
> -> ice_qp_dis
>   -> ice_qvec_toggle_napi
>     -> napi_disable
> 
> it still uses napi_disable. Did I miss something in the above patch?
> I'll try to look into using another synchronization instead of
> napi_disable/enable in xsk_pool setup path too.
> 
> Thanks,
> Quang Minh.


... and the simplicity is out of the window. Up to you but maybe
it is easier to keep plugging the holes in the current approach.
It has been in the field for a very long time now, at least.

-- 
MST

