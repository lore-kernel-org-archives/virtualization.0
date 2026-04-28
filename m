Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67540F8E2
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385421; cv=none; b=bD0JXT1J1I/7Ujv9Zj2d0ZOqPr2CWyzFuL/K9QB0No+T0lcoZsqZXeJlgoJOopNjkWEoYvV8uPyXpG5EF9/ZKIGp4DQJphyDjDloaE0CTZiWdWWabWqiqJjOMk6qCIxWMN7WuBqUgAZ32eWP2XUCxVkeo/hxRCN/M476Pe7cuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385421; c=relaxed/simple;
	bh=aIlgWL9/0pGueQ0AKrJko6Zr82igCKUb4r8NWEDLG7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i9E+CHbyQVfaF+IifYZGQMYGaM319aO73mSyPT8syB/MAmFccebU6Y4o3gikTxJdxALlHnuF9jD6HjdvppeNY14nPMHhLecmocwFNZ3CB8D2mCj4j5T5J3OaqqZvyE5WaCm5WDdIQ2qU7Kr+TvoILknzwF1ro3puX4PEn5k6rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LanfYs5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LanfYs5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777385418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymlOvxmwGZ8VtNX0ef8EHtkI32hxd4KqndZm7HincXA=;
	b=LanfYs5+QQnr7hOmWYq6zW3kBxW2qNRfxc0jkjiOyDNTsWV+YGhRuKmzXOufPOPBcjwx13
	7hcaYDd5scUdZQcGuoLlghvVDigYZ3meUC4inA7kQpXCD6dtO/lM7ehOR1vaOfNwupo1Og
	18TAzPBVd/oI14AI9HergfAhJjlcUtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-60SVvYeaOambrdYbNXPp2Q-1; Tue, 28 Apr 2026 10:10:17 -0400
X-MC-Unique: 60SVvYeaOambrdYbNXPp2Q-1
X-Mimecast-MFC-AGG-ID: 60SVvYeaOambrdYbNXPp2Q_1777385416
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c768a9a9so74064625e9.1
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 07:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385416; x=1777990216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymlOvxmwGZ8VtNX0ef8EHtkI32hxd4KqndZm7HincXA=;
        b=qPzPdb6eqQD/hMDdWQ20+7JKmPVAIT7Nis5RkYQeuAvICqODbnh8ShCk/IKfHTPfsm
         TYVpnlCNbMlZaQYBTcGSA7d/SLN4Vhmen74wheJXiI7tJa8pH30O1N+KlbpKqFAopgqS
         aeqn0hcjdHJUuU4Qvj1pvg8tZp+EJiwQIAiodrEVJZEyXLiO2TPPbd0g2UMcoqNfk8dU
         RzbN+4OUGIq+C+si13KLHTzZH9S45IEz7InqUNUinNV3RfLFRoNMNrrUiyhE2emPFNU0
         Kir6uP+1Vs/nbNcx8kOCEoBGfPQpvo6I3mji1ekBBc/wGz5CBmU87OCEzXY4VAcULyYk
         dl0w==
X-Forwarded-Encrypted: i=1; AFNElJ+QPSi5/6qdyMHeI9u47qjPtfWMiDGowCVuxS/whthUYU6wgKFLgmy/Pgpv6H2SaptD6zc6D8jY+1XS/R132A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9r3931Q4sQspHMHDwGks4TQtUtp7IwYVrrCxR+MxZsI7W4WqF
	fpLBHK9/Ufu4L0DF8El1cVTBoCXfr93RoMYdjP22ohYAANQUGB1hAy2YLBxS54RFRjm7MFQXNEk
	+fed811cBy65CJZYocgxBd5+BF23jZAoTomid8ScXrstKXCALd/+SvZr8eyC5SbKB9isx
X-Gm-Gg: AeBDietzCQvJSw5KUZc469ONfzCtPU8hPR+He/lqjrND4rBDJroj5NBa/Fi7Czh1c1G
	xNVt/Ylv3URLYoECbFpZ23Z/tApkheSVJT3WWjtc3br+T8ZlCBHJgorDOrtdo8bNUKaPDk6nvdf
	8I4dGzTZebgs4ewuJ/oeSUS2YvVoQ/KbKetNr+2bQvhAR/e/NYM5ynyWf/6UbZTjTPM4pjItUzn
	NmiB4GMjtZBGMFbI6ur6plyiKpxzaOzhxMxD9vHRgFFnGaJxr50CkSfeUOQexbj7VR+CV/3G17c
	TYtZfKCup8GfBL7CRpYoApvtfq2+dnyL3xaYjz2/GJ7jNv33ZsY3dbIoHapI5UbpRBxPC1iXTzN
	JReu5fc9vbTc2fIGL34OOQ3dRL3EQ92JjtHVJ1DYnTsJOSn/fBYKD0bFg
X-Received: by 2002:a05:600c:138b:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48a77ae59c8mr53086345e9.7.1777385412742;
        Tue, 28 Apr 2026 07:10:12 -0700 (PDT)
X-Received: by 2002:a05:600c:138b:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48a77ae59c8mr53084375e9.7.1777385411078;
        Tue, 28 Apr 2026 07:10:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773aeb6dsm71069655e9.5.2026.04.28.07.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:10:09 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:10:05 -0400
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
Message-ID: <20260428100731-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
 <20260428092150-mutt-send-email-mst@kernel.org>
 <d00bea39-7748-46ad-9c31-27326041f03c@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d00bea39-7748-46ad-9c31-27326041f03c@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a4-iujRXShlqxtnjsV03wBvqPlvIlPucWeQyf7SBrLQ_1777385416
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2026 at 03:41:20PM +0200, Simon Schippers wrote:
> On 4/28/26 15:22, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> >> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> >>> On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >>>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >>>> becomes full. Once an entry is successfully produced and the ptr_ring
> >>>> reaches capacity, the netdev queue is stopped instead of dropping
> >>>> subsequent packets.
> >>>>
> >>>> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >>>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >>>> LLTX is enabled and the transmit path operates without the usual locking.
> >>>>
> >>>> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>>>
> >>>> The existing __tun_wake_queue() function of the consumer races with the
> >>>> producer for waking/stopping the netdev queue: the consumer may drain
> >>>> the ring just as the producer stops the queue, leading to a permanent
> >>>> stall. To avoid this, the producer re-checks the ring after stopping
> >>>> and wakes the queue itself if space was just made. An
> >>>> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >>>> drain that the consumer performed.
> >>>> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >>>> netif_wake_subqueue():
> >>>>
> >>>> Consumer CPU                  Producer CPU
> >>>> ========================      =========================
> >>>> __ptr_ring_consume()
> >>>> netif_wake_subqueue()         netif_tx_stop_queue()
> >>>>           /\                  smp_mb__after_atomic()
> >>>>           ||                  __ptr_ring_produce_peek()
> >>>> contains RMW operation
> >>>>  test_and_clear_bit()
> >>>>           /\
> >>>>           ||
> >>>>  "Fully ordered RMW:
> >>>> smp_mb() before + after"
> >>>>     - atomic_t.txt
> >>>>
> >>>> Benchmarks:
> >>>> The benchmarks show a slight regression in raw transmission performance,
> >>>> though no packets are lost anymore.
> >>>
> >>> Could you include the packets received as well?
> >>> To demonstrate the gains/lack of loss. 
> >>>
> >>
> >> Do you mean the number of packets received by the VM?
> >> They should just be the same as the number sent (shown below), right?
> > 
> > Minus the loss? Which this is about, right?
> 
> Yes. I simply calculated "Lost/s":
> 
> elapsed_time = 100e6 / sent_pps
> Lost/s = total_errors / elapsed_time
> 
> 
> To get back total_errors for example for TAP
> 1 thread sending:
> 
> elapsed_time = 100e6 / 1.136Mpps = 88s
> 
> 3758 Mpps = total_errors / 88s
> <=> total_errors = 331 million packets
> 
> So, out of 431 million packets sent, 100 million were successfully
> delivered and 331 million were lost.

That is my issue.

I kind of have trouble mapping that to the table below.
For example:

 | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
 |            +-------------+--------------+----------------+----------+
 |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |

how can # of lost packets exceed the # of transmitted packets?

Thanks!


> > 
> >> I assume they would be visible as RX-DRP for TAP.
> >> For TAP + vhost-net I would have to rewrite the XDP drop
> >> program to count the number of dropped packets...
> >> And I would have to automate it...
> >>
> >>>>
> >>>> The previously introduced threshold to only wake after the queue stopped
> >>>> and half of the ring was consumed showed to be a descent choice:
> >>>> Waking the queue whenever a consume made space in the ring strongly
> >>>> degrades performance for tap, while waking only when the ring is empty
> >>>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>>> tun/tap+vhost-net.
> >>>>
> >>>> Test setup:
> >>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>>> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >>>> mitigations disabled.
> >>>>
> >>>> Note for tap+vhost-net:
> >>>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>>>
> >>>> +--------------------------+--------------+----------------+----------+
> >>>> | 1 thread                 | Stock        | Patched with   | diff     |
> >>>> | sending                  |              | fq_codel qdisc |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>>
> >>>> +--------------------------+--------------+----------------+----------+
> >>>> | 2 threads                | Stock        | Patched with   | diff     |
> >>>> | sending                  |              | fq_codel qdisc |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index efe809597622..c2a1618cc9db 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>  	struct netdev_queue *queue;
> >>>>  	struct tun_file *tfile;
> >>>>  	int len = skb->len;
> >>>> +	bool qdisc_present;
> >>>> +	int ret;
> >>>>  
> >>>>  	rcu_read_lock();
> >>>>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >>>> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>  
> >>>>  	nf_reset_ct(skb);
> >>>>  
> >>>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>>> +	queue = netdev_get_tx_queue(dev, txq);
> >>>> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >>>> +
> >>>> +	spin_lock(&tfile->tx_ring.producer_lock);
> >>>> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >>>> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >>>> +		netif_tx_stop_queue(queue);
> >>>> +		/* Re-peek and wake if the consumer drained the ring
> >>>> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >>>> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >>>> +		 * in __tun_wake_queue().
> >>>> +		 */
> >>>> +		smp_mb__after_atomic();
> >>>> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>>> +			netif_tx_wake_queue(queue);
> >>>> +	}
> >>>> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >>>> +
> >>>> +	if (ret) {
> >>>> +		/* If a qdisc is attached to our virtual device,
> >>>> +		 * returning NETDEV_TX_BUSY is allowed.
> >>>> +		 */
> >>>> +		if (qdisc_present) {
> >>>> +			rcu_read_unlock();
> >>>> +			return NETDEV_TX_BUSY;
> >>>> +		}
> >>>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>>>  		goto drop;
> >>>>  	}
> >>>>  
> >>>>  	/* dev->lltx requires to do our own update of trans_start */
> >>>> -	queue = netdev_get_tx_queue(dev, txq);
> >>>>  	txq_trans_cond_update(queue);
> >>>>  
> >>>>  	/* Notify and wake up reader process */
> >>>> -- 
> >>>> 2.43.0
> >>>
> > 

