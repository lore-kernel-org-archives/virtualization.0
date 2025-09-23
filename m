Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E581F5846
	for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639283; cv=none; b=BNEWR7dfgxjwwK7cDUn9r0/tRqa+2DC0dO7ORRXw14kQBmXwWSa5ba4B4GjjhKzNpqnL2x10ae6bFfcXxR11z6tjGUylAVTA2YeRGPziPAvFCX5ZVYob9XhscTka/NGuSGswQP0QyYAXZjSrsMVWcV3e0xKuch0oavmD4eHXHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639283; c=relaxed/simple;
	bh=yLJ8trcIeN87cTM37Qp7/z/or3KwICs4V/zFq2dp/xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X82v4VdUhzryNEsONue/T3xaKG1xuKG6inn6dene8uv8HNcK+Tc8UsMevh8G8WEa4N9/A+eTX9DJ+8vBhB9gB9cyhQ9sa6E+TjhzXqCoN0JqxUqS02PoqGjgLJfubH3ckKWt1WtmmjIw3DucH6sSAg0qvhkBhpXBZFL4RtzYOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLUus4Ph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLUus4Ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758639281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlTGS/oUq6qr4tFK7p920ZEocw8mB7yDznWqUIeSU/0=;
	b=FLUus4PhA1JD+T3k8ndtD0IW63i7t8c0OvuYjykz66fRKReLtKf+ehlMkyl8cbxQbqOhkV
	cysZsWu6EjZDNl9v0/ZWfbcU3svKmQhr8SUVvnk4RLFfgujMsiWKOTwHPmsPDUJHiS1cRE
	4ZlxkyjQSxWQ/cOU3vBnX+Ybz6JCCNM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-HREMyOCQM-2MmVTmpOAynQ-1; Tue, 23 Sep 2025 10:54:40 -0400
X-MC-Unique: HREMyOCQM-2MmVTmpOAynQ-1
X-Mimecast-MFC-AGG-ID: HREMyOCQM-2MmVTmpOAynQ_1758639279
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b2e6b2bb443so176686566b.2
        for <virtualization@lists.linux.dev>; Tue, 23 Sep 2025 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639279; x=1759244079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlTGS/oUq6qr4tFK7p920ZEocw8mB7yDznWqUIeSU/0=;
        b=WoUx/3jRaa3i+p7l0eGUvUGJX1lc2mAE9c3w3RNv4vyo+CzlwFrEZYJmTlignj8te6
         yPajvMpCcHLu4MLJtLZqyYqy+J+y8Ct0ibcc/rykZv3D8ZH2wIWlKX60a6WiwpX/rgO2
         QHmJwEXj+KVSeQycjP0jKqd9bGT/HFQ1xwBf/FSNKCWCt9VwdcR/9uQl1lDozJ0RC4U4
         9KuXYJlw/4Zr3K2kJV4gjSg+sZqXcsk9PD+MSJzPHGUS7h8Q9vQJ9fT3lsJpHFOh25Mb
         /sCKS8slrYZ9oVXEef8i7wZ9dDRR2/kyr6vIy/7684cwW3OyczXiTUIg0VK1je7KED+B
         Iuqw==
X-Forwarded-Encrypted: i=1; AJvYcCUMznHwqw8K8Kbnw7okpSb/k9oebFl2oNtIwdYvYqK5U9NhUSWReg8yHCnVhiPQnQtYb4lS44UBGT4leSY5yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMAuS6vwT7jV1q7a5/M4XgNQrzy97kiFSh7hWu5tkXppLRtdye
	944LTA+MXvrEcVYGosdaNX+LaZojuGTlaiS9qyc9nHOt7aDv2u6ijL9yNNYD7r0vXvqtoof/1CF
	d3xuR2loXRclwjo+tkjUMAhlYYqHDhaHOlkpyPnkbJ5Bv0oV3Uk78nWKWd+vguih/OgAD
X-Gm-Gg: ASbGncv/9kKenfDqs/nPz8YQTnRjkcz9Q6IU8v+UtqQGVk/Ld0Du3/LCgr9A1VmXPw8
	xlmXyjCuqYEhAorXHrAaBn30AKS1mORuLD5jpMmmXHOYj3op6/D2WO+QFC9Fz4ZpZdnGgqeptUI
	iwTvkfH5S8zSPCUrCOZnSga8dCSak4bvt7o4h5hCQB2WJ4jvD3TZjjW4JPKuWq0vcE7hyzs48xK
	ClyBYsRTTCBS+dqmx+JcO1XbssqKbVZ2Z6G1nXu/6WX2zkZgXly399s54wBME+OdWpfNY0T1s2G
	/RurdDh82mjz/aZYlyw4TGyicBPUtwCjvEg=
X-Received: by 2002:a17:906:4fca:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-b302a36d276mr320841666b.40.1758639278592;
        Tue, 23 Sep 2025 07:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0UY1L8jdF7RbmRM0SmnKrV7GJclLjE5bXJYDHMS+tHgb236lYdm0fYPTKRoEBIL9oZfqX0g==
X-Received: by 2002:a17:906:4fca:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-b302a36d276mr320838666b.40.1758639278088;
        Tue, 23 Sep 2025 07:54:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2dd7bab2e6sm392363866b.41.2025.09.23.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:54:37 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:54:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>
Subject: Re: [PATCH net-next v5 4/8] TUN & TAP: Wake netdev queue after
 consuming an entry
Message-ID: <20250923104818-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: WOXekjaymRIC0eZJyjs0rZ9oi1fSGgmpxQh_BbJQKRs_1758639279
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


Sounds like there is subtle interplay here between queue stopped bit and
ring full status, all lockless with fancy ordering tricks.  I have to
say this is fragile. I'd like to see much more documentation.


Or alternatively, I ask myself if, after detecting flow control
issues, it is possible to just use a spinlock to synchronize,
somehow.


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
> +	 * even though the ptr_ring is full. The order of the operations

which operations, I don't get it? it's unusual for barrier()
to be effective. are you trying to order the read in netif_tx_queue_stopped
versus the read in __ptr_ring_discard_one?
Then that would seem to need smp_rmb and accordingly smp_wmb in the
producing side.


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

