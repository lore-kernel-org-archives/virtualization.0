Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854914;
	b=rf3i6BvgKNegm0PuaTvh4k66Y6Rgx7nd0/0WbZfft4Ok1VwOox/kDKCJLpQMk3PMXoYW
	 XoeB/kfzJei4vStuHrGJCL+QKevA4BBTJtu/Hqt5co7jeMyAInjR4P+hRFiwHdWdargNS
	 yjHUOi76eckHnKRuNjwlYxD5lJzfpFDIXpiN7zRKvN20pufWiInIVUZgwxw9RUAqAQ4Az
	 VD++TBCpisRpgJ83y11Grio98jJGSssmpQPYa37LOilSIA8mpwM8ps+b4qG6x+YwtHPYP
	 lGdKaB+R++suRWq97LOinHBd9bQJ+Oa6KwoBH2z6rCsNLUnO2EM/wsgpdJJUrbvzVpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vKZYX2T+imCKRxT6rO3qtsMudM/IWrsE0UqXLbo/qu4=;
	b=l02aqweLBEMVDXnP2yJMOIn6x8SWBqKJwPBwbFzMrT9N+VUyVWuI3x2En5opNpXPqFzb
	 rbV7/KC+ARmZLZfcwHRxq4sZAbY26BjcFju/eCjDmR7Sdy4XdQw57tp3AwhOibWliD81a
	 PJgkKcMS/41hqrnaPDAriLO2dfzpoF9nqx8p0eypcZ3nTe8s8fxcVd1oejbDIMUxWYe7g
	 KyUBdz7D/V7AUMFtCOkfVOYcAY9eF4As7b7y8yQmqoNnk/u9rL251AF56MVHve9fiKqQO
	 PHLTESKL0MiA/ur53S6MvNAp+bJrmXWN96pyh2d5YAmfejmpEHqnKEYocxcN1CvzCVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0ehVAnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915CF606A32C
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0ehVAnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CA41F000C1;
	Thu,  5 Nov 2026 05:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854914;
	bh=vKZYX2T+imCKRxT6rO3qtsMudM/IWrsE0UqXLbo/qu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g0ehVAnXLYJ+U3f06fcTnwCGJDqSi8u9UXsUJtjsZZ+7dt7RWjMG7WEunw0p+p8jb
	 JoCRSUzRLSzyiogvC/Dc0z6IC0lGb873Wnczo9zaB9HnmY3Dppwg8Au5BL3HRjSVV6
	 leGYBGLZjPYhbzqqHmQB9lDgJHJmKjce6goIpfmkWtFHlZWCr1PV3CzRiQ6fb0jh13
	 /d/ujTznLNxLhXY2Nsj1p+VD24yoLrMlZ8dNdNUQQp0lmGA/rpzMrWmFpvMQz+ADI2
	 cUBnUrcD8cy9wG6JjW2/b6NcrMlmekHv2A7DBd/R3E60mdE13eOYO/9bNpFIX6VS1h
	 bpA/O6Zbpc6KA==
Message-ID: <sashiko-outbox-198575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/3] selftests: net: tun: test outer protocol of
 UDP tunnel GSO packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104050131.629967-4-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-4-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 05:01:53 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add tests writing single 4in4 Geneve GSO frames to tun devices with
> UDP tunnel offloads enabled.
>=20
> tun_vnet_udptnl_proto uses a tap device:
>=20
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
>   tag) is rejected with EINVAL.
>=20
> tun_vnet_udptnl_proto_l3 uses an IFF_TUN device with a tun_pi header,
> so skb->protocol comes from userspace and there is no Ethernet header.
> The outer IPv4 header carries options, as virtio_net_hdr_tnl_to_skb()
> expects room for an Ethernet header before the outer transport header.
>=20
> - outer_proto_ok: tun_pi and the frame agree on IPv4, accepted.
> - outer_proto_bad: tun_pi claims IPv6, or the IP version of the frame
>   is not 4 while tun_pi claims IPv4: rejected with EINVAL.
>=20
> Without the first patch of this series, both outer_proto_bad tests fail
> because the kernel accepts the frames.
>=20
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104050131.6299=
67-1-edumazet@kernel.org?part=3D3

