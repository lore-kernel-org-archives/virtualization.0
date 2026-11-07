Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063229;
	b=itTrc2C2VL6MyTcccblP2K7VPLBxVUxMQ2MK46yVVDbCsR0v7eKG9dgUtIeYfDAanzIq
	 dGbjTK0bTZJdKj5R2xnBcmoI8BpNJ1f4/uxGc1vo9ZyCO0s8WB8P5tXtmFPSwDJG0VDJW
	 hDGclg1VGQS6vmzrjckr+bR2okteZV0zzuyZhRRZL08NnECxPQj5IUb/s3aXgU2UGBpY5
	 r9vfRI3Jy2Gpbq+S/xFaId35uAamATfg5kZKE5yTLahbPnqt/beCEKV11+ITOxRvgRjTJ
	 pwWJi/PgBBBbT2RCeJOYhUbq5juHd020wr3Gp6lbIkUEIZYjt116ujjmt5q2X0870lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C3vGdE+QgqSuKM+AlBPCPRiYprDg/6E6EI6alZ1kK5g=;
	b=k3nY4/NucRe09K9n5SZpPxJG0xzixiZFWA+3lIKpEpu9bABkj58i8iytFmVtUdfOdljX
	 YqK61nKDt3DwipcbMbrjSPQr0NfhYa6lSqWzU3dTy0vW/b4zqmXGneuHUgC3MyYisDfS6
	 dzLdCilqFEbL1l+0dYPFKKSw5evhKzhnpU97jjfSH0rJRwRUB9URiu0+OFkVjkP+ijC1c
	 2N2yHphrUH+zuT9wd2w3jYVMRFXZrONDwqKyNwvTD5R6An9DPuP+/z9lOUWeM7qsAznuQ
	 qP+zqx4vKZUUpookJtYvPLkrvQjIBY0ee/ng0rzqwdmjFFZlxSAtNG+G1UUsrwyg+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCev8tC4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6ED606D827
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YCev8tC4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B661F008A4;
	Sat,  7 Nov 2026 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063229;
	bh=C3vGdE+QgqSuKM+AlBPCPRiYprDg/6E6EI6alZ1kK5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCev8tC41A+orCCB7rLSHHZZSOpnR1BEhsbGNDLsxr34a8xyGFnIrwEgeveJT7BrH
	 UfNP7kW9+s73B9txY/IiZmChQ+mQOgOzOOsLZjGoaRdPNG+PCLjuFNlbD2KA6Pa6Nt
	 6Ur0F1YD4Uo92xMJhgjcVZZK192u8YRT6CzkJlOjPmpsFWWVBtFRienrhg9D8R0QQD
	 DLIz8yRpWSv2YNITvX6wGVZqEAz26NSr33hdBsKmuLH7876Vs66X1G+TNael1mvfzf
	 6FC5pvdHfIz6lb4RB5wC5F5Es8XugqmT+yOnJrqimo5NuiJBWdJGv9mPkmYVuF7kr6
	 skjMRgWhc7LAA==
Message-ID: <sashiko-outbox-202972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-10-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:53:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep timeout and wait results in the types returned by the kernel wait AP=
Is.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D9

