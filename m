Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195A3D1712
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108174; cv=none; b=K5cnlbp7lNeuA/8coJA8LNdzWZQNKQai2gB1OfkzXlVuMm0F7KnFDCPBXnsk0ULnSzN4FJac4xyUcgD4WS5NSEdQJkZv+D+Jag2sXgvcbR9Rr9e80HqUQG9na1PxMDwV3Lf3SR/x5CJms3uH3EglGerZYxg6ntYo9GXh/IpUeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108174; c=relaxed/simple;
	bh=dM3TlIQgVWr1xfD/Lm0b3bvPVHqNBiyinGy2WrAxOQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lT7P4Fcmpwf82xpuAfSUgJJCY7Aepw5OiAt8QeoJ6j7dDI1x9g474h/IIjmaQoATjVExU6KRVnEZE0PXga6BJq24Fean+51GAxvUueve3XHOuITuGfY1TpkRvJm8k47yPIYHa4C3pXXwoU+5A2aVI65IdSS4Tg3BvFG0Tdpz0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDnYxgLa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDnYxgLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778108171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
	b=gDnYxgLaTSuQ++xAxp+kved5m7CVgjJ055l5LdYbc/iGde8NrVFMD4R3wbzwE5QM8bX+9X
	sqINbg2NYGk53gEu/uMcKlz6MIFbUSd3AaNMs0EuDo2ITwqm5hxOdbm6roD9TIe7w9ipBk
	AM1fFzy2WNdagfaZa4P2q8D+Irotyac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-T8vWvbJKOUSFXD7knnFS7g-1; Wed, 06 May 2026 18:56:10 -0400
X-MC-Unique: T8vWvbJKOUSFXD7knnFS7g-1
X-Mimecast-MFC-AGG-ID: T8vWvbJKOUSFXD7knnFS7g_1778108169
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso779085e9.0
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 15:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778108169; x=1778712969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
        b=nbc5ekIrtoDdmqSvp/KLWnp5rju3+7OMIdf/uKU0Kq4J4E8Lmj3DgFldyvSOEv2KX2
         qd9Q8VXcbhv0vug89ohYcH1/MqEKbx0lg01jqVdmXiV11WRl+PwPHvLYMDkdOGnf9sp1
         69ULWmAqiqlZgAy869lgLlShb1RryF3kKyb9GqUSileitmHaqa6ZhzMswMjHONYI8L4w
         SCjQRxbVDDXuVqQAEnnlq5d+Nuse1+wGSov3PQYSH/wibM9R4LY9Xxq9uJufNXw0otWA
         TWiD85L7OAV5nu6idvc6oKUPtTHCerrf2EQ7j4nMGInZE3yUoAX5tfD/co5hvtAeUbx/
         Mn5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+tkK4DBxAv7tFpW1g5+6EMpWZGUYb9K2jTPE55VAbd8qrrDpwopiEnwPSXX/+eiR4cgR/Iz7ESlmYpqvPATg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRuy2t+a0vslUzUnfZSflkWpZDcWJeCc4uN5gCnDBeh2y9ZGJf
	sdIKUZPXY9vsKQERsi6v+/sY0IFnugE+p6spwVS3YYYgIX2rvziHoDjD9+0TrHvmVm0Vj8WeoP0
	KQg6Ntszz9Awwu7sm7+/PBW3cSog7WWZp9xQDgDkBVJoYa1cETSvXGfAKNIpVMqr1E9o8
X-Gm-Gg: AeBDieuf6Wq81JqFHasny5vrOUIZ8Z8y0B/5zOiXbULTzx0BId0QagLQ4AuthLkQV98
	64IHi7RZFXO3QOxy2e7gEoAxrQlFD7GuylsUiArUmKK0/KKvWzmP5lDbDzVSzH3X9Wn6Gxz9AVu
	5Owx3JDvUNR2+D0uBQu27yHTuTfrmgNU8tP4au99vVjJeFD6NNDtJ5OOKT2I2WUezJpmNe+wuFB
	NbJPfiD7Y+kPla/J4N0wwxTu4nlwiwh2q886Lkjzcz+v41vxdXiBC8vED3OC9XyRgnV1bl0KSNE
	q2BLZ1xCu/clrBFUdnTG7hIVpLVbtwvMuMeLmUTbQAIi7QYzrwZ0Ki6bRiaag7TYwdfCVZ3lmI8
	OPRi1S91y9lhRrfRC1zuFbsjoNOk8IGpojQnGjFwh4lQEUeTixHtAkYa4ol9/OA==
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr87549915e9.16.1778108168898;
        Wed, 06 May 2026 15:56:08 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr87549685e9.16.1778108168416;
        Wed, 06 May 2026 15:56:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm16159726f8f.14.2026.05.06.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:56:07 -0700 (PDT)
Date: Wed, 6 May 2026 18:56:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v10 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260506185515-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
 <20260506181909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260506181909-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lga83mJbmk52qzKh4qP_1VCM1WyX_Loy1rN-6jzBXQM_1778108169
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2026 at 06:28:06PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 06, 2026 at 04:10:33PM +0200, Simon Schippers wrote:
> > This commit prevents tail-drop when a qdisc is present and the ptr_ring
> > becomes full. Once an entry is successfully produced and the ptr_ring
> > reaches capacity, the netdev queue is stopped instead of dropping
> > subsequent packets. If no qdisc is present, the previous tail-drop
> > behavior is preserved.
> > 
> > If producing an entry fails anyways due to a race, tun_net_xmit() drops
> > the packet. Such races are expected because LLTX is enabled and the
> > transmit path operates without the usual locking.
> > 
> > The __tun_wake_queue() function of the consumer races with the producer
> > for waking/stopping the netdev queue, which could result in a stalled
> > queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
> > with the smp_mb() of the consumer. It follows the principle of store
> > buffering described in tools/memory-model/Documentation/recipes.txt:
> > 
> > - The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
> >   followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
> >   ring with __ptr_ring_produce_peek().
> > 
> > - The consumer in __tun_wake_queue() first writes zero to the ring in
> >   __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
> >   status with netif_tx_queue_stopped().
> > 
> > => Following the aforementioned principle, it is impossible for the
> >    producer to see a full ring (and therefore not wake the queue on the
> >    re-check) while the consumer simultaneously fails to see a stopped
> >    queue (and therefore also does not wake it).
> > 
> > Benchmarks:
> > The benchmarks show a slight regression in raw transmission performance
> > when using two sending threads. Packet loss also occurs only in the
> > two-thread sending case; no packet loss was observed with a single
> > sending thread.
> > 
> > Test setup:
> > AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> > Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> > mitigations disabled.
> > 
> > Note for tap+vhost-net:
> > XDP drop program active in VM -> ~2.5x faster; slower for tap due to
> > more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> > 
> > +--------------------------+--------------+----------------+----------+
> > | 1 thread                 | Stock        | Patched with   | diff     |
> > | sending                  |              | fq_codel qdisc |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
> > |            +-------------+--------------+----------------+----------+
> > |            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
> > |            +-------------+--------------+----------------+----------+
> > | +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
> > +------------+-------------+--------------+----------------+----------+
> > 
> > +--------------------------+--------------+----------------+----------+
> > | 2 threads                | Stock        | Patched with   | diff     |
> > | sending                  |              | fq_codel qdisc |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
> > |            +-------------+--------------+----------------+----------+
> > |            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
> > |            +-------------+--------------+----------------+----------+
> > | +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
> > +------------+-------------+--------------+----------------+----------+
> > 
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index fc358c4c355b..d9ffbf88cfd8 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	struct netdev_queue *queue;
> >  	struct tun_file *tfile;
> >  	int len = skb->len;
> > +	int ret;
> >  
> >  	rcu_read_lock();
> >  	tfile = rcu_dereference(tun->tfiles[txq]);
> > @@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  	nf_reset_ct(skb);
> >  
> > -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> > +	queue = netdev_get_tx_queue(dev, txq);
> > +
> > +	spin_lock(&tfile->tx_ring.producer_lock);
> > +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> > +	if (!qdisc_txq_has_no_queue(queue) &&
> > +	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
> > +		netif_tx_stop_queue(queue);
> > +		/* Paired with smp_mb() in __tun_wake_queue() */
> > +		smp_mb__after_atomic();
> > +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> > +			netif_tx_wake_queue(queue);
> > +	}
> > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > +
> 
> There's a weird corner case here when tx_queue_len is 0
> but a qdisc has been configured - it looks like that
> currently it just drops all packets, with this change,
> the qdisc will get stuck permanently.
> 
> I suspect just checking tx_ring.size should fix it.
> Or if you feel adventurous, change return code for __ptr_ring_produce
> to distinguish between "no ring" and "no space".


__ptr_ring_produce_peek really.


> 
> > +	if (ret) {
> > +		/* This should be a rare case if a qdisc is present, but
> > +		 * can happen due to lltx.
> > +		 * Since skb_tx_timestamp(), skb_orphan(),
> > +		 * run_ebpf_filter() and pskb_trim() could have tinkered
> > +		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> > +		 * we must drop instead.
> > +		 */
> >  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >  		goto drop;
> >  	}
> >  
> >  	/* dev->lltx requires to do our own update of trans_start */
> > -	queue = netdev_get_tx_queue(dev, txq);
> >  	txq_trans_cond_update(queue);
> >  
> >  	/* Notify and wake up reader process */
> > -- 
> > 2.43.0

