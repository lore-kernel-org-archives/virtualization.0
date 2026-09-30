Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFF4DD3A2
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775708; cv=none; b=Rk9jGPPmds0KZunlg91dEEr0TTjZZqHRy8L49hbcaSb3QN4kGXugygy5ACH474F8zAfwvSc816S8gc1y+1s87HPc2Tdfz1gmRXLXgcdFOLhVWMg267m8vo5yM1rHEL3DAOdchQX25urgqNXXtTmYYBMYiOSRii+2XE5qUeYvQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775708; c=relaxed/simple;
	bh=fslMP+pUM46PKhRq2bwZ4pNmeLiDUJmJYz+mUeTS84M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hl8/xjC90Gc6Ii+cxrJSu7bO2EF6xO80A2xl9zYMNAuZzHci8yjrlh7Rgx3sL8JJaG9P6lLbEQxTmlCyEOmSpluuTpUOvpzVOs17gL1f6bBSQzSpLGKcs9j7ZprHWhJYNKB8irDTKH9vtD0yLrpYbRtqDpDAgWWpnITtKaJHsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz+1sxLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz+1sxLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC0D1F000FF;
	Wed, 30 Sep 2026 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775701;
	bh=k5JlHMQ1SP+99jKiRrBIQ5hMnsuzhxifRgQ6KJS8BA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iz+1sxLXhuLMKane2swqRKbFZNBSVN1jvxP13vVbVTfSy+XjfunTzVQeptZ2ZiNdT
	 h3TkHMZa6/pkrq9x1/dbpaoIl9SORDS/mBm+0+ky3Oqdw4cQLoIv7QzSyqAkXNsfaK
	 Zkm5ERUbSPsr1VZn4rTwWOH1vjJfOboUqUOV+rvPKNYJeOpSBTQhULWWp8REYsX8XI
	 2AcR1i7rfwpLSGdImVAAtsR94Q7l1ys2IyHUUgcF2lR5rpK73VXMfsXftrFkZHzxHx
	 Ve9u4+s6UhpMuH1x7MokAZl5vAzsuJFa+CvBh3Id++p4gZlVujHFpmKzQGXm6v5ejW
	 lN4lSFOfTk+Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: add ARGB8888 support for primary planes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dorinda Bassey" <dbassey@redhat.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260930132707.500748-1-dbassey@redhat.com>
References: <20260930132707.500748-1-dbassey@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:41:40 +0000
Message-Id: <20260930134141.5AC0D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/virtio: missing blend mode property for primary planes with =
alpha format
--

commit 9355c68bd37dd7d0e90b6eec00d769a8fd8ff04f
Author: Dorinda Bassey <dbassey@redhat.com>

    drm/virtio: add ARGB8888 support for primary planes
   =20
    Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
    virtio-gpu primary planes. Without this, glmark2-drm fails at
    startup because it selects ARGB visual configs by default, which
    don't match the XRGB-only plane capabilities. This causes
    drmModeSetCrtc to fail with EINVAL.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index 10718bc736939..eef9ef42dffea 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -38,6 +38,7 @@
> =20
>  static const uint32_t virtio_gpu_formats[] =3D {
>  	DRM_FORMAT_HOST_XRGB8888,
> +	DRM_FORMAT_HOST_ARGB8888,
>  };

[Severity: Medium]
Does adding ARGB8888 support here also require adding a blend mode property
for the primary plane?

Looking at virtio_gpu_plane_init() in drivers/gpu/drm/virtio/virtgpu_plane.=
c,
the blend mode property is currently only created for cursor planes:

	if (type =3D=3D DRM_PLANE_TYPE_PRIMARY)
		drm_plane_enable_fb_damage_clips(plane);
	else if (type =3D=3D DRM_PLANE_TYPE_CURSOR)
		drm_plane_create_blend_mode_property(plane,
						     BIT(DRM_MODE_BLEND_PREMULTI));

Since the primary plane now exposes a format with an alpha channel
(DRM_FORMAT_HOST_ARGB8888), userspace compositors (like Wayland/Mutter) will
expect a blend mode property.

When a DRM client queries the properties of the primary plane after the
driver exposes this format, the missing blend mode property may prevent
userspace from correctly discovering or configuring the blend state. This
can potentially lead to incorrect blending or fallback to software
composition.

Should the primary plane also be updated to create the blend mode property =
in
virtio_gpu_plane_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930132707.5007=
48-1-dbassey@redhat.com?part=3D1
