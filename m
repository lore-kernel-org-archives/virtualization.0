Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763542;
	b=fJPGv4aKxBFh2vUNRG+d/9QOELBSAdsNbDFPx8pZPg/1lSEvty4z8/cXr67JxweMNPXm
	 BX+NncxMVvNM4/mqLZiHa6h0Gg/vgCnlHoMJxqA450tgcbW/WXwSTeZSG6RMArRFumITU
	 EqRc3yY1k8EBAB3NNA+pFi/UtK3nRYaWXyVT8r4EJfYe9qR7Bmnrj0lgo0HP2x3hfpRqz
	 7spEuRswF9hCKVnWstuq7rq6EUSzgdT6Uheene0moArpAUr3bkJ4OCIFShmTCGWOcWlvz
	 GDid+A/pps7iQGTE4VIywyVuVa7RMHAfd3VbZYfOUlgIlFa+peR/2/pAlP6r4o9muHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763542;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yRh34aX2rLtOJ80BRGm92yaJcrbbjKCBk23xn/LROvk=;
	b=bKxDY93tWZk6z9EHeFGM9oTkrJJ8wK1uUuPO5YA/tbbp2iADWRis6sXBw2RKV6DTETCl
	 T7iwlx9EyN2LJTnFFPmWVFsoenbg7y+UFezq/yRBhjVdFErSdVpH01HOJdbUdyct213Yl
	 glcbRysFAj9PmWUXdvw+dUIhYL1BL9puyUJQ7Ueq91AVHCOmGtap9Mr/F0vhA49bQIYno
	 VkuPcfjYqqj7b7RkTZUcgIwKRckdFce0tLqNWLxBKE9w5dYA/hB0OC4Kcm04GV8JHeqYh
	 Vl/2eChBTpYRcERUo5l/zqzvwU4HKX6yGuEFk4XTk6EXQpdC1UXCMbHmn4ryPx+U6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXu01gFj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F140606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXu01gFj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DCB1F000C1;
	Wed,  4 Nov 2026 03:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763542;
	bh=yRh34aX2rLtOJ80BRGm92yaJcrbbjKCBk23xn/LROvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXu01gFjOohD3kEjtL+JqCV/7uKNpbPQVOyknxaEe6mwuVpTCgULqeF9vDikYZcav
	 xsZ4my7lDOgX0yND+Y+FtgMjqlWOKDffxApSEo79Scb4hifv1Vz5pAWam8dP3MOmAH
	 TeX8x1EqRVCqHiNvUcWuWd+QCm9MWIlUL4ix3EhKyGqmnG5+3mc9QlPqBU3Hw1K9wR
	 8vXCDKzUSS0MNKTckjN2FTWC879Fgz3TZw6DfJU4jdkA60klIHaI+fi3uCAGIC1m8x
	 eX38nAEZuPVSzYzYqhiR0iyrhPPxVlTI52JdaXA2QvovxG9JAoBE/6TKE8CICEWJ1F
	 68X3u3JR8GfTg==
Message-ID: <sashiko-outbox-196616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-10-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:39:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request is
> still pending. A later teardown may then submit another RELEASE before the
> first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels t=
he
> pending request and wakes the waiter.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D9

