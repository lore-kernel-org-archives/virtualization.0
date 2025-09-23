Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD65328591
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645401; cv=none; b=kzbe1Z+W7X8ha5NTLVAAtu6YeuIsEk23LFmxdezDsotB2dr4jYFZBFZOmABwof0LVnzLJH6O/x3l/zkXbilmCVXMGJnXUnfcD1bsQdEcwKV8vLfnh+9zG/kcC626oGvaqILsv6Y98gVZ83T2kjW8MEr/Q2ATak3mgRYAaqEWL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645401; c=relaxed/simple;
	bh=WRbvQlH5wzDRTJnGfw2q29Hf/ZHyrfDOIIYTdpuj9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bBXNXa4SKtluc00ZD7MnpMDiZ72lPS853ohE5B5J17921YGg39UdldQy/04pWgaWTZZxZJXGArrXviTmxHV65GGnnRruiNTtBtoc09EsoE9zvcQOVQziKu01H6JTwnT1b6OI17mNt/tpzUsUxN2IpaoqlxtY6Ps4HNLX7LUZn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjhGfuWc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjhGfuWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758645398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4zPpYQN6ZewmJa/VE3YRRkMpzAS6jQaLK0K7KotGZpQ=;
	b=DjhGfuWcqhSUMsXJfKakOmW7E385oRXULaf597tNBB3S21dDN9dkLNca1aL7hh7G4cttaE
	4aiGRgH1Y8mGaFkw43fYwFW2goPc2M4r8TmFX5zR27/BSuhlDomuI1ebQ6vzDQQE5gGU2v
	PMJgZpKqkMwGPlHHDDpCY8cVLA53PLM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-TUPX6X_vP-aiU-xzV_AUGA-1; Tue, 23 Sep 2025 12:36:35 -0400
X-MC-Unique: TUPX6X_vP-aiU-xzV_AUGA-1
X-Mimecast-MFC-AGG-ID: TUPX6X_vP-aiU-xzV_AUGA_1758645394
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eff3936180so1513747f8f.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 09:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645394; x=1759250194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zPpYQN6ZewmJa/VE3YRRkMpzAS6jQaLK0K7KotGZpQ=;
        b=pSqbE8q1A0sPu1tebTiRaNdXadEUSrPL9yrv5lBk+sduPRZZ/66u0fvAVUPcO7cdUZ
         kEFG0dFBoyyC57dbgv5M6qcBGqebdJSjDG8t2rwdWzdwxVmCcB1sMPi8EsRfOl0ZcHsC
         JbOogzng1q17hnMZtCuB4iAxKftB2Ss12TihuTjHZUMy50GwLy1smXyEOnwo3vVZZpIH
         S80iH9k0dtT+iBY0Dnyj9XJ9iF2rMlnyRZVQPGnjbIA+Vf27QgILWhTkVpCXkAzGXjxU
         celIF1muLiNeKcniw04d8a+5Tra6ZMFm8/kWOOOG16zjjUQ+qta5GsSeLXhrRQ9V6ETC
         9mSg==
X-Forwarded-Encrypted: i=1; AJvYcCU0NsPS5sCSUKvu1YQfIx5n8/PKFq1IbGH2QRgbAS3ZH5E2yvF3KuZyJVJiZCGbd84S29reMmislK4yWTAs2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTtWdFO2CFsbC7jpjyL1NL4Ia76srFT3XQW16NdbSZpNfk4Kyq
	egEl7ZNpOJGWLTSVHxgLL6wT04Sc3Yk3IpY8H6ALdhVKXcS5xHcPom/HwPlZITVmtG/wqLnKcGp
	R2kXn1RH5xeZpQKB1m7I+kNuwiFcO+F9e51b3Hw8pu5a5bFEmlyHT8npE1SyPcalCQSIq
X-Gm-Gg: ASbGncvQpgn3ec8Ix8ZVQf7J8wu3lVrE6FI0M8kk78QhsDF2wd3t9NtpQnZHIN0u5Pv
	8MboN2N9tOQOLnaKbybVV9NZQYrCIYiCj6aYfUZLFgbKHp7cuISg8jgDU9LR3MIKDW4st3gCuML
	JIAqwKDW9nFzVEzlfiU5d9mrHm43sgvYUq5DcykT21KgCOsmbyWZt0qDXeo0qWsBmsNv/8Lljz6
	bY800UEH9bVYFeeAqoR67UuOgn2UT88DJbAzb/NCte6beFxtJ9n7BM8Rl52SICf2DnyhUrPmcr0
	rYEw8NOIlaitT3AqjQN1CdhmNx/8Q/XzWG8=
X-Received: by 2002:a05:6000:1a87:b0:3ff:f55b:274a with SMTP id ffacd0b85a97d-405cb6c6b56mr2974008f8f.43.1758645393689;
        Tue, 23 Sep 2025 09:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOZ04vpd4BJvD9C2hR3DHmCmGT6e5v2KZ+8ep2PmkrMv09043lQZ0v8NtS5c34X1dkjLA54g==
X-Received: by 2002:a05:6000:1a87:b0:3ff:f55b:274a with SMTP id ffacd0b85a97d-405cb6c6b56mr2973978f8f.43.1758645393257;
        Tue, 23 Sep 2025 09:36:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm288273635e9.22.2025.09.23.09.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:36:32 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:36:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250923123101-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7LRriTFy23i_OeCq3EAXcIs9J-cgfKnB4SosEPGKIfg_1758645394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 12:15:49AM +0200, Simon Schippers wrote:
> The new wrappers tun_ring_consume/tap_ring_consume deal with consuming an
> entry of the ptr_ring and then waking the netdev queue when entries got
> invalidated to be used again by the producer.
> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> if the netdev queue is stopped before invalidating entries. Like that the
> netdev queue can be safely woken after invalidating entries.
> 
> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> __ptr_ring_produce within tun_net_xmit guarantees that the information
> about the netdev queue being stopped is visible after __ptr_ring_peek is
> called.
> 
> The netdev queue is also woken after resizing the ptr_ring.
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tap.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/net/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 1197f245e873..f8292721a9d6 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -753,6 +753,46 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	return ret ? ret : total;
>  }
>  
> +static struct sk_buff *tap_ring_consume(struct tap_queue *q)
> +{
> +	struct netdev_queue *txq;
> +	struct net_device *dev;
> +	bool will_invalidate;
> +	bool stopped;
> +	void *ptr;
> +
> +	spin_lock(&q->ring.consumer_lock);
> +	ptr = __ptr_ring_peek(&q->ring);
> +	if (!ptr) {
> +		spin_unlock(&q->ring.consumer_lock);
> +		return ptr;
> +	}
> +
> +	/* Check if the queue stopped before zeroing out, so no ptr get
> +	 * produced in the meantime, because this could result in waking
> +	 * even though the ptr_ring is full.

So what? Maybe it would be a bit suboptimal? But with your design, I do
not get what prevents this:


	stopped? -> No
		ring is stopped
	discard

and queue stays stopped forever


> The order of the operations
> +	 * is ensured by barrier().
> +	 */
> +	will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> +	if (unlikely(will_invalidate)) {
> +		rcu_read_lock();
> +		dev = rcu_dereference(q->tap)->dev;
> +		txq = netdev_get_tx_queue(dev, q->queue_index);
> +		stopped = netif_tx_queue_stopped(txq);
> +	}
> +	barrier();
> +	__ptr_ring_discard_one(&q->ring, will_invalidate);
> +
> +	if (unlikely(will_invalidate)) {
> +		if (stopped)
> +			netif_tx_wake_queue(txq);
> +		rcu_read_unlock();
> +	}


After an entry is consumed, you can detect this by checking

	                r->consumer_head >= r->consumer_tail


so it seems you could keep calling regular ptr_ring_consume
and check afterwards?




> +	spin_unlock(&q->ring.consumer_lock);
> +
> +	return ptr;
> +}
> +
>  static ssize_t tap_do_read(struct tap_queue *q,
>  			   struct iov_iter *to,
>  			   int noblock, struct sk_buff *skb)
> @@ -774,7 +814,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
>  					TASK_INTERRUPTIBLE);
>  
>  		/* Read frames from the queue */
> -		skb = ptr_ring_consume(&q->ring);
> +		skb = tap_ring_consume(q);
>  		if (skb)
>  			break;
>  		if (noblock) {
> @@ -1207,6 +1247,8 @@ int tap_queue_resize(struct tap_dev *tap)
>  	ret = ptr_ring_resize_multiple_bh(rings, n,
>  					  dev->tx_queue_len, GFP_KERNEL,
>  					  __skb_array_destroy_skb);
> +	if (netif_running(dev))
> +		netif_tx_wake_all_queues(dev);
>  
>  	kfree(rings);
>  	return ret;
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index c6b22af9bae8..682df8157b55 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2114,13 +2114,53 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	return total;
>  }
>  
> +static void *tun_ring_consume(struct tun_file *tfile)
> +{
> +	struct netdev_queue *txq;
> +	struct net_device *dev;
> +	bool will_invalidate;
> +	bool stopped;
> +	void *ptr;
> +
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> +	if (!ptr) {
> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> +		return ptr;
> +	}
> +
> +	/* Check if the queue stopped before zeroing out, so no ptr get
> +	 * produced in the meantime, because this could result in waking
> +	 * even though the ptr_ring is full. The order of the operations
> +	 * is ensured by barrier().
> +	 */
> +	will_invalidate = __ptr_ring_will_invalidate(&tfile->tx_ring);
> +	if (unlikely(will_invalidate)) {
> +		rcu_read_lock();
> +		dev = rcu_dereference(tfile->tun)->dev;
> +		txq = netdev_get_tx_queue(dev, tfile->queue_index);
> +		stopped = netif_tx_queue_stopped(txq);
> +	}
> +	barrier();
> +	__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> +
> +	if (unlikely(will_invalidate)) {
> +		if (stopped)
> +			netif_tx_wake_queue(txq);
> +		rcu_read_unlock();
> +	}
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +
> +	return ptr;
> +}
> +
>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
>  	void *ptr = NULL;
>  	int error = 0;
>  
> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> +	ptr = tun_ring_consume(tfile);
>  	if (ptr)
>  		goto out;
>  	if (noblock) {
> @@ -2132,7 +2172,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  
>  	while (1) {
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> +		ptr = tun_ring_consume(tfile);
>  		if (ptr)
>  			break;
>  		if (signal_pending(current)) {
> @@ -3621,6 +3661,9 @@ static int tun_queue_resize(struct tun_struct *tun)
>  					  dev->tx_queue_len, GFP_KERNEL,
>  					  tun_ptr_free);
>  
> +	if (netif_running(dev))
> +		netif_tx_wake_all_queues(dev);
> +
>  	kfree(rings);
>  	return ret;
>  }
> -- 
> 2.43.0

