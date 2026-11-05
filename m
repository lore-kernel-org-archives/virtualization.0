Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846383;
	b=ZZNOnk2wME4m8lvlXntyb2MdrHV6tpeWBbhtOXdy54GCpUdahctdtiHO82+69JI1QCTL
	 adBY14InQYAFYV1dcr/IEkL9soALs7b31NchU/RGnGYROC7IKqwb+nABKfkwbuZdSNIVB
	 44oPXPepxpvD6Q5msePQToJnO7ED9N5zdsYBWEzZeB/cUUHZ7jUUJlYnhkyMsSRczHmZP
	 PGvS/OHKDR1y3HgY3RG/AGqUN8J/SgTjJEyWdoEan3m03402wo83yIQ8E5vp68uRnMhEh
	 RHFpGY5znZ39urdjd19NSVI1WdaTsUAAYUrknVKYiyzJ68TkS+wiK6VQPpSzWVRv+uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ww5b9MaOipj2aEHnQaXdgRWrKmuLH1AVkV9KsFfBnmg=;
	b=EOpEEuyKuWnim2nkBBizJtEXkgXwNvzarMcIx/FcDBLKgg20VjiIE9Aee9gL3eFmNKSH
	 PpMw2djlXdDpWed4XIrsUrD928sorRv/bGCSPJILxNcat6aBJQ/tfDV6vkaF2yLBz9z0p
	 yDf/c7h8q8zVhNt+o+M5Q+CrGzJnMMeH358xphMmhw6mU7k/NtGyNRKBOGkf7WTwleLsl
	 bQFby6DcWgyEf/d5Wy3tDuIHhS9q+P6y7fIkdgSbApCpF98lha/FK9lkCtmtFilQqyQfI
	 /HkLOVm/o1+YjeXU2ASbnZj7PVitzGxWaP2I3l2Og5X96rxCFB6vyJ0VWgt/JCiZIdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R843I7VJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244ED606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R843I7VJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4AB1F000C1;
	Thu,  5 Nov 2026 02:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846382;
	bh=Ww5b9MaOipj2aEHnQaXdgRWrKmuLH1AVkV9KsFfBnmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R843I7VJfkZBAqhntfhJFu/s8OZpUskkDfqpXlhryW5Z4wwkxjWz//jhiwZycGq2s
	 RuSCyd8f4KDTGSDEMca20e/Cc0iDY8b+f0PbtZFDowEtbPo95Q623T0XYP2dv+w1OA
	 S/1zWJBpV1Yqmu53SOez/c21b9lgGzIYClKEJ/doeaTuDrQKrv8SQm9f0sXiiKl6nr
	 +s8f+yhruKg4t5Aan0eZvRIZnyYcm98JT20M4OR9OF62SjTDFJDIh98sZVcaZ4hmrU
	 yCqevoflGHeUHJxN9sU2Zi39sXvbYYSRnKp8wdZlaBn3jk1famRpxpcayJ8h8nwe+t
	 GBKGotUh/xKhA==
Message-ID: <sashiko-outbox-198472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105023140.18373-9-mynameisjune111@gmail.com>
References: <20261105023140.18373-1-mynameisjune111@gmail.com>
 <20261105023140.18373-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:39:42 +0000
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
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105023140.1837=
3-1-mynameisjune111@gmail.com?part=3D8

