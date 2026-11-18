Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967095;
	b=ckzjH6/alci5C8e+knsqSlVtitsBl3+E24KITLrx0A2lnB9N7lG5pYSlpNtMDQHGrWjI
	 EEWNUVKmEnnPTeKd7U7KQP6mFUBm/i91JD8i7Mq17xJLp6/VyPh/yflSwfEgIkY2+ld6Y
	 qZF2xC4h4aL23oBMch1C/vRQd1oyBFLyZkAkM7KO0Fet9UY+LRyNfdJeCyuqczM2ghkDq
	 NYBAor3WSDR6tFTY3YyGryHN4BrSpOY581dZKQQZIC0soPI6/A/uBbF/BFpRLfrEhrDcA
	 6mNeu/XWBDu2KXIA2yy0wDDe8Gee+Hw/UC5jrCgI0Yh63rb4+Oy+7BaXaSjVNgnCGgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ex93YETbIMxoA78RvTBTfynISw4jSNCHkjF7RlM/B0g=;
	b=1HyjG504j6plSpLDYdYGMgUrMsogJtAwq/LJX74uePVS50o/gPsijBhUMx931l81O6k3
	 j57cxd0ZKbGRmgIKXPGO0+KjbS9cySwK2C+LGUZNRXpRBpJSNKMgbr/YcGyje3tCvEJTk
	 GI6RuTH9rVzjrs8uFaw598jwhNOwRc6J9ZvCJRXPapacBcFpAmF1R42tSmClgtldvTQpR
	 nMzSalhtiD7qcwz6L4SXgNjlncxSeFfj0/pD3C0h614epdprFf6OzWti9/8kcb8p57Afm
	 mcV7BBWrMbUonoil3mytuR0SzkpkHa+yCRoZcStPUtOezFNuxHTVmt+PGpwIS2oWxfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3Hmpel2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3926606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3Hmpel2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC1B1F000C4;
	Wed, 18 Nov 2026 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967094;
	bh=ex93YETbIMxoA78RvTBTfynISw4jSNCHkjF7RlM/B0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3Hmpel2Yv2sstHhtY8GsXQr4zGNn9FWqkHzuAtO/pO+95drcZdwKk02iIPU5y9yR
	 sPeZzAWZ4oAFsDxidGcWtTXT05g1lVZoN8VJnWvnPL6XmtANNQ4yK9bEi6PgdqbA16
	 mRAl0lxjyDvPSUCst8PzIMXqiZXc0r2lm0x9wwTgA0W8svX2DgOn5892vOfGUhlrKb
	 OzTOL3Q5D54IfwrR/QDX5D5ppk/y7HyOniSZvvYxhV3TCl1icHFx5xfK4kTf/VGJbn
	 X8j6D58X4sy59Qo0bKa1ZhKyzVJPbEhoUvN28LhTJEmWPqpyJJ1wc89+2MKG71u2Zw
	 E+z2aqCdx8Vkw==
Message-ID: <sashiko-outbox-219917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock: only undo SS_CONNECTING when connect() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com>
References: <20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 01:58:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vsock: incomplete handling of post-handshake reset in
  vsock_connect()
--

commit bfeaeec883913ff39b46b5892948bd62e612d57c
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: only undo SS_CONNECTING when connect() fails

This commit introduces vsock_connect_close() so that vsock_connect() only
resets sock->state to SS_UNCONNECTED if the socket is still in
SS_CONNECTING.

Link: https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v=
1-1-50298b9ccfbf@rbox.co/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1d7d53542724f..6395c6a7b0b1e 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1704,6 +1704,16 @@ static void vsock_connect_timeout(struct work_stru=
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
> @@ -1862,8 +1872,7 @@ static int vsock_connect(struct socket *sock, struc=
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
> @@ -1877,10 +1886,8 @@ static int vsock_connect(struct socket *sock, stru=
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
Can vsock_connect() hang until connect_timeout or corrupt vvs->bytes_unsent
when a socket completes its handshake and is then reset to TCP_CLOSE while
vsock_connect() is sleeping?

CPU0                                CPU1
vsock_connect()
  release_sock(sk)
  schedule_timeout(timeout)
                                    /* handshake completes */
                                    sock->state =3D SS_CONNECTED
                                    sk->sk_state =3D TCP_ESTABLISHED

                                    vmci_transport_handle_detach()
                                      sk->sk_state =3D TCP_CLOSE
  lock_sock(sk)
  if (sk->sk_state =3D=3D TCP_ESTABLISHED ||
      sk->sk_state =3D=3D TCP_CLOSING)  <-- false
  if (signal_pending(current) ||
      timeout =3D=3D 0)                 <-- false
  /* loops back to schedule_timeout() */

When vmci_transport_handle_detach() runs after the socket has already
entered TCP_ESTABLISHED, it sets sk->sk_state =3D TCP_CLOSE without setting
sk->sk_err:

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
    ...
		if (vsk->local_addr.svm_cid =3D=3D VMADDR_CID_HOST ||
		    vsock_stream_has_data(vsk) <=3D 0) {
			if (sk->sk_state =3D=3D TCP_SYN_SENT) {
				...
				sk->sk_state =3D TCP_CLOSE;
				sk->sk_err =3D ECONNRESET;
				sk_error_report(sk);
				return;
			}
			sk->sk_state =3D TCP_CLOSE;
		}
    ...
}

Because the wait loop only checks for TCP_ESTABLISHED, TCP_CLOSING, and
sk->sk_err, vsock_connect() stays in the loop and sleeps on the closed
socket until connect_timeout expires.

Also, if a signal or timeout coincides with a post-handshake reset to
TCP_CLOSE (via vmci_transport_handle_detach() or
virtio_vsock_reset_sock()), vsock_connect() enters the signal/timeout path
and calls vsock_transport_cancel_pkt(vsk) on a socket in SS_CONNECTED.  If
another thread sent data after the handshake completed,
virtio_transport_purge_skbs() frees queued VIRTIO_VSOCK_OP_RW packets
without decrementing vvs->bytes_unsent, breaking SIOCOUTQ and
vsock_linger() accounting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-vsock-conn=
ect-close-v1-1-43fb125973dd@meta.com?part=3D1
