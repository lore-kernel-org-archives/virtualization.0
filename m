Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822126;
	b=ygsRXvY1uI39j/4xs35XVdmT2Oc4vMZiYkUdByTNo5tpQHm6WUVlTuDOti7+D3uYuKI+
	 01fgLBu0tzFJPh1MIMM8gz1DNpfbzxMfA5VhIwMpBYm9QfgBggU4MbfSRPD+m+dLz2zEa
	 IBUgA/JzW/LDfgQXoRnqYZJmK3Ed5F9BufQETXndA1/WgTelsYOkQkAAxarvkcCYPKXcc
	 NuUs+F5n0J8354Vn14FNZHnbR1poQDN/F1AommZuukGiMsBlxYuf7Fr1A50L5ImAp8gLv
	 rYQM3lPtfUjkFKEroJSyfnKAeLA2CRwB2gZFbSfR5WXIkzLPZ0X4qF95dUCYd3BXfXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8ZfjSarc28lVAkF2CB82kK62/MsMeeIueZyFdCa1ScY=;
	b=d9N/4tYvdZB2VhQUYxWBxoUiixK27xyQIjSnrjrQ6XstLWObnuN9DZog0PzNK5exQYHe
	 HH1Yos1ppRmSoP5r41f/Dg6nZDRXFOh1xQyMkXK6oy1HTPSFFBpe1zTbBXf6Tzr9zBhk8
	 J1giQNmDZ67VvI5Fa5rtfYR6iN4U2CZ0F3lwzThmfpwiKR6tbYQQmQNHqYXLlQpoXX1RT
	 TuSHVUz0L5nD7Lla4ajxgTK/qz/cDymI0sPElXGoBpD5jBhEmFgfbopBxSMUohKkreSbB
	 l2zSimQuBuzYfhRXK7Q3BYdEplWtW6wZVO+2MHIbXchd5Ah/3MLleTrjXVrvtUmgUyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SEu34H/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062F606A330
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEu34H/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E871F000C6;
	Mon, 16 Nov 2026 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822126;
	bh=8ZfjSarc28lVAkF2CB82kK62/MsMeeIueZyFdCa1ScY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEu34H/fM6fORX1i5o3omeuCM/ioSHgM5rJxorvJW9nlWLjqshnV1r7+ClUAOcDjF
	 3PFi32KBh+xjD63XPmWLxBPsASYVYyEsSITur8UGpEd7tOP45AQoZW7QufSADD/hkO
	 xYWoT6KmTLp+s3BBkr3LWPcaQ2uYlwkfoaE4yWdZFn82M2Rvhxq0UxX4Eh22cY6USf
	 FUIQR+qASHByQqfyhyhHR9qQFYWibvDpHldE6Tc56klbAqK9anWVZUxOUBqmRX12p+
	 PiesNRq9N3VMB+TJnV8go1uEfcR1KQJsyiYq9ECbUDvahV/ex1G0UvvtN7NoZG6Dnw
	 hcWY8ZCguqC1w==
Message-ID: <sashiko-outbox-216627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/4] virtio_net: zero the stats reply buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116092445.3391334-3-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
 <20261116092445.3391334-3-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:42:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtnet_get_hw_stats() allocates the reply buffer of the device
> statistics command with kmalloc(), and __virtnet_get_hw_stats() parses
> the whole buffer. When the device writes less than the buffer holds,
> stale heap bytes are reported as counters through ethtool -S and the
> per-queue netlink statistics.
>=20
> Allocate the buffer with kzalloc(), so that the counters the device
> didn't write are zeroed. An unwritten record header then has size 0, so
> reject it when walking on that header to avoid an infinite loop.
>=20
> The used length cannot replace the zeroing here, since the device can
> also report a larger value than it wrote.
>=20
> Claude Opus 5.5 was used to audit the driver and draft this patch. To
> reproduce, the virtio-net device in QEMU was modified to offer device
> statistics and to leave the counters of a receive record unwritten. On
> an unmodified kernel, ethtool -S reported kernel pointers as rx0
> counters. With this patch, the counters are zeroed, and a reply with
> missing records or a record of size 0 is rejected. The
> drivers/net/stats.py selftest passes when the device answers with
> well-formed records.
>=20
> Reported-by: Michael Bommarito <michael.bommarito@gmail.com>
> Link: https://lore.kernel.org/all/20260711150754.2918392-1-michael.bommar=
ito@gmail.com/
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.or=
g/
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116092445.3391=
334-1-lian@is.s.u-tokyo.ac.jp?part=3D2

