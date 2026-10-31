Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413260;
	b=c3ZgK3NcU/V8rZFQM3hK6jO8mzXTtAmzX2EJdgDyBYn9YHx1V/St4IhXtDCrXTDQkxpe
	 V1G5IDfwUnjmQrXwAVeExhvUvr/6adG/zTuZ4ytxF52+cKpdTFbaPOCA5QenDg1qa3RRp
	 1jDyqEYj7zRmRDZmY9kGPkzqNNc15o1peGWCXoe01wJgZalTY6EbbRAbjYzrlHeWBowWg
	 JRI10liucNnK15FNVGEZUlfHH7zrkL8gvNkkiXFkUAB1QNL5494r//RlJCUitnXkBrAAk
	 SBVpNRJgc7YHjzkr92qAN/iwDcLd5CTxA3+lybL8rTMZ9B5whBHiabHl9F6AlE1TDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413260;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MfKY7L9qOzcuTfvexN0EsI/DcH+E6o8dXHPP37Vqu0g=;
	b=TKCwFbTSrxVYVaM1y3AXy+nb2RpncPhsiSx1Nc7YscaJAxXZ5gGFZ4zNT2k9BQ2jU3Hw
	 RxdRRHVzeagFBwnxrj0EzkS5j48KzQOSUk4rB9Fv9OZkA28KBHt196+ABx7g/ZXAx8FoP
	 nNn/YhtKsEA6rqfC/sED+VFzO17B257PJotdRHqNV5DXJEysval+rmMoC/9wt9p7qLW0y
	 zHICCf2Ev2WTBmPxaSK9QP3Pg6SjHRnKFMU/XTvusvGJUmhbVE8ebeo4k/kumMbbsS8qa
	 FCxRZuQVOb3QEBbf5Fz3GQBz7C6pwTlALljF+vcFaS3K4UTl2hkCaEUqUQKKm/0JyNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jf/02yir";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB78606A31C
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jf/02yir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6651F000C1;
	Sat, 31 Oct 2026 02:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793413259;
	bh=MfKY7L9qOzcuTfvexN0EsI/DcH+E6o8dXHPP37Vqu0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jf/02yirdbib9C4FEMoIWhp7O9PaJO248oI6+B35bZR8D9RcdCPxvtcnYtNatJmOR
	 k/rbrTur/cyx7vRBFmzScqIxyq9W69PqtuVsngeEgbhys1P3bUvUv8r0d/QvmTSLxh
	 1lOgjLXupnR/X0owf206pIBum7peEZ2v0TUQHR0dAFlTbfvs8DIUkdv7WO3Coy3OA9
	 3Xvtus/P4V/db2rO85O9U/vTOGVr2FLKWEFaVOMvbqrnPzoxEhpA88QgrA1Rkngx0C
	 1bRa4jOChQPq3uiCwgIbuIzm0YDSRxgEznVhTenZPqtIFxFEFgoatcZwKcyuCeXpWF
	 vwG+jjdovpEKg==
Message-ID: <sashiko-outbox-191705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/14] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-13-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-13-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:20:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery.
> A negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> [ ... ]
> callback retained an acknowledged appl_ptr of 64, and finite-silence
> playback kept the written prefix while clearing the rewound tail.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D12

