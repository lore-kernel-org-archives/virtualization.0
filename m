Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B6386552
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645165; cv=none; b=ew1y6F00huSzvnAyGJyeTFxGATGLx/51OTv9sRLb/PPuuq6aQLJS1xRfRsF3LTme/3viMAVTw7bOdvpT3I9VoavPpL29zdQKlKg2tCmuEhriMshxn3vB9pEXABz2tjPT/UwKeY4qvsQ+18bCioCvAblQhGc03no9zqN6l/tMR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645165; c=relaxed/simple;
	bh=nLDHo4+J3rjIrxCvYVLDFD1h4xwNgopZGRHp+WbBSm8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k3WAgSxXKvKJH5Pn+lfq2gFuYANbTZjn4a2cpaxBjDOEs6Q/nsKj6VI/ousxk9+dzuEk6qdjcm5qldw51V2waMPmH7N4C7XZQHfpPQPy2y5ef1nFiozU1+MeIlg3GS/KlfRbK1XShbnLvj6o2H0NGHALAImpr/W5EQLwu6fN0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg1wSic9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg1wSic9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300681F000FF;
	Sat, 10 Oct 2026 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791645164;
	bh=H+P/wL3zitAeIyoU57JVhuwa5yX/h6XhvME6dOVmtEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gg1wSic9JR75K1uNkVBtoDMziIp/RvbGa6sra6KA25/17zO1J8Ppxmh2Urt1Ojnu/
	 drD/NqDe7QCQ7jWZWPpQ1ah76WMDPGHIu51HaPBxCxUZPCDlNSQR9sNn+Xf5IstkOu
	 NlkhQXam5r6EWUQkLASi5JCIC9i3ny4JN/LzIwxW4xoDnVsNC+qnYhS/td0mJQa1Ql
	 4AUXEymwLgPjDxCQvRf4dxX7uSH0g7IAGsBPy5tF0W6RTRMcITG7Hdacd3F2G+7fFf
	 Ibubrwk/0Quo7M6Z76TC1wIqiej6ENeaWsMhuGa9kHAYo31o4Dc6CKy5PBl0fhO005
	 pPxJlMNQalZJw==
Message-ID: <sashiko-outbox-166686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/virtio: share one vbuf cache across all devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
References: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 15:12:43 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
> "virtio-gpu-vbufs" for every virtio-gpu device and destroys it from
> virtio_gpu_release(), which only runs once the last drm_device
> reference is dropped.
>=20
> Two live virtio-gpu devices are enough to hit this: the second
> kmem_cache_create() call finds the name already taken and
> kmem_cache_sanity_check() WARNs. This reproduces at plain boot with
> two "-device virtio-gpu-pci" on the QEMU command line, no sysfs
> remove/rescan or held-open fd needed.
>=20
>   kmem_cache of name 'virtio-gpu-vbufs' already exists
>   WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
>   Call Trace:
>    virtio_gpu_alloc_vbufs
> [ ... ]
> at module init and destroy it at module exit instead of per device.
>=20
> Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1b129b44597a126d2d79
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010150429.1703=
6-1-ngocthang2710.1999@gmail.com?part=3D1

