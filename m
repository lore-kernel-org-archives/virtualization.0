Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184005;
	b=iWvNqmTePdd0iXK/IRe5ZJMDeVWAlPNdBBFYIINEWI+ODdbj/T6QAkiadqLDvEcuCd4L
	 2nVT/zAbv438GxxQD1zNZl79H93QxPWkAOlFy/CTr+9ZK1XsXT1WxRuCx5ToJq0ZUpcuI
	 7pThIvtsFnDiSStreLVClGpF2LjXOo+N34P5J4SK3EUUEvzh+rzyX5hTmDxjQW7wwZhQW
	 ZLJ0YH2uBNmh8N+54NlUeDkOLde6nPYPGM5oJwWQIix+TcoLbgDL5g5lrIS75R8N7BEqM
	 9RcLx+A6cnF7pckgY4V1vyL3z0D34AfeIV4dzLETlbmg1pXx4pPT8a7zR7bo0FY49Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184005;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9TERZRBezZjipGxijNn0GodnAY86x0gFk9cD39jqcX8=;
	b=26sO4gQJ824xkbxcrloXXkKJvNz0r6pdRTplBhsMkmk7Mho/joamaj/33npIe274JjEy
	 i7e/Xsr6u+rxo4UCSrByaFGkCZAxHjHLyVSXAaooCSolZpirZWwi/pFkvolrob3istOVr
	 YXNQufXRyF6g5z1zUzQMMD5JKspbm5yJR8UEKO5DlFNzQGylyQso/EPN9U69W9tlN7yQJ
	 ppOJU4DuMikPSNeGYCdLSocDCx3G/9owIG39DNOON02vts/iMr3+1Tb4gNtfqLSVKkikU
	 uNo77js0HkkQQkev/0Sc53QyDqZBKF8MoigKfTOBr1OdLQiP2V+2kfiRLBUtuaY6KZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUvXoVVK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3301606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUvXoVVK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2225A1F0089F;
	Mon,  9 Nov 2026 00:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184004;
	bh=9TERZRBezZjipGxijNn0GodnAY86x0gFk9cD39jqcX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUvXoVVKXc99wKcOJm9Nhby60RIUHoLI7MQZTK92oAqeOzMdfdnRxYPW6WKN2cvdm
	 kKUdCL122JcIxmkNVLnzw/71CoeVgMmKV9GfmlaAcFhLnXDf6kmBvvdR/xxxBg1Fp+
	 g9P6m40oXUBjbnNAZOW0XCqK0mP0+ekN3pZqbeL71lRbpuocmhbGxZmt10PnCMbUQb
	 lnp2MUagY7wuPwBq5PBxCtAGkUwkgw+6yDwomitX5mCr4ZBHYJ2EQQ3N904Ks9aSPB
	 noTACbEMQAlUw68QohXr7ewNwQsN8XnClmSPwrjkaxcgFGM+6E1J9OrahibSZcaudO
	 DUBCmATgOuWhw==
Message-ID: <sashiko-outbox-204210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 07/12] ALSA: virtio: validate indirect capture
 appl_ptr accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-8-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:26:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Retain references to the pages backing ALSA's vmalloc buffer until its
> queued I/O messages are freed. On NOMMU systems, use driver-owned memory
> for DMA and copy playback data before submission and capture data after
> completion, so ALSA buffer release cannot invalidate an active request.
>=20
> Validate the PCM buffer and each period before building scatterlists.
> Require a successful full-period response for ordinary capture before
> advancing its pointer. Each descriptor targets a fixed ring slice, so a
> short response would expose the unwritten remainder as captured data.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> [ ... ]
>=20
> Retain PCM DMA pages and validate full fixed-slot completions. Account th=
e successfully seeded RX ring as full so completed capture data stays reser=
ved until appl_ptr consumes it.
>=20
> Bound ordinary indirect capture appl_ptr consumption to completed, unackn=
owledged capture bytes before invoking the indirect transfer helper. Reject=
 positive advances before RX ring seeding and reject frame deltas not align=
ed to runtime->min_align before byte conversion.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D7

