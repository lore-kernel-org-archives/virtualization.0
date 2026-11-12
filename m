Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794463368;
	b=Jw5KY0jGD+5DiHwagmi6UYXCSnMu2x0PMT0AvLLAt/LFjHHSWnSmaxUkNv4zg6NuGBPS
	 DSQzEhUJD3fV+1NKySAXbNjO4e2C1Ti5D/XMlVzK8j+vWtY/AEzXA88vvErRe4iGb2/yC
	 NQga3+dhYCWQb1lYv5H9ckT2P4KVwgc3wPXQzTA3Uc/I9E//y2aNTfimjAzIhgE4hPPgf
	 bRj5VyHkVEojZ/thZHerUqHqMI/4B6gIRmFqXmLb4heivaZHvo+JAbOerXefmtITUmuSK
	 wpksRJfP3QOMRPXBsAtc0f+nPcr5UjruuEU1W0p/uHgqSUJQzHH2CoH5OwdTlLqLCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gkEn+arF+2uYCE+akWsJ5d3KsCCEN0004PcwsSbob8A=;
	b=f8hDCQ/pAWw2DBUwKeR/RCfsrO6zpyjQiua8nYdJwQdJ4jx39c6zSoeVjNPcTz2Qcl5G
	 qq0MgxSYIrFYgh1YUbZSVX0f6CwAwoGmbpyP4NwzNlCVb20zU2EX+8QBy1Lj9h+Zlkjml
	 n0BDKQEIoZmMsxjnABK0M1d7z7cUzikk6C/bz5AqLD1Ef3yDyhDQXbSuxBM0eNcZMlKpB
	 fK166rSgm4JzrWQ8XUJ7Y4m+Cb09fpqtcNTyQLiZ96e+H1I3fDHULyAjlHVgiVu0BuSMm
	 W662CSOliwsuhOq7FFULb747vC1duQaN4DqyKzvyPuaBQHBB4NNS5T8zLQb0zQUoRoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E3/1etIh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5012606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3/1etIh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA7A1F00A05;
	Thu, 12 Nov 2026 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463367;
	bh=gkEn+arF+2uYCE+akWsJ5d3KsCCEN0004PcwsSbob8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E3/1etIh+vmg/urB5Qnkc/+BEeq2j8O/k73XHXq6OTL8zgMTpqV/Mkqipljm4lT9o
	 mFwXPNHI3W0m9MRs5bsG3m5it8yPk+N1+XRbkldEeLq3BfxWAFY1agw7zb7ojrj5Ym
	 u2rqNSLdG0t8AnEuG0LBcveFfMQAmpUBadDqRbej9p8ITblLLPGn7O8Ph15SkmNY/f
	 4/klLPpcM84P1n/+AaMisNjvFPtirdLDQRnCXLzj0QkVrpLzsiCiYK66AIkmIxauBc
	 yJLVXHQm+IeY9LrTuaT6pdIbNoobi/7pmA/Oy61KaIEfvBJwHeR4xP45u4hu5z9MaH
	 Nws6gFSGmKHmQ==
Message-ID: <sashiko-outbox-210492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 06/17] ALSA: virtio: propagate playback send
 failures through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-7-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 06:02:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Propagate playback submission failures through ACK and commit indirect
> accounting only after transport submission succeeds. Keep the PCM state
> and buffer-access checks synchronized with playback transfer admission.
> The existing capture ACK callback and initial queue reservation behavior
> remain together until the request-owned capture conversion in patch 12.
> That conversion introduces RX reservation, validation and refill as one
> contract.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D6

