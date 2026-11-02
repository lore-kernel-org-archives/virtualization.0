Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651856;
	b=DxQZUv1mugCCNVL6IkJOuLK1++J5IMQVOPTKRm3AZ8qyNNTjRCozanACExnkhgb6DiGS
	 JimYq8GCNaaL+ad3g1rTwZpZXohPxkWSbt4bhq0S/FllfPSJS/CBdAlRA5Dc2LwF6paxy
	 XbjbbZrNn61+llfA3mzTwOpd/sDGonGUOAwa8WKvPzhFmnc968DJ/97b3ILKO7il7UZUY
	 VT1/YSHkUkIdqPdK/x4GRPhW/TBWESnRWdK703gywRK7TBFIo2xMoG1Tx0qPCdYqIwvAV
	 CiUCTdUW9QSGHvhOnINaHZVuoq+/JawQNumDZxAXQPOuIcGZSUEEI/mW+F/dnzS7REw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HucwvKmMxKBW+aVNAhG16khAXgiQXl+QhVTGprC50ag=;
	b=e3dlWvu+EuHSdxO0kJIhQmm7ICeFMncQAYLLOjGqDt4aQQTfgEQ9BEjuHZSWMg9qwfm6
	 XLS9L2E5VjbuKmXAS8qwKX4T5ulP295Fq0A6UuOTJ8cxLMWNHP/xQ1lOFp4hTocq2qi16
	 86D9k+Nis/1ujWk9AlbYWYWSWmFn/BwisM3v6ANk4j82SCFQmk/MDZ2V8ZNYeLncCsitf
	 1pJPXwVEsm/oLckL8xDYFVE9zigZSxWSuZaNG2qqynehh/DZJfCBlYFam50vWbWmWPPb3
	 D9rVfC1O2yfu3aHoTfgzN3n5ah8D+5OaBtbOIG9QrtLOw6QhOYH7fcFHcREgZfPR3Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdNZAp1s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C6606A326
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdNZAp1s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1317A1F00A16;
	Mon,  2 Nov 2026 20:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651856;
	bh=HucwvKmMxKBW+aVNAhG16khAXgiQXl+QhVTGprC50ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdNZAp1shst3NuhXnlIhL4XAGcEMAqK4AA30HGya4x3wVjGmWfZWm88Kw0vFTKN25
	 RSX3N+23mhK5oIV7QnHJ6lbEtuohEOZNaYD+tady2aVzfDFIzo+FPTpFLU4obtVdbp
	 Aj/Txc5fAgNA1HxXcGiYUpPIdfGc4fN3XHIiWKtNajGfBUCFvXPcInz6vUhuzWR5tH
	 Pmr537vpTIMAeg4G8kam7Q52ISLGKB3HVnpfzO7ACPHJtZrhWE5XeetDKUywpqSFok
	 +8dK8WdZ2UN50qSBIugb2h0pJP69RAX5sRpqZH8RLiEiPQNoP8UJ0pvwWapx+0dGxI
	 krOAXHjYm+4eg==
Message-ID: <sashiko-outbox-194133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261102203518.436327-2-oss.patchbox@gmail.com>
References: <20261102203518.436327-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:37:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_mem_init_kdump() marks the device DRIVER_OK before it checks for
> CONFIG_PROC_VMCORE. Without vmcore support it then fails with -EBUSY,
> and virtio_mem_probe() deletes the virtqueue on that error path without
> resetting the device first. The device is left with DRIVER_OK set and a
> queue that points at freed memory. Nothing has been queued at that
> point, so the device has nothing to process, but the driver should not
> leave a device it is giving up on marked ready.
>=20
> Before commit a9403425b3cf ("virtio-mem: mark device ready before
> registering callbacks in kdump mode"), virtio_mem_probe() called
> virtio_device_ready() only after virtio_mem_init() had succeeded, so this
> path never exposed a ready device.
>=20
> Move virtio_device_ready() into the CONFIG_PROC_VMCORE branch, right
> before the vmcore callbacks that need it are registered, so the -EBUSY
> path never sets DRIVER_OK.
>=20
> Fixes: a9403425b3cf ("virtio-mem: mark device ready before registering ca=
llbacks in kdump mode")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102203518.4363=
27-2-oss.patchbox@gmail.com?part=3D1

