Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276498;
	b=rxqCjhA1nhljJe5x1xcpTLNbEHFLhd27n/0jUSqdl3vvFdHGqYwnUOKJfx8iBB8zIfj1
	 z7gnE3yqdL0fwgXbcarAbemeo1e+jv0ao2pNMrOa2qQMbKg1TGv5P15yHSf6amlreablw
	 KGEOhbl2oUwPhKMr6WoeT8CVD6C+tJzkgbiQ6oE6EN/aETsv6tm2hvjKLUtFPOZj9EGWr
	 oNDurLlAuaeRvZxuXeYfE+VtzmbNZwslFHCidVNb/KHZkT0eBHJYAgw3eWyOAl2dZ7ApD
	 jpio7z/lYBVqahjGRntJP6yxUVHfZyGS7DjWufKjPs7QXiKOBVPvB3/SX1g82NOm04g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=76B8w5iLKCPxfLJXd3X043vq9OsdC3dWqLya7FBe1xw=;
	b=hDxPKReAdcP16rePKcl3oSLAGPwfmqLJQ+xZzwwJKvLOkDodhx8nSXaWYpRHmGXgnNaf
	 ItrZqZB7ImJRLC99B0OxV45hEphxkM8WT7/cLuy1nWuUHkYjywvzS9dDYdw+Or9OSu83L
	 uQxgmEVkwYgbxgcV90R4BVi36WHRzzMKSkNYT1AnZQaxAp6o0gTAAd0aIZm0j0z3CRYon
	 swyDhvKwV8gWa8Vm9fpORL4e3MlMA3+Ch7Sydb0jTBzmMqQoZrcU7cYnd6YSrBaTz+G0w
	 FLDNk1HzSTXJOApe95P8oLUbxwkwF3PDiF+KdnHaQbXh+PzUtkDtkfOGwfjxgFn+NzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsPSWwLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06194606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsPSWwLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ECD1F01825;
	Thu, 29 Oct 2026 12:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276497;
	bh=76B8w5iLKCPxfLJXd3X043vq9OsdC3dWqLya7FBe1xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsPSWwLjxXEe3+nyrM/PXDOkyIaKIXNZByMlPIeBv9DuAio10vm8IEC7fE3CACoJB
	 DPQHrJPinmE/l1669kPayUeBceKVFCivgkJlMN29zl55762xkNvDRm4O8at1XN9snG
	 GvigjRWa94LbqrCOOH08UHehqM4I5qQPPD8c3RfYubO+HjP/t2xjvZcMctcYUlWqJB
	 fogUm9vj8pe5e4pTnwt2LCGWUxd2R99PZWiPfcF65I6aOQ9DUFDXKfx+CLSEHKXUi1
	 Kj9V8ffGlW4+54z5JQ++Scf7IOs7gy4N41FaQzG71nzQWU3MZl9w66AVYd00KtiIUz
	 4NKkErXNYWt2w==
Message-ID: <sashiko-outbox-189276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_pci: don't take the MSI mutex under
 cpu_hotplug_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029121648.22155-1-zenghui.yu@linux.dev>
References: <20261029121648.22155-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:21:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029121648.2215=
5-1-zenghui.yu@linux.dev?part=3D1

