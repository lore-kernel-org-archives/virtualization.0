Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263539;
	b=5oDPaFX89cTW+X5+QIfFrHMmOr1jkp7LwGran//+9kbl7vPGyh5mEhmmAFGXTEmZYpVl
	 +Q+q9vKCW2LYXMbtcsDad5uQ554dpQf4YqGzdxAk/zcn0qDrmc94/6IMUCnBRGR5+9QKF
	 OCSOIUxQJTEgYVnf0LxB5h+E889LSDsLG8x4FIDuJeK0kYWuG6UQ3ZPt9UZFd5WLesNhS
	 84cnzDCyuPTbv9j6ZORCeKJHyou68w62KIG0XgPMAndWhgE0ul2lZYDfq00ACZTj75xtD
	 dZcmT3eOrSLzLeioAM7/hdUgzZdB3pCmyZq2sS3krg49DlHUAT6acpbiYBxlxxexHXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263539;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NN3SS/GWxtehXYYDCzn+wfse+oJraHA6lY5/AzoX8l4=;
	b=fWDDMA6OS4ooBJPxtNTmeeF/RipGthgdwAHPB6WwOrJtufvTfIaqlzikkEzajChHpRIT
	 LZnKk8o8tCyNgodrjWfZH6HN1uMk4LXhZf8LqUGNpkcvUPYqrlY6vYt69MnPiAcl0P8Uo
	 8gebate5CKALpHmy1tXzetnLsqy4SC4P7I7fhAhiOVbojmhvBbkduFtYHKSNVA0wbcJVx
	 opsIKDRX73jdJ4bgwSun6F7TvimXOoxwxO4u9qpcxEZ51bOoFZ6v1ukWCkPAZSdKydSx1
	 PXBTZnnuOQ6K9uRmZuB6LvNENAP8YJDCmE1/KoKorU9G/bjCWcGIPAKbZFkyoR7kkKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WL0178Kb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA2606A31F
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WL0178Kb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA91F01825;
	Thu, 29 Oct 2026 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793263538;
	bh=NN3SS/GWxtehXYYDCzn+wfse+oJraHA6lY5/AzoX8l4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WL0178KbdsynPrEVdm3te3fYp7MyVNzZmrkHyCjgElfP1UeuSm0HuqHUzK7aMf3n4
	 dCfe9NRKFx53AjwRKGtQpyr9qx0US/lp+2cdI0eMGPhJcKKqK4NYuJeGdO+panFQgQ
	 EqFPgbxdho8NW52HnEmMCOyywdWkpx4FyBAqnzoV1q6f0MFuNRyEL3rie3gqETSM0L
	 4DTIzTb064S+cKrtj4Zm6Yo19RHWhAupIF8/PYqqTXX7Zgm5TiyUj9YJnqTw9EhYOn
	 6UihALkWaxke0IReqdf0GIXsf9wB4DZiBp8xu9NaQDK2AE2BfZr+AWf0GR6p+PhuRe
	 T7sahafhAexEw==
Message-ID: <sashiko-outbox-188987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_pci: don't take the MSI mutex under
 cpu_hotplug_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029084043.19409-1-zenghui.yu@linux.dev>
References: <20261029084043.19409-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:45:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> Lockdep reports the following circular locking dependency when a virtio-n=
et
> device is probed with lockdep enabled on a system whose devices sit behind
> an IOMMU:
>=20
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>     WARNING: possible circular locking dependency detected
>     7.3.0-rc1+ #84 Not tainted
>     ------------------------------------------------------
>     kworker/u34:0/57 is trying to acquire lock:
>     ffff800104f83ee8 (&md->mutex){+.+.}-{4:4}, at: msi_domain_get_virq+0x=
f0/0x118
>=20
>     but task is already holding lock:
>     ffffc00081edd930 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0=
x10/0x1c
> [ ... ]
> This also covers the CPU hotplug callbacks
> (virtnet_cpu_online/virtnet_cpu_dead), which call virtnet_set_affinity()
> with cpu_hotplug_lock already held.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029084043.1940=
9-1-zenghui.yu@linux.dev?part=3D1

