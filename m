Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202242;
	b=4E9ePqi2C96AsLNgdOlEVYAdaosVnPTsjXEbY6/hrMuGqNOmg2UqD0ETazAO0uFnSTLD
	 1UiZhf78xSrSgvlWj7+5tgkah7nPCQdP2QPvi0Q+mrZRRlrN7j4cG1VSP6Y6libE9vhHz
	 HdfvcRyXcAdLaL/wVCDsmDy1A1rytAt+U2kr8rk0OGhg5awvYajvHEwptJUcOjAbOrVTN
	 4JJfkdS0nEBPG31A/UjXeyqjA2ezi04PunG4QxonTIf45HEeGD3cmrymv7tKrsm+4Px16
	 /OGFKeMs9UFa7WBSifgDYTfzjGca1L+aLW2ofg2nATb9R+E4HudqTwADZNUxoqaYTcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uhZZTGja1gqg9jMp/sw6NiecHD7aGUJ3b72W3WGU8To=;
	b=Zqd/2lX/XShX+NTJMi7AL4jaconuYGeEPncWLAF5oBOhpW5BjycwcwXtxW2rWKF+8fMK
	 38kfCCxVpnDxAytQT2yAtOgpqfGn3WncNeMYnx+uqPRBI9mWUEzdNVW1kdgB2finZWo86
	 NWgi45tqVa1EqCmIdoT9E7SWmt2AxG2pZ6s6TW+juzpaEP8vjQWSLmVfvQQeoNt+hGP1g
	 +yeA5GCgPDD2ABnnLViOPqOh3j/g2euePgK2OJhyTWpiYY3FWjHIjM5YT/eC30tH2P+Yq
	 9nmDmTHy7D+/QEj7zbIPWGzv4H+w9ToNeUMmF/+3l4Ug9sVIzotpJZGtB87UnP3DPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egrTjwbW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8500606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=egrTjwbW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC321F0089F;
	Mon,  9 Nov 2026 05:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794202241;
	bh=uhZZTGja1gqg9jMp/sw6NiecHD7aGUJ3b72W3WGU8To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egrTjwbWI3i88rV+VktEwKIvR1Pw59oYzi3rO3vrSM7sh1TFJ2ol3Vb0/l+tALahQ
	 1shX1S3dTHeSRNQhYCV6No9oBoEHkjgXhfdM/iaWxYqLGsyrKJvXGQw6FjRijsdHHY
	 mPSTbXDW+WBZyIcGnUGl8BUcfY8D0SdkutsdjCqc2bRM7KJ50+jCkvzxAp6lf6IazQ
	 OC7lJThkKxQIfbo8KsW8KRsANVbZ8GwbwFQ3vCUf8a+vEuF+6KbI75eFTVpIpmlhpj
	 TukLgaeedoDPdIC9MxcGfm4MT7OASNlVQlLXu2IgcA1t53iCpLaWKJ65WuhRhBGBpA
	 LbMmN6w7TJZ0g==
Message-ID: <sashiko-outbox-204441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 10/13] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-11-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:30:40 +0000
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
> Keep timeout and wait results in the types returned by the kernel wait
> APIs.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D10

