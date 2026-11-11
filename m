Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377848;
	b=EeTycmZG61wBG27bp3ouSgMtxC3mhQKn0ldiP7JeyMPvgrQ/AgHi8SoU0LlS22YmKix/
	 mHAOxeUrj79uqHVOvXWIsMNZ2bk50ftMlp5QBTMLopP308eZIDirDV6snhk4+FJHftIkb
	 lVyWe9VWUFdSy6sqmoMrdXmabozlMQV5hRx0pHMfgsCsorAkodQ4xns6qAuDBiKMRskmY
	 2kDarVlDk6ktvvbztMcgMTtlxWFW7Ue72y1tUZRgNaV5j4S8CJfD0yWK2xC6O4/OWA5K9
	 rIqlwX7qiXjQPmaHuGO2ahBqRhprawNoLHNgb0XMX8xNhXujz+Dro9E5+jCI2N+7AzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nAcrqdOYaUjfcEJFB1uBhX8SbX76DOalEh9QvYuSGUs=;
	b=E4OkvTxWK/4ckEMztEkAngB13wo1alQO4DCAU07pimyeZXZslJX0xOCaNupF2RIfjwYr
	 9SZ6IeMNOTDlKj0i6b7KqvuPYtjoS0164lbIZ1to0E+Y2f0/ua5KyFhzpbGkHUj2pmkhc
	 kne8ISsr46W6QqKm3ZJgE2iP0Ud+2xZ6hvSF+qlWA+EJCmt/LyPx9n1ioXra5zpv2YosB
	 7vAfalKxzXCj+Asd/XQ6ZDCuD6Yyai2a6J5H6qdT4FWuOBZItmEuS7+qLmqQHfg7tM0Uc
	 RK4Hwwd9VOgfthSTgLN+Tzj7VJI6V9TSmcwmwQoEGxqiLf07NK8lDNzvGVFIM5e09HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEdmgSYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE8606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZEdmgSYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9E61F00A05;
	Wed, 11 Nov 2026 06:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377848;
	bh=nAcrqdOYaUjfcEJFB1uBhX8SbX76DOalEh9QvYuSGUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZEdmgSYckv8Wd6scfcyHYgslseWwqgz2LdJ/nx2pBK1hOjtXn3npfpyvXX1bqnBqD
	 kSM2R1bNoNlectSJVTWJ4zbc8CN1C/8IpDsPRzW7GIImTJ1IEfzVBPqBs4sAona128
	 UJNZxUUFqPH5P3fXVDfMZ4VD07E2kIshf0N9l4BfEdBg7QhGSflaUzmp8jo4qIEnon
	 X4N6T39+M6WX2dI7MqUvFhilrW6GPZWXKSX1VDuxb7ew3Gy8fmTgyVCz9vggzkIW/e
	 EZqWNeTgxqihY81j7msJXU1hL4KvVrvrpCjfBXeeeuU3KTGPTNNhhNpSfAlc12WKwy
	 oyCtBzcbXaxYQ==
Message-ID: <sashiko-outbox-208424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 12/16] ALSA: virtio: use request-owned capture and
 serialize recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-13-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:17:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Receive capture into request-owned buffers and commit completed requests
> in submission order. Append actual frame-aligned payloads contiguously
> to the ALSA ring, preserve a valid STOP tail, and retire empty requests
> without inventing data. Bound occupancy and report overflow through
> XRUN.
>=20
> Add explicit, default-off compatibility options for packed status
> decoding and capture pause using RELEASE followed by PREPARE. The
> default capture path uses request-owned buffers.
>=20
> Serialize control transitions and preparation by generation, keep
> payload and DMA ownership separate from the ALSA runtime, and stop
> admission after uncertain control completion. Preserve linked prepare
> and paused-error recovery semantics. Reject new ACK admissions after the
> core buffer-access gate closes, including linked members that have not
> [ ... ]
> held. Each period buffer is allocated separately, so page rounding can
> make the allocation larger than the ALSA ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D12

