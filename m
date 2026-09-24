Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E741447D938;
	Thu, 24 Sep 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255707; cv=none; b=Sbf2Zjl95RBDPVA/MP2cV8GFR57/84dMDoZj7dGeYgTDN3TaOHDIkC4gdsL8BHcgcN8ZAze3NVTUld46vAsr9CPi2fN9iRs+3CMBaNF+ChF+n6I1XRyRs+dGp2fNX5rMbCO64qG97aZqX8nWtVdq3QsePLUkojA5mpQ6zcyCR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255707; c=relaxed/simple;
	bh=IVOFSzKDDnuAQJvDeDKAkHzBxHHeO9GrAPHb+jDNZB4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltXAtX4Mobkbpa/1F88ts3+a81pMOGnknvc4MlcoIFrf/XBSrmlSYRdHw1PkYTLIgPq6fICFqna7YcihoRdvDv/go6AGhdrGjB6tS2EH5GnfrI8DjKoqIULD+7ZY/0xF14cHuAiUtXyUSW3e/m70Piu4V8kpD8mDfsEPXDifB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGwSPG1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGwSPG1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E111F00898;
	Thu, 24 Sep 2026 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255705;
	bh=Yv+LvmDc4+GOwovnKN15pAyNbsYBYUIHkB9gzQ0Y8JE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lGwSPG1kwOjE0VJO7W3V7NRRNfHMXYDEz9nsP0bNPZHNb7Z6kZ8a5Ly0gUKWULwx4
	 ukCaFPC1nJx3sWX8UwA2Lo+6Aq5mTDR35k+4Yv4osQQ/loWdUBsG/HCFqL0+Nanas9
	 248W/bgJ8WyhCYM346TrwA+M7u4F5pzGqmC2zODOH048boQPQkFER81pi46cwMpok0
	 GggPjhA7bUxDuAJ1EnKhJoxKcfWzlzfOLzcS/Qj2fsu54QmbSXQ+lNLmcBdicnUP3Y
	 lmoClDpgIy5B07ADocDeJzRnGw76FWcjvTsdu00W97RE3etnKgm88NCekqLF+WLn20
	 6rcbvZwab4SfQ==
Subject: Re: [PATCH net v3 4/8] vsock: drop the re-assignment logic
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
Date: Thu, 24 Sep 2026 13:15:04 +0000
Message-ID: <179025570429.2160803.6079312973703621422@kernel.org>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-4-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-4-78907b8200d4@rbox.co>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The invariant this patch asserts ("On a failed connect(),
  transport is de-assigned", enforced by the new…
- [Low] Two in-tree comments still justify the SOCK_DEAD gating in
  vsock_remove_sock() by the "transport reassignment" case, which…
- [Low] vsock_assign_transport() gains a hard precondition (the socket
  must have neither ->transport nor ->trans set, otherwise WARN +…

--

vsock: drop the re-assignment logic

This removes the transport re-assignment path from vsock_assign_transport()
and replaces it with an assertion that the socket has no transport and no
private transport state yet.  The rationale given is that a failed
connect() de-assigns the transport and a connected socket keeps its
transport until close().

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 20181ddde114f..5cecd1c9c6e50 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -604,6 +604,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  	__u8 remote_flags;
>  	int ret;
>  
> +	if (WARN_ON_ONCE(vsk->transport || vsk->trans))
> +		return -EINVAL;
> +

[Severity: Medium]
Is the invariant behind this assertion always true?  The commit message
says "On a failed connect(), transport is de-assigned", but
vsock_unconnected_reset() can return early without de-assigning:

net/vmw_vsock/af_vsock.c:vsock_unconnected_reset() {
	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
			 sk->sk_state != TCP_CLOSE))
		return;
	...
	vsock_deassign_transport(vsk);
	...
}

With the VMCI transport, can a peer detach during the handshake produce
exactly that state?  vmci_transport_recv_connecting_client_negotiate()
subscribes the detach callback while sk_state is still TCP_SYN_SENT, and
then:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	sock_set_flag(sk, SOCK_DONE);

	/* On a detach the peer will not be sending or receiving
	 * anymore.
	 */
	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
	...
		if (sk->sk_state == TCP_SYN_SENT) {
	...
			sk->sk_state = TCP_CLOSE;
			sk->sk_err = ECONNRESET;
}

The blocking connect() then wakes on sk_err and takes:

net/vmw_vsock/af_vsock.c:vsock_connect() {
out_reset:
	if (err)
		vsock_unconnected_reset(sk);
}

so WARN_ON_ONCE(vsk->peer_shutdown) fires and the transport is never
de-assigned, leaving sock->state at SS_CONNECTING until close().  A later
vsock_assign_transport() on that socket would then hit the new assertion
added here.

At this commit there also seems to be a second, transport-independent way
in: a peer RESPONSE followed by RST leaves the socket in TCP_CLOSING with
SOCK_DONE and peer_shutdown set while connect() sleeps, and since the wait
loop here only breaks on TCP_ESTABLISHED, a signal or the connect timeout
routes to out_reset with err != 0 and trips the same warnings.  That second
path looks like it is addressed later in the series by "vsock: treat
TCP_CLOSING as once-established" and the SS_CONNECTED guard from "vsock:
handle socket bricking due to transport event", but the VMCI detach case
appears to survive to the end of the series.

Would it make sense to make vsock_unconnected_reset() de-assign the
transport unconditionally, or to normalize SOCK_DONE/peer_shutdown there
before the checks?

[Severity: Low]
Could the new precondition be documented?  vsock_assign_transport() is
EXPORT_SYMBOL_GPL'd and called by the transports
(virtio_transport_common.c, vmci_transport.c, hyperv_transport.c), but the
descriptive block above the function still only covers transport selection
and the -ENODEV case:

/* Assign a transport to a socket and call the .init transport callback.
 *
 * Note: for connection oriented socket this must be called when vsk->remote_addr
 * is set ...
 *  - anything else goes to h2g or returns -ENODEV if no h2g is available
 */

and the declaration in include/net/af_vsock.h carries no documentation.  A
note that the function is one-shot per socket and now returns -EINVAL if
vsk->transport or vsk->trans is already set would help future callers.

[ ... ]

> @@ -668,26 +666,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  	 */
>  	mutex_unlock(&vsock_register_mutex);
>  
> -	if (vsk->transport) {
> -		/* transport->release() must be called with sock lock acquired.
> -		 * This path can only be taken during vsock_connect(), where we
> -		 * have already held the sock lock. In the other cases, this
> -		 * function is called on a new socket which is not assigned to
> -		 * any transport.
> -		 */
> -		vsk->transport->release(vsk);
> -		vsock_deassign_transport(vsk);
> -
> -		/* transport's release() and destruct() can touch some socket
> -		 * state, since we are reassigning the socket to a new transport
> -		 * during vsock_connect(), let's reset these fields to have a
> -		 * clean state.
> -		 */
> -		sock_reset_flag(sk, SOCK_DONE);
> -		sk->sk_state = TCP_CLOSE;
> -		WRITE_ONCE(vsk->peer_shutdown, 0);
> -	}
> -

[Severity: Low]
With this block gone, two comments elsewhere in the file still explain a
load-bearing check in terms of reassignment.  Should they be updated?

net/vmw_vsock/af_vsock.c:vsock_remove_sock() {
	/* Transport reassignment must not remove the binding. */
	if (sock_flag(sk_vsock(vsk), SOCK_DEAD))
		vsock_remove_bound(vsk);
}

net/vmw_vsock/af_vsock.c:__vsock_release() {
	/* Indicate to vsock_remove_sock() that the socket is being released and
	 * can be removed from the bound_table. Unlike transport reassignment
	 * case, where the socket must remain bound despite vsock_remove_sock()
	 * being called from the transport release() callback.
	 */
	sock_set_flag(sk, SOCK_DEAD);
}

The SOCK_DEAD test itself still looks necessary, but for other callers:
virtio_transport_recv_connected() and virtio_transport_remove_sock() on the
RST path, and hvs_do_close_lock_held() from hvs_close_connection(), all run
on live sockets without SOCK_DEAD set.  The reassignment reason the
comments name no longer exists after this patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4%40rbox.co
