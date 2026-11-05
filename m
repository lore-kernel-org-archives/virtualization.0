Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891610;
	b=yS4JFhvdDmWEVWQhE2qWg/W+P8T2EHjkx0+BWoLAbt5swLtdgycesrRROtkbKc07t8uA
	 WAyPFzdoqFQ7eTtabCGIOI3hElg4ausYndbtCnlQzLtja9gpGUlzvDGOa9jnEtKU4bucg
	 ANadtlNMMMMd5iOWBJj+xI8ZNuBF+g9RP74u5UDBNzRF069qTdLUTv09AJk8oKjCuFQMD
	 jkacygEPE7ACrLfqN6s97ivhZH50eD+GC0Gv9h3Dxl6MSwz0i+zdpbLGAncppJM/53SJI
	 q4BAwqZszSEunUDFGcvAhJgqyjA/MHCjP4wpCuShpZBZso73FybyGpUj7Srjk2dFQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891610;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+kuezWz0di39mk8Ui+h0TN4JDk0dTEA42Ut2hOsKzsI=;
	b=hpXJ/9e5IoHEhR6bIC68tU6FXJHgfQTCOhwxWBB586esND60lyNlLyj+6agAiQhs+Sq1
	 X3qap9dQRBg9FiYatE8uZUeiySXu0iU116MfaciXjaQUBVL8F+YvM7YW2ryIuZ1LFG9CE
	 smIlAnnCsEzum6fBi/CRsVXdF01qW0wYLqJcshv/0ei6i7sPqJ3CTdxVREI3xjAeWkfUT
	 3drUK4F1600mC/c0HWteml+bLlN8HDavOJlzHLi7A2+I6Cq7xxrjdPlqfPgPstyvwQVhy
	 wvZ/JHoTfpS56H4SuNtUmxWH1/DsCZqbJJ3LZIRATMVZm8DrhFdRCSnj7/O5lv/AG2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOHlfFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B680D606A331
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCOHlfFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DFD1F000C1;
	Thu,  5 Nov 2026 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891609;
	bh=+kuezWz0di39mk8Ui+h0TN4JDk0dTEA42Ut2hOsKzsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCOHlfFZVa51eLqKmhXEFl5npKZigcRT/qxcQwQgTssQpJ24t29MgPrqe24sRnRlI
	 0gy1SM2I+3Gcvf1EIvfm4QPEylWKaWyZEXq2hL9VZmdu3MlpsuYHuOjbQvBYjY1saa
	 vLKICWNtyfULXkr2PQDL7IjBCZaUULjnksOlYf6fHVS91flspEZFqRqoOhsZJCnpBb
	 YIVhcnXS9l1Co4LQOkaM5JuRajQqCn+QOS0MpSqJ+F53O0DLTcsRWZILueTShsu4Ss
	 E1tq/ny9Ymtf5DIDsSzWXIZ9w4tWfMj0VaUtn6iE37GVJKBxQqUNAVYbsDyjBLHIrW
	 JzSt/aSEbK+Hw==
Message-ID: <sashiko-outbox-199302@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] virtiofs: zero the reply region of the argument
 buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miklos Szeredi" <mszeredi@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105150943.86650-4-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-4-mszeredi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:13:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> copy_args_to_argbuf() allocates one buffer for the fixed in- and out-args
> and fills only the in-arg part.  The remainder is handed to the server as
> a device-writable buffer, and the server is under no obligation to write
> it: the used length it reports is its own claim and
> virtio_fs_verify_response() has nothing to cross-check it against.
>=20
> A reply that declares its full length without filling the buffer makes
> copy_args_from_argbuf() copy the uninitialized remainder to the caller,
> so a server that fails partway through writing a reply returns stale heap
> contents from e.g. fuse_statfs() or fuse_getxattr() instead of an error.
>=20
> Commit 5364d081125a ("virtiofs: validate fixed-output response length")
> covers the case where the declared length is short.  Zero the reply
> region so that the remaining case yields zeroes rather than whatever the
> allocator last held.  Only that region is zeroed; the in-arg part is
> overwritten by the copy below and the buffer can be as large as
> XATTR_SIZE_MAX.
>=20
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-f0d6d4a3-f5df-4f72-ab09-802e5aab4=
9a6
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105150943.8665=
0-1-mszeredi@redhat.com?part=3D3

