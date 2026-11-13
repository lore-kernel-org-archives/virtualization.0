Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566079;
	b=F/AFJpL+muTPtjFT8ww1axkeQqhY5xRcVoceusivRoid8TyZSXeZNA6ZJTTgGIHEz0bB
	 pCW3wexcygSem+ws8X2w7cF8s3tYZGOS6fsgoJ8Na3abSQlOq/lxoknDyOuw9f/Iu4ofm
	 MrG278G5lneNpkpt6nC8xMAlkHoJmE43UyL3/ocTlmhEum2xxsT694Y3nE6TQa+9xJTqY
	 Zu30uO2rmI/U255CgNTkOC4GFE2tIOr3fHTBhaxSb/zgoahSCwS10LrJjob8licrKhdQN
	 d80Nhc2egerCjr2HAwlPmmgcXqkQZ/DSCnoa06MOiKcrR7mbi9/XFxTmEtHPp0Y8aQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VHpXThLJEvJY93/oQ6iOV3ZNPvYBfa2H/O917Ag3esY=;
	b=zxmXLlHtD7Rs3h80jahpgRrOQeUMnh92iE+sLEhUf7cM/nIo7sSkvZICDptSYQXC2aaA
	 oNxrg8q33kwVd9pq13hJXNX8KOMobWGmAjKn+btj5dfSuPjHt12xhuYT83mi+ydsqQ2+A
	 GuTW7UMdheKp9T/KuRYdI5hfu1oBnHgC3LuY0v3EZ3g2/WMSutnm/03dIC3EF9+eFPK1r
	 sj4942Anz3G+um7PwJQP/6AyPP6AA2qYGn8HRzNUQ9waVfB2jzbseOImrb5d96JaI7Qhs
	 PtwJucUI7xZYVL6qrcwZEefGvpj4zDJ7PjLB7l1uveTCX8dnqtBoHEBZ6Yp43ioJagA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwoEVp2b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9263606A882;
	Fri, 13 Nov 2026 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwoEVp2b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A80F1F000C5;
	Fri, 13 Nov 2026 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566079;
	bh=VHpXThLJEvJY93/oQ6iOV3ZNPvYBfa2H/O917Ag3esY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TwoEVp2bMwSf2CQCr1uSCn2dKkSXBektnQMYx9IYdz41n0rAsaxSzVE6VZIJFkRBr
	 wNk39rd06lDZiRfuDIvIsrl7CkxzMQ1Yp+Mj+ZZRnJvoasYG0rgGLsWxgW4EkJ7+5a
	 GFvAD3zFzdCJ6CLeWqBtxr6jCP0ZtDEbhsjFfDAcfwaPxaMmOJWVolmNvfTgmI8vCA
	 jDjlg9hLpW8O4V+h4ci6Pa37mteVBTEyntPLk8rbuDvHpKi11e6wDQ4CRaP11ZrptA
	 J1cd0YPng8SLxiBxMEHHPBY1IOm92nEoI17BrKPssu2LNRa1QTq2o3MX8ziSQtFhw9
	 PRLVf3MrlHwaw==
Message-ID: <sashiko-outbox-212625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vhost/vsock: Fix socket state constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
References: <20261112-transport-reset-state-fix-v1-1-5698375f52a9@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:34:39 +0000
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
- [High] vhost/vsock: vhost_vsock_reset_orphans() TCP_CLOSE breaks
  vsock_connect()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] vhost/vsock: data race in vhost_vsock_reset_orphans() [1]
--

commit 5aff0946f70c88424d509989526e2bc91c501e
Author: Michal Luczaj <mhal@rbox.co>

vhost/vsock: Fix socket state constant

This commit updates vhost_vsock_reset_orphans() to set sk->sk_state to
TCP_CLOSE instead of SS_UNCONNECTED when resetting orphaned connections.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 88a310390eb0a..fd224f7681d92 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -789,7 +789,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> =20
>  	sock_set_flag(sk, SOCK_DONE);
>  	vsk->peer_shutdown =3D SHUTDOWN_MASK;
> -	sk->sk_state =3D SS_UNCONNECTED;
> +	sk->sk_state =3D TCP_CLOSE;
>  	sk->sk_err =3D ECONNRESET;
>  	sk_error_report(sk);
>  }

[Severity: High]
Can setting sk->sk_state to TCP_CLOSE here cause vsock_connect() to reset
sock->state to SS_UNCONNECTED while vsk remains in vsock_connected_table?

 Previously, SS_UNCONNECTED (1) happened to match TCP_ESTABLISHED (1), so
vsock_connect() treated the socket as once-established.  With TCP_CLOSE, a
vhost device release racing with a completing connection can hit the error
path in vsock_connect():

CPU0                              CPU1
vsock_connect()
  release_sock(sk)
  schedule_timeout()
                                  virtio_transport_recv_connecting()
                                    sk->sk_state =3D TCP_ESTABLISHED
                                    sock->state =3D SS_CONNECTED
                                    vsock_insert_connected(vsk)
                                  vhost_vsock_dev_release()
                                    ...
                                      vhost_vsock_reset_orphans(sk)
                                        sk->sk_state =3D TCP_CLOSE
                                        sk->sk_err =3D ECONNRESET
  lock_sock(sk)
  if (sk->sk_state =3D=3D TCP_ESTABLISHED ||
      sk->sk_state =3D=3D TCP_CLOSING)        <-- false
  ...
  err =3D sock_error(sk)
  if (err)
    sock->state =3D SS_UNCONNECTED          <-- still in vsock_connected_ta=
ble

net/vmw_vsock/af_vsock.c:vsock_connect() {
    ...
		if (sk->sk_state =3D=3D TCP_ESTABLISHED ||
		    sk->sk_state =3D=3D TCP_CLOSING) {
			err =3D 0;
			goto out_wait;
		}
    ...
	err =3D sock_error(sk);
	if (err) {
		sk->sk_state =3D TCP_CLOSE;
		sock->state =3D SS_UNCONNECTED;
	}
}

Because sock->state is reset to SS_UNCONNECTED while vsk is still linked in
vsock_connected_table, a subsequent connect() on the same socket can
reassign its transport or, if shutdown() clears SOCK_DONE and a new
VIRTIO_VSOCK_OP_RESPONSE arrives, call vsock_insert_connected(vsk) a second
time and corrupt vsock_connected_table.  Setting sk->sk_state to
TCP_CLOSING instead (or checking sock_flag(sk, SOCK_DONE) in
vsock_connect()) would preserve the once-established check.

[Severity: High]
This problem wasn't introduced by this patch, but vhost_vsock_reset_orphans=
()
modifies sk->sk_flags, vsk->peer_shutdown, sk->sk_state, and sk->sk_err
under vsock_table_lock without holding lock_sock(sk) [1].  Concurrent
socket operations such as vsock_connect(), sendmsg(), or recvmsg() holding
the socket lock can race with these updates and observe inconsistent socket
state.

[1] https://sashiko.dev/#/bug/linux-f1ccca0e-e7ae-4926-a24d-72f61680c524

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-transport-=
reset-state-fix-v1-1-5698375f52a9@rbox.co?part=3D1
