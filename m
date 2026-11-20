Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176209;
	b=yTCh7PUZAt8bpNWYrs5z3PqmTQMPhWYS/rKxa0Qu0LkGcvMGBqk6mloM9yy2L0jetxg2
	 uXDcloLnjT1JhJzjMm/IeC0E+O0yfrafGCWxz+SmWf6yPo+8bARAATSFA6BJLjDbStkLW
	 dNAlqSXEdJ0MTLt0tiHxl20h1OSW3cT8vWHfUMxXHkI+hEcMb/YlnxFQdp+8emkdnUG2i
	 SHXmuDwXIeGgTpfkKo0m+/yAWJyDtIZQVQwVZqlL8PEF/dJLGx3MwNCgxtaaYMItRreHg
	 gtVzhT+4iXsXqDZwFcqc/4vajOWyfuHYEaoTwr8iGPMJF5eVQRsXJXLBxeVdSXeR0vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D9at/Eff08v14Tjx7lt6iFeVjBbLZi2fRGGkfKvp0n8=;
	b=T0gJkwFjdI9Kr790tu8pw7QhQ1JUiOsW/SEpw4fnZFiJGXqWScCvx8QqGj8+W8oNd+3y
	 T9C1YtvIhqFgJwUddSkhYsXUOxwggJL3zsaVFPxBYvt5+ADHNGECeMDdygGffrxIq0Sv6
	 0iIBqNwOoqgreL4xc3U2eirNcbIZtZ8jLXpy8wN5Tvu6nOhQS9Xu6ozzxZZ6rZ7WZEkvZ
	 TX4g1PAO9P3wInYM/okZ6fAyAj3nhp69aAosqyrhu5fjlNfWE0lyGeAyp0WxKFxbL6UhQ
	 IcHgnOtV9WX9SHlY1+LYeAzxMnLZ7JndT/BjnGeNLUhw4BsgY/J2OOLK4NzxB6X1VgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwkanqZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70224606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwkanqZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A7F1F000D4;
	Fri, 20 Nov 2026 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176209;
	bh=D9at/Eff08v14Tjx7lt6iFeVjBbLZi2fRGGkfKvp0n8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GwkanqZnNELPkeatoohuMDz8Z7YlVLqaOalCyuvB8W2Mj7Kk89c+Ne0EwBto0K58s
	 AYzRGFBinmmNC4nboI2tezGi7zyEzhoEXQo46BPJbouZ7yJupxbXI67oGx5XB60d5m
	 C1nNqAL9OY83PmUWB/UPYaYGZBC0vJghXi8UddZW12Z0fT/gSnbh6jRIEPnDu31VSe
	 1lNKOXYLtudGZWG8/+B1alHZGuGAVMMlyFyZIAwP3SINgMYCvsHEqYdo4hWTOX1R4f
	 ofIrO3BThGmAUmXZ2AFmvzSSxDPFeZgIZVpWvftqOs7UD+RMSwp4BWCmLCq6EWLnZf
	 Hpf9CdONb0UJw==
Message-ID: <sashiko-outbox-225114@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/7] mm: skip zeroing in alloc_anon_folio for
 pre-zeroed pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <0e8d142ec28ccfb548797652e1d39783046bddda.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <0e8d142ec28ccfb548797652e1d39783046bddda.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Initialize newly allocated anonymous multi-size THP folios through
> folio_init_user().
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D5

