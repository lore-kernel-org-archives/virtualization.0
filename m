Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568823;
	b=0IrWMw1MhDAJ+XWOmypr/EdudFs49rhcqwCNZuedsEO/Nmv9dA+V/knntWlgnhBaejfn
	 ZCxsVGwLKpjD9QQRe8ddK3gSYQYu9380zrdi+9lSZo5aKGFJi2+Gd2WmoXtKT2ykMueoj
	 nf9oMR84ujuqoDC8etUncnzB2UAQdJAG10BayG5tZgArazdBuAsbHN19xG/YVk+J6tvQB
	 86iCGDDqAwOsalmFA3Jo3gLWilbrWOuC0WM/YWe5meA+ugPUHcic7QDKjUrncVtS/ypc9
	 Yfy7/VBUE9Ywsh2jw5VUky2q7V+FkQpPJWcsy1NQIzYevJwptps18CpDiA4MVujT+/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568823;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nVVajcRzPSdxVfqDR4XCuNuK4WHLL2Ysyvur0DS5B1U=;
	b=1Bd/tBa+0auea3FtS/SYQlwwt5RhBVAsG3NaaYn9E0g5FoLXA+6t1e+CxCWmH0E/LO55
	 BXRXmcVAtE1VRBvloZGmftLNv9zrJ/OlVo2IbT/cy6IZ163vEWEK+e7az6LqXaL8Kfh58
	 34kJNaFUd0CQprdLphMvlzieDI2wK/B3W/dxVa6bAoeJRx2Dapo2Oo6SJ5hMvjSNzXJaU
	 QmS676KS7o1UvBtV7a17gkPznirM8JHiuIXE4046LCl9RVFyjvwJzgpfvfxBYjLZBRKCY
	 87fmsldpAnCSOvQaX34jIvh63+p6m1uRXjXJRKHmwL/I/oa5T4F/VnAnUA0qXLd0sGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axsPdk9T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33830606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axsPdk9T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905E41F000C4;
	Fri, 13 Nov 2026 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568822;
	bh=nVVajcRzPSdxVfqDR4XCuNuK4WHLL2Ysyvur0DS5B1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=axsPdk9TPC50ITeEFPYTCBp7yZkcHGoPDIZS1cRlK+Y4Xo5rIY0eyL/Ib8y5R9g+M
	 32ra6vuLW39IsHyv6rueoOJTGBWtax+krekiPnn3gSPRPLY53AiQqFxMZyrcr3ExTP
	 wnwarMkKiGENMBQ4Wkk7EYJ8uBA3dZATfhdzP3H3PrWrNw79giIHA5QK78EjTkEM1n
	 +b1USCp+EtSCmjMQ7EjisXmA2JUmT/2mNX+WcHe3bU17nnBvNiM7Czeker3NuPI/8z
	 S9L9WOXlmgbtZkZPC04bmmy2dgsZs7MTX+VVDRzTCysmm0mz0HmqzUiwYjiTCLShqH
	 3c6Q7NNNp72rQ==
Message-ID: <sashiko-outbox-212701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 1/9] net: ethtool: tsconfig: allow hardware
 timestamping without a PHC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-1-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
 <20261112-v6-7-topic-virtio-net-ptp-v5-1-7ab67b572f4f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver can do hardware timestamping without a PTP hardware clock; its
> get_ts_info() then reports hardware timestamping with phc_index -1.
> ngbe and txgbe (libwx) do so when no PTP clock is registered, e.g. with
> CONFIG_PTP_1588_CLOCK=3Dn, and dpaa without a ptimer-handle.
>=20
> SIOCGHWTSTAMP and SIOCSHWTSTAMP work for such a device, but
> tsconfig_prepare_data() refuses it with -ENODEV:
>=20
>  - TSCONFIG_GET fails.
>  - TSCONFIG_SET passes the new config to ndo_hwtstamp_set() first and
>    fails only when building the reply, so user space gets an error
>    although the config was applied.
>  - In a dump only -EOPNOTSUPP is skipped; the error ends the dump, and
>    the devices after this one are not listed.
>=20
> The reply already leaves out ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER when
> the index is -1. Let tsconfig_prepare_data() take that path instead of
> failing.
>=20
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to g=
et/set hwtstamp config")
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-v6-7-topic=
-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de?part=3D1

