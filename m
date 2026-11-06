Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924070;
	b=tVuo0jxdxabg+YUikSutbAaUNOdY4EzOc8fRlEVlsf/nq8Cr7N3O9klKjMLKfRba+Lmf
	 DK1bGKp0NIpawZQ416tT4ud6nS34jUoMxfCHh0vtRSnp5JFL6SDcar8eYyXh5OelvfQnv
	 ZC5d5dc+liDDZzaOrFOwY0KYRKoP9PW63CJ1q0pmQjOYqJRw73VLTh0M4a8cGT1OeHWxO
	 m66X1i+5YswlPGLmuhm4KlAnJ270+Ec8TllWV6u+R5PCe4pNAvQkewQND9M/6z69SUJOX
	 t5/6OpURx08TcC7U3tmz8d8tUJ1COZge93B8ZiHHE8TFCgrs7sfdyr+6vu4ydugVpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eZwqzLPYhA5LhPMmLwpPR4+/0g3+UAni9ze8gtkZCTQ=;
	b=Z6qnxAsF/6gqjuAfkeFfxzblpS00Nd24Dj5jqe5uzN/R4LBKLKnFOcZyN21Kh/IhvToF
	 fSm6mhjYEgT51uvEHg89Z35S/HT5MY1Z1/d56eKXPXxZPYn0qRshJdZi42IhX/hnGC0oX
	 h9ExaY50Qy3mBcmyRBYjl6Z+1iIMlz1dpTlYc7JlXUjru7XWqicnesCA0qFMfIVT160HF
	 UG8+KziO7tYQ+cCrab/5r5p7Y5apQgl1+7JhOMqP23ifL1nF4r9YAnFC9WvwkfqyOVQyC
	 S15l6KwcUlOnBmvAkblUhiBWm8ByVTXZHjULSmBh4Dcxu6oD/zlfvR9lT269JvP/Oew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ek4RrqlD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189E606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ek4RrqlD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA5B1F0089F;
	Fri,  6 Nov 2026 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793924069;
	bh=eZwqzLPYhA5LhPMmLwpPR4+/0g3+UAni9ze8gtkZCTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ek4RrqlDtuZVBllwhXtlkmakqDBRoeqlcVqu4r0CgFhPH7dHNQnHLZaz2niR37hYn
	 Tnjdq2SKEsEMOtI9pjMuQVopwRuje7zhLuyNQLYtb2mFzwd5YC1fnEJs8SyS6IvRYO
	 4IL2Bik+ps2lQ6fBO7sdYwdQsP/6Zo+A966dH504gqU/VFgk9QiHeFR/TJlDjU0MBe
	 NeiMpdSwpnN7w5cPddLMhBbzcBD3VgCvSOBttjmcbKM9Kh2cOwO3M3qXa992Y6U9pK
	 FIi7u4bxlXInVrvHeE1CLyrS0YCb+7RnVyDOR3+CxLd06QgJgUvsHNRH1v4y5jGYGd
	 nUz6PkZRodlpQ==
Message-ID: <sashiko-outbox-200428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-4-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:14:28 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D3

