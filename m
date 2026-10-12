Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E554457AC
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842579; cv=none; b=qYjBr1W5oXy2zJbDJkTmXtea1+4yfbyQ0vFQek500PmjcMHYIhyyioFoLn6FKU/f0WhSpeT4aCIm0tGG6go8nYylmVI5bAqaSi8/+HEIKWhK5DX0dPKvNMlJodM6zoDJeu/jROvGStIUP41AUubmU58k60N9nL44sQmBlznT3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842579; c=relaxed/simple;
	bh=xrEfK09sOgKPL8tRakdgdLoY5A4I63z1FJ2ZQnHI7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuU1lCcb+wVLfDD06d0bwA7V77mnddshru+McxfMP4a7LqQ7tdn66MTjLxW4fREcelwmK4DvoagAKYFcc37O+ZSObjalWez7hLH5bUXJnL4Wx2vk0W1EYRrNtzFfL8s6Y7S5EPQBgNMd9EdHybGipLUEjtBKe2ZYKUpBLQhvZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRMUQqDT; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRMUQqDT"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-824e6e6ed71so1961391a34.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791842575; x=1792447375; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I34AgC3qXFsIWry2eO2C25CSCiy4N0N7n6VOFiD93pA=;
        b=dRMUQqDTQbS11acklZhccv4VjpmJx0d2q7EK30AW2422xVVG2MVO/T1dsWyZuy03/R
         9SpeWdwVUJEWKbuffinR5U+FIvWSPZeysrAVYAu4VEsAymdidId7tRbW+RnPa91aNjjH
         fZYDleTRQMOEwNQXKDmjm/LYdoUgqMTqDK/XiyhPcjuh9GPiwc2oPo0aP0O1dV9KmeVm
         vXyESEm5y/QzOsA/t3/xXDgwUcz6F7Xys2p+OjWD5svRD1q0k9CyeEZjHY/Frm8emh7r
         /IlNxRDV3zh4BLqe7MWhQxZXNaoXyl9d772mRQjYejOj/Qne/GtsV36/fi97dIOGUDVS
         RwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842575; x=1792447375;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I34AgC3qXFsIWry2eO2C25CSCiy4N0N7n6VOFiD93pA=;
        b=mWWqcGOPtQ5TLdXSWvaI+fWMidiqedM+8tzeO5T8y7DYxId6wpjBorn7os7MkzuOwL
         h48+kf3kWqm/Q4p42/isDr20Sp3NqzhcfAOTNxqY0xGmqOFdJ4Lpj98h8cFD0vXcnbLI
         Hr6JCDWbBQNiRPobZwjcjuMxGK2306RlSmZJmt5HuIpcOCkOMyvn7A7QpU8yIqTHSMk8
         lmVQGnPVk+W75LvpYcU18sVpc939U8QB8dw+g5XgPmvqssxbdLaPfIzNdlGZCdGtfS8j
         VQKc0OROSoKyh6oFcsY4V90H1SCwCw8P0QWQ4LsktQv2tda7rUTKhfo+qggapu8eb5CH
         J+Gw==
X-Forwarded-Encrypted: i=1; AKwUvBy6ELgpHXcnhe82b/EILOMODHTay2LU21Clta7LmWJhxcdMs/Kn5EwNlYiMdjxDHHRNtEXznqrh+nbFfQugcQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKgR4ofQzM1VXQ2fvNIeNi66Wxl/aTRjuzvWG7CisAzGZK40k0N
	R0qO8b9ylHxRAW+0luU6HgqeudSsBgwVeyAYZQGGB8KXKzIyjQM0KWvX
X-Gm-Gg: AYBFou14kj7QyOSpkAoNaCqOmUiTfeshs+s1DsZ11OIs1MTLw9Ab7FNSGxySzk9z25s
	D6rnC+MWlZT24sV1VVb+lO3Og3D9srswtjSmO2X8vgta7eA96SAQypVvdgs6Lm6mevZa7Gx2FQq
	JyNAeyl/oamNTyGbkEIQ4EENIP2Vm7Z3Mnk0gLpcHBKiPWvo18/r8NHWqFgZYxwX9xbBtwy+QDm
	gIWJjIJlqPsFJgDBvU7fhaXotC+K6E+bfomfuenmvgWFvmC2JY+p2ogN3RvfBRM1Dscr/9ItdYo
	HxJf5q4aXCiS/tFXoI+0YaAtjXHu+joWRdx/jrNHF3929X0mnFTnTrVnO2a7SaWrnCN4ijNMj6Z
	GJB+rzwbx6qAa/XqsAomNPJ5ekJQmR+6JgWB0CrIb3V52DBrhWKRTHPLdi5rUJOES3hr7K7UnHM
	ZFtfNRF7POWbQxy88sS862FzMvNXyWHqVO6bIeGN7rlwpDjwhF2UupttQ95VG+fxNA62qbFTlNv
	UqndWaoMmiBoA77mm2iKrhvwIfTHw==
X-Received: by 2002:a05:6830:43a0:b0:81c:4784:a5e2 with SMTP id 46e09a7af769-83094e738d8mr9929561a34.6.1791842575557;
        Mon, 12 Oct 2026 15:02:55 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f64csm10655830a34.3.2026.10.12.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:02:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:02:50 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-2-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.
> 
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.
> 
> Pass the network namespace and decoded address tuple through a packet
> context to the locked receive path.
> 
> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so the locked receive path can manage
> the two lifetimes independently.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
>  1 file changed, 96 insertions(+), 43 deletions(-)
> 

[...]

> +/*
> + * The caller holds sk's socket lock and must free skb if this returns true.
> + */
> +static bool
> +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> +				 struct sk_buff *skb, struct sock *sk,
> +				 const struct virtio_transport_rx_pkt_ctx *ctx)
> +{
> +	const struct sockaddr_vm *src = ctx->src;
> +	const struct sockaddr_vm *dst = ctx->dst;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	struct net *net = ctx->net;
> +	bool space_available;
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check after acquiring the socket lock. Listener sockets accept packets
> +	 * from any source and are not assigned to a transport.
>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
>  	    (sk->sk_state != TCP_LISTEN &&
> -	     !vsock_check_source(vsk, &t->transport, &src))) {
> +	     !vsock_check_source(vsk, &t->transport, src))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
> -		release_sock(sk);
> -		sock_put(sk);
> -		goto free_pkt;
> +		return true;
>  	}
>  
>  	space_available = virtio_transport_space_update(sk, skb);
>  
>  	/* Update CID in case it has changed after a transport reset event */
>  	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> -		vsk->local_addr.svm_cid = dst.svm_cid;
> +		vsk->local_addr.svm_cid = dst->svm_cid;
>  
>  	if (space_available)
>  		sk->sk_write_space(sk);
> @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		break;
>  	}
>  
> +	return false;
> +}
> +
> +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> + * lock.
> + */
> +void virtio_transport_recv_pkt(struct virtio_transport *t,
> +			       struct sk_buff *skb, struct net *net)
> +{
> +	struct virtio_transport_rx_pkt_ctx ctx;
> +	struct sockaddr_vm src, dst;
> +	struct sock *sk;
> +	bool free_pkt;
> +
> +	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> +	virtio_transport_trace_recv_pkt(skb, &src, &dst);
> +
> +	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> +	if (!sk) {
> +		(void)virtio_transport_reset_no_sock(t, skb, net);
> +		goto free_pkt;
> +	}
> +
> +	if (!skb_set_owner_sk_safe(skb, sk)) {
> +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +		goto free_pkt;
> +	}
> +
> +	lock_sock(sk);
> +	ctx = (struct virtio_transport_rx_pkt_ctx) {
> +		.net = net,
> +		.src = &src,
> +		.dst = &dst,
> +	};
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);

At this point the socket lookup succeeded with src/dst/net, why not just
pass sk which already has all of them?

Best,
Bobby
