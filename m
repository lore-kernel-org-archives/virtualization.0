Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843680;
	b=dykmPaEd6c70lhijK4vCa6PsQkYzu5zp9xvuCLeYrlJ18Fpw/WYmjmDhvGtrHPwz+6ff
	 gSWv60BBLn2cKsoAmFuits0cKzbY+roJX1rP0IOPHZiKI+vON1vsyqrPwm2Ja/0Bx/g7A
	 DYMBLhBlZPT725COiQvx76Nl8rSeOqJeVRZFuwnXdw7PxKZwyx7dinvzx9jvC0zhCU3/p
	 VfOf1ZFub9hjD87mDEOjuGLIFGeVcsu7gGQmUBsJd7cHCR2D03sIHfvhBBMvkC2vPlvbm
	 9VUAE0MJOVHwH4+s3ARpL7J8xKEhlb2x08thVZMGLlpS4NH7rAbUnMxS7zsB7BIMcgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843680;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QKPgoiWRsxPtShXuI0V6ebeOraFMZLMbO856bZBhv+o=;
	b=0gxtQPj0sBOjgzyhvb/LhkpoVrvFOiIs3zOMefJhgAPrIYEujDh96vDBdnxNuIdY9qAQ
	 W6BmmKYvalMSStive+4pXXola58QFyM5qbna8hSPqoVktJdT6zqlvld33srY3V7ODTOJe
	 T9xtkTEFJDGO2ACNnw93yF+WdnEh2tCD4RKQd8jYd3WiW3v2V6C9NeIxxqVrCVTzzTxeP
	 2sAWRXpeLyMBl/fPUKQcEofS3tosD567AdvdG9xH6fJ3V3mpPc0Hxu4mAZYBG3hYo3PT7
	 j0v0p/eemoC8G1SXIoL7v1NW7bzVpO+5tIFKUJRQQW6rW8zwfYZ1FX3cOVFZu0deZhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2aiKN+V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08152606A331;
	Thu,  5 Nov 2026 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2aiKN+V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700CD1F00919;
	Thu,  5 Nov 2026 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843679;
	bh=QKPgoiWRsxPtShXuI0V6ebeOraFMZLMbO856bZBhv+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g2aiKN+VlnryNsGMh4BQ7274hgbJGjXfe8MLA97CcEJCdg9m4irMCNoGOY5s+z4Ew
	 uROx9+Zj3Ye1pGRr1G0whQarxGN1nPHrwga+QNBVrrZBLaGTz8Yzqq6MlsViRXXuc+
	 qqGNbRItpq1nHhnTH8r1jJVz2miq3iZ4j0JNd1YY1/MRSkpHot5RbN+jkaAgvrXj9H
	 wXdxXzzIeXGbb1XxREpMYiMndJsbQDqCbxj/t47VESe24Ppjhz9/ktLtiB6l7TlT+4
	 0DZHibPQRVamwBsEF8G634nSzJng+sU0xGYur5tkMJs0cq6FIjo1819Wd/3wAYeGJE
	 zE4+IpCRBuFAA==
Message-ID: <sashiko-outbox-198420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-4-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:54:39 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vsock: connect() corrupts state and bytes_unsent on swept establ=
ished socket
--

commit 1f8c2b3f7e5cf0bf0bba26600e236377dd6b1fe3
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: add a netlink command to assign the g2h device to a netns

This commit introduces a vsock generic netlink family with
VSOCK_CMD_DEV_NETNS_SET and VSOCK_CMD_DEV_NETNS_GET to assign the
guest-to-host vsock device to a network namespace and query its assignment.
Sockets that can no longer reach the device after an assignment are closed
with ECONNRESET.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index c9b28e34b1b3c..7140a3c708389 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -742,8 +868,269 @@ bool vsock_find_cid(unsigned int cid)

[ ... ]

> +/* Close every connected socket of @t that can no longer reach the g2h d=
evice.
> + */
> +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> +{
> +	struct vsock_sock *vsk;
> +	unsigned int i =3D 0;
> +	struct sock *sk;
> +	bool reset;
> +
> +	lockdep_assert_held(&vsock_g2h_assign_mutex);
> +	lockdep_assert_not_held(&vsock_register_mutex);
> +
> +	/* lock_sock() cannot be taken under vsock_table_lock, so pick the
> +	 * sockets one at a time, then recheck each under both locks.
> +	 */
> +	while ((sk =3D vsock_next_connected_socket(t, &i,
> +						 vsock_g2h_should_reset))) {
> +		vsk =3D vsock_sk(sk);
> +
> +		lock_sock(sk);
> +
> +		reset =3D false;
> +		spin_lock_bh(&vsock_table_lock);
> +		/* It may have been closed since we dropped the table lock. */
> +		if (__vsock_in_connected_table(vsk) && vsk->transport =3D=3D t &&
> +		    vsock_g2h_should_reset(vsk)) {
> +			__vsock_remove_connected(vsk);
> +			reset =3D true;
> +		}
> +		spin_unlock_bh(&vsock_table_lock);
> +
> +		if (reset) {
> +			sock_set_flag(sk, SOCK_DONE);
> +			WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
> +			sk->sk_state =3D TCP_CLOSE;
> +			sk->sk_err =3D ECONNRESET;
> +			sk_error_report(sk);
> +		}
> +
> +		release_sock(sk);
> +		sock_put(sk);
> +	}
> +}

[ ... ]

> @@ -1705,6 +2093,16 @@ static void vsock_connect_timeout(struct work_stru=
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
> +
>  static int vsock_connect(struct socket *sock, struct sockaddr_unsized *a=
ddr,
>  			 int addr_len, int flags)
>  {
> @@ -1863,8 +2261,7 @@ static int vsock_connect(struct socket *sock, struc=
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
> @@ -1878,10 +2275,8 @@ static int vsock_connect(struct socket *sock, stru=
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
What happens in vsock_connect() when a socket reaches TCP_ESTABLISHED while
sleeping in schedule_timeout(), and is then swept by
vsock_g2h_reset_unreachable() before vsock_connect() reacquires
lock_sock(sk)?

While vsock_connect() has released lock_sock(sk) in schedule_timeout(),
virtio_transport_recv_connecting() can receive VIRTIO_VSOCK_OP_RESPONSE,
transition sk->sk_state to TCP_ESTABLISHED, set sock->state to SS_CONNECTED,
and insert vsk into vsock_connected_table. Once established, a concurrent
vsock_connectible_sendmsg() on another thread can acquire credits via
virtio_transport_get_credit() (incrementing vvs->bytes_unsent) and enqueue
VIRTIO_VSOCK_OP_RW skbs onto send_pkt_queue.

If VSOCK_CMD_DEV_NETNS_SET then runs vsock_g2h_reset_unreachable() before
vsock_connect() reacquires lock_sock(sk), it sets sk->sk_state to TCP_CLOSE
and sk->sk_err to ECONNRESET while leaving sock->state as SS_CONNECTED. When
vsock_connect() wakes up, the once-established check:

	if (sk->sk_state =3D=3D TCP_ESTABLISHED ||
	    sk->sk_state =3D=3D TCP_CLOSING) {
		err =3D 0;
		goto out_wait;
	}

does not match because sk->sk_state is TCP_CLOSE rather than TCP_CLOSING (u=
nlike
virtio_transport_do_close()) and sock->state =3D=3D SS_CONNECTED is not che=
cked.

If signal_pending(current) || timeout =3D=3D 0 holds, vsock_connect() proce=
eds to
call vsock_transport_cancel_pkt(vsk) -> virtio_transport_purge_skbs(), which
purges the post-connection VIRTIO_VSOCK_OP_RW skbs without calling
virtio_transport_consume_skb_sent() to decrement vvs->bytes_unsent. Doesn't
this leak vvs->bytes_unsent and cause vsock_linger() on close() to block un=
til
sk_lingertime expires, similar to the issue fixed by commit 002541ef650b
("vsock: Do not allow signal/timeout on established sockets")?

And if no signal or timeout is pending, vsock_connect() exits the wait loop,
consumes sk->sk_err via sock_error(sk), calls vsock_connect_close(sock), and
returns -ECONNRESET while leaving sock->state as SS_CONNECTED with sk->sk_e=
rr
cleared to 0.

Should vsock_g2h_reset_unreachable() set sk->sk_state =3D TCP_CLOSING like
virtio_transport_do_close(), or should vsock_connect() also check for
sock->state =3D=3D SS_CONNECTED after schedule_timeout()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D4
