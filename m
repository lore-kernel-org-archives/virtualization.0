Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF22254AE1
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180977; cv=none; b=rniy9dpMdpnhnz+KwObWSDY0zKkcMvc6yW150ESEU1nByytjS27gAIrwZHfs9/I1gx8AYS4GoJHgHxslj0efe4Qiw4KUrYbe301jUjROlfsIsASIZ/7NsbTrQ8yebiDO8z7XyvLALhihwpN5UrtaZjoixiknFNPQp+ry4fvy3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180977; c=relaxed/simple;
	bh=kyULVipYGXF8pQ4S/uAyjcoQp2UuofAj8by9h0Na7sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o4WR8qIGgdNTmzYUTSp+iR2f5SMHLRDbvRMa1Arb+wLRn1BP1vTX4PE5ODfwVujG9imST/LoMJ794vbDgu8qKoEPwZfR0SErScQxtEjic7uAG+UT0X+xF3rcCDUOJP84B4EffQTPRaK72Dk9G9U6ZYgwnfn8vc/Roik0brABhyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ut7db16c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ut7db16c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764180974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qZzdcbGa6XCDNLwt3NmSWbQLiICgwvwTMHTS5/gnpeU=;
	b=Ut7db16cA7rloEIP5c/6eFeTRVaEjy4hS0C7ke4K8lF7pPqPkefHrR0oyAo0ir9GMu55OS
	2TMfRd2jcCVNm8Kwha0jmaU1SDXJqI2GaJxGb5t1+XHgARvB6RdhG9iH4KO7b8hJvqe0SV
	2GJwGMD2JVB9w675GTFCR/YhNKhiBMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-fAPqI4FQMpS0_pihOsElUQ-1; Wed, 26 Nov 2025 13:16:13 -0500
X-MC-Unique: fAPqI4FQMpS0_pihOsElUQ-1
X-Mimecast-MFC-AGG-ID: fAPqI4FQMpS0_pihOsElUQ_1764180972
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso43858225e9.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 10:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180971; x=1764785771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZzdcbGa6XCDNLwt3NmSWbQLiICgwvwTMHTS5/gnpeU=;
        b=gFCu6iymlyov+VKFMZYLQLfINUydQZsI55wtWPLdqa8cpff3Sv0ej96RUyL53uhM+m
         /+SV4w0Z8EqR11wiqUYCRLuDKOTWYDdVXoRtV4AKLKe8UKurwDCCHvxwuqyxEcNG/5TH
         PB1MOOwQb1TbLOzYS+mQKgWIzRpx/+1HKmoiaVOGqe2Hwe+hLlIPq3nhW8UhHSnMx16R
         abmj9j8EoySgANB1D9xgs2CtagvYrbgV3EwbJ74pUHf/76QLhO19I+rgmUlwGJlhhU42
         YqMIA6niF97yYXzOsOu5gzccsMvClACjV4pU38joeGufLy/oLZlwr2Hai3gMdaSuYnIn
         vPGw==
X-Forwarded-Encrypted: i=1; AJvYcCXAeMY8oaqlxFRI1S1XgfzqMKKoMyDmHE/FoZSH7kxerIxUviSxMTPtuhK/6MbFQ6DGHLjyz9SutJcX/xTYwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsehefOxFibtjX77Ecc5TKzSYAUUwJ0dW1w2mFlOUxUtz2BoiV
	oMruBRHK4/c1vGPqh3iiMP70AzarBKmGtPUj8V8z3rvMgvBLDoTZfFcpZpcz3TsNV5JYB7EwQqe
	aSh0jZw5vrOMNqJUQjs0YZ/aWslXIPcFwn0dM5PH+GVsWEU2kF8OlT1CPrc5teCCY8+AS
X-Gm-Gg: ASbGnctOoedxuerStJgUOaef8Cfbc/Lp3YHYIz9xmUxHCC81nRIPLZArDVhOqHj6RLl
	Bp/P7jvyECUwKLW02PinDEB5PbUSctPvjouw9xNLx2sk4eHuVQZT1ml1UTfieaWH9zInFDP8Xk7
	meIwgZ0+3OxEyKfnDFk2RMdz+LpMYEFnXOEmZeKjLZ5W0bL6cr0NVRqOgGBV5ukVk3zi4+gK2Em
	U5AyxXhjr/2pmziBol24p5faPYovT7doOWXQ0+uA5GLWXBac8PQg5ANUIbAM2KNdUGIxjFtSBFb
	kAougDtokMICvfVLXKUrDh0InGCySnHtmDl1ivNP3gAu+nVq5dTxP1Isq6U83AUhO6gexPMRbEJ
	80hR2SvyvXTKdsxLXD03Ib+ziMPd0iw==
X-Received: by 2002:a05:600c:5252:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47904b248demr87345735e9.31.1764180970578;
        Wed, 26 Nov 2025 10:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgRL93Ppj04AXVDEje5Q42qgkdWU1MdkDElxcXzRopk1GruOFcZ+Ewr6pGrw/CAbF8TMGXHA==
X-Received: by 2002:a05:600c:5252:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47904b248demr87345385e9.31.1764180970053;
        Wed, 26 Nov 2025 10:16:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e598sm41453547f8f.4.2025.11.26.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:16:09 -0800 (PST)
Date: Wed, 26 Nov 2025 13:16:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	jon@nutanix.com, tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v6 3/8] tun/tap: add synchronized ring
 produce/consume with queue management
Message-ID: <20251126130226-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
 <20251125100655-mutt-send-email-mst@kernel.org>
 <4db234bd-ebd7-4325-9157-e74eccb58616@tu-dortmund.de>
 <20251126100007-mutt-send-email-mst@kernel.org>
 <c0fc512a-5bee-48da-9dfb-2b8101f3dec6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c0fc512a-5bee-48da-9dfb-2b8101f3dec6@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z8sVKwzC33t53XNySLqI8oCYxJZgd3cCviNwsroo9rc_1764180972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 05:04:25PM +0100, Simon Schippers wrote:
> On 11/26/25 16:25, Michael S. Tsirkin wrote:
> > On Wed, Nov 26, 2025 at 10:23:50AM +0100, Simon Schippers wrote:
> >> On 11/25/25 17:54, Michael S. Tsirkin wrote:
> >>> On Thu, Nov 20, 2025 at 04:29:08PM +0100, Simon Schippers wrote:
> >>>> Implement new ring buffer produce and consume functions for tun and tap
> >>>> drivers that provide lockless producer-consumer synchronization and
> >>>> netdev queue management to prevent ptr_ring tail drop and permanent
> >>>> starvation.
> >>>>
> >>>> - tun_ring_produce(): Produces packets to the ptr_ring with proper memory
> >>>>   barriers and proactively stops the netdev queue when the ring is about
> >>>>   to become full.
> >>>>
> >>>> - __tun_ring_consume() / __tap_ring_consume(): Internal consume functions
> >>>>   that check if the netdev queue was stopped due to a full ring, and wake
> >>>>   it when space becomes available. Uses memory barriers to ensure proper
> >>>>   ordering between producer and consumer.
> >>>>
> >>>> - tun_ring_consume() / tap_ring_consume(): Wrapper functions that acquire
> >>>>   the consumer lock before calling the internal consume functions.
> >>>>
> >>>> Key features:
> >>>> - Proactive queue stopping using __ptr_ring_full_next() to stop the queue
> >>>>   before it becomes completely full.
> >>>> - Not stopping the queue when the ptr_ring is full already, because if
> >>>>   the consumer empties all entries in the meantime, stopping the queue
> >>>>   would cause permanent starvation.
> >>>
> >>> what is permanent starvation? this comment seems to answer this
> >>> question:
> >>>
> >>>
> >>> 	/* Do not stop the netdev queue if the ptr_ring is full already.
> >>> 	 * The consumer could empty out the ptr_ring in the meantime
> >>> 	 * without noticing the stopped netdev queue, resulting in a
> >>> 	 * stopped netdev queue and an empty ptr_ring. In this case the
> >>> 	 * netdev queue would stay stopped forever.
> >>> 	 */
> >>>
> >>>
> >>> why having a single entry in
> >>> the ring we never use helpful to address this?
> >>>
> >>>
> >>>
> >>>
> >>> In fact, all your patch does to solve it, is check
> >>> netif_tx_queue_stopped on every consumed packet.
> >>>
> >>>
> >>> I already proposed:
> >>>
> >>> static inline int __ptr_ring_peek_producer(struct ptr_ring *r)
> >>> {
> >>>         if (unlikely(!r->size) || r->queue[r->producer])
> >>>                 return -ENOSPC;
> >>>         return 0;
> >>> }
> >>>
> >>> And with that, why isn't avoiding the race as simple as
> >>> just rechecking after stopping the queue?
> >>  
> >> I think you are right and that is quite similar to what veth [1] does.
> >> However, there are two differences:
> >>
> >> - Your approach avoids returning NETDEV_TX_BUSY by already stopping
> >>   when the ring becomes full (and not when the ring is full already)
> >> - ...and the recheck of the producer wakes on !full instead of empty.
> >>
> >> I like both aspects better than the veth implementation.
> > 
> > Right.
> > 
> > Though frankly, someone should just fix NETDEV_TX_BUSY already
> > at least with the most popular qdiscs.
> > 
> > It is a common situation and it is just annoying that every driver has
> > to come up with its own scheme.
> 
> I can not judge it, but yes, it would have made this patchset way
> simpler.
> 
> > 
> > 
> > 
> > 
> > 
> >> Just one thing: like the veth implementation, we probably need a
> >> smp_mb__after_atomic() after netif_tx_stop_queue() as they also discussed
> >> in their v6 [2].
> > 
> > yea makes sense.
> > 
> >>
> >> On the consumer side, I would then just do:
> >>
> >> __ptr_ring_consume();
> >> if (unlikely(__ptr_ring_consume_created_space()))
> >>     netif_tx_wake_queue(txq);
> >>
> >> Right?
> >>
> >> And for the batched consume method, I would just call this in a loop.
> > 
> > Well tun does not use batched consume does it?
> 
> tun does not but vhost-net does.
> 
> Since vhost-net also uses tun_net_xmit() as its ndo_start_xmit in a
> tap+vhost-net setup, its consumer must also be changed. Else
> tun_net_xmit() would stop the queue, but it would never be woken again.


Ah, ok.



> > 
> > 
> >> Thank you!
> >>
> >> [1] Link: https://lore.kernel.org/netdev/174559288731.827981.8748257839971869213.stgit@firesoul/T/#m2582fcc48901e2e845b20b89e0e7196951484e5f
> >> [2] Link: https://lore.kernel.org/all/174549933665.608169.392044991754158047.stgit@firesoul/T/#m63f2deb86ffbd9ff3a27e1232077a3775606c14d
> >>
> >>>
> >>> __ptr_ring_produce();
> >>> if (__ptr_ring_peek_producer())
> >>> 	netif_tx_stop_queue
> >>
> >> smp_mb__after_atomic(); // Right here
> >>
> >>> 	if (!__ptr_ring_peek_producer())
> >>> 		netif_tx_wake_queue(txq);
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> > 

