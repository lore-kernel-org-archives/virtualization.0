Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854914;
	b=ILuIPsetIYuXWPBUM4FMvq1wZclGUoZIKqt9Mi1MS+5IzT1Yv7s9xtybgvQ6Dr7aLijO
	 CR+tvAl2E3Vm5GkzejJ3jPrZGvg8L8Kv4PCaxZslHHNaWwM9qAkTkNE0ybN8qbpAHbe2X
	 ypHJljf5J5jowaMZFLXkeGrcHUWX87w5+vQUyuVr2IC6cV46S98bT/+LsHNRrPedwAXIS
	 CX4MhRHUOjxvGvV3IXoRPevRby3J9bpVtwG+TKMFQGycJlKUbMEivy29GaiR4An88ARM9
	 PAEgmdNfy3jvdK4ypqM/aU/iLGNqy9jsH6623voYzv8STvf2yIN3yTALNUOxHB13xFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8yPgp/4vcwe0Pc2kI0sNiy3/cpGh5eQbCbGnwZCNH5Q=;
	b=U+JrIAr63jtZvMWC5vaO3uL+9ErQXl1CkMpgGvQ6a7VeM+eZm80xBT/qfNkfR0I0mtxu
	 gydfD6IntvetEBPAIpfydTvtH6e4wgvBSoKY7M40l9q1ZZhP1oFwMJk7SaVHfmet/kIMl
	 2AVLtHXef5dHwy4EnO/gCtbKhb5BrdjFKTFJrf1ADRXFrwFpT4AxKB8J+qtOwK2D1SP3B
	 3NeJZscYItSZpAO/vH7vANTdNrtumzpuGErcYnsJ0yCX+qr6IwkxTGeY4GfRf325l3Pip
	 kVJz6df0DOaJMX82NoEkbtJUaJ8nBwnbTbg0UlXF4WsDWIzpHhXutw/fJMa2sr3m+iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtkWGHxY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA8606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtkWGHxY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597EE1F00919;
	Thu,  5 Nov 2026 05:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854913;
	bh=8yPgp/4vcwe0Pc2kI0sNiy3/cpGh5eQbCbGnwZCNH5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mtkWGHxYgvhjZxGe19LFMcwINTWQzZqlGnIIyKAP8iqXV8VFJrHYeA2Z0/IMbhT8Y
	 zPzD5YqjjVw9sMS/ueGT8j03ieYfKVSxE+wyg77/Vzd7j/YisNcjCAPI0K5RXbGkOD
	 Fwaw3/FWWS3agbXlUaQjHoNroQtXm6IKFHIiYQE+gMVVqe6ec9sAngvNFxGcgx1U4n
	 aJWMZdmnAr5b6dxcnPC2f8GE+JjdC7ZUNtxHP37nbTjMaUby7YoR4sxTJmNiR5oEl+
	 z0+PPlgQqpG8MeGxv3+QzzXcqS+I7fFYGAsQemKaAf13dIya9Sxmhlj6gc6zjx2N4M
	 mby6037YxpGQg==
Message-ID: <sashiko-outbox-198574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/3] selftests: net: tuntap: fix UDP checksum
 length in build_udp_packet_csum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104050131.629967-3-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-3-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 05:01:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> build_udp_packet_csum() passes udph->len, which is in network byte
> order, as the number of bytes to checksum. On little-endian hosts this
> reads up to 64KB past the UDP header and computes a wrong checksum.
>=20
> Existing callers did not crash only because they use packet buffers
> of MAX_VNET_TUNNEL_PACKET_SZ bytes.
>=20
> Use ntohs(udph->len), as tap.c does in its own build_udp_packet().
>=20
> While at it, clear udph->check before summing instead of relying on
> the caller, and send 0xffff instead of a computed zero checksum, as
> the kernel does with CSUM_MANGLED_0.
>=20
> Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header fo=
r TUN/TAP testing")
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104050131.6299=
67-1-edumazet@kernel.org?part=3D2

