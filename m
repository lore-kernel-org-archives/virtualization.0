Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450461;
	b=p8Ev7dNpBZGP8D0Iz8QEu8U6j95uU3xVRvRrXO4KKsK1OvrCtBiXdN24Fs9LqHO6PllU
	 ULEy+nwgJuP5uV38tzJxtucCqiYt+/SyRGTzyrtSgp/CkBP5L1HJkgi6lU2Oa1iDlCB6e
	 riGzFhDKOADKqIbR4GHJ2E1pyvKRlvOp133GJV33NPNNT9oe5/7lXdwUDV4e9ZTUZ5FU7
	 Te3VANZ6UKeNvhTF06Az5h5ip9+kCaOcZXaCaQSILwBiBxhcX6QLdW5qjKYblgaTVI455
	 gBlOjh+ZsZUT+KikXvsl5ZMW4c8IuhqogtxJ4dPOJszrtwvJFd+QsFS/iD9rwQPLFrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450461;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9YwEppL1HObbZFcSKIlrfsED4Z0nIutq5UPWEedkxvM=;
	b=YcUmCasG6wKpTRSxg2hrMPqjLxnMtNtYSkp7hBKlxvn4tAkaXIA5PZwU6HZOL1GVweqY
	 EMW7fiL6reMSEQ9HK9pCvXxG1Nva5dBbujitzD4zmNRPm0vxm31L86Jnb9/j8MUzMd8KE
	 plj/II1Yg8ln/SCHgOFXlGCjfo9kFho01r2tgKeymoLcnMOJ7RNWbWXpY4zmAZwF54/IW
	 mVualjnlAsKIfFJ1VaBDwPd/hdyeqNP7mVoQh6OaDoPUlDqaQVMfSx0W3AoVXrqxD3HcH
	 1f3lRPf9IsCwyHLVhy7SMHnGcw1ewbF07wNE2Rq6me8fEqiABE7LidTQh3xs2OMeTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8SnR0oR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054ED606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8SnR0oR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9DA1F00A08;
	Thu, 12 Nov 2026 02:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450460;
	bh=9YwEppL1HObbZFcSKIlrfsED4Z0nIutq5UPWEedkxvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8SnR0oR3/iAEOZGW9ERySp5hQ9yrSWyJiKuz3uCY/mbAzQ1vmECZQTr+cKsYsKKt
	 6c5Q+nB5o2IYJbdBUTzxMCilE56jv+ONUqb+0+SIsuuE+QZGnESSbIpc4PoOQ8YfUB
	 UQ93HZMNPXys5OzvT4b5wCp6Egmak/oDsbyM83JSbESw7mkeJPZqSOrnuvBjtz7jZU
	 +Ev5Dx3fduF51fuFaK6SKk+Ho3/i2YxB2+woV9IUy5RG7H2Ai7B3fESeVW6AEsyMwT
	 wgvGQr2ob0q/3r5tD4WBjvM9bmvfzyiKYqXcH8r+zPIMRrUtjkOK2Ee2cZE3K7PXy2
	 1jUy28USBOvtA==
Message-ID: <sashiko-outbox-210190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 10/17] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-11-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:27:39 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D10

