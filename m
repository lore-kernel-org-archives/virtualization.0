Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631782;
	b=ZJvFQ3btDASsECDz2ApFF4D10M+zbwkExUNzwVRtwakUHECVESQEymN01T0SpyRoXDj0
	 y6y6JAy3iptdu/SYiWG+dHIbSdImmdIvRWsdHxdgjeVDSTQf7FTHyMegGGfl77pl7AEuA
	 BHzolcDA+uWRwXLQqy+j64vTT6tObGVswrqKa4D22jEk0DwV+WshHvqHqMkBRgzTqudbn
	 ZkV+W6xBpAAw6+x6ttCkaEI6hmjwcpdAaATawf0R3AwturaIUuuc1j2WIG5tHaFHgVHxu
	 xElwixuIRjcKB39bIoEeKHfEKMCjSnX/CLeKFdvfOQTK0Lk1I8Wqabe6EQKpflPgTkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qZOV5yeJN52oqOP5wofreZ7d/2qLoxE1uVSEpJjZi1U=;
	b=WD4CAzNDzd6th+d3hM6PZGCfr29p73jUP0WSP3ebqIEotAaPo2S3rbMR93K+RFqJgOIp
	 mgTF6PzXXL5/4rL25HV5uYBnGIZnHvnCgfuFmPo/n4N1Bza/306h5zaES1h4GG8hAqXj+
	 jcizeR7hDsSFLJP7blvtno2sCrEeDSfqcA4mOpE0vnGItYfVoaHo7kGmRxlvzGvguas3A
	 1p6mXA6bpwjIIJOE8A0/HOZk33nPHsuSobfnyaHcU/5dJzf/norVCsFj/PxIEMT/h8u5C
	 h4Gi6P7wUK0CSQxxl7pJZGmUkQs3/JvrSzDSVp005Mzj18HNxa/uZ0/+NtxNV99Cf4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhTEelLF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737D606A31A;
	Thu, 22 Oct 2026 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhTEelLF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DEA1F000C2;
	Thu, 22 Oct 2026 01:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631781;
	bh=qZOV5yeJN52oqOP5wofreZ7d/2qLoxE1uVSEpJjZi1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhTEelLFx5ItluwlyJZnAU83z9gkNN9dqy2GtkqFUb+Oa4e1oLtBOp70frfdNDAK8
	 nOkIEGvsItn0PzAoYy8j+KCqNCGQGgmkcReEBYoq74/lyNf3q73At32fFefr53kw+C
	 HqozRA94brr01EVnF7uhlt08f1QFCtNkV3VE7K/ee0I7NP8yvYTX4cddc5ntcZxOX3
	 iuhN4XfTF47clnEl4PFzkHpTmfW2INYO3rplbg2VVb3dbgvrqGlJNM3wiYJLl0s1fA
	 dZkqfqorcsw48cQwYOlU/4Y+WSI6yvkMawsh8c+pAuaMqRfnkHcAQhAZUFbJW+sgd9
	 tgkBhBk5gMasQ==
Message-ID: <sashiko-outbox-180841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:16:21 +0000
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
- [Medium] vsock: incomplete socket state reset in vsock_g2h_reset_unreacha=
ble()
--

commit fe6dcf2ff7ad3f974f6de58396eb4f397d8574af
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: add a netlink command to assign the g2h device to a netns

This commit introduces a vsock generic netlink family with
VSOCK_CMD_DEV_NETNS_SET and VSOCK_CMD_DEV_NETNS_GET to assign the guest-to-=
host
vsock device to a network namespace and query its current assignment. When =
the
device moves to a namespace that existing connected sockets cannot reach, t=
hose
sockets are swept and closed with ECONNRESET.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index c9b28e34b1b3c..e16e72471b4a3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -742,8 +823,303 @@ bool vsock_find_cid(unsigned int cid)

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
> +	while ((vsk =3D vsock_g2h_next_unreachable(t, &i))) {
> +		sk =3D sk_vsock(vsk);
> +
> +		lock_sock(sk);
> +
> +		reset =3D false;
> +		spin_lock_bh(&vsock_table_lock);
> +		if (__vsock_in_connected_table(vsk) &&
> +		    vsock_g2h_should_reset(vsk, t)) {
> +			__vsock_remove_connected(vsk);
> +			reset =3D true;
> +		}
> +		spin_unlock_bh(&vsock_table_lock);
> +
> +		if (reset) {
> +			sk->sk_state =3D TCP_CLOSE;
> +			sk->sk_err =3D ECONNRESET;
> +			sk_error_report(sk);
> +		}
> +
> +		release_sock(sk);
> +		sock_put(sk);
> +	}
> +}

[Severity: Medium]
When vsock_g2h_reset_unreachable() resets an established socket, it sets
sk->sk_state =3D TCP_CLOSE and sk->sk_err =3D ECONNRESET, but leaves SOCK_D=
ONE
unset, vsk->peer_shutdown unchanged, and sk->sk_socket->state as
SS_CONNECTED.

On a subsequent read, __vsock_connectible_recvmsg() checks sk->sk_state
before reaching the stream or seqpacket receive paths that check
sock_error(sk):

net/vmw_vsock/af_vsock.c:__vsock_connectible_recvmsg()
	if (!transport || sk->sk_state !=3D TCP_ESTABLISHED) {
		if (sock_flag(sk, SOCK_DONE))
			err =3D 0;
		else
			err =3D -ENOTCONN;

		goto out;
	}

And on a subsequent write, vsock_connectible_sendmsg() skips the -EPIPE
branch because vsk->peer_shutdown does not have RCV_SHUTDOWN set, and
instead takes the -ENOTCONN branch:

net/vmw_vsock/af_vsock.c:vsock_connectible_sendmsg()
	if (sk->sk_shutdown & SEND_SHUTDOWN ||
	    vsk->peer_shutdown & RCV_SHUTDOWN) {
		err =3D -EPIPE;
		goto out;
	}

	if (!transport || sk->sk_state !=3D TCP_ESTABLISHED ||
	    !vsock_addr_bound(&vsk->local_addr)) {
		err =3D -ENOTCONN;
		goto out;
	}
...
out:
	if (sk->sk_type =3D=3D SOCK_STREAM)
		err =3D sk_stream_error(sk, msg->msg_flags, err);

Because sk_stream_error() only replaces err with sock_error(sk) when
err =3D=3D -EPIPE (and is not called for SOCK_SEQPACKET), both recvmsg() and
sendmsg() return -ENOTCONN instead of -ECONNRESET without clearing
sk->sk_err, leaving vsock_poll() permanently reporting EPOLLERR | EPOLLOUT.

In addition, because sk->sk_socket->state remains SS_CONNECTED, a retried
vsock_connect() fails with -EISCONN:

net/vmw_vsock/af_vsock.c:vsock_connect()
	switch (sock->state) {
	case SS_CONNECTED:
		err =3D -EISCONN;
		goto out;

While vsock_shutdown() sees sock->state !=3D SS_UNCONNECTED and still calls
vsock_send_shutdown() on the disallowed transport:

net/vmw_vsock/af_vsock.c:vsock_shutdown()
	if (sock->state =3D=3D SS_UNCONNECTED) {
		err =3D -ENOTCONN;
		if (sock_type_connectible(sk->sk_type))
			goto out;
	} else {
		sock->state =3D SS_DISCONNECTING;
		err =3D 0;
	}

	/* Receive and send shutdowns are treated alike. */
	mode =3D mode & (RCV_SHUTDOWN | SEND_SHUTDOWN);
	if (mode) {
		sk->sk_shutdown |=3D mode;
		sk->sk_state_change(sk);

		if (sock_type_connectible(sk->sk_type)) {
			sock_reset_flag(sk, SOCK_DONE);
			vsock_send_shutdown(sk, mode);
		}
	}

Should vsock_g2h_reset_unreachable() also update vsk->peer_shutdown,
SOCK_DONE, and sk->sk_socket->state (when sk->sk_socket is present), or
ensure recvmsg() and sendmsg() consume sk->sk_err so callers observe
ECONNRESET and can reconnect as intended?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D4
