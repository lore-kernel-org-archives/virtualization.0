Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A202340A6B
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386755; cv=none; b=Vu4knQQ5yXG5Z03AYTX0w6FVDIRmMIa9uliixz12JpNpIUdYV7bXX+bOjaOTanEkC6rcOcO2loWmsOjEZQOGPifIOfkRh45AO7YUt5Bi39KLS2bzg4opLi5hPSBCE3E4UY9Pr+R/E0xtPKWP6JX0lZT+IDWFinrT3A6SD539Y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386755; c=relaxed/simple;
	bh=PflM0WAo79zj/vrmft2LxB9enula3rWFzuEZCd/m0Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bX6HgJsLaF53LvcCIAXA3QAuTeRur3rzYnnAbTp7DVBmLndUp0+0p4d6ay8I62vwtEWPa5nsr2FTlJhIo/GXuYvZ21Cy58MEVl3xXQ04PDd9/Qc2wnViqbcw2DshNcR1lLd4XnREXeODw3cXBvp/Y4C0+0BDIihQ2eprT13otoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jhaogm61; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jhaogm61"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777386752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy+Zqi/x02FVQVkOBreJZs+wOKUpsU6s7p7xuZL/QrU=;
	b=Jhaogm61/0fd4EsqLjH0OP/CcH7BczdLldXBKo8Mu1eB5Jl/5l8Qlt5J9Hw++9HX9pWPNA
	fwPxsgAUthzdUXNPTqqJGhF/EyaVKyGmY6oFhyv7QYvzzeQixmjABvaXBjwEf5ixI9FkYQ
	e1F5iM8NsaQ1i3Pk7G25r7YyGh8W/qw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-JXKJq7PAMSyMlGHSiWoIzg-1; Tue, 28 Apr 2026 10:32:31 -0400
X-MC-Unique: JXKJq7PAMSyMlGHSiWoIzg-1
X-Mimecast-MFC-AGG-ID: JXKJq7PAMSyMlGHSiWoIzg_1777386750
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7d0947aeso6953024f8f.3
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 07:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386750; x=1777991550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy+Zqi/x02FVQVkOBreJZs+wOKUpsU6s7p7xuZL/QrU=;
        b=KG8gNrwuYz3gjDkxUIvO3oMPKkWm8VRmhbBLRkj8pXGaJp1W3DUwjKvDzfkcsg+Tcg
         GEcCrfLNm4HMVrQQ2ElZI+VUeqnfdS8FDhH1fieAS+mJF3DidezbKMmTIwuP1p7o3sql
         8Rdy1ynrm8yMiM9nHW55s8Larxm3AK//ngRc3e8Ksj1wyxbd5b3ELSO8/7c8bvKxNgiL
         nHg57frueS+vkiE0FMnCC5Y4LfO086oFm6SG1Zk1bGwZlDgcGDyxmI9Dz2LEKGjAdE/D
         OO4eI4OuFKY96Q6Ra/VFV3Tk+7h9coSK/AFp+kfxygCMb0550SxpWbUfiPyoXwW6DXPy
         zQfQ==
X-Forwarded-Encrypted: i=1; AFNElJ975cK9b0jy8gEzgCZgnI2pMxBPJTabxJcy1X7gfpRTS87x6A2laZCcCeQwW5InUhy+7r1YClkl4NGrxo8nRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqh+bC3aQFQmqZYMveCdT8gALBs0g2HtQANq/Ecm5bllM5/YZ+
	BBkaJ87XHYwWtMy624hbt+SmgfTXIQ8jywOISXqbA0fO6VO380pvm8sEMAcM/nYZg5qV7GjMzCJ
	GhgLh/0qzq0u15WUYDBm+dIiJqyE6FrXB/QfIzul4hUXW74blWdlS0Ubd1yfZsJKcHo9Z
X-Gm-Gg: AeBDiet+3tTl55xA8OSG+MktcNhRVNJhSN7b6cvfZkn11XTF3TFXiBs1gCAkap7Gs7B
	mD9Z7L5Bu9bzYpmySNRZgap5qIzg6R1gwfnCUeV1DshJINfI3rcV4aTkZJxMSa5VW0m4ON6kcNZ
	IQffGtqQUhyhigsQjGhhGvilT14IIicUJxGUbGnaTW8fIk/BtYOh06ztyNqiQbPC9VKj8rwVtK+
	k9PTWswuGBnKTrvNBoqFbpN4WFlX5zF0qiFlbLj0pgUNvDkosBdCvQYZRPdsBzuBhAPmFxXJHOf
	ivlQ4ZiYtc2j3V4Bhc+AJ7zypIPqa1vfE6GwNUfr5CQkB2oJ7jZCozgWHddif22/d8z+8BQxcxd
	M2dj0xRhIUSbv95CL2PpLYWMa4Nb9FiB1vGQcg+WUrPBYny31/DUKTTXQ
X-Received: by 2002:a05:6000:24c3:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-4464b86e6a0mr6214106f8f.41.1777386744697;
        Tue, 28 Apr 2026 07:32:24 -0700 (PDT)
X-Received: by 2002:a05:6000:24c3:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-4464b86e6a0mr6213603f8f.41.1777386740512;
        Tue, 28 Apr 2026 07:32:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f4c0b23sm6873138f8f.21.2026.04.28.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:32:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:32:16 -0400
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
Message-ID: <20260428103108-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
 <20260428092150-mutt-send-email-mst@kernel.org>
 <d00bea39-7748-46ad-9c31-27326041f03c@tu-dortmund.de>
 <20260428100731-mutt-send-email-mst@kernel.org>
 <f4274173-23ef-43c3-aab4-b64678b440ec@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f4274173-23ef-43c3-aab4-b64678b440ec@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZVjk_tHqRCixUk2CfufcGzK6lLXlsl5fI-9QehwjGmI_1777386750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2026 at 04:18:54PM +0200, Simon Schippers wrote:
> On 4/28/26 16:10, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 03:41:20PM +0200, Simon Schippers wrote:
> >> On 4/28/26 15:22, Michael S. Tsirkin wrote:
> >>> On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> >>>> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> >>>>> On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >>>>>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >>>>>> becomes full. Once an entry is successfully produced and the ptr_ring
> >>>>>> reaches capacity, the netdev queue is stopped instead of dropping
> >>>>>> subsequent packets.
> >>>>>>
> >>>>>> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >>>>>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >>>>>> LLTX is enabled and the transmit path operates without the usual locking.
> >>>>>>
> >>>>>> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>>>>>
> >>>>>> The existing __tun_wake_queue() function of the consumer races with the
> >>>>>> producer for waking/stopping the netdev queue: the consumer may drain
> >>>>>> the ring just as the producer stops the queue, leading to a permanent
> >>>>>> stall. To avoid this, the producer re-checks the ring after stopping
> >>>>>> and wakes the queue itself if space was just made. An
> >>>>>> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >>>>>> drain that the consumer performed.
> >>>>>> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >>>>>> netif_wake_subqueue():
> >>>>>>
> >>>>>> Consumer CPU                  Producer CPU
> >>>>>> ========================      =========================
> >>>>>> __ptr_ring_consume()
> >>>>>> netif_wake_subqueue()         netif_tx_stop_queue()
> >>>>>>           /\                  smp_mb__after_atomic()
> >>>>>>           ||                  __ptr_ring_produce_peek()
> >>>>>> contains RMW operation
> >>>>>>  test_and_clear_bit()
> >>>>>>           /\
> >>>>>>           ||
> >>>>>>  "Fully ordered RMW:
> >>>>>> smp_mb() before + after"
> >>>>>>     - atomic_t.txt
> >>>>>>
> >>>>>> Benchmarks:
> >>>>>> The benchmarks show a slight regression in raw transmission performance,
> >>>>>> though no packets are lost anymore.
> >>>>>
> >>>>> Could you include the packets received as well?
> >>>>> To demonstrate the gains/lack of loss. 
> >>>>>
> >>>>
> >>>> Do you mean the number of packets received by the VM?
> >>>> They should just be the same as the number sent (shown below), right?
> >>>
> >>> Minus the loss? Which this is about, right?
> >>
> >> Yes. I simply calculated "Lost/s":
> >>
> >> elapsed_time = 100e6 / sent_pps
> >> Lost/s = total_errors / elapsed_time
> >>
> >>
> >> To get back total_errors for example for TAP
> >> 1 thread sending:
> >>
> >> elapsed_time = 100e6 / 1.136Mpps = 88s
> >>
> >> 3758 Mpps = total_errors / 88s
> >> <=> total_errors = 331 million packets
> >>
> >> So, out of 431 million packets sent, 100 million were successfully
> >> delivered and 331 million were lost.
> > 
> > That is my issue.
> > 
> > I kind of have trouble mapping that to the table below.
> > For example:
> > 
> >  | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >  |            +-------------+--------------+----------------+----------+
> >  |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> > 
> > how can # of lost packets exceed the # of transmitted packets?
> > 
> > Thanks!
> 
> I just do use the sample script [1]:
> 
> ./pktgen_sample02_multiqueue.sh -n 100000000 ...
> 
> ... and this runs until 100_000_000 packets were sucessfully
> transmitted, independently of the lost packets/errors.
> 
> [1] Link: https://www.kernel.org/doc/html/latest/networking/pktgen.html#sample-scripts

Confused. Are you saying "transmitted" is actually "received"? And the #
of packets sent is Transmitted + Lost?

> > 
> > 
> >>>
> >>>> I assume they would be visible as RX-DRP for TAP.
> >>>> For TAP + vhost-net I would have to rewrite the XDP drop
> >>>> program to count the number of dropped packets...
> >>>> And I would have to automate it...
> >>>>
> >>>>>>
> >>>>>> The previously introduced threshold to only wake after the queue stopped
> >>>>>> and half of the ring was consumed showed to be a descent choice:
> >>>>>> Waking the queue whenever a consume made space in the ring strongly
> >>>>>> degrades performance for tap, while waking only when the ring is empty
> >>>>>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>>>>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>>>>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>>>>> tun/tap+vhost-net.
> >>>>>>
> >>>>>> Test setup:
> >>>>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>>>>> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >>>>>> mitigations disabled.
> >>>>>>
> >>>>>> Note for tap+vhost-net:
> >>>>>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >>>>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>>>>>
> >>>>>> +--------------------------+--------------+----------------+----------+
> >>>>>> | 1 thread                 | Stock        | Patched with   | diff     |
> >>>>>> | sending                  |              | fq_codel qdisc |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>>
> >>>>>> +--------------------------+--------------+----------------+----------+
> >>>>>> | 2 threads                | Stock        | Patched with   | diff     |
> >>>>>> | sending                  |              | fq_codel qdisc |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>>
> >>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>> ---
> >>>>>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>>>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>> index efe809597622..c2a1618cc9db 100644
> >>>>>> --- a/drivers/net/tun.c
> >>>>>> +++ b/drivers/net/tun.c
> >>>>>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>>>  	struct netdev_queue *queue;
> >>>>>>  	struct tun_file *tfile;
> >>>>>>  	int len = skb->len;
> >>>>>> +	bool qdisc_present;
> >>>>>> +	int ret;
> >>>>>>  
> >>>>>>  	rcu_read_lock();
> >>>>>>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >>>>>> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>>>  
> >>>>>>  	nf_reset_ct(skb);
> >>>>>>  
> >>>>>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>>>>> +	queue = netdev_get_tx_queue(dev, txq);
> >>>>>> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >>>>>> +
> >>>>>> +	spin_lock(&tfile->tx_ring.producer_lock);
> >>>>>> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >>>>>> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >>>>>> +		netif_tx_stop_queue(queue);
> >>>>>> +		/* Re-peek and wake if the consumer drained the ring
> >>>>>> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >>>>>> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >>>>>> +		 * in __tun_wake_queue().
> >>>>>> +		 */
> >>>>>> +		smp_mb__after_atomic();
> >>>>>> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>>>>> +			netif_tx_wake_queue(queue);
> >>>>>> +	}
> >>>>>> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >>>>>> +
> >>>>>> +	if (ret) {
> >>>>>> +		/* If a qdisc is attached to our virtual device,
> >>>>>> +		 * returning NETDEV_TX_BUSY is allowed.
> >>>>>> +		 */
> >>>>>> +		if (qdisc_present) {
> >>>>>> +			rcu_read_unlock();
> >>>>>> +			return NETDEV_TX_BUSY;
> >>>>>> +		}
> >>>>>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>>>>>  		goto drop;
> >>>>>>  	}
> >>>>>>  
> >>>>>>  	/* dev->lltx requires to do our own update of trans_start */
> >>>>>> -	queue = netdev_get_tx_queue(dev, txq);
> >>>>>>  	txq_trans_cond_update(queue);
> >>>>>>  
> >>>>>>  	/* Notify and wake up reader process */
> >>>>>> -- 
> >>>>>> 2.43.0
> >>>>>
> >>>
> > 

