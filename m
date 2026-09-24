Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE21394EBA;
	Thu, 24 Sep 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255706; cv=none; b=HL+zK41gU8F58tvEZ1HToZDrzqFoNEOYfZ/rJOw/i1Pe6L2oTrCFiBoaFvv4aTvg22deb8ipZ9BMCwYTmP5Tz9X5WrmVDcB4zNd6LNC1xWDDjkSKaOqWiwTXDUx8CZ2au5ICnGLoj2uiu6bG6p5PFMXV431+vH9hUnmnrI0VDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255706; c=relaxed/simple;
	bh=1yoKbr/kW7J7Acg1LrptrwI8yuKt1GAS6FpC/pe9MGM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i/CnxXVVCtg6Uo2QGRfJwjai4Ceda+cUneR9PD41z0btsBVlF8XNoDJINJnoBrbn+p32MLc4X3tQqBGNOQIy0s1PG9TecWoXDrkPniFFmENhXS3GJZ2tgb6K525iIGfpKVCMlGxHoc0zSSlPoxnxl7BzN5EcI3sAvo4c9/sPVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8KTtUIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8KTtUIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5721F000FF;
	Thu, 24 Sep 2026 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255704;
	bh=D50jyEnrA+GfmMu/9vpXf68CrvA2h9Dt2BUARw2bThg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i8KTtUIe7/miJdNhzXaxbX1PXW1iELkhYeIoCxrlsyVRvZrbrUewZZZfwuOTF6PkB
	 7Zyv4G6FnXD6IXbuy2cZddlCXNJ2Nju4SbyBdNey8zxWaBJdkoHdS3AZhUhp5ET7Qo
	 z8eHMdD14jh+2ZptV/giZhWg/UckKcMhV9g/rjXDDdnHvvoXfpY/MMVPG+EWdnsTAf
	 6aJEu96ierNyslvcUMoVe4GncM9FUaGkdNPI4z4GDoduQ9Eu4ctbwoQbVbD/0y04f6
	 j5IZx8AFWp6rvXa0/qkYI/mVPXkDCVEfyWA3nro5S8wwAzjYtneRZMDGtkQsgqplNu
	 AAODqxymYHk8w==
Subject: Re: [PATCH net v3 3/8] vsock: do not preserve transport assignment
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
Date: Thu, 24 Sep 2026 13:15:02 +0000
Message-ID: <179025570282.2160803.14008153968313791312@kernel.org>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-3-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-3-78907b8200d4@rbox.co>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The WARN_ON_ONCE() assertions added in vsock_unconnected_reset()
  (af_vsock.c:1695-1698) are reachable from ordinary peer behaviour, and…
- [High] vsock_unconnected_reset() infers 'never established' from
  sk_state/peer_shutdown/SOCK_DONE only.
- [Medium] Incomplete lifecycle change vs. commit message: for a non-
  blocking connect() the new de-assign path is never reached when the…

--

vsock: do not preserve transport assignment

This adds vsock_unconnected_reset() and reworks vsock_connect() so that a
failed connection attempt de-assigns the transport and reverts the socket
to its initial state, while an established socket keeps its transport until
close().

A few questions on the new helper and on the paths that reach it.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5c8e7e7d35b4f..20181ddde114f 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1679,6 +1679,42 @@ static int vsock_transport_cancel_pkt(struct vsock_sock *vsk)
>  	return transport->cancel_pkt(vsk);
>  }
>  
> +static void vsock_unconnected_reset(struct sock *sk)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
> +	sock_owned_by_me(sk);
> +
> +	/*
> +	 * Only connected socks may have peer_shutdown or SOCK_DONE set.
> +	 *
> +	 * Once established (TCP_ESTABLISHED, TCP_CLOSING), a socket can be
> +	 * de-assigned only on close(). But we can narrow the check down to
> +	 * states we actually expect (TCP_SYN_SENT, TCP_CLOSE).
> +	 */
> +	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
> +	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
> +	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
> +			 sk->sk_state != TCP_CLOSE))
> +		return;

[Severity: High]
Is the "only connected socks may have peer_shutdown or SOCK_DONE set"
invariant true for VMCI?

vmci_transport_recv_connecting_client_negotiate() allocates the queue pair
and subscribes to VMCI_EVENT_QP_PEER_DETACH while the socket is still in
TCP_SYN_SENT. If the peer then detaches, vmci_transport_handle_detach()
runs on a never-established socket:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	...
		sock_set_flag(sk, SOCK_DONE);
	...
		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
	...
			if (sk->sk_state == TCP_SYN_SENT) {
	...
				sk->sk_state = TCP_CLOSE;
				sk->sk_err = ECONNRESET;
				sk_error_report(sk);
	...
}

The blocking connect() waiter then wakes on sk_err, err = sock_error(sk)
becomes -ECONNRESET, and out_reset calls this helper with peer_shutdown ==
SHUTDOWN_MASK and SOCK_DONE set.

Since WARN_ON_ONCE() evaluates to the condition, the helper splats and
returns before vsock_transport_cancel_pkt(), vsock_deassign_transport() and
the TCP_CLOSE/SS_UNCONNECTED restore. Can that leave the socket stuck with
sk_socket->state == SS_CONNECTING and the transport (plus its module
reference) pinned, so a later connect() returns -EALREADY for O_NONBLOCK or
re-hits the same early return, and listen() returns -EINVAL?

Before this patch the same path unconditionally ran:

	err = sock_error(sk);
	if (err) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}

so the socket stayed retryable. Is the change in behaviour here intended?

On panic_on_warn=1 kernels this is also reachable from an unprivileged
connect() when the peer VM goes away mid-handshake.

> +
> +	/*
> +	 * Try to cancel a VIRTIO_VSOCK_OP_REQUEST skb that may have been sent
> +	 * out by transport->connect().
> +	 */
> +	vsock_transport_cancel_pkt(vsk);
> +
> +	/*
> +	 * No need to invoke transport->release() for unconnected connectible
> +	 * sockets. Go straight for transport deassign.
> +	 */
> +	vsock_deassign_transport(vsk);

[Severity: High]
Can this de-assign the transport of a socket that did reach
TCP_ESTABLISHED?

virtio_vsock_reset_sock() (and vhost_vsock_reset_orphans()) move an
established socket to TCP_CLOSE without lock_sock(), holding only
vsock_table_lock:

net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
	...
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
	...
}

sk_socket->state stays SS_CONNECTED and the socket stays linked in
vsock_connected_table. A blocking connect() woken after the handshake
completed then reaches out_reset with err = -ECONNRESET, and all three
guards above pass because they only look at sk_state, peer_shutdown and
SOCK_DONE.

virtio_transport_destruct() frees the transport state without purging
vvs->rx_queue and without unhashing the socket:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_destruct() {
	virtio_transport_cancel_close_work(vsk, true);

	kfree(vvs);
	vsk->trans = NULL;
	...
}

The rx_queue purge lives in virtio_transport_remove_sock(), which is only
reached via release(), deliberately skipped here. Does this leak the queued
rx skbs, and does a subsequent successful connect() perform a second
list_add() on the still-linked connected_table node in
__vsock_insert_connected()?

A later patch in this series, "vsock: handle socket bricking due to
transport event", adds an early return on sk_socket->state == SS_CONNECTED
or SS_DISCONNECTING at the top of this helper, which covers exactly this
case, so this only affects this commit taken on its own. Would it be
cleaner to fold that guard in here?

> +
> +	/* Revert socket to initial state. Keep sk_err. */
> +	WRITE_ONCE(sk->sk_state, TCP_CLOSE);
> +	sk->sk_socket->state = SS_UNCONNECTED;
> +}
> +
>  static void vsock_connect_timeout(struct work_struct *work)
>  {
>  	struct sock *sk;
> @@ -1690,11 +1726,9 @@ static void vsock_connect_timeout(struct work_struct *work)
>  	lock_sock(sk);
>  	if (sk->sk_state == TCP_SYN_SENT &&
>  	    (sk->sk_shutdown != SHUTDOWN_MASK)) {
> -		sk->sk_state = TCP_CLOSE;
> -		sk->sk_socket->state = SS_UNCONNECTED;
>  		sk->sk_err = ETIMEDOUT;
>  		sk_error_report(sk);
> -		vsock_transport_cancel_pkt(vsk);
> +		vsock_unconnected_reset(sk);
>  	}
>  	release_sock(sk);
>  

[ ... ]

> @@ -1874,13 +1896,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  	}
>  
>  	err = sock_error(sk);
> -	if (err) {
> -		sk->sk_state = TCP_CLOSE;
> -		sock->state = SS_UNCONNECTED;
> -	}
> -
>  out_wait:
>  	finish_wait(sk_sleep(sk), &wait);
> +out_reset:
> +	if (err)
> +		vsock_unconnected_reset(sk);
>  out:
>  	release_sock(sk);
>  	return err;

[Severity: Medium]
For a non-blocking connect() whose failure is detected asynchronously by
the transport, which path reaches out_reset?

connect(fd, O_NONBLOCK) assigns a transport, sets sk_state = TCP_SYN_SENT,
sock->state = SS_CONNECTING and returns -EINPROGRESS. If the peer answers
with VIRTIO_VSOCK_OP_RST, virtio_transport_recv_connecting() takes its
destroy label:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_connecting() {
	...
destroy:
	virtio_transport_reset(vsk, skb);
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = skerr;
	sk_error_report(sk);
	...
}

sk_socket->state is left at SS_CONNECTING and the transport stays assigned.
vmci_transport_recv_connecting_client() has the same pattern.

vsock_connect_timeout() above is gated on sk->sk_state == TCP_SYN_SENT, so
it does not reset either once the state is TCP_CLOSE. And a retry with
O_NONBLOCK hits:

	case SS_CONNECTING:
		...
		err = -EALREADY;
		if (flags & O_NONBLOCK)
			goto out;

which returns before out_reset.

Does the socket then keep the transport assignment and the transport module
reference until close()? The changelog says:

    If connection fails (init went wrong, peer misbehaviour, time out,
    signal), transport is de-assigned and socket state is re-initialized.

Should the asynchronous peer-misbehaviour case for a non-blocking connect()
be covered as well, or should the changelog be narrowed to the synchronous
paths?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4%40rbox.co
