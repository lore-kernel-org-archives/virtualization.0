Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982631;
	b=KM/X2Wp1fx1hC5nZBKVVd+xboW0ZZK7TSOcqmb9UROoP9R702fszsdHHYCYrVE9LHi+X
	 S9dkUwpTP+JSQ3h6HmPXuQzzk6yD6ctSn2Joqo5VcXHwhaK0hdUVJ7L4TEzKanlO0j3HQ
	 n/s1OR9ox5WtGKo9m2pNFH6AGwRCNSwth2fGnVJiHmOd0E4qiMovD2Pp3Ij8WxQWwV4b7
	 jStQ17MqTxZKT5sJNA2zm1EmGYf6QXbUrDMxAErxf79i5nlDjP20fQ7qic11gOQKbVVD+
	 unvkkm/dll1nUe47ofSro3V3ko6ROw6cRA8Tqiafj+U+YNM1SMjcemLYsidga3VdvHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982631;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+d5XSF3OkDsAuW3lXR56zRA92LlBXUPj+FMgyqbX+Ig=;
	b=HEVZ7gcMd5s+1WtcG7UJwneNkCgUMEcEzRwScmSGVRhToD898H0rB0lsEnwxlCTI78zg
	 Y0eLWo8vQOKMaQlJeULmGXz1m1W9rZeBllELj9nXOWsUkF6fHKRYl8F/AZ49Mgkj8VeDI
	 b2cwvtqA5GTklMb+bjs3pUU5Jq4MuyZQi6FEhoBVz3vxxfBPlTK8F6C9NHW1B3noswvNv
	 XiNFNTwfbEb5RpQKzcnlsrOZF0JsCULgOmmJtQkH5b8yzeM5OA1QsY4/bm7wMj9Wqld4U
	 VRZDtVgvJmgIAnBQCJ9PZfl1MFSKeK0+HsuT0GODia6W8aq7TCZUB/tm3KKOhehb2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMrrnALX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569B606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMrrnALX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5541F0089F;
	Fri,  6 Nov 2026 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982631;
	bh=+d5XSF3OkDsAuW3lXR56zRA92LlBXUPj+FMgyqbX+Ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMrrnALXGg8azilyHww61n3P4G/KFEO2xyPE+z6nT+38JtGQPnjhsTIWNZVXzoa8z
	 IGbJozuaC567nanDHO7QyLjt+YssSc87+nDxwdn/13CLFF5qQNUy6T6S6bclEeYIaz
	 6t1rn7S1BPWNIDlI0/oNf+BGPXwBe/2swbgavMWzC6brLazK2J+sFkicSDkoKURYoT
	 FEkuTWeGKL009j1NignBBWGv8RPGmrn6ts5uVPyZ75WAPIwe5sROw6qtVWidEXTUQZ
	 VyiPdrYIGlbdayikeM4yBEAh0KbH6W18M7hf6m9vNKu6Yoetq3nItSP9hWXjeQJnE/
	 tlMCwx3zfveSQ==
Message-ID: <sashiko-outbox-201815@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-3-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:30:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D2

