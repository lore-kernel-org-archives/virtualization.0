Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462243;
	b=KjHdcH8uLKGBZrERwDcvs1KdUse1U9LU/2IF1O0By4h0Duch0WUjFa2SqeO01aQqjtWd
	 FPrccmuSNGt79yE5qk9Sc5BQhxodUnRvJABZ9n/58hHKLHkLLGKafez6Yev1K/5yp0ORJ
	 5xAxtWkTM2SZBJKnuh7Wy+7SeKOFEW2h8JhXEyRdin1YVwahE9QSbMUyf1SVxPNyhRPew
	 WXJqXIxp/2d9S2vnmV17VUbgWWNuSDDvdVUqgSqqZZGaY7KHh7F/B0lq9PZP32PUxact7
	 nnqCPRIqL/iVHSDbCpogVM6SE/PJ28uxfFGFvH3/0Hb/ck1bWgv+KrkJHJp9zDicMzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vHjZy/p124kWTHaOvDpcjT/YgQGvhJmfK7k35TQnGIA=;
	b=z1FubyQK8FF4B2YvIRdYZYvoHyIL/GZI8gJaFDyL2xhGOnE4QByMGGOjvFxC3tpZi57d
	 RVc+2sJYTPyjdGjraO3F7lP4351jG7bOPmLR7XHQ50Hl4pBbpFwQgg82h8TRNxNUkdK0U
	 HeAo/kmc3q5rDzxAbL72nZ7r+PP1IqLmWe8qa4THfK5EuNxX1fqSujeUGjJLuzesW2gsM
	 agM6yRzW07Cz8o6UeABx5WYozk95aNC6UzP3NMhskeaxwU1CfxCyx58oTXyLmivUuBLct
	 ThaocDcDBFtpDcjpZfzns/6vR5FZHtI65ejr5nqen4NMSZZNmGjkpCnMhyAn5+W5Emw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmounnS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9C606A323
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmounnS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5DD1F00A05;
	Thu, 12 Nov 2026 05:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462243;
	bh=vHjZy/p124kWTHaOvDpcjT/YgQGvhJmfK7k35TQnGIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmounnS4+w9pQUdfBDXTURAAs13vl2OhOSedw3rqOsIq5rjtFFtrSNclYIokw7QnX
	 /Y2udh3aMtrUe4Qd9gZgrH0fVQ5d2czHOLSxOZcbKO4EAFIYX8bJAGdkqxI70VV41i
	 AfMjXNUWq7Dd5n+YYle45iY2FDJ/dyxbw4kbZpvo7qUmKNVFmDdbpReRfY5EzBpZuv
	 zYseBHU2T+1vdauwt0A8FxDvYCe5Rx7LUxeQeYUltB6KpzL4JoZHI+xY59ZRAc6WM9
	 6vQCIxDSg4e7T3eUp0hS8R5DGRFmK2sG6Ov6LE9Ph7pq/DPJ08EVsJn6WnX8YULiVy
	 wOiuglSlEKgbQ==
Message-ID: <sashiko-outbox-210475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 10/17] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-11-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:44:02 +0000
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
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D10

