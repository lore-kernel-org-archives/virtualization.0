Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452712;
	b=26cnk45cNRpVDe4hvQW/bLV4GZ5AuqtQ17OeD2dZsvtb8Gana+LSGGn+ns/Bm0he1kFM
	 0kYKyP1M1vabqN1MJvIvjOVx9FvyCK+vjkCdVy8cvd2RR1FLdgD26xacwqBoiVbou6Nk3
	 YIL25n881CjwPaHCR5n4SAU7oTVb0y34gqk1Hhcz2xtlxjx53D20W6w3aRTT15WaL83Nf
	 g+P2DnASykhApfg5fN3fd7DbEORsjDZgh+SSqrlYcMdZi8YUpibiB9ul9Oc5AMPWPUAy1
	 FSVy+CzF56SkFF4MEqBbeoZWk3V/p94YplrHLSJ99lQEj1ushhJpJ+fxpsC5Rw590OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=thjW8A8oWWML0/79cc7dWKgoCgJG45jy913lBgEH8EY=;
	b=SW+My2MsDa5lLczFH/wW6u43q38I3xGqdAxsr33H3rzKOLM6jZUqMe3KajHwA/3EJbK/
	 V+mOEHb82YzYKazUi5rafE5Qc96BaRydm0G+hbVnwptOhWTBuw4ku3NoaMkgcnbWlgtnf
	 pS5pAxk6PTfHbbLzGYXzdMZA9iL2DnyQcrXiv3nuMGjExgRfhzeWj3ag8RrZ4R0NcqX+m
	 nX4ezTWvRi1zUILU0G0Cpx70tpK+vlOC64raFKaMWtckyDRywu8a2WFDEgThIfVutT/q2
	 eNHGyJpgk8SLKgQT0kHKihpQCDLuMJB5dB3FanXJFFuEp1jHUF24YKZ4TmN2xU3bvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdq6vW4N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08330606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdq6vW4N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D7E1F00A05;
	Thu, 12 Nov 2026 03:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452711;
	bh=thjW8A8oWWML0/79cc7dWKgoCgJG45jy913lBgEH8EY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdq6vW4NFOkPuIeF93E7khhzmYsvnjFhl2LPgtByCG1oKH8o9hBfYXyg+VFJMdhEZ
	 yy6JkDLpsPTqdPpFNRGzNBv7Ja+2x2GxHWTo1DZqzQsYkKMFxXdQg1lPMzhr+i/YQN
	 RymovTVa6dF0EiJ7G06IrIIQF+1MmTrS5OcqbtWdt+++gvkBdPCXA8k6/tGSN9erCE
	 E5Ipzyg6TsYwDHDQlmhl512ofKkeloxs5WjSPGoPKLbnEsVLL2jc26x1C9JlvaiMB4
	 xsSVECTmHEeIMisvtkwiMKWu9xqIJZaMfv2u3TQrG+yQhS1+vfIWjxlknm6GRTpIkR
	 arT/2jNkvrCxw==
Message-ID: <sashiko-outbox-210238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 16/17] ALSA: pcm: add an explicit application
 pointer to indirect playback transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-17-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-17-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:05:10 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The indirect playback transfer helper samples runtime->control->appl_ptr
> internally. A driver that needs to refill already committed data from a
> pointer callback cannot pass the application-pointer snapshot used for
> ACK validation.
>=20
> Add snd_pcm_indirect_playback_transfer_appl_ptr() so callers can supply
> that snapshot. Keep snd_pcm_indirect_playback_transfer() as a wrapper
> that samples the runtime pointer as before, preserving existing callers.
>=20
> The explicit-pointer form lets virtio refill accepted data without
> accepting new application progress while the ALSA buffer-access gate is
> closed.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D16

