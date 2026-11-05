Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843681;
	b=DLYeVGzS7aiuF3+Fr70U2/B9LdUG3gTi/mwosR1/09xs+zEQzp2osofv9bug2Wmovk31
	 Af+j+jPYATsuIB5OccTxUU7dxMEd+NVMNpohuHKyDU/8muYAoZiQiTMm92qDEb1c7kPrq
	 jXS8qH/Gvr+YgkwxPQMMq5PKpTWO8xdiP8VbxE1mA+5MZKqqTubjxkDFj97seQcB3EN5e
	 nSBkKSE9pE6PJLcyQdZLi7NySuyGsIjDqt33Lx7M46qN9hxXjyE/UnWEUKZCBs4J/BOJv
	 XZ5g0MMYCDukf5nVSicHrshGAX61c5GBUeGmpXBKrUlsR7oADV1+i1lNEBCeMp8Ky+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+yWdo/0a0eeAHbSdljbrBqnn6cYdtPGmmMmAAboJx7M=;
	b=3szTe2OnVgynVD/mehxpRHb6KzfCnORsXlBXqqUgSV98+PDVSRTjiO4qVxMTY0LaDvnW
	 I5xLiz2jhLondCpKXITz9y5I9bsp69OuvKN8DTrO7ETG8aJndtN2oBEJZLTuUZcJxqmqa
	 6rrAnC9OQIfwYUN+Ef4lN4NjJ4kuHbPkzHrQmTsDYUei4LSw542dGg1n9EqPubljloawt
	 CwA+h1R8C4uLIjLqrGjx6WqU8tIjPfcCQz4g36VSXYTiAJfAdzrhyU0UtJ8MZUtYd7y4L
	 UoAoP5sqUIsRSc+UbwwhR37erKJdjXGhW0E2S36CnGNE7XXFd+zcIk9t/cYb5n1xw+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUCQDUhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C24606A336;
	Thu,  5 Nov 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUCQDUhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370571F0093A;
	Thu,  5 Nov 2026 01:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843680;
	bh=+yWdo/0a0eeAHbSdljbrBqnn6cYdtPGmmMmAAboJx7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dUCQDUhFfb9P7WFHkpYMzO8gkEkc+rJaPwifdvkweNvN770sJ3VHe0aWwziDe1fzc
	 Ukl8+qmccWqW03Brjg/4yqe9OnMnSL7hlZQD4PCZA9t/CitoAimQGY3Yxr4i7tlynY
	 aODi3jTrp5mu5kOEYsL2sZn4+WeVZrrq4Cac/yxoDecq5xjT+lbUjsyNfF26XULgJ2
	 GJbSieS/zfyyXXSJJGxRPR8dKNH4RTfkAEzFl/3rqRjPyxNeZh0ti+qdBWUX+YEQ80
	 veKtX1ZZlzF1hmHK/vtmCWtfon9Ocsl/E4Mi068dk8YF9piYtpLHBS1yVIk13j5P6x
	 Njb6hyow1y85w==
Message-ID: <sashiko-outbox-198421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 5/7] vsock/virtio: support guest device
 network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-5-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-5-48179b9b66b8@meta.com>
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
- [Medium] vsock/virtio: virtio_transport_send_pkt() drops RST replies on n=
etns change
--

commit b8eab48b6f555e1cbf805a0b83f5c8f89bdd6029
Author: Bobby Eshleman <bobbyeshleman@meta.com>

vsock/virtio: support guest device network namespace

This commit adds network namespace assignment support to the guest
virtio-vsock driver, restricting reachability to the assigned namespace and
atomically checking reachability when inserting sockets into the connected
table.

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

> @@ -682,10 +697,15 @@ static void virtio_transport_rx_work(struct work_st=
ruct *work)
> =20
>  			virtio_transport_deliver_tap_pkt(skb);
> =20
> -			/* Force virtio-transport into global mode since it
> -			 * does not yet support local-mode namespacing.
> +			/* Only grab a reference if the net changes underneath
> +			 * us.
>  			 */
> -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> +			if (unlikely(!vsock_g2h_net_eq(net))) {
> +				put_net_track(net, &ns_tracker);
> +				net =3D vsock_g2h_net_get(&ns_tracker);
> +			}
> +
> +			virtio_transport_recv_pkt(t, skb, net);
>  		}
>  	} while (!virtqueue_enable_cb(vq));
> =20
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 1e762a480df49..7efcbdc7e04fc 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1468,8 +1468,8 @@ void virtio_transport_release(struct vsock_sock *vs=
k)
>  EXPORT_SYMBOL_GPL(virtio_transport_release);
> =20
>  static int
> -virtio_transport_recv_connecting(struct sock *sk,
> -				 struct sk_buff *skb)
> +virtio_transport_recv_connecting(struct sock *sk, struct sk_buff *skb,
> +				 struct virtio_transport *t, struct net *net)
>  {
>  	struct virtio_vsock_hdr *hdr =3D virtio_vsock_hdr(skb);
>  	struct vsock_sock *vsk =3D vsock_sk(sk);
> @@ -1478,9 +1478,14 @@ virtio_transport_recv_connecting(struct sock *sk,
> =20
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RESPONSE:
> -		sk->sk_state =3D TCP_ESTABLISHED;
> +		if (!vsock_maybe_set_connected(vsk)) {
> +			virtio_transport_reset_no_sock(t, skb, net);
> +			skerr =3D ECONNRESET;
> +			err =3D -ENETUNREACH;
> +			goto close;
> +		}
> +
>  		sk->sk_socket->state =3D SS_CONNECTED;
> -		vsock_insert_connected(vsk);
>  		sk->sk_state_change(sk);
>  		break;

[ ... ]

> @@ -1750,7 +1754,7 @@ virtio_transport_recv_listen(struct sock *sk, struc=
t sk_buff *skb,
>  	 */
>  	if (ret || vchild->transport !=3D &t->transport) {
>  		release_sock(child);
> -		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
> +		virtio_transport_reset_no_sock(t, skb, net);
>  		sock_put(child);
>  		return ret;
>  	}
> @@ -1758,7 +1762,13 @@ virtio_transport_recv_listen(struct sock *sk, stru=
ct sk_buff *skb,
>  	if (virtio_transport_space_update(child, skb))
>  		child->sk_write_space(child);
> =20
> -	vsock_insert_connected(vchild);
> +	if (!vsock_maybe_set_connected(vchild)) {
> +		release_sock(child);
> +		virtio_transport_reset_no_sock(t, skb, net);
> +		sock_put(child);
> +		return -ENETUNREACH;
> +	}

[Severity: Medium]
As reported by Stefano Garzarella on v4 [1], will the VIRTIO_VSOCK_OP_RST
replies sent by virtio_transport_reset_no_sock(t, skb, net) still get dropp=
ed
by virtio_transport_send_pkt() when a namespace assignment races with an
incoming packet?

In virtio_transport_rx_work(), net is snapshotted via vsock_g2h_net_get()
before calling virtio_transport_recv_pkt(t, skb, net). Inside
virtio_transport_recv_pkt(), the socket sk is looked up with
vsock_find_connected_socket_net() or vsock_find_bound_socket_net(), both of
which require vsock_net_check_mode(sock_net(sk), net) to be true.

Because a namespace's vsock mode is fixed after initialization, sock_net(sk)
(as well as sock_net(child) in virtio_transport_recv_listen()) and the
snapshot net passed to virtio_transport_recv_pkt() always have the same
reachability with respect to vsock_g2h_net.

If a concurrent vsock_g2h_net_assign() changes vsock_g2h_net to an
unreachable namespace after the socket lookup in virtio_transport_recv_pkt()
(for instance while acquiring lock_sock(sk) or setting up the child socket):

1. In virtio_transport_recv_connecting(), vsock_maybe_set_connected(vsk)
   returns false because sock_net(sk) is no longer reachable from the new
   vsock_g2h_net.
2. In virtio_transport_recv_listen(), vsock_assign_transport(vchild, vsk) or
   vsock_maybe_set_connected(vchild) fails for the same reason.
3. In virtio_transport_recv_pkt(), if vsock_g2h_reset_unreachable() swept sk
   before lock_sock(sk) completed, sock_flag(sk, SOCK_DONE) is set.

All of these paths call:

  virtio_transport_reset_no_sock(t, skb, net)
    -> t->send_pkt(reply, net)
      -> virtio_transport_send_pkt(reply, net)

However, net is still the pre-assignment namespace snapshot from
virtio_transport_rx_work(). When virtio_transport_send_pkt() checks
vsock_g2h_net_reachable(net) against the newly assigned vsock_g2h_net, it
evaluates to false, freeing the RST skb and returning -ENETUNREACH without
sending the reset to the peer.

Should virtio_transport_send_pkt() allow outgoing VIRTIO_VSOCK_OP_RST packe=
ts
(or should virtio_transport_reset_no_sock() bypass the net reachability
check) so the peer receives the reset when a handshake or connection races
with namespace assignment?

[1] https://lore.kernel.org/r/atjvzn-zPYJjLAhy@sgarzare-redhat

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D5
