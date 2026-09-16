Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB544E4304;
	Wed, 16 Sep 2026 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601960; cv=none; b=fdbV46SyZ1WG999HvPomTrdFF0IOVXpvbemoGH3kKQFsIoQE09d7HwbvSqOY1xxnzc729vIqEo4yykFNO6eZlDkl6KOeF/6XqCP/vMSXfug16ciIx/R4asmOmpF44tKJgG03HpEdORge0qINHxeYZWm6D43lUodHS9VC0bTS5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601960; c=relaxed/simple;
	bh=0VruGOcHMn7s4Xvh7/5PEOZ6dO5OOxNk6OshssXhJ/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RsK0/jyHFGX6rvb+tBZaHx/cnib/jhKjNwdGb7W8vOdsxnTcpH8hRtIdcGsx1wYdQ9+18lLLQozaIthqnsnLwFzop1x9wVlnkrHhMUl23kb4DhI/PxTAXAyDNMayPaA9VSGH0vGFrQcb88SOzOY6c17xdCMkA6S/F2oB4GgviUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnjkX/V8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnjkX/V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF51A1F000FF;
	Wed, 16 Sep 2026 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601955;
	bh=filjnyf342E4M2H2Obf85mVFGHrLc3neRKaFrYuW0tA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XnjkX/V8257k3/suTp3HKJR7LMRPwEWAZuYF3pCsAB74Ghv1KpJDHxncxO6a0Zyoq
	 Hq9wr/U7ujGEHvT7Ydz2ub0HN1bBunPXYTxyYhxiyio0QeOE2NKdwfS26fc7lCf3Tt
	 LeKWvKgE77P5bqGgYuiJyOwtIpqmrCxilQ9pJr4T6R8vdGtRxZSjFri/YwYkyNS0Ho
	 WQFzB9T27e0e+QTUa3WFwFlAqqTUym6a3LQZKFcdbWknd6/f0gp9Bc3+vzGK/8MObT
	 fkYc1RVmKz6LbUu0lBvR2O8mtUakvfN+qqSKzWp1layUSqrNQbgk+q5yKXJzlmynfp
	 eCKqmsN8tGdPw==
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, asias@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 23:39:14 +0000
Message-ID: <178960195424.22033.1318608175795217350@kernel.org>
In-Reply-To: <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
References: <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] Lost-update race: the new lockless store `vsk->peer_shutdown =
  SHUTDOWN_MASK;` in virtio_vsock_reset_sock()…
- [Medium] Unannotated (plain) store to a locklessly-read field:
  virtio_vsock_reset_sock() (net/vmw_vsock/virtio_transport.c:423)…
- [Medium] Commit message does not describe the bug being fixed nor the
  user-visible behaviour change, while carrying a Fixes: tag.

--

vsock/virtio: Streamline socket reset on transport/PM event

This makes virtio_vsock_reset_sock() set vsk->peer_shutdown to
SHUTDOWN_MASK in addition to setting TCP_CLOSE and ECONNRESET, matching
what vhost_vsock_reset_orphans() and vmci_transport_handle_detach() do.
The changelog describes it as groundwork for later patches in the series.

A few questions below, one about the changelog and two about the new
store itself.

> vsock/virtio: Streamline socket reset on transport/PM event
>
> Follow vhost's vhost_vsock_reset_orphans() and VMCI's
> vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
> later in the series.
>
> Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")

[Severity: Medium]
The changelog says the new state "will come handy later in the series",
but the patch carries a Fixes: tag against the original transport commit.
Could the changelog state the failure mode that is being fixed, so this
can be judged (and backported) on its own?

The change also looks user-visible by itself. After
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET or device removal/PM freeze,
vsock_poll_shutdown() now contributes EPOLLRDHUP:

	if (sk->sk_shutdown & RCV_SHUTDOWN ||
	    peer_shutdown & SEND_SHUTDOWN)
		mask |= EPOLLRDHUP;

and vsock_poll() adds EPOLLIN|EPOLLRDNORM, while the blocking send/recv
loops now terminate on the peer_shutdown condition rather than only on
sk_err.

The errno also changes for send(). In vsock_connectible_sendmsg() the
peer shutdown test runs before the state test:

	if (sk->sk_shutdown & SEND_SHUTDOWN ||
	    vsk->peer_shutdown & RCV_SHUTDOWN) {
		err = -EPIPE;
		goto out;
	}

	if (!transport || sk->sk_state != TCP_ESTABLISHED ||

For SOCK_STREAM the error is then passed through sk_stream_error(), which
consumes the pending ECONNRESET on the first call and raises SIGPIPE on
subsequent calls unless MSG_NOSIGNAL is set:

net/core/stream.c:sk_stream_error() {
	if (err == -EPIPE)
		err = sock_error(sk) ? : -EPIPE;
	if (err == -EPIPE && !(flags & MSG_NOSIGNAL))
		send_sig(SIGPIPE, current, 0);
}

Before this patch the same send() returned -ENOTCONN and no signal. Is
that behaviour change intended, and could it be mentioned in the
changelog?

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa5..4d6991321699e 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -413,11 +413,14 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
>  
>  static void virtio_vsock_reset_sock(struct sock *sk)
>  {
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
>  	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>  	 * under vsock_table_lock so the sock cannot disappear while we're
>  	 * executing.
>  	 */
>  
> +	vsk->peer_shutdown = SHUTDOWN_MASK;

[Severity: Medium]
Should this store be a WRITE_ONCE()?  As the comment right above it says,
no socket lock is held here, only vsock_table_lock via
vsock_for_each_connected_socket().  peer_shutdown is sampled locklessly
by vsock_poll():

net/vmw_vsock/af_vsock.c:vsock_poll() {
		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);

		/* DGRAM sockets do not take lock_sock() in poll(), so use one
		 * lockless snapshot for all shutdown-derived mask bits.
		 */
	...
		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
		mask |= vsock_poll_shutdown(sk, peer_shutdown);
}

and the equivalent assignment in the same transport is annotated:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_do_close() {
	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
}

The other writers in af_vsock.c, hyperv_transport.c and vmci_transport.c
use WRITE_ONCE() too, so this looks like an unmarked/marked pair that
KCSAN would flag.  The last patch of the series also reads this field
with READ_ONCE() from vsock_connect() with the comment "Virtio/PM events
are serviced locklessly.", which makes the pairing here relevant.

[Severity: High]
Separately from the annotation: can this store be lost against the
read-modify-write in the rx path?

virtio_transport_recv_connected() handles OP_SHUTDOWN under lock_sock():

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_connected() {
	case VIRTIO_VSOCK_OP_SHUTDOWN: {
		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);

		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
			peer_shutdown |= RCV_SHUTDOWN;
		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
			peer_shutdown |= SEND_SHUTDOWN;
		WRITE_ONCE(vsk->peer_shutdown, peer_shutdown);
}

while the reset path holds only vsock_table_lock:

net/vmw_vsock/af_vsock.c:vsock_for_each_connected_socket() {
	spin_lock_bh(&vsock_table_lock);
	...
			fn(sk_vsock(vsk));
}

So the two lock sets are disjoint:

CPU0 (rx_work, lock_sock held)
  virtio_transport_recv_connected()
    peer_shutdown = READ_ONCE(vsk->peer_shutdown);   /* reads 0 */

CPU1 (event_work or device removal)
  virtio_vsock_reset_sock()
    vsk->peer_shutdown = SHUTDOWN_MASK;

CPU0 continues
    WRITE_ONCE(vsk->peer_shutdown, peer_shutdown);   /* stale value wins */

Are these two contexts actually serialized anywhere?  virtio_vsock_vqs_del()
runs the reset loop before rx_run is cleared and rx_work drained:

net/vmw_vsock/virtio_transport.c:virtio_vsock_vqs_del() {
	/* Reset all connected sockets when the VQs disappear */
	vsock_for_each_connected_socket(&virtio_transport.transport,
					virtio_vsock_reset_sock);

	/* Stop all work handlers ... */
	mutex_lock(&vsock->rx_lock);
	vsock->rx_run = false;
}

and the VIRTIO_VSOCK_EVENT_TRANSPORT_RESET path runs from event_work,
which shares the non-ordered virtio_vsock_workqueue with rx_work.

Since hdr->flags is host supplied and is not validated as non-zero, the
value written back by the rx path can be the stale snapshot itself, i.e.
0, which would clear the reset state entirely.  In that case
vsock_poll_shutdown() reports no EPOLLRDHUP/EPOLLHUP, the sendmsg/recvmsg
peer_shutdown tests see a stale mask, and the guard added by the last
patch of the series:

net/vmw_vsock/af_vsock.c:vsock_connect() {
		/* Virtio/PM events are serviced locklessly. */
		if (READ_ONCE(vsk->peer_shutdown)) {
			err = -ECONNRESET;
}

silently passes.  A WRITE_ONCE() alone would not close this; would an
atomic update (atomic OR / cmpxchg), or performing the reset from a
context that can take lock_sock(), be more appropriate here?

>  	sk->sk_state = TCP_CLOSE;
>  	sk->sk_err = ECONNRESET;
>  	sk_error_report(sk);

Both of the above were still present in the same form at the end of the
series, so no later patch appears to change them.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7%40rbox.co
