Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953840;
	b=1GyIMIYfVnOpVkIwbC+t+4AsUMsu3yXkvS1XOQqzj2ZbpnF9Ab21cIInwogU6eu2g+pd
	 ZiMRtRc9YznRG76LQigjxYxlIrHy0Qx/39cQcu1il6zIZ/SRBMRc+P/dt6GsN+UIrlMdd
	 quiYyLzxJZGq0pi/BUO815mCjCZDt3Ll3NIgxjtwsm3mV1ytaRAEykju2BNEaijNDw0g/
	 TpXX3Z6EmU9jc1zGha0ka7Fl8zyij/EuRqA9e4AwYnscelqrgYiJYJ0li/3KvN+VbP307
	 8V7kkLn5nUa3N9xMayUgaSMnUYGuRCa5TuJmTbfDYM6jcZfc6Pm8RdCZujwJtmJMrnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qHow3nmXVmzEUZO4CI4Dhf9mh4GRIENlTdP2svJv5xU=;
	b=pqWXzMDKhFcGBtavrgr2Bt7CXbEq6VzpzbAwUBw0ZERtNIcEPAsHOTafNRBPlw6pmdij
	 8DpUav6b70+HB+eF3W3Ir/pZoDWyblDU4bXdGl0H4KEyBok89yIvFrecXpNg2pjlC4sub
	 AxF7NVnhT8CgBqQVzqdecQGG+c/zDW3fdE9AeLvfVS9Bb/+iN24cOxdqQMShvVRrVXi4N
	 e2BNGhNbT2SLVORmuI/S0V8hc5zHhMq9KnBsMShGnioCjgpM+sGsNLA9hNz3crP31uAw0
	 jLdqDQbb2pfy7vL6PU6QGeNYCM9beDA+MkrqmyghI9ZKcj1/G4Nc+DhfqGzXUZHtudQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oX97isI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA6606EE88
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oX97isI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CC51F008BC;
	Fri,  6 Nov 2026 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793953839;
	bh=qHow3nmXVmzEUZO4CI4Dhf9mh4GRIENlTdP2svJv5xU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oX97isI7pk9pALwZAxUMh8QXFrS8hMV9LXM+lOPBheTsIWPmqfuASJyJYbSppt9lk
	 vCTTrFfnZZfc6DCA5oJF8eFef+N4T+I8krOEE2/AK1NvJaJuSdaH2nwihKjLXIesV1
	 RFExpHCcvJAnD93dB4t2mByKoU8A0ZBJx126mJd00FvzvjIA+GzVtTI3114YtZLjV5
	 XQf/u2PLWGJZDFgQuLEuj5fIub0twqUnrZvc80w5so1hBHLmZTY0vtDOOUvqY/04Cb
	 fbG8su5oAsgXCC0TLOxYL9XDpecSn3LwPuI+g2zvs5lJAfRhXsHLHk6ROHD5yQiuEO
	 rYmCp5GJNrxHA==
Message-ID: <sashiko-outbox-201060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v10 1/4] drm/virtio: add VIRTIO_GPU_CAPSET_ROCM
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106082625.812860-2-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:30:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support ROCm
> compute workloads in virtualized environments.
>=20
> ROCm (Radeon Open Compute) is AMD's open-source software platform for
> GPU compute and HPC workloads.
>=20
> ID 7 is already used by the OpenCL capset (VIRCL), and gfxstream's
> rutabaga_gfx has already claimed IDs 7-9 ahead of any spec or kernel
> header update, so ROCm uses ID 10 to avoid a further collision. A
> matching virtio-gpu specification change is in progress to register this
> assignment.
>=20
> Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h for
> consistency with the other capability sets exposed through
> DRM_IOCTL_VIRTGPU_GET_CAPS.
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106082625.8128=
60-1-honghuan@amd.com?part=3D1

