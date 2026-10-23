Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743271;
	b=4zDh85HEk7UqRGFoVUHjEJ7cxVdug+O5ClHm3lFJbN366JlL+iP8/91oSk4gfmSTWOIc
	 vT3QL42S/NythNiSlY5qEfhV0PbP+uM5Ht7OHHHZaIjrDTDbpPz3TBMHcEd3STWsXaTu5
	 YX5eVxJ+lavdfFqy7PilZGgg7SJCCDA1A5pEVXin5ZBfQ5AZ18EBaHD/WxWfCBqD3OU93
	 +8rQxzDwYvFk8SyXKMZeMb8SGDpEynJIA9rLXPBZufarEKWEnjmgwe+s8Lwed68vKvm6O
	 m35G0GSj4hKb8RESEOdMxgDp2NU+kPXEDw4Qlke1o6udDaQ44ng+k3T/B1CflNDZoeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vuNYS0wacWTObShiKj1AgYD8JaJX53+xF+RT+LGKSCc=;
	b=SKfzhPDHQvngCwBIvkQdR+awcfPJ6nLmsJErYY4N8DlTpuUmxgRm6sagBhPk5oZvh3h9
	 u8C+ZpCJzdN/2AlWfRTfb1fXL72wh6g1Zt0h054AQGZSq2qBpIFSo6NQMiIuIk1xqkGGm
	 yEWBQNTXFQiZ96Vg2CSdEioLI6dWdw1KqJdhYT+rRq4OeWld0slWxPbRyrcG/3ro+hzRu
	 i9g9y4FwiKnhAa5em0TiDgHPganwcUhUyF0Uojuw2TwdNFNjP4jDlnWEzO+VJwcuDJCZs
	 zewohcU5HtpzkiZfnkQzfQ5PeKU4a83DpJzaXId5AC42W3vnJovxDIGI9rSGRm2i+ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfxhPUbl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD3606A322
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfxhPUbl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004C11F01828;
	Fri, 23 Oct 2026 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743271;
	bh=vuNYS0wacWTObShiKj1AgYD8JaJX53+xF+RT+LGKSCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WfxhPUblBIsG9jSV55vUfGIt6ks9im0Ni7HQUJMYJFDtyjbCIVpulPVSsc/YGtghb
	 phntymb1hA8LUl2qXKi6Jr5kOL47IvN7a3WHzeubi/eSC192tVBUhrU0llIUwfdHgp
	 SMhzbVjHXLxJdTFQ+oJsQMhmOu5TSrIX7RFIWMeyG49lCgpkVb0SEukfZ4/IlUChEa
	 7Z+ZPuevnXNDHmCxjp9h9/MSxxAVHpTtLMLCl/DZsmRyTgxYmxr14zTZlJSteY9G3z
	 f+FlYMN9bb3cPisNDVNjb5f74gbMmt3fHN3KMRadqLOZkC2rka8yZPPo8fdvHilOAf
	 8D4GAAoFUXfMQ==
Message-ID: <sashiko-outbox-182491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/5] vsock/virtio: amortize RX socket
 locking for stream packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023075140.9613-4-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
 <20261023075140.9613-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:14:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The virtio-vsock RX worker looks up a socket and takes its lock for every
> packet. Retain the connected lookup reference and socket lock across a
> bounded run of STREAM/RW packets for one established native socket.
>=20
> Reuse the locked socket while packets match the same flow. Finish the
> batch on a malformed packet, flow change, non-RW traffic, or a change to
> the socket state, transport, protocol, sockmap state, or receive buffer
> limits. A connected lookup miss falls back to the existing receive path,
> which can still find a bound socket.
>=20
> Limit an uninterrupted socket-lock ownership interval to 64 packets and
> 64 KiB of payload. The payload limit is one
> VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Small or zero-length packets still incur
> per-packet work, so an independent packet limit is needed. The 64-packet
> limit uses VHOST_NET_BATCH as a reference; it is a policy choice rather
> [ ... ]
>   8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
>   16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
>   64K         1.385     1.358  -1.96% [-10.61%, +7.53%]
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023075140.9613=
-1-physicalmtea@gmail.com?part=3D3

