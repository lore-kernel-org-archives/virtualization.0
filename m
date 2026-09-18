Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8743EA66
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698204; cv=none; b=lQVkD9ZmBYOmjJTnLZvpddcArX4dV4NvzVlm15Ny8puW2chN1qjzCymLnhFgYZZ0HyeO8laCw7wyuRveQcRHYpEOyh6J2jlza2i27kw0eIbnscodf7e/WTma6pGrXceJN87X0Ip3/Jp4jjQLyIx/Dn8BWrs3ySgSFkhZLzURZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698204; c=relaxed/simple;
	bh=JQpyqiLWI20WRDfcE+9Kaerjh90E3rCrrGFwJ0cr4Vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rXGdtDNiIUcwJ0Lj++FcmmxeEtUUs3F5SljvbnBPUEhmrHvhOXCCQ5HVxnFzMhboAKcP+8RvperX5mRGnuhw2xxCMg7u7FDHB0+YvIoBmIPyGhc5jiJJ7pRwA6KUVLvLFTagQYuKf2DksubWEx/rwqo1u11EDblTw4LXk2LGdJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QspJ+00T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QspJ+00T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795CC1F000FF;
	Fri, 18 Sep 2026 02:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789698196;
	bh=YXQQEglBcmDSGfULyIbPQqx4CfZaXxvf3ss4t2PKInk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QspJ+00TiNecc6F6Sve16b9EAkanL37NDdn4uhX96MyIlTO4W+/7r0ayZ/WF6+lPY
	 cahDnmDI7b6+BbRG5y9M8sVecoiGWRRrfgPwg3aHvDQPr2KvcjvZGnOMwOPJEL5kIO
	 Bkrlbrd2LXUwMQRhd1ETx4bV4Mp9xGWPG1kQJKn4ibmSCze3P0h5hO7Zyfq8D9eeTo
	 gzyuCeiBt9wKmnu5qL9Swve+bkxI7b0wVNFFVTs9EGTE2xxs6CL0SRAeG3Udo2iAFD
	 51RmSr7rZDvM+vIksKqS4eyNI8Ug4spTlVQ2mZcXVXtqObt+A8SFNVhsP/tBtC61lt
	 TqBLKEo75mL5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] drm/virtio: wire blob ioctl creation to userptr
 objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260918021154.1432154-5-honghuan@amd.com>
References: <20260918021154.1432154-1-honghuan@amd.com>
 <20260918021154.1432154-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 02:23:16 +0000
Message-Id: <20260918022316.795CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm/virtio: PRIME export of RDONLY userptr allows writable DMA=
 mapping
--

commit 5d368a790c7066062061e9164c64d6e00b653f96
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr support into the virtio GPU blob resource
creation ioctl. It adds userptr flags to the allowed mask, handles userptr
verification, and calls virtio_gpu_userptr_create() when requested.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..6d38483f5fd61 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -36,7 +36,9 @@
> =20
>  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
>  				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> -				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> +				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> +				    VIRTGPU_BLOB_FLAG_USE_USERPTR | \
> +				    VIRTGPU_BLOB_FLAG_USERPTR_RDONLY)

[Severity: Critical]
By exposing VIRTGPU_BLOB_FLAG_USERPTR_RDONLY to userspace, does this allow =
an
unprivileged local user to bypass write protection on read-only pages via
PRIME export?

Looking at virtio_gpu_userptr_funcs in
drivers/gpu/drm/virtio/virtgpu_userptr.c, .export is exposed for userptr
objects:

drivers/gpu/drm/virtio/virtgpu_userptr.c:
static const struct drm_gem_object_funcs virtio_gpu_userptr_funcs =3D {
	.open =3D virtio_gpu_gem_object_open,
	.close =3D virtio_gpu_gem_object_close,
	.free =3D virtio_gpu_userptr_free,
	.export =3D virtgpu_gem_prime_export,
	.get_sg_table =3D virtio_gpu_userptr_get_sg_table,
};

And in virtio_gpu_userptr_get_pages() within the same file, it only pins wi=
th
FOLL_WRITE if read-only is not set:

drivers/gpu/drm/virtio/virtgpu_userptr.c:virtio_gpu_userptr_get_pages()
	if (!(userptr->flags & VIRTGPU_BLOB_FLAG_USERPTR_RDONLY))
		flag |=3D FOLL_WRITE;

If a user maps a read-only file into memory, creates a virtgpu blob resource
using VIRTGPU_BLOB_FLAG_USE_USERPTR and VIRTGPU_BLOB_FLAG_USERPTR_RDONLY, a=
nd
then exports it via DRM_IOCTL_PRIME_HANDLE_TO_FD while requesting DRM_RDWR,
does this allow the user to import this dma-buf into another device and
perform DMA writes to it?

This appears to circumvent the read-only pinning constraints when the resul=
ting
sg_table is shared via PRIME and modified by an unaware importer, potential=
ly
leading to arbitrary code execution or local privilege escalation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918021154.1432=
154-1-honghuan@amd.com?part=3D4
