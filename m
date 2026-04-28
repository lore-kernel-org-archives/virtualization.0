Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E82C181
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380635; cv=none; b=C6ZkvuSe0OOp+6FnhS4ChWBdW/SnGqHbBnZg5d+MnaAPMMLKsVgy4O3GX0u1ELVlcRxKUg3LpV8XrpKa4Qs2tuPoT5GSWD5ntewEds4CzN2bui7KrQ7Y1cEI3t84ZuBnDeQLMyhSfMGhOeOgW2sW7GoncrOZ+U2Fxvqup2f167A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380635; c=relaxed/simple;
	bh=4jJGYQxHBlAYam3pVZa37i0ecAp+T4koXg6IlslsR5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kamjmSnYoyZRjglhbvBsm+NDVYF7Ycyz2W5qVqzXrkQGiQTS7To+du1WL2SeuGgjqK9PC9JIid9VoUtWzxnCWFeS5adbzjSBl9f4yLab2ft1yzMMzxwduTK6dBn/u/ebCSpc6junmu6GWjvf3FGMVvPWvlY4Npy9IKUw2fTa34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqRP7aBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqRP7aBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777380630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0i0+P4zaB64MHfqqKp5K0u0CNckDs52Y4/4I9jpSM2g=;
	b=fqRP7aBp3huqueXMATc7HgXUyfJvvlPH8ufZCIuH2gOCjwuX3gk/8cJuT7JB4cDhPyaYI7
	nf5iUP5yzkpo+Y27G4efsD1BlDlJjhobw9t45ZGiRluv/Ay66m1FKEtWOweNADA8NA6yw6
	i36E34i/ykqMD9uGW/StEW5+jlpoBI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-Xx6NisWNMm-PJ-uH_4hDxQ-1; Tue, 28 Apr 2026 08:50:28 -0400
X-MC-Unique: Xx6NisWNMm-PJ-uH_4hDxQ-1
X-Mimecast-MFC-AGG-ID: Xx6NisWNMm-PJ-uH_4hDxQ_1777380627
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a589c7879so42845095e9.1
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 05:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380627; x=1777985427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i0+P4zaB64MHfqqKp5K0u0CNckDs52Y4/4I9jpSM2g=;
        b=D2PH/pCBKKRE/Qy1z/mvHc8Z4TNYN4sMGVVLgodX7EoutY2H4i5z00zb8Pm8daxzdm
         jBL05+P/h4McYdo6E9bZfZZ81RnFtGEUCixMqfpFtlD2nN2qBdOxAG6nz7qx/3bKSwdO
         820wg6NKZ7iby9IWKbyV5cpx3GJ4Vj9t9FBmXTFyBdMsO6etO8ESGJtzuyJv/+L7P33Y
         YQAnvPwGhvJ5NOwMqVJT3o2CXXSQUgxl9K/fBsdw+2S9TP9mRoZUVsMtvMdbI9L7aRDW
         Rpvv+DzJ+u4tCSS8hs1wF+Oqc2HjRUpjPyEIZEoV73wT3CnUZNr0x4aGMPTp7XJKqIpA
         n03w==
X-Forwarded-Encrypted: i=1; AFNElJ8bkajQl2wi4br8N7Ud0VNRCTI89H9GwwWDc29X93QvIqnzte2F/VxonJc0ES3dMewjkpuTVWCQmVe2Urdcpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTqXYS4fEm6urg2pv1SG4CyM/wQv9BF/EIjMg2vzf6Ns5tY8bU
	WOJ3i6nzXPGa4UTEAm1Rh88lJdf3q5AlxnGCB44rDl8foXandSHhqhPB/LHcBc0qeGjm6xIqOn2
	MSjyiP2XvbJnHlrKGVBatpCHjb5A6YZpkp0zvwaXoFwD0KtwhYvUxdHmNUoHddZVjSWrc
X-Gm-Gg: AeBDietKtVPAIyoj6GkBllF+0m6C23K3mbH3p3M21jcN0A3sgE4X4yEQPI5Whls9bXu
	OUEgaGh+NgYQ4EuFARZ8zJD+IKYXHenzBXLu6e3fVSHP9HrfA3049qZNNE69jubEsgiCysCQZUM
	/mfivWDp/gnH+RAtEDrGdIajJt3KANpMyswszSffy/6qtu0DQepO7EqqX1zNmIM78QouFF4q+AI
	PXRLTBzuzTyt0AuxOZ8/RJB0zYafP/kY8g7+c+m8wpX7mb2F8QokUwy9DFxm5hXoJIcduYFwLHe
	gkzhMzJuutasGClvgD3sigtNnhlQ26+6KE4rKAE3gvXElNc+HNLctWwd+qURasWlIKNeIgYNj2P
	kiO1Ma9GD3H4Ms3g2kHpVfSimJ5ZRdkEWaVA3te3SV8oNJwvO73+3/0/p
X-Received: by 2002:a05:600c:609a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a78a33023mr30740355e9.9.1777380627121;
        Tue, 28 Apr 2026 05:50:27 -0700 (PDT)
X-Received: by 2002:a05:600c:609a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a78a33023mr30739215e9.9.1777380625808;
        Tue, 28 Apr 2026 05:50:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773efe38sm72509755e9.13.2026.04.28.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:50:24 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:50:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v9 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260428084851-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: emMkRJ_a0xBIPF8mshl-5-7NUVbd7cmZmDuVtJi3HVQ_1777380627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets.
> 
> If producing an entry fails anyways due to a race, tun_net_xmit returns
> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> LLTX is enabled and the transmit path operates without the usual locking.
> 
> If no qdisc is present, the previous tail-drop behavior is preserved.
> 
> The existing __tun_wake_queue() function of the consumer races with the
> producer for waking/stopping the netdev queue: the consumer may drain
> the ring just as the producer stops the queue, leading to a permanent
> stall. To avoid this, the producer re-checks the ring after stopping
> and wakes the queue itself if space was just made. An
> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> drain that the consumer performed.
> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> netif_wake_subqueue():
> 
> Consumer CPU                  Producer CPU
> ========================      =========================
> __ptr_ring_consume()
> netif_wake_subqueue()         netif_tx_stop_queue()
>           /\                  smp_mb__after_atomic()
>           ||                  __ptr_ring_produce_peek()
> contains RMW operation
>  test_and_clear_bit()
>           /\
>           ||
>  "Fully ordered RMW:
> smp_mb() before + after"
>     - atomic_t.txt
> 
> Benchmarks:
> The benchmarks show a slight regression in raw transmission performance,
> though no packets are lost anymore.

Could you include the packets received as well?
To demonstrate the gains/lack of loss. 

> 
> The previously introduced threshold to only wake after the queue stopped
> and half of the ring was consumed showed to be a descent choice:
> Waking the queue whenever a consume made space in the ring strongly
> degrades performance for tap, while waking only when the ring is empty
> is too late and also hurts throughput for tap & tap+vhost-net.
> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> 1/2 was chosen for the sake of simplicity for both tun/tap and
> tun/tap+vhost-net.
> 
> Test setup:
> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> mitigations disabled.
> 
> Note for tap+vhost-net:
> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> 
> +--------------------------+--------------+----------------+----------+
> | 1 thread                 | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> 
> +--------------------------+--------------+----------------+----------+
> | 2 threads                | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index efe809597622..c2a1618cc9db 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *queue;
>  	struct tun_file *tfile;
>  	int len = skb->len;
> +	bool qdisc_present;
> +	int ret;
>  
>  	rcu_read_lock();
>  	tfile = rcu_dereference(tun->tfiles[txq]);
> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> +
> +	spin_lock(&tfile->tx_ring.producer_lock);
> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> +		netif_tx_stop_queue(queue);
> +		/* Re-peek and wake if the consumer drained the ring
> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> +		 * in __tun_wake_queue().
> +		 */
> +		smp_mb__after_atomic();
> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +			netif_tx_wake_queue(queue);
> +	}
> +	spin_unlock(&tfile->tx_ring.producer_lock);
> +
> +	if (ret) {
> +		/* If a qdisc is attached to our virtual device,
> +		 * returning NETDEV_TX_BUSY is allowed.
> +		 */
> +		if (qdisc_present) {
> +			rcu_read_unlock();
> +			return NETDEV_TX_BUSY;
> +		}
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}
>  
>  	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
>  	txq_trans_cond_update(queue);
>  
>  	/* Notify and wake up reader process */
> -- 
> 2.43.0

