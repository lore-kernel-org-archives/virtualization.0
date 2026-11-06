Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923338;
	b=GVSdh5bA+bhTKabuIpuukJ3dnELaBTkHI7IsHeSNos464975EJlRdTlAXYOJnWY+42KR
	 QzIgflL4oXJm6ka77hxMIT6Nz62nPmE9JW5kWAOypJCyFLPxs8+YqtBbRn3ZIfNkO/RKF
	 z7tGFfNbuoj96xp2YrlLQUBsXcq84geZpYCZxbHrKbjGVEg5an2c+gcrdNLksKbpG+PJL
	 bfWdtWvqXNijJxWgLtDGomYU0bU2md6pmD2xM3bIjjiQQ8+PHOMIRBm/JyGTvjdcPth8x
	 cajVTUwfaxTU2GhlM9/yPAQ1HJgGmQ2zl+BRbYBY3ax3GE3MSVMvokE3oGQN0R+Z4lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z++6mrdU4ZT+gZqj+OJdyBM+V/WsuQKO201L/9pOO+M=;
	b=cVVqL84TCxpTUHElMqBDhA1z9MPW7mBYMfNhjgRWWRFkpZdK3mmZcj4l0mEzQN2zu9YR
	 KGHgkmiZi07mCDjXvS85PAONdNgLmkz2EKYxtHpO7vdeP/g/Z/O7dV+EoQ8eM1vkWeHS0
	 p0FRddpzYRg6A8CH02pg3DAhwU3aooZ3PRrWXTWkaFcLi+6KLgFotU6uujEfCfusJBV5h
	 pQK+CIpfRbTTOhFwLwHXHmobhMq6PdtfNEWUT9LKSF+ETYp6gxtiYAlGmiN8zW/RaIxZY
	 QWtqviIaOr7McAOUODc+tBqFOcQouGTNEPw1Gf+WpKOfmTh0QYtmK7L/k6ezx0WcvKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFcIZ7Qz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33912606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NFcIZ7Qz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9038D1F0089F;
	Fri,  6 Nov 2026 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923337;
	bh=z++6mrdU4ZT+gZqj+OJdyBM+V/WsuQKO201L/9pOO+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFcIZ7Qz7i2rv4L4zjBlztkAQO28kLi66CD7t/3B4Owr5JnMruQSXg0O9fLbQkSPv
	 HvgLzhfB7scsEXIac8973JcUafdyagafOWLjHryPrgRCp2SN+b02cAOu3R5YXmUlyL
	 Nw1j/njFFRBqAmAKYvBPuXCs6icOKuUmpwIexOXU44IuluzcObW3G2z/Xhc9FD6kv4
	 FKK+sTBMqC4Jq4uVr7dNZoX9MkbFw3Ygcl3dIYikUhSKaWH6r6+D8faCNR87D0YOHN
	 /jzgO5avfVmS0pDh2okl406en2ZDCMxH3YGGeWt+6lJM5NxeUCAr6cEmxrOfaMrKe2
	 dfFk1HZJT+20A==
Message-ID: <sashiko-outbox-200419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/3] vhost/vsock: release the accounting of packets
 dropped on rx errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Drokin" <green@linuxhacker.ru>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000141.3617241-2-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
 <20261105000141.3617241-2-green@linuxhacker.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:02:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> When vhost_transport_do_send_pkt() fails to deliver a packet to the guest
> (unexpected output buffers, a buffer smaller than the header, a fault
> while copying the header or the payload) it frees the skb with
> kfree_skb() and gives up. The success path does more:
> virtio_transport_consume_skb_sent() subtracts the payload from the
> socket's bytes_unsent (SIOCOUTQ), and for a reply the queued_replies
> counter is decremented, restarting the guest's tx queue once it drops
> below the ring size.
>=20
> The error paths skip both. Every such drop leaves SIOCOUTQ too high for
> the life of the socket, and every dropped reply permanently takes one
> slot of the queued_replies budget, so that after a ring's worth of them
> vhost stops processing the guest's tx queue for good.
>=20
> Release both on the error paths, as the success path does.
>=20
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Fixes: e6ab45005772 ("vsock/virtio: add SIOCOUTQ support for all virtio b=
ased transports")
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000141.3617=
241-1-green@linuxhacker.ru?part=3D1

