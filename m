Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267914;
	b=Io0WMzY1OYlGGtZ8iqaWudvvp7rwofSvd7A5XSeNoDJD0drUjjKYjEO8c1aQTYZA5Sz8
	 FOrMD0B/Ox458/CkyzROspWCJhLQJhIU1VvrTk+PqrcqNXdXGVndCA/qpWuHfHPjqfG5j
	 rTZgIdwsVK1MQ/oOvIsxX5M+MYJ7vBcLn8uqlPQ6gt5hq9qTVPXr0ZNh3nDMDfz27Dygq
	 mWf+voKL/n9tQ1QSsZ7GL0MCEKvuWlIYirBf2VX+8l4X0g03bWtSE2mvrg5uAwBqcmBMR
	 5vO9XFUKxtbofWNq5XPWDYa6ahfO+TjnGrNSKxOw8e2CflsMkwuYcbkherYTV70qNwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HWV6p6UbG/zRsdgjX52NzqhMo8PcIK5yb/1+onnaBnI=;
	b=sN/Qa2/vA81CKTTRTKFC+lbn85T4M7ncKwacH3SCpDccXauMNhJpvRtKMVALG0AfZw46
	 xg+IRsC8PTlxWuki9FyXz2lzhgkDHde4S8mv1a9pPAUztYmAut2p2Xec3wOyLzBJafTAZ
	 9TuM5pErIz8VrGjcM2JGiPuKIo+mdVBU/1JSs4QG7yL5dY2MMY5qXIHNXOIVocBZLk2Nr
	 hU8/2VTSH+Ye8Il+OOKuSbMKLhoopc0SyCsjpZXQUietx3ajoJMIVgwfFxo+vtTZSV4K9
	 oVVfFTtSsx5PrcYcq2gUA1TEMZM2FqcBO398/Oe4QQv0xwABvRhjx9ZhsNL3/z3MWAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOVlwDsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6D606A330
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOVlwDsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29301F0089F;
	Mon,  9 Nov 2026 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267914;
	bh=HWV6p6UbG/zRsdgjX52NzqhMo8PcIK5yb/1+onnaBnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOVlwDsFjxOGQ8avPqJPEwvm0cDudhyU+eLzzYmDU56gSsy+k67naSYBHlv2yVnHR
	 X4M0TfcBOI3McaiLHsQ/+uDlNG6qGfZbFe3UYRPwIrKEdotncXaJnaLf/IzQut/gOn
	 MUOLFVB7rpCKZOPNo6VzYMgEr5jlqa7Vndi7FsFY6sy0WyIthACAbc6pOXVjo3VTVs
	 nVFKL7vtf3rgqc1b98rhzrWkdtbCH1kif6NMPriOTabhKZ31vn2gfaMnvsmBMzZZhq
	 EWWV0GeWBzvFWF9YCYR2WjL0ftsa+yCnKAAt2KDf1j8y28f25Ad7Y5tMc/UzeFHrxL
	 kZf0Fel3MivSA==
Message-ID: <sashiko-outbox-205790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 01/14] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-2-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:45:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> staged-capture policy sampling.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D1

