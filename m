Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824293;
	b=DyOWQzW/L9NxvDlrxKVORxD5z8gNXXpr1f2S9y6Hb3MYTBGjeYwpUPPl7JdXGigvPu3X
	 YeSyCBHRC4YMpCYwh3IpJTgCqPaJc71yn1PNWLgNhtsonTodmdqS9a6+w98hkFX1aXn0U
	 jvFhCACCWLyaQVrY+MiKcEwyVEM826ZUC/QIC/I8h1xzgn92zQe8lP+5TQhUWYIpJA6I7
	 Vw6ZfM9NUav5Fppcmog9kXWWewJCfcwJY9RYGzb157LzYNAvLfgKuY8HAiUVHpnb8wKuU
	 eGdTy8CBt+yrGQKalSm7SyUTXBssziz5GQ/85gC8ISdl3FmWc/ztODR4u+crmdVleHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HzectLEwg6SVq0XizgONNFPKbMsGlFL+pegfzfsgI9I=;
	b=KJoi9fhzJ5IXYvQvOceziAtTLVauOOQdJ75XSwamXp5L6iwLImPMQcQKifemiNvrmSDv
	 KdIuVNLX4gCXWRD1yRjfIkJDyYsnqAKJRdZUES7Y5Xh9vlC6Oe/98zMPFyqzOYnNtI82Q
	 G2RCe0ZR//L3i+Lw6dAVhyyQyIMQOaP1IgVcX0I51EDxi79GuCJkuAp+Hhy26psCuVVeu
	 PYHYvkQn1fGT7mCvBnpbTNtLuJhnULKCEPsggzzxrNOk2q/ai09Alg4s0cSG7GTMh5Ge8
	 QulKf1mGCdqEhMgtiTh2KV9PHhFlDj+FvSOQSGFIGpjPfx+RMV6MvcuWwqqba73ivBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IByVjCcX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7086082BED
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IByVjCcX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046771F00919;
	Wed,  4 Nov 2026 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824293;
	bh=HzectLEwg6SVq0XizgONNFPKbMsGlFL+pegfzfsgI9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IByVjCcXXm6FaqjvPAqb/u3QEsyZ/kOgubihjG7syKCHWgiUR1nVIMwOlEskIJrOE
	 Xknm7FwGsbXjhJwzOYDhchcNUGQvRjzSDRmbwO0m6YXpsvy9kl1neE3pCCCjbrFW0q
	 pH+31h/7uQKnUgSJgLl00KidvLCOMWQy5Tb9lXdJZ0rO3VMTOd6CJ26fowGdRua4Pv
	 B38dAL0ZGUI7hPSkSbc9K1R51DDJOawjtQAdL95pnk77GnHJu1WyeKarR9Zl2c8AWq
	 C5CvaSRdkGdlsUC8FK7sKl7UVN1BkVdmieLYoxTy5PofjRbsqhjzgSKLuziysJ5nId
	 uP1Dws3f9uOGw==
Message-ID: <sashiko-outbox-198017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/3] selftests: net: tuntap: fix UDP checksum length
 in build_udp_packet_csum()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103203113.550604-3-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-3-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:31:32 +0000
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
> Fixes: a942fcd72e97 ("selftest: tun: Introduce tuntap_helpers.h header fo=
r TUN/TAP testing")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103203113.5506=
04-1-edumazet@kernel.org?part=3D2

