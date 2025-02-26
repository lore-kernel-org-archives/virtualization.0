Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2D258CF9
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608007; cv=none; b=Dk+6OHswJSziEn+pJj8w8StNkp5nEdF5Lw0UDbjmdw4AQsFscdcE4B9tqi5y7hcMr0mUKLAsnZODbgjGPKrPYGqdD2vRnZSG6iicg8VAPWsjG86iqJJSWJs2DC8ztzaTa1Xv2p1AykBCwV29chrci+kZRJkIBVYMpA6CtMZYyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608007; c=relaxed/simple;
	bh=+AGXsd3l0/ZAahpV30MW18ZWS7qqDgJIIVxUnI5sp+M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bGO/aLMHDOfZ4Igrjm8390IAwXSvq7GBAZ0AdpIVMXS2JKTvlp0qltwiZ1VG3H/NNoEL9Qk5ZwMJe1eKxs15aX/tRx539bd8KYNGMNdxXaeCnahXF1tU78rfD+LZlVuZMlzo74b5Lo75mBkY6n7cgemzfxqtu34D3pcrGTeHjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InkERG0B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InkERG0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740608004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xoC6B7ot7I9gFHLsIIDATRwO00Yvhc2uVgVPoqjJGYQ=;
	b=InkERG0BT0jdHMLgYq3GZPoKhlcW1Zd4psxbtlAHGzp1WfACqZHBMCQ0s+wtyUkr2dPmjA
	BUKN47FI5sMQIX/cC0gFdJ5sARg8elfXa1aYeVNIq7BZlRWeNFxnWjCq73XTDVTKCh4HQP
	EVGXHRgBsqEEwDjWsQIGgCiA5Nvy10Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-QAbjFm1gNASnzBJv80WYgA-1; Wed, 26 Feb 2025 17:13:21 -0500
X-MC-Unique: QAbjFm1gNASnzBJv80WYgA-1
X-Mimecast-MFC-AGG-ID: QAbjFm1gNASnzBJv80WYgA_1740608000
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f44be93a8so96142f8f.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 14:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740608000; x=1741212800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoC6B7ot7I9gFHLsIIDATRwO00Yvhc2uVgVPoqjJGYQ=;
        b=Lqxuqzh2b/qlKRoM+GEpGyOgQeb4NMrwZosYvGUzCTLAMWI802dwhyjdvJOpfkqHP3
         Fi2983VUsguWyQ8uLo9SkfaN2q3ZEmwVA6KgKXU0jskcqtSSJphQf4wCt8xrNR+FUd/h
         UaNssXNvZ84grHu0uj8FaTyqMReTmZXzls6mhmX5GFjkS5+LWUNR7ul/mDS1AK0bmiXT
         GK29fammRkEE+Gz9hBZ+tnU15Fkkej3eLkWid6LUw8xgu280sJlXxugFNhRxNiryDDbA
         cmQyglw5IrivBLlHIZHYaeRkhiXtqXHzjy79EwzYhHGq2r7PhEFfzFm/Dfb12ZJ4VCR8
         RzFw==
X-Forwarded-Encrypted: i=1; AJvYcCWkDu4LUtQr7qQUTxiTcsOYvqwKYTrc/ZLGixD7X2wLsI1uS9ppxwcHUxZPGe1lA35+/l7fPJJfMZokhnTtCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW8yYn2ZdEf3/xHhMyXeRB+cQQwsLsNO/pifzNMGzsgSO6YoLM
	spt2+XuaO/AzauB+U5YcPriRVHNWatjzo56H7UtdXNGvV+46EOWogNUY4ixb3mTaidyqgLkRjJW
	Dz8Aau5jmmVSR6WmPb6zYTxhMBS7chk73GaQwoeTpW++qFiE9anXvcCdhnq3chQLG
X-Gm-Gg: ASbGncvkd/zLwCWv4UObWCNSSdEP9pfj5qvPamDA59sMqJ+rBy5Cf4AcqJWEcvc6B+7
	trf76nYNfdoRLb6b1xphDs6foaN9ihY6ZeG0WwUuC6s84/6FwVXwLiv5rj82yT5qvFzV70Qlclj
	9NT0It4aXjEO1yuFfZIhIIH5sGyKowyxuA7BpgwYgp4zdfyaPrikqj4RnZ9rWk9hJFWOLv+shoO
	MFGNjQr61Kgg5O+TbvLGjkn4gBsngggH2o+WQQB3Waq1bIlHwEV/9W07kV7PnH96HqllMea5Ni/
	LbY9iB4s/g==
X-Received: by 2002:a05:6000:1f88:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-390d4f429dfmr3953210f8f.32.1740608000161;
        Wed, 26 Feb 2025 14:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6UZscpycCohbgKUm67MTCc3ms1w0NUKbtY3TjrWejb4s65WjUp3KhFLNFf62YjJo396h7PQ==
X-Received: by 2002:a05:6000:1f88:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-390d4f429dfmr3953196f8f.32.1740607999757;
        Wed, 26 Feb 2025 14:13:19 -0800 (PST)
Received: from redhat.com ([2a02:14f:1eb:e270:8595:184c:7546:3597])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a28bd85sm2488945e9.36.2025.02.26.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:13:18 -0800 (PST)
Date: Wed, 26 Feb 2025 17:13:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Damato <jdamato@fastly.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Message-ID: <20250226171252-mutt-send-email-mst@kernel.org>
References: <20250225020455.212895-1-jdamato@fastly.com>
 <20250225020455.212895-4-jdamato@fastly.com>
 <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
 <Z79XXQjp9Dz7OYYQ@LQ3V64L9R2>
 <Z79YseiGrzYxoyvr@LQ3V64L9R2>
 <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z795Pt_RnfnvC-1N@LQ3V64L9R2>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ndfgYSmn2iOAyswcs7UpOoGU8G8GOR0yjAP_JfW1nyg_1740608000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 26, 2025 at 03:27:42PM -0500, Joe Damato wrote:
> On Wed, Feb 26, 2025 at 01:08:49PM -0500, Joe Damato wrote:
> > On Wed, Feb 26, 2025 at 01:03:09PM -0500, Joe Damato wrote:
> > > On Wed, Feb 26, 2025 at 01:48:50PM +0800, Jason Wang wrote:
> > > > On Tue, Feb 25, 2025 at 10:05 AM Joe Damato <jdamato@fastly.com> wrote:
> > > > >
> > > > > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > > > > can be accessed by user apps, taking care to hold RTNL as needed.
> > > > 
> > > > I may miss something but I wonder whether letting the caller hold the
> > > > lock is better.
> > > 
> > > Hmm...
> > > 
> > > Double checking all the paths over again, here's what I see:
> > >   - refill_work, delayed work that needs RTNL so this change seems
> > >     right?
> > > 
> > >   - virtnet_disable_queue_pair, called from virtnet_open and
> > >     virtnet_close. When called via NDO these are safe and hold RTNL,
> > >     but they can be called from power management and need RTNL.
> > > 
> > >   - virtnet_enable_queue_pair called from virtnet_open, safe when
> > >     used via NDO but needs RTNL when used via power management.
> > > 
> > >   - virtnet_rx_pause called in both paths as you mentioned, one
> > >     which needs RTNL and one which doesn't.
> > 
> > Sorry, I missed more paths:
> > 
> >     - virtnet_rx_resume
> >     - virtnet_tx_pause and virtnet_tx_resume
> > 
> > which are similar to path you mentioned (virtnet_rx_pause) and need
> > rtnl in one of two different paths.
> > 
> > Let me know if I missed any paths and what your preferred way to fix
> > this would be?
> > 
> > I think both options below are possible and I have no strong
> > preference.
> 
> OK, my apologies. I read your message and the code wrong. Sorry for
> the back-to-back emails from me.
> 
> Please ignore my message above... I think after re-reading the code,
> here's where I've arrived:
> 
>   - refill_work needs to hold RTNL (as in the existing patch)
> 
>   - virtnet_rx_pause, virtnet_rx_resume, virtnet_tx_pause,
>     virtnet_tx_resume -- all do NOT need to hold RTNL because it is
>     already held in the ethtool resize path and the XSK path, as you
>     explained, but I mis-read (sorry).
> 
>   - virtnet_disable_queue_pair and virtnet_enable_queue_pair both
>     need to hold RTNL only when called via power management, but not
>     when called via ndo_open or ndo_close
> 
> Is my understanding correct and does it match your understanding?
> 
> If so, that means there are two issues:
> 
>   1. Fixing the hardcoded bools in rx_pause, rx_resume, tx_pause,
>      tx_resume (all should be false, RTNL is not needed).
> 
>   2. Handling the power management case which calls virtnet_open and
>      virtnet_close.
> 
> I made a small diff included below as an example of a possible
> solution:
> 
>   1. Modify virtnet_disable_queue_pair and virtnet_enable_queue_pair
>      to take a "bool need_rtnl" and pass it through to the helpers
>      they call.
> 
>   2. Create two helpers, virtnet_do_open and virt_do_close both of
>      which take struct net_device *dev, bool need_rtnl. virtnet_open
>      and virtnet_close are modified to call the helpers and pass
>      false for need_rtnl. The power management paths call the
>      helpers and pass true for need_rtnl. (fixes issue 2 above)
> 
>   3. Fix the bools for rx_pause, rx_resume, tx_pause, tx_resume to
>      pass false since all paths that I could find that lead to these
>      functions hold RTNL. (fixes issue 1 above)
> 
> See the diff below (which can be applied on top of patch 3) to see
> what it looks like.
> 
> If you are OK with this approach, I will send a v5 where patch 3
> includes the changes shown in this diff.
> 
> Please let me know what you think:



Looks ok I think.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 13bb4a563073..76ecb8f3ce9a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3098,14 +3098,16 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> -static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index,
> +				       bool need_rtnl)
>  {
> -	virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> -	virtnet_napi_disable(&vi->rq[qp_index], false);
> +	virtnet_napi_tx_disable(&vi->sq[qp_index], need_rtnl);
> +	virtnet_napi_disable(&vi->rq[qp_index], need_rtnl);
>  	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
>  
> -static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index,
> +				     bool need_rtnl)
>  {
>  	struct net_device *dev = vi->dev;
>  	int err;
> @@ -3120,8 +3122,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	if (err < 0)
>  		goto err_xdp_reg_mem_model;
>  
> -	virtnet_napi_enable(&vi->rq[qp_index], false);
> -	virtnet_napi_tx_enable(&vi->sq[qp_index], false);
> +	virtnet_napi_enable(&vi->rq[qp_index], need_rtnl);
> +	virtnet_napi_tx_enable(&vi->sq[qp_index], need_rtnl);
>  
>  	return 0;
>  
> @@ -3156,7 +3158,7 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>  		vi->duplex = duplex;
>  }
>  
> -static int virtnet_open(struct net_device *dev)
> +static int virtnet_do_open(struct net_device *dev, bool need_rtnl)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
> @@ -3169,7 +3171,7 @@ static int virtnet_open(struct net_device *dev)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>  				schedule_delayed_work(&vi->refill, 0);
>  
> -		err = virtnet_enable_queue_pair(vi, i);
> +		err = virtnet_enable_queue_pair(vi, i, need_rtnl);
>  		if (err < 0)
>  			goto err_enable_qp;
>  	}
> @@ -3190,13 +3192,18 @@ static int virtnet_open(struct net_device *dev)
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	for (i--; i >= 0; i--) {
> -		virtnet_disable_queue_pair(vi, i);
> +		virtnet_disable_queue_pair(vi, i, need_rtnl);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
>  	return err;
>  }
>  
> +static int virtnet_open(struct net_device *dev)
> +{
> +	return virtnet_do_open(dev, false);
> +}
> +
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  {
>  	struct send_queue *sq = container_of(napi, struct send_queue, napi);
> @@ -3373,7 +3380,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	bool running = netif_running(vi->dev);
>  
>  	if (running) {
> -		virtnet_napi_disable(rq, true);
> +		virtnet_napi_disable(rq, false);
>  		virtnet_cancel_dim(vi, &rq->dim);
>  	}
>  }
> @@ -3386,7 +3393,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	if (running)
> -		virtnet_napi_enable(rq, true);
> +		virtnet_napi_enable(rq, false);
>  }
>  
>  static int virtnet_rx_resize(struct virtnet_info *vi,
> @@ -3415,7 +3422,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
>  	qindex = sq - vi->sq;
>  
>  	if (running)
> -		virtnet_napi_tx_disable(sq, true);
> +		virtnet_napi_tx_disable(sq, false);
>  
>  	txq = netdev_get_tx_queue(vi->dev, qindex);
>  
> @@ -3449,7 +3456,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
>  	__netif_tx_unlock_bh(txq);
>  
>  	if (running)
> -		virtnet_napi_tx_enable(sq, true);
> +		virtnet_napi_tx_enable(sq, false);
>  }
>  
>  static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
> @@ -3708,7 +3715,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	return 0;
>  }
>  
> -static int virtnet_close(struct net_device *dev)
> +static int virtnet_do_close(struct net_device *dev, bool need_rtnl)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
> @@ -3727,7 +3734,7 @@ static int virtnet_close(struct net_device *dev)
>  	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		virtnet_disable_queue_pair(vi, i);
> +		virtnet_disable_queue_pair(vi, i, need_rtnl);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
> @@ -3736,6 +3743,11 @@ static int virtnet_close(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int virtnet_close(struct net_device *dev)
> +{
> +	return virtnet_do_close(dev, false);
> +}
> +
>  static void virtnet_rx_mode_work(struct work_struct *work)
>  {
>  	struct virtnet_info *vi =
> @@ -5682,7 +5694,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
>  	if (netif_running(vi->dev))
> -		virtnet_close(vi->dev);
> +		virtnet_do_close(vi->dev, true);
>  }
>  
>  static int init_vqs(struct virtnet_info *vi);
> @@ -5702,7 +5714,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  	enable_rx_mode_work(vi);
>  
>  	if (netif_running(vi->dev)) {
> -		err = virtnet_open(vi->dev);
> +		err = virtnet_do_open(vi->dev, false);
>  		if (err)
>  			return err;
>  	}

