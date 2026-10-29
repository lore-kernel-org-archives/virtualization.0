Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793291798;
	b=KfVaRNZIkK6wuoHxSuq7GOEglVls6tbNSLHp8smK4CCoF4do50EHlfW+2vrOiHy1jUfE
	 JPfpZ6CNbK5njMlAGAOHcgX/TDtMVkhkvlz675ki11xU13YZDmMBOsK25joWAmzNkDi/Z
	 GjHUwwwcPVITqtfoDMvOKSjjTTQbzeWnsB8xDGCu7prqI9o0xFMdBYZg0BWIUmeQUS5JS
	 XzoGj0nHb8DoFOyeVKSwQBPa7enDb/GGA8HcfrTMZRnzVUdaSH5DUPaMdTAY4fHflu2DO
	 J74eaiHVgfntZY5aTqe8W37ecU6sYDkhe8Ub+Cmo2LwIEUcvXom8tLdqs8m0GgZ4gIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OeKQ2piVZxDYVUoUzDvAra2V/pExVPr719BktUd07rs=;
	b=INjQnp3jFkKgGPwUX98l3EVmwCZrqIjaWV1pW9Dil6T/ib4zl5Fl9c0eshY+D78iCoQE
	 Emonv8bvKRcTYYu3DZgjJs0tnkWUeg8jdFNGUHSHurT8pqInqAV9cq06s229S+iSdnrj7
	 eUWp+M/WQYPhD7xxVo9aRx6A9+35OViDL1Rm/m/j/2pMBhfcXdENzkJ50ifS+ygzJqm60
	 veUXkgq9KiESnD5PhSpIMnbnHa52gc7VjVIRRyick0fLCmWM+OMBB1i/938/U4ugG/dLf
	 W/AKBTb3ZZortMiFpJEIuXZcmVov1FeBWsPldJns6E2uMqj3YnFH9wDGaMvAkNo1+6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOvPSNnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A46606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOvPSNnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40141F01816;
	Thu, 29 Oct 2026 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793291798;
	bh=OeKQ2piVZxDYVUoUzDvAra2V/pExVPr719BktUd07rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LOvPSNnLz5dw2nQQ2UeNPqTyMQNCPZdOLR6P9adgELPU2eul7Dy6bWrIMV1p01o9C
	 NetDKUD0gj9AAKJHQ3Fs1g3jC2M7fFKb8m7K0j1C5+AIq1lN+gW05OIKR0idszYFuQ
	 SG/lSqrwJbhg3TrJBNhJBtlAqXenYRpDkaFng8Ffx0oXm4nUVOOFeMtETzw5aC6pqT
	 RLpPQJ0UqFt0cCYxN37o2EoFBmtj4yRHFWKxdPFUwe4Y2Y4+fAJP4thVD6iKbDjv4d
	 LqoCmjblaV/hgZR6PuFDSzXxO7j+oojvMg89dK/PQ3qvtvn+Lia1lyJOpgC8ENSWeT
	 hKkRtIHlEJE0A==
Message-ID: <sashiko-outbox-189664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: add spi-virtio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029-spi-virtio-bindings-v3-1-ef30217abefd@valla.it>
References: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
 <20261029-spi-virtio-bindings-v3-1-ef30217abefd@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:36:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add bindings for spi-virtio based on virtio-device, allowing proper
> validation of SPI controller nodes declared as children of virtio
> transports (e.g.: virtio-mmio). Such nodes are not used to instantiate
> devices, which are registered by the virtio transport, but to define
> their properties and establish dependencies with other nodes.
>=20
> The compatible follows what the virtio framework already searches for,
> "2d" being the hexadecimal representation of the SPI controller device
> ID defined by the virtio specification [1].
>=20
> [1] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-spi-virtio=
-bindings-v3-0-ef30217abefd@valla.it?part=3D1

