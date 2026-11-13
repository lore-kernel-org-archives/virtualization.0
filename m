Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552615;
	b=S6jptSkR7O5kwczEKUWksXrFOucfvVRu6EHZ3qHc3jJiKNDrWm9R+eqKDf8sFCOz3ldU
	 cOMC+7ru6ZD6WUySRaMCHYE0o3Hzy2GkzUApYZNxnSm2gMtOpccPgoXU+Y8CinLVtXH0Q
	 NQrFqa0VPdXkrM5rCyitORp2JNpRghjBXrtc0ZyAUjcF9Ca71HpfxjaGkNVttPqv9NUaV
	 EcgxdYx0UGdxZsbjhUVh7bmhlnWyUEx7qbmA2IMaFw4ACagIgZYuCWQZgRi5xtaWRa82K
	 qqCMDJZAkxoYJvJYlHk6bt/vx0EUjO8cziCArLwtU6RdYjjQtdzPYv16hom7/NkMZMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552615;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BgbOcLubiRuZM03xbjLp1oGYVAWJ+Ge9KDkzEsS9BPk=;
	b=DHOvvW6tz8N6pKAN6Qd4hPYh0uGG2oLapWcLaFYs3BqwVDd6jIqhuBUaZNZTGuK7FgOG
	 uNbWC68dWM57+4j/uAgXFbKwj3jZqhQLsdkfy09lf4+qLrhuUIs75XIswoDRJJx4gbgIA
	 HwsVxNHDVlwwQ4F9jUcH8qFpjsscM2EbHQGnqhWTIqLCZnLxfiaXvNwmgS1siKh1I2ciU
	 Cm1Yx44ftEU5UN2xSxBrCmL8nePQSCEXz9wa+uqwKZvsKt6mMTfSb5sjWEkixGRVP26jJ
	 x4i5yRNibzW3nnpb77KC9wlcWxNTXI3iGYJWggX2mWhRPZbqRMsOn2MFKItWvDLcQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmUAsiei;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57203606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WmUAsiei
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89581F000C4;
	Fri, 13 Nov 2026 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552615;
	bh=BgbOcLubiRuZM03xbjLp1oGYVAWJ+Ge9KDkzEsS9BPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WmUAsieiBZXpEZkATGcQ4VxdUcUvU0WpR/akyb+uAXTPFNVFt2fbmshXPgTFNSnTM
	 zsZr3XOPGFWZ/RomfHXwNbvy7LiT7/k+bcnNVPRZj1xyDJb2tuuXFgv+CA26PNHZPl
	 pWokPeGVO1FPaENdG07onq7EeHTkadcEh1jh4rFFsSoejxQ3L7w6pJshSpx4UeTKXl
	 nf5RBIqLJr4FZlJjZ/K0Qw6m4loxcPCUnP+7izWAzvBabTjqXLqwzh6uvxdK+sA4gT
	 K8p/w1dkykxWEtqSETEe57bHKdQy7N2onM9Yqpiv10GjVNYuWDaGDwkNJ7bHTpd+Xx
	 dw6KKwxDHlj5g==
Message-ID: <sashiko-outbox-212289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 13/20] ALSA: virtio: prioritize capture period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-13-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-13-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:50:14 +0000
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
> Use system_highpri_wq for capture progress notifications. Capture now
> always uses request-owned storage. Playback keeps the ordinary
> workqueue. This preserves the priority proposal separately from recovery
> and accounting. It provides no hard real-time guarantee and cannot
> prevent reader overruns.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D13

