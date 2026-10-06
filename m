Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8D49E12D
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302334; cv=none; b=CuJDnjFWB88AR3Q/HtZKjpW3jsn6r5InDyPvRlNqc5kFbRCTZ7Ssk1HGvj5oJV3bZWYu+SFwL8CiccC2iFOGngpdDhrYo759LUHs91yQc+3a5BmsJGr0bTOxch2xwrqRrimgJBjof39+F+tkWcElBT53RGAGnnUtapHHqSLDKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302334; c=relaxed/simple;
	bh=g/A9S9gvT+pYL8fVHgbknRCB99Rr8gVoAcDQoMhV5mE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tv91uH2MUWr7lC6n/H3IOuNtckDNc2kEkEeylH9kLRoEAEOt3bueaMYwXxygeKCOlcjONk4VjYkUeWo3YbUVFNEX6lZBmYVYiPKcTYzCsTUIzC1hVddmBrZ+rUK5942frhV5UfBywIEj/UvneYwBKtDqyQxZmVTwEDvlNeJr55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C25TW2CR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C25TW2CR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E92A1F0089B;
	Tue,  6 Oct 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302332;
	bh=8y6kLm/9r36/kdchitA/wVasVsQZyBMPrWtVK3TeBa0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C25TW2CR+Z1UkmiMJoUTQTubXxG0Vf/aYuzMLAqgnN+VylwXB56PUdqbTMBzFGllI
	 LOrKUZBViSR4fvoXUWTZ8K0rJRTR/fRMyaLcz3cdBjcdwUoGKmMRzmHLcESe2M1Fpi
	 imfA4pdc6hkx3GMnRAR1IOS6jy9rYJQFwIvTPP3kd9LgUK9j3akoOODa8oSBk34sJc
	 LNHSGu1DGlO7bwvjQamGRFvxpKP+0mDvxshifoUp6CTEahQ6aHKwFpST5EMfSHbahb
	 k0kNmUZHsVangptJLiZvsr7wwCCyRkdhZjNceOIuC0RVBFdxguOgwnu0AQYXgYzHhR
	 Cq/NbFu46lPJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@invisiblethingslab.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261006154913.2689067-2-val@invisiblethingslab.com>
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:58:52 +0000
Message-Id: <20261006155852.5E92A1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/virtio: blob size alignment check is bypassed for 2D devices
--

commit e9be6e8827fcf796e95413bb22d054eb21acf9b4
Author: Val Packett <val@invisiblethingslab.com>

drm/virtio: do not enforce blob_alignment in cross-domain contexts

This commit stops enforcing blob_alignment requirements in cross-domain
contexts. Resources created under these contexts are arbitrary shared system
memory files rather than GPU rendering contexts, so alignment is no longer
strictly enforced.

Link: https://lore.kernel.org/all/20261006004044.2242154-1-val@invisiblethi=
ngslab.com/

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 81e70a12b3569..c28534593b2f4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -539,7 +539,9 @@ static int verify_blob(struct virtio_gpu_device *vgde=
v,
>  	params->blob_flags =3D rc_blob->blob_flags;
>  	params->blob_hints =3D rc_blob->blob_hints;
> =20
> -	if (vgdev->has_blob_alignment &&
> +	if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
> +	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=3D
> +	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
>  	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>  		return -EINVAL;

[Severity: Medium]
Does adding the vgdev->has_virgl_3d check here completely bypass the size
alignment validation for 2D devices?

If has_virgl_3d is false, the condition short-circuits and skips the
IS_ALIGNED() check entirely. This seems to allow userspace to request
unaligned blob sizes on non-3D devices, which could potentially cause
host-side errors or command rejection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006154913.2689=
067-2-val@invisiblethingslab.com?part=3D1
