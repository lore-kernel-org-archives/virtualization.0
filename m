Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EC3EB7FB
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382550; cv=none; b=L6l2hQ6uFaYkxCr1IGcgfe3AmWbOpW1yhzmYi8V9NELikFlNRVDB3J1dKIHJdoQ5aYe1C7aXCMrJQzyGx9yjfG7bJgdAWxbGh5oSVldShHqN7o6tn95y2TlIS8MDNDbiH+/bPl6y9K9vOaHHSoDM030t20C+s1v5AHxstBeIYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382550; c=relaxed/simple;
	bh=2BB9SsZnD1oUi/iZNMFAyjkEk2+CmkyVl1grdupCgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=thfGAyS9d2Zvv+5llJr53E9axww+NPkbKvCdBe9oJ/NRsllmVoP2ayp+BV89iuvmnAO9Z/PteAT9KtLwPfeVIzDX4fm6Jf0RG0SMCUpzURgPTqg89AFXOANb1l8YMqEtSMLnve2E/N3QneKSY0x1Rm08iXP/fOxfY2+XbpmkIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YD7RPCYC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD7RPCYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
	b=YD7RPCYC86hYsi4uM8tWWnXN7QtAVP46depnLDHlRweYu4amQcETaxinSqyDzwGl/Oi+ne
	+iRKdpjxmkcPR970Bd+4O0UQGlm56KrLpnhlQuP3B7dpH1wrQxDu0cdVKh76PAjw6VT6g4
	BucCpq5YaAN3oDBLSNdL7aXSpAUKllk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-irLb7YnDOheKa-ivVwvIFw-1; Tue, 28 Apr 2026 09:22:22 -0400
X-MC-Unique: irLb7YnDOheKa-ivVwvIFw-1
X-Mimecast-MFC-AGG-ID: irLb7YnDOheKa-ivVwvIFw_1777382541
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-440d12a472eso8411645f8f.3
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 06:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382541; x=1777987341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
        b=aQzCYsvgXU0riDVIqRuuYVlSlHx7kzdas/jQM/JMatr8TCIg6ntiLRPYBHy8UeVVgt
         7WKUDJUcdTLTXKEmjBCMVEWjyaH8lqObYXGBUqvWXesw4mdluBRv+Lc3gx0bMWUra66t
         JRexEhDIMKaUF2K0+bvfZrD2j5RY/ql8tTFuRJMddos/4vhaVWgVKDiX1FVQ1CZKmUR4
         cXHE1l7QIJsgpPABHEr3Pfu1p2VX2ccvfjNBE+tQBfRZElGGvMusFbXYdyTatlv6oVSp
         o8jzdYgCKXHEBS77Ka7EQEpwLbS8CAhqMd3pQAFVUhJ17efvE6vUIgnuNFeAcEtRvD/z
         WdKg==
X-Forwarded-Encrypted: i=1; AFNElJ/QreXyLaXlft3mvrw8GWJOVkv90iTggPmp65aBeDYB3nI0uOtYUYWcfaMKaQx2M4/PX0ZqRv9rfaroG7mGBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxItiQ4QDdfabZaw9r+zm7XEKdlapIsuHdGZB36py/GPn/+AD3+
	nUqPObcDVF1sQXTNJoTEkzHagsBuK0Jzs6MkRh/11EfUNJZTSIUIZgcIr979CwzxAPq7dmxH1yP
	P5v1Xmtf4NFu5mxXTot9xlVJICHwnWEdcPOThcBEg/MomT92AlcghU2cmNlJGCy9rCiY7
X-Gm-Gg: AeBDieudiyIY37OFRH7jKi+o4oea1UiKS2zgd+dTgIVNUqnuvWqG9hkTSda2k1uSWXu
	bkMsm5A3qQpGZKdfzD4ZeEybMufEAaK++XvKGNucMuCR052FTp8UlOzGGjGrTOTW/Ie9D1CqG9A
	dQZ6TKB9d91MyhhA0Bs8o2wAih6fXWBvwhfLT6YtP3bAQ46eTR2kRuxrqGlSDgtX2UdpjPjUASY
	GQDNoKv/b/9WpR+DTIFIjuUnrjYpQbuRU22dIPZNMvszOkp6Yb7/ZpEQ0hKTmJr1YLt2ql5P3eW
	b6tikWszdFjzq7CNF+0CfSHh7PBjNlwVCTVrpkWE1EvafqPfI/B5HIAkRNp76tvjrltMB066R3H
	lUoLATenLwBRVYEd5JTP7rdCfO7Q8KW318INepBRtCeCQ4RM8XvpNZq6J
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-4464a1684bdmr5626381f8f.27.1777382540739;
        Tue, 28 Apr 2026 06:22:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-4464a1684bdmr5626286f8f.27.1777382540032;
        Tue, 28 Apr 2026 06:22:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm6487599f8f.13.2026.04.28.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:22:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:22:14 -0400
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
Message-ID: <20260428092150-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FxdNBobBRr7_4vqA3RKzYAAjCh9M5PjJ7gw_5AszeYM_1777382541
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >> becomes full. Once an entry is successfully produced and the ptr_ring
> >> reaches capacity, the netdev queue is stopped instead of dropping
> >> subsequent packets.
> >>
> >> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >> LLTX is enabled and the transmit path operates without the usual locking.
> >>
> >> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>
> >> The existing __tun_wake_queue() function of the consumer races with the
> >> producer for waking/stopping the netdev queue: the consumer may drain
> >> the ring just as the producer stops the queue, leading to a permanent
> >> stall. To avoid this, the producer re-checks the ring after stopping
> >> and wakes the queue itself if space was just made. An
> >> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >> drain that the consumer performed.
> >> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >> netif_wake_subqueue():
> >>
> >> Consumer CPU                  Producer CPU
> >> ========================      =========================
> >> __ptr_ring_consume()
> >> netif_wake_subqueue()         netif_tx_stop_queue()
> >>           /\                  smp_mb__after_atomic()
> >>           ||                  __ptr_ring_produce_peek()
> >> contains RMW operation
> >>  test_and_clear_bit()
> >>           /\
> >>           ||
> >>  "Fully ordered RMW:
> >> smp_mb() before + after"
> >>     - atomic_t.txt
> >>
> >> Benchmarks:
> >> The benchmarks show a slight regression in raw transmission performance,
> >> though no packets are lost anymore.
> > 
> > Could you include the packets received as well?
> > To demonstrate the gains/lack of loss. 
> > 
> 
> Do you mean the number of packets received by the VM?
> They should just be the same as the number sent (shown below), right?

Minus the loss? Which this is about, right?

> I assume they would be visible as RX-DRP for TAP.
> For TAP + vhost-net I would have to rewrite the XDP drop
> program to count the number of dropped packets...
> And I would have to automate it...
> 
> >>
> >> The previously introduced threshold to only wake after the queue stopped
> >> and half of the ring was consumed showed to be a descent choice:
> >> Waking the queue whenever a consume made space in the ring strongly
> >> degrades performance for tap, while waking only when the ring is empty
> >> is too late and also hurts throughput for tap & tap+vhost-net.
> >> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >> tun/tap+vhost-net.
> >>
> >> Test setup:
> >> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >> mitigations disabled.
> >>
> >> Note for tap+vhost-net:
> >> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>
> >> +--------------------------+--------------+----------------+----------+
> >> | 1 thread                 | Stock        | Patched with   | diff     |
> >> | sending                  |              | fq_codel qdisc |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >> |            +-------------+--------------+----------------+----------+
> >> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >> |            +-------------+--------------+----------------+----------+
> >> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >>
> >> +--------------------------+--------------+----------------+----------+
> >> | 2 threads                | Stock        | Patched with   | diff     |
> >> | sending                  |              | fq_codel qdisc |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >> |            +-------------+--------------+----------------+----------+
> >> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >> |            +-------------+--------------+----------------+----------+
> >> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index efe809597622..c2a1618cc9db 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  	struct netdev_queue *queue;
> >>  	struct tun_file *tfile;
> >>  	int len = skb->len;
> >> +	bool qdisc_present;
> >> +	int ret;
> >>  
> >>  	rcu_read_lock();
> >>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  
> >>  	nf_reset_ct(skb);
> >>  
> >> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >> +	queue = netdev_get_tx_queue(dev, txq);
> >> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >> +
> >> +	spin_lock(&tfile->tx_ring.producer_lock);
> >> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >> +		netif_tx_stop_queue(queue);
> >> +		/* Re-peek and wake if the consumer drained the ring
> >> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >> +		 * in __tun_wake_queue().
> >> +		 */
> >> +		smp_mb__after_atomic();
> >> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >> +			netif_tx_wake_queue(queue);
> >> +	}
> >> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >> +
> >> +	if (ret) {
> >> +		/* If a qdisc is attached to our virtual device,
> >> +		 * returning NETDEV_TX_BUSY is allowed.
> >> +		 */
> >> +		if (qdisc_present) {
> >> +			rcu_read_unlock();
> >> +			return NETDEV_TX_BUSY;
> >> +		}
> >>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>  		goto drop;
> >>  	}
> >>  
> >>  	/* dev->lltx requires to do our own update of trans_start */
> >> -	queue = netdev_get_tx_queue(dev, txq);
> >>  	txq_trans_cond_update(queue);
> >>  
> >>  	/* Notify and wake up reader process */
> >> -- 
> >> 2.43.0
> > 

