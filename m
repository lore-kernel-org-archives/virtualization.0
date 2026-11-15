Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715289;
	b=BBHue7iK2nUndbXk9HPCuUb3+cLsBnZPX5mb2a0Ft/ZyJuR7BPV3sRl/6riJ7GYhVf8m
	 X9TG4TSbUILDOjzgHlHtlJx+o4XdNnaYQvm4l73ogWEk6pv2eP77l1wbihVibpJuCkZs5
	 aVrTwj38ComoW3J/Yezavluw3NlPH65ll4lia4ZrjKl1A65+XBzX7rP0ZWlXIiDwEaWWK
	 ni9K2qpdC/kG/cY+OwZ/H0lfWqVzMHsZeJirG/k1y9LDptGH3Zkhyq4VvVeZgDCU5tHgQ
	 dA5HgHwEFQVogh2ifCYPeexvjEOeNcMFgR+qGsiSTdcPzalzNW67j17d5aGXeJmFRxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715289;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=j1ISAF+2u8ez95maVgyjSaDntsJ2s5Xsb6THdeRbXZg=;
	b=pew0KYpyZEu4UBFhJAFI3Cku3/d4T38N9J+m2U0CG9zZ8RZl4gdn0zluscNqjl6YBo9A
	 uBkGwjQ6mCV9tUgdVVJuEvfmlP1ip1KyzijL75mnpEj6Ht9p/b6u2n1THOZQ2LTOmy7Ms
	 SgpwAHRgNRzCyNvSoEE8nkR0QLhjG3X/1ciSyPKD7mH7rdrgD8yR2YLjjFtqeQaEmwsET
	 FFLSJXeHrzM2y6T3/eTJv0zUgxCMvDIMGULbuFxtgY0OYXjSWaaE5hzLDDyqxXyHPnwDj
	 OQo0H9UliXTeGeA69a9sHA7kVnQuetVAJ7+bKq1+KIxl6ixLm5o1AgiBEeM7jvFCgqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmavcgbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD226606A323;
	Sun, 15 Nov 2026 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmavcgbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13711F000C4;
	Sun, 15 Nov 2026 04:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715289;
	bh=j1ISAF+2u8ez95maVgyjSaDntsJ2s5Xsb6THdeRbXZg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mmavcgbEee9aOC7CN1peIR/Na4uAZMQx4BQk27w8pV3LYcoq60Dwi0ur8g490Pnzy
	 UDOyQCtSFNDJlIzylZTAQc/xqI4O3l1HX/7zB5OcoizJaE2YLFXyrVW5hWyJH6xkyZ
	 HdjxZHlYPlUAjc+spSz3gVLqioNhYEM895auwabSH04ocBAk620BJKR8cuIt6fsD8t
	 lDUYHL+ZTnbuNYD0mq6SY7ychxVXqwN0Y60g4ShG1omCuVoy1bTJnFMVxvsZEl6T+D
	 LaoeSiZG6v8IFpDAM2UD6zyB71lwJfcypOPtz7krSSuRzippdAwSAKv6/TRdVYBCmu
	 UXs+Dk1O7N+JQ==
Subject: Re: [PATCH net-next v6 1/8] vsock: only undo SS_CONNECTING when
 connect() fails
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shuah@kernel.org, rdunlap@infradead.org, donald.hunter@gmail.com,
 edumazet@kernel.org, georgezhang@vmware.com, acking@vmware.com,
 dtor@vmware.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
 bobbyeshleman@gmail.com
Date: Sun, 15 Nov 2026 04:01:27 +0000
Message-ID: <179471528724.2199510.7407342828719727367@kernel.org>
In-Reply-To: <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] vsock: vsock_connect() fails on SS_CONNECTED sockets reset to
  TCP_CLOSE
- [Low] The commit message understates what the fix closes.
- [Low] The commit message names vhost_vsock_reset_orphans() and
  vmci_transport_handle_detach() as examples where 'connect() gets the…
- [Low] vsock_connect_close() resets sock->state only when it is exactly
  SS_CONNECTING.

--

vsock: only undo SS_CONNECTING when connect() fails

This patch adds vsock_connect_close(). The helper sets sk_state to
TCP_CLOSE, and it moves sock->state back to SS_UNCONNECTED only if the
state is still SS_CONNECTING. It replaces the open-coded resets in the
signal/timeout and sk_err failure paths of vsock_connect(), so a socket
that got connected and then reset stays SS_CONNECTED.

Link: https://lore.kernel.org/netdev/179447093204.2199510.8895677421994612994@kernel.org/

> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> can complete the handshake, setting sock->state to SS_CONNECTED, and then
> reset the connection, e.g. in vhost_vsock_reset_orphans(),
> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> connect() gets the lock back, it finds sk_err set and moves the socket
> back to SS_UNCONNECTED.

[Severity: Low]
Do vhost_vsock_reset_orphans() and vmci_transport_handle_detach() really
reach connect() through the sk_err path described here?

vhost_vsock_reset_orphans() in drivers/vhost/vsock.c writes:

	sk->sk_state = SS_UNCONNECTED;
	sk->sk_err = ECONNRESET;

SS_UNCONNECTED is 1, which is the same value as TCP_ESTABLISHED. When
vsock_connect() takes the lock again, this check runs first:

	if (sk->sk_state == TCP_ESTABLISHED ||
	    sk->sk_state == TCP_CLOSING) {
		err = 0;
		goto out_wait;
	}

So connect() returns 0 and never gets to the sk_err handling.

vmci_transport_handle_detach() in net/vmw_vsock/vmci_transport.c sets
sk_err only when the socket is still in TCP_SYN_SENT:

	if (sk->sk_state == TCP_SYN_SENT) {
		...
		sk->sk_state = TCP_CLOSE;
		sk->sk_err = ECONNRESET;
		sk_error_report(sk);
		return;
	}
	sk->sk_state = TCP_CLOSE;

An already established socket only gets TCP_CLOSE. connect() then keeps
sleeping, because the wait loop runs while sk_err == 0. It reaches
vsock_connect_close() through the signal/timeout branch, not through
sock_error().

Only virtio_vsock_reset_sock() seems to match the mechanism described.
The code change still covers both paths, because the helper is used in
both branches. Could the examples in the changelog be corrected?

> Userspace can then connect() the socket again,
> and a connect() to a CID on another transport makes
> vsock_assign_transport() release the transport the socket was connected
> on.

[Severity: Low]
Should the changelog also describe the same-transport case? This patch
seems to close that one too.

virtio_vsock_reset_sock() sets sk_err but does not call
vsock_remove_connected(), so the socket stays linked in
vsock_connected_table. Before this patch, a second connect() to a CID
served by the same transport hits this in vsock_assign_transport():

	if (vsk->transport && vsk->transport == new_transport) {
		ret = 0;
		goto err;
	}

That skips release(), sk_state goes back to TCP_SYN_SENT and a new
REQUEST is sent. When the RESPONSE arrives, the connected-table insert
runs again:

	vsock_insert_connected()
	  __vsock_insert_connected()
	    sock_hold(&vsk->sk);
	    list_add(&vsk->connected_table, list);

The node it adds is already linked. That looks like connected-table list
corruption plus an unbalanced socket reference.

The changelog also does not say why releasing the transport the socket was
connected on is harmful. Stating these consequences would help stable
backporters and security triage judge the impact.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 483af15a5109e..dc81cd47f099d 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1703,6 +1703,16 @@ static void vsock_connect_timeout(struct work_struct *work)
>  	sock_put(sk);
>  }
>  
> +/* Avoid breaking the socket when another thread has changed its sock->state
> + * while we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	sock->sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;

[Severity: Medium]
Does the rest of vsock_connect() need to recognize SS_CONNECTED now?

With this patch the failure paths can run on a socket whose
sock->state is SS_CONNECTED. The wait loop and the signal/timeout
branch still only treat TCP_ESTABLISHED and TCP_CLOSING as success:

	while (sk->sk_state != TCP_ESTABLISHED &&
	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {

Suppose the handshake completes while connect() sleeps, and the
socket is then moved to TCP_CLOSE with sk_err == 0. The loop keeps
sleeping. vmci_transport_handle_detach() does that for an established
socket, since it only sets sk_err in TCP_SYN_SENT. With virtio,
virtio_vsock_reset_sock() sets ECONNRESET, but another thread can
clear it with getsockopt(SO_ERROR) before connect() takes the lock
again. connect() then waits for the whole connect_timeout, or until a
signal arrives, and ends up in this branch.

Here vsock_connect_close() now leaves the socket SS_CONNECTED, yet
vsock_transport_cancel_pkt() is still called right after it. For
virtio this reaches virtio_transport_purge_skbs(), which drops every
skb queued for this vsk, not only the OP_REQUEST mentioned in the
comment.

If a concurrent sendmsg() queued OP_RW skbs while the socket was
TCP_ESTABLISHED, virtio_transport_get_credit() already added them to
vvs->bytes_unsent. Purging them without
virtio_transport_consume_skb_sent() seems to leave bytes_unsent
non-zero for good. SIOCOUTQ then reports stale data, and
vsock_linger() waits out the full SO_LINGER time on close().

The caller also gets -ETIMEDOUT or -EINTR for a socket that now
reports SS_CONNECTED. If the error is -ERESTARTSYS, the restarted
connect() fails with -EISCONN.

The long wait and the vsock_transport_cancel_pkt() call predate this
patch. But this patch is what decides that such a socket stays
SS_CONNECTED, so the rest of vsock_connect() should probably agree
with it. Should the loop also stop when sock->state is no longer
SS_CONNECTING? And should an already connected socket skip
vsock_transport_cancel_pkt() and return sock_error() (or 0) instead?

[Severity: Low]
Can this leave a socket that never connected stuck in SS_DISCONNECTING?

Consider a blocking connect() racing with shutdown():

Thread A                          Thread B
vsock_connect()
  sock->state = SS_CONNECTING
  release_sock(sk)
  schedule_timeout()
                                  vsock_shutdown()
                                    sock->state = SS_DISCONNECTING;
  lock_sock(sk)
  timeout, signal or sk_err
  vsock_connect_close()
    sk_state = TCP_CLOSE
    sock->state stays SS_DISCONNECTING

After this, every later connect() fails here:

	case SS_DISCONNECTING:
		err = -EINVAL;
		goto out;

vsock_listen() also fails its sock->state != SS_UNCONNECTED check.
Before the patch, this socket was reset to SS_UNCONNECTED.

The non-blocking path still resets unconditionally in
vsock_connect_timeout():

	if (sk->sk_state == TCP_SYN_SENT &&
	    (sk->sk_shutdown != SHUTDOWN_MASK)) {
		sk->sk_state = TCP_CLOSE;
		sk->sk_socket->state = SS_UNCONNECTED;

So the same sequence, shutdown during connect followed by a timeout, now
leaves a different sock->state depending on whether connect() was
blocking.

The comment above the signal/timeout branch in vsock_connect() also
still says:

	/* If connection was _not_ established and a signal/timeout came
	 * to be, we want the socket's state reset. User space may want
	 * to retry, so we keep the binding and the transport assigned.
	 */

That no longer always holds.

The exact SS_CONNECTING check is needed so that a socket that was
connected and then shut down is not reset. Should the never-connected
case be documented, or made consistent with vsock_connect_timeout()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-vsock-guest-ns-v6-0-3737ce4673c0%40meta.com
