Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429649;
	b=cxR4Caky/wEYkPrnko1e2q7RaebvvjRDE/eqswK5R7HiE2NHP+VWFAgBWT84sNLkGFlW
	 K4ugDfA0i4SoPjJVJazZBjSMSMtOdOaqd+HZ2Kf6a7uVw0JDvb4orzK9ul3n76BKNdRCz
	 yKLaMZJudIAm0isR6Ol1XUw4ILOqI8AOPBEs/FvdSTewbUnNHBzln2kXln4WQqLj5GreQ
	 sp4H29QgfVXOLdeQcSxvFMY4AgqjD65pw3Y9VYcZTyDPJhBS6umZswjC4y9b1rNcs3hOH
	 hgNDJMLMKU4LpNTWdz+MaCbNQPf6wbh0FEPTo+0TAw1o8wIrb3hBbl4lmQ09zIITh7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FQyTYKoo5RbTv06mSYT1IiAHpOPkLKB5UBrl9sMqRQ0=;
	b=Xxd+m9uRL2xuBuHz7iJAEBX5Ry4IJB3AGWoGBB/vwv2r9O63v5mfXViNRkZTyQJzMF4y
	 UtstNBfjmmGG3mzwtPYmksAzKzCogqyDG1R9WuS+/X3cZfDnp5/cs/Iri3HtjZFoiEAdj
	 Us9NsbKN7opPZDOXEhATthzF1Lfg97+q2kOpKUPMuJ2XSHnCqMcGKRXVi+e6tFNDTqeP2
	 BqnOlcOOWpRmVqaF/BugWSt2DgfeGi+Y0cwtRoDXa5dmHuWbp+rLMy3GaGKsBgVJzWgNW
	 zr52tsehMGPe0Ogqm2Wm1Szj50V05qEBiZqzWfsfhIjoCJ3riLQzCwMLT4ViguCFpvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHY5jvlq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E09606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHY5jvlq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536F61F000CF;
	Mon, 23 Nov 2026 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795429649;
	bh=FQyTYKoo5RbTv06mSYT1IiAHpOPkLKB5UBrl9sMqRQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YHY5jvlqBBib1VI4VPjU4f203XvJD/y0E/hH6u/fgeMw+AAJu8R+SGDXQUOe3V4bT
	 TOIhXS4SV9s7OWGVqQFRrWs2r5tg3k+78aBJca/9k9f5NAs36SZq5QJqRrpLwgWaAn
	 4hXEA1aVFfDPGzl0cXKpyGJdcQIzAIlXco1eN2OAXG9r/NK7wfB8kuuZOB48By3zaJ
	 lkGWMjYF5KuEW+cDcStd2zuiyYIWDDnw28rWv+k6JaLN/0v2RTe/VExOGLDSXdX/e0
	 igiYoMFW7pz3jj8Ib9WCJd/kjB+gqEmwrQEnOcPVIL475o8jaUfW6fDQbl+tBaPxsA
	 FTFerlL3DmOIQ==
Message-ID: <sashiko-outbox-229036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_console: drop device reference when DMA
 allocation fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziheng Wei" <zihengw03@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123102321.8605-1-zihengw03@163.com>
References: <20261123102321.8605-1-zihengw03@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:27:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> alloc_buf() takes a device reference before dma_alloc_coherent(), but its
> failure label only frees the buffer:
>=20
>   get_device() -> dma_alloc_coherent() fails -> kfree(buf)
>                 -> device reference is permanently leaked
>=20
> Release the reference on the failure path as free_buf() does on success.
>=20
> Found by LLM-assisted static analysis. Build tested with allmodconfig;
> no runtime fault-injection test.
>=20
> Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc serial")
> Signed-off-by: Ziheng Wei <zihengw03@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123102321.8605=
-1-zihengw03@163.com?part=3D1
