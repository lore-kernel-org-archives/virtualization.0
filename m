Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C994ACC9E
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641221; cv=none; b=iXUoqOux9yl8TWsEo6N0UUNCenkwkP2p70jAZgwXFckkbHOmm6K6mqyos1LxrLYlxIQr4zF5MAlswWKmEBJ6aTKxXZDj8geluh74pWO9R8eXzhAoTNVpGOxT6S6+mB9T2yeqsV3NwJpNWD4IGDa42s1y9z9crJ7tAyLU3k49sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641221; c=relaxed/simple;
	bh=M0PPXgEINzQHq+yY0t4Epbic7GLGnjRq+ven9qDdOC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YQl5NlZJhbm3eRNEMR+KQrWqh8Odr+OO0C4k/b4u5pjdlavh8pWewwmZlT+orMrZ5q564jKyXCU20DTiupsQcm2QyOaC9YMBkXaGZEnmz8/oXohtSONilMR+jWZS3umaMIlJKs3jr7SYd0JtYAoDS7M9R8K885xManaomL+sqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhBgFjDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhBgFjDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A7D1F000FF;
	Thu, 17 Sep 2026 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641212;
	bh=ystkHgfg/B2+LWhyt4IqYeXfy5fWKql2JcdLt5+qRwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QhBgFjDlrqKyxZblUiGQD0fHQ7o7EcENTQMUO9gWu7a0RsgvndkwR/+s8uj9OLpug
	 kAEivoqIxthMuDsUrSKlzWLTR8J4o6Wbq9+ANIWp0vNcKNMsJYbN+W8/cij7xZH8T7
	 siW7cElkAAdDHltBchifW1KHZOFkWUlQVSIQXf/H14qIxo5rg4BvCEDrgz6ii8JiNW
	 h4VhCI7tQsl6ZZNVGgcUyUyI7xJ8YemICBuDeD1Dy2uFGqqZeppBkxsdyvQic35R8A
	 u9ApcFFiw9CTn+u7bX2TCXKDFIBtoHufO1kSrOFVP6RQcx7vBMotBr/ZRpYnIK3aL1
	 Mrt7EkrHKtuCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260917102540.1312102-2-honghuan@amd.com>
References: <20260917102540.1312102-1-honghuan@amd.com>
 <20260917102540.1312102-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 10:33:31 +0000
Message-Id: <20260917103331.A8A7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] uapi: VIRTIO_GPU_CAPSET_ROCM defines unstandardized capset ID 8
--

commit ddbf02d8a1557a4976371db4a94be88bc1f7052f
Author: Honglei Huang <honghuan@amd.com>

drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability

This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to the vir=
tio
gpu UAPI header to support ROCm compute workloads in virtualized environmen=
ts.

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
Does allocating this ID without specification standardization risk permanen=
t ABI
collisions?

If the virtio standard later assigns ID 8 to another capability, this UAPI
addition could cause a conflict. Furthermore, skipping ID 7 leaves an
undocumented gap that might conflict with virtio standardization protocols.
Has ID 8 been allocated in the upstream virtio specification?

> =20
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917102540.1312=
102-1-honghuan@amd.com?part=3D1
