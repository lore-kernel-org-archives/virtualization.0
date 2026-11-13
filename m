Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552749;
	b=HpOnht4gM19XXN/1MfNd6DbIYswqxOBE2loHwPyBED78pF8VQzmvOEfnVPHJi5H4lORl
	 bzlkHEUCrZRgutZhkfNCwlVQ56ewRwKQCZhUhskN7vSOAewnaRNpJ22yLI0g8ADv5z7Qg
	 yEqzTJGquhh2yBgJuHVOyKEy54DeWZlHxaeVdmJ8tZ6YvZr4Riv+FQUu+w8SC9/8Ff1v7
	 T2YCEosjgFm6rKR8qyXFXY4j2uHf/vjAvzQwH32J/YskThMX6f3nLMkex345JTQXi7FTn
	 tVAnl3XOn9wI20Ud+IH8CdWJt9783nhWxFRCK90vr9qyQwFicoXlNH06oQKZWKCTVPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r1wpPRntbu11kgjFTUgoXiuHQrMvLNthaxo7iLzKRfQ=;
	b=dMW5pZLEdpzHHg5/8y0Nm1DOb6VaM5KwgB7TBPeHl8ySaRSLkHBP5aNcq6kNnMI5ji4G
	 n0DImZ72motvyp7WJ6oFg/RERzGqoGJI2Wz2xGVZRRYHT7f/eEdXri0UlEEJKlkJ+W8dx
	 fOFXfatgkLLUrOIrX5Fperi/5lrWFCMWEmicySOf49YQ5xEhXPC3k+4s4gt9dJWO5LKyN
	 dJEB0g6hV8UbAqi9OTz7TmoykCxwcwJ9yzw8lcfG/L8k2ryXVi6sFM+ilD9OpJ7BejfQA
	 y6iHaqolTwnhv77wDJNqdJR7HVpMpjQbUVP6CHaX5zIHRDH2XG4I2OZ2ji0MsFcwKzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fejDr7x2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8E606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fejDr7x2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0030D1F000C4;
	Fri, 13 Nov 2026 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552749;
	bh=r1wpPRntbu11kgjFTUgoXiuHQrMvLNthaxo7iLzKRfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fejDr7x21ilnPbsreBLByXKDdLcAEDFbLrMCbqKdU9jUSa6kRsq6ajvgC2B/Rz0zr
	 2etnh23rczKQBhXthG3oVuPdUkJ+aMr2wyIYODyT2fq29jTQTISwkyQfz94gZZDPj+
	 PW779Ifh3TiXQn0ZYtVtMKvlPvhjuuQrCF4KnF+bQnSaqhb3nMTZXKrpiNeTd77cjH
	 TIzxrVHTehFqU9T97S1M/cV4Bk16l94RlufLx4sXULvdNqN5O1+nDQixT4DXyVsZCb
	 /S3hfzHvMnH3pYS5ljvwhJbx4VcARdhMLVUlV5zk+SnyR/iITFvj6XztgKg2M00U70
	 6pImZSYXNfCrg==
Message-ID: <sashiko-outbox-212293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 14/20] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-14-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-14-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:52:28 +0000
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
> Document request-owned capture in the ALSA configuration guide. Describe
> `capture_packed_status` as default-off, reading a packed trailer after
> returned data while the fixed status scatterlist remains the default.
> Describe default-off `capture_pause_restart`: pause uses STOP and
> RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
> START while retaining the prepared stream.
>=20
> Note that on MMU systems request buffers are vmalloc-backed and
> page-rounded individually. They remain allocated from hw_params through
> hw_free, and capture data is copied into the ALSA ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D14

