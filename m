Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704458;
	b=N/XpGMAbrPcEqSm/xuqc27TnibE64YSSljMcQZ1Z4v0fMYccbO9XUWqzuo8p51xfjE6N
	 Mf1nI+lyK8VK7tmj09wnDAOYBFvxHvjxuKRPtgK7xX/2m21/TaPbQR7OvpYw8Vj0wkIB7
	 IZCUPJlzn5bn9el//XtC/c9zbGsiEbmkYH9HV4GlxITEcs3pKqlhuIOFs6a/kDJBFLusY
	 hB+S03p3GXrZlkwEGI7OUvwFMmrAe5W6ObNqtJBv2IRtq4IYdThxtLD2ovi1axOeJrOVE
	 6Y1dtihq6bt4h2oI5tyEFszXImWE6p6+JGzCjsV0WHyUWDSNN8+OtXQvfoOt20FPLXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704458;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XCP1JRddYtqlR7didgWu8XygBls8hDIk3SG0C+RWDoY=;
	b=r6SV/ADfPxDXW6/egAFu1l2a0KAX3cXZVlNkJzYJTsozMD/WZzYtMMoIUv+7XA3TU33X
	 GUq4np8pfZwDmXVkQWghkeJvjZhKDLAbaFV45bHpuHH2eoxCa4BGlaAHW2J3CFdTdEykQ
	 HZnDS5alnqe7K9Q89udAxwxqWReXQxkGqErdW01Us5eE7fUIXStb+7Y/6kiI2rYErMwdb
	 Kyaad5O3KR5NdKslLzEPBF+jZ6GZdUn5AYRilH4NHk7Ken/x4vY0z2KZAp9kMt/mWviKk
	 IMnEp/ZSuR15FmrllXVUdUsOZzYWpKHFUA1RzATpKxBwGxiLVLi/e+j+brsqqHdqfxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TevsXF8E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444CF606A33E
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TevsXF8E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E101A1F000C1;
	Tue,  3 Nov 2026 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704458;
	bh=XCP1JRddYtqlR7didgWu8XygBls8hDIk3SG0C+RWDoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TevsXF8E7RrdBw2sknEjXG+yLjRjprSY0LJ4gm9s18HRSL2cAFt6BTMMvknHIUy5w
	 rt4mSB4M4ELmrkLqEqwgsXfYdAL/sUWd1DVP4lXT72KOwL/8DDe/8TCM2KgKutqrar
	 EEh3cdvtzcw82pBiOQFFOxuIhsK2NEYf6sDq0GDbs2c6YRcyEiO4TT8cVqjKvaPWAl
	 88Vui/3UNhOSQvkwkGeBc+/HgZgrF9BpsDU+AmTFeIizqOJODFbjCjOOb8WUVVDuNz
	 1E7b3p7+4ZRMxt8IYoDQ97G7b2qgw9RkeabQQ6CyqXAa6nfrxJNNva3JTAlrm3P05N
	 iL2kt0mKQxXqQ==
Message-ID: <sashiko-outbox-195127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -resend] drm/qxl: fix use-after-free and NULL pointer
 deref
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <d9930eabe544a4bec5d55113ccd6b1bcd2998bd6.1793704291.git.jirislaby@kernel.org>
References: <d9930eabe544a4bec5d55113ccd6b1bcd2998bd6.1793704291.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 11:14:17 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> When allocating a `qxl_release` structure with `kmalloc()`, the underlying
> memory contained uninitialized garbage. Specifically, `release->base.flag=
s`
> (part of the embedded `dma_fence`) was not cleared.
>=20
> This garbage in `base.flags` caused helper functions such as
> `dma_fence_was_initialized()` to return true even for releases where the
> fence was never actually initialized (e.g. via `dma_fence_init()`).
>=20
> Consequently, during release cleanup in `qxl_release_free()`, the driver
> attempted to put/free an uninitialized `dma_fence`, leading to refcount
> underflows (`refcount_t: underflow; use-after-free`) and subsequent NULL
> pointer dereferences in `dma_fence_signal_timestamp_locked()`.
>=20
> Fix this by switching from `kmalloc()` to `kzalloc_obj()` in
> `qxl_release_alloc()`, ensuring all fields (including embedded fence
> [ ... ]
>  BUG: kernel NULL pointer dereference, address: 0000000000000028
>  ...
>  RIP: 0010:dma_fence_signal_timestamp_locked+0x32/0x120
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d9930eabe544a4bec5d=
55113ccd6b1bcd2998bd6.1793704291.git.jirislaby@kernel.org?part=3D1

