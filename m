Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712875;
	b=DcHxu1b559A4T60Yg5beTWT0Wz9kRVMll9D8sj6V3akZCt2r80zt1ixYIfdzBseQkHMt
	 TtV3qD03STQYWp3A9uUPiFpRNrGNpRt8TQxiQeK0FolhbORtI1PkwNQWSDgddh1rzJ1OF
	 3mZlPbY5grgdE/8Qe2Zqmsqx5ztf8OHZu/QXJfpsbz8X5At91cPX7vhUYs2NDrCQvQhrg
	 2rcARzjlz9IRrWO97i1V9zYF/j4rC+fqUmJRwR0oRCNPNnGzlciDpuHaybjV3LEn6r2fR
	 kUUUgfntNsOj/seo5K/PveCAiX1StLzmjzaxuxCmDAAZyZ/bolHkaL6/6H+aL3eeuVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mirjRrVwMS32KwSx+cfQBET69tXXPcSR1S4rQK3mOoA=;
	b=TBtaLoTDOSKqks6iV/SHWhv/f/2zugaqhJ6dTmE2OBX3vNLZ1qkFyux61PBLJsvlEK3c
	 ivH6vOjza8OriCUaYWjvEVQwU5ZCaA99LLM+PHECOUsI73ylb6tpRyEi3RK5rR0wM9HU0
	 AjSLZuE56MP/q4cid/wolSWz3/lirbb/5QX35hMr7dMWbEcebnMuLY8zrhWhp/gUh3do8
	 hUWBZEo42EIsxT/FI3jVSPuQb8HUQqhzXXA1MWo1d/MOgFQixKOI7DuUBP2eU3l6+tAWl
	 EJ4wWUv0EBUcA1D089jf3L1UozSUTkdbmP7r6Cf5LqzGgY3cUFtV9cAr0cb0jiEszMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHnG9aNV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B98606A885;
	Sun, 15 Nov 2026 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHnG9aNV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389311F000C4;
	Sun, 15 Nov 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712874;
	bh=mirjRrVwMS32KwSx+cfQBET69tXXPcSR1S4rQK3mOoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHnG9aNVqr9Y635GfiwEMRth4ZGixkWLLODa/8eu1KAqETtoAYH2sTNgMyBghtnLi
	 bMo0gWAqKUhCQY9D7hakm6554UqGUJjj/cAjfQ+C6GsTCRJKGdAgC9OAoVZA0F3jW5
	 WxSGb79bYFwWEg5CVhhLWkGvoD3l2m8fRgevrsRSvbvJ8ISDNPIZaIX+YzmszCYNXQ
	 yiRUlY7NDQe0vwwZNVxR48ZweuJL3moO6fZsvm0PgG7o207Dg32PrrdGlc+zG1DgAR
	 Cm0CSpGeeCRXQgZStLJgtjORVqqR1+lt3xfEk1bF6uMW+4qpNgmPQVNed+HL5NXhX2
	 wFUjJgEnE7VYg==
Message-ID: <sashiko-outbox-215199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 6/8] vsock/virtio: support guest device
 network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-6-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-6-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:13 +0000
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
- [Medium] vsock/virtio: swept sockets still send packets in
  virtio_transport_send_pkt_info()
--

commit fba2ffbc0db5d9ef1fbbeb2422cacba719ecb282
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock/virtio: support guest device network namespace

This commit allows assigning the virtio-vsock guest-to-host device to a
network namespace and enforces namespace reachability on stream and
seqpacket sockets across the receive, handshake, and send paths.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 1e762a480df49..c1cbe834e4f59 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -295,6 +295,9 @@ static struct sk_buff *virtio_transport_alloc_skb(str=
uct virtio_vsock_pkt_info *
>   * since a socket assigned to a transport is required.
>   *
>   * Do not use on listener sockets!
> + *
> + * This checks that the socket can reach the g2h device, so device-only =
replies
> + * such as virtio_transport_reset_no_sock() must keep not using this pat=
h.
>   */
>  static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  					  struct virtio_vsock_pkt_info *info)
> @@ -317,6 +320,9 @@ static int virtio_transport_send_pkt_info(struct vsoc=
k_sock *vsk,
>  	if (unlikely(!t_ops))
>  		return -EFAULT;
> =20
> +	if (!vsock_g2h_reachable_sk(vsk))
> +		return -ENETUNREACH;
> +
>  	src_cid =3D t_ops->transport.get_local_cid();
>  	src_port =3D vsk->local_addr.svm_port;
>  	if (!info->remote_cid) {

[Severity: Medium]
Can a socket that was swept by vsock_g2h_reset_unreachable() still send
packets if the g2h device is later reassigned back to a reachable
namespace?

vsock_g2h_reset_unreachable() removes the socket from the connected table
and sets SOCK_DONE, vsk->peer_shutdown =3D SHUTDOWN_MASK, and
sk->sk_state =3D TCP_CLOSING, while vsock_g2h_reachable_sk() only checks
whether the socket's namespace can currently reach vsock_g2h_net. If the
device moves back to a namespace vsk can reach (such as init_net) before
userspace closes the file descriptor, vsock_g2h_reachable_sk(vsk) returns
true again, and close() -> virtio_transport_close() sends a RST before
checking SOCK_DONE:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_close() {
	if (!(sk->sk_state =3D=3D TCP_ESTABLISHED ||
	      sk->sk_state =3D=3D TCP_CLOSING))
		return true;

	/* Already received SHUTDOWN from peer, reply with RST */
	if ((vsk->peer_shutdown & SHUTDOWN_MASK) =3D=3D SHUTDOWN_MASK) {
		(void)virtio_transport_reset(vsk, NULL);
		return true;
	}
    ...
}

Because the swept socket was already removed from vsock_connected_table,
that RST (or a packet from shutdown() or setsockopt(SO_RCVLOWAT)) goes out
with the old 4-tuple and can reset a new connection that reused the port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D6
