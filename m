Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182154;
	b=JX9pxlEGKwyNH2/+nMzq7dinbUKjo80KL/YXUeimm26yeDZf+I4mC17tSdWHkNnYNRyT
	 ZRbJxbyAD4TxQwqkhJu8f3+JDjh3nHmxvczyvj5v+ik2dJey7GJLU1YmYctycOmEZ6+pn
	 6AC/1CTW+Yu2hNNLNIKj0JQXZPbxjd2ksANqOnfX5cej89JL8ggFWf/EeV9U47PMh5ecP
	 HH4cXCawcgR2jk7tKEdjCUoYeQ41VCBxAenOI1ONViwmcEidZYBXopbMiJ310BpvBd2Xl
	 8vFfg6DxR2bN02ukCPZkFDZkUHSVK0lxqlBUoUlnfldWQlwLwEBWr+H+XEPE80obmlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182154;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2aOQmxSc2EX03miAMYpYqOwur6GJ/nGugK5PjCJ7k+U=;
	b=bZ8xy42TW+bcT84FlKNs3Gfkk3sGvOS+vR2GkoYczgyblu/ncXqPMbH5KMiN89J5p/o/
	 5LNavzHMjsDZCd9XMMHBGtatOYc8bBwNmu1KUYL24b1Krd534xMSl5MLd8cG1XqPQZh5x
	 z9CZPweCglOK+SSCGYrgCHFf5UkKVWYJoAirv178+/1MSVTVFCMJS6HXuR0d+dQ9BhcNu
	 y7CE+gknwpB/84yK1qQSWhWlQPMYTbONrz6sRxkz9cUDCNO1P39i3/P7y95W2ubXuE2RD
	 LpK+OWRsOjIxzY9wQnFUeZ9MRnvg7V1WDfMHV+J56xKtNJqROY0kysAytGWTCicvx5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvvCuZBy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED091606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvvCuZBy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A9E1F01825;
	Wed, 28 Oct 2026 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182153;
	bh=2aOQmxSc2EX03miAMYpYqOwur6GJ/nGugK5PjCJ7k+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvvCuZByHStooamGKHoNdWMq/0xqdjgO8cA9O3izGGyqgRA+65D4whWdRYOckgpOy
	 wvwAvpX04lyfl16MPUuBsUJM1jY2K0P0VD5I45de6DsLVeu69+CrQY7p73HJ757vRV
	 h51J9yHTPKp2qqA0zQENW4bNMiqvYFUWzr/qJ8x3XMx3JubovB3fCfHTEbSwe70GCb
	 X7w7ZmBdeT9dm1M+bIOL0ss9sX7hlO+pxfP3EpIFkOj9qOT/BfPP0TBUPdSRUbpdGe
	 ssGCJiIZ3RQ0Liv3KbL9GGncHnPQAO6DrjAu60wD5B8RSFYF0p1Ah3dD2Rk9CFBzPE
	 xCVaeGO0lg4Kw==
Message-ID: <sashiko-outbox-187725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/16] ALSA: virtio: fence staged capture state and
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-14-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:09:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A failed PREPARE can leave subsequent START or ACK paths able to queue
> requests. Device reset can also leave stale queue and pause-restart state,
> and a failed open can leave period work referring to a released runtime.
>=20
> Track successful device preparation under the substream lock. Require that
> state and a live virtqueue before queueing transfers. Clear preparation
> before reconfiguration and reset, stop transfers before resetting the
> device, detach outstanding buffers, clear queue pointers under their lock=
s,
> and cancel period work before completing state cleanup. Mark all streams
> suspended so prepare re-establishes device parameters after restore.
>=20
> Keep prepared capture buffers eligible for NOMMU bounce copies during
> native pause. Suppress new notifications from an inactive failed-open
> path, cancel pending period work on open failure, and guard the worker
> against an absent runtime.
> [ ... ]
> client-deadline failures on v5 and the corrected kernel; it does not
> justify relaxing the capture overflow checks.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D13

