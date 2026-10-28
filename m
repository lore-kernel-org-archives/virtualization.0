Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182335;
	b=OgY8Ba4a5AaIp+RcwAdigHwzN9S5YggV3wT1wlht39osQmxfQ7O3BwADuINPeBYYPUqs
	 74Oah9+X/B6ClDAOCyjM4zkgZj1FAyEE0Ni2B9wMZjU5QM1D8FnIP1rRjOiXlMsRC3dSb
	 0YkDGhExCiB+PWJ4BxeJr/uL49dpU4cRziZ5rScM369rwqmJ7uS6MW5xuUT9yj9fk2ivb
	 FjGHqLJ4OLOh+aSK700A0VG5LIkASPvJDCpZJMNKm3m1K0kv3cYTGGTrPvgAZ0+EJrDrT
	 VHLXNKJ5eon+xdkBqhwdys32BBL0BsJ0arwGZbxi7LCYefus+cw3iQKG/jeKzhMBBZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0hlQsFHoZ2FHW7jqGzp33+w9ncl0yMLbiMGgP2Uj3sY=;
	b=A80MSNg8j+J+3dSTHvL7CzatKa5PV/6cKIhXHS5lt4zbh65aEZkZQSmepGerk5a8w8X/
	 K95fAEhVHO9FSFBVfxLVW0VVpD+5Zg5G/QF0rC6NiarfWbBy+H2UkgWJqMNTcJ7TRBBwq
	 bqT8wBOvfpEYeks9b2UuYJQL4M2w+3O3PoHPdb7KExa3t1a77CfQKdN5xK+Qsuwb0gdNZ
	 pw30CqN+bmFwtmKhwGeIxfBljaFQLrrAN0ANQ6vc8l07KEZYNKDiYalItPhtOnjk2NEN3
	 ikG9o6CR5RFHtCau5ISChtA2orJ4YQf0NAdeYU+bbc2rKSpuQ9Yi+60Gxa+ixt7cXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZMcrnCD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C6606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZMcrnCD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085B41F01825;
	Wed, 28 Oct 2026 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182335;
	bh=0hlQsFHoZ2FHW7jqGzp33+w9ncl0yMLbiMGgP2Uj3sY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZMcrnCD0MwPW9KYUMlYi1uvk1uPdz4LlT8n2lsLMEm2VA9KYupe8xuyJHSQs6pjp
	 EpqhiLrNyDj9IJtroflppV1d+rrFi8TIn1myGcfpOfKlmXGaBFpNGqmU4UDTIE/mwe
	 X8TI+ei9Etcu7FntOYr2Rf5rjRawpG9DwotKJeE0VY/0zLkXAzUlqOofoNEtY7lb08
	 eM3BCsz9c/sbhmjYtM4xAMki9LxhvXV/qvvPuRDEcR0W48clS5Lio2/oJeJCHyW5Tc
	 la5/qhDneBcI7qnnqSb/h4QJRSnrsfi9ifJbJEVNV0se+65pL/yAeZZ7ywBJmzoqa9
	 cDqVuHRi5h9gQ==
Message-ID: <sashiko-outbox-187731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/16] ALSA: virtio: Keep PCM DMA buffers alive
 through device ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-5-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:12:14 +0000
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
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D4

