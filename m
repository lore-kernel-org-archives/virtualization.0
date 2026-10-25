Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792908123;
	b=NuqxIjrmjFl/SdF/i9bnX5eGinnSRgQbTu5YRPWD2npv+gyXLZ6rtTDsewSj+9e7W6CT
	 HVKXhGrQ2KdxrKiFsXjnkXlsAPJzBjOt+Zdx73ut9NcHaEceemJUI5qw94Q7jOMZGyZjQ
	 3ErWlW0kPiiZlVVleVw88dOfQLnm9R0tPpxM6VmYWyuTOccUw3SqUs2DomcQgSCBnLa1w
	 HiHfq9lcmEnH20g2UwsU5MsN3wg7M2sp9vkO5DBWqpGHgUnQtckO/htFGi/M/v+WO6dY9
	 U7iZnH6OqUE+EfHxSbJGpTgElpFEjuAr9D4HNK1OHHQDqfQejk194RPfbeZpLp26cwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792908123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mBVRPsBLeDR6kS/f7aMqR6L2f6PpFkB6pDEFXN3SQ/w=;
	b=GNTf9wqheuUzodRh3WEL+Q7gacTI4oO31fZi4BU65GO8UwaJAnOx7JkkLod8v0+F3WiS
	 08QPjLmf3lBaGwQhMOEyr3JxNh31G7xaxogwx+OD/wpXg0HY3+t8wUv71g9TXsl0AQoYg
	 pMJyEr07295bgH7Gook+BJKpiDrvLHFQ7Cn6c58FYMRj35Ms3kXxpqIQO+LWs6r8++9dC
	 1hYXsoIUvhEHyLqxW8cAh6c9ST4j/ySmocVXIKMd4PjAZhuNZ40kP6uxBDbpBxFd4aZWd
	 A5cD2qX+v5y8KCeZ74a85PzWVbr8A1qbuxUnqNbg0j1Kb8mpiQmwgYMCX/RsgyVNRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWDs7pmP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C325606A31A
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWDs7pmP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033511F01825;
	Sun, 25 Oct 2026 06:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792908123;
	bh=mBVRPsBLeDR6kS/f7aMqR6L2f6PpFkB6pDEFXN3SQ/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWDs7pmPFYlhey1gFRsJsnfcxjCj4hnKIujNf4T7G+dBHC26h/I5ORCoF86Xd4AN5
	 pnOh5Bwdo9E0Vsd6FV93uw3gSj4fuNbvlq/P8UZMIg3Wb+6DCg1qH9KbMZqkraCp6f
	 vW4tC55JL9A0u4VlucnM1vqlqZBNRCe2aTOLNOPn7D4u3bEIMv9mEEQ7Co8/pyY2Qx
	 tPIrLqd/Ve9wN7EeW7pqAHYatRldj9jvRjE51SvmGkecvUqKMijzbuoali5cDMkyt5
	 7k1Kz3EpXw44BesXuYYKKi0VoTXn4n5gYKNFOjcm5AFnYtpE10oXIbqry3P8hp0K55
	 wJcY5cBCNn3VA==
Message-ID: <sashiko-outbox-184092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261025055702.69259-2-mynameisjune111@gmail.com>
References: <20261025055702.69259-1-mynameisjune111@gmail.com>
 <20261025055702.69259-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:02:02 +0000
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
> READ_ONCE policy sampling in the following patch.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025055702.6925=
9-1-mynameisjune111@gmail.com?part=3D1

