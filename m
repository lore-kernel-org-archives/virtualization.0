Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6F33065D
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458503; cv=none; b=vGVBbKzpK3g/E4bxdyNccvuIleq9x8QsyBX+t7a7osPmf0EP9fsrqWhcP47x3NKYlKOUri+QTlnUiti3/U5W7OW3QKJN4lhPxLjiz6LtsKQn7HkaaRGB3KwhlDTHl+QTmB3yn+7Spg81VFX5a6nZa4er65oyqdMafti9JruRwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458503; c=relaxed/simple;
	bh=Oei46MargQ0iqhuuujiA27xfsU3tzyY18TFZ2Wr4Lo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2wZRdkbEgJJkvSsDZHeZuP/fiz06Co0sC7cSZYpOtBYqWyqF3EHoXIhCsjCzrHMOMIX8jwBvWMmBTdGjDiCXDahuEVwyZxVRMk7j7JZestVJAKwtT7werQO6P0OXuloXVtp313+O5hAo6Ksk9mfumExVCe7cwT1tU5F+Rvbz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADrPzxim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADrPzxim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D323E1F000FF;
	Tue, 15 Sep 2026 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789458501;
	bh=Oei46MargQ0iqhuuujiA27xfsU3tzyY18TFZ2Wr4Lo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADrPzximHpC9EhkGcPNcT6YSpJ36A6I7JFiBBxysDSh9PWIxmBF+CNg+jPbzVLKJg
	 TW4ASLAZmuoX31beaN2QAMwYfsZyN2LxiBnPnu6G9PwsnnK1vu3TNw97mcOswjWwXr
	 5Vxe79Dv3VzwH/BslB+id788mR6vGtAgTuoSDoLGCVZ51yZBBZmDWmjdNl6rKzRPi4
	 4DXjnY/tADhWD5IVQQs15vH4KvDlYEIfbWdR6tPeaBx47Kormj/KMWSWBsatjFtObw
	 cVvz2Dpry3lCwijxyxDRnhIIaUmgrUA8d8mINowOCdJPrqWgPV+S29p5iSEIxobJfU
	 CczEAblrB5S1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/virtio: fix object leaks in
 virtio_gpu_resource_create_blob_ioctl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-fixes-v2-3-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
 <20260915-fixes-v2-3-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:48:20 +0000
Message-Id: <20260915074820.D323E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> virtio_gpu_resource_create_blob_ioctl() calls drm_gem_object_release() on
> both the virtio_gpu_resource_assign_uuid() and drm_gem_handle_create()
> error paths instead of dropping the reference it owns, so
> obj->funcs->free() never runs and the virtio_gpu_object, the resource id
> and the host-side resource are leaked.
>=20
> Use drm_gem_object_put() instead.
>=20
> Fixes: 897b4d1acaf5 ("drm/virtio: implement blob resources: resource crea=
te blob ioctl")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-fixes-v2-0=
-a0d799e4db66@outlook.com?part=3D3

