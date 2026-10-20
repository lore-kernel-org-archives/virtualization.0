Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497842;
	b=rgxvvEnZp49Jggdr6SI2E2VbEzwaD/NmV2/EhRJ0MaWyX66aHvkd+xxUxdgUvDw49vdI
	 eRBeY6IpY2sSdBj6DMxQWXHZNrYJtucWA0UJL2hRfOGqxrtlD/ljeGl/eFZqHvI1JsHlU
	 pyv+UHsO1saTFDOtdH9G5f5HCFm11WufsFiinYPAKNfd+JdstAAyu5uv8s4Ym02HgqmMM
	 +jmbvQCWPeh9/7BqPSyFHdYo0545hzuXuJ3vg87z9MXjyxoLzeJk40NdK7ZvIv3gwD55o
	 GKVEZXuRaV7SXv5AyrFLoSe1ayf74wWtW/zVT/mM1SN68zZzbP8arnnltlJ1PfAhcKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GsXWzsKzLO0kSE+rhbl4YyFjny/0QdDZrA6pX/9FvUQ=;
	b=SVllBu2f9i2A7ebAfYcyhi4dC84aoGcGgUrafcjXVR9Dx1KiewDjKc+hLSbP99/Uo777
	 u7YCpK9DxXg5Swj0YVffsG+VSswKI9O+pW3fH0GNRPeC4LxFh+U9E21vMS9j87XUIhB2W
	 aUCihcmXhE+R3GS0pFEd64aysxdUITKjI2Ne/r+qI74olP0UA29W0FagWqQx5l2crdcgI
	 6KNCi9bxRfGjB7NWc4tmZCs5DGtzGyxiglUZd3hxUFgGuSINkcxB8KXoBj0dZfbvJQCjl
	 M+72l4UogtNKUmwndNh9p9CHTDASx0SG4W1iTeY3yIliLuoJtVhiFFo0/C4byxuqMGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdhgKbEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6051606A322
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TdhgKbEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A0F1F000C5;
	Tue, 20 Oct 2026 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497841;
	bh=GsXWzsKzLO0kSE+rhbl4YyFjny/0QdDZrA6pX/9FvUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TdhgKbEQ+0k/WocBI/wb+oN7m8WxzHbcOb8M6TNvjyFf5iU+0qcEjiGOiCmAktppS
	 jYkQn+YPixuomSbeMMREpbbW82BUf5YUK2IMwCsWG2I9WinE85du5gd1LplUKKU6N9
	 +g5TUCwI11BU4rkcSdPwfmQCCaWK6jpHAYMUwg1sHK92iTO7Vn96c7Y+XxO7in3YtW
	 2MFpMIGFI80Sval3yI4UGqpqLZjP6NBz5YZtverEns1oDm/Hc/lEtRI1RGF5FCvmGL
	 u/uyorOepEIO4c2Hv9I46VQx/x/heJEhyBt8zHTiFhEl6vc05TTr9QGepOODtvm1df
	 fDYkmdYjdOmrg==
Message-ID: <sashiko-outbox-178920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/8] virtio_net: parse tunnel csum_start
 little-endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <fa2c17b9871d1d858cc9e109e1bfc61b3ffdbd69.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <fa2c17b9871d1d858cc9e109e1bfc61b3ffdbd69.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:04:00 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> <glm>
> The tunnel header format is only produced by standard-compliant
> devices, so all of its fields, csum_start included, are
> little-endian.  The nested virtio net header import already
> parsed csum_start that way, but the inner transport offset was
> parsed with the endianness specified by the interface.
>=20
> On an interface in legacy big-endian mode the two parses of the
> same field disagreed, and the value stored in
> skb->inner_transport_header - which is only bounds-checked from
> below - could point past the end of the packet, where GSO
> segmentation later dereferences it.
> </glm>
>=20
> Parse the field little-endian in both places.
>=20
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D4

