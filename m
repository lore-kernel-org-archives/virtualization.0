Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984804;
	b=idMkrKNw8GgDUoVV3Dm7SBOCEWVBxupjI0Oq3bhG8ANI6ksFvSaAuSrld1Dt6V4eUA1s
	 +I6m0Q54RGrUvgqkWIANBZC6YyoWterBOJuQBTJ0IL4NVFOUC9FUXmN3wF9R3x97IMVKj
	 zvBIHg1VfbZjkw0yrvJXu7BEYLzVas6B2fXXgoHXhLR2aXB3tjH280tYB8uDykiH6mRRe
	 DQicKzK0KMwaBNfXsgzkP8TrzbiwiLD6z+snyxSHKiJ3FUK31Pr+HW9+KcVw4Snko3XVs
	 dxEbjUT54NHDlR8PQQJFBscUwz8fbdMwsklCLX7HLYGR03uXONmqwcplg9P9jakgzoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S0nfDxGSU6qmU0jGKm52c9MdLeDuadQvfhhQaconSOo=;
	b=GsF3wju/ebIrfiX4g6mK6oUeh1yvbzdwPt69oyQ8P2UjevBKn9OuIUnAm4Zm/vpDy1lu
	 EXfxOvWTqGz4w8wLk+JiQCITx7qjcOAqiKHi3+CYBQh1DLvUe/0Qs2niwIzwNtFUVQVZu
	 drwnOsDXMlg93984qvexy8Pzg3k7MK8U78FhtB5pb/yfl5BSUXlxmtniK8VyakF2dU3To
	 R3hovExSXKczPIWs3v/GRhQB1wstAf5BUQ9V71/ixWLeSssatIEpXY4m36rOa4k5X9zRI
	 NsNA3RT2+yrn3uUFSPs/opUDulJn9OEFteZ3e6j3YXiTpRxSYCUxijWhJLmRddWHT6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnnREPlf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84845606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnnREPlf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0351F000C4;
	Wed, 18 Nov 2026 06:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794984804;
	bh=S0nfDxGSU6qmU0jGKm52c9MdLeDuadQvfhhQaconSOo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnnREPlfp/pPrEN4wtpJs3Cnb+PTb2l0BvTYd/xtbTujCV4MadUpiudik+Yf61TUa
	 DugLAEXvvON0+q8lJNzzh9Xp+1SCxtn7wer9fDOa0w9NQIgi0t0+45kmdFqso/rul/
	 3DLgqXnvBFTD2tqZ3GlPVn8svxgueN/LHh7v8XWRc9/+UpcDKNarkneJlO2/5I9xrr
	 knxozQ6ShqwNwxqrF/q2oyvcsnY/MSH8tlxFusSocHwqzTn304Y8Qs+XJU1jKDreg5
	 CPu+fiQgYzs8/CtMIkkRCfhFSa7XqmeQuIILlb3tkp4O7+CyH6j1/kL8cUCRKXHyYo
	 Z/LxfG5MVUvUg==
Message-ID: <sashiko-outbox-220277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] x86/vmware: Move high-bandwidth hypercalls out
 of line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <59bf54707b78e2a4d2072c1aff6bcf72cb35e6b2.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
 <59bf54707b78e2a4d2072c1aff6bcf72cb35e6b2.1794206170.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:53:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The high-bandwidth helpers contain inline assembly which temporarily uses
> %bp as a VMware ABI register. Keeping that assembly in vmware.h duplicates
> it in callers.
>=20
> Move both helpers to vmware.c and export them for the vmwgfx module.
> Preserve their unwind hints and remove the redundant caller-wide objtool
> annotations from vmwgfx.
>=20
> Preserve the argument sequence from commit e0e022004bbe ("x86/vmware:
> Fix i386 high-bandwidth hypercall arguments").
>=20
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794206170.gi=
t.zack.rusin@broadcom.com?part=3D1

