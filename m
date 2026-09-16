Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43D4AB3B5;
	Wed, 16 Sep 2026 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601961; cv=none; b=fdaVGZw5tAF+XYXDIwseMaROMGjxbl6prDbLTmtvWRfBATY1RK8D5BKt6ySLbFsH3MQHb0pu7dDPISX/F2dT2t/rXCgDMKXN0U8UygFR+OFn8BFQyj24maikgbBBExTpCmfrRiANjV5UL8/LgJChx7wBdv6pK0AlBAQM0JYB4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601961; c=relaxed/simple;
	bh=iWzhTfSozXXM+lntzjqYajGJ154AXJP+CJho0JJF1Sk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dA/osQc+uRtfZwlPUylVb4oeW9XdITExpKf/fcV/ceJ74Syc9wgltKo/NjmVZrhe071zwwWtLgjadXuSIP6nr6/i6s+GHAl/cTwRQXLUP8l26c1a44z64WtcMC9Yx9pbWNh2W+sobcaN9VkrLtA1KJhWorc0FEoEtz4efFKFTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmEJ5fI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmEJ5fI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ABB1F00899;
	Wed, 16 Sep 2026 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601960;
	bh=VJr9XzYaVEQFQOTiu+z8jJTc4QbuNgO1YA8XzQY5KyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RmEJ5fI/UNw+B2Cn2EETGeKvx2izEJIifHVZGPQhL+cK87PXHzQRJy0+3wtcVFxOb
	 KbuPTQAwRjAKJ3ln91ERoLQKzKHWLegLDXdxE8R8eze8X55u+roCrSslqN6SnCZts3
	 4L7JD0JoXDf/LLnOJMr7ISwf1txPGU7EnZV/9R5cIkfcA5JfnafWVh+0PGZenLhh/P
	 hHQykfmkQ6K+FeZqni6u4GgV0tEfRubpkk6cvPXVUwYqU93X3xXe82ZPnSatrzfNjW
	 d+dcc5Py5VuRDZ4CJ7y6gOEKS5oX9O2WvJGHqgSTqJFPYvDIxfuRrZZMNOG09TidDH
	 OTPNK+hWxanEA==
Subject: Re: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during connect
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, asias@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 23:39:18 +0000
Message-ID: <178960195898.22033.11234095166779171405@kernel.org>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The new consumer in vsock_connect() reads the poison flag with
  READ_ONCE(vsk->peer_shutdown) (net/vmw_vsock/af_vsock.c:1747), but the…
- [Low] Undeclared intra-series dependency: the new guard in
  vsock_connect() (net/vmw_vsock/af_vsock.c:1747) only *reads*…

--

vsock: Handle sudden TCP_CLOSE during connect

This adds a check in vsock_connect() that refuses a fresh connect attempt
with -ECONNRESET when vsk->peer_shutdown is already set, so that a socket
poisoned by a lockless virtio/PM/vhost/VMCI reset event cannot be handed a
new transport or pushed back into TCP_SYN_SENT.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index adf3f018347ea..972952d04a81a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1743,6 +1743,12 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  			goto out;
>  		}
>
> +		/* Virtio/PM events are serviced locklessly. */
> +		if (READ_ONCE(vsk->peer_shutdown)) {
> +			err = -ECONNRESET;
> +			goto out;
> +		}
> +

[Severity: Low]
The comment mentions virtio/PM events, but this hunk only reads
vsk->peer_shutdown.  For the virtio/PM path the flag is published by
virtio_vsock_reset_sock() in net/vmw_vsock/virtio_transport.c:

	vsk->peer_shutdown = SHUTDOWN_MASK;
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;

That store comes from the immediately preceding patch in this series
("vsock/virtio: Streamline socket reset on transport/PM event"); at the
parent commit virtio_vsock_reset_sock() only sets sk_state and sk_err.

Given the Fixes: d021c344051a tag reaching back to 2013, would it be worth
spelling out the dependency so that a stable/AUTOSEL pick does not take this
commit alone?  On its own the new check would be a no-op for exactly the
virtio/PM scenario the changelog leads with, and only vhost's
vhost_vsock_reset_orphans() and VMCI's vmci_transport_handle_detach() (which
already set the flag) would be covered.

[Severity: Medium]
Should the writers of this flag be marked to match the new READ_ONCE()
reader?  The two handlers named in the changelog store it plainly:

net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
	vsk->peer_shutdown = SHUTDOWN_MASK;
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
}

drivers/vhost/vsock.c:vhost_vsock_reset_orphans() {
	sock_set_flag(sk, SOCK_DONE);
	vsk->peer_shutdown = SHUTDOWN_MASK;
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
}

Both run from vsock_for_each_connected_socket() under
spin_lock_bh(&vsock_table_lock) only, never under lock_sock(), so they share
no lock with vsock_connect().  Every other lockless writer of the field uses
WRITE_ONCE(), for example vmci_transport_handle_detach(),
virtio_transport_recv_pkt() in virtio_transport_common.c and
hvs_close_connection() in hyperv_transport.c.  Is the plain store racing the
new marked read something KCSAN would flag here?

There is also no barrier pairing the poison store with the sk_state/sk_err
stores that connect() actually leaves its wait loop on.  Can the following
still happen on a weakly ordered machine?

	connect() wait loop exits on timeout/signal:
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
		vsock_transport_cancel_pkt(vsk);

	userspace retries connect(), reads peer_shutdown == 0,
	falls through to vsock_assign_transport() and
		sk->sk_state = TCP_SYN_SENT;

while the socket is still hashed in connected_table.  A later OP_RESPONSE
then reaches virtio_transport_recv_connecting(), which calls
vsock_insert_connected() unconditionally, and __vsock_insert_connected() does
a bare list_add() on an already-linked node.  That is the list_add double add
splat described in the sibling commit 6f06a44e.

Would a WRITE_ONCE() for both stores, plus explicit ordering between the
peer_shutdown store and the sk_state/sk_err stores, close that window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7%40rbox.co
