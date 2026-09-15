Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FF26AE5
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458395; cv=none; b=C2BVfwwe8+1TPmqR3F0htN1UMTZdqrqnEW8tBezaX98kH26vC+OZ/AecPe5DDluAQ3hjUaAj8fn7GdIJttZiROdB5lGQzLnweB4irKJMiE7OqP0LiePtV3fWIXrPtJsX8YAP2g0flz7mXSkl+NDHInZhmlvPv2knz5zjYa2czsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458395; c=relaxed/simple;
	bh=g7JV4+l/4BvFJmN+XbBDlgNMUmuIi6jk2dMiBcWdfBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJ19eHWXMvDRwCnpNwzUvdQvhWxK0FpSs5Kp929bspez57Vpy4XSvHNbSubv/7xcv1Il9M9V/C3Xw9uKll2wjIXa/j36KY1DkV43nNIEsgw8gwuW13Y+odUVQCo4LETgGudUkUPEnXI3HuWG10f3BWVRHbaYW9Gbxk/99x70h20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5BdeGai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5BdeGai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC21C1F000FF;
	Tue, 15 Sep 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789458394;
	bh=g7JV4+l/4BvFJmN+XbBDlgNMUmuIi6jk2dMiBcWdfBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5BdeGaiQow8Qm0yMqql9+hP4NYE0/ffCbnKRJPGsRBhlbIjgFebia04TxeM1H3gJ
	 R8REKRRsJHehpik0cKvI+tbBH/T/OM+GHEp7mnm5vsSFgJVIgJAv8mjVT6YvzYhrKn
	 vyZORsiDffB5/wvJOErCHalSB63dwW2VyDnSRGSvz01zM6+VNYLyvVxdoS60a2wrNX
	 p9mlrN4ox17YFX4pstA7bobf0ouJcQaWMlAprZpoJ9d34K5U/uA44E0y5DUV8JgiJB
	 D795XlAvDLTV2Nz+YXWzZBPgXqw7e2Z92RaK1dIL8H5VR9vQIhDYnd1h4obnJCqWCN
	 9GPr0oxTGOrXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/virtio: fix object leak when
 drm_gem_handle_create() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-fixes-v2-1-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
 <20260915-fixes-v2-1-a0d799e4db66@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:46:33 +0000
Message-Id: <20260915074633.DC21C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> virtio_gpu_gem_create() owns the reference taken by
> virtio_gpu_object_create(). On the drm_gem_handle_create() error path it
> calls drm_gem_object_release() instead of dropping that reference.
>=20
> drm_gem_object_release() is the inverse of drm_gem_object_init() and does
> not touch the reference count or call obj->funcs->free(), so it is only
> correct as the last step of a destructor, as in
> virtio_gpu_cleanup_object(). Using it here leaves the bo at refcount 1
> with no remaining reference, so virtio_gpu_free_object() never runs and
> the shmem pages, sg table and virtio_gpu_object are leaked. Since
> virtio_gpu_object_create() has already set bo->created,
> VIRTIO_GPU_CMD_RESOURCE_UNREF is not queued either, leaking the host-side
> resource and the resource id.
>=20
> drm_gem_handle_create_tail() drops the handle reference on all of its
> internal error paths, so the caller only has to drop its own. Use
> drm_gem_object_put(), matching the success path below.
>=20
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-fixes-v2-0=
-a0d799e4db66@outlook.com?part=3D1

