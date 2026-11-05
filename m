Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846585;
	b=TPu2IlXMZVlSPEZ/CwtZZ48VYxw0mZmOaObRGWXNLADiMCfZSd0g91s1x+LxmnmI9iR8
	 E8QmRq2WhRaz4PKxmd5VY+DARiZEf05KBUsJGVakMuRGF/xtc1MXMppHrUF3iw4VbBNXm
	 zvRqJ8lm+UW8UZCBNMO+J8LHR7f4Upg4yLl2bTkyefzptd248pYQoLlBTaARmmxytLJuw
	 zxAgCxVtBBGO6KxiFDNjmgM17OHGqV0FueaoaeX06dHXd8NrdRrQykuE3FulNAkoBJPOF
	 N8kiCvMph6EkHbA03F7Q9CVmSkzrylY7Qvp73nmvvCf4lI8EHj17kJwvuAd+ZReUtdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nB+cbeFcvV1VPjLTJvUa13LzE7+x/bs1qT0+9995eBI=;
	b=mI0EmBk9iX1JgYm//J3xiMCKMZzy+Vyn7bd9NWWPmP4vhk/2Y+SKRHru2evd+ilJ3S3r
	 Z6HwZD6qUd4ZlCzyVpHJgNsep+uev+FXz/VpAs5ZKZQ6hPLoh4f6LD6iKClGZZuAy+BHS
	 G/CDgJPl8o7kMN1FMnITLApLu+DJb+N8UHc5aCF+tLGbDWk4UOTiF1KOJXV3Qh+l6M0Yk
	 ppSSqaf6PVa/e/FYn1VACfQWSc5Cn+bZQzB17/jP644pDrVyOjR6j2Cefx9AWRR8xofLa
	 sTuNFpgYBoWZCjMePkQkNePrD3LgjP8EoZGFe3IpMqH3B3ayYgWTnlhMxF9oitcL+0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GSM/xhdg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC86606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSM/xhdg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726211F000C1;
	Thu,  5 Nov 2026 02:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846584;
	bh=nB+cbeFcvV1VPjLTJvUa13LzE7+x/bs1qT0+9995eBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSM/xhdgouc8BBLP2G3rzF5IP7v5PR8j2Huqc05WEI3CRzumcBJnIxiqMDZANqEXi
	 WrMtqRUfJzykm8f1NH0Lh3YKu/droWWDcV/2MJcvsTHlSau38b/lY/+LptPpUzYdjE
	 Mma+zlEkTkAVZEYpizK+qfTQr5aZnshvydnPga7OEMW5EeVk7Op+g0KSr4cFKhvcES
	 tNEmLCLoFdZsgXcwGoueuwz2DCHWr3pynrQ0u7seaUL2WXv2WMot5SMcxNxl0MwQcx
	 PNsLmCqwltTfiFjxTc2estScP7eKiBnPm8P/fIm33+U7LXvLr7ym/tLn/caNjQXvrJ
	 P6CV02/xwm8lg==
Message-ID: <sashiko-outbox-198474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/12] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-13-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:43:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Document the five opt-in virtio_snd capture module parameters. State
> that capture_allow_empty, capture_allow_short, capture_packed_status and
> capture_pause_restart require capture_staging, and use the ALSA kernel
> parameter restriction tag for each entry.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D12

