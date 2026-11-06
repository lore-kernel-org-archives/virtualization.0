Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953003;
	b=UxE6ZEiHMhuo/wKdJFfURVJH7J4FVtEF0Vo/Wo5ww1dHK4skyGx2pqg3GO6CfrsTz0gX
	 PMs6RBgPoSltLuYqgGQiZiHmY9G/JE9uC4rZXJ7hiawSXlJiEGAvSU2T2ZzpcPV19VJNv
	 5rXmtiusIPAqKrLO2VLWrknj4oXF3TgNQYqFy9cyngkoG+B0fdVIBXbTiW+7DJmIfgBhO
	 W+QHUuG2obIFne5TxFnjXWq/6afBuJTPqsKYlZjA3LlEAgbbd3BIfg3a6mlaWEW/dbs0H
	 QeZZSbEbLVMNwvB1fBXkzbWh11PKM2FEVJNOzpIPex4RRLI4hDiEu/NeDZKHqBfl9JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RL068GFq46c4tl1jaLaS5lew4PSd7um6LzUZCQ/R30k=;
	b=x6VqndGjC+5veF/y+GF4wVDGT1y9ChkwRW43hAxeulr6Caz86fAYHY7eL1+6NM7j0O8l
	 UKLAXPV6jU69tfG8aay3Yj2bqZ2UbaODW1T3gfGEkYVO3TlVftl+QJccKoUUmSxQ4aEqD
	 uX6y/sQzqbel5tjDvJSB7N57aU/gTz+9ASM/26nSdCHuPbBy6FhxaPwme+KRenRJa7wRM
	 8aHQoIuTj5raDqyl2n3tAr2IMDGjh4AfATW9f6UiLTSomfjz+S9EwIHLW9QMSBA2lhh4M
	 3qqDHYhNvX5YXJ0t8YA4YIXCxuYCeAT+eVkFXEUtiUDluGSKezoYcUxJyASFD8pqeew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiIcGzVL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB69606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YiIcGzVL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330BF1F0089F;
	Fri,  6 Nov 2026 08:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953002;
	bh=RL068GFq46c4tl1jaLaS5lew4PSd7um6LzUZCQ/R30k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YiIcGzVLBIZmVGNK2dvgYC4lBIJgyf4H9ZDi51A8dlvN2ZF/q0wJr50cel2QEWM/O
	 a+fZ2B3SHiciOyrOFC1ODKIgGeLU0QAcyddjIxz2mkhIt7aYXYh7D6yREeBgmZSTq8
	 vo8fWJU+/1uywO5Em5owNsDbsCKxdD/j/asSvbUMl4KRaHUm/T4BrumDwImFqLjMwD
	 xwt9/dP0Jc1gTox5r+nZa1H1H+WAq18AbNOIElwoP8IScuPTDN7QJz9Lxm8iIIm71r
	 DOv1rtHXsN5Iei9O0pBmR+36bJO0nY1ssKYTkDya4zJmo/wgWqC/351TxplG8gkW4D
	 pOuiTdFxK+zgg==
Message-ID: <sashiko-outbox-201041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/8] selftests: net: tuntap: fix UDP checksum
 length in build_udp_packet_csum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105115715.1466924-5-edumazet@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-5-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:16:41 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105115715.1466=
924-1-edumazet@kernel.org?part=3D4

