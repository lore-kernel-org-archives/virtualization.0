Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414184C6523;
	Thu, 24 Sep 2026 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285270; cv=none; b=VbrxgqJcQ6YkF4z5CJhecB2cN9I/nud8IYYepPfKOtDB5d3cObk4hmVr5KiQPqjGc7Rkx+FLHfUQAse3tIT6pvMl1sIOFIGawEFh//194Aa2t3C9cGlt3XlfDe7ENnPiPKDxPn3911ttM/IyQHjcMa83G1XrvBalpgyH+tZ2lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285270; c=relaxed/simple;
	bh=JP0eTty2Tpm0CtZaR3dRF95p1WSqlwUIqo3atBFz5v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5VMqtNP7EUEsqsEJdeP8zyC8eqHqQSaDdqBE+UdbHssRQZU5nqpDysS7MDeadY80huHV5yGMdN/tQ/jwPR0v2+KJ2+i9cZFaiS7KDGGAQbriOQhbdBhyrOEmJ3PzXJdgGhmjJFgnenM1IU6BWicLQAvJQJlHcNaxIMhZL0EPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SINuYGcQ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SINuYGcQ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qyk-00CkCU-83; Thu, 24 Sep 2026 23:27:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=+A9Az0MiClrCw3VDlH3olIjxpFcd/4PPoA5rQnv4QjI=; b=SINuYGcQkzEIVwBI2+9ilugVXA
	kHfmqJ9k8otoqAIdsXOo7uB5BGq+sSUcnzy2Y3ygQKUbX/Kd1+6rHxFfERsj9y2q3xscEljdyFMZ6
	H/peyfJOu1rNk1NdCzmWGM6Ych+mJRe8d3AVk1ra0hQphgLZ/KoVAZuaoY6HzXLCn0o/zl5CCJW9m
	DSKeLPJlGHG8S0jHozebWsrjkRrV5jU2C1QNqHKI6+l4Ocolwp6Kl0vgZRvQjVYE+WFku4k8YEVaR
	XUtZexlRMXTDiqrIn2UX8ZTmamV/25fBH15O6W1FOZoSUp/05tkiY484wySsZ1EVhIBX6MQjs4cRm
	HhP/5MbA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qye-0002iQ-Ue; Thu, 24 Sep 2026 23:27:37 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qyS-006cST-CD;
	Thu, 24 Sep 2026 23:27:24 +0200
Message-ID: <20ae0115-a0e9-4804-ad51-13ef75e82264@rbox.co>
Date: Thu, 24 Sep 2026 23:27:23 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/8] vsock: do not preserve transport assignment
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260922-vsock-connect-reset-closing-v3-3-78907b8200d4@rbox.co>
 <179025570282.2160803.14008153968313791312@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <179025570282.2160803.14008153968313791312@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 15:15, netdev-bot+sashiko@kernel.org wrote:
>> +static void vsock_unconnected_reset(struct sock *sk)
>> +{
>> +	struct vsock_sock *vsk = vsock_sk(sk);
>> +
>> +	sock_owned_by_me(sk);
>> +
>> +	/*
>> +	 * Only connected socks may have peer_shutdown or SOCK_DONE set.
>> +	 *
>> +	 * Once established (TCP_ESTABLISHED, TCP_CLOSING), a socket can be
>> +	 * de-assigned only on close(). But we can narrow the check down to
>> +	 * states we actually expect (TCP_SYN_SENT, TCP_CLOSE).
>> +	 */
>> +	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
>> +	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
>> +	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
>> +			 sk->sk_state != TCP_CLOSE))
>> +		return;
> 
> [Severity: High]
> Is the "only connected socks may have peer_shutdown or SOCK_DONE set"
> invariant true for VMCI?
> 
> vmci_transport_recv_connecting_client_negotiate() allocates the queue pair
> and subscribes to VMCI_EVENT_QP_PEER_DETACH while the socket is still in
> TCP_SYN_SENT. If the peer then detaches, vmci_transport_handle_detach()
> runs on a never-established socket:
> 
> The blocking connect() waiter then wakes on sk_err, err = sock_error(sk)
> becomes -ECONNRESET, and out_reset calls this helper with peer_shutdown ==
> SHUTDOWN_MASK and SOCK_DONE set.
> 
> Since WARN_ON_ONCE() evaluates to the condition, the helper splats and
> returns before vsock_transport_cancel_pkt(), vsock_deassign_transport() and
> the TCP_CLOSE/SS_UNCONNECTED restore. Can that leave the socket stuck with
> sk_socket->state == SS_CONNECTING and the transport (plus its module
> reference) pinned, so a later connect() returns -EALREADY for O_NONBLOCK or
> re-hits the same early return, and listen() returns -EINVAL?
> 
> Before this patch the same path unconditionally ran:
> 
> 	err = sock_error(sk);
> 	if (err) {
> 		sk->sk_state = TCP_CLOSE;
> 		sock->state = SS_UNCONNECTED;
> 	}
> 
> so the socket stayed retryable. Is the change in behaviour here intended?

True, I'll drop WARN_ON_ONCE(vsk->peer_shutdown).

> On panic_on_warn=1 kernels this is also reachable from an unprivileged
> connect() when the peer VM goes away mid-handshake.

It was meant for debugging and to trip the fuzzers. Would it be better to
use DEBUG_NET_WARN_ON_ONCE?

> [Severity: High]
> Can this de-assign the transport of a socket that did reach
> TCP_ESTABLISHED?
> ...
> A later patch in this series, "vsock: handle socket bricking due to
> transport event", adds an early return on sk_socket->state == SS_CONNECTED
> or SS_DISCONNECTING at the top of this helper, which covers exactly this
> case, so this only affects this commit taken on its own. Would it be
> cleaner to fold that guard in here?

Maybe it would be cleaner, but I think it's easier to review as it is now.

> [Severity: Medium]
> For a non-blocking connect() whose failure is detected asynchronously by
> the transport, which path reaches out_reset?
> 
> connect(fd, O_NONBLOCK) assigns a transport, sets sk_state = TCP_SYN_SENT,
> sock->state = SS_CONNECTING and returns -EINPROGRESS. If the peer answers
> with VIRTIO_VSOCK_OP_RST, virtio_transport_recv_connecting() takes its
> destroy label:
> 
> net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_connecting() {
> 	...
> destroy:
> 	virtio_transport_reset(vsk, skb);
> 	sk->sk_state = TCP_CLOSE;
> 	sk->sk_err = skerr;
> 	sk_error_report(sk);
> 	...
> }
> 
> sk_socket->state is left at SS_CONNECTING and the transport stays assigned.
> vmci_transport_recv_connecting_client() has the same pattern.
> 
> vsock_connect_timeout() above is gated on sk->sk_state == TCP_SYN_SENT, so
> it does not reset either once the state is TCP_CLOSE. And a retry with
> O_NONBLOCK hits:
> 
> 	case SS_CONNECTING:
> 		...
> 		err = -EALREADY;
> 		if (flags & O_NONBLOCK)
> 			goto out;
> 
> which returns before out_reset.
> 
> Does the socket then keep the transport assignment and the transport module
> reference until close()? The changelog says:
> 
>     If connection fails (init went wrong, peer misbehaviour, time out,
>     signal), transport is de-assigned and socket state is re-initialized.
> 
> Should the asynchronous peer-misbehaviour case for a non-blocking connect()
> be covered as well, or should the changelog be narrowed to the synchronous
> paths?
OK, so a _non-blocking_ connect() getting hit with RST before connection
can be established: fd bricked, you can't re-connect() with it. While you
can retry a _blocking_ connect getting hit the same way. And the choice is
to unify the behaviour or document the discrepancy, if I get it right.

