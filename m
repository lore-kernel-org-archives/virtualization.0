Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264565;
	b=aMXtItr+si4UN68ab6s0Pu8e6+oeWtqTWzBciD/R9wWRZXSZE0+C+fP5z1PZbW7yf1wT
	 XBWClzRys7j/oYFWt8tB0n6x1kw5U97+n2cM21QyVMEAHBcNohF4qvFuoHt1chhOi1o2S
	 x8Fq8yAv/xjQz9Da/loMHCndJJmYsyUvH314rn0FfiJTkqF4LgHlh+GtTO6qoqkmQ+i5y
	 IN3i9qR5mKh8wdnikEUGIAPpG4DAnIJPKqMz2ZOC+dfkTtZXACMQjnpGq2N0bPZCEqFZl
	 wlJCojc8WaWfSrayhjoUR8iEkICvCSmlappePncSTXDxPVIT/ng3EVFbL9J0yurpx8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Z/JWLODJbpelFQAYFHaDWUTx+ojXSVPSRas1UBIfZw=;
	b=kqDLxetaUNc7ix0N1UxzhKvnDqktyeCkKLz5d4TD9YShzbzz77kYiae2/MROTL+0N/k2
	 GrWbuRd4naWB7L1JrFIStQ2s1mw/UBLswkZhpa9cVdLBwVS7YwtiQFwRKu7k34PCugpBx
	 i02Eyd+4Mjs02v7JzmlQ38tg4B/aHFAfrl17pHD9zeU4/wTFj4YB5E4DQh3LnRBSqaqON
	 UUXElxl8VnldAIUhp+dzh914Ki9wO1kqrJJwejFPw2OQAxZVasaF+/4QSUOidyxdAPXhL
	 +QIV7s4G9sIDZIbT0eObBzLUz5cyT39+EP89rlbjoJrFrZ+yF/xA+gsyYTsaRIpFmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYaSBmpV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A560A262D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYaSBmpV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0F31F012C6;
	Thu, 29 Oct 2026 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793264564;
	bh=8Z/JWLODJbpelFQAYFHaDWUTx+ojXSVPSRas1UBIfZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYaSBmpVbMLS2TtAWRQG5Ck+2oSJPZZJw84k4uPvQwZrK7H9B2ojaNhVgre+NFHCB
	 UGBFq0qlGJFQjq6AKBUDfdJU/SczgyuzOhskSSaW4AdkbmkhFibXcGvv5zJ6KNsF39
	 rKVBCAaHu29Lj5JxUtvnmHgbaTc9JQHp1a46jwQeDjWvMKDZ/n26YA2vczUHyeokhF
	 oe/etXR3v8lX4t5mzzn5BuvTqXZX8mYuk3WyhXLl8DonSo/dcKZWoImNv9+on7ZB3I
	 qVkJ5cWYZ2ExyPwcy/GCZKEJ9ce1OOt67LUW1TzW9dMuIHnar4cWg9JuPQTnfBJi/p
	 7pe8BRo5VkDBQ==
Message-ID: <sashiko-outbox-189002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/14] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029085032.70689-6-mynameisjune111@gmail.com>
References: <20261029085032.70689-1-mynameisjune111@gmail.com>
 <20261029085032.70689-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:02:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and payloads
> in the reference-counted message so caller cleanup cannot invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure. DMA
> cacheline alignment alone does not guarantee the structure's CPU alignmen=
t.
> Align regions to the greater of the DMA cacheline and control-value type
> alignment, and reserve prefix slack from the buffer base so typed accesses
> remain aligned while scatterlist regions stay on cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029085032.7068=
9-1-mynameisjune111@gmail.com?part=3D5

