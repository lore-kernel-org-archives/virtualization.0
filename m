Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461998;
	b=WDlYe22aELuyTTX+m/vArB+5eKWFaEuXtDtECrsNBIFd6ZuK3O4ZGg0OlPFYKZWoRS8+
	 f+VnQyfS7tffUEruKq6G9uGNXoAgbTulMlYHHDMSOytnXQyGp1foXEPgLh6Z3kjJz2sch
	 DnjBBnSdd4kJwasKqE0vlV2pdnf+SRyLv+Sg5FOhPmSQgX1i1YtH4AbRjFkrSCR9B/Q93
	 HNcSZV2V8OoPCyRiOVJZetdcsVA13SGylbqIYgE282b3H7S9i6xl2mpe1ynwuvzh/Jw2A
	 0n2POCCdCeJQ7MJ8QcE/y2y/TEz/ZqDWACqweUacL8pStKQM03Wlsy8XhMcbDnVm8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w9PIVZ3CWYpsnFrFE3Po+RwBEayJKANzWK3fRghw7J8=;
	b=FWqb3Yc1sVzCTy6KjajxQgcjeMp0dRvfab5ryDFlrvoCYad3naG6l3VRgCmytsqlirGB
	 +3OtwghV3ejFRqV7hL0mJ0dEOE4oCEqOR4G2e8nD3gIestnSsrYRxVflNx75UcgWSkazL
	 mUopqOyR+m/9E4YyZHkeVRX0+b1rVzUaZvSgegWXxpDB5qXpoSrtH2rIw9+UVVloeh1WW
	 Uwi8/RHHlUp+jkiUVcIuUNukMKfjchosYGaR9qXEM4NgP1yIt6X+G/fZIs/XFtk8PvI0f
	 I816Y8iJhjQ4cuTEQrqMOil8sXin3EjxYK4s3l6N8n3xFTmP5Z4Kc5nNmSbMo1Ofz3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik86ZRk9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B018606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ik86ZRk9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACAE1F00A05;
	Thu, 12 Nov 2026 05:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461997;
	bh=w9PIVZ3CWYpsnFrFE3Po+RwBEayJKANzWK3fRghw7J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ik86ZRk9y9TRWfdozLb/VDQnJBV08F/R8tcL40jOJ49KO/ODfYqICSg/UJFl/to2y
	 +vbhB66YNePDIJZgFqAfdiPXJxXqYbeTjm2tmSThCDLcFJnz2N9rswH0sbXuoYsOUr
	 sx2RBhEFP8YrKf0LJYkJ1Xm/ELAODuUzeH7YyL6kGzyMsxALbLau8bm41rilHkxhf9
	 S2qLd/sOon8x3O9aJmU8LRfiO+4XGC3sFsyd3T1kkPJh+OFip0mM5fwS20cePD8waT
	 ZOidrfdbv5kcY5PeWYap4hWxvghLULhUHrGtCMArJ79dHqgx0eSvzUEafUlE6v1nQF
	 7J02j6qc4hx/w==
Message-ID: <sashiko-outbox-210467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 01/17] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-2-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:39:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D1

