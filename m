Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665544;
	b=wPHsrOb1vWWU6ceOdMdzZaM/vP/KHLmm1HtLOwWIQ2VSgmBrw20wAQYGLkQr+gSCKT3n
	 OgU/c8XlDkhJ/zvWgYxUEdPfw00919FRZ3jSAhChLWGe5hNqLdyzf6PVmQEJgWU1FgEg7
	 HiHP9wb1yUCRbX0qmevipeiS4nk+E3KzZyj9pcdn0w0kNxHmm8+FeCjG+OGXtf3W+xwnh
	 tTcE7mPPOwuxgoJor5yoRyZLMpBnpZKskHQCO3wuUPHkqjXbU9IopwV57i6n/YmBMosvg
	 4y+ktg3O7cNfipNHs/KFBgrXnkXybei997PfzojZI6P8YOjOdgJV+KHa9q7HX5PIdlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p1hnn8Eitpq369+k5SdDw/XZwrJRDGDVeA/v0JPP41Y=;
	b=VXOa/08YLYXBVn1il1vuHHPlbytHOi6cKHhfod2ELD8e12bMDy+zFHPMGVeasETog2WG
	 9qhna8gZD3B33XhTzkQb7LQtxqO04iDI00HY8WnzpdWsn8VHYI9wG2aLfVSBwd49kMAn0
	 Z2n+6PgbAbl+RAuXs4Tqp1tXczOWG9DsZ49nXuSzzagqLdptr8MOFE+/WlVUAxTR7ZVoW
	 aBD8t4K9ltMtIR3mylQVHOxORLfM1yKS8WTHjqQ8Kr0XcjYHdcg1vsmWU3LTeL8Ey80JZ
	 5GekyAa07e6GbmBMiKjQ33THlBtDjpq8xICCCgz/qwJJL8wlCuq671URGdhnpv5bOiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adRn7VKH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D77606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=adRn7VKH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCC11F000C1;
	Tue,  3 Nov 2026 00:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665543;
	bh=p1hnn8Eitpq369+k5SdDw/XZwrJRDGDVeA/v0JPP41Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adRn7VKHUKPInA3J8IHmgIP+JyeyutD+p2mZTdzSLrCPrcHtTZrMZrOxsEqo2zcO5
	 mM6Anr8G9hhbmdlmEP8jfpHdEsbJ5hiH+Xu9YhOZPgA+qIc07yhCI15KFi7lI1DMTF
	 7VqX4Q2MJ9T/HujU3j6GW7QAkBxefz4pMPa/y5LhJTxSdp1AoSV2/D1WmZ1/RW/4Xo
	 6r6ZbMpJ5kKxnpWkIhi08p04+Khp6ozvmhzFqvJm/uj8qnZ7X7pJdRX0fr4UljRoEO
	 +l4TYEVFthaxJGEj7rJXjdfcsYjFCXxtkh018J95M5EuwUK8RzKc574qKYjlwnf7hi
	 mleZKsez/INrA==
Message-ID: <sashiko-outbox-194374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/12] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-5-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:25:43 +0000
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
> Clamp device-reported capture lengths to the message capacity before
> advancing the hardware pointer, preventing an oversized completion from
> accounting bytes beyond the buffer actually submitted.
>=20
> Require whole-byte periods whose total matches the negotiated buffer.
> Check offset, length and the final message index before indexing the
> message array, including empty transfers and arithmetic wraparound.
>=20
> Seed the ordinary capture ring once per prepare. Native STOP preserves
> queued requests and unread samples, so PAUSE_RELEASE must retain their
> ownership. Re-enqueuing the entire ring adds another period to pending
> message lengths and exposes unread DMA slots to the device. Return
> consumed space through the existing indirect ACK path.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D4

