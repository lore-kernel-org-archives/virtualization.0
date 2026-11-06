Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953004;
	b=rrWVSb+oKQwv8ZbSP54xBorM6KLmbiF1g345q5Odql3bai9GuOJIo+7aDIxXSqXv/LZE
	 boXdjn6BuKuWJ3iRsUtS/qy1i00YVPvJY9N6+2yxjdI0r+syKmxRR8uGMToX8tH3rcW63
	 K96zwEPruRJbrNkWreTRP9wb1Yt0Yj7vLEzvthyoZP7Xhx4A4BfYWgpoCRJ1suE9eLvMV
	 ddgmtfHNg1n4GoGCP7EXu4KHja7Z6DMZ3zesjMMg0mfsc8EQlC+vaHPpNWoAJoAgE6owA
	 iIxETYt1UM+/0e6B0fK4crVVeO+Yqa2IBm09zgp3NaBMOMo+eqXKOPUkJ/zejgJ9TsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l1ItVHn5z88MlPKrDIbSUtbpz8/qcxAo2Wi1/8tmnNA=;
	b=3FW+FacuWXfEa7fbaItGg9YwDdPDrhDuh6mf4R9fXpHoFrzo8bGVdF2VOVUl5Y+9UwGR
	 G1PpjkJM1nGGZXoI3JoQLtV92AUCu/QSZk+amEye8s8mvAdDvVRkOzDIkpUOQdQbnQVjb
	 AWao1QCiL+k6xGzNoNMxJoC8TWUCoQEqgBt9dkpXZU1YrY7kEX4nUT443beTR+5yQHgoJ
	 6hZy1+4sptv1xPxNTSHE1trnmoUH/kHxBGxYKm03rUfdn4BJiyfp8MNoEVZJsH4Zx6zif
	 r5ZrNPbrfRAkS2cWNLiBavawWVae5tQiy6Vwv11jZgyjkQcjmtDN5nM39qZ4dA+uOEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojOhpJSG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A639606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojOhpJSG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932921F008A2;
	Fri,  6 Nov 2026 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953003;
	bh=l1ItVHn5z88MlPKrDIbSUtbpz8/qcxAo2Wi1/8tmnNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ojOhpJSGdM0IOKhvn2/TbPShVXFHP9LkjueGkN1+oCRJDOx0KWikVKsoBMDR5rskX
	 RJ8WQmwj43R2o+vzvb7T0NHVCjc3eMMQYX88L55TXvzb7ht4PAh7mCDHAqZRwgmrzA
	 VggbXcgBRQOVFk2NkdFIeGx5lTbFcUDcTpbEU7+DVmETIJEYWuMzienXNwDjUjt7HY
	 0u+ULGbIV5YHO4vq3Tconp9gBhEdIrsi/Vnb6dmOZizCxFQ5p6nqBXuEyX11108GN0
	 YuVFIH13Iko51oCaLd9Pp2r0LNoYdgUJT/5Gk4MEp/al6Lwa2yRNbiUcIpSqTlbWr7
	 PUb58VLkF0XLg==
Message-ID: <sashiko-outbox-201043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 6/8] selftests: net: tun: test UDP tunnel GSO on
 retyped devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-7-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-7-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use TUNSETLINK to make the device type disagree with the tun/tap
> framing, and check that the outer headers of UDP tunnel GSO frames are
> still validated according to the framing:
>=20
> - tun_vnet_udptnl_proto.outer_proto_link_type: tap device set to
>   ARPHRD_NONE. Frames with an NSH outer ethertype, with or without a
>   VLAN tag, are rejected. A valid outer IPv4 frame is accepted.
> - tun_vnet_udptnl_proto_l3.outer_proto_link_type: IFF_TUN device set
>   to ARPHRD_ETHER. An Ethernet frame behind the tun_pi header is
>   rejected.
>=20
> Without the patch "net: virtio: do not use dev->type to find the outer
> L3 header", the frames expected to be rejected are accepted.
>=20
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D6

