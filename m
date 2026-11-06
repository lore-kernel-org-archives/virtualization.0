Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954549;
	b=P6C8kGsMPz3V4zagQkmcl7N3TzfNcGcsLuX8MeZZUYEYA521pVURKTcDXmuiRiPV2CdC
	 JfzRpC5RiBhmob3TMA3khXOS3m32i0/G9QME3a0HYGJRe13bRYgQtRELKaWkJrHa3o0a6
	 LBEHNJUifzNRDsgeo2rpb77ab8P0tjehpMU1ZlVvrR1Yawp6DsSL9a+X90q3yT2zUArYD
	 oheS0CMb4adTHsrFxWCC5CgdUShO/3X9tqI1nsS7qcuKgPWYumatAlqk/Hls5c0l5ssGa
	 RQtkTz0TKkS4/5lRzMR/RRiHU7lMuuLvoHzVGGGKU1enJRkQydLp15cL2pOUvDCjFHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/eHTPOzEkZLLg3BwwxI5b5F0YG2J+rrTwxnytXIxj8=;
	b=FQFNuza7M09V1G4mkDQWjaGZw10X4lquRSw8WekBn7PFJXBPvjpcaK7ebhqPDb/qc+8a
	 HzK8ve2hXHR6kc03yKJz6+kzJVhnVwLvHnJ0QYc+bTTmqNfzzVPSTkiJc9lmINA0XDIts
	 zSfSyoAXqTY698wiB72pZSVMZa5y8iOtZAv+MRxffsMZIjTaAXKL2mZ0DlZReh8iALULU
	 svon2FHT+Lk/7q0Q/JSsVGySHf6L2mgLzllKJrxBGhVuujJl8R1x1xreuPexsR0bjKCPb
	 E8KZX2/bt+gbMMFiZQJ70D3QvjLftjXrvuKo9/0MIZ4Uami1Wi1LFCZm3aPjDPAL9Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkjuU6dL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E6606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkjuU6dL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B111F0089F;
	Fri,  6 Nov 2026 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954548;
	bh=H/eHTPOzEkZLLg3BwwxI5b5F0YG2J+rrTwxnytXIxj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YkjuU6dLb3uLOFL1cIxthbZoNIYphwNCfZN8gSupsC9xHJkD8F7E3txvWAx3362SJ
	 8VY8o08UcGxjLkv6p6OYcQJtcq3EXnVhMiHXeQ8opBoEmpVrV8poaaFVhFvJ/EqVd1
	 wvhBjA0DbLbLe9vjs3duSsNRnpka+TSTKG7Vv08T8HdVCLtLqHYY6NetxiZ+wL9RL+
	 H6j5odl27MwAkuMH197n66pFr+KYzCBOciNCLIM4GGe4cHKbA0/Uv2YeHUCNZxoRY8
	 T7Mb9MwLoLc7Cqism/NutYn0qmIIeOG1s+DdZhkoR/2/OykGBtZ9T0k1zf3aJFdDTA
	 5l0btlRTW2o2Q==
Message-ID: <sashiko-outbox-201084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v10 4/4] drm/virtio: wire blob ioctl creation to
 userptr objects
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261106082625.812860-5-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-5-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:42:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/virtio: unnotified ctrlq strands blob on handle creation
  failure
--

commit f8b823e6be2332eb525d4e0d0576cd0869cd03e1
Author: Honglei Huang <honghuan@amd.com>

drm/virtio: wire blob ioctl creation to userptr objects

This commit integrates userptr creation and read-only blob support into
the blob resource creation and getparam ioctls, and switches the error
paths in virtio_gpu_resource_create_blob_ioctl() from
drm_gem_object_release() to drm_gem_object_put().

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..e57750588df01 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
[ ... ]
> @@ -557,14 +586,14 @@ static int virtio_gpu_resource_create_blob_ioctl(st=
ruct drm_device *dev,
>  	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
>  		ret =3D virtio_gpu_resource_assign_uuid(vgdev, bo);
>  		if (ret) {
> -			drm_gem_object_release(obj);
> +			drm_gem_object_put(obj);
>  			return ret;
>  		}
>  	}
> =20
>  	ret =3D drm_gem_handle_create(file, obj, &handle);
>  	if (ret) {
> -		drm_gem_object_release(obj);
> +		drm_gem_object_put(obj);
>  		return ret;
>  	}

[Severity: Medium]
Can this leave obj stranded in vgdev->ctrlq when drm_gem_handle_create()
fails after virtio_gpu_resource_assign_uuid() succeeds?

Neither the blob creation helpers nor virtio_gpu_resource_assign_uuid()
call virtio_gpu_notify(vgdev); notification normally happens at the end
of virtio_gpu_gem_object_open() inside drm_gem_handle_create().  However,
virtio_gpu_resource_assign_uuid() takes an extra reference on obj via
virtio_gpu_array_add_obj() for the queued command buffer:

drivers/gpu/drm/virtio/virtgpu_prime.c:virtio_gpu_resource_assign_uuid() {
	objs =3D virtio_gpu_array_alloc(1);
	if (!objs)
		return -ENOMEM;

	virtio_gpu_array_add_obj(objs, &bo->base.base);

	return virtio_gpu_cmd_resource_assign_uuid(vgdev, objs);
}

If drm_gem_handle_create() fails before virtio_gpu_gem_object_open()
reaches virtio_gpu_notify(vgdev), drm_gem_object_put(obj) only drops
obj->refcount from 2 to 1.  Because the refcount does not reach 0,
obj->funcs->free() is not called, leaving the queued commands un-kicked
and keeping userptr pages pinned and charged to mm->pinned_vm until an
unrelated command notifies ctrlq.  Calling virtio_gpu_notify(vgdev) on
the drm_gem_handle_create() failure path would ensure the queued command
completes and drops its reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106082625.8128=
60-1-honghuan@amd.com?part=3D4
