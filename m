Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563107;
	b=Vb1bJznSNMy23gjYKUHYLdPMVQrbFmoV/0VwqONBo9fK7LI/BGaOar2FKS4dTyarhHk7
	 X1mtV335IZOUgBAFC1a4z9XNlT3K1/2a/znWFyNM83kSz+tK0Mjwb7sAlgmj+Y3boU13U
	 X90p/xYBlrWxnCFFQOAe9mr2qz/ertSthMfnum4tAxZ1hICOMq/cSV6B0pNaLzTsuYpB4
	 I0RKBCjHkjj14ezm38ij5MLX+gg/gXoZ+mW/qx08vQzg10kI9liyVSlhUBxCI4ed2v/OB
	 0t8zgZDbA2hVPCom4hjfywtnyZjiI0BiLa/oivmhREmpvhVsP7H/RXCwpdiNBsGIK3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ahDTFNVKG+/XZfabY3ikUhmZ6rXxM2stpRTcz5GfjrI=;
	b=BJuayLLf3D3ha8Vf0XG27htB561n2XTvp2jBEbVEYvePX+EG+bMEjftAOlJmIuluQ+r/
	 BgpMNcfr48UL/rKVCAipcyiFZMy3MQZaVktyHhMQgqVBf7O1Rh5f5HfyLfG9Q1WxV7f5V
	 LcfBztHpl3EdCBVq6HdBcsznU/K1s6mcgZLKX6mBsauwVJzpKgSSIcw9ycwBa3lLQSo+n
	 sXXn60s6lni6u3DRMmazCuDWd7zUgZyH1h6GdT6xHrQ6grSx8GvYhcDpjsvsoqJI1trK9
	 zK7UX5Hb2qv6jyn6UhZOztE4SosSh5gglUaYGaVcWXLLS0zybnqlLa4Rcrn3AdlAfVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JH4BkEQZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62F606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JH4BkEQZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2001F000C4;
	Fri, 13 Nov 2026 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794563106;
	bh=ahDTFNVKG+/XZfabY3ikUhmZ6rXxM2stpRTcz5GfjrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JH4BkEQZZ6RF75JZz4yVJ2D/0x/S3RiHa8VGHGeOiOrOrt/5G4TLcgVGx/Tarb2Z4
	 NzT3VcXV2xpLxfDwNhKNx0jtfPzriaOghPFAtaQjifywxtTUP2orl69Jeq2I39NCGq
	 7TgKr2dqICDq/BUcweWg5qX8lssBxbhZ0hLiRBrYM7b4MAPBXzI+xK70+8ec451PnA
	 o2NIfL21PuzTyw/m5OQ7k5dTZMmrdvHSjs68WCni5EmjxEIAfHc6MCT2aNRq2yHUvR
	 uqpzws8R5E8kWBiFG2i0h20iIwMeURsuNr1d14A0D8bCPtk2h539WVwnF7gSlDQSzh
	 H/IjwMqDJ8i7g==
Message-ID: <sashiko-outbox-212562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 15/18] ALSA: virtio: reject invalid playback
 completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-15-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-15-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:45:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> A TX completion currently advances the hardware position even when the
> used length is malformed or the device reports an error. Validate the
> fixed status response before publishing progress. Retire the request
> once, latch XRUN and schedule error delivery while preparation is
> active. Keep malformed or failed transfers out of successful playback
> byte accounting.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D15

