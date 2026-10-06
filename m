Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F21CC71
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791248034; cv=none; b=kPSQZT6J3aZiNW76QOlPL1DxPibm1+Ph0g9wB4++RppYbbgww08WQyY/JN+PywuLHoENDcI7mDmVCeURvYAazBqhFXHmw5ErCq3MBtApXARCzJiVRz2aU1i/NaHAlku0U8or4Vt8yQiVO8HR7SDgmWVU0n4tSyvWnUkAt1ctgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791248034; c=relaxed/simple;
	bh=Bgv7qwFq9cSEstGjo0jg5VHaOr0aKJgmAVQ9YYLKJ+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t7EBPa1DY2UDiCyOlNgkj5mWWTXwCXVXiYq7xeVqcPYAGF5J20sBnR9hCOiLzNUWJTtIsnlM/zB8y+x8Hdy9pKFHUP/SSINM32IIoBPRJljYSEyUN0gsqyjS5Kaa7ohqSbiOyZ1r5hGSLFWXG6OxMtt9UtdsRAu+u2eDa+2qHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdLv2lDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdLv2lDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E821F000FF;
	Tue,  6 Oct 2026 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791248032;
	bh=nZyWsuZ29X2XjD5qUL3PY1cLlVg7igHjAZzuJpMN4rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdLv2lDk/b4OVrPWre/WwQ+NPyhC1mAgJJjxNUsce5T61RC9G/rT7yfTsBasaFTfX
	 LqTG9iZdyPdPZzrgMX5Pnx9nacRQCBz7J+n3GhItqB2aPH2KFrfsxn91wgM6tA+dbT
	 i62Klv6xYIJrYSVo+QSbvkTvpzAMIqn3xMSG4OnB3sCRdiFubx1XHP4ud9LnaZ8Lvc
	 KxcKqSt/yzRrGAgFA6HLVQjHnz0ZuH9OHJlDbYQDHZl1BVowxPu26kyn2i6GiQR1/w
	 lCSDLSzbEoDTwZT7ruypdExqtVqbZk/HVwl4bizP8v+0cDlANsgQL3LUaDPNMXoGzg
	 doepAKHknnSPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Val Packett" <val@invisiblethingslab.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261006004044.2242154-1-val@invisiblethingslab.com>
References: <20261006004044.2242154-1-val@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:53:52 +0000
Message-Id: <20261006005352.77E821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] drm/virtio: NULL pointer dereference in verify_blob() when 3D =
features are disabled
- [Medium] drm/virtio: data race when reading vfpriv->context_init in verif=
y_blob()
--

commit e614dba4f51f24b9effac7458783e310e89be777
Author: Val Packett <val@invisiblethingslab.com>
drm/virtio: do not enforce blob_alignment in cross-domain contexts

The commit prevents enforcing blob_alignment requirements in cross-domain
contexts, as resources created there are arbitrary shared system memory fil=
es
like Wayland keymaps.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -540,6 +540,8 @@ static int verify_blob(struct virtio_gpu_device *vgde=
v,
>  	params->blob_hints =3D rc_blob->blob_hints;
> =20
>  	if (vgdev->has_blob_alignment &&
> +	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=3D
> +	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&

[Severity: Critical]
If a virtio-gpu device advertises VIRTIO_GPU_F_RESOURCE_BLOB and
VIRTIO_GPU_F_BLOB_ALIGNMENT but not VIRTIO_GPU_F_VIRGL, could this cause a
NULL pointer dereference?

In this scenario, virtio_gpu_driver_open() returns successfully but leaves
file->driver_priv (which is passed as vfpriv) as NULL. When userspace then
calls DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB with VIRTGPU_BLOB_MEM_GUEST,
verify_blob() is reached without aborting on the has_virgl_3d check.

This newly added code will then unconditionally dereference
vfpriv->context_init because vgdev->has_blob_alignment is true, causing a
kernel panic. Is there a way to verify vfpriv is not NULL before accessing
context_init?

[Severity: Medium]
Does this introduce a data race when reading context_init?

This accesses the lock-protected context_init field without acquiring
vfpriv->context_lock. A lockless read of context_init could read a partially
written bitmask if updated concurrently, leading to incorrectly enforcing or
bypassing blob alignment checks and returning spurious -EINVAL to userspace.

This could happen if userspace calls DRM_IOCTL_VIRTGPU_CONTEXT_INIT and
DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB concurrently on the same file
descriptor.

>  	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006004044.2242=
154-1-val@invisiblethingslab.com?part=3D1
