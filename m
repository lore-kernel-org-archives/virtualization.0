Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227036;
	b=ZrWhJkLgCVXmATKS9ncfErJg1suUuw9SGgoLdoHf1BV+Ke8M1CIPDunD0XlE6BAUfVU0
	 kiTXh5xyhcDOGEtfQW1Wypo8rCHdxYTUI1WUxKDKjS0FKKWNF4XFKYEEMlg68by9OnrRv
	 MZnYyTMxtjVRPnSKj44Bx3GlH9t2XX0vJ9KRX3zt3dcxRjKSCb+n79SiiLvf8NtV/bOL2
	 XmRdtMcTNPP9jKk/clUk/ofkEN2+s4ONNpMKKOOTlsmUYAYrWlO2q6qKSJSvFwamz9dlP
	 9JZdqYYLr5N6mLi3JkHzr8PfnIaL9+xVjzaDhDy5MvDbwMYfZ8VyHNnJUQSKUCpV/ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=er/rmomIm3zUcl4IfZ5liUNtJ1efSrOsd47sK22Z5Rk=;
	b=ngC60SpqPogUCUCwBkBjUBVLfDPLwDxhuhH9+QEGbdsty1lF7qfXlosrBTwg+veh+qQh
	 EDpqU0AyKJiY0lA4F5k4vi/5NBYdI5T45Z/nVlRnDlexKkHjqNdy3YGvEWN5zGj1HEujJ
	 4+P6dSaKrFMQz8FpFRaMNpCRZRmrgZRJcOVKFBbieIBkVlVIFQcD1tHa0c6pjLuNUm4pr
	 CVcBs92pkZbnbq7yRMljxbH+9sl8Ra0o47TM/cYYXHqgiIKoZcDq7MaNrwhMSHjMMbPqX
	 dGTdoP6IKv3miNn6NYoe3wzNHX+PCYGV91lwNCQdReTYt/RWnDAsMD9MsRe+7kRxdRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwqr3WpW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A62606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwqr3WpW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ADD1F031E0;
	Wed, 28 Oct 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227035;
	bh=er/rmomIm3zUcl4IfZ5liUNtJ1efSrOsd47sK22Z5Rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwqr3WpW0Mz+KV6c8oCmh68EUysXPcIdBfWr+px5NFdEWI4jH8a3RaRJHo1yQ5j/4
	 ZYdykYAxIxPRlvs2dd9DIf46CWi3DgR1c4FdrT0Y2JJYAd6QvvQpZq9rncPYMS3h/2
	 FP+jPBK7aFS0LjWhNVDGIOQYAZdYhehhrBhQ+AOsNlbGnR/7JLSpClx+THsDLdk+5R
	 tO6nBCZqhbaY08WdmRgWXz+X+1vLw3h4H3tMCGt0n10zIJYUgsqUdw7ddkD5MFEaYs
	 7FZ46u+bMPhhvuVsBm54muEQkDc/lM7KswcgMwF8FaoI+TExdhYz+dGadE+eKJQIiK
	 EjSOQJhEYC9vw==
Message-ID: <sashiko-outbox-188521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Propagate errors from deferred blob mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changyul Lee" <lcy8047@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028222500.2575769-1-lcy8047@gmail.com>
References: <20261028222500.2575769-1-lcy8047@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 22:37:15 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_gpu_vram_map_deferred() ignores errors from
> virtio_gpu_vram_map(). If mapping fails before RESOURCE_MAP_BLOB
> is queued, virtio_gpu_vram_mmap() still waits for a response
> that will never arrive.
>=20
> This can happen when drm_mm_insert_node() finds no room in
> host_visible_mm. Since no command is sent, map_state remains
> STATE_INITIALIZING. The task then waits indefinitely while holding
> mmap_lock, and SIGKILL cannot terminate it. Any user with render
> node access can trigger this by mmapping a deferred-mapping blob
> larger than the host visible region.
>=20
> Propagate the error so mmap() returns instead of waiting.
>=20
> Tested on Linux v7.3 with QEMU (virtio-gpu-gl, blob=3Dtrue,
> hostmem=3D256M).
>=20
> Fixes: 4c26e162947f ("drm/virtio: Extend blob UAPI with deferred-mapping =
hinting")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028222500.2575=
769-1-lcy8047@gmail.com?part=3D1

