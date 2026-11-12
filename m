Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445835;
	b=hKgvF3r9YCuzHYdpQpi2bboa8gDvRZGRgqzUpV8fAOseeqTdAaP7eiKb4wZ3td3NuNqd
	 o1XNpk1Et+LWnniLPLPd7b82swOQ+dL0fpse4bE8PL/aUcL9AYGE6s+p5rjmgDpIaklef
	 14kpa+LSTeemOuPG+zE9UX3xyHYnGDKTIjt/PinsyZOf67qXOQnBrxQ+/HkkQEV8cCK3d
	 +4K9aStZR2aOIFZ2n0kIUBSJ6s4oYA+zPCPb60idUPwWq+vKcRWWb2En/TmGQf6Z55gnZ
	 dMYUh4eqk8+kOlZtAGXbhwOkiJQOpb82sArGD6oI9oJiP3ZoT7JHPZHwz45/iOoqBng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=23XeZiNIIpiUrWqTZI3oLi7tZDAUAGe24KSvnSfxh7w=;
	b=U9pfoefH64+heBaxaTSbykyoMKwdvI1cW3UWHgpj1igMuFK0hhOSoeT0S0RX1D/5uFj+
	 n++ebGgSQqpWHiyaFrYmZKzDde/OfCX2Qf77QOGIPXjhvH8FfwbV4YM3xC79PJrEhrP8W
	 bbcvZxrvDqLEok0QJEgDVNhWYeZVVWylYk9nvMTrAUU6gJ6Sb5L/MRCqfJ2tQLsd5NVQ5
	 iJVO+9q2Y098JRmPF22AgBDceWXrD9cgjVT8HC6k7/xXMyzB2YE9I6OY4W430vu54l9vs
	 nJi7DQVEBdn6OvDofYnI/ItoVonUKzq+mpTU+zYDaKeIRX0i2TnspHP59NLs2xWGDWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7FKUBlZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A98606A888
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y7FKUBlZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900D41F00A0C;
	Thu, 12 Nov 2026 01:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445834;
	bh=23XeZiNIIpiUrWqTZI3oLi7tZDAUAGe24KSvnSfxh7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y7FKUBlZNsct6dYgv7QvH+5N5p96cja+h/CBa976TCdIY1qFH62F+ZGDpI+SWmz4J
	 0mURh/r7GuFr0CjEhNlYJtJf4rkBVDHaqQ4fsqR60vAQm0lWvNcEJH6cnkVwekJrxb
	 7jr9c0C47+4V3vrqx13Adknf88Kd2eBsPgg+zChxsVzjyGBUEKtnlZV3+qFgtFikJ2
	 gJgqjzeWNzptnmXS8TW9hr0gdlirPMaIGUuhU963aW46FHANR08r7+0wTs8xOqnUwP
	 G+n4wCn00zikz0uDmpmJPwf/g2aGvMV4rCEfcpRKh+NIPesLMA+d18S5b3DxS7qE84
	 CX+43F9vhvAOQ==
Message-ID: <sashiko-outbox-210043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 03/17] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-4-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:10:34 +0000
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
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D3

