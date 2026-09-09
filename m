Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C13D5663
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939880; cv=none; b=fLcxlDpRWZYIsvhWQCsn4JBRG6LC+VfYOjkp5VrJ+KeyJKvia9cPkIhw48tTYM1SMJ+XRwrVsCr6pum5esvwamEZrs4jdgf6qnwH93rA/T1gEzQt9XlfMfAftQI+hgycHUFSBpqUS+LoBilODPN1l5LYoXXhIorYCnKF/KgaW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939880; c=relaxed/simple;
	bh=cWlu5BMpYKezZ0AnOVa/jLD+z9IKRrWqrBVyIKPCohM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qpShsFqNZ/60uO3YGxFdGz31L9JafoxAB7TQXWrtpAaa7RSXOpQotO3AGywHyGvbN4Mk4/y8s2GihmCwaVOHPEm+05J+acJ8hyWmCXR25O92G0HUpUaXWx518pmlxF8Aou+FzKVk9TboJ37dbs7XRWKHTQjLsOZyGjuTuSF/C7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciYnLxaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciYnLxaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658241F00A3A;
	Wed,  9 Sep 2026 07:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788939878;
	bh=tixwgiWwREE+e/O+XQzoT2C82NYobPgNbFeLqiM0sjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ciYnLxaGp3aO4UD5fLXeNL0fOiiO/AOgzouPf2HJ/wQUowsaovGKMY6XFFuL43Ob7
	 o9xC2R+xVa4sXg4ISf/yWQta+Vpqtd2J4l4too9g86odZry/9p3ZhfGg2KMQxpn9Zi
	 jKcGwgKrbDD9PXO/t5UKJf22EXhBdUoOCZ5abD1e+Z8UOFKYWTwO37hE9vRSLsqaPs
	 ZbxYvOIgKZH+jexfUuiO4JDJJDX2S/MY9DSYyMFWhfaVNGfAzN1Pc46hbU4Rsa1/uD
	 Eqfu/O/AwPodNgJSsLbRjDb6ZcO/3ialglSt7C4NP+G1GfVdXyLfB0MN41Pv52c39h
	 Y2CDLw1SDgVSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: Replace deprecated
 drm_simple_encoder_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909073440.52641-1-bonatto.davide@gmail.com>
References: <20260909073440.52641-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 07:44:37 +0000
Message-Id: <20260909074438.658241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing error check for drm_encoder_init return value.
--

commit 731688e34b570f6cb070588f1d74f9b42481123c
Author: Davide Bonatto <bonatto.davide@gmail.com>

drm/virtio: Replace deprecated drm_simple_encoder_init()

This patch replaces the deprecated drm_simple_encoder_init() with a direct
call to drm_encoder_init(), defining a default cleanup callback directly in=
=20
virtio_gpu_encoder_funcs.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/v=
irtio/virtgpu_display.c
> index a1a875a0c706a..85986578001fe 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c

[ ... ]

> @@ -306,7 +310,9 @@ static int vgdev_output_init(struct virtio_gpu_device=
 *vgdev, int index)
>  	if (vgdev->has_edid)
>  		drm_connector_attach_edid_property(connector);
> =20
> -	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
> +	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
> +		DRM_MODE_ENCODER_VIRTUAL, NULL);

[Severity: Medium]
Does this code need to check the return value of drm_encoder_init()?

If drm_encoder_init() fails (for example, due to a memory allocation failur=
e=20
for the encoder name), it returns a negative error code like -ENOMEM and=20
cleans up the partially initialized object.

Since this return value is not validated in vgdev_output_init(), the functi=
on=20
will proceed to use the uninitialized encoder, attaching it to a connector =
and=20
registering the connector with userspace. Could this lead to a NULL pointer=
=20
dereference or corrupted state when the DRM subsystem interacts with it?

> +
>  	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
>  	encoder->possible_crtcs =3D 1 << index;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909073440.5264=
1-1-bonatto.davide@gmail.com?part=3D1
