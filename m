Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E9302CD5
	for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040059; cv=none; b=dyPm0A7ttrcvSVhXZ8JB6fEcjdTMMEwenim/rf51rhSunuV8vUtWakfM+xDQ/dCxafjiFqkML6HIktf/APIfhzDrF2uG7PnmHOp3op+hEm0BKTm4XEVWAXXHOOCpUop634XXQLRTk0uqD2MXZcZ1MX92otmeAUUqREjEKTmuWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040059; c=relaxed/simple;
	bh=GR3k999HC/wBwuDdQiVyvY8an+sH4jRx08ZnxkTnhTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aiIkr2Iodm2e6mF9SDiu5tlNYwgRBdj75ra/4my8okw1NQ5lL9rc0Y5gJysgr7Ssc4G4mXpxsKCEyxsZcB2dniB+ICFgqXejVfEUf2gHTGXl40c04y/1irVUqYYkOOVX08Yov9MwuHE8FM7MLlDXtY6/R+N7/4b4YVP7aw7Cogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL5xClzi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL5xClzi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768040057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
	b=gL5xClziAG9lNksl1hWzHMS19QBdTivcmBH8YXIO4fxJCQgtm1GdvmGgBLNhYUuIlotsRQ
	Xtw4RJqznksZoagfVCuyQEyJo5TlOeDUVXvmsBW16iGLRokdtSIJdBpA8ybiy4ojqtsz5t
	5Kx2J6Ewd05Z6Wm+diuayROmXfTWuVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-qeBHdG_lOTGaQY_1W6EpXg-1; Sat, 10 Jan 2026 05:14:15 -0500
X-MC-Unique: qeBHdG_lOTGaQY_1W6EpXg-1
X-Mimecast-MFC-AGG-ID: qeBHdG_lOTGaQY_1W6EpXg_1768040055
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so33510935e9.1
        for <virtualization@lists.linux.dev>; Sat, 10 Jan 2026 02:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768040054; x=1768644854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA+ZbEhpNNEZeZ/tio972zkgtuSqnUftWgoWPgE0LNo=;
        b=CthKEOcCJRny7sdkgvNPp+TJ6qPyLlTHu7YIaB6MrcunyFemngAiehPP25eHJLtrpb
         rmeGoyY1kw+xoGlGOPTuVteTfKICV8P3DI2ALGhI+L8QT+jx+mak4Qr0VZwHwoDmfZdD
         XeK64hGWXxSCf9r7MX+Y4/iPg9/Rpx2EuUQ0f6sL7fn+WV1Gz1zJpii1edXh2PUP+MTK
         uWRyyRkdH/Bmo189XLx8+tS/3m6QFpHzueRm/6pyi1QwpaI6jUXIE+av3Lm/MJe8zhwY
         /ccSrhVU+40S988wtO5Dl4zyilS40Vqb+bhgVlJugkZb/C7P7jZJAsjlQ7R3CHMyhSO6
         2s/w==
X-Forwarded-Encrypted: i=1; AJvYcCUr3R+OdHYHfXOTUb59PtUcQ7L9ajlOuG3zEAh6rb+5t7iYqDBIshnyZejvwqcCP4T0TpbA+D/YTM8wzywXgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWmpixV47XGRnlqwFFxb685se4mxYtsnDPydT5r4yr2mda2e0o
	dFPcKgwRrxX7AVv98bDVly9tetgSANk8Lh6oPKRnlc4RuAapLtJo1YgFsShIq76//EOe4OANXdH
	oxAkkMX6pavCvq1GC5bsksYAaj3+CJ1yWQnOvhqPjuEAGNPzbRtVqctTrd+fzbEzNDA2K
X-Gm-Gg: AY/fxX5pHXMhEDiDQL8FpPMoFMJ4E3Gz0qieN4UPCFxiYWoQ6AQyFNk8hvbTNqJjOeZ
	LAeq1kpaZcLS1u1gx8kU3TUkLT30wM9yPq2dCxtyDgPVkR0fP+4T0SZDJqziniCuzG1upfJwl+J
	gu8C1GvRYOkv5NasdHthiY43OOzi5d/MWt/Nnu3bnCOU+Rtq+dFl9KCEVc7LVqVpdaYumHslQNo
	01k56bIjmEIM73bh3lszUpTQjTf+9tb6hYe7H2bq1k8oESjOyMCe+KaDZ2pIkgCMU9PtpmtRaBJ
	bhl7xKY5g5Xk3G2H/sJqPm4Ru8kUoI34FqPpZlD9XXWlPHbvjfeHfWhCKz/5LLNZLA5VzrHUh1/
	ZypJE
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr144672775e9.30.1768040054555;
        Sat, 10 Jan 2026 02:14:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsvcWZT602v6D3Jk4OZpQRCrttnIFGdd1e0R1U9h/xIHk0Xd/hakt57g7VJk+sGDBWCw9vRw==
X-Received: by 2002:a05:600c:4fd4:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-47d84b3b687mr144672455e9.30.1768040054093;
        Sat, 10 Jan 2026 02:14:14 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f2:9400:32c:f78d:ab04:e7a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d87167832sm86921535e9.7.2026.01.10.02.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 02:14:13 -0800 (PST)
Date: Sat, 10 Jan 2026 05:14:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260110051335-mutt-send-email-mst@kernel.org>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
 <20260106150438.7425-2-minhquangbui99@gmail.com>
 <20260109181239.1c272f88@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260109181239.1c272f88@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4asLkgitm0-pH4-dpPyJSVl1gcQVNX8ydh1w_bm-La8_1768040055
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 06:12:39PM -0800, Jakub Kicinski wrote:
> On Tue,  6 Jan 2026 22:04:36 +0700 Bui Quang Minh wrote:
> > When we fail to refill the receive buffers, we schedule a delayed worker
> > to retry later. However, this worker creates some concurrency issues.
> > For example, when the worker runs concurrently with virtnet_xdp_set,
> > both need to temporarily disable queue's NAPI before enabling again.
> > Without proper synchronization, a deadlock can happen when
> > napi_disable() is called on an already disabled NAPI. That
> > napi_disable() call will be stuck and so will the subsequent
> > napi_enable() call.
> > 
> > To simplify the logic and avoid further problems, we will instead retry
> > refilling in the next NAPI poll.
> 
> Happy to see this go FWIW. If it causes issues we should consider
> adding some retry logic in the core (NAPI) rather than locally in
> the driver..
> 
> > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> 
> The Closes should probably point to Paolo's report. We'll wipe these CI
> logs sooner or later but the lore archive will stick around.
> 
> > @@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
> >  
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> >  		if (i < vi->curr_queue_pairs)
> > -			/* Make sure we have some buffers: if oom use wq. */
> > -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > -				schedule_delayed_work(&vi->refill, 0);
> > +			/* Pre-fill rq agressively, to make sure we are ready to
> > +			 * get packets immediately.
> > +			 */
> > +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
> We should enforce _some_ minimal fill level at the time of open().
> If the ring is completely empty no traffic will ever flow, right?
> Perhaps I missed scheduling the NAPI somewhere..

Practically, single page allocations with GFP_KERNEL don't
really fail. So I think it's fine.

> >  		err = virtnet_enable_queue_pair(vi, i);
> >  		if (err < 0)
> > @@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> >  				struct receive_queue *rq,
> >  				bool refill)
> >  {
> > -	bool running = netif_running(vi->dev);
> > -	bool schedule_refill = false;
> > +	if (netif_running(vi->dev)) {
> > +		/* Pre-fill rq agressively, to make sure we are ready to get
> > +		 * packets immediately.
> > +		 */
> > +		if (refill)
> > +			try_fill_recv(vi, rq, GFP_KERNEL);
> 
> Similar thing here? Tho not sure we can fail here..
> 
> > -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > -		schedule_refill = true;
> > -	if (running)
> >  		virtnet_napi_enable(rq);
> > -
> > -	if (schedule_refill)
> > -		schedule_delayed_work(&vi->refill, 0);
> > +	}
> >  }
> >  
> >  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > @@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >  	}
> >  succ:
> >  	vi->curr_queue_pairs = queue_pairs;
> > -	/* virtnet_open() will refill when device is going to up. */
> > -	spin_lock_bh(&vi->refill_lock);
> > -	if (dev->flags & IFF_UP && vi->refill_enabled)
> > -		schedule_delayed_work(&vi->refill, 0);
> > -	spin_unlock_bh(&vi->refill_lock);
> > +	if (dev->flags & IFF_UP) {
> > +		local_bh_disable();
> > +		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> > +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > +
> 
> nit: spurious new line
> 
> > +		local_bh_enable();
> > +	}
> >  
> >  	return 0;
> >  }

