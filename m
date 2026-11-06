Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924070;
	b=JtmPyRPcZFyNdUvJcvVJb2PeAHxMkEHPwE9LGX/8TmfEU2Yd+uJcMPhtoNm1t5TQlLfk
	 2ENvbSAbHJTmIYKzGq0YGWJJ+I5+eqlQmvQwyA7xrEiCXsoF8OCiQPehXNLFQP56/lcDA
	 1csMHzUs0gVms6YKgXY1WVFpPS3igEtuHjedpEp9DiPQd+4AsFJ+RRafYCBkSmU0u30ip
	 joDpioqlW77Y+mN6Gu6EpU3Xy5FU7gu5wwXpWDHleKs0Y/cCF3K1aiLOuv+6PY0pboWB8
	 mBWlhyiDsPVwpZE7QHFZGghAvxATskoZN/a593ft0MmzXaXrS2sqAIbUC/WPOVfZqKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924070;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I0i91HdmL4pjhVu1jKfxmvAmYcs0mo7ct6KbPdM7jCY=;
	b=YCaT8Iy1wjx1ldqS+lJ8UG2f+72t4cghc7uT1MbL8lN8MD3DMVwq9a+nx5w5rMRnVSoE
	 yaRlFv6s1TUkMgpiG/ow34jg2DdMUxJsl9OYXcl5Olr0Ob1AH7XlJlv2DjKa0Iy8w57S+
	 P3gt/fdd9YRrxyQfUMF2F+140WGU8OhwNQVAhD/n7aM5Y4TudsoQL0MtRF1dD9q1/fWBH
	 aHh1limnwchOUTr0aaQXvlXNm+Hz8AvJP6+bBxS7wnerBDdTWQf//PT5b7qVwJAXZZRzX
	 X8D26XodZ776IduCPO8GltMrkDBET+656v/S0A+SIAhVeOCdV3wwLs5dliwQkFLchyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SI3ULv5E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A077606A32C
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SI3ULv5E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53771F008A4;
	Fri,  6 Nov 2026 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793924070;
	bh=I0i91HdmL4pjhVu1jKfxmvAmYcs0mo7ct6KbPdM7jCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SI3ULv5EoRBce6JrYxLblUjww1iczZg0zBUZ5lUYHZ5KpKDwAZ93N5WM1sM8xo+s1
	 FIp2LEYu3VDs5YexKC31b7pbz/XND2AxJtCby9e/sXcx2WOMaxyhcktV9CDs5qci/7
	 tQZuldMNlInglAFafzAeis2OFbH8VhGqj+a8Yk4qV3B4yFjw4lfQCeI+c2X4+ZE6wj
	 GbI4j65mQbl9GVHk09AcHZ7VAO4LqoqlfT6QpeZ8MothePxOnPPkVfgLYbt2A/gLHG
	 iXmX/tdF/MN9kRS6Cm5MMi6F9IonqcM7d87gKlLmcYZ0EwAbsQsm+TpT0H4qaCzhlS
	 kour56/VhEQfw==
Message-ID: <sashiko-outbox-200429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-9-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:14:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D8

