Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864592;
	b=EbztRfO/NPp1QB1cYHsfTbuWEnQ41fbS6uD24uZJYPg8e6cKqYLNt+pm3SsuDk/45rJR
	 +iMHydXOywKVwC8SHmvKdxvZDSwRSvOODSHR5hHlB1QlmxDiDi+Vy9B0M2fSTM2wJ2ZDf
	 XgKaP0D6Ods6/KUqk1lsZSGT6gAGhpEwecHVVyqlov0QGpO2xC9cLyr6jADETQwNZuqSm
	 wMkEo+j3rTdIKZokGXbKy977Sw+ZusEHsTE2zDXNieQYhQHNUPmP3mmVEncHFM1fFRJix
	 IP4KsfVOalOGHseR+tW58JFBiyn/tQS45BcPz9quTOukXmmqRbWUCWtKnvBN54sNhOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t+NFLHoVhd+07FnjFza/4vQaf/elQVLQNnIGbXwEDnM=;
	b=1lplA3H6Ad/B7UHZeQfjJyDB75DhSsZfVrCvocZHWVZ7zCjVGG09cj5Z36gbJdA94HjF
	 e8d4P/GJw9nMG0B1trjsJfX+NUxBJJML58uQY8/uHPsc+RBj7adshh2kLm1Zw9kOgGYfE
	 GzV+1e5vntbj62qG5sYs1RWMGqMP494x9gB4ena+BAh7q2ndg6parLebZc8BVVa78LWCD
	 VrbGR6Gk5MKtZJkCtkV2/q0xZfZH9uc4k+lQQUExiQvkfcPkcgphmwTFs1TbyuLtosNYY
	 Rb3toXNndmEnltaWaaOBWxe7KgMdynq3D/LDI9+8vYUl1Sd+Wk/aJowLKz2TaIFhLXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moLZsTR+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92F606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moLZsTR+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC301F0093A;
	Thu,  5 Nov 2026 07:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793864591;
	bh=t+NFLHoVhd+07FnjFza/4vQaf/elQVLQNnIGbXwEDnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=moLZsTR+7v3Q2kY4N+xdJ/tUXUltMRqRyUID9vWP+JMqB+ibvINA5nfJ0DREZfnSV
	 jS42djs181FeuSzGHt7MH0rU6mcu9yrA7Rq+/QXwAgbx4urJGu0rVDRXRlz/9nM2yX
	 FdCn6eMHPHOzX2vyKdOPq48uxh0zDiN8QE4WRCm9HAulLeF5ZhhYiAHliv9c0huhkf
	 fWSvEac2ZU5YZLD4Lz8KcQ69B6ZSIeUykY20qQmAUmOeGppyQKfOBimKMzaPUgfX27
	 nOcl9qvVufC/PSKx1IrLmFooykd5av3WhhwVAGKJGpi7sh/N9lPXHLiZ5c8SViUTPC
	 bFoZMKs1VpT9w==
Message-ID: <sashiko-outbox-198694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/12] ALSA: virtio: retain PCM DMA buffers and
 validate capture completions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-8-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:43:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Retain references to the pages backing ALSA's vmalloc buffer until its
> queued I/O messages are freed. On NOMMU systems, use driver-owned memory
> for DMA and copy playback data before submission and capture data after
> completion, so ALSA buffer release cannot invalidate an active request.
>=20
> Validate the PCM buffer and each period before building scatterlists.
> Require a successful full-period response for ordinary capture before
> advancing its pointer. Each descriptor targets a fixed ring slice, so a
> short response would expose the unwritten remainder as captured data.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> [ ... ]
> retire empty stopped completions without advancing capture state. Once
> an XRUN is latched, later completions only retire queue ownership. An
> out-of-order full completion reports XRUN rather than publishing an
> unwritten ring slice; this path does not reorder completed requests.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D7

