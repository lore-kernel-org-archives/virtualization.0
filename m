Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7E8635D;
	Wed, 23 Sep 2026 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126324; cv=none; b=EuBM5S2bq70dlwBQA40/Z//VpXyq9cg4YmHZIUFuIH2bDMdi7VZAJ0vFGg7J1IZFRi4P3jhkvRHCKr9AyIp88M4MFoPl/ZWrBPAcZPcBqN+RSm7h4RJmeBx7F3g6KYZys4rzPI5NhoBRl4BzGI3Bbm3GWy8YSJQp7HT8Jn54+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126324; c=relaxed/simple;
	bh=0IgX27Y+yb+uUIomSYcSASUwZZm7viMrIoY7xB89fco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gGLb+qD8Niq7W3wA77I7WS0Lwe8wEfXntTkhOpviNO8Vek5H1A6SONJv9/WJSUEBeHgxCO6+ObQx/B3d1zMFo3KQvqw0tdx3jpjJFWrn4xVLv3/l3FEUGy+8kPpjaX4t6J3TIRtG3fhAOKkzOQJvfjrSjniCh7Nu6/woPSU04yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2og1DEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2og1DEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A501F000FF;
	Wed, 23 Sep 2026 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126322;
	bh=KeEY/m6BRiJF+S52LfXLSYkT2l+3ABxVy4sGjtKRxSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2og1DELzqSxEtrQSbt1BYz+0peXSeCwPE8g+iCoXpbvqJQHqxHr+vAqMP2d1t8hw
	 Wb4Bb7cPL5w+PlPKuFyWPVKdudyowrcXfm/DC0agVXtKX/QR3IUUmHpI8919VVghvW
	 B49AFfyf/7oThuqrpOquc2NYSs5oFjR4zjOTGITUVoaQWVHZKAMNQGKTQ43d/7iYk7
	 o4AeGH9NVLAJ/CmC4aDQMo/G2qZH21MkZqTdVXAlPq2ghB/Wag6hmHgdsqRl3d4rX9
	 iWvoRICQ5MQWxoIr3YZ4iF726NzR+hf5CQCJL7qN71ZtdfxppriUHkPaTMq0Zi0mPu
	 Lxn/RZYq/M8rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/6] vsock/virtio: support guest device
 network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260921-vsock-guest-ns-v2-4-693bd78fde9e@meta.com>
References: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
 <20260921-vsock-guest-ns-v2-4-693bd78fde9e@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:18:42 +0000
Message-Id: <20260923011842.91A501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vsock: unprotected socket state modification in vsock_g2h_reset_un=
reachable()
--

commit 22f9613466fe3520fb04ad3d32779638f9afe30e
Author: Bobby Eshleman <bobbyeshleman@meta.com>
vsock: add a netlink command to assign the g2h device to a netns

This commit introduces the VSOCK_CMD_DEV_NETNS_SET netlink command to move
the guest-to-host vsock device to a different network namespace. It resets
established connections that are no longer able to reach the device from
their respective namespaces. The commit also updates CID discovery and
socket creation paths to honour the new namespace assignments.

Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 95a435aef512b..9938dd5010192 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> @@ -742,6 +812,173 @@ bool vsock_find_cid(unsigned int cid)
[ ... ]
> +/* Reset every connected socket of @t that can no longer reach the g2h d=
evice,
> + * and let the transport tell each peer.
> + */
> +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
> +{
> +	struct vsock_sock *vsk, *tmp;
> +	LIST_HEAD(reset_list);
> +	struct sock *sk;
> +	int i;
> +
> +	/* The calling context must hold vsock_register_mutex, which serializes
> +	 * concurrent netns assignments' use of vsk->pending_reset.
> +	 */
> +	lockdep_assert_held(&vsock_register_mutex);
> +
> +	spin_lock_bh(&vsock_table_lock);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vsock_connected_table); i++) {
> +		list_for_each_entry(vsk, &vsock_connected_table[i],
> +				    connected_table) {
> +			sk =3D sk_vsock(vsk);
> +
> +			if (vsk->transport !=3D t ||
> +			    sk->sk_state =3D=3D TCP_CLOSE ||
> +			    vsock_g2h_reachable_sk(vsk))
> +				continue;
> +
> +			sk->sk_state =3D TCP_CLOSE;
> +			sk->sk_err =3D ECONNRESET;
> +			sk_error_report(sk);

[Severity: High]
Does this code modify the socket state locklessly?

sk->sk_state and sk->sk_err are modified here while holding only the
vsock_table_lock spinlock, without acquiring the socket lock (lock_sock).

Core socket operations, such as vsock_connectible_sendmsg(), rely on
lock_sock() to protect state transitions and evaluate sk->sk_state to
determine if data can be enqueued. Modifying the state here without the soc=
ket
lock introduces a race condition. For example, a thread holding lock_sock()
might read an established state and proceed to enqueue data, while this
function concurrently sets the state to TCP_CLOSE.

Should the state modification be deferred to the second loop where
lock_sock() can be acquired?

> +
> +			sock_hold(sk);
> +			list_add_tail(&vsk->pending_reset, &reset_list);
> +		}
> +	}
> +
> +	spin_unlock_bh(&vsock_table_lock);
> +
> +	/* Reset outside of spinlock because the transport may sleep
> +	 * (e.g., GFP_KERNEL alloc).
> +	 */
> +	list_for_each_entry_safe(vsk, tmp, &reset_list, pending_reset) {
> +		list_del_init(&vsk->pending_reset);
> +		t->reset(vsk, NULL);
> +		sock_put(sk_vsock(vsk));
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vsock-gues=
t-ns-v2-0-693bd78fde9e@meta.com?part=3D4
