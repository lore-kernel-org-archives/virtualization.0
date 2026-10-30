Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338564;
	b=mgnLPb0/QoWKK+gsuPNOwl7Gq4YODMTLuncpd1tL/8dycqR7OV6MBXXpQJAFUPIdlDIH
	 SvoHhX3eDg8cosMhGOpfRh8ip/jlK8Dc4Q9r1kc0r3+a8FSShHE2igngzTohcjODfIN8L
	 ERObrjZgmkWtW8/+xg2sruqSY9O+QkE+00fs8FHJXTK6Nv5cakp/OWHlBrYuIxAGSbCeU
	 2UA9M+CmLs7e2dzrrlxP91c/dDmGBmMOUgBN/djW1YwvM0BgwSy5UZW0DlCbeNMTJIRGL
	 UFAcWjIjRppNuoBc+M10lxQXQQxWhwX7cduTtfruybQX6TSpv8/K3eJlRk0e/R5xFBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UkjACxqEDfmJwk5DGc/5d7WATlZJuCbKCAwhZPR6Brg=;
	b=XLYqkdioFrKNKQLqmm6ZbLd87vMalHgFuIqEYFPqifMNAodqFiky+/E9F7IbG1zkcnl3
	 AR5c/pTiO5tKbkc7aX60V43iSEPdhMjEG79EAcEkbta6P5GITMl1j2LghQnGn+eVj/qgL
	 Qey4/VeXwdxLXVoZ2fbYVyKmzgLqzJ3Hy+6gCyxpqH9N8/Z5K06qfKHEMNb+2YksKYPL4
	 X/HYRZL36VPqEEnCPeOOUbJUl5MQOXahEQ29r6oxjLCKmfxjUZzS96GXoafNlq1wyXmYi
	 /RlFs1nut8wGC6uLVEUWZCRA2RGFCoPdmhof12WZqLnwZ5ZowheAv5AW9phPBE+/5Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IELJKmhs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F78606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IELJKmhs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC69D1F000C1;
	Fri, 30 Oct 2026 05:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793338564;
	bh=UkjACxqEDfmJwk5DGc/5d7WATlZJuCbKCAwhZPR6Brg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IELJKmhsNCCyadEASp50+mrZqZ++PzSjCeIndADgYIKRXJsCkBUkE3GyRKbyzi+fO
	 LybF7AmCHMnCEPNg9/gTgIawMI+ZVnnTKnjSeHBQYLV8QoTwugCN9qr5bXUtjm1jPI
	 dkaNhQ1wrRQBnmZ+q/qmXKcuF8XHU3fB1V8onSQ3moTwkUMohe5/jDjushJf+Nl5to
	 A9mfT2ksTO2HYBUd7JzU1hzdu8IGd5gVlNC2F1fl9RJqm4XRPeumLG9H6ancUDZwWT
	 CRTyFjNVeuv1Oa1+vRcm3B2r5J+1RAmMzrFmovukjpv5Kt7OozluAB6btrmmGQ8Q7d
	 eaac/zSvm6rzQ==
Message-ID: <sashiko-outbox-190568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/14] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-6-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:36:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D5

