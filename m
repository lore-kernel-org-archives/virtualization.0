Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369976;
	b=EYEym8gBIl4txtCo5lYytuQMBNpV/SZLlhtprKfY/y1JZnddLTLpSnj0spJRAp1pkMsz
	 4h8qs7UGqpe4tYOGBzbegGkZSA7v8754R0AHpCDxQSItHAGf635K7Psrvu2FLxwV3Tl5X
	 vY1aGH1WtXMzmAfK7PdEsZNod9vwHIm6V6Tvg9nVYaeYcxVkV7clbGk6HTvVaIbzQlju5
	 lLAzpA5QNchJaPBUu+oKBLrAGQzoSOvYWk7t7hAlCs6cPOSvFgUg7YUoVSfIxpdo22IvF
	 oXMS6VNrpmjZ9or1iq3qwjid2X/g4uK8cB2H/mY08xQSTpB+5A9PIg/xBhzkSIs6f9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZuMiCLj+lN6CNgaAQsONwfJ3gCI1gxfwZ0H/49IP5oQ=;
	b=Ks3EvT7Hjio1LIUUySYAi4Cry1/O+WnnSJiRyTXz54x9pZDE+v+RjNwDCu0Dkk1wvJjY
	 JV2rBZWq6t/9ncW9eA1aOhDleawj8JzexJRSWMnNfvDnMXeLOOxIs4mtAipIKi7sw9zBd
	 hSHzoprKPOcXwuyYHGjgPCqlnJZBRkdZTkF8Y66NC5OSvBTTJEpn32G1o02ytHuWyiYcu
	 ycuHniLp7M93m5apqvqCG5MmIYhAlIUJM4hOiZPoUFMKV09fKIMeGKk5X7JHQ/Ojy3W0O
	 twXcotXyREjhw3AhMJbzxnNjrVPYnN6NfOWhFuuhba5EQ1GTkEvswAdxk2DFfNEfCbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5nVYunr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A2606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5nVYunr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7441F0089F;
	Wed, 11 Nov 2026 04:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369976;
	bh=ZuMiCLj+lN6CNgaAQsONwfJ3gCI1gxfwZ0H/49IP5oQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h5nVYunroWkacpvT8luZlVwfYbCqaVGMdXuAqJDRmepW9IQHxjNbn8uxLhO9gNjCQ
	 bk+oaHSNqlyZca46FGyA/jrWdJ70l1cdQTPs1uUY+AHpfTM/8nzcK7QeFuGgWKTq86
	 aFvspQuMc22GHagcKKZAz6KpqJovT/gklGqATsx0g6uaKPFD8YAIJ9gGja1blR570B
	 MPY0UXKYmzA4Rn8vGpuxv5vQqv8eJn+9yyuoB3z1YffxC5Ia7irqlZQDqiaSLsnDU6
	 R/yn4TWNxwdfuqcylzjzTXul3WsXLQS0KI5dGNVN5Iit6G16a5/0f58D73MkrxGG2n
	 dcr9bFtDOpKlQ==
Message-ID: <sashiko-outbox-208260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 05/16] ALSA: pcm: serialize linked buffer actions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-6-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:06:15 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Concurrent non-atomic actions on different members of a linked PCM group
> currently lock their own buffer first, then the other members. That
> acquisition order can differ between callers. Sibling buffer mutexes
> also do not close their buffer-access admission counters.
>=20
> Close buffer access for every member before taking any buffer mutex, and
> acquire those mutexes in the stable linked-list order while group
> membership is protected. Release every access gate on success and on
> failure, including when a member already has an active buffer access.
> The group action then uses the buffers already held by its caller.
>=20
> The PCM stream and group locks are not held across sleeping driver
> prepare callbacks. Single-stream non-atomic actions keep their existing
> buffer-access locking path.
>=20
> Fixes: 3c3201f8c7bb ("ALSA: pcm: Fix races among concurrent prepare and h=
w_params/hw_free calls")
> Fixes: bc55cfd5718c ("ALSA: pcm: Fix potential AB/BA lock with buffer_mut=
ex and mmap_lock")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D5

