Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664567;
	b=JY9wQXDxO8kqroR237kgnfGSrtf7c94lUMz516YWElND7zbZ52if2Uojp503L2UIW64y
	 mwtb6U5X+iA34sMOcku8MGQmBMAHTlhdVV9nAZSz266SD9YOsgMYqXOiljwL7t7WAifwF
	 20u6jAN6FWn4AzU9FcZAddMKNM7AXweQfiNGwFNUsECIjFv5pxSA0LhGhEUM4+JDFalBq
	 VfCJ0y2dZdSIyPUEBqA2c/0wphNOBxZ3iVEMG9B8Pm/1TB8XRLSLYFdROcnEvfDX9bqks
	 AkkhxCNa9RrY+wVaeedGgeGMYWp/sFgj9uSjGfSMPALA6S/oCY3a5WhcDIlkJcU5pNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ow3XCvJjCoEA/HO2JqUdHbblgnQnfGKmyr+ULDzjLOc=;
	b=YsC7QS5FACw1XtZqvlaKRHaWdGC4uxizoREA2aGNHlJXFgCHyfwiHTM+jRosXPtAN0sm
	 Msgp2VAivGH7KGWjoKQ8iyzaoVwgnZhTUCjzEijtz69e4YJOOg7tivQMuV7gk6RAZ5dZZ
	 OCO5zBZK1ckYGJTANChtP5q8KN9fEwUdYYtu6lEGF/Vv3W8Nqk82yrQyWqK/IYLzH7pbO
	 eiob2kCrJ/M3o+MACpnvY9ADQ6iusaxYpNgRQFEGtcJwxj+vYAwuDE7gDQRuIE9z6UkBt
	 Tq2MC0B8d2d+UR+p9L+J6pODdzDmG8t7J85B6cDjpBctDmPC1E+ZISJLbcErchEnLNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej1s3Eni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C1606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej1s3Eni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35831F000C1;
	Tue,  3 Nov 2026 00:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664567;
	bh=Ow3XCvJjCoEA/HO2JqUdHbblgnQnfGKmyr+ULDzjLOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ej1s3Eni9qUZ4VvWYOA1LO0jsYQkDWFtAX8p0xGSBAYwApjWoZSjOenoWpWjg/me5
	 AXN0xvNcmIlVjIVOsmbJmkVTLcRvtbnET2uIaKhJ3mPU3bNiUJtXiCTSOLx8iTpz4I
	 rDwwgPjEVqv5JKeqrg9e/64bpW0kesCxhCdOdg0jHdw8+hpKsuxdOZEDQ9qhDH/wyn
	 qGUE9El3OkBcrWQJsJnVdNX6rX4dx01NYvhq3XNMjVlV4Zlj5AkQCwAUKQ1QeZqVaJ
	 0sk1xrt5nn/st1Hn9dLvCSvV0rcWun903vGg/ursoygtEaFv3E4KcS84iyHvKOJ7iq
	 zZKH2Aetp7OUQ==
Message-ID: <sashiko-outbox-194363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-9-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:09:26 +0000
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
> using the period-interrupt path for this event can infer a false ring wrap
> when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM time=
r.
> The driver must release its pointer and trigger locks before calling it.
> Existing period notification callers keep their current behavior.
>=20
> Atomic and nonatomic synthetic PCM tests reproduced the missing wakeup
> and false-wrap alternatives. The new helper delivered 64 final frames and
> reported four available frames after delayed partial progress without XRU=
N.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D8

