Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268311;
	b=NQUsFrJkMeQStvyir7uL1VtgzDjd6qMrDjy3RSdfb3r3sDCGMD8+ZJPn6VBjgZEzk7tS
	 d4u4xf1akYhd8dTqcp1wopxQ+lUcFQ3BkC0oDFPQIsVa6jGqCAtn0RiCrTrvEmBu+w91u
	 1+5ky12HukD5p7iNBIU0WGlrcWZqX5ZD6xD7iwHpEMOHniwClvIT4eFLv8MvPhXXMw8jb
	 2Rz77KKG08hLl+GeMH9pZCMsTPi4P+pwDr9aoq5xGvj36o8Y573oa9HokgEEwMghg6NAl
	 tTRdt4zmoKGX03Ai40Tm9XFQcFGlC5g5Ims4TEOgPz+VMI0CzvLXwdL9oqiYOLcMYmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=73+OTCVsyA/ugAIKmcg81qYgEH77wfKaFci5B1ZqL3g=;
	b=cCMu4pCsUreVOlOffVaHJpSQHltL6DYir6DxtLQP4aYSu93LDxExWijSxBY61SKIVS/5
	 eFWiEEA91Oi3HQjdLDd6x2v+0pl5PBVGYDjX8E4TYbGcX5wPaXKdJQiMNOorOskaK6LKK
	 aog01/h1sA2JLwzHH2eLaa1eD+/k4DlGFrZjjyHJEw8WzlKLaFrljNAeeY4wxNTFxPa9s
	 +XITJo4hdWoRdTvCeCN0/+ASH/2IHCurawP2p0ORMXSu0A2yahNVlIr2DuXdzL401cz54
	 7H9aIlcYIjA7l09OYGs3AqzaL08cxFO86fIap2/jzMtMY1W1nyRXx0ilGoqw9wr4RrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVfptvf4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F35606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVfptvf4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794611F008A6;
	Mon,  9 Nov 2026 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268310;
	bh=73+OTCVsyA/ugAIKmcg81qYgEH77wfKaFci5B1ZqL3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVfptvf4lUctNRBjX69oX345BhC/YKB0Yo0vQOxJe9Lns9qnKcr8rSTnhkAV2DUeZ
	 Teca+lQpR2p87cwAqCcvfHr1nQPzdOUVMuLti4+L5MqpjKiIqeARRQkfz6GmaECop+
	 +FR3AB0FKyZCg6gHH4a1hMWZNHlZRMUaObSNYlvwTOyp0nYDqZC1MP8h4Rq0KH8N7e
	 MABbqu5DMqu4UQJqY4oEtlWpfi7to6EnptLZMJh7QqiMK/lkSOglRwyhmf7LAR/C5x
	 wn4fzCjKNMcWKdPsO/n2fZOUrd1Ek9dgOnbtHrTNNMp2IkPZkqnpSpmtDgc/wI3rQh
	 71IHp/9Bq9opA==
Message-ID: <sashiko-outbox-205797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 10/14] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-11-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:51:50 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D10

