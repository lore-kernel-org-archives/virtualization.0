Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631783;
	b=Wz09sc8s+o6INsPoSFjJJVO4EHTIXfhnFZqh0VDrP/FF3F7FmAehJamcAM1twschJFRQ
	 8mCD8rw3w+jK6A3tQTA/RQGiRgfeL+NJzPYqpCnOwjFE/gYIZcXqVxNyeH91ZqqcsCckH
	 B6f9/uEB2ozoGsV8+jn2XxdDO0zrXyWfByJTJr0phYh8iJQp7TIfKZYSZr6OeBX5cBvyr
	 dF1istlVBtHM3MSEMhc8Gg19cnUQ1udm6iy+JL/NUCzgKmcfpyk63iw43H/FWgVzcVq9o
	 1968J8BUIUV9RhRPZhR1zW/PGTyj8kd028JLr4VEpctngHI17PrVZ5sWu3xBMVfcF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631783;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0KVS0L3QDq8wtkWnaNEZpyC0S3uTyPBsomM9MIQnvZg=;
	b=GAsAonbLEk3ZKLC1DKTqSNM6iluNrReO3TW5/Ia4PQwRNfkQBdq8vFgLTShNBXqSQr04
	 xk6EC9C8E6INcB2pnY8PlZ1PxTTaZfDZrVVjAQXsMbof07r6Q/bJFtmxt9hLksWQkmHVR
	 u+NcKQqfhZgeKbeYMRQ2GwRF6HaZH++raiXm6N0H28qoBaXpdaTK8fWOCCXWyElcH2VEH
	 GpTak6r3Z+vDgEs/R4qx95qh8Stgckd3o2D6fdvxdG/4lNjIwHjjx4Oq5qHOc7Nzf1HF8
	 lPTNGeDkqWt50dDolOsI4LJxgYMax3qgVk2SqMrb/0CiF2NvUcMF/wog+txOsqOIjGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWPa1krg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2474606A31F;
	Thu, 22 Oct 2026 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VWPa1krg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656FC1F000C1;
	Thu, 22 Oct 2026 01:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631782;
	bh=0KVS0L3QDq8wtkWnaNEZpyC0S3uTyPBsomM9MIQnvZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VWPa1krgh4ELL1GQP+pfVgkhjWmc5CST0hZKhlyYXx/Bcqmj+PZmxjdaIJRAahR4V
	 Pc/hZheTvOKONbwJ6nmyOHGCkhBIe6ETE0WG2ZVN/xNej2E+UTbDPifBqT1SEGOZw1
	 frsUNyOO60unP9hhDcmt6JBk81mo7jQh75EjzHuwnnpV7BK67hgHJsMBXNbjbr8McP
	 t03Zr0wCk9ehCzOAKi4/cne0GW6kI03inVoBSPzDeietT/NyN/kpzT1YScrE3C0S9s
	 +tD3y7V8qmcxuDgpKHNQZh9UeCvcr05znI+aOx4pjN1GMgkwAZ2B4o1gA5EUaooFkX
	 mBosYiGEtXQiQ==
Message-ID: <sashiko-outbox-180842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 5/7] vsock/virtio: support guest device
 network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-5-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-5-047527cfccfc@meta.com>
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
- [Medium] vsock/virtio: virtio_transport_send_pkt() drops RST replies on n=
etns change
--

commit 8627fb28e7c64d1d9b02b254ab9dca7140468f14
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock/virtio: support guest device network namespace

This commit enables network namespace assignment for the virtio-vsock guest
device, updating reachability checks in the virtio transport and re-reading
the assigned namespace per packet in virtio_transport_rx_work(). It also
uses vsock_maybe_set_connected() when transitioning sockets to the connected
state so sockets that lose device reachability during namespace reassignment
are reset.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index eced6929405df..06df82b130cff 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -256,6 +256,15 @@ virtio_transport_send_pkt(struct sk_buff *skb, struc=
t net *net)
>  		goto out_rcu;
>  	}
> =20
> +	/* A socket reset by an assign can still send credit updates from
> +	 * recvmsg() and setsockopt(SO_RCVLOWAT).
> +	 */
> +	if (!vsock_g2h_net_reachable(net)) {
> +		kfree_skb(skb);
> +		len =3D -ENETUNREACH;
> +		goto out_rcu;
> +	}
> +
>  	/* If send_pkt_queue is empty, we can safely bypass this queue
>  	 * because packet order is maintained and (try) to put the packet
>  	 * on the virtqueue using virtio_transport_send_skb_fast_path.

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 1e762a480df49..0c864db2bc65b 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1478,9 +1478,13 @@ virtio_transport_recv_connecting(struct sock *sk,
> =20
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RESPONSE:
> -		sk->sk_state =3D TCP_ESTABLISHED;
> +		if (!vsock_maybe_set_connected(vsk)) {
> +			skerr =3D ECONNRESET;
> +			err =3D -ENETUNREACH;
> +			goto destroy;
> +		}
> +
>  		sk->sk_socket->state =3D SS_CONNECTED;
> -		vsock_insert_connected(vsk);
>  		sk->sk_state_change(sk);
>  		break;
>  	case VIRTIO_VSOCK_OP_INVALID:

[ ... ]

> @@ -1758,7 +1760,13 @@ virtio_transport_recv_listen(struct sock *sk, stru=
ct sk_buff *skb,
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
> =20
> -	vsock_insert_connected(vchild);
> +	if (!vsock_maybe_set_connected(vchild)) {
> +		release_sock(child);
> +		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> +		sock_put(child);
> +		return -ENETUNREACH;
> +	}
> +
>  	vsock_enqueue_accept(sk, child);
>  	virtio_transport_send_response(vchild, skb);

[Severity: Medium]
Will virtio_transport_send_pkt() drop the VIRTIO_VSOCK_OP_RST packets sent
when a connection handshake races with a device namespace change?

In net/vmw_vsock/af_vsock.c, vsock_maybe_set_connected() checks reachability
via vsock_g2h_reachable_sk():

    spin_lock_bh(&vsock_table_lock);
    reachable =3D vsock_g2h_reachable_sk(vsk);
    if (reachable) {
            sk_vsock(vsk)->sk_state =3D TCP_ESTABLISHED;
            __vsock_insert_connected(list, vsk);
    }
    spin_unlock_bh(&vsock_table_lock);

For virtio_transport, vsock_g2h_reachable_sk(vsk) returns false when
vsock_g2h_net_reachable(sock_net(sk_vsock(vsk))) is false.

When vsock_maybe_set_connected() returns false in
virtio_transport_recv_connecting(), jumping to destroy calls:

    virtio_transport_reset(vsk, skb)
      -> virtio_transport_send_pkt_info(vsk, &info) /* info.net =3D sock_ne=
t(sk) */
        -> virtio_transport_send_pkt(skb, info.net)

Similarly, in virtio_transport_recv_listen(), when vsock_maybe_set_connecte=
d()
or vsock_assign_transport() fails after a namespace change, it calls:

    virtio_transport_reset_no_sock(t, skb, sock_net(sk))
      -> virtio_transport_send_pkt(reply, sock_net(sk))

The same also happens in virtio_transport_recv_pkt() if an established sock=
et
is swept to TCP_CLOSE by vsock_g2h_reset_unreachable() before lock_sock(sk)
acquires the socket lock, hitting the default case and calling
virtio_transport_reset_no_sock(t, skb, net).

Because virtio_transport_send_pkt() in net/vmw_vsock/virtio_transport.c now
checks !vsock_g2h_net_reachable(net) and frees the skb with -ENETUNREACH,
won't all of these outgoing VIRTIO_VSOCK_OP_RST replies be dropped before
reaching the host peer, leaving a guest-initiated connection half-open on t=
he
host or causing a host-initiated connect() to hang until timeout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D5
