Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356374;
	b=2LVnoHrbYJxoWVnu/CWqhN9gR5DQu8dO6Qo3ohYBvlM7FJ/DAfdEYGBM4cXKTNjdRIAK
	 2c2NkWVHFrACfPSvsvGtWsXIDomIxOv9qCjuuwm4Jl/0hLLh4hI9BYbM2QLYjTeGPa4IG
	 j1VSbISchU80QmAgkoxTDnRypcdtr1AYGlgxpPNOKiG/i8Rg8BMwlneaxn7IYl6lqrxNt
	 xq2XogSBQMgHcOwYFtkczstudfVBycRxrvS9E8qcVWcLhjMUtiq9WQCBPlJi2AgXJTzCg
	 9iTyMfWdeh5NEndRZkJ8khXF0Dcv5ugg6RdjtOY0bZ+Z8xcObbBR+XDvplHY7VR3eUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ogfz79difxh0Ntyd67EY00mxmQpDbvdQQkn7ymIdiYQ=;
	b=GUwpWsL07pKrW0aAK4zBuollLW5yLDc7G8F1yD+lzg75SABHbdyatIJtm7va/Y6ypaR2
	 YLyo1WFsx3mNl+XVeZOIPZIZ9BAo5PEVN/xmzer1+Wfk5b5HrPTZRMnpgCYPL8Fxt0LIG
	 27HSc4THlsZ+R5gRVpfR9hbiyr1qiqpyPYSuYcOKntGV8odEWK1bgab/V6AaaWhR5uIPi
	 Fs7zWqs/oV9YIxZ5206n1/XWfVr8RNJ9rHSPBFOS4DUzvqFZ7/Ri5HUXTR/j1c4YKWOs3
	 MfwBspylNvOUJGScPPnbxKMvGoihV+ip3P5Jf8UlD25RYA5gXFwcIvbUczXdRa+SaFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7t3kTw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A67606A321
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7t3kTw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9149A1F0089F;
	Wed, 11 Nov 2026 00:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356373;
	bh=ogfz79difxh0Ntyd67EY00mxmQpDbvdQQkn7ymIdiYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7t3kTw42ou2SSr1rvXZ9IPI7xGzXpRC+iR5FdcILnXA6CfEPI/ZaAcEJvXak5XXN
	 S3OGGUO+S7riNtqJaK8yoF+a6DKgcSBeVILUDQKTc42bXqJtsepyqqHbEtNs4FRj1u
	 P332ZX8E2z2qXMt2KxrbLj4iaMzfN1OoneOypAeyMoUmUVOFiJUppGUpwgCBV3xkNv
	 m6ipLC92AnUYSCgzyBXcKB1R6Q6nZ79V0qSNwch9H/Z48H1rFkdR7nacjmE+DvElTS
	 RfI4nIdRdb7q+43fKICly8jOy7+v1d0u20sMKYYSojwxwITAEMB/w7/Oh352WR3O3M
	 Nv3EBOhqNl00w==
Message-ID: <sashiko-outbox-208011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 13/16] ALSA: virtio: prioritize capture period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-14-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:19:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use system_highpri_wq for capture progress notifications. Capture now
> always uses request-owned storage. Playback keeps the ordinary
> workqueue. This preserves the priority proposal separately from recovery
> and accounting. It provides no hard real-time guarantee and cannot
> prevent reader overruns.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D13

