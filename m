Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C344AA1FE
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641288; cv=none; b=pUCQ0A20Av53zAX0d7Cri8FZanQBNibHatazVLaeSSrxCxFwx2wYzQC8l9HMsGYZXV1gmDhN9X89FPAdfc97PI25rygbrbABUi0koxc3+uMErk1oPy9G1m3Wm5OB7FxjWeOPvloeVPdX7GEVlTHRWrR+2kAjx9qgvzRhYe5z/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641288; c=relaxed/simple;
	bh=ydXj21x8XPJkU2RBkFvgIUcGg75r5gSgGv1OlHMB6f8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/99LJ4dWTx29Lt+LCWDm/eYKtewgaysAcHBW7SDoAcTfQJzUTQClg5/6ngf+f92t/czFkqLRLycVcd9NT5KG9ZjHCuU6dDRboT6VyCyy9kNa1pfF9699bP7plbNh+P/PQEVHuvyZ9ARbw17pTVSnNxUUFFZ93wzH9sKH6NKukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsQ7N44W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsQ7N44W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F271F000FF;
	Thu, 17 Sep 2026 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641277;
	bh=A5vZJgu6y0sFszhGK8CduL/HbXSIZ/z1c/boerVDM2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsQ7N44Wkcxo01qpGvDlqi5QGTlzb1ttT2HN2hJ3kWJlZWs4EZCUMMgG7xdEcj7HR
	 5V2/PYnObXYH3tCY1jsiDS6WPcvcPj2760OpsCKb6sYFqUhowAbtKS6WrSBPu/Zf46
	 qMVjFlKDCM3owrnduoroh8A+pWo+ML7TouJBNns7YfZsqPDgNE7K134N1B4XyE6VBi
	 sTVp+MhM1TO4MElm/OgYpdysH6jp7EXzvuX6HQUIh61v8ma3Z3iScPfWRTHTvVNQbF
	 KGB19gBp3Ejqk2Gfgzb/Gi3XpnLcp6TxjSdgOF3IjqgRvoTlWdFApv0MSXxKcO+wre
	 B9izSKiq0p8yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] drm/virtgpu api: add blob userptr resource
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260917102540.1312102-3-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:34:37 +0000
Message-Id: <20260917103437.92F271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] virtio-gpu: guest-only blob flags leaked to host breaking wire ABI
--

commit ce150cb1a68528e491d40b28c03376311a653c0c
Author: Honglei Huang <Honglei1.Huang@amd.com>

drm/virtgpu api: add blob userptr resource

This commit adds DRM ioctl flags and a userptr field to allow userspace
to request a blob backed by an existing process mapping. It introduces
guest-only flags VIRTGPU_BLOB_FLAG_USE_USERPTR and
VIRTGPU_BLOB_FLAG_USERPTR_RDONLY for guest pin behavior.

> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_dr=
m.h
> index 95587e12aed57..6171b4e2300b1 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -186,6 +186,9 @@ struct drm_virtgpu_resource_create_blob {
>  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +/* Guest-only flags */
> +#define VIRTGPU_BLOB_FLAG_USE_USERPTR      0x0008
> +#define VIRTGPU_BLOB_FLAG_USERPTR_RDONLY   0x0010

[Severity: High]
Do these guest-only flags leak to the host and break the virtio wire ABI?

When userspace calls the DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB ioctl,
verify_blob() assigns rc_blob->blob_flags directly to params->blob_flags.
This struct is passed to virtio_gpu_userptr_create(), which calls
virtio_gpu_cmd_resource_create_blob().

In virtio_gpu_cmd_resource_create_blob(), the flags are written directly to
the command without masking:

drivers/gpu/drm/virtio/virtgpu_vq.c:virtio_gpu_cmd_resource_create_blob() {
    ...
    cmd_p->blob_flags =3D cpu_to_le32(params->blob_flags);
    ...
}

If these guest-only flags are not masked out before being sent to the host,
will strict hosts reject the command with an error, making the userptr
feature unusable?=20

I noticed this wire ABI violation appears to remain unfixed at the end of
the patch series (commit 357076bf581c).

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102540.1312=
102-1-honghuan@amd.com?part=3D2
