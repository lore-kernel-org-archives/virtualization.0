Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FD1AA1D5
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790483370; cv=none; b=kVPBgA6AeM+Ss1f05TtEo8JjjTApsOtR7yCNhOzoor6H002He8L7oDqfcZ/wJ23XXiq9SUUpnZGjuTG+OsbusexTLb5evOOms9XeQmFguhq8phViin4FLh/WAIAtz29c/9ppEEtCjJYDd6r2n0OXf/i0I1nLe86My3UP5XKF0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790483370; c=relaxed/simple;
	bh=hx7oeHKJFM9GV4DYbXaB/HGx+epW+geiopMeZ8IJRmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J38XdCjnhvEKXUyppaVnsgtB1rvIw+OisqZMWOSGWXIPu1+DBP3xbZj/YNSvkYKExBp2YxjTBIGGzVt0v22V9a9wn5X7/FRt2rBQMInHSk3PYpiA9D2XfmbuX82dZDsT+PpDp+AS7RAjZK1q+yOAP4CJs2pjY3PLq5L2I9mzgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9A11F000FF;
	Sun, 27 Sep 2026 04:29:28 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: drop the dedicated vbuf kmem_cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nguyen Ngoc Thang" <ngocthang2710.1999@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260927042035.19956-1-ngocthang2710.1999@gmail.com>
References: <20260927042035.19956-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 04:29:28 +0000
Message-Id: <20260927042928.9C9A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
> "virtio-gpu-vbufs" for every device and destroys it from
> virtio_gpu_release(), which only runs once the last drm_device
> reference is dropped. If a reference outlives the PCI removal (for
> instance an open /dev/fbN), a rescan probes the device again while the
> old cache still exists:
>=20
>   kmem_cache of name 'virtio-gpu-vbufs' already exists
>   WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
>   Call Trace:
>    virtio_gpu_alloc_vbufs
>    virtio_gpu_init
>    virtio_gpu_probe
>    ...
>    pci_rescan_bus
>    rescan_store
>=20
> kmem_cache_create() then fails and the new device does not probe.
>=20
> A vbuf is 216 bytes and lands in kmalloc-256 anyway, so the dedicated
> cache buys nothing. Use kzalloc()/kfree() and drop the per-device cache.
>=20
> Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1b129b44597a126d2d79
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927042035.1995=
6-1-ngocthang2710.1999@gmail.com?part=3D1

