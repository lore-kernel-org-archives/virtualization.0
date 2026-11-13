Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562232;
	b=tvObC1/YDWz/IrZYf9f7a0W1ZXxCFinPCm7Kx+ghPrr+nbZNeA/X1nE/zLj3kc/ROFE3
	 /wFmMkAoxNGEPjNiWh4B9DAEMslBoDsRK7cxPWM8ykTtAx3wLMQ5yuW6YImOL07Qylso/
	 UqvVk5kAqjDMtod6ZwFR67Eb73zOwFnfe7ABVSHPbGKA9E7g2FnARynD+IBQ8lAXrL16R
	 SgTbbOCH2XeS6cKwoXsUDvMBmOsEZttsIHIrjKt/d0QbTPQdkjm2Fx279vnWNKESp+3K+
	 tcW1TfxB0XQEpBEL/uu50JrMFNI8SYHztvu148OGwrbEqkEubsHZJypIJK8eLIfj5LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562232;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KyfY9btDlVtLSfj9DSIB0LP9sFe6ah2jSWhr/doPbDo=;
	b=lO/vE5SAgdUs8ibrxUSptz5jc9DjdthwzOf0ZZsvxovMi6sBl4h5Tq9Vzfx4TSMMWYOv
	 N4eZ8XZZ9++E56MEuAWixItWAjurquCeEsAvzB98Ov4RYa3S+/uZF0v8QF/fK/5vUNQsC
	 BNSFmInTahnQapN0Z2P3jmJWfa1oLZyPeQwuaGH/pBBDaZqhbU65+jOAT3JRK3dTaAY6H
	 g6l6Bgp6f8HNt8X8nhyxOhVqksbTZW2bmHev2YPBzt49T8trNE5I8JFFp/Euv/K5TRTG4
	 kCB4/NAnw1FoWiY/o7O4gCp313hPwCUWEs1Jr+BegBSZxX2MzBjbhLcQA5DqxeVDOGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEULxiOc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73627606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEULxiOc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDF01F000C4;
	Fri, 13 Nov 2026 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562232;
	bh=KyfY9btDlVtLSfj9DSIB0LP9sFe6ah2jSWhr/doPbDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEULxiOcWsUm166OYUxkn2odb6AB9GADDdBFfVhyYwhCiXzH/6OvhOUKvYIwgveh/
	 mwZYn9Zuvjz9hzezrZ0eVgJARR5uD4k2sLEitNA1f4H6oHWth0BZCAqFq29zFSdiba
	 R/1IM2YGW17E+LpPhBiAdYs9cKkSDV5HknhZ9DTKbTmjBeBE/BiyxGOomPeBvw1SK5
	 8tJPHG/Q36cksTRN6wGFPt4kxFb3MZhyHHd8zvoSoFwf143i2wuAEWLRkAIgacG5Ny
	 gRWfICzC7J8xsRA85/Se8eLy0PwSN6s/ZXxprqtkM7gPsc3tS3+7hJob8EFs5nNQiF
	 zjg4TlU9ix8bA==
Message-ID: <sashiko-outbox-212545@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 10/18] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-10-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-10-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:30:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and
> payloads in the reference-counted message so caller cleanup cannot
> invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure.
> DMA cacheline alignment alone does not guarantee the structure's CPU
> alignment. Align regions to the greater of the DMA cacheline and
> control-value type alignment, and reserve prefix slack from the buffer
> base so typed accesses remain aligned while scatterlist regions stay on
> cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D10

