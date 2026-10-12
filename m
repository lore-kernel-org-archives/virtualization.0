Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117F475327
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843473; cv=none; b=ucGUmNcDpYuVTk9rLyHTaHx8EEeItdYare0d0u6mhtLIhT2HLsoHwGhwA5bfCiEVqZEooHIylEVs4oD0P7Fih7A16ZGfYraCAEIMVy4aY2x8eT0vryMzYcEr44N+dMNh+3I2RZlOBwWpH0pJVJnH4soW5fVj81YnRZwe4xiUmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843473; c=relaxed/simple;
	bh=gtoYvpUKjEumvZ9NZ4lgt37kt3RngiiSW4yRL0iX9gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSGlEMat2DMRUgxH8pqBLWNa19NVIeSWCIELI1afegyfkbgsDl8BEwTe1dz8EuhBzCYbUENf6i7To5EZMRvUi2GEbAjJK4BYNJDXmfoogVdOJChn1rgpyt6xWg49b7MsW1JQwpX4VfFtkTJOaRwA3KlIFLf0HYA6N8/R7RiuK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGCWrALl; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGCWrALl"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a6bb779d13so305706fac.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791843470; x=1792448270; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F68EtWrkn2Wfb2ayNm/k6SKK8v3U+BQEExnVnz6byuA=;
        b=NGCWrALlwlboqyXZpqfNDxADfgUBX6nbEiCP4hXpM3jx8ELMLr9Gz0Drj3yVb8JhUn
         8ptBbLdBYF+DX34+iCL21Q03/hWqkyNkY0svTq/lv7e1f8/ZoCShVR77VICsPA+dN8WL
         tvP3teb/Yj/vkPn8RFZu+4fS3msBkmLIVPDLRwUhrHwNfFOZUj/Vfvhe2S63vPeQsLt8
         MsjU2oLPEHHCa5Nd45Z8c4LgsYpgs9Ig7iQ4QBie1uWUEugsqUDRkho3YgJ34X6uRLHv
         3ipAMidH+YwgGboJ+uqKM+uP6eIMGVQsDanoZGVsDKFPrIIpObBOf5NJ/AXQ5KFA+IRS
         xTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791843470; x=1792448270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F68EtWrkn2Wfb2ayNm/k6SKK8v3U+BQEExnVnz6byuA=;
        b=sVM9xI7KmJQ5WZOPybr+iIR9o/wdaEiVKeMKcsy4T+iyp8v/3AP2lZHQB69AAM27J3
         27nIO3JFASRtOLUbWoKMucAMUoSTlPBOwZUKVMxddqSW7hz25tm9eib+LU5GPsAZtHi2
         44B7DzUIfUp8Nq8rGUe2A3GfOFtnUQIhzWuUv3aUv6BeNr1XKXPPDh5iQFK3ucHZJl/i
         SYFvB9mlJb0PPfnfwchn1NGpHfAJeLxAW4RFUk1kVewOGDxRoouH2hKFiaC+kUSJM1yM
         7ks9sNCNyTLQn6y+WeYBOCctM4767gQpXPLuSFLoHc9/elOveTeDoQEbkNC+KBAyqzhf
         1q3A==
X-Forwarded-Encrypted: i=1; AKwUvByDgidrFEswl567xLIP+mNv+yp+kY9qK4Kjw4ygmiZ6QSDRmjiS3RKgUOEAfg4WAfC7msHtagYO/ElSfSrCTw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJaXvClBd5rfSg60tUgL3fsIuXEbUd7RACZSQUxCeEmk2O07gX1
	Po7P7qbp1xtxmDZved8wSgOBCnqpnguuolsME1EjE6ay2HgKCkSAQsJ6
X-Gm-Gg: AYBFou3srm9PpxmHKxvMS2n0t/Fz1KhcqVIWwHHbzxJSlI+yQxx4qZblGWFFJE8lyjU
	yGXSyHtEc1eMFZTQcBwAiDFLZLNqK9U4oneR3lOU9h55DCNvg6KO8WwDAJMTQ52K+fLYj7G8Dwh
	ltGhFjraGhCwy71vIEPoCSC73YMmemRN+W6Iift54PtoYCechKPvhNtekKbVjw7oi0GQ1vonUJV
	aGAMMoOZWNU4ez85FfPDXynRCx2Efk3OlelxTjSz5LbDVj43oCJ7o5t8KXOx98aKte40oPbo9nI
	YnZ1wAI3pK1JQ7FfrLZpA2TTFIQEg8ab7F1phu0dRQRCSFWglp9SUuod29HyRKE1zv2KjEC8h3v
	fPWZigiI64otEcOgilsXP5MMmYrES8RJGgU3uh6IjrUPQv6uBcwefQPk1rHxK78RHswNT9hTUTR
	BKt/vYFewzomnODr6OM0m22Y/kC/6zhEqoUacFUKQxg/1w8v8rxx+UjyHz8iMAK/AUWaWn1CbyH
	4DsMgEdmJdosrjz0+J8
X-Received: by 2002:a05:6870:c213:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-4a2a8955927mr10013926fac.10.1791843470199;
        Mon, 12 Oct 2026 15:17:50 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a85edf81sm10977018fac.15.2026.10.12.15.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:17:48 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:17:45 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
Message-ID: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-4-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> An RX lock batch still looks up the socket for every packet and takes a
> temporary lookup reference, even though the batch already holds a reference
> to the locked socket.
> 
> Record the network namespace and packet address tuple when a batch starts.
> Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> release the batch before looking up a different flow.
> 
> The cached path still traces every packet, takes an skb owner reference,
> validates socket state, source and transport, updates credit, and runs the
> receive state machine. Only the socket table lookup and its temporary
> reference are skipped.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  include/linux/virtio_vsock.h            |  3 ++
>  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
>  2 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 26dde6909c4e..d6528681e052 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
>  	struct sock *sk;
>  	unsigned int pkts;
>  	size_t bytes;
> +	struct net *net;
> +	struct sockaddr_vm src;
> +	struct sockaddr_vm dst;
>  };
>  
>  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e67dfcaa279c..73e5c7dfe8b4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>  	batch->sk = NULL;
>  	batch->pkts = 0;
>  	batch->bytes = 0;
> +	batch->net = NULL;
>  
>  	if (!sk)
>  		return;
> @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
>  	virtio_transport_trace_recv_pkt(skb, &src, &dst);
>  
> +	if (batch->sk) {
> +		if (batch->net == net &&
> +		    vsock_addr_equals_addr(&batch->src, &src) &&
> +		    vsock_addr_equals_addr(&batch->dst, &dst) &&
> +		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> +			sk = batch->sk;
> +			if (!skb_set_owner_sk_safe(skb, sk)) {
> +				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +				virtio_transport_rx_batch_finish(batch);
> +				kfree_skb(skb);
> +				return;
> +			}
> +
> +			ctx = (struct virtio_transport_rx_pkt_ctx) {
> +				.net = net,
> +				.src = &src,
> +				.dst = &dst,
> +				.batchable = &batchable,
> +			};
> +			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> +
> +			if (!batchable)
> +				virtio_transport_rx_batch_finish(batch);
> +			if (free_pkt)
> +				kfree_skb(skb);
> +			return;
> +		}
> +
> +		virtio_transport_rx_batch_finish(batch);
> +	}
> +
>  	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
>  	if (!sk) {
>  		virtio_transport_rx_batch_finish(batch);
> @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  
>  	if (!skb_set_owner_sk_safe(skb, sk)) {
>  		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> -		virtio_transport_rx_batch_finish(batch);
>  		kfree_skb(skb);
>  		return;
>  	}
>  
> -	if (batch->sk && batch->sk != sk) {
> -		/* Never acquire a second socket lock. */
> -		virtio_transport_rx_batch_finish(batch);
> -	}
> -
> -	if (batch->sk == sk) {
> -		/* Keep the batch reference; drop this packet's lookup reference. */
> -		sock_put(sk);
> -		ctx = (struct virtio_transport_rx_pkt_ctx) {
> -			.net = net,
> -			.src = &src,
> -			.dst = &dst,
> -			.batchable = &batchable,
> -		};
> -		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> -		if (!batchable)
> -			virtio_transport_rx_batch_finish(batch);
> -		if (free_pkt)
> -			kfree_skb(skb);
> -		return;
> -	}
> -

Not sure I love adding code and then removing it in the same series.
Seems like these are asking to be squashed?

>  	lock_sock(sk);
>  	/*
>  	 * Sockmap removal restores the native protocol under sk_callback_lock.
> @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>  	if (start_batch && batchable) {
>  		/* Keep the lookup reference until the batch is released. */
> +		batch->net = net;
> +		batch->src = src;
> +		batch->dst = dst;

Similar to my comment in the other patch, seems these are all in sk
already?

Best,
Bobby
