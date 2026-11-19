Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055276;
	b=ZBK26kAFcjUMBQbiJ92AqszcAhgF2QYg3beArep2OjuLdUNSPylyUepZ8SQ1vTdpSaM0
	 KNiWEmIGc0Qzl43LbEVefToaeywqKsh0e8NiBygZSCSVX2ZBxtVX5/CdavnHHKoARTd40
	 rorlHxLsljgtdZ6dHxSpwDmIr0zMxnHD/eEa07WFwzzWwdg8NZ1fflTj5kzaZ+alXAefc
	 BOwHLUO7BeoTG7DXm8yuzyE3GJ/EDS9VIYJgGjkQzY9KFvUfZypoZ+rG83LGCHe2jZfcd
	 hwG+vn+uCxGo6wa3shRoPz8QSbPh3pQ0J2elsDbOcRD6hgIeA9xkHsjCkrTzfk8LK5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055276;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rfsRZTTooLEvkEIkjQvYssn8EaF5zCGfcjw83BmyLk0=;
	b=Bzqpj8gEUftuSb4BB99a71cKMWMSrBedOmebXCtohH9NTeKlS6+MnmGj52rqPgG0Niur
	 ZyH6u9GaxNbYi4L+XVedesfJYobQvntmu6x3/BpKEnxksaMH8L39H0Rv7RU6mj1tWI7aS
	 yeIx3FwCViGAbzPHQvwrd8rxI2GjW+WeFocHw2unG62YXOpF+7SMmsDAktOCNFU7SeaN3
	 9aaVUiPY9a4wkWDBVS3qpVu3n1o6o0fAwYjWNZzWmVMalcsohHtBlRZQjhc+rE3w2uSCl
	 imjMlUk2Jp43/LTLlo/JeWPykLVPotKcqTVW5tgSq0mb3SKccNxpew0b1tLkfISbfFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QazKFWCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BB606A320;
	Thu, 19 Nov 2026 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QazKFWCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E11F000C5;
	Thu, 19 Nov 2026 02:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795055275;
	bh=rfsRZTTooLEvkEIkjQvYssn8EaF5zCGfcjw83BmyLk0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QazKFWCHIuFijwovA2yxXeMnJUWTPoM1ALlTcLcou5AgHiuz2IUD5nP0MJlkUb9jz
	 bj+7hRCzOM4z1D4rEvt2b7KS2T2He7x0puWqoNUlxJyiXFljsTE0wf7XlJxMAuqt4q
	 uPF+yK1gUVBia9/Pglk9XEGVWvCcVTro5uuOJ2QRlbJEU/HbaLLyvj/uZEq9PlJqnK
	 T5DR7mD7k4JkuB/IKgJ7rVzY26nUmqn6S9jEaWrYLKqHaeRskqFrcm8TUE8+lnjFMI
	 Qh6C9WsxkwzedNLVv7DErilUdmFhyT+RtUyvJIq4Iu5eFfJIWohYObxB0KjGTIO2Th
	 O7484vfwBBDoQ==
Subject:
 Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect() fails
From: netdev-bot+sashiko@kernel.org
To: bobbyeshleman@meta.com
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, georgezhang@vmware.com,
 acking@vmware.com, dtor@vmware.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kylebot@openai.com,
 mhal@rbox.co
Date: Thu, 19 Nov 2026 02:27:54 +0000
Message-ID: <179505527459.3136.4929715245621080353@kernel.org>
In-Reply-To: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A connect() waiter that times out late can still abort a newer
  connect attempt on the same socket.
- [Low] The commit message names the wrong trigger paths.
- [Low] If another thread calls shutdown() while a blocking connect() is
  sleeping, a failed connect now leaves the socket in SS_DISCONNECTING…

--

vsock: only undo SS_CONNECTING when connect() fails

This patch adds a vsock_connect_close() helper. On a failed connect(), it
moves sk_state to TCP_CLOSE only if it is still TCP_SYN_SENT, and moves
sock->state to SS_UNCONNECTED only if it is still SS_CONNECTING. The goal
is to stop a socket that got connected and was then reset from going back
to SS_UNCONNECTED, and to stop a late waiter from overwriting TCP_LISTEN.

Link: https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/

> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> can complete the handshake, setting sock->state to SS_CONNECTED, and then
> reset the connection, e.g. in vhost_vsock_reset_orphans(),
> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> connect() gets the lock back, it finds sk_err set and moves the socket
> back to SS_UNCONNECTED.

[Severity: Low]
Does this description hold for all three examples?

virtio_vsock_reset_sock() fits it: it sets sk_state = TCP_CLOSE and
sk_err = ECONNRESET.

vhost_vsock_reset_orphans() in drivers/vhost/vsock.c writes a socket_state
constant into sk_state:

    sk->sk_state = SS_UNCONNECTED;
    sk->sk_err = ECONNRESET;

SS_UNCONNECTED has the same value (1) as TCP_ESTABLISHED. This function
also only runs on sockets in vsock_connected_table, which are already
established. So a vsock_connect() that gets the lock back takes the early
exit:

    if (sk->sk_state == TCP_ESTABLISHED ||
        sk->sk_state == TCP_CLOSING) {
        err = 0;
        goto out_wait;
    }

It returns 0 and never reaches the code this patch changes.

vmci_transport_handle_detach() sets sk_err only in the TCP_SYN_SENT branch.
For an established socket it only does this, and sk_err stays 0:

    sk->sk_state = TCP_CLOSE;

connect() then goes back to sleep and reaches the reset through the
timeout/signal branch, not through the sock_error() branch.

The code change covers both reset sites, so only the description is
affected. Could the commit message say which transports actually reach
this, and by which path?

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1d7d53542724f..ce958b48295b9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1704,6 +1704,19 @@ static void vsock_connect_timeout(struct work_struct *work)
>  	sock_put(sk);
>  }
>  
> +/* Avoid breaking the socket when another thread has changed its state while
> + * we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	if (sk->sk_state == TCP_SYN_SENT)
> +		sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;

[Severity: Low]
What happens if another thread calls shutdown() while a blocking connect()
is asleep?

vsock_shutdown() moves any socket that is not SS_UNCONNECTED to
SS_DISCONNECTING, including one that is still SS_CONNECTING:

    } else {
        sock->state = SS_DISCONNECTING;
        err = 0;
    }

Later the sleeping connect() times out, gets a signal, or sees sk_err.
vsock_connect_close() then moves sk_state from TCP_SYN_SENT to TCP_CLOSE,
but sock->state stays SS_DISCONNECTING. After that, every connect() takes
this path:

    case SS_DISCONNECTING:
        err = -EINVAL;
        goto out;

listen() also fails its sock->state != SS_UNCONNECTED check. So a socket
that never connected can no longer be reused. Before this patch it went
back to SS_UNCONNECTED.

The non-blocking path in vsock_connect_timeout() still resets sock->state
without checking it:

    if (sk->sk_state == TCP_SYN_SENT &&
        (sk->sk_shutdown != SHUTDOWN_MASK)) {
        sk->sk_state = TCP_CLOSE;
        sk->sk_socket->state = SS_UNCONNECTED;

So the same shutdown-during-connect race now ends differently depending on
O_NONBLOCK.

SS_DISCONNECTING does need to stay when the connection was established
before shutdown() and the reset. Otherwise SS_CONNECTED ->
SS_DISCONNECTING -> reset brings the original problem back. Could the
helper tell the never-established case apart, for example by looking at
sk_state, instead of either always keeping or always clearing
SS_DISCONNECTING?

> +}
> +

[ ... ]

> @@ -1862,8 +1875,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  			 * sk_state == TCP_SYN_SENT, which hereby we break.
>  			 * In such case VIRTIO_VSOCK_OP_RST will follow.
>  			 */
> -			sk->sk_state = TCP_CLOSE;
> -			sock->state = SS_UNCONNECTED;
> +			vsock_connect_close(sock);
>  
>  			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>  			 * transport->connect().

[Severity: Medium]
Can a connect() waiter that times out late still abort a newer connect
attempt on the same socket?

vsock_connect_close() only checks whether the socket looks like it is
connecting right now. It cannot tell whether TCP_SYN_SENT / SS_CONNECTING
belongs to this waiter's attempt or to a later connect() call.

Here is a possible sequence in vsock_connect():

Thread A
  blocking connect(), sets TCP_SYN_SENT / SS_CONNECTING, sleeps

Thread B
  connect() on the same socket, takes the SS_CONNECTING case (-EALREADY),
  sleeps with a full connect_timeout

The peer rejects the handshake:

  virtio_transport_recv_connecting()
      sk->sk_state = TCP_CLOSE;
      sk->sk_err = skerr;
      sk_error_report(sk);

Thread A
  wakes first, sock_error() clears sk_err to 0,
  vsock_connect_close() sets SS_UNCONNECTED

Thread B
  wakes, sees TCP_CLOSE with sk_err == 0, sleeps for the rest of its
  timeout

Thread C
  connect() takes the default branch, sets TCP_SYN_SENT, sends a REQUEST,
  sets SS_CONNECTING

Thread B
  timeout expires:
      vsock_connect_close(sock);        <- sees C's state, resets it
      vsock_transport_cancel_pkt(vsk);  <- cancels C's REQUEST

C is not woken and gets no error. It sleeps until its own timeout and
returns -ETIMEDOUT. A peer RESPONSE that arrives while the socket is in
TCP_CLOSE gets an RST.

This looks like the same stale-waiter problem that v2 fixes for
TCP_LISTEN. The new helper's comment says "Avoid breaking the socket when
another thread has changed its state while we were asleep". Should this
case be covered as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-vsock-connect-close-v2-1-db5388323770%40meta.com
