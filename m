Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907154;
	b=aA6+FRlDa2av8t8lDCbFuMhiDd/lVwfjulPmLV38Fh32KWWcLD/dvZZFP1IlcI/aF08x
	 EpfCz/6LRzrG1CedmffvqlYRETSIOGPdFoNgO/jKhuExfWWGiFPmIMeIqswyuCTMEiWcP
	 LCcD56RexbCYk+y+zhYUQQcgrz+piViDUOBOAJOvaGL5o1toGCBq6ra/LclbsvHdiPmn6
	 CJboFYaV6I2PMwJ8WfnvfH96i+Crx8tyVty7GYxh7h6tDRCaQDw5oLZZvSTTRDAGfW7e5
	 AgUOuFTJiaczJwVLtYtCi1ahdDKXZmUCc/WaBXZD95MeGlX36jM349IUNQBb/gDbjHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907154;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h6a17iGOu0ud9+jih/gGA6EnjgibS4oWnJoGdI9QIXc=;
	b=3wuyuRoTP0TLthVz6reOVZNW/tTltJPW2keozpC/W7/fxtq8Xh/uEXhVOR/pPqeuZ30x
	 bM7x67AzzHIsxLQeVvjkbMqqZ7bGyQkD3hWwGAuG/z5z4wa9/COPps9/EV0mDdnV3Zyx6
	 w5RGckUupP1y0A2F/M614sZvQ8t7MsV8l0pm4i6LFXNgctumvkhYDUjhNLaQQnm8pzTLe
	 U6xDW/rLEVDeaUCyZx9k+faEQGtqcWXSDIr9DvYioAL4rKJCuOzvozQxpZ/S6OObGhQR2
	 3uo2hFYOx1Nj3pRoxQokTqD6CQ171acsufVEA1ejbswV2RAJQKaDGmEl5DXrFwaDEFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Io5tUhku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C1606A6C4
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Io5tUhku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E8E1F02810;
	Thu,  5 Nov 2026 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907153;
	bh=h6a17iGOu0ud9+jih/gGA6EnjgibS4oWnJoGdI9QIXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Io5tUhku0CLouu0CxZycDFPolCJOXaZPJoDdqvYX06eTMWfcedT2UPStbuNl7673r
	 nPGA36rFWAAk3rEAYVEsmZ8cZ3fmYvGVJ0XxLsqDBat2Vj7kjrmJw8+ADpaEwPO7lE
	 VOvQHz7Dkmb4GcFY7Mec3dKsa0uD/i4Ji39yE+MHtYjLQdskjIFneXPGCo/jKxYlT6
	 H5ah2zYE1cvzD2A3lpLgm2S8rIyUR6I0Ekb2BCZ9ET9uUF2FDpkm4tTDMaGI7e2klR
	 mHu56V1cHsJ4Z/iyN6C3bOfgz46z0qw3A9LBjuURUgt7lMJlokIdeiHYniK76kOmvy
	 vwPrJZl9H6FJg==
Message-ID: <sashiko-outbox-199921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 34/83] drm/qxl: Switch to
 drm_mode_config_create_initial_state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-34-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-34-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:32:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/qxl: missing monitors object cleanup and UAF in qxl_modeset_in=
it()
--

commit c9a17dafeda120436479a0975b3829acefce4188
Author: Maxime Ripard <mripard@kernel.org>

drm/qxl: Switch to drm_mode_config_create_initial_state

This commit replaces drm_mode_config_reset() with
drm_mode_config_create_initial_state() in qxl_modeset_init() to handle init=
ial
KMS state creation at probe time.

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index 204c47d613732..7f719e200d317 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1312,8 +1312,7 @@ int qxl_modeset_init(struct qxl_device *qdev)
>  	if (ret)
>  		return ret;
> =20
> -	drm_mode_config_reset(&qdev->ddev);
> -	return 0;
> +	return drm_mode_config_create_initial_state(&qdev->ddev);
>  }

[Severity: High]
If drm_mode_config_create_initial_state() fails and returns an error here, =
can
this cause a use-after-free of qdev->monitors_config_bo and an unmapped MMIO
write to qdev->ram_header->monitors_config during probe teardown?

Earlier in qxl_modeset_init(), qxl_create_monitors_object() allocates, pins,
and vmaps qdev->monitors_config_bo, sets qdev->ram_header->monitors_config,
and allocates qdev->dumb_heads.

When qxl_modeset_init() returns an error to qxl_pci_probe(), the error path
jumps past qxl_modeset_fini() directly to the unload label:

drivers/gpu/drm/qxl/qxl_drv.c:qxl_pci_probe() {
	...
	ret =3D qxl_modeset_init(qdev);
	if (ret)
		goto unload;
	...
poll_fini:
	drm_kms_helper_poll_fini(&qdev->ddev);
	qxl_modeset_fini(qdev);
unload:
	qxl_device_fini(qdev);
}

In qxl_device_fini(), qxl_gem_fini() -> qxl_bo_force_delete() force-frees
qdev->monitors_config_bo while it is still pinned and vmapped (triggering
WARN_ON_ONCE(bo->map_count > 0) in qxl_ttm_bo_destroy() and leaving the
qdev->monitors_config_bo pointer non-NULL), and iounmap() unmaps
qdev->ram_header.

When qxl_pci_probe() then returns the error code, devres cleanup for
devm_drm_dev_alloc() runs qxl_drm_release() -> qxl_modeset_fini() ->
qxl_destroy_monitors_object():

drivers/gpu/drm/qxl/qxl_display.c:qxl_destroy_monitors_object() {
	if (!qdev->monitors_config_bo)
		return 0;
	...
	qdev->ram_header->monitors_config =3D 0;

	ret =3D qxl_bo_vunmap_and_unpin(qdev->monitors_config_bo);
	if (ret)
		return ret;

	qxl_bo_unref(&qdev->monitors_config_bo);
	return 0;
}

Because qdev->monitors_config_bo is still non-NULL, should qxl_modeset_init=
()
call qxl_destroy_monitors_object(qdev) on failure before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D34
