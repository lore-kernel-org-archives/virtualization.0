Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256771;
	b=DwZz50x6jHsPDl67Y9LI20xuLC2PZycrvaOYn78dvgxBGcq34U7U+1g5bzUhdj9zCqsu
	 WC6MiOjemfeyY4d2S0QWGuQH27nHP8TFgHTK8EjzKAzGOM2YvQbnU3e1ZL2Jo8kwoWDdr
	 Mn+uyF2evVJ5d4TFlrLKN7Vf1RaTEDQZoMNv+3S5THDxqu63sjGQCtz1mjV8q66nPwI0e
	 OT0zLSK2GP3GSzzhIzBgHaBvaVxtmE6Wg63RLdeE5TaI3LB7OQjw53lnhQQWJVbaVjiVR
	 RpK1Y5sg8ddS3XSDjH3hkFscH0y6UowAk5eXmM7sa7QHPYhW2gauCgHHgiliWCE7xOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XUjGEGHnrUXG7hPPXuftOOwmzqQ8dbOSkEiXoYBf/BY=;
	b=BRxU1EedxF5EUIdcGZYlRNn5akR7usTOe6d4Cn2Z0h4JILW8VD0t5+30vAol36AN3sMD
	 XpndrC8/k7nI4UHeYJbYdqIm+22UIAzEB1l6l2c2ubjMYLWKoAUQ7bwPf9fcE2D9irJXb
	 WdXARTO8mT0r0f/X8xlIri4cErZNw8h8ZkNSI2iSJwaLDdk8xZCGirIEi+eMzxv/98su9
	 mdnHiThJLp2qQzv3RDb40b7iRDy35IEz8zJrgvEgFlwUhlQI2zvYWuMBWeR2lxSMZyM/Y
	 GBXaa/aRbA4SzymJ54Kk9cJsKknK2N38rHHmxRWobLAj3ewRhn/OKULjK4AerTVvSdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3EyVbaq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEA606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3EyVbaq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5822F1F01825;
	Thu, 29 Oct 2026 06:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793256770;
	bh=XUjGEGHnrUXG7hPPXuftOOwmzqQ8dbOSkEiXoYBf/BY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3EyVbaqCpjV//RuIe0rDIHOpOPu/Iin+l4ASi9/71EpSqVYIGIa6SeeZgRBB+nnT
	 OVZckszpVlWL/ztFfJKent5pGhVBkgXVvAUhMOPsGMi/BgmCY83CIA6fiO/jls+FMW
	 q9N5EVtx8sIpKJufN4vzO/UJZGFe8oNQZpFmoBAwi80jaY/nJ5OA8xCLol+k1JQZb/
	 gmXSvhk4xkK/33O60M56Xqe+ynUySAy1YK9FkmCF6frYmFKfrBBV+cPsLBllOXoBWY
	 ECVwf2bGtN+dQ4V9NnZ73ILL8H/0Fyfj0gtC0+44v4xewx8LskMmxYeBWlY3xNnp2+
	 PYp8Cd/K5ylvw==
Message-ID: <sashiko-outbox-188830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net] vsock: make local-transport CIDs conflict on
 the same port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiran Qiu" <eritque-arcus@ikuyo.dev>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028065231.655701-1-eritque-arcus@ikuyo.dev>
References: <20261028065231.655701-1-eritque-arcus@ikuyo.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:52:49 +0000
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
- [Medium] vsock: incomplete local CID alias check in vsock_local_alias_cid=
()
--

commit 5d164f9e8d6139f39bfbdee4f02c52a0bdbf7d5a
Author: Yiran Qiu <eritque-arcus@ikuyo.dev>

vsock: make local-transport CIDs conflict on the same port

This commit updates __vsock_find_bound_socket_net() during connectible
socket bind() so that binding to a port on VMADDR_CID_LOCAL conflicts
with binding to the same port on the local alias CID.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index d0508887a2fba..47fd00fdac6d8 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -294,8 +294,31 @@ static void __vsock_remove_connected(struct vsock_so=
ck *vsk)
>  	sock_put(&vsk->sk);
>  }
> =20
> +/*
> + * CIDs served by the local transport are aliases of one another on the =
wire:
> + * an outgoing packet uses transport->get_local_cid() as its source CID,=
 no
> + * matter which of those CIDs the socket was bound to.  Two binds of the=
 same
> + * port on different local CIDs therefore reach the same peer and must
> + * conflict, just like a VMADDR_CID_ANY bind conflicts with any CID.
> + *
> + * @local_cid is the second local CID (the guest->host transport's own C=
ID, or
> + * VMADDR_CID_HOST when there is no guest->host transport), or
> + * VMADDR_CID_ANY when the local transport is not loaded.
> + */
> +static bool vsock_addr_aliases_local(const struct sockaddr_vm *a,
> +				     const struct sockaddr_vm *b,
> +				     u32 local_cid)
> +{
> +	return local_cid !=3D VMADDR_CID_ANY &&
> +	       a->svm_port =3D=3D b->svm_port &&
> +	       a->svm_cid !=3D b->svm_cid &&
> +	       (a->svm_cid =3D=3D VMADDR_CID_LOCAL || a->svm_cid =3D=3D local_c=
id) &&
> +	       (b->svm_cid =3D=3D VMADDR_CID_LOCAL || b->svm_cid =3D=3D local_c=
id);
> +}

[ ... ]

> @@ -727,6 +754,27 @@ static u32 vsock_registered_transport_cid(const stru=
ct vsock_transport **transpo
>  	return cid;
>  }
> =20
> +/*
> + * Return the CID that the local transport aliases with VMADDR_CID_LOCAL=
, or
> + * VMADDR_CID_ANY when the local transport is not loaded or has no secon=
d CID.
> + * Must be called before taking vsock_table_lock.
> + */
> +static u32 vsock_local_alias_cid(void)
> +{
> +	u32 cid =3D VMADDR_CID_ANY;
> +
> +	mutex_lock(&vsock_register_mutex);
> +	if (transport_local) {
> +		if (transport_g2h)
> +			cid =3D transport_g2h->get_local_cid();
> +		else
> +			cid =3D VMADDR_CID_HOST;
> +	}
> +	mutex_unlock(&vsock_register_mutex);
> +
> +	return cid;
> +}

[Severity: Medium]
Can two sockets still bind to the same port on different CIDs that end up
using transport_local and colliding on the wire when VMADDR_CID_HOST is
bound alongside VMADDR_CID_LOCAL or the guest CID?

First, in vsock_local_alias_cid(), if a guest-to-host transport driver is
registered (for example, virtio_transport built-in or loaded on a host
where no virtio-vsock guest device is present), transport_g2h is non-NULL,
and transport_g2h->get_local_cid() returns VMADDR_CID_ANY:

net/vmw_vsock/virtio_transport.c:virtio_transport_get_local_cid() {
	rcu_read_lock();
	vsock =3D rcu_dereference(the_virtio_vsock);
	if (!vsock) {
		ret =3D VMADDR_CID_ANY;
		goto out_rcu;
	}
    ...
}

Because vsock_local_alias_cid() only checks whether transport_g2h is
non-NULL rather than whether get_local_cid() returned VMADDR_CID_ANY, it
returns VMADDR_CID_ANY instead of falling back to VMADDR_CID_HOST. When
transport_h2g and transport_local are also loaded on that host,
__vsock_bind() -> vsock_find_cid() allows binding to both VMADDR_CID_HOST
and VMADDR_CID_LOCAL, while vsock_addr_aliases_local() sees
local_cid =3D=3D VMADDR_CID_ANY and skips the conflict check completely.

Second, if both transport_g2h (with a valid guest CID) and transport_h2g
are registered alongside transport_local, vsock_find_cid() allows
__vsock_bind() to bind sockets to all three CIDs:

net/vmw_vsock/af_vsock.c:vsock_find_cid() {
	if (cid =3D=3D vsock_registered_transport_cid(&transport_g2h))
		return true;

	if (transport_h2g && cid =3D=3D VMADDR_CID_HOST)
		return true;

	if (transport_local && cid =3D=3D VMADDR_CID_LOCAL)
		return true;

	return false;
}

However, vsock_local_alias_cid() only returns the single G2H CID and
vsock_addr_aliases_local() only checks VMADDR_CID_LOCAL against that single
local_cid. A socket can therefore still bind to (VMADDR_CID_HOST, port)
while another socket is bound to (VMADDR_CID_LOCAL, port) or
(guest_cid, port).

When the socket bound to (VMADDR_CID_HOST, port) connects to
VMADDR_CID_LOCAL (or guest_cid), vsock_connect() -> vsock_assign_transport()
selects transport_local based only on remote_cid:

net/vmw_vsock/af_vsock.c:vsock_assign_transport() {
	case SOCK_STREAM:
	case SOCK_SEQPACKET:
		if (vsock_use_local_transport(remote_cid))
			new_transport =3D transport_local;
    ...
}

And virtio_transport_send_pkt_info() then sends packets with source CID
VMADDR_CID_LOCAL and vsk->local_addr.svm_port, hitting the same port
collision on the loopback wire.

Should vsock_addr_aliases_local() treat all locally bindable CIDs (where
vsock_find_cid() is true) as conflicting with each other whenever
transport_local is registered, or at least fall back when
transport_g2h->get_local_cid() returns VMADDR_CID_ANY?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028065231.6557=
01-1-eritque-arcus@ikuyo.dev?part=3D1
