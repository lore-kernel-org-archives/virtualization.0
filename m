Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954063;
	b=L2LMh9y1U+nEk7brmCchEjj6K9oRtpWao52r+1HxklyhyKxFPW7zTiJCZajcFM8VHOQu
	 ki3DPiOkjDSJ4+G7BkA/ROK/Uqa2/MP7NFv9FSSUrHqY9ISSveFKPQIuNUEqnVro+bLLK
	 LqdphywRqZVpR7jUkGuMBO42usIdikElyR7KVOYIEQV8zRnTV59wiTNDc75d3y8ELRA+E
	 Pmvsy5gAdZB2xvKftuehuSvgT0v2PK+q1bUDv7AIsoc/B1lROQPqxGdltijCB+xV7ZrOS
	 Op8GC3AgXilFEkmPvslL64Of24FEJ21InNdzn4mhDpG+jiSiP8I+vzZm1YfPNSWHG3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7JXFbAztKhOt74NSZZqXTN76aYrSflbLc0AG9OdrqIs=;
	b=wYRixWjyKj35ZIfQXOSng803s/0EvWErk5qr6R+WSaBMxm8Gpf26wZ0VsPwb4KJZvWau
	 UNeUyq8mhhtqSpMgYRK8SEgUgml3lZXB7FdHvPEaIxxvXA464tuUog8iTslfqSHf3KXnB
	 v67/MGIRnbF3l5KZiwxpzp2zqQutLJzZrG3jD0y/srb7nN/gKM9KSYqEhQydqqZTMAHj/
	 ZXca9wo+tCIl6pUinn4yPW4o/PikbWovRafen+EGuEyTFdcbAn/n1mGiI6/lck/bkNtis
	 aLjEaJCVc0cW5HaukeY9ewLw/O1K8MYk6YjPK7mOHUiVxEmNUWRnQev+YQIxi4ak9/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmpUJArn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D4606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmpUJArn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD4B1F0089F;
	Fri,  6 Nov 2026 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954063;
	bh=7JXFbAztKhOt74NSZZqXTN76aYrSflbLc0AG9OdrqIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmpUJArn61tfo3urd7+VWstzlPi9qc8S661Sb+55XIFhAZPuij4CCGjGfPDZqjKZ4
	 biym78tVEHklvMWAeQay/jkByhVXlivs+/nzFWSIOwMw9TOHOzoZ45O5PJR8hLOCpA
	 nAhxYnxey8HuuNy7W9KE8O+a8ztbn2+Xl4mjkJR0albLYQuPKJBVxXVi/6DJM0dSEp
	 UZbTAyp+nHIf91OpyRdFjoVnIqLwTiiSKC/jb9ZZVTB3HNr4INqdqwywW1YEbJCMBm
	 pxyQMSAq4g4+++3gXLgSFVt4ABQsmeiXHUpIxBQghAcV5p3gw5PaBlchgfG3kB0PHR
	 2CALW8IepdXpA==
Message-ID: <sashiko-outbox-201067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v10 2/4] drm/virtio: add userptr blob resource to
 the UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Honglei Huang" <honghuan@amd.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106082625.812860-3-honghuan@amd.com>
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:34:22 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add a userptr address field so userspace can request a blob backed
> by an existing process mapping. A non-zero userptr selects that
> path; probe VIRTGPU_PARAM_USERPTR before using the field.
>=20
> GPU-readonly backing is requested with the virtio CREATE_BLOB wire
> flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
> VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
> resource. The guest pins without FOLL_WRITE only when the device
> advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).
>=20
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106082625.8128=
60-1-honghuan@amd.com?part=3D2

