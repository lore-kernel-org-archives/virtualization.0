Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760347;
	b=jeSsfgOWa/514yr7Zz9sKdAmq7ITR+1AbT4pyDwXpMTPzeHXJnvssqBz7SALlnrxzsIJ
	 U+9n+MkWiAs63hcfQ0cq3AB1c1F5Azg7AsuSPJSD4Dv0lBDaY2Yw/bO9+BmzvXLjXWR3k
	 3yXf2QTL+r0DsYdeXkIHfsU3Aq/cAwfGa497kCfgl9qoFiSke5B/ApfgvcixWeDPuKzd9
	 axyk+cad3E8lx/f2p42D0tpJ/LIp4rCnzucKFW5JS6lK14s//xgv2kDAvqix60zasxUZ7
	 fJtRWDV6t7KXroUP2ulIseluAF+4ZtNZFgsnmRlTdd6dX3BhoxN03/5Y9E2ZgmH6KdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mjy2cxoofy45BOE/JehXYlDV4tE/A7rdI5PsaDMdcYc=;
	b=Yud+7xu/2oOP2dNt6u6wsYZo60uFYMQo8J1zg891ShKXTWEGHEHBLwvrqzplTIxr0Aa2
	 f28IZS+sUxiyV1p0E+5HP/hhz3Dbm1NyzLEble7RMGK3ROh4+EtYc0JuWE1PTYxltpjkV
	 KaB0giqXuTvXGMyfPOJH/Ag5pZ5xw/CDAlfXkrGC5hd9keRzsxHuZP6MtlRrjCXg4OMfe
	 W9H4XPNGGBzXOLc9di4sIPu1bMKnp0IIOOOiFhXW8aKBubKyP+qXqrnJeAP0+u9Mav8J1
	 g1tZC/cybLgkBqmXMJT86f7+E23IuqGFKFX/lhmYuRCHGpWmR6JWUkv0BKcq9/AFZ9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkkjoqBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1457A606A31D
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkkjoqBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DFF1F031E1;
	Fri, 23 Oct 2026 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760346;
	bh=mjy2cxoofy45BOE/JehXYlDV4tE/A7rdI5PsaDMdcYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jkkjoqBmJ5dZzleJ3CMh9r8VTDdCdNxi6LXbtkVNuNxNkJHBadzU8cAXHXyV9tcNg
	 5Z3sXiMzLjr2dZ/t/GQgzY+jwyo5u1Ch8f+nQ+GW5NZbxpwQ1CRrP6xGXHU3rGN6As
	 JwdyIM/Sf6KKaRjRLqtduIvLjr6hN4Zp4//A5x/KIiBAgcEQAUXIi8ywONzsoh5Iur
	 MYm6mDSe04WPebBmza2dMGyW18HjLGvnMTvxM5/JNNbwkQegp+4XTK6UsLV6ujQUx9
	 X3XKuWZNB7IKnrzpoS+cOB5bK2/1j+WVaLUFmKZ0fiNOHBlcYTGZrjoPGnQ4Qsxjfd
	 BzNyjUAakvjhA==
Message-ID: <sashiko-outbox-182802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/7] virtio_net: parse tunnel csum_start
 little-endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <dfcede18b8d54519bf586b8e5099e89ec63bf014.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <dfcede18b8d54519bf586b8e5099e89ec63bf014.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:06 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> All tunnel related virtio features are > 32, so none of this
> functionality can be enabled on legacy mixed-endian device.
>=20
> Accordingly, all tunnel header fields, csum_start included, are
> little-endian.
>=20
> The nested virtio net header import parses csum_start that way, but the
> inner transport offset is parsed with the endianness specified by the
> interface.
>=20
> If tun is misconfigured to legacy big-endian mode while the tunnel
> features are enabled, the two parses of this field disagree, and the
> value stored in skb->inner_transport_header - which is only
> bounds-checked from below - can point past the end of the packet, where
> GSO segmentation later dereferences it.
>=20
> To fix, parse the field little-endian in both places.
>=20
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D3

