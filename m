Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003049B5AD
	for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077566; cv=none; b=uP2JJVRTPfbCiZJZ836BsV3riyYMMzEyQqrmNIG0/Bx2XIR/wF0SwVnBcsmvey7rAGeuxtNTw23bLmzfoqyPIP4ahPISSctjJ88X37HwenCRBhuSnK6od36KbqzhQwoDvPPQ5yP0lwvPQY7l9OihETU+hTWnKPl9sPWT7qwH2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077566; c=relaxed/simple;
	bh=T+ks5uEbJfUwt43YrxT8qrUxjlGJufrWOecOM9RcA3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJT5gNsF3EPP+UizBOpPXDS7oqjHGa0FhTvD8Ff7HUAWg3t09iatLjtHR+AB6iwy3zs1beWhtGhKQ+qvg6YjNYYzx9WePiqDP20+7o/BZCnqSvWkPFJAooBMs0AgUhh2+6x0cqPor5CGfJ9fH2/+HGzAHYvNC0/5PRKSxBlYod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTcKSTt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTcKSTt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512651F008A0;
	Thu, 10 Sep 2026 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077565;
	bh=tni4mXK53PpJ1PZK8ofM378Nf4+HXlvG2lf5SOyZV3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FTcKSTt1gHvKYd+R4p5VH/e8XBc7fdcHeDLLluwkDScY+eosYRiWWl4g3wKMVUZyb
	 kXdjKu83KyyWVj0Q/96Wko9X8XmUJraRyHoUf2+7R/7fa3AVLWZIQXBOUpvVRx0q9o
	 cCUkv0xkf8wjH8qnOyqg5IeIP1QaSAVz5Ru91O9G7DpaVkr1b6jmjMFz+vd+mZZNfO
	 8+nGeyCIaXQUVXyWRWr+gUrXdBtm5j0+98ZGVhHTw6JQusQLi8+JS3dBWW6j2K1VrF
	 g/J8x+r9b7MLuTsSh7xeebqROE0WyY1EIN6KW2TVtAIeihSQC3HAUTaKfFoDcNVQfO
	 bCCxO4+ErJmHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock: Do not reset a TCP_CLOSING socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co>
References: <20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:59:24 +0000
Message-Id: <20260910215925.512651F008A0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch intentionally leaves a reproducible kernel panic (`list_=
add double add`) unfixed when a socket's connect() races with driver unbind=
 or VMCI detach.
--

commit 1aaee088d1b836a02d4d13c4a6eec8193f64408f
Author: Michal Luczaj <mhal@rbox.co>

vsock: Do not reset a TCP_CLOSING socket

Ensure connect() resets the socket only if it has never been established.
Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING transition
(on VIRTIO_VSOCK_OP_RST), which could race with the connect loop.

Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58afb..eec5dd6daebb1 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> @@ -1875,7 +1872,8 @@ static int vsock_connect(struct socket *sock, struc=
t sockaddr_unsized *addr,
>  	}
> =20
>  	err =3D sock_error(sk);
> -	if (err) {
> +	if (err &&
> +	    sk->sk_state !=3D TCP_ESTABLISHED && sk->sk_state !=3D TCP_CLOSING)=
 {
>  		sk->sk_state =3D TCP_CLOSE;
>  		sock->state =3D SS_UNCONNECTED;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this error path still
leave a race condition that triggers a kernel panic?

If vsock_connect() races with an asynchronous transport reset like
virtio_vsock_reset_sock() or vmci_transport_handle_detach(), the transport =
sets
sk_state =3D TCP_CLOSE and sk_err =3D ECONNRESET, but does not remove the s=
ocket
from vsock_connected_table.

When the vsock_connect() loop exits due to the error, sk_state is TCP_CLOSE.
Since that is neither TCP_ESTABLISHED nor TCP_CLOSING, this block will exec=
ute
and set sock->state =3D SS_UNCONNECTED.

This allows user space to retry connect() on the same socket. If the second
connection handshake succeeds, the socket is re-inserted into the connected
table via vsock_insert_connected(), triggering a list_add double add panic.

Is there a way to prevent user space from retrying connect() in this scenar=
io,
or should the socket be removed from the connected table during the transpo=
rt
reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vsock-conn=
ect-reset-closing-v1-1-50298b9ccfbf@rbox.co?part=3D1
