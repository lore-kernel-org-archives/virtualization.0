Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973E4963CF;
	Wed, 16 Sep 2026 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601960; cv=none; b=h2eaQK+5iDmJjhE6zP89n0qctyAs8d1OTGdv1pIXUkpGEJFKvmt7Ea6PMbUu5QebOQcnXx0mxBFTwBFKKavTm5cfcMAIZg3WV3oTyJP3/t2Dqeu7k7KgBCycNjkCW9CByOKFS52KybvKPbd2Fkdit5yvdHA9RXFZgKKN460mTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601960; c=relaxed/simple;
	bh=Fgf5+6fLSs4Fm6W6pne9+i/4mUYhu624mn9y5ABC+7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aO5pX/SfUBQbKLKXBuz25A76B7YdPkJawNt+xPfjNukqL8hPJ9+Xj3H7PRxp/sB+gbRoPcO67GPngEBKubEInohYFhZmNZB4jqdW1lf5yaa5o1GZFua+wPYtDKzdKm9hvsj2RRBeqB9Q8Wy8IE6uVCx3/L50ISupLppEEeYS2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSV++m7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSV++m7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC941F00898;
	Wed, 16 Sep 2026 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601957;
	bh=PkNEb2IafQiLXy/mmBKntIkV6PocevA1a6nPMjOMtiE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oSV++m7jhBJZRYNM+XqYHiVC9NwtTc6Uf32fpoQvMT6+BuJqUIEkkVU9zXMF/J5vD
	 TjTdReCs0cUp9kilKGeT5fNtO7SfHzWlQamIgFiJpiLn3e9d50/3FmMvyeH5xxc3dx
	 8Cn1Pa+7gjitV01b+BuoYrPdvNEeyNQKQkoPd8zsTORjdSW6VpJ9VYwpHjT18CgQXd
	 MyRhFnI7xBKj+Z0rSYfVEtM2vdmTGWT1Ptr5V99teqvtDSL/Xtu/cR6gJNPuPXNKqs
	 naLXyahhpIhkMZtcxE4UKrOxVvzoWMom9nhu3Cqza7Xl4TIjpGzFqUpCsNUFKAidKb
	 m6IVcJ3EAiG2Q==
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, asias@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 23:39:15 +0000
Message-ID: <178960195580.22033.2015490803994413730@kernel.org>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete race fix: `vsk->transport != NULL` is not a reliable
  sentinel for "a connect() waiter is still in flight", so the exact bug…

--

vsock: Enforce no-transport invariant for TCP_LISTEN sockets

The patch makes vsock_listen() reject sockets that already have a transport
assigned, so that a socket cannot become a listener while a connect() wait
loop is still running on it.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58afb..499e902becfad 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
>  		goto out;
>  	}
>  
> -	if (sock->state != SS_UNCONNECTED) {
> +	vsk = vsock_sk(sk);
> +
> +	if (sock->state != SS_UNCONNECTED || vsk->transport) {
>  		err = -EINVAL;
>  		goto out;
>  	}

[Severity: High]
Is vsk->transport a reliable indicator that no connect() waiter is in
flight?

vsock_assign_transport() drops the old transport before the new one is
validated and initialized:

net/vmw_vsock/af_vsock.c:vsock_assign_transport() {
	...
	if (vsk->transport) {
		vsk->transport->release(vsk);
		vsock_deassign_transport(vsk);	/* vsk->transport = NULL */
		...
		sk->sk_state = TCP_CLOSE;
		...
	}

	if (sk->sk_type == SOCK_SEQPACKET) {
		if (!new_transport->seqpacket_allow ||
		    !new_transport->seqpacket_allow(vsk, remote_cid)) {
			module_put(new_transport->module);
			return -ESOCKTNOSUPPORT;
		}
	}

	ret = new_transport->init(vsk, psk);
	if (ret) {
		module_put(new_transport->module);
		return ret;
	}

	vsk->transport = new_transport;
	...
}

Both of those failure returns happen after vsock_deassign_transport(), so
the socket is left with vsk->transport == NULL while it is still alive and
still bound (vsock_remove_sock() keeps the binding unless SOCK_DEAD is set).

The seqpacket path looks reachable without any allocation failure: only
virtio_transport.c and vsock_loopback.c define .seqpacket_allow, so a
SOCK_SEQPACKET reassignment that resolves to vmci returns -ESOCKTNOSUPPORT.
The init path is reachable via the kzalloc in
virtio_transport_do_socket_init().

Can the following interleaving still put a listener into TCP_CLOSE?

Thread A: blocking connect(), transport T1 assigned, TCP_SYN_SENT,
	  sock->state = SS_CONNECTING, enters the wait loop
Thread B: connect() on the same fd hits case SS_CONNECTING (-EALREADY)
	  and joins the same wait loop
Thread A: timeout fires and runs the signal/timeout branch of
	  vsock_connect(), leaving TCP_CLOSE / SS_UNCONNECTED and keeping
	  T1 ("We keep the binding and the transport assigned"), while
	  thread B still sleeps with the sock lock released
Thread C: connect() to a peer that resolves to a different transport, so
	  vsock_assign_transport() deassigns T1 and then fails at the
	  seqpacket_allow check or in init(); vsk->transport is now NULL
Thread D: listen() sees sock->state == SS_UNCONNECTED and
	  vsk->transport == NULL, passes the new gate and sets TCP_LISTEN
Thread B: wakes up; TCP_LISTEN is neither TCP_ESTABLISHED nor TCP_CLOSING
	  and sk_err == 0, so it keeps looping, and on the next
	  signal/timeout it runs:

net/vmw_vsock/af_vsock.c:vsock_connect() {
	...
		if (signal_pending(current) || timeout == 0) {
			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
			...
			sk->sk_state = TCP_CLOSE;
			sock->state = SS_UNCONNECTED;

			vsock_transport_cancel_pkt(vsk);

			goto out_wait;
		}
	...
}

That stale waiter rewrites sk_state and sock->state without re-checking
whether the socket became a listener in the meantime, so accept() on it
would then return -EINVAL and incoming requests would no longer be queued,
while entries from the listener phase remain on pending_links/accept_queue.

The window is also user-controllable through SO_VM_SOCKETS_CONNECT_TIMEOUT,
which sets vsk->connect_timeout read at loop entry.

Reading the rest of the series, up to b93debf817d4 ("vsock: Handle sudden
TCP_CLOSE during connect"), vsock_assign_transport() is unchanged,
vsock_listen() still gates only on sock->state != SS_UNCONNECTED ||
vsk->transport, and the waiter still rewrites sk_state/sock->state, so the
gap does not appear to be closed later either.

Would it make more sense to express the invariant as "no connect() waiter
outstanding", or to make the reassignment failure paths not leave a live
socket transport-less?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7%40rbox.co
