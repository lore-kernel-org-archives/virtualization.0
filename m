Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766648096F;
	Thu, 24 Sep 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255709; cv=none; b=NfMViS/X/ghiW+k4A1gsBg/N5VrKKYb+m7KO5szfoQDSL+IHcS6wK+00yRQUYiQ/Xud6z3hgcbFZTLIetDk72ojnNb64l3CvQfjSCBjBkD4YhrqabotNh/gJgR8lj1dJFPCC8vkVrnEiVu4j6maYNOc8J2QTosGKvipr/J03sSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255709; c=relaxed/simple;
	bh=oqoB2lrXibWoRaZlOMGU+9FJXSMPqmM6IgKONybd2HI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QkZ8Qk911HG1prmq3uJJqMV+19l6G85lYXlR6Jn+dSRJilxCwoDh74Xd5tg5xpcC3TWV5fhkHcGlql/vNmEIaX4G+c0SA5S/TEf5dNq8fREzLavqbSqEBeFYv8G09/DYCoqRjiPzvHr26QUOrlOalrHsWD3cjHitsStoaHQwcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZByoMuO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZByoMuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F4C1F000FF;
	Thu, 24 Sep 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255707;
	bh=h5DHjDtJA0Z9XkY1ugtFj02RoadRwZe5IvVliuif+Fc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MZByoMuO/lsk239DluCY1FfHk7j5utvwe58ogf+cAtx4tQaSk54+FRIzto1SKbPCE
	 kjvaAdChJcuVRF3Q0MKCDfRkul1UhBq9Gnt7jicfnNF+szlDKxNxUoc/U1J0NeOak6
	 iu7FRxqA+tREeWGOqDaLwHtnW53BEe2nkfUS7W1wvnfjoOa7FffePiq4aVlRRwmNZy
	 3/gCyiENSl96wSzSoo3D/7HKlhQHoYebT9VllpQVf/wG/adgkmzzyo3FU5XnMr6rne
	 E+0v5zg3RS40tlGUIv9fDbxrmIpsHwnyuxzHqbQTkW1PYg31GFBokD/JMY8UuslBsF
	 N9PnwpGUt43KQ==
Subject: Re: [PATCH net v3 5/8] vsock: treat TCP_CLOSING as once-established
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
Date: Thu, 24 Sep 2026 13:15:05 +0000
Message-ID: <179025570581.2160803.6664724141686428896@kernel.org>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-5-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-5-78907b8200d4@rbox.co>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The failed-connect cleanup at the out_reset label of
  vsock_connect() (net/vmw_vsock/af_vsock.c:1883-1884), which this patch…
- [Low] Concern (validated as NOT a defect to report against this
  series): the new short-circuit in vsock_connect() enumerates only…

--

vsock: treat TCP_CLOSING as once-established

The patch makes blocking connect() stop treating a socket that already
reached TCP_ESTABLISHED and then moved to TCP_CLOSING (or picked up an
sk_err) as a failed connection attempt, returning 0 instead. It also makes
the out_reset cleanup call vsock_unconnected_reset() unconditionally rather
than only when err is non-zero.

Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5cecd1c9c6e50..ff4140aaf1f32 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1846,15 +1846,19 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
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
> +			finish_wait(sk_sleep(sk), &wait);
> +			goto out;
> +		}

[Severity: Low]
This isn't a bug, but the new short circuit lists only TCP_ESTABLISHED and
TCP_CLOSING as "once established", while an established socket can also be
taken straight to TCP_CLOSE by a transport event while connect() is
scheduled out:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	...
			sk->sk_state = TCP_CLOSE;
		}
		sk->sk_state_change(sk);
}

net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
}

Those sockets were established as well, but they miss this check, so
connect() still returns -ECONNRESET or -ETIMEDOUT for them.

The cleanup side of that case is covered by the follow-up patch in this
series, "vsock: handle socket bricking due to transport event", which adds
an early return to vsock_unconnected_reset() for sock->state ==
SS_CONNECTED or SS_DISCONNECTING, and neither of the two transport paths
above modifies sk->sk_socket->state.

Is the remaining difference in the connect() return value for the TCP_CLOSE
case the intended behaviour?

>  
>  		/* If connection was _not_ established and a signal/timeout came
>  		 * to be, we want the socket's state reset. We keep the binding.
> @@ -1877,8 +1881,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  out_wait:
>  	finish_wait(sk_sleep(sk), &wait);
>  out_reset:
> -	if (err)
> -		vsock_unconnected_reset(sk);
> +	vsock_unconnected_reset(sk);

[Severity: High]
With this call now unconditional, can a VMCI detach during the handshake
turn this cleanup into a silent no-op plus a warning backtrace?

vmci_transport_handle_detach() sets the flags before it inspects sk_state,
and it explicitly handles the TCP_SYN_SENT case:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	...
		sock_set_flag(sk, SOCK_DONE);
	...
		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
	...
			if (sk->sk_state == TCP_SYN_SENT) {
				sk->sk_state = TCP_CLOSE;
				sk->sk_err = ECONNRESET;
				sk_error_report(sk);
				return;
			}
}

The valid qp_handle that this path requires is already installed while the
client socket is still TCP_SYN_SENT, by
vmci_transport_recv_connecting_client_negotiate(), which also subscribes
detach_sub_id; TCP_ESTABLISHED is only set later on ATTACH. The detach
callback runs under bh_lock_sock() while blocking connect() has dropped the
socket lock in release_sock()/schedule_timeout().

The woken connect() then sees sk_state == TCP_CLOSE, so the new
ESTABLISHED/TCP_CLOSING short circuit above does not apply, it leaves the
loop on sk_err != 0, takes err = sock_error(sk) and reaches
vsock_unconnected_reset(), where the first check fires and returns:

net/vmw_vsock/af_vsock.c:vsock_unconnected_reset() {
	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
			 sk->sk_state != TCP_CLOSE))
		return;
	...
}

That skips vsock_transport_cancel_pkt(), vsock_deassign_transport(), the
WRITE_ONCE(sk->sk_state, TCP_CLOSE) and sk->sk_socket->state =
SS_UNCONNECTED.

Does that leave the socket with its transport still assigned and
sock->state stuck at SS_CONNECTING, so later connect() attempts return
-EALREADY for O_NONBLOCK, or re-enter the loop, burn the full
vsk->connect_timeout and return -ETIMEDOUT?

Before this series the same path simply did sk->sk_state = TCP_CLOSE;
sock->state = SS_UNCONNECTED; with no warning, and the socket stayed
retryable. At the end of the series the new SS_CONNECTED/SS_DISCONNECTING
early return in vsock_unconnected_reset() does not cover this case, since
sock->state is SS_CONNECTING here and sk_state is TCP_CLOSE, so the
WARN_ON_ONCE(vsk->peer_shutdown) check is still the one that fires.

>  out:
>  	release_sock(sk);
>  	return err;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4%40rbox.co
