Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EA345ED4
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789855364; cv=none; b=VpH6SZ7wZfkclPKZbZs+HSa1wIUvqNcV2bsqR+y2AhHCuUDuyo7N11QCAGN5vvm3gDuPizR9PJjmI1hUBucI4URixUO6G9xAIvoLaUvjXywPIzqjthpnAQuxTLjmTnUdnn5dt6thEWm9mDzaBd0QCpnWhyApUoB2CG2i6lHK2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789855364; c=relaxed/simple;
	bh=NJR4PkRBUTgziG00XripMQMsQqV6BFyNDJM03lwdL1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bp74eKqyB1/uiHBdt4fTaOWFdplDZxsAQcEy3fjc6e2hlsU4JMPEQS9V2dJYY9T24hArtTtO7/KkGLtefUPWwMM5ERORc8Cr8YcNstAV4mnismDuBKmVrkhJ2a4MJec56Ph6Xu3vop0U+fYz9QDHmaXVmnk6+CCpiVXRAhdbYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgbvWm1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgbvWm1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD041F000FF;
	Sat, 19 Sep 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789855363;
	bh=9B/a6L3cbpLZJ1oc6CcZJ+hz9X4+eWzFgD+2BpRW+i0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AgbvWm1DQnGpn7rkuppxt6XbEyVfS4MPidUJnjBPlmyWTvn/GhGlc6M8GUMWfRFht
	 Fk74nuLT7lHIFHyPEObTTfuFced75I8OZkS+048Oh+r2djzSHrlaIEIxBx0ObRBXiZ
	 X9PLjSLXsOTRBJQovH2+rqTGulQZ30WNNZkhbzNPjeq8sHMm26YjQUr2/fOEmXQWJk
	 3b9//dC1M+T/sgOdqb5tl5PwUGfFnai6ij56O9/Ml3ggZtsAbB5S3CPk3ESdR1W3m2
	 qt41qbxnpP6yvoRcyt4YUUqB5to/G6EOI5wXEknXhgd0XviRyTa+Y+rg1MqVgxYef4
	 uzwpG2DO1LdYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix 0-byte blob ZERO_SIZE_PTR, GEM leak,
 and context_init rollback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
In-Reply-To: <20260919215232.3470178-1-benquike@gmail.com>
References: <20260919215232.3470178-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:02:42 +0000
Message-Id: <20260919220242.EFD041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Fix multiple issues in virtio-gpu VRAM mapping, blob creation, and context
> initialization:
>=20
> 1. In virtio_gpu_vram_mmap(), set vram->map_state =3D STATE_ERR if deferr=
ed
>    virtio_gpu_vram_map() fails so callers do not treat an unmapped VRAM
>    node as valid.
> 2. In verify_blob(), reject rc_blob->size =3D=3D 0 or size values that wr=
ap
>    PAGE_ALIGN() to prevent kvmalloc_array(0, ...) from returning
>    ZERO_SIZE_PTR.
> 3. In virtio_gpu_gem_create(), virtio_gpu_resource_create_ioctl(), and
>    virtio_gpu_resource_create_blob_ioctl(), use drm_gem_object_put()
>    instead of drm_gem_object_release() on error so the BO's free callback
>    is properly invoked.
> 4. In virtio_gpu_context_init_ioctl(), stage context parameters into local
>    variables and only commit them to vfpriv after all parameters and
>    ring_idx_mask have been validated.
>=20
> Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vra=
m object")
> Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an arr=
ay of fence contexts")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919215232.3470=
178-1-benquike@gmail.com?part=3D1

