Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053337;
	b=KTgzpULiwBTrvq9UG0rjSxDeX7jeeMHUm9ushHyRcjqM3b2TupBZOjW63N/E9EoG/b/E
	 Kz+e8+FWvbJa1rpnyFW6BgdiG6IqskKHk82m0oLXKKiFU+q3VsTtRNQV827BgyEFGvL64
	 iW/wJtL+3mEZAAEFgJc+qT4enXTPB5yLryRVu6PldzvWifqwWx/iKRNBzDWeHQln1bmSt
	 0HWUSiPE+6Z5eWWYbTSRKrv7+u5rWwW1tYvDtPwVN/Xg7LMa7hfRAaQUcXuVPkr/00jSi
	 /IUDzdBYjVlARjZkLyDRZoCeh8AITNiehv5zk5Fo14gs0a1+nTfCksk1lTfdiDhKmXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053337;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KdfThSWSYJgCX5CuT2DGBsYkPwFqpzcetOCAf14ReD8=;
	b=m71jnWq3wrS/TLqC7tPKUEYc+wCRhDtezbX5k9FCgAIF4Pn1GLgnYCd1tJyQQVP+Ox6f
	 bZ/HNf46Pgik5kfCfHSPdnL+MlH6z6OodGbpN+LiWlUIyAupW8AFtrNwduT8VGv7tKxle
	 Fdc1Ex8WLHmAKEuVPCKnnHtBI3MTeXCprH5lwhMAx2b7+mn4V9zioKu84/RdDRfdpphog
	 DAwcGi36Ve/JeU1cjA7Vd41rQWHniJJsVQY/Y0bzNend53wLpLMXEMjTvb/0eSUYgJWk9
	 PXDGGTclmkXx/EbIW3tIB3GG2ps3gIqEfVpUNbhtYfpxmZbTTyu4ikigtuwEpmaDzDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRZFPznH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52569606A32F;
	Thu, 19 Nov 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRZFPznH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18971F000CA;
	Thu, 19 Nov 2026 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053337;
	bh=KdfThSWSYJgCX5CuT2DGBsYkPwFqpzcetOCAf14ReD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZRZFPznHqh/YzAI+tSDegQa0cD+KpXvFlwcqvCoZFUZ5mwelGHwuOTkJe1t/1AuS1
	 VY84RliusxvsjzOG/Ugc4t1gELlpCMrtH69mhlNarzhrMZlQlArhrj5M2RuN1AF3kl
	 PCN4hKT6HctRnOuiy7Y6TX7uG3yk2AiW3TCIYQjovfv6pnFwfXp/CMSGQDEfbM0vgh
	 yvICZJM1Wp+DayGgSji4LFEdoSn4STyMgvLqkMJ57SqTbWXkYorQfVKcppWuQJGbmS
	 b7qmTSpvQ6MG7QxiIy0fW3PDAvDhCFTMEpXTfF3IJQCr58vTGK/440ojYmvITMu9or
	 K7D3aXgFU88xQ==
Message-ID: <sashiko-outbox-222310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-4-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-4-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:35 +0000
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
- [Medium] vsock: swept sockets lose seqpacket data and return EOF
  instead of ECONNRESET
- [Medium] vsock: vsock_shutdown() clears SOCK_DONE on swept sockets in
  connected table
--

commit d661163d1e6afc774ff2a10040756b2e6a13f480
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock: add a netlink command to assign the g2h device to a netns

This commit adds a vsock generic netlink family with VSOCK_CMD_DEV_NETNS_SET
and VSOCK_CMD_DEV_NETNS_GET commands to move the guest-to-host vsock device
between network namespaces and close sockets that lose access to it.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 7d58e7396b75f..dcd39ad43eec3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> @@ -502,6 +544,37 @@ void vsock_for_each_connected_socket(const struct vs=
ock_transport *transport,
>  }
>  EXPORT_SYMBOL_GPL(vsock_for_each_connected_socket);
> =20
> +/* Return the next connected socket of @transport that @match accepts, w=
ith a
> + * reference held. The scan starts at bucket *@bucket and leaves it wher=
e it
> + * stopped, so calling again resumes there. Unlike
> + * vsock_for_each_connected_socket(), the caller acts on the socket after
> + * vsock_table_lock is dropped, so it can take lock_sock().
> + */
> +static struct sock *
> +vsock_next_connected_socket(const struct vsock_transport *transport,
> +			    unsigned int *bucket,
> +			    bool (*match)(struct vsock_sock *vsk))
> +{
> +	struct vsock_sock *vsk;
> +
> +	spin_lock_bh(&vsock_table_lock);
> +
> +	for (; *bucket < ARRAY_SIZE(vsock_connected_table); (*bucket)++) {
> +		list_for_each_entry(vsk, &vsock_connected_table[*bucket],
> +				    connected_table) {
> +			if (vsk->transport =3D=3D transport && match(vsk)) {
> +				sock_hold(sk_vsock(vsk));
> +				spin_unlock_bh(&vsock_table_lock);
> +				return sk_vsock(vsk);
> +			}
> +		}
> +	}
> +
> +	spin_unlock_bh(&vsock_table_lock);
> +
> +	return NULL;
> +}
[ ... ]
> +static bool vsock_g2h_should_reset(struct vsock_sock *vsk)
> +{
> +	return READ_ONCE(sk_vsock(vsk)->sk_state) =3D=3D TCP_ESTABLISHED &&
> +	       !sock_flag(sk_vsock(vsk), SOCK_DONE) &&
> +	       !READ_ONCE(vsk->close_work_scheduled) &&
> +	       !vsock_g2h_reachable_sk(vsk);
> +}

[Severity: Medium]
Can calling shutdown() on a swept socket clear SOCK_DONE and cause
vsock_g2h_should_reset() to match it again?

When vsock_g2h_reset_unreachable() sweeps a socket that has unread data
queued, it leaves the socket in vsock_connected_table with sk->sk_state set
to TCP_ESTABLISHED and relies on SOCK_DONE to prevent
vsock_g2h_should_reset() from matching it again.  However, vsock_shutdown()
unconditionally clears SOCK_DONE whenever sock->state is not SS_UNCONNECTED:

net/vmw_vsock/af_vsock.c:vsock_shutdown() {
	...
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
		...
		if (sock_type_connectible(sk->sk_type)) {
			sock_reset_flag(sk, SOCK_DONE);
			vsock_send_shutdown(sk, mode);
		}
	}
}

Because vsock_next_connected_socket() restarts from the head of the current
bucket on each iteration, a process calling shutdown() on its swept socket
makes vsock_g2h_should_reset() true again and re-matches the same socket in=
 a
loop under vsock_g2h_assign_mutex.  On a swept socket with sk->sk_state set
to TCP_CLOSING, clearing SOCK_DONE also causes subsequent recvmsg() calls to
return -ENOTCONN, and on a TCP_ESTABLISHED swept socket it bypasses the
sock_flag(sk, SOCK_DONE) check in virtio_transport_recv_pkt() if the device
later moves back to a reachable namespace.

> +
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
> +		    vsock_g2h_should_reset(vsk))
> +			reset =3D true;
> +		spin_unlock_bh(&vsock_table_lock);
> +
> +		if (reset) {
> +			sock_set_flag(sk, SOCK_DONE);
> +			WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
> +			/* Same as a peer reset, stay TCP_ESTABLISHED while data
> +			 * is queued so that recv() can still read it.
> +			 */
> +			if (vsock_connectible_has_data(vsk) <=3D 0)
> +				sk->sk_state =3D TCP_CLOSING;
> +			sk->sk_err =3D ECONNRESET;
> +			sk_error_report(sk);
> +			if (t->cancel_pkt)
> +				t->cancel_pkt(vsk);
> +		}

[Severity: Medium]
Does setting sk->sk_err =3D ECONNRESET and sk->sk_state =3D TCP_CLOSING here
cause SOCK_SEQPACKET sockets to drop queued messages and empty sockets to
return 0 instead of -ECONNRESET?

When a SOCK_SEQPACKET socket has unread messages queued at sweep time,
sk->sk_state remains TCP_ESTABLISHED and __vsock_seqpacket_recvmsg() dequeu=
es
the message, but then checks sk->sk_err and overwrites the return value with
-ECONNRESET, discarding each queued message:

net/vmw_vsock/af_vsock.c:__vsock_seqpacket_recvmsg() {
	...
	msg_len =3D transport->seqpacket_dequeue(vsk, msg, flags);

	if (msg_len < 0) {
		err =3D msg_len;
		goto out;
	}

	if (sk->sk_err) {
		err =3D -sk->sk_err;
	} else if (sk->sk_shutdown & RCV_SHUTDOWN) {
		err =3D 0;
	} else {
		/* User sets MSG_TRUNC, so return real length of
		 * packet.
		 */
		if (flags & MSG_TRUNC)
			err =3D msg_len;
		else
			err =3D msg_len - (msg_len - len);
	}
}

Conversely, when a socket has no queued data at sweep time, setting both
sk->sk_state =3D TCP_CLOSING and SOCK_DONE causes __vsock_connectible_recvm=
sg()
to return 0 (EOF) before ever inspecting sk->sk_err:

net/vmw_vsock/af_vsock.c:__vsock_connectible_recvmsg() {
	...
	if (!transport || sk->sk_state !=3D TCP_ESTABLISHED) {
		if (sock_flag(sk, SOCK_DONE))
			err =3D 0;
		else
			err =3D -ENOTCONN;

		goto out;
	}
}

Meanwhile, a SOCK_STREAM socket that had queued data at sweep time never
transitions to TCP_CLOSING after draining, so subsequent recvmsg() calls ke=
ep
returning -ECONNRESET instead of 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D4
