Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837614;
	b=TBIpiMVLopNWXsPXQzKV3VQXbBEQg7zJoUrL4vWtWEwgTPOcWGONfzkCaWoQiE15+eHW
	 wRm0uHmWV0Ly2RFOw0aM1NK9t9RquXDONsYbN5ORXiO5kUkd6qv+JFQMuqS192jG8jPsv
	 FH4+6465EFhe00UYbJKsNQ5o0dTWi6p/v2AHxdtWMZLYpP/l9I3IxLQr6a/lXDxDNuJWy
	 FhJD4yvFMuZ/RpyNhuuiyZ7eQEq3xczXMoP8eoc9sxwuhZIVJHrh4v+ZigBpv2VGZVNOi
	 U5yopW+OxCT7gmvFCz6jJEqpJPC0wPeOX9Lo6JdnRVArtkr5dfRNC29MzP8yY5wsAFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hMCKmJtxerbL6W55vnXzI9SORSRDhQyNkdn0Xauzvqs=;
	b=TSUKjg6YxJu+CHu4YC2Yvec9GMLr4wxUlJHW8soG/eQZPhdB9yGKYDhS+/mSHV7iFHKd
	 rUsFREZjnfOxk4GPoyXkmhk0zYO2eEOWtJ5JWpUw+xllNiB0wA5vUtZRldP4J4uvjuvtV
	 P5aY0YoGNgfgQC9JP4ghZexQNqJR5A5kDUt3gxlOog6mxdUGcnD0YqVsN8/aDjpTFUM64
	 Z06/B2DwSLNlT+M/aTh1cON+DXqHfU8aOzyHj/MbR8o0lpMtv2iMkkvreMgm+XhfBgNCx
	 UaSIAmQnm/XB5L3NbQh81bAbhwqEeSSu72mgVVG/Lp5yu5Kuv7H/r8fQpx0kT+AAXug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYWuZ2dH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA01B606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYWuZ2dH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3AE1F00919;
	Thu,  5 Nov 2026 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837613;
	bh=hMCKmJtxerbL6W55vnXzI9SORSRDhQyNkdn0Xauzvqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYWuZ2dHumDj/HnK9u/nn3cX+tsCvhQW42Q0JxgvC1YXiL6e2Q8VSmG2PuhIsLzhy
	 Z9b4i1gxOTOtjj2kqXXNxPxGuhPkNSGF1pYQjInnvwzGEdaa3i+bwWjOdY4p2X/Xlt
	 2nSThp6FWF+uQjA8PZ9KFSybBnGe0Zqu1BGFlo2Rm9vHnnCH7bCIVno8D8LzK90Cax
	 D9zIscjPuYu+AVWLluULoozyVvAluYYXKyDE48VmKLZWfPchEJngHY50dBeYhWy0DR
	 6EgzC2kS3LD+XdGulmLd1BknWgX5q6jaNuo+hylcxFHLsPJrYUv5WeJMwv96UvLKKP
	 rS/7lIr0q7GyA==
Message-ID: <sashiko-outbox-198337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-3-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:13:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D2

