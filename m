Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891538;
	b=33KLJenPOnj9DEeJY9UNBuHuHeV0VF1+x6FQd3ElRDLfeoMJ0SoHOSQX+G5uyXNHBzzy
	 YiYiaU9o6DWNkPR36QSpJSvCwInuF6x+t6UtKgbfJZGaJvZsXAoeHRF/A7j11mIrrKZ9n
	 emFZc35fjnSekBpZect+6TdAJzST8uSd41CobkgUB0mVjIw/9LUqSJoN9Xr/UzC7SFNCa
	 DvH3O8D89pCaKuRTbBs2nhDe/SxbMdU/hlzp62VIOykNhX3k9F1e6QrTYyYp9kmamr627
	 7vooBGJXB0VkoiBOYFceYDVfeujcKBjTpdBvWIfm5UxNFvhEqUPMmmFy04ovtVEznZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YwlRlnupOz5rxsWt/GhPVa2k6ZJRqx/vd97RMkDyW8s=;
	b=JTiENaTwM8l5qL6YVQi3ewqvFc4+L1qoNTh79N2GeF1DHGbgNc1pnOsM7OXWwQYl6cWr
	 XqRXfDUN+NmD7dT4R82BTqIOl9Wa/pEnV4oVWEgAX3a0wSiAIOjeEtTXklOc29rVSOs6Z
	 wanCjYgzydzJSTRqL/j2LFYLOVLhlimhjnnEGpKEifP1Vjbt1WuOjC6z+tPHfAc7umqef
	 xr0JWeL8eu+8PcGuDGWlvrpT63dr3Y/rbZbrr9+r98B8eQHGDEmcK55CcO9T2w5Z/S3+y
	 yxaaaBmnmQQwvScWeoU9mGNFGATHOaKZ6XSn/gaZ1UlTrUNvYllzdnBpeSs+EP0e2Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWH0ykUH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235B606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWH0ykUH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CFF1F000C1;
	Thu,  5 Nov 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891537;
	bh=YwlRlnupOz5rxsWt/GhPVa2k6ZJRqx/vd97RMkDyW8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWH0ykUHmMVeMQNPKYxwY1vvCVrzTipYc5HcvP/FQ3DBDTJ1OmC0ZU+O8yaJtKAIE
	 ZcFVkDgj4d3pJh6NuD//ALFXUW2cDeCi0aArhQYYWf86pWWVajReW3INZIndyWdX0i
	 fqUWjaZNbwV5Ln30cOPlBIgd1zCwejptfCdOa/fp9FI4XRkNcrpg+q237AeQJGrecE
	 L2x0E8qi5CcGHuYKxfuKlbWELGXinsNmr5WkfWYjVIno6lkV5ExeEqAaQl2Dcrtw+z
	 Nz9TLa7qsNCJJcmr5Zz2NBDAYm2pa/jYKGf/21eHkjoIh4mlT4sVWy6L54qe0uix78
	 9euugE04OJgUQ==
Message-ID: <sashiko-outbox-199301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miklos Szeredi" <mszeredi@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105150943.86650-2-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
 <20261105150943.86650-2-mszeredi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:12:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The virtio_fs object is refcounted via its kobject, so a mount can keep it
> alive well beyond the lifetime of the virtio device binding.  The tag
> string, however, was allocated with devm_kmalloc() and is therefore freed
> by devres_release_all() as soon as the device is unbound, i.e. right after
> virtio_fs_remove() returns (see device_unbind_cleanup() in
> drivers/base/dd.c).
>=20
> virtio_fs_get_tree() looks up the instance, takes a kobject reference and
> then drops virtio_fs_mutex before doing the sleepable part of the mount
> (allocations, fuse_conn_init(), sget_fc()).  A concurrent device removal
> can complete in that window:
>=20
>   CPU 0 (mount)                         CPU 1 (remove)
>   -------------                         --------------
>   virtio_fs_get_tree()
> [ ... ]
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: <stable@vger.kernel.org>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-0328b3a1-043b-468e-8425-6a613d91b=
5ef
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105150943.8665=
0-1-mszeredi@redhat.com?part=3D1

