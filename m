Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863151;
	b=YtqwDpWqW1Sxn05bk35nHMAMD9AOAlYXArN40eeuJdzDLu+Y/I1SLZeeBGIqXKNJ250K
	 OXryk0sxb1m2GApQFgkicrRu2JIm3gn21eNibVuF4BrhBZQM0p16eb0XeodNNopYloWhz
	 17KxroiN/n2DEhLv+YbvXMx5REmar42iyCMEZQ20gofzpJUf+be8k8NYX0rvwokVl4feG
	 H3+rU+EQ2+xPBVfZaqYuEnk5J86az5dHWcO6AL5CKS/g+hSAXq2V4UVwQRfoTzjjgyz3C
	 tuIS9A8B2OmKwa2J9uojVDETvsHgJhcZC1rJdlF+QJiZDPU0ldYe9Tkw+7PWVymPqkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=56elTfCmj9FZp3MddjsLgsgWWaDgoiURjg7k8/BvNsc=;
	b=sX0hQYuSXy1KfiZEp/XhwzKZdzqROAdGeiCSnw4xtF+JOQt835W68bdUjG++F0WCQhFL
	 0ZkB542Kw/TeFYjIghOYB9eL47Rz7z61Hk8SGDvHAWPJgmFbzmbku1hYKKoNG7iyHwiVT
	 CbaaJDnkX7HRQyijCR6Nsl3Jy7mk6EqoGbxYGZA+EA66Z74rdmZeDJcoB6OjtFRXaSM+B
	 j8DUVELMVygT5/R6HSczcoFzZg5t1Pb9XdVTgaZUdoKMJCDdkVnZNqAX9HYqZ+Qv8td61
	 vb3cytfokaVckyN0K5vVXSOsYzlvjzx8cy/pthMk5jBBso20hyhPZ/UH8npLdEUzLIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3ouSUaB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2CA606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3ouSUaB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473B41F000C1;
	Thu,  5 Nov 2026 07:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863151;
	bh=56elTfCmj9FZp3MddjsLgsgWWaDgoiURjg7k8/BvNsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3ouSUaBC9GNZBdtF5/WWbut+pZEBVjAyNp2yzUvJNf0hOrj4QjNaGOBFB1OSFXbU
	 P09CBNubVUEv6EBqtoO2vGJvVxU8tT9agHUD4yCbz5pBu2qQKgRemLKOQTZ2GEX/BM
	 tSOPdOcq5DDxmffPS8FKfubDcDHLOwNR9wz8jtI2KDfgXTIbJWGCd2WK6fCuyVuiBd
	 FyYcWG+BrT4rWLiuCj1rg49SCeF5EFwDu/htx8CjNIcxWDlVhnA6RMwjrYfHEQ6N1F
	 O0kIU05X9jdCCfjoGNMqYVSSNZsti4pDYzvNlUsrsL2FMEhDcsJsTsyULH3gHz5/LW
	 UgPyTqZP2yOzg==
Message-ID: <sashiko-outbox-198658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/12] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105070845.6449-9-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
 <20261105070845.6449-9-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:19:10 +0000
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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105070845.6449=
-1-mynameisjune111@gmail.com?part=3D8

