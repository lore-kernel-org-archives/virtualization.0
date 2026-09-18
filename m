Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F994C042D
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726068; cv=none; b=Vz1n6WLvfuTlFvpTE4AJKyChLfaxpyOyMgGZUYMdNsG+p9+Uu1V1TXW9EKGcPqUIW2Z/kQTWMH5hOkNOmc2n5tN0edhaheMBtCa8kHE+/xMsVOOGjWAs+S9scrUc+AhVzGLL6+DTUv52yGTxzAKjqebfIG+4++/NqAX+919v+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726068; c=relaxed/simple;
	bh=YU09E9xCcUVm/25QGOYcP3P3SHKRzDI/6wOf6QKBDXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTx7BsXO5cYDeanAtLd/CDxt7/4W6ajJBl5ig7NFzC1A9dZG5d190JCbMWs0WQOQvqf9GZkZf8cZhhMdBYqbbCwPmJREmHFMxKK/tfLwF29e05H7NiUrncDHvBFREXyOrpV8oxEyfiRr2gxHATpd2LnlCnu5HysMNm271VmVJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaPYPH2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaPYPH2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB741F000FF;
	Fri, 18 Sep 2026 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726066;
	bh=1lWqeW8RkSCQ4mmAW/UZ+RORXUUVhD49yzdjSZZAYqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YaPYPH2ydP6oTz4X0M45atKQCJrEQYeLFinxe1vUpbri2IlkAGZPhaY4OxDiHYF56
	 wSZJF/qiy5BtitDcj39nWZ+H9/ARWKFFiAiGdLnw9XamPdIMxsnkqRknYVxWH82R3j
	 nqtJK+djl9/kldwc1OWRgEZjnYQqmqwgKX86bseW0l0PccUi4HF0i15UqJFvlBW+to
	 U03AYIaOTrRI9grI4XAvIU7Awui1ldoqAec/hy4JOZrxfpUVNhRMd1m+R8mmwvfiPo
	 myjPvTucDJhzKBf7ncXKiLpJyz7K2wYUgDTVRoN+MgBVYIKsHJjQp/BW2B3ExgTSW9
	 zDcS/WUwz3yIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260918095940.2253018-2-honghuan@amd.com>
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:07:45 +0000
Message-Id: <20260918100746.2BB741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] virtio-gpu: premature UAPI exposure of unfinalized capability ID
- [Low] virtio-gpu: missing DRM UAPI alias for ROCM capability set
--

commit a394228d77eeafc9f1dcc36150380f8561f1ee49
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM with ID 8=
=20
to support ROCm compute workloads. The commit message notes that the=20
matching virtio-gpu specification change is currently in progress.

> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_=
gpu.h
> index 4f530d90058c7..3d4dfadc9d789 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VENUS 4
>  #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>  #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 8

[Severity: Medium]
Is it safe to expose this speculative capability ID to userspace before the
virtio-gpu specification is finalized?

The commit message states the specification change for ID 8 is in progress.
Because the Linux UAPI is frozen once released, exposing this ID now could
permanently commit the kernel to ID 8 for ROCm. If the OASIS virtio
technical committee assigns a different ID or rejects the proposal, would
this leave the Linux UAPI permanently incompatible with the standard?

[Severity: Low]
Also, should there be a corresponding DRM UAPI alias added for this capabil=
ity
set?

Previous capability sets have matching definitions in virtgpu_drm.h, such as
VIRTGPU_DRM_CAPSET_VENUS and VIRTGPU_DRM_CAPSET_DRM. Without adding a simil=
ar
VIRTGPU_DRM_CAPSET_ROCM alias, userspace DRM clients relying on virtgpu_drm=
.h
for the DRM_IOCTL_VIRTGPU_GET_CAPS ioctl will lack the necessary constant to
query ROCm capabilities natively.

>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918095940.2253=
018-1-honghuan@amd.com?part=3D1
