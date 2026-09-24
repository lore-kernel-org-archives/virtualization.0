Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D13C8713
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260383; cv=none; b=QRD1kDXUaTfUXgVy+d4HwAltqktfhOv/6ATjfWmMbirxJ3u/3D2u9i+rOv3ttg2E3kOsItz97YsBmZWB6jRX4thNlBH7Q4I5QKXqSWEAZDffwtDQOGY9aSflFzezHZAjoPG95z6jkgdmts20zryPoobtGtDzuD/REOQ/2Ys36Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260383; c=relaxed/simple;
	bh=NUmFgmP3onyBS8wpBUrPaN9iNTjL6genG1yUXnZoOOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uHY7eo+i1jAqntzXBlwDEBFtlhEBZ2/wGeaDN+rbHq/IsxuRiYJS4hs6pUzgC72UE0StqS0ajpJ4VHrh6OTL/En0Jejohv2CAlx0JJEK+5ZGDSo0Eui+Mbn3orQpI2B8XLi8XE1ZHUcZ8kIH+EU/VKD9wGMGcD1IvjsCuyNTlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ice1bukA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ice1bukA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D952A1F000FF;
	Thu, 24 Sep 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260381;
	bh=iWN4w1aWEnSLpgj73dfmyBjuDdKnD+m0djhf881d+94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ice1bukA5G8wHKXJye/HevjvexsFdkLXkvHyf9udtkGezDpL28GxC1vSqIO3/iyhR
	 jjaDhDAue0sAokKm8YFvX2rgM9t74RD6hMolBcEyzJFZa+yH9uQ39Mx8iOJfSFlYII
	 NT6FgE/0DS1HZOfqr455r1bxB1ZJpPPsmAJcanFYAJsaP+fXt6Kf9qSGHj0UpmIs85
	 jzxHg85pThOU4nohyhdMGh+nAmweUMgs34C/M8uREBNhaeavetngqVOPWVUrF7t6/f
	 EeEMV8ODfIm+6pBLDI8gkOOFQrkLgCxY3QE+g2MpOW4kqs0fgy9RJF6DM5Y7LNE21E
	 wj+j1iDAc0cZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: add overlay plane format support
Reply-To: sashiko-reviews@lists.linux.dev
To: Baorui.Liu <baorliu@amd.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260924142242.676-1-baorliu@amd.com>
References: <20260924142242.676-1-baorliu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 14:33:00 +0000
Message-Id: <20260924143300.D952A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/virtio: missing format translation for new overlay pixel for=
mats
- [Medium] drm/virtio: overlay plane update overwrites scanout instead of c=
ompositing
- [Low] drm/virtio: overlay plane initialization is dead code
--

commit 6902c3c1a9efc5fd5b84d6539b7a7f5b7707c29f
Author: Sophia Gong <lili.gong@amd.com>

drm/virtio: add overlay plane format support

Advertise additional pixel formats for virtio-gpu overlay planes so a
userspace compositor can use KMS overlay composition. Handle
DRM_PLANE_TYPE_OVERLAY in virtio_gpu_plane_init() and reuse the primary
plane update path for scanout.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index 10718bc736939..4277676aee4e1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -44,6 +44,21 @@ static const uint32_t virtio_gpu_cursor_formats[] =3D {
>  	DRM_FORMAT_HOST_ARGB8888,
>  };
> =20
> +static const uint32_t virtio_gpu_overlay_formats[] =3D {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_BGRX8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_RGBX8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_XRGB2101010,
> +	DRM_FORMAT_BGRX1010102,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_P010,
> +};
> +
>  uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)

[Severity: Medium]
Does the addition of virtio_gpu_overlay_formats also require adding these
formats to the switch statement in virtio_gpu_translate_format()?

If an overlay plane is updated with one of the new formats (like
DRM_FORMAT_NV12), it looks like it will hit the default case in
virtio_gpu_translate_format().

This would trigger a WARN_ON and cause virtio_gpu_cmd_set_scanout_blob()
to send an invalid format (0) in the command packet to the host.

[ ... ]

> @@ -586,6 +601,13 @@ static const struct drm_plane_helper_funcs virtio_gp=
u_cursor_helper_funcs =3D {
>  	.atomic_update		=3D virtio_gpu_cursor_plane_update,
>  };
> =20
> +static const struct drm_plane_helper_funcs virtio_gpu_overlay_helper_fun=
cs =3D {
> +	.prepare_fb		=3D virtio_gpu_plane_prepare_fb,
> +	.cleanup_fb		=3D virtio_gpu_plane_cleanup_fb,
> +	.atomic_check		=3D virtio_gpu_plane_atomic_check,
> +	.atomic_update		=3D virtio_gpu_primary_plane_update,
> +};

[Severity: Medium]
Will reusing virtio_gpu_primary_plane_update() for the overlay plane break
display composition?

The primary plane update path assumes exclusive ownership of the display's
output->index.

If both a primary and an overlay plane update on the same CRTC, won't they
both send VIRTIO_GPU_CMD_SET_SCANOUT to the same scanout ID, replacing each
other's content rather than compositing it?

[ ... ]

> @@ -601,6 +623,10 @@ struct drm_plane *virtio_gpu_plane_init(struct virti=
o_gpu_device *vgdev,
>  		formats =3D virtio_gpu_cursor_formats;
>  		nformats =3D ARRAY_SIZE(virtio_gpu_cursor_formats);
>  		funcs =3D &virtio_gpu_cursor_helper_funcs;
> +	} else if (type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
> +		formats =3D virtio_gpu_overlay_formats;
> +		nformats =3D ARRAY_SIZE(virtio_gpu_overlay_formats);
> +		funcs =3D &virtio_gpu_overlay_helper_funcs;

[Severity: Low]
Is this overlay plane initialization currently reachable?

It appears this branch might be dead code, as there doesn't seem to be any
caller in the driver that requests the creation of an overlay plane by
passing DRM_PLANE_TYPE_OVERLAY to virtio_gpu_plane_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924142242.676-=
1-baorliu@amd.com?part=3D1
