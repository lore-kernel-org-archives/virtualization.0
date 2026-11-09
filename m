Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201907;
	b=i98oGD9CjB/NGqGjP8319TFAGKcVohBA8L4oq2nEDjS8d7ye50beusAo0fNQM9TOwkqi
	 IVggvmOXIRbVzCiSvo8bncCFrHSAaNO91ex6AptIzduyOMsUjhPBp5U9ug/gSr1xZqUJ/
	 jyIhKx5RjVzQkvjChx0nA5O6ttiw41+ejhbGAAm3IDuNlqCzJ84KA3h0SZUbKXnDKNFGG
	 f6wovQaMiU3Et5WJzA4ZdkfL4/wvt8y5pKauYryGRno0MOLNzeBLaeBGqBkkcjadFQWHz
	 MW9GFL5AX3nfC/Lsj7NZi6z3tUnTix2XxDxYNaLoWO9ekp3LL/Pl/yB85T/8JwfclXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VFb6gHU/2zyxh+lMcFzw5uetqRIdcBq1UPmQpfVrmIY=;
	b=xA5e/FMOe2fygK3/10tuANgGStyoy5awyfD56KXlGqE5dkd0bmknjeS1+G314ShG0a1F
	 qf7t1oYwT7YA36O798iguhkBRAF3psOwthMb2H688cgJnJL5wQcUJQOW+M7eLAYHe5R/Y
	 Z9pId+TBXAy7KKwq9MXpzQn+Gz60+f8awNHRXa78Y/NPCSG72Sw4CxCamToXGCzQBDQD+
	 3+q61Vr7G3yFvNsD7YzB41FmezXfQS+VEWOJn8wp7XBSVIlIpXyKlcpoAnhdojYft0p/5
	 5PJRYsAgKdcK2xJ16u5cZ6CkuqMkLin/PK23SkzPQeVvUZSZE22EdiPkyMg8aB+NDVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPbIlde7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE61606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPbIlde7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE21F0089F;
	Mon,  9 Nov 2026 05:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794201906;
	bh=VFb6gHU/2zyxh+lMcFzw5uetqRIdcBq1UPmQpfVrmIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPbIlde7CEZ3aWHWQQ2CRe4erLjkDzqy5n1Pdp0PJjp8SOx9AV/Hj4Q7GSkX2Z8Ai
	 GlxEVX5qvsJUkRJ81hgDEAVMt1gPDWDqYdLB5VF8SXNFAbrhJEsEkiVyU+Ilu7ohig
	 NDUAANrzIad3sEVo9GUV5zBtZGD/h6hHSDgaFAYYumLPNO/F/hiq4Olr5db05uRVQl
	 GofslW+hs1Y0NCr5SBIdu5Do4nxyWCYhiKAK1uWcclKzkG+gMW/C4UWmzOfe6lSmko
	 wpg4cOJtKss4ppGRPAh9EbZEk/0+TCsxP9LxnLTikYPGn+dOQKkBA6bErPc/NdCdVD
	 s4DPFiVZgUV3Q==
Message-ID: <sashiko-outbox-204433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 09/13] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-10-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:25:05 +0000
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
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D9

