Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822127;
	b=smN+vt5pslVmOIaElvEnEyDfeaMJbYE+gtM78AWzhehRd1eEVZcG1fKq0Q9urrK5Fb0+
	 XKOdUquNXlBmhuihbkBh+7mQH1lNev040j5f7Lk7ftAhApBQ4uAICJMYDHsaCEK+lY6WW
	 5rOZH04pt0qVAcX8FUVya20zbI6SQAEqJXHCt75/Xv2KApSu69Pmq2OE9Er8JbccmjhUe
	 DhywmTeHlTfMPZiXuMeRDfgnoblAq3rDVr/wQOk79TkUr8eqLzGCXj9CrHuFbSgb3cov+
	 DmIUSYJ8nV8sgSE/Ee+M337/zqQ9FZt2YH9ht32dlVUPbdxNENg2Pj9f94Pa4xonXXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vnh6G5Yfn57SaUfEBtDtRvivnfCTGMWK0Y2kV5W3Xn0=;
	b=fffgxHiTAET5qxK3puBX+qi8iwEwoK8tdfdFpqkMe3fXB/ijsZvXt4mv5zMpUP/H96rj
	 ib88oPhZtebVdg5DhYjqe16cyj56J6174na5E9KU995m6GOIp9pVX6YWE/6fgVDckNqR6
	 R3P1vBWvdhB1lX+7xavuloKk3ijF1+mXLtGUHUN4L6M0wUUXB2igsrbCVcfuaGtvIxXdY
	 scJqk05SSqSuEGAWpiSbPoj3t3Gakcar5asQsd3mAahjbgLMyjrZF+3CENXuksnKo4mGP
	 t8/Ib4FpOW1yODUD2jhiPu8WFCm4SR5uT5ZE2An+CLqJCOTjmD2A+3itG2478AIa3+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXZMoL6j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04C606A32A
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXZMoL6j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2E11F000C4;
	Mon, 16 Nov 2026 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822126;
	bh=vnh6G5Yfn57SaUfEBtDtRvivnfCTGMWK0Y2kV5W3Xn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXZMoL6jmsn1wOGZd2KmLoVnDOFWvekvhULmQQ0scJMEygGQIqQTAQbnnRHcPkfDB
	 rzLcLoMTA31onbmtXpGGvRFhZ19Kci6EifRztVu+qkFIpxPWj3j26J2iecu7AKq1bJ
	 TUEGyoSNJkA/1gvlY2Gc8kUTNY4eTS5Q5dGCcGReGHQxyrtLkHEb+PrzDDNIa7y73t
	 ZTEtvDZ15UKSq4gMf9mUSAUhRc1hPV6uD3LmLnnrlSHbgKJogRBwop5lJZZAAiiC3j
	 K/QwuQQa7WzSYYoVSCozEPAOcEAxo2DAnRTvX8nXBhWVg8X11WOq4cPXK6ldZwYYlh
	 cX1DV5n2HSetw==
Message-ID: <sashiko-outbox-216628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 3/4] virtio_net: keep reads of stats records
 within the reply buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116092445.3391334-4-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
 <20261116092445.3391334-4-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:42:06 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> __virtnet_get_hw_stats() only checks that each record of the statistics
> reply starts within the reply buffer, while virtnet_fill_stats() reads
> the whole payload of the record's type, so a record near the end of the
> buffer can make the driver read past it and report the heap bytes
> through ethtool -S and the per-queue netlink statistics.
>=20
> Fix this by reserving zeroed space of the largest ctx->size[] after the
> reply, so the buffer can hold any type of payload.
>=20
> Records of an unexpected size are still parsed, since every record
> starts within the reply and cannot cause out-of-bounds reads, and
> rejecting them with checks per type was judged costly to maintain [1].
>=20
> Claude Opus 5.5 was used to audit the driver and draft this patch. To
> reproduce, the virtio-net device in QEMU was modified to offer device
> [ ... ]
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.or=
g/
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116092445.3391=
334-1-lian@is.s.u-tokyo.ac.jp?part=3D3

