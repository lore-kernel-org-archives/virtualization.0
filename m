Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020215;
	b=oyFG13Vwc0+M4kdDGxUg+kzmgNyIzpCuBMU2FQuEKc71j6FXfhuu4+2RaQkwONikFFGg
	 MQ46mWXtY2o8PZfQ7glCB9/UlyIKpGoacrrnrOEj9hXJEdgM0bwBf+7ZF6ki3bEWPTwHI
	 fnptWtLX0Z26C9Zhm+5armcnMUKHBHsU3cidxdsWITqGu9kygme2hQgOS/MAfIHZpFqQl
	 oZH4j5JwmsM4LQXnH+RscoPHQMMqpgQkxJv5G9kINbZAUtCz2W7/BH0EK2Svsh+ioc+JN
	 iF1itQZ0gqZ5MSPYQqE/kBl781sx9Y2Cp4k2uBG+KNiM/aktCgyXJA37Lo3mRA9dxGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/AKQu0OvSkP8LfoHKteKjTp5CuUDpaEuSew3cU9pLtU=;
	b=G8G35S8zuLV9FJkDOYDy5L3iBWIxBBTWRMHag5vXPPy9BuUIn7gemJuzemy+GCZSqDUr
	 NjV13imYdyhRMRbicHkWR6p4f8gO6adiugjaZCGJ/wItfXPk6j87K7l/DhsW4QxYYxiqg
	 Te4tBSzcZiC49ki86T5dct42FBlhJN68Hvoh71nDezDU/2MeQBFsAHPhT1qoCaiHyHZd1
	 xpuS4PMghVWzwyuPBRGjbPy2tyocU6bwberh5pSgeLbq7epQzHbmAn0BWn0+/5Ld7JN6+
	 KK6nFSClvrQCjjK6dRsNwwv0A0uY2ufNj9QL9D329cSFb5OqHCDEz2NJDZfUEqAtUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C9NGjW/J";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28301606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9NGjW/J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EED1F01828;
	Mon, 26 Oct 2026 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020214;
	bh=/AKQu0OvSkP8LfoHKteKjTp5CuUDpaEuSew3cU9pLtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9NGjW/Jhf0p8lbv/L30u960jg9uyIR+B4z0rDCMFNdxxmQ+Jy2KZ8mcTjpOo2o/j
	 FaDl/JaPdB5Sf8M2v8j1AW1XoFxECvcI4G52H21L4FF6VRk6uzE/4jg/Nh4Uv1UFlQ
	 tkcVSDmzTlv75jmGMq3pqKEQrzGsgX2JeXTGB0XK49u+IKtKSW0hLRglC6w/SyFmOa
	 L/PH3upJOMV2OojnsqpoFLCI16oWiAvjw2pTxPGtweTlIBJwArdIkEdlf+hrZ4Cvqk
	 hxPA8pCfaMGaruir/9RnJoMrITm2X5ZhHLwZUomAqB/TGMsRujdz12bv6ld0hUvbIf
	 MZ2T8QjxZLqQw==
Message-ID: <sashiko-outbox-185273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] x86/msr: Remove rdmsr_safe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026130223.773129-4-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
 <20261026130223.773129-4-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:10:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> rdmsr_safe() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026130223.7731=
29-1-jgross@suse.com?part=3D3

