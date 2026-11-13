Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568826;
	b=koaXaAevncZ0SKwlKUw1HezcsP6PongriEvu5uPyVhbMS1OR9tDOcGyr6u66vyo3eaSW
	 71RHjEtNNKBqzVmJhwGDe9Oto28x8yWGdOM35zuCVuLa8i0vrMWx8ReqWRkk1SOAVulYf
	 CqZwyDp6A9MYf5UeqCdo5zkVWZ1NS9A7Mq3ksSW3rCqtTIHJ1959EzYWo22VQZ9uHrNxz
	 y0NOh7NJ7HH6XSfOJ0Gxuf3w8FR3XWq//mA5ks1gcP4qqqRCQK7Ix5dkuAdBlzELYoYC9
	 RiS6Ru5sbNCZNPCowfwrS8l2oXpwjGZWMAcuwfKlwOPL0ERg8j08X9Av4rQZdgFw77w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568826;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TPs5DsEvapc/YwbtLkbcWwdq9G05c71A/OkB3HsZByo=;
	b=L0HemiQ5NshQ/gmT9yT3BjEbOxL90x8AH9W8xUh42cKZIZnvcIvT1udQuOiVUvn2wcxK
	 8JvBWERvRbbnZf/XMqCjNEUDb3F0ZDYQhmtHpPwnRTCFbvCQVqTLkBsuM+YQAZttRkhYM
	 QvaiZXXF6wVrJN5KoISxKfB7qXdUvntfoHyW0Cgjf2BESPACVH1TUFe3h3Up4Z86GYbbX
	 gg2+gLKIY5aZLVWR7ypEEihXy56Y446mrcVJdPJsuHvnjoJtB8seYdTptoLYRft5LBeoF
	 3lNrTyNI09A1AoYHFF2WM4fEPjZ64f2kaml8eO5D84gPIsT7/ozEqTWRhQafMfB/JHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aecwro1u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA5606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aecwro1u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0418B1F000C4;
	Fri, 13 Nov 2026 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568826;
	bh=TPs5DsEvapc/YwbtLkbcWwdq9G05c71A/OkB3HsZByo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aecwro1uzT79ak3gw5lNGsmKryio0L0w7vhKpsuOjowZMjIofT9uoWMw+w7/ofHqh
	 6IE2y5zaQURCv8+OLxVFxPI1pqZlUYQ3mEVd+YeuGjGyQS+6x71lv3ORXptoXim26K
	 tEPTerEEmH/jmlIaO60fgtNxkQktMoHcpNm77EvP+JsyK15pjWLqBqRgNWVskcXvNi
	 uo4mmNB06JG3sGIE0M3L3xAsSCRfIiTMfbF1o2NLyapS8OnJzkP2i04dr9wTSM3Fgd
	 vNO9d/xZMASFyY41wTMeUZs8kIn0h/o7rdJ7v6fjHrfnYNt3dQJVU69O0q6iXTm5R+
	 3WoAHM4+w5DtQ==
Message-ID: <sashiko-outbox-212704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 4/9] virtio-net: move virtio_net_common_hdr
 to virtio_net.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-4-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-4-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> tun and vhost need to know the layout and size of the virtio-net
> header as the driver uses it, e.g. to fill in fields behind
> virtio_net_hdr_v1_hash_tunnel. Move struct virtio_net_common_hdr to
> the kernel-internal header that they include already.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D4

