Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824294;
	b=klmZbbS7UWEpzP3ZbKBxV3t0iwFPyH6IOH6amWmFKhnhCA7pJn2oY6rqsN/8WMFI0Ybo
	 kBVCziUiQYgy9o9xBqZndmyoQh/AR1ZCPUqt9ldtnfHvNo8301/fqwzrldG4BZhNafaTI
	 8j6nlMRErM7+bNoUuXow11ARy6/yRyejPTmjX1V8q1pKFWgw8FFCf73QJ0EKiHeCRhm6v
	 JVtLDzDBPMXhgTmRB97EoMjs16SaiuakDqqpOsF0RSTVyVXsGT/sveIDjV/Ba1rZ9TMhP
	 eQUQtdQ8ZLwuPgBlVe5Pl4PHvZKtibtbEQXkws1gD4CVSq+BBIebpF7RPvJ8+Yiz1tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824294;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p9w7on9dO8QkADV1WYwJb/4XgC96QCVgsN/Luqsowqc=;
	b=BxVWBFrhgWpcsMC+RxsWPx05d+GcdC0yvUj44J7ATD4dLcUXT6XFV77aTp7rJ5BSMu/+
	 X7P2r9M7gWcIj9o22wDCdoz3vjg59Z4e4zw45qpkrhxYE4W/xjSug+wFSSJKHtHSwvdzB
	 ybiX4IAafxio4BTO/JzNmF+6b1ZG1rw+XoSyW3qswuur3AGKS7OBLXzru/yk+RELaEXQW
	 OMk+UtYfD0Ilb03B7uwFuFcAhLhV3pg9Xfl7tR5JZVPhmXP2S3QQN94csV0xMx4iXOOXw
	 eogyflPS9Gx4FYYdp6uzVbcIsKf8qOk/HiGkCeYu1ajqVV2+QQk8TutOeI61jbuYLGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvCYE9W6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534676082BF6
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvCYE9W6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EF21F0093A;
	Wed,  4 Nov 2026 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824293;
	bh=p9w7on9dO8QkADV1WYwJb/4XgC96QCVgsN/Luqsowqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvCYE9W6JTbmXkmAyArD0UcQVGsasMSDQCqy6LEYkNiWXmfOduFNls6ugmb+7jWiV
	 wkLvuRq52SH0E5E+bqzGzOAzNfFZASa2tccCm7iE32CBKGd7FnHUIQvG7Jab3sxwD2
	 nmvT7NSHh6/eomoV99n8vT+F287OTRvSDkmj2E8+QkqJqR4GvnPBrkQx/04ujrwYsn
	 7BMbp82f7SgdusWYjkvBdN/ffx70LC3P/BSD0bPXwN96ejgx6HW1JqCJgY7iD3FjEK
	 Y8a5QC1kk0xOTEtWLo3hSVF/z9+tNiWQr6ERG2rnXQnVZ0S2GE9EX1PGNqYkPP/NdL
	 2ytnMGLnTQkiQ==
Message-ID: <sashiko-outbox-198018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/3] selftests: net: tun: test outer protocol of UDP
 tunnel GSO packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103203113.550604-4-edumazet@kernel.org>
References: <20261103203113.550604-1-edumazet@kernel.org>
 <20261103203113.550604-4-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 20:31:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add a tun_vnet_udptnl_proto fixture writing single 4in4 Geneve GSO
> frames to a tap device with UDP tunnel offloads enabled:
>=20
> - outer_proto_ok: an outer IPv4 header, with or without an 802.1Q tag,
>   is accepted.
> - outer_proto_bad: an outer ethertype that does not match the declared
>   tunnel type (IPv6 on an IPv4 tunnel, or NSH, with or without a VLAN
>   tag) is rejected with EINVAL.
>=20
> Without the previous virtio_net patch, outer_proto_bad fails because
> the kernel accepts the frames.
>=20
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103203113.5506=
04-1-edumazet@kernel.org?part=3D3

