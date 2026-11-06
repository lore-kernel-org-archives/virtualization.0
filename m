Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923339;
	b=DBTE7zhPcCsMv3SwM4sipxu+mccl8uxBZepz8RpNVeBv2b3qaztswlN+uyTcbNBFPWPo
	 PtLxtNSmEuSPpe2VpGirwBbNlJ9SBSVJ3GxudX6BXbbGIYOlswtZuj2G12rKlkZE/1Yk6
	 G0AQZXTl6hFEepMjtSO3cZEDqW1QZVSshFW6nSBhRSMOSYvC7bkwYJaQmqOE20j5+dGmh
	 vIP7pTQVtO0gHRtGpUX6BkLGXc7hiugXoajYmEQs8usy3TtBn7cnplp72XA2pQMGbejaU
	 xyFzlukr5XrKG1rQNErTy3hNGvmatYgCs0qHgugPYvg/LuniCNHqevjCBeEAu871lHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s8NyW5LhQsrIuxGrQrW+2hXkB5sJ5WWGtOEKG8kVHGs=;
	b=DEQr1FzJOhkaw2ZrsM0ONoE6VjvKUAKvKD0aTpZPzqFiveaXZwAIhrFGBhk/51nSOdJ7
	 KQGaHSMkjvhZ6bkREaYNnOCwlODtZnrKie8l+IlIHsD8gaNKvlOvn4eTDy6FGubWl8WOK
	 KEpfAXEO+mMkuADgZr4NU6SPJqQqHYuL/ZLUTCgafzUxuu/7nNQCXApA2flBX3+xKDCh+
	 4zZzfBzZ5dwekS9usc35yx/9Cw/tVQmHl3ZcQSqGDSxWwv8eRLgW0n8VtitH3N78g2/HQ
	 PogwQKMx84Tp4w80dND3Kc9bjjqFyUCivvibVGZzA+FH3oPGI+kzgTnbnBgdV4ej3VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMwp6dpW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD2606A328
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMwp6dpW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429D31F008A1;
	Fri,  6 Nov 2026 00:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923338;
	bh=s8NyW5LhQsrIuxGrQrW+2hXkB5sJ5WWGtOEKG8kVHGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMwp6dpWRehsbEVnIVyG2eit6RdeeVoZj23tMLuzBQ3lzKJsP9mkEaWkof5l3toTw
	 uB38ou3FjI7PpLv8vnzo8SnTnN0CEis0pOc3FJmi5DXHcKQzxYd6njVZjw6U0vd9tr
	 G4IXCs9LgHmQEtvUTuEenQNqfLCYvnlzxHzfcJluWDzxYAUws1VKysvgBOr0SjlwQM
	 6Of9hhKkg5mtSkEazWFUXnsfNcQtwsnS27UgZ6ruR01/REBoKeAzRuEVhKKyPmOXDO
	 R1VkNKXSGZZ9cvPFZktAxSN2ESAquC5HzjjWQqwKM/tfYJc0IF6M2U7uNJkONTcANM
	 MfzX8QMg1vIfA==
Message-ID: <sashiko-outbox-200420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/3] vsock/virtio: bound the send credit by bytes
 not yet consumed by the transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Drokin" <green@linuxhacker.ru>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000141.3617241-3-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
 <20261105000141.3617241-3-green@linuxhacker.ru>
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

> The send credit is
>=20
>     min(peer_buf_alloc, buf_alloc) - (tx_cnt - peer_fwd_cnt)
>=20
> where peer_fwd_cnt is taken unchecked from every header the peer sends.
> A peer that never consumes what it is sent but keeps reporting
> fwd_cnt =3D=3D tx_cnt gets unlimited credit: every send() is accepted and
> the skbs pile up in the transport's queue (on a host, vhost's
> send_pkt_queue, for a guest that posts no rx buffers). The skbs are
> GFP_KERNEL allocations charged to no memory cgroup. The peer learns
> tx_cnt easily when the host side relays a stream it also controls.
>=20
> Commit 8ee784fdf006 ("vsock/virtio: cap TX credit to local buffer size")
> bounded peer_buf_alloc, but not peer_fwd_cnt.
>=20
> [ ... ]
> (SIOCOUTQ 268304384, where the test stops); with this patch it stays at
> one window (SIOCOUTQ 262144).
>=20
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000141.3617=
241-1-green@linuxhacker.ru?part=3D2

