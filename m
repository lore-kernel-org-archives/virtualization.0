Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57F23D280
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696944; cv=none; b=SgjkIWLVp278BiLokFp/Qmgbr/igfxk+O5CD/9aKq/svt+SP0EIawuStw6HTikl9cjss8YUUs1m86cB2idDvTLajFB/jzAnMPO694/cpfnSjNtv+ZOj9DIOhb0bKtbTfhU4TIR8xeixk9SHSdzfQijizGRhdR3KZHo+2bkgLSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696944; c=relaxed/simple;
	bh=IYyT2OvtNRU8mKssTIxBwKkXN9e3ywY0bC2fvBkYVDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IY8vxVcz3GXZN+QyK4VGyHqgmDA5UKqaR3zwxaPMoXSYAdRQ3u04LDRaWrbsjVFX/mhbMaomLu8p+bVHiAD/phdaLDSY3/VFsZD9yfuhVuPtaauJw1EIKkyXcd670DEddmf9enWo2afB46BzkJmWI2pFhIfBpdQ8Qoi9HRM1IJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4PiWmfZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4PiWmfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758696941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMFaozSmWaP2nSuZAYoKtFmuv42SSqXkQF+k+CWOpeA=;
	b=W4PiWmfZKSVJ/CRX+oWXRxQX4+MShxudum2wKA6vEOb1W6FY7Gg7r61JeqAp94K4B6uZLF
	5xH2ysgsFWnshc79piH7QQRl7yKcwUcuo722yW9H23++jwZBVe14LqXANTBk/ndyj30AL9
	hNig7sUvVRVJ3Wq96KwqaG9+h+zFETs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-OyR_piIhMH6kj_EjvP3JnQ-1; Wed, 24 Sep 2025 02:55:33 -0400
X-MC-Unique: OyR_piIhMH6kj_EjvP3JnQ-1
X-Mimecast-MFC-AGG-ID: OyR_piIhMH6kj_EjvP3JnQ_1758696933
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46b15e6f227so12657495e9.1
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 23:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758696932; x=1759301732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMFaozSmWaP2nSuZAYoKtFmuv42SSqXkQF+k+CWOpeA=;
        b=PAgdqNiAUjUMCJCwzEdMIdtk0nlVsYc1ygG3vKUR3l/jNSN+/NSnKktZ/rdUbJD7FR
         v3WBxeMVfkUVybvsDcicsD5sFLxS4RpPOhFJd+mCOgaUvUGsogv2fJKgzG9CpKiDmVWd
         DJT7/kac8xU5brfZQNHFrBdcQ3VBA11DYbk9EgNKfv2bfmijeYyHguXNsGlJmFnOKEeE
         FD3eIXDS2B2rZK+v+2JXc8GDIDpBcYQzIYw3UASghKc2fRl0y4XNQkr9J6MHbqPlRfFW
         wJ6HnoxBvThk2XDX+n96qshMuUIVgdfZ3H2/f7WTL89sPIM0RzQ8Hv4riyRMM3SIKj1S
         Gnfg==
X-Forwarded-Encrypted: i=1; AJvYcCXV4h6OfrR7YtkgKPvUYhrygp66ivyUPV1Zrs5xMJFYFaa/zm4BvbGPJcrvKMr+ayk72jJUKwe8VYR6V3jGLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGTRYid4W5gEyrMaK+z0Q8sPumAfk3jKscqtL7hfQFUdDI7WcY
	A7prpxr7EI6SpD+RzaEv3cnx102kd7AMRzV5pRM07BRZu9LtauemrPevEGPO+e4Lt4hutWffTJf
	LUuthVBEFyguI96TYU31xBXqeWkXek1D+6onrndIwRT8kBb74HtUEKitg+glSuUHhsXH6
X-Gm-Gg: ASbGncv9EWZwjAuot3ad7aG2fd2DPqueJbKOJGclySB1M+DOkdjtamsn0wfXMW6pov1
	bZbis7ttkyb5QRgJAxapRiB8NFd9+BRyUYfnTWtYFKl0cEeODxbAiWuJIEhKQuYOE3rVaVTSUk7
	KWvarRiA7h2EzslqYWA/DJsK9YAlGrK0puHpOL6vVwY7kLKYcohAlIIIIaY4opQGfcsJtt7BHtp
	YuNeAw36G/cZyPapWS75SfPbb4D3Pzc9bkRnn7Vsc7IjE7zyEQJn7AN1G5HnXB0MBmicMkp+Sh/
	y+nXHZWSvN1k1KhF4vrxLdFClXWJC8brqIM=
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e1dac6457mr53314985e9.31.1758696932401;
        Tue, 23 Sep 2025 23:55:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzQnJawr202LYF/GiG0rNphKRkGOKkt//h6RbI08Bh3KFW0jxQ55p1coTiwy7Vic6NwDCxDw==
X-Received: by 2002:a05:600c:198f:b0:45d:d9ab:b86d with SMTP id 5b1f17b1804b1-46e1dac6457mr53314625e9.31.1758696931825;
        Tue, 23 Sep 2025 23:55:31 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f99178390csm13966234f8f.44.2025.09.23.23.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 23:55:31 -0700 (PDT)
Date: Wed, 24 Sep 2025 02:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250924024416-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250922221553.47802-5-simon.schippers@tu-dortmund.de>
 <20250923123101-mutt-send-email-mst@kernel.org>
 <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aacb449c-ad20-48b0-aa0f-b3866a3ed7f6@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FMwaiRzlbp2IGGeO8Z1Bg57gZ9NrJCWRbpRmlHZBkBo_1758696933
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 24, 2025 at 07:56:33AM +0200, Simon Schippers wrote:
> On 23.09.25 18:36, Michael S. Tsirkin wrote:
> > On Tue, Sep 23, 2025 at 12:15:49AM +0200, Simon Schippers wrote:
> >> The new wrappers tun_ring_consume/tap_ring_consume deal with consuming an
> >> entry of the ptr_ring and then waking the netdev queue when entries got
> >> invalidated to be used again by the producer.
> >> To avoid waking the netdev queue when the ptr_ring is full, it is checked
> >> if the netdev queue is stopped before invalidating entries. Like that the
> >> netdev queue can be safely woken after invalidating entries.
> >>
> >> The READ_ONCE in __ptr_ring_peek, paired with the smp_wmb() in
> >> __ptr_ring_produce within tun_net_xmit guarantees that the information
> >> about the netdev queue being stopped is visible after __ptr_ring_peek is
> >> called.
> >>
> >> The netdev queue is also woken after resizing the ptr_ring.
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tap.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >>  drivers/net/tun.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 88 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >> index 1197f245e873..f8292721a9d6 100644
> >> --- a/drivers/net/tap.c
> >> +++ b/drivers/net/tap.c
> >> @@ -753,6 +753,46 @@ static ssize_t tap_put_user(struct tap_queue *q,
> >>  	return ret ? ret : total;
> >>  }
> >>  
> >> +static struct sk_buff *tap_ring_consume(struct tap_queue *q)
> >> +{
> >> +	struct netdev_queue *txq;
> >> +	struct net_device *dev;
> >> +	bool will_invalidate;
> >> +	bool stopped;
> >> +	void *ptr;
> >> +
> >> +	spin_lock(&q->ring.consumer_lock);
> >> +	ptr = __ptr_ring_peek(&q->ring);
> >> +	if (!ptr) {
> >> +		spin_unlock(&q->ring.consumer_lock);
> >> +		return ptr;
> >> +	}
> >> +
> >> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >> +	 * produced in the meantime, because this could result in waking
> >> +	 * even though the ptr_ring is full.
> > 
> > So what? Maybe it would be a bit suboptimal? But with your design, I do
> > not get what prevents this:
> > 
> > 
> > 	stopped? -> No
> > 		ring is stopped
> > 	discard
> > 
> > and queue stays stopped forever
> > 
> > 
> 
> I totally missed this (but I am not sure why it did not happen in my 
> testing with different ptr_ring sizes..).
> 
> I guess you are right, there must be some type of locking.
> It probably makes sense to lock the netdev txq->_xmit_lock whenever the 
> consumer invalidates old ptr_ring entries (so when r->consumer_head >= 
> r->consumer_tail). The producer holds this lock with dev->lltx=false. Then 
> the consumer is able to wake the queue safely.
> 
> So I would now just change the implementation to:
> tun_net_xmit:
> ...
> if ptr_ring_produce
>     // Could happen because of unproduce in vhost_net..
>     netif_tx_stop_queue
>     ...
>     goto drop
> 
> if ptr_ring_full
>     netif_tx_stop_queue
> ...
> 
> tun_ring_recv/tap_do_read (the implementation for the batched methods 
> would be done in the similar way):
> ...
> ptr_ring_consume
> if r->consumer_head >= r->consumer_tail
>     __netif_tx_lock_bh
>     netif_tx_wake_queue
>     __netif_tx_unlock_bh
> 
> This implementation does not need any new ptr_ring helpers and no fancy 
> ordering tricks.
> Would this implementation be sufficient in your opinion?


Maybe you mean == ? Pls don't poke at ptr ring internals though.
What are we testing for here?
I think the point is that a batch of entries was consumed?
Maybe __ptr_ring_consumed_batch ? and a comment explaining
this returns true when last successful call to consume
freed up a batch of space in the ring for producer to make
progress.


consumer_head == consumer_tail also happens rather a lot,
though thankfully not on every entry.
So taking tx lock each time this happens, even if queue
is not stopped, seems heavyweight.





> >> The order of the operations
> >> +	 * is ensured by barrier().
> >> +	 */
> >> +	will_invalidate = __ptr_ring_will_invalidate(&q->ring);
> >> +	if (unlikely(will_invalidate)) {
> >> +		rcu_read_lock();
> >> +		dev = rcu_dereference(q->tap)->dev;
> >> +		txq = netdev_get_tx_queue(dev, q->queue_index);
> >> +		stopped = netif_tx_queue_stopped(txq);
> >> +	}
> >> +	barrier();
> >> +	__ptr_ring_discard_one(&q->ring, will_invalidate);
> >> +
> >> +	if (unlikely(will_invalidate)) {
> >> +		if (stopped)
> >> +			netif_tx_wake_queue(txq);
> >> +		rcu_read_unlock();
> >> +	}
> > 
> > 
> > After an entry is consumed, you can detect this by checking
> > 
> > 	                r->consumer_head >= r->consumer_tail
> > 
> > 
> > so it seems you could keep calling regular ptr_ring_consume
> > and check afterwards?
> > 
> > 
> > 
> > 
> >> +	spin_unlock(&q->ring.consumer_lock);
> >> +
> >> +	return ptr;
> >> +}
> >> +
> >>  static ssize_t tap_do_read(struct tap_queue *q,
> >>  			   struct iov_iter *to,
> >>  			   int noblock, struct sk_buff *skb)
> >> @@ -774,7 +814,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>  					TASK_INTERRUPTIBLE);
> >>  
> >>  		/* Read frames from the queue */
> >> -		skb = ptr_ring_consume(&q->ring);
> >> +		skb = tap_ring_consume(q);
> >>  		if (skb)
> >>  			break;
> >>  		if (noblock) {
> >> @@ -1207,6 +1247,8 @@ int tap_queue_resize(struct tap_dev *tap)
> >>  	ret = ptr_ring_resize_multiple_bh(rings, n,
> >>  					  dev->tx_queue_len, GFP_KERNEL,
> >>  					  __skb_array_destroy_skb);
> >> +	if (netif_running(dev))
> >> +		netif_tx_wake_all_queues(dev);
> >>  
> >>  	kfree(rings);
> >>  	return ret;
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index c6b22af9bae8..682df8157b55 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2114,13 +2114,53 @@ static ssize_t tun_put_user(struct tun_struct *tun,
> >>  	return total;
> >>  }
> >>  
> >> +static void *tun_ring_consume(struct tun_file *tfile)
> >> +{
> >> +	struct netdev_queue *txq;
> >> +	struct net_device *dev;
> >> +	bool will_invalidate;
> >> +	bool stopped;
> >> +	void *ptr;
> >> +
> >> +	spin_lock(&tfile->tx_ring.consumer_lock);
> >> +	ptr = __ptr_ring_peek(&tfile->tx_ring);
> >> +	if (!ptr) {
> >> +		spin_unlock(&tfile->tx_ring.consumer_lock);
> >> +		return ptr;
> >> +	}
> >> +
> >> +	/* Check if the queue stopped before zeroing out, so no ptr get
> >> +	 * produced in the meantime, because this could result in waking
> >> +	 * even though the ptr_ring is full. The order of the operations
> >> +	 * is ensured by barrier().
> >> +	 */
> >> +	will_invalidate = __ptr_ring_will_invalidate(&tfile->tx_ring);
> >> +	if (unlikely(will_invalidate)) {
> >> +		rcu_read_lock();
> >> +		dev = rcu_dereference(tfile->tun)->dev;
> >> +		txq = netdev_get_tx_queue(dev, tfile->queue_index);
> >> +		stopped = netif_tx_queue_stopped(txq);
> >> +	}
> >> +	barrier();
> >> +	__ptr_ring_discard_one(&tfile->tx_ring, will_invalidate);
> >> +
> >> +	if (unlikely(will_invalidate)) {
> >> +		if (stopped)
> >> +			netif_tx_wake_queue(txq);
> >> +		rcu_read_unlock();
> >> +	}
> >> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> >> +
> >> +	return ptr;
> >> +}
> >> +
> >>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>  {
> >>  	DECLARE_WAITQUEUE(wait, current);
> >>  	void *ptr = NULL;
> >>  	int error = 0;
> >>  
> >> -	ptr = ptr_ring_consume(&tfile->tx_ring);
> >> +	ptr = tun_ring_consume(tfile);
> >>  	if (ptr)
> >>  		goto out;
> >>  	if (noblock) {
> >> @@ -2132,7 +2172,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> >>  
> >>  	while (1) {
> >>  		set_current_state(TASK_INTERRUPTIBLE);
> >> -		ptr = ptr_ring_consume(&tfile->tx_ring);
> >> +		ptr = tun_ring_consume(tfile);
> >>  		if (ptr)
> >>  			break;
> >>  		if (signal_pending(current)) {
> >> @@ -3621,6 +3661,9 @@ static int tun_queue_resize(struct tun_struct *tun)
> >>  					  dev->tx_queue_len, GFP_KERNEL,
> >>  					  tun_ptr_free);
> >>  
> >> +	if (netif_running(dev))
> >> +		netif_tx_wake_all_queues(dev);
> >> +
> >>  	kfree(rings);
> >>  	return ret;
> >>  }
> >> -- 
> >> 2.43.0
> > 

