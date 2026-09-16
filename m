Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEBE4CA779;
	Wed, 16 Sep 2026 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601962; cv=none; b=HMVAAJ5JFNxV0Mm4+pY4Fe1eLcVuuKoH3XK8VbZr+/s2UZ8/4YairmMITRHBOYi8tagF01BYWeDfcLvJB5rRkjOUXtqmC3cF4lmuxBEj725N8R5Sapgx2EioZa23Pfn56PSx6KXQDSoyKmFgDCeqt0xZAYBjf5d/kriplzpNR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601962; c=relaxed/simple;
	bh=ii2ZG5F7ufI7wKa1xlq57LRaUXtjyL8jQs74dZdeelk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PvYCdkhJzDYUum4ohyh6HM8VB0lh4Gm58fj/KMR8fbWcM7nh3aQuJgX3BEt101cXjf1JFo9ViK6gDKFs6tyWPKpvUL+jhF/CtdBfN9J97bcvWLAyn5cpwXGNmq+HAvPIdyuRXa3RGYVRqs3QPa3iL8SOXD0vXurMqhalrsU2/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ely4aOS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ely4aOS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EF71F00893;
	Wed, 16 Sep 2026 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601958;
	bh=6xLgyUj4E59zikNOGva9HXqASQHqSQBDsxta8HdSbyo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ely4aOS/u/Hv7ETfy/G5Aq7GF+vWBwxNALr0q6TieCHGNhioWnE77s1VcGcIEUlKq
	 9jCsi/b5WWf+OxnhJbYufMXubhKQYqeILs00VfgFRsEMKC6g/IXIEy7r+UlWBzbBo6
	 IedH0VPt9e0TZlXCLJRlCgECuSPC1QJ5mcyyzQlE4HPTyaShN9wiS5sIr/E9tepol9
	 snKHDqQuopfYn53/0KQWBIZzSpcAWJa0ykOMUO+G9t2kCUpBkKu5ViFD1jkooHYP63
	 u9+VweNcnAbYBSEvTlj6SQWpG1/hwNx+h21XxqfsonFvj2XrLd0DtH6+3PZHYWQHQu
	 /1iYM70NfvxuA==
Subject: Re: [PATCH net v2 4/5] vsock: Do not reset a TCP_CLOSING socket
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, asias@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 23:39:17 +0000
Message-ID: <178960195730.22033.16636722417726715635@kernel.org>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] Undocumented change of connect()'s return value / sk_err
  consumption for an already-established socket.

Pre-existing issues:
- [Low] Reported gap (validated as resolved later in this series,
  therefore discarded): at this commit vsock_connect() keys its "do not…

--

vsock: Do not reset a TCP_CLOSING socket

This teaches the vsock_connect() wait loop about the TCP_ESTABLISHED ->
TCP_CLOSING transition triggered by VIRTIO_VSOCK_OP_RST, so a socket that
is still linked in vsock_connected_table is not reset behind the receive
path's back. It also rewrites the tail of vsock_connect() and drops a
stale comment.

Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 499e902becfad..adf3f018347ea 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -1834,23 +1833,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		timeout = schedule_timeout(timeout);
>  		lock_sock(sk);
>  
> -		/* Connection established. Whatever happens to socket once we
> -		 * release it, that's not connect()'s concern. No need to go
> +		/* Connection was established. Whatever happens to socket once
> +		 * we release it, that's not connect()'s concern. No need to go
>  		 * into signal and timeout handling. Call it a day.
>  		 *
>  		 * Note that allowing to "reset" an already established socket
>  		 * here is racy and insecure.
>  		 */
> -		if (sk->sk_state == TCP_ESTABLISHED)
> -			break;
> +		if (sk->sk_state == TCP_ESTABLISHED ||
> +		    sk->sk_state == TCP_CLOSING) {
> +			err = 0;
> +			goto out_wait;
> +		}

[Severity: Medium]

The old code did a plain break here, so control fell through to the
err = sock_error(sk) tail. Now it jumps straight to out_wait with err = 0.

Combined with the tail change below, does this mean a blocking connect()
that wakes up in TCP_ESTABLISHED with sk_err already set now returns 0
instead of that error, leaving sk_err queued for the next send()/recv()?

That window looks reachable via virtio_transport_recv_connected(), which
runs only for TCP_ESTABLISHED sockets:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_connected() {
	case VIRTIO_VSOCK_OP_RW:
		if (!virtio_transport_recv_enqueue(vsk, skb)) {
			...
			(void)virtio_transport_reset(vsk, skb);
			virtio_transport_do_close(vsk, true);
			sk->sk_err = ENOBUFS;
			...
}

and virtio_transport_do_close() only downgrades the state when the receive
queue is empty:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_do_close() {
	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
	if (vsock_stream_has_data(vsk) <= 0)
		sk->sk_state = TCP_CLOSING;
	...
}

In the queue-full case vsock_stream_has_data(vsk) > 0, so sk_state stays
TCP_ESTABLISHED while sk_err == ENOBUFS.

The changelog mentions only the TCP_CLOSING transition plus "Drop the
redundant err=0 and the inaccurate comment above signal_pending()". Could
the changelog also spell out that connect() no longer reports or consumes a
pending sk_err for an established socket? The patch carries a Fixes:
d021c344051a tag, so it is a backport candidate and the user-visible change
of the connect() return value seems worth documenting.

>  
>  		/* If connection was _not_ established and a signal/timeout came
>  		 * to be, we want the socket's state reset. User space may want
>  		 * to retry.
> -		 *
> -		 * sk_state != TCP_ESTABLISHED implies that socket is not on
> -		 * vsock_connected_table. We keep the binding and the transport
> -		 * assigned.
>  		 */
>  		if (signal_pending(current) || timeout == 0) {
>  			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);

[ ... ]

> @@ -1874,8 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>  	}
>  
> -	err = sock_error(sk);
> -	if (err) {
> +	if (sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
> +		err = sock_error(sk);
>  		sk->sk_state = TCP_CLOSE;
>  		sock->state = SS_UNCONNECTED;
>  	}

[Severity: Low]

This is a pre-existing issue and not introduced by this patch, but the new
whitelist covers only TCP_ESTABLISHED and TCP_CLOSING. A socket that is
still linked in vsock_connected_table but was moved to TCP_CLOSE by a
lockless event handler still gets reset to SS_UNCONNECTED both here and in
the signal_pending() branch above.

Two writers do that without calling vsock_remove_connected():

net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
	vsk->peer_shutdown = SHUTDOWN_MASK;
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
}

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
	...
		sk->sk_state = TCP_CLOSE;
}

With sock->state == SS_UNCONNECTED, a retry connect() takes the default:
branch, vsock_assign_transport() returns early because the transport is
unchanged, transport->connect() is re-issued, and the next RESPONSE reaches
__vsock_insert_connected():

net/vmw_vsock/af_vsock.c:__vsock_insert_connected() {
	sock_hold(&vsk->sk);
	list_add(&vsk->connected_table, list);
}

which is the same list_add double add BUG quoted in the changelog, plus a
leaked struct sock reference.

For the record, this appears to be closed by the next patch in the series,
"vsock: Handle sudden TCP_CLOSE during connect", which adds

	/* Virtio/PM events are serviced locklessly. */
	if (READ_ONCE(vsk->peer_shutdown)) {
		err = -ECONNRESET;
		goto out;
	}

to the same default: branch, and every writer above sets
peer_shutdown = SHUTDOWN_MASK before moving the socket to TCP_CLOSE, so no
action seems needed on the series as a whole. Would it be worth noting in
this patch's changelog that the TCP_CLOSE variant of the same race is
handled by the following patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7%40rbox.co
