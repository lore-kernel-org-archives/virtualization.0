Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052067;
	b=qroMN0Nxgsmvrink8ltFXhRZmbHZcM1rHPk9X0dOnUCz2IusojAhXidtPbE1I2877itJ
	 z7Ec8gXxNHAC0P9/BUqfGvKvXeGh2ewiPzs5B6knmAz6NIyfGOFeKqtp8uxI4/yCxlL3J
	 7s+qCZCJsoE2UZp5ky2a7VZUqVYCrWRhB0Om7noKzuZkpfQt6aOOY/kzVKnGkK2LE2fuN
	 eRQIffxzdPJX2+rMh1cHNEZ/9OzQ+M1JZltksQf6EOMstFY5UlpEpVzQiIFm3Tc9meh3v
	 9ylkoPg9bttFBzjOpmo91wDP7j4ArHdJHrdVXnKXQJMxqjUMKIy1F6Ei+9o23i3WLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052067;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Y1nPfNmjmqdVKNfkuaUVVAzb9SxNmHaWMBAbyiMlbE=;
	b=J+8RPvcq6yG0cxcCQtmAGB71lMc0wB7lBbUJrjTcU8d3hsBoIiRhtuPcHvsPpuqgBo5F
	 o0MTqo53vZP/6iBIG9rtEs5jcVr0a8r6pO0lH83prxsU+6EUrIucW3PsiTuQWpUHO8R6e
	 kiZYuiUxeAnMNjw8bLQE3g5IEVote5p+WBTse45H3pOcih7eH34pIJ/fhj60sIs+vyTWO
	 J7b9xByRJDXYCW12XhFzPihJGvcDjx0kjP70Qj+yzuhHm9Vni+0P+/+lKCU6N85qu2cxR
	 TGxuxi70gpByk8HASMchD7ZfEjqWLgCppktlUqn2jHnrVNzLuWjS1a3XYFpLnZLLENg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OV2ZAk1h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14038606A31C
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OV2ZAk1h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DD11F000C4;
	Thu, 19 Nov 2026 01:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052066;
	bh=2Y1nPfNmjmqdVKNfkuaUVVAzb9SxNmHaWMBAbyiMlbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OV2ZAk1hKQAUeFSeYj20ik6X3vV32dC2CuQiklBcPEf+FWfOuZVEtFlulaH0/1Bkh
	 gqsVJyYnC87F2Aymkyk589qI9ERsSLVopWXunjyQWD3nN9F0LTGPLOqC33KBW+qvz1
	 NwomZ3ciEcuib07UzilImE5XXoQZhygGB1MHAIGvUs9QgduO8EFJh5Kc+8oJJlv8GS
	 oe6xTBOIxz17AzPfkUVVEs+wG90uAfn+xxPh3aOqc7fkm0BwltW/iq0p73kAKjZZa2
	 Mm/vFO/hvn2ELM5Q5Sn5k+iLaxHvyE70exvtwdy8pQL5jkEegtK6MxZTIrFqAO2+kw
	 c40xVza0yQdUQ==
Message-ID: <sashiko-outbox-222284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:34:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] vsock: incomplete handling of post-handshake reset in
  vsock_connect()
- [Medium] vsock: concurrent vsock_connect() waiter stays in loop and
  clobbers retry
--

commit 82a88284866b93cccb5d48f9bd76a86ebb091f06
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: only undo SS_CONNECTING when connect() fails

This commit adds vsock_connect_close() so vsock_connect() only resets
sk->sk_state to TCP_CLOSE when it is still TCP_SYN_SENT and sock->state to
SS_UNCONNECTED when it is still SS_CONNECTING.

Link: https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v=
1-1-50298b9ccfbf@rbox.co/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1d7d53542724f..ce958b48295b9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1704,6 +1704,19 @@ static void vsock_connect_timeout(struct work_stru=
ct *work)
>  	sock_put(sk);
>  }
> =20
> +/* Avoid breaking the socket when another thread has changed its state w=
hile
> + * we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	struct sock *sk =3D sock->sk;
> +
> +	if (sk->sk_state =3D=3D TCP_SYN_SENT)
> +		sk->sk_state =3D TCP_CLOSE;
> +	if (sock->state =3D=3D SS_CONNECTING)
> +		sock->state =3D SS_UNCONNECTED;
> +}

[Severity: Medium]
Can a second thread blocked in vsock_connect() stay in the wait loop after
the first attempt fails, and later clobber a retry connect() on the same
socket?

CPU0                              CPU1
vsock_connect()
  sk->sk_state =3D TCP_SYN_SENT
  sock->state =3D SS_CONNECTING
  release_sock(sk)
                                  vsock_connect()
                                    /* sees SS_CONNECTING */
                                    release_sock(sk)
  /* timeout or peer RST */
  lock_sock(sk)
  sock_error(sk) /* clears sk_err */
  vsock_connect_close(sock)
    sk->sk_state =3D TCP_CLOSE
    sock->state =3D SS_UNCONNECTED
  release_sock(sk)
                                  lock_sock(sk)
                                  /* sk_state =3D=3D TCP_CLOSE && sk_err =
=3D=3D 0,
                                   * so while loop continues
                                   */
                                  release_sock(sk)
  vsock_connect() /* retry */
    sk->sk_state =3D TCP_SYN_SENT
    sock->state =3D SS_CONNECTING
    release_sock(sk)
                                  /* timeout or signal */
                                  lock_sock(sk)
                                  vsock_connect_close(sock)
                                    /* resets retry's TCP_SYN_SENT and
                                     * SS_CONNECTING
                                     */
                                  vsock_transport_cancel_pkt(vsk)

Because the wait loop only exits on TCP_ESTABLISHED, TCP_CLOSING or
sk->sk_err !=3D 0, CPU1 does not see that the socket left TCP_SYN_SENT once
CPU0 clears sk->sk_err (or times out with sk->sk_err =3D=3D 0).  When CPU1 =
later
times out or gets a signal, vsock_connect_close() sees TCP_SYN_SENT and
SS_CONNECTING from the new connect() attempt, resets them to TCP_CLOSE and
SS_UNCONNECTED while CPU0 sleeps, and cancels the new attempt's packets.
Even if userspace called listen() instead of retrying connect(), CPU1 still
calls vsock_transport_cancel_pkt() on timeout.

Also, if another thread consumes sk->sk_err via getsockopt(SO_ERROR) or
recvmsg(MSG_ERRQUEUE) before vsock_connect() calls sock_error(sk), err is 0,
so vsock_connect() skips vsock_connect_close() and returns 0 while leaving
sock->state as SS_CONNECTING with sk->sk_state =3D=3D TCP_CLOSE.

> @@ -1862,8 +1875,7 @@ static int vsock_connect(struct socket *sock, struc=
t sockaddr_unsized *addr,
>  			 * sk_state =3D=3D TCP_SYN_SENT, which hereby we break.
>  			 * In such case VIRTIO_VSOCK_OP_RST will follow.
>  			 */
> -			sk->sk_state =3D TCP_CLOSE;
> -			sock->state =3D SS_UNCONNECTED;
> +			vsock_connect_close(sock);
> =20
>  			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>  			 * transport->connect().
> @@ -1877,10 +1889,8 @@ static int vsock_connect(struct socket *sock, stru=
ct sockaddr_unsized *addr,
>  	}
> =20
>  	err =3D sock_error(sk);
> -	if (err) {
> -		sk->sk_state =3D TCP_CLOSE;
> -		sock->state =3D SS_UNCONNECTED;
> -	}
> +	if (err)
> +		vsock_connect_close(sock);
> =20
>  out_wait:
>  	finish_wait(sk_sleep(sk), &wait);

[Severity: Medium]
When the transport completes the handshake (setting sock->state to
SS_CONNECTED and sk->sk_state to TCP_ESTABLISHED) and then resets the
socket to TCP_CLOSE while vsock_connect() is sleeping, does vsock_connect()
still mishandle the post-handshake reset in the wait loop and error path?

First, in vmci_transport_handle_detach(), a detach after the socket has
already reached TCP_ESTABLISHED sets sk->sk_state =3D TCP_CLOSE without
setting sk->sk_err:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
    ...
			if (sk->sk_state =3D=3D TCP_SYN_SENT) {
				sk->sk_state =3D TCP_CLOSE;
				sk->sk_err =3D ECONNRESET;
				sk_error_report(sk);
				return;
			}
			sk->sk_state =3D TCP_CLOSE;
    ...
}

When vsock_connect() wakes up, sk->sk_state is neither TCP_ESTABLISHED nor
TCP_CLOSING and sk->sk_err is 0, so it re-enters schedule_timeout() and
blocks until connect_timeout expires.

Second, if a timeout or signal coincides with a post-handshake reset to
TCP_CLOSE, vsock_connect() enters the signal/timeout branch and calls
vsock_transport_cancel_pkt(vsk) on a socket whose sock->state is already
SS_CONNECTED.  If another thread called sendmsg() once sock->state became
SS_CONNECTED, virtio_transport_cancel_pkt() purges queued
VIRTIO_VSOCK_OP_RW packets without decrementing vvs->bytes_unsent, leaving
unsent-byte accounting for SIOCOUTQ and vsock_linger() out of sync.

Third, when virtio_vsock_reset_sock() or vhost_vsock_reset_orphans() sets
sk->sk_err =3D ECONNRESET after the handshake completed, vsock_connect()
exits the loop, consumes sk->sk_err via sock_error(sk), and returns
-ECONNRESET from connect() while leaving sock->state as SS_CONNECTED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-conn=
ect-close-v2-1-db5388323770@meta.com?part=3D1
