Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053338;
	b=FBeI/VCE0E1AGYW/nPrHorj8FpwqqXvS6PD1JbDv91OAoNAE3esCdKE2YU3EpuDJPiP0
	 kTbIxMzuS/pOfm3LF3E4sJ19mzHoEWIFnAayoTMEuBRZEw2sfK/O7/NR7izlEe45VSk+M
	 czbGLZ2lv6JZita1KS6UuhZVoWgyNQAaj859qijk8TM58HK5uEMQIbe6csLBAZ5NHiYMK
	 n5hsGuV3pedVG2IUzKbZeum5JvlsbKVw5pUgkVu9HYuOlNLdN66hJBjI7iExOUSRMg32h
	 ds5+YzPFHX3eYzVMFP+yqpahq4URvXhVhp+clqXSzRN0r1yEJywji88W62WHlOHN//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vA5ToclYx6H/faiDFEGJ9saRp250wEs7l8uVF7ohgTc=;
	b=AQ4aMdl/cBLjs6skONFRPPmsAPfhbg9+h5sYC+KJMAktlJF1mr69nRPJ+zHUrbacfCVS
	 0SyjNW2mKRhX6N2IArcipg4NMgTLK8F10vcMELTP898aZNcVGSnk6XK9HoqGwPjW8t/SK
	 tpPhgPNuLujRsck7aOK/IlFWs52lCFMir2TDdnzxAbnemRtHK9+XgTqORcJV+cKLxff0j
	 /j8si5LNAExnL21HPYGxfdSJZVniSDIgX4qzZkFNXan8AUXcjvLhRXdMAHTGX8enr/7qh
	 o2n1fkDAeoyYHDbCgtV0YZzqzUJ3HV9CVD7eV2CH6dXdjTgxw6Fs42gno3u1qlX/oIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WclZePUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3866606A325;
	Thu, 19 Nov 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WclZePUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9418F1F000C9;
	Thu, 19 Nov 2026 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053337;
	bh=vA5ToclYx6H/faiDFEGJ9saRp250wEs7l8uVF7ohgTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WclZePUNwtj7/uud2AKcNWrXzsKlYrFQGku77sVSmANdHPQ6qhAaYMBoT2/8o4lU1
	 cbezsDkkKQuoYf7Ff0+JYuuoshf1gmFFXNBN5ZZs98gKQ9SUrD99jByarF4fHiblyj
	 HgnhrVvOttNCKDzipEQXRyM5UnttSvMrI9OjPvqRkdhuC3oFB8stIRu2Z+wvNcB1E/
	 BOptR5lZzdPADzN8PxBMIqen9QK1wUoBhlB+KHNUK4WK0/IALtz7HPaT0CUzSDAqFZ
	 G4x1bzfa3qM7Fj+B43o6XXyL6EYnVAohrwGJl6FvvEHZjJGo/PsLMDbcAduZfFNqzp
	 eWtfceQ4ewSqQ==
Message-ID: <sashiko-outbox-222311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 5/7] vsock/virtio: support guest device
 network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-5-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-5-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:37 +0000
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
- [Medium] vsock/virtio: swept sockets can still send and receive after
  device reassign
- [Medium] vsock/virtio: bytes_unsent not decremented in
  virtio_transport_purge_skbs()
--

commit 9aa3064a70d9c211d00810f1b687d67543df5469
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock/virtio: support guest device network namespace

This commit allows assigning the virtio-vsock guest device to a network
namespace and updates connection setup, packet reception, and packet
transmission to check whether sockets can reach the assigned namespace.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 1ddb6839a8fbe..ba90815362120 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
[ ... ]
> @@ -587,6 +589,7 @@ static struct virtio_transport virtio_transport =3D {
>  		.seqpacket_has_data       =3D virtio_transport_seqpacket_has_data,
> =20
>  		.msgzerocopy_allow        =3D virtio_transport_msgzerocopy_allow,
> +		.netns_assign_allow       =3D true,
> =20
>  		.notify_poll_in           =3D virtio_transport_notify_poll_in,
>  		.notify_poll_out          =3D virtio_transport_notify_poll_out,

[Severity: Medium]
Does purging queued packets on an established socket leave
vvs->bytes_unsent elevated?

Previously, virtio_transport_cancel_pkt() was only called on TCP_SYN_SENT
sockets, whose queued packets have zero payload length.  With
.netns_assign_allow enabled, vsock_g2h_reset_unreachable() now calls
t->cancel_pkt(vsk) -> virtio_transport_cancel_pkt() ->
virtio_transport_purge_skbs() on TCP_ESTABLISHED sockets that may have
data SKBs queued in vsock->send_pkt_queue.  virtio_transport_get_credit()
already added those payload bytes to vvs->bytes_unsent, and normally
virtio_transport_consume_skb_sent() subtracts skb->len on TX completion,
but virtio_transport_purge_skbs() frees matching SKBs with
__skb_queue_purge(&freeme) without decrementing vvs->bytes_unsent.

As a result, SIOCOUTQ reports stale unsent bytes on the reset socket, and
a concurrent close() sleeping in vsock_linger() stalls until
sk_lingertime expires because virtio_transport_unsent_bytes() never
reaches zero.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 027fe41c676aa..c8049dd80cbcd 100644
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
Can a socket swept by vsock_g2h_reset_unreachable() still send packets to
the host if the device is reassigned back to a reachable namespace before
the file descriptor is closed?

vsock_g2h_reachable_sk(vsk) only checks whether sock_net(sk_vsock(vsk))
can currently reach vsock_g2h_net, not whether vsk was already terminated
by an earlier namespace assignment.  When vsock_g2h_reset_unreachable()
sweeps a connected socket, it sets SOCK_DONE and
vsk->peer_shutdown =3D SHUTDOWN_MASK, leaves the socket in
vsock_connected_table, and keeps sk->sk_state as TCP_CLOSING (or
TCP_ESTABLISHED if unread RX data remains).  If the device is later moved
back to a reachable namespace such as init_net, vsock_g2h_reachable_sk()
returns true again:

- close() -> virtio_transport_close() checks
  (vsk->peer_shutdown & SHUTDOWN_MASK) =3D=3D SHUTDOWN_MASK before SOCK_DONE
  and sends VIRTIO_VSOCK_OP_RST to the host.
- recvmsg() or setsockopt(SO_RCVLOWAT) sends
  VIRTIO_VSOCK_OP_CREDIT_UPDATE.
- shutdown() -> vsock_shutdown() sends VIRTIO_VSOCK_OP_SHUTDOWN and clears
  SOCK_DONE via sock_reset_flag(sk, SOCK_DONE), which also allows the
  socket in vsock_connected_table to pass the SOCK_DONE check in
  virtio_transport_recv_pkt() again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D5
