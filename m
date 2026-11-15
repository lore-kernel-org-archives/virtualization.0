Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712871;
	b=OJjX5QNi11XksWhMvx7Q6rnBzQwOEbTxSkKGtY/yElqkUfGPx0qvxohv0gMV5can871S
	 pnpBqsoXE/oDG0EachtwLR7ohY3rT2cRsghXK16gwN6oU9V5b9OcVwCg1m06fVJ9BQOo7
	 4+hW6OnH11o4wZPjb42ueTf+kjQ5O3+VQVH3+rBU+mprA2d0HISbC1g9QQTwyn/vozcx5
	 ZPhCq+PhLgY3nAN7LbWmYXcm1J2aS+OzBSkwepLqBvWTVWGw59g+yD7Q45YtuIcKAozIG
	 kMPv3SLUYcqt60dqI5FDNtjZOKtlFAJtSZ6EdBMl/6uv5FiJQL1Lmb87xufm4sq2QuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712871;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yYI5gepbeux3oiB+Nf4asNNGZW3iCTJ9RdpyTtjwEmo=;
	b=4u8f4Vylq+zIi51K0vm4dnczI3TKtHEhYOvfo8tKf2BOk0hXbcFx5GGGHu1tJxzzsKNH
	 fINoA7vrQa4hIsv7WoUBLGarky7tgLal3vE16PZOGRqiHJ2RUqQ8mo/fHBC5aN2gVkSow
	 DrSTtNqZ9OdQaxtYO1DeBsMXpsOK8YFmVs6cCjiID3rxYOFgwZR4V6Zorh8gVjPnKq9/y
	 6VD3OKtX4oR9y+1Rjjih3xpR3PtfYTdfxO1pRrkneVA17nGCt0jQ/zqtJykYrhKPNWZ0E
	 cGt9Qyb/pQJ4K2yAa+v4LvfgqfPaELbPd/+LSR8fYk77+IJ8hNinqQnl8ugfH8GGlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX4bTuim;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4462C606A329;
	Sun, 15 Nov 2026 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX4bTuim
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA991F000C6;
	Sun, 15 Nov 2026 03:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712870;
	bh=yYI5gepbeux3oiB+Nf4asNNGZW3iCTJ9RdpyTtjwEmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BX4bTuimbBpQZjFGhkl26ojtad4OyBqDZDpaUabAk9IDaspa0YB66eDSpvJWXIuGq
	 5xBiV2jFvICCG4tCBM79/dawuBnzzfybz80wVYtzew7F/LB6SMAgLhgTa1O6UbuKqR
	 yT+OlPEE6gLmRue0VgNUKZRFnfvYRok5YgoqbKq73TRuQdiCM9rwsmkm6lpTuHu8ei
	 H27yidDpulv1vX93E8hovUUAs/IK01RUXBR3SikintGLWDfZAqalbl43k/kolHQCwF
	 iLf428PBRtaX8T6FVLi+z5vu2QRYuRWb1hX3XP4rxgrlquJXOxFe9mxnn+DAgdG0eb
	 EMhPtf0vSm1GQ==
Message-ID: <sashiko-outbox-215194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 1/8] vsock: only undo SS_CONNECTING when
 connect() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-1-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:10 +0000
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
- [Medium] vsock: vsock_connect() fails on SS_CONNECTED sockets reset to
  TCP_CLOSE
- [Medium] vsock: vsock_connect_close() sets TCP_CLOSE when state !=3D
  SS_CONNECTING
--

commit 02952dc6bba9fe20e7c14b7fd24b6a5865ca1aab
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: only undo SS_CONNECTING when connect() fails

This commit adds vsock_connect_close() so that a failed vsock_connect()
only resets sock->state to SS_UNCONNECTED if it is still SS_CONNECTING,
leaving sockets that became SS_CONNECTED while sleeping in that state.

Link: https://lore.kernel.org/netdev/179447093204.2199510.88956774219946129=
94@kernel.org/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 483af15a5109e..dc81cd47f099d 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1703,6 +1703,16 @@ static void vsock_connect_timeout(struct work_stru=
ct *work)
>  	sock_put(sk);
>  }
> =20
> +/* Avoid breaking the socket when another thread has changed its sock->s=
tate
> + * while we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	sock->sk->sk_state =3D TCP_CLOSE;
> +	if (sock->state =3D=3D SS_CONNECTING)
> +		sock->state =3D SS_UNCONNECTED;
> +}

[Severity: Medium]
Can vsock_connect_close() overwrite sk->sk_state with TCP_CLOSE after
another thread has moved the socket out of SS_CONNECTING?

Because vsock_connect() allows a second blocking caller into the wait loop
when sock->state is SS_CONNECTING, two threads can sleep in
schedule_timeout() on the same socket:

CPU0                                  CPU1
vsock_connect()
  sock->state =3D SS_CONNECTING
  schedule_timeout()
                                      vsock_connect()
                                        case SS_CONNECTING:
                                        schedule_timeout()
  <connect fails>
  err =3D sock_error(sk)
  vsock_connect_close(sock)
    sk->sk_state =3D TCP_CLOSE
    sock->state =3D SS_UNCONNECTED
vsock_listen()
  sk->sk_state =3D TCP_LISTEN
                                        <timeout or signal>
                                        vsock_connect_close(sock)
                                          sk->sk_state =3D TCP_CLOSE

When CPU0 consumes sk->sk_err via sock_error(sk), CPU1 stays in the wait
loop because sk->sk_state is TCP_CLOSE and sk->sk_err is 0.  If CPU0 then
calls vsock_listen() (which leaves sock->state as SS_UNCONNECTED and sets
sk->sk_state to TCP_LISTEN), CPU1 waking on a timeout or signal calls
vsock_connect_close() and clobbers TCP_LISTEN with TCP_CLOSE, allowing a
subsequent vsock_connect() to bypass the sk->sk_state =3D=3D TCP_LISTEN che=
ck.

> @@ -1861,8 +1871,7 @@ static int vsock_connect(struct socket *sock, struc=
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
> @@ -1876,10 +1885,8 @@ static int vsock_connect(struct socket *sock, stru=
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

[Severity: Medium]
What happens in vsock_connect() if the handshake completes (setting
sock->state to SS_CONNECTED) and the connection is then reset to TCP_CLOSE
while schedule_timeout() is sleeping?

Both virtio_vsock_reset_sock() and vmci_transport_handle_detach() move an
established socket directly to TCP_CLOSE rather than TCP_CLOSING:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
    ...
		} else {
			if (sk->sk_state =3D=3D TCP_SYN_SENT) {
				sk->sk_state =3D TCP_CLOSE;
				sk->sk_err =3D ECONNRESET;
				sk_error_report(sk);
				return;
			}
			sk->sk_state =3D TCP_CLOSE;
    ...
}

When vsock_connect() reacquires lock_sock(sk), the check for
sk->sk_state =3D=3D TCP_ESTABLISHED || sk->sk_state =3D=3D TCP_CLOSING miss=
es
this socket because sk->sk_state is already TCP_CLOSE.

If vmci_transport_handle_detach() ran on an established socket (leaving
sk->sk_err =3D=3D 0), or if another thread consumed sk->sk_err via
getsockopt(SO_ERROR) or sendmsg(), the wait loop condition
(sk->sk_state !=3D TCP_ESTABLISHED && sk->sk_state !=3D TCP_CLOSING &&
sk->sk_err =3D=3D 0) remains true and vsock_connect() sleeps until
connect_timeout expires or a signal arrives.  It then enters the
timeout/signal path, leaves sock->state as SS_CONNECTED via
vsock_connect_close(), and calls vsock_transport_cancel_pkt(vsk).  If a
concurrent sendmsg() queued VIRTIO_VSOCK_OP_RW skbs while the socket was
connected, purging them via virtio_transport_purge_skbs() without calling
virtio_transport_consume_skb_sent() leaks vvs->bytes_unsent, breaking
SIOCOUTQ and causing vsock_linger() to wait on close.  Returning
-ERESTARTSYS on a signal while leaving sock->state as SS_CONNECTED also
causes a restarted connect() syscall to fail with -EISCONN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D1
