Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2F331A72
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170755; cv=none; b=lAFbW2/Idgh3lX66gJ6qkkFOFZMeLv70Sf7179l5fBqesOuoZksFPyOqUBxTJUr9H+oXyNSeZeiTSE4VrHpX8WTm0Vrm3orTLDydhOdi6kFJU7N9Rxzj99Tsr/Eo+x/5eoWKv63JMjO8LfQKaF4LnVw2S3vM0EOfmWUJzK6LYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170755; c=relaxed/simple;
	bh=MlNy/atfOJbZCeA0q/MGoSHM0JWfj9pD6YlEmXsdmCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m5rvDnUmUQ2PzLcvhjBOeIYLsTwTTE2zRowKiyZ44ukLSwZPiA2R5fPvRrxvQDk8lx7hplb8fUi3tYgS6TSIHmpc1Nx4L2rStWzvbKagTs+Kjz1nbCLhC0mDs0PwmNfkuHSf36E7J4AZYR/p9dQqX6iyDGYlZ3V6hf2cJN0klHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlPbdJim; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlPbdJim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764170752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdOd/whsaB5ha6Xltts70lCb5PGc5f2tglKc7q062f4=;
	b=QlPbdJimjippuKa4JyrQxKtfkC5TlOoI+8bLgGwb6AryKJFBApO2SMcd5B4VPhb4lQmBU5
	EFX29A9bmG3B6qjURlHRcBxc42igiBoCASGO+mLOBtt3Ac0XY8lJxDadrb9hJDbULaOo8r
	TLjLIRJt7AlBYN/D3OQEtUjcoOEVH6I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-30VlThMuOQOqppIuvhCMNw-1; Wed, 26 Nov 2025 10:25:51 -0500
X-MC-Unique: 30VlThMuOQOqppIuvhCMNw-1
X-Mimecast-MFC-AGG-ID: 30VlThMuOQOqppIuvhCMNw_1764170750
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3086a055so6518336f8f.3
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 07:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764170749; x=1764775549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdOd/whsaB5ha6Xltts70lCb5PGc5f2tglKc7q062f4=;
        b=GvHSOblNkGgMpVWTBS3ItXQIDG0+hb1/1kwRExL/Ho9l2weTdThKdCZ+DZKi0g6SsO
         O5WLMBYIGMvy4c/PcxEX6GLmroy0ZHoaTi46zStwxvjzgBmbyLRg3++3FgHfq0Dk636m
         h1Izh/q3WA5NDpEjvYmmX5y+7gzKhkF/rjadPWS/x1JKbcShaEM/DuArZE5O9v2onRIY
         YCp0Ybki8IhzRaJt3Vb2B3FEAM3+Hh+7V7ZQyceMrOTO8KlXzi+NGGvkyJAxT0uodJVT
         y6wuO6MIoPZcNWxE3gHLCVyzBcq265ClwT12EF2go7mq8U/IV5L+iD9CMn9BRyx01R7y
         kx6w==
X-Forwarded-Encrypted: i=1; AJvYcCUGa/YVXdjiccGu3T5oxJrqA/dMHsyM1KwR3qxBNZgYv8S68eP5glrxmlwxeaQ8hDldMF+JXqAjjDpVWwBW/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz++289+L/hj+8yQ9MPYtZfxndz572dDVBIjDXHfLKcXFMGm3wD
	tXXgS2+6PkH6mcujauTwtA3WQc9L6hYxBJ4WDhHic0m16Ch/S1TNW58V8OTLlhslD5QmKZPR1Vm
	RVlYNnuvRNLQskp3RiS6FEPQee242Quf6ZLqgc0GoE4t2qHwPmlsF20A3192llfxYu0NV
X-Gm-Gg: ASbGncuX23AhVJQg2iWj3vx6Ey+f4cNLdaNBrhbhBhJh3vKnyVueu3FLEmlqCLMygR5
	As4iNuLQPbNy8Imajo/w3m8P0AiC3s/8RH24kymzq/rvBTxrfP1TwxFlJ530f1q5nwVE5BHvM9W
	cZrlZG6G4vfHionyt4FNuWBH5zti/q+HggaQqt1/om9ByWzFxLR7x/vpMk3r7ahjpuOZ6zvvmiE
	KvpsFWmMICuAENpXnUMqYoPJneEjBoSMr/n/UzzLk1thjPVL6Q+heqXfG5cNtOAyw1Np7fzuRfp
	rYTVDCYTiYlQ2LCe3w4Xa0pr+noyR6UeTjRQXGaA8lnYs6JXtDb5XK7c56dM6TPwP1TvEwOMEgP
	Z2Pl+0dXnI8ZL3jL0XHxsDopa3FXMKQ==
X-Received: by 2002:a05:6000:2489:b0:42b:3a84:1ee6 with SMTP id ffacd0b85a97d-42e0f22a2c8mr8023531f8f.24.1764170748930;
        Wed, 26 Nov 2025 07:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+KQvLghlDUQh9afZD+PVNCo1iNTuBYw29hyUe/fgigkK4QndBh9YrGoJcdMGDn9uA+ZGhNA==
X-Received: by 2002:a05:6000:2489:b0:42b:3a84:1ee6 with SMTP id ffacd0b85a97d-42e0f22a2c8mr8023493f8f.24.1764170748385;
        Wed, 26 Nov 2025 07:25:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e581sm38903906f8f.8.2025.11.26.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:25:47 -0800 (PST)
Date: Wed, 26 Nov 2025 10:25:44 -0500
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
Message-ID: <20251126100007-mutt-send-email-mst@kernel.org>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-4-simon.schippers@tu-dortmund.de>
 <20251125100655-mutt-send-email-mst@kernel.org>
 <4db234bd-ebd7-4325-9157-e74eccb58616@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4db234bd-ebd7-4325-9157-e74eccb58616@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IylbW3yp5Rn3_8snG32vtZquGNCuJjJIuYTsnxwXu6o_1764170750
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 10:23:50AM +0100, Simon Schippers wrote:
> On 11/25/25 17:54, Michael S. Tsirkin wrote:
> > On Thu, Nov 20, 2025 at 04:29:08PM +0100, Simon Schippers wrote:
> >> Implement new ring buffer produce and consume functions for tun and tap
> >> drivers that provide lockless producer-consumer synchronization and
> >> netdev queue management to prevent ptr_ring tail drop and permanent
> >> starvation.
> >>
> >> - tun_ring_produce(): Produces packets to the ptr_ring with proper memory
> >>   barriers and proactively stops the netdev queue when the ring is about
> >>   to become full.
> >>
> >> - __tun_ring_consume() / __tap_ring_consume(): Internal consume functions
> >>   that check if the netdev queue was stopped due to a full ring, and wake
> >>   it when space becomes available. Uses memory barriers to ensure proper
> >>   ordering between producer and consumer.
> >>
> >> - tun_ring_consume() / tap_ring_consume(): Wrapper functions that acquire
> >>   the consumer lock before calling the internal consume functions.
> >>
> >> Key features:
> >> - Proactive queue stopping using __ptr_ring_full_next() to stop the queue
> >>   before it becomes completely full.
> >> - Not stopping the queue when the ptr_ring is full already, because if
> >>   the consumer empties all entries in the meantime, stopping the queue
> >>   would cause permanent starvation.
> > 
> > what is permanent starvation? this comment seems to answer this
> > question:
> > 
> > 
> > 	/* Do not stop the netdev queue if the ptr_ring is full already.
> > 	 * The consumer could empty out the ptr_ring in the meantime
> > 	 * without noticing the stopped netdev queue, resulting in a
> > 	 * stopped netdev queue and an empty ptr_ring. In this case the
> > 	 * netdev queue would stay stopped forever.
> > 	 */
> > 
> > 
> > why having a single entry in
> > the ring we never use helpful to address this?
> > 
> > 
> > 
> > 
> > In fact, all your patch does to solve it, is check
> > netif_tx_queue_stopped on every consumed packet.
> > 
> > 
> > I already proposed:
> > 
> > static inline int __ptr_ring_peek_producer(struct ptr_ring *r)
> > {
> >         if (unlikely(!r->size) || r->queue[r->producer])
> >                 return -ENOSPC;
> >         return 0;
> > }
> > 
> > And with that, why isn't avoiding the race as simple as
> > just rechecking after stopping the queue?
>  
> I think you are right and that is quite similar to what veth [1] does.
> However, there are two differences:
> 
> - Your approach avoids returning NETDEV_TX_BUSY by already stopping
>   when the ring becomes full (and not when the ring is full already)
> - ...and the recheck of the producer wakes on !full instead of empty.
> 
> I like both aspects better than the veth implementation.

Right.

Though frankly, someone should just fix NETDEV_TX_BUSY already
at least with the most popular qdiscs.

It is a common situation and it is just annoying that every driver has
to come up with its own scheme.





> Just one thing: like the veth implementation, we probably need a
> smp_mb__after_atomic() after netif_tx_stop_queue() as they also discussed
> in their v6 [2].

yea makes sense.

> 
> On the consumer side, I would then just do:
> 
> __ptr_ring_consume();
> if (unlikely(__ptr_ring_consume_created_space()))
>     netif_tx_wake_queue(txq);
> 
> Right?
> 
> And for the batched consume method, I would just call this in a loop.

Well tun does not use batched consume does it?


> Thank you!
> 
> [1] Link: https://lore.kernel.org/netdev/174559288731.827981.8748257839971869213.stgit@firesoul/T/#m2582fcc48901e2e845b20b89e0e7196951484e5f
> [2] Link: https://lore.kernel.org/all/174549933665.608169.392044991754158047.stgit@firesoul/T/#m63f2deb86ffbd9ff3a27e1232077a3775606c14d
> 
> > 
> > __ptr_ring_produce();
> > if (__ptr_ring_peek_producer())
> > 	netif_tx_stop_queue
> 
> smp_mb__after_atomic(); // Right here
> 
> > 	if (!__ptr_ring_peek_producer())
> > 		netif_tx_wake_queue(txq);
> > 
> > 
> > 
> > 
> > 
> > 
> > 

