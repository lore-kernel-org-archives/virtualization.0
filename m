Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005B4854F2;
	Thu, 24 Sep 2026 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255711; cv=none; b=e67NJ3VS3opkspvTx/gDG7ZKS0f7zHvm8hQUqUzYejjDQHIRv5VpUbEtCKQoJIJoUoacnab8gj4y5dwQQ+GzPbso/3eTXRFjHCqH1NGXPOdBoDXicTmgivyn1jiFhiGBjH6/lJA+h9vIxygAWFlRv1wQuBilWdy5qGgy43tATRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255711; c=relaxed/simple;
	bh=kxG5drWNI1YkqfoR+fQYyOx2/eVcHAFM//dXBmkX/bg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxJSb7840pkTHhc4Y5WHARYxxd3UFqcFQo0bPBBD7FRB2ZysHBnBLgCD99CCGdwQiHF3ckiLLzDQiDh3He7U6mBXh9Bsfq/vo/qfKWshBR36QRq9++pY7zzxPyrZadWiCislq9YBayTFqw1uBu1qNIr4dz+Du++8cuZo6ihI0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4oUvOuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4oUvOuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B551B1F00893;
	Thu, 24 Sep 2026 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255708;
	bh=zfcxlp81RZQ0P3BS23/W58Ta2s6bNUUwTVV2DPii4F8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y4oUvOuDwOd+ZYsjYakukFb4tNH+G0x3AVqtOGfQssIfeUA/gDc/nnLamDIQMj3ZQ
	 RUizSw+5nwmBrE529kDcZwpcviM4ADSs0tiWkdhIDyaubg1ID5ONkeZjbu9ZCLo5zF
	 4BIQ9xLO2wn12ABQQyPgsg3JkvT5yJk/Z7XKDmRQkEZXp0r6sq2hYBFL+2p3O/ZGOF
	 /am3/uhcDAdYy4J4nj3208nkSYqmrJFUoH3mkvPoGmmke8hlzVbfB7doQ2CPwSsTWu
	 GWOp4n2sQ9d7sWRNqnWUmyLFLycZB4++SKJl4asilTM1cd+zdM+5f4RwqtArruSTuT
	 oR3bNK2/kMTEQ==
Subject:
 Re: [PATCH net v3 6/8] vsock: handle socket bricking due to transport event
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
Date: Thu, 24 Sep 2026 13:15:07 +0000
Message-ID: <179025570732.2160803.4275584152310711154@kernel.org>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-6-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-6-78907b8200d4@rbox.co>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Over-broad new guard in vsock_unconnected_reset(): the early
  return also fires for sockets that were never established.
- [High] Incomplete race guard: vmci_transport_handle_detach() can brick
  a socket that is still TCP_SYN_SENT / SS_CONNECTING, which the new…

--

vsock: handle socket bricking due to transport event

Transport events reset connected sockets to TCP_CLOSE without holding
lock_sock(), so connect() can observe the reset concurrently.  This patch
makes vsock_unconnected_reset() bail out early when the socket-level state
is SS_CONNECTED or SS_DISCONNECTING, on the premise that transport events
leave SS_CONNECTED unchanged.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index ff4140aaf1f32..5a2d7e10ecb88 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1663,6 +1663,19 @@ static void vsock_unconnected_reset(struct sock *sk)
>  
>  	sock_owned_by_me(sk);
>  
> +	/*
> +	 * Transport events are serviced by resetting each connected socket to
> +	 * TCP_CLOSE. The reset is done under vsock_table_lock but without
> +	 * taking lock_sock(), so it is effectively lockless from the
> +	 * perspective of connect().
> +	 *
> +	 * Preserve socket's bricked status. Also check SS_DISCONNECTING, since
> +	 * shutdown() may race us.
> +	 */
> +	if (sk->sk_socket->state == SS_CONNECTED ||
> +	    sk->sk_socket->state == SS_DISCONNECTING)
> +		return;
> +

[Severity: High]
Can the SS_DISCONNECTING part of this test also swallow the reset for a
socket that never established?

vsock_shutdown() moves any socket that is not SS_UNCONNECTED to
SS_DISCONNECTING, including one that is merely SS_CONNECTING /
TCP_SYN_SENT:

net/vmw_vsock/af_vsock.c:vsock_shutdown() {
	...
	if (sock->state == SS_UNCONNECTED) {
		err = -ENOTCONN;
		if (sock_type_connectible(sk->sk_type))
			goto out;
	} else {
		sock->state = SS_DISCONNECTING;
		err = 0;
	}
	...
}

For a blocking connect(), thread A sleeps in schedule_timeout() with the
socket lock released, thread B calls shutdown(fd, SHUT_RD).  sk_state stays
TCP_SYN_SENT and sk_err stays 0, so the wait loop keeps sleeping until the
timeout or a signal, then takes out_wait -> out_reset ->
vsock_unconnected_reset(), which now returns here because sock->state is
SS_DISCONNECTING.

For a non-blocking connect(), the same guard in vsock_connect_timeout()
does not filter a SHUT_RD-only shutdown:

net/vmw_vsock/af_vsock.c:vsock_connect_timeout() {
	...
	if (sk->sk_state == TCP_SYN_SENT &&
	    (sk->sk_shutdown != SHUTDOWN_MASK)) {
		sk->sk_err = ETIMEDOUT;
		sk_error_report(sk);
		vsock_unconnected_reset(sk);
	}
	...
}

so the worker calls the helper and the reset is swallowed there too.

In both cases vsock_transport_cancel_pkt(), vsock_deassign_transport() and
the WRITE_ONCE(sk->sk_state, TCP_CLOSE) / sk->sk_socket->state =
SS_UNCONNECTED below are skipped, and no further timeout is armed.  Does
that leave the socket stuck in TCP_SYN_SENT with the transport still
assigned and the VIRTIO_VSOCK_OP_REQUEST not cancelled?

A late response then still matches TCP_SYN_SENT:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_connecting() {
	...
	case VIRTIO_VSOCK_OP_RESPONSE:
		sk->sk_state = TCP_ESTABLISHED;
		sk->sk_socket->state = SS_CONNECTED;
		vsock_insert_connected(vsk);
	...
}

so the connection can complete and become usable for send()/recv() after
connect() already returned -ETIMEDOUT or -EINTR.  A retry of connect() now
hits case SS_DISCONNECTING: err = -EINVAL, whereas before this patch the
failure path reset the socket to TCP_CLOSE / SS_UNCONNECTED.

Would an explicit flag, or a vsock_connected_table membership test, express
the intended "socket was once established" condition better than
sock->state?

[Severity: High]
The commit message says "But transport events leave SS_CONNECTED state
unchanged" and lists vmci_transport_handle_detach() as one of the handlers.
Does that hold for the VMCI detach path?

vmci_transport_handle_detach() runs from vmci_transport_peer_detach_cb()
under trans->lock plus bh_lock_sock() only, i.e. concurrently with a
connect() that released the socket lock in schedule_timeout(), and it
mutates a socket that is still in the handshake:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
		sock_set_flag(sk, SOCK_DONE);
		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
		...
			if (sk->sk_state == TCP_SYN_SENT) {
				sk->sk_state = TCP_CLOSE;
				sk->sk_err = ECONNRESET;
	...
}

A client socket already owns a valid qp_handle while still TCP_SYN_SENT,
because vmci_transport_recv_connecting_client_negotiate() publishes
vmci_trans(vsk)->qp_handle and detach_sub_id before ATTACH arrives;
SS_CONNECTED is only set later in the ATTACH branch of
vmci_transport_recv_connecting_client().

Since the handler never touches sk->sk_socket->state, connect() left it at
SS_CONNECTING, so the new check does not match.  connect()'s loop exits on
sk_err != 0 and reaches out_reset -> vsock_unconnected_reset(), where the
existing checks below fire:

	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
			 sk->sk_state != TCP_CLOSE))
		return;

Can a peer VM detaching mid-handshake therefore still produce these
WARN_ON_ONCE() splats and still skip vsock_transport_cancel_pkt() and
vsock_deassign_transport(), leaving the stale transport assignment the
patch aims to avoid?

This appears to be still present at the end of the series; the later commit
6b7829ad only adds the TCP_LISTEN check.

>  	/*
>  	 * Only connected socks may have peer_shutdown or SOCK_DONE set.
>  	 *

Thanks for looking into these.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4%40rbox.co
