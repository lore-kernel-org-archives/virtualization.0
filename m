Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C1342E43E
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885683; cv=none; b=CQhbc7hUKr00JU1LZfPG/KhY8zEGalE/mLOZRU7BVOsUJ58xhceeHadB0kxWAz+5kgKuD0nJlyEaputSf9zqrbOeW0OiRiucdyiFcI++eItWLj7BwXlVP4ecfNZ4SujClPtvB7ZBSLhMEt1Hw4vNSIXcsoe968ZOaFW7EvYXlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885683; c=relaxed/simple;
	bh=jXmPy2lXKpcAo3UpwkwgoNo2pUe/1gn2vRB7ag1S7HI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l5iJSlaeDUHkS8QJAiEb3KZbbgsYEZZ+6CCY0Dn/AJnHHXNXvjO9qzjxy8ucHL762UUZuzPSeN1XRZLiIahrJq4UQg8GpjjAUW7N0uIICYnx8+7QbKGdmfx9HJnxa948/Fe5e+8PMzEmNFihAJ8z0bFwRiIYrorBDKWvQsKxsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJsT9XrJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJsT9XrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C31F000FF;
	Tue, 13 Oct 2026 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885681;
	bh=jXmPy2lXKpcAo3UpwkwgoNo2pUe/1gn2vRB7ag1S7HI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJsT9XrJa1h+8xxPbECa0bXNPEtZ5ylU4CfS1+fpSo+eVfCZrRLGRsZlIJJPnxGA2
	 rLFULBJyNTS+vQzxZJiq0njtqPB5RmdLoJF3R1B3W/mt0smUw88hInTiHIUFLwhuwr
	 1rdGzGHWOTw2D0apSJ+RKIACG3khzv9uHnhwPl/Ts4Si9Do27asWhevo6ccFYWvSJl
	 q1mu/E4EGlKzcIndWxit0ESyyAX5RPTTypUfLQWnkaH+U88UuLZofnd4jsLNWZPg4h
	 erLBnpteIbUP6ZVgI2G/wv7KDiTLXIBX1aMy9rC0XD51xQQa4b18tFqI1WTozF6iq1
	 taDkwXldw7N5A==
Message-ID: <sashiko-outbox-169429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <d58a3ac9b1719fdf8ce9d286be606128aeebf1aa.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
 <d58a3ac9b1719fdf8ce9d286be606128aeebf1aa.1791881787.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 10:01:21 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

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
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791881787.gi=
t.mynameisjune111@gmail.com?part=3D5

