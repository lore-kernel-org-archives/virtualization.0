Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356168;
	b=0LU7ZixY42njstMNNQh+VoCVz2UtQuO6bx/QFEY9TlAoNvo8eOeU+rDneHK/Ap3OdLN7
	 tna56n+DRSMoEFPSGUG4vJEHwTVnAppIcHaVJLB7R+Ujv5vBj2rKi1CBgj1pt797IRfeg
	 kp4Md1qU11Ez9QJ0J0cxnQKisv8BrW1oI5kcUfumRvZvxqLX5PrSQsdHSoyQV6JLbwEuq
	 H4MpcCtElEtCWxRGHzv4HOONqG/anx7rG6oyTb1C+x2cj7qu9tC6ZWP6YwbG6e97WfuGy
	 e9g7kKnE4o4KRoS4Vecwe2JHyK4luueKjiWyzv3XwfDWmmR0Pg2uWS6pcSKw80vvOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kn6qugECXTlkfjYjRT/XPNzUDkmO/JsRpmZ1JRFzB2g=;
	b=Wh9+Tkwa2/bG0OzVVf7Qz2MeTzN5aki1E0W+6afTwf0AANoYD3OmlnJVqPsDcnybD91b
	 XwKyJtHlTseEWJKfeVPrY7BrI/aJ6MkRKwZY+CyED9PwqjoklbllGZo6pUel+tzZl37zk
	 JUbtKbTJ+1cH4B4q8fXrYOYY0lisQ029beSKeHfn551Hy0f4RPQYXNVzxtw1YYH2bz1b0
	 0TbPcwo6z/Ex9mtYiKfVltfmxnjJCKozw5zQnQDWbl15sL6XXBoFtHrqXhqGmsZkE6fO2
	 J9eVl7Jw9OaumAjeDXXMNz5y153T5Pr+hoyfd4CzBM1Qlil/J98QA9RdofzQXU+uuRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSjr0txF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD9606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSjr0txF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A561F0089F;
	Wed, 11 Nov 2026 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356168;
	bh=Kn6qugECXTlkfjYjRT/XPNzUDkmO/JsRpmZ1JRFzB2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nSjr0txFcdZnikkejRTi+w26W9MqvHcUOY1OpkWyIYFHFJwIn31cSi+xBBRYVPQ4J
	 R4Pk+ejWkLLcGQivpzUvUqTuVvi7vy39vc4r/vwAIaVfVgzs/+g+5umLnWWv99+Las
	 RALcnsgwngHB+YwPqb1bxC11zJQ5haVUR7EGytHxRbbjv/vF8x2m0gcKfqFmvWIuQ0
	 7IqakMyZ7aYnatvgX6Ml+5SXl3lyyDdcBv5FablCeccmb+mh0qtI/LlB1HQkREgyjK
	 w1X71vauROLm/uMANzTuKOxv8J9DJhC/hMP1ERHW/sVYMcAqSjhjv/hH0DwBTU13ZI
	 FY5ln425XvOIw==
Message-ID: <sashiko-outbox-208005@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 03/16] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-4-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:16:07 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D3

