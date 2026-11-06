Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982959;
	b=npW2A8DE9mPndWsE6PgTKkCM5U9QnGwHcb0BCeSJiX6nQw4+KXCx01aF36olVC9YwPiO
	 hLjl2A1tshqACFajDwoL2rwbrBvcuPFh4GtJKONTCo74pBbaiSc5Yf1QMTDyBDcrM3FXO
	 NeYwulmFr3SOrxttpIlYtXuPdbwM7vLmNlbPRV+Ogy+++8IVRlipJb3ss5HlQfGgMNq1c
	 njJLNDIY/GAXh91UhzHBYcAxNeuAqXrwemCzbNmaOl3LfEQi1BhBNAXXO1qB6uvOQKJbi
	 3XsQu1PEYW+lbY377O0aVOTMbvikMWcyLMqW/OuxoFt+cr2eZXxOpiUuKMHM41fz5AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lYbnsei6PcAUgqtn4irfG4QQrjrN1uv7XChPED3jKYE=;
	b=hfXVmJu4R3mn3iZaNqBMNcCPNIKxAFIiTscJGst302QMfCnZCF1Anw4TSNz4P2/MNvr3
	 bHSZ2HNh15EQauPmJrg/BXbqdQei6D86bctb+X+w6ZFrdyWiiI3vFbYxu1Z9oFYGYhJRl
	 x/hL7T+i2xV+0FkQRKQvLMieD0qgtS9F41ghU2C29/Yo86lR1xR6r4J47QZ7vi/0LBdLw
	 xhouRzqHa0nXlkOlorW05BYBLULAw3d4j2o4jyQsb8xwrgMAfixHhe0pVKwOiuiaQOu5z
	 k0Dp4ZC7iUuiJUhJVbRZ6UQiBbXVYiz/xyNcma17oqU2yV3idts3ST5khNLShJSPkug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWvqIhD5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FE606A335
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWvqIhD5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741D21F008A1;
	Fri,  6 Nov 2026 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982958;
	bh=lYbnsei6PcAUgqtn4irfG4QQrjrN1uv7XChPED3jKYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWvqIhD5jLTy5a+N46PatHrDvD1K419NlDKH1CM2mJr4etXW9r2LpGvyN1kzUzo5v
	 Wa2FiJpDyVgUhJt5FRDB/hCBnIXKYz6Ti0e/irfHLp3maiUBqLFTGIwt67LCBXf4CJ
	 XKVLqPlNdhV5pBovXh4r4z8mnWhqdZH7lm4kVIe3eoZ0P3Hg53DKGEZABZXQpDjq1F
	 5XLc6La+CWQFgz6Ne2cmad1hvYIDiE0tPFETO/FGE3ufLd+vFZj1uUxO161iuFrAmt
	 FgaFjPs5wLmTv4Fv5LsET2XS9XLWJTBzlGD/EkiQsxE91hjE/stwpH4mY8OuO0FCbx
	 7qpIR/OU2oP5g==
Message-ID: <sashiko-outbox-201831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-4-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:35:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> the existing post_action policy. Applications must recover the group
> after partial failure before relying on shared positions.
>=20
> This adds an internal kernel operation and no userspace ioctl or layout.
> Out-of-tree modules using snd_pcm_ops need to be rebuilt.
>=20
> Complete appl_ptr rebasing once in the callback path. A later linked
> member can sleep in prepare while the earlier member accepts SYNC_PTR; a
> subsequent unlocked post_prepare assignment would overwrite that
> acknowledgment. Keep explicit RESET playback silence processing and
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D3

