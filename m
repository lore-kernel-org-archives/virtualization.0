Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158198;
	b=40Te0AJ4r442D7JeESMMjKns8qBnWUEzRVpza6/A2uubTadn+RgeFJNyCek8ssWHRMYt
	 OxvJlb5t5o1X0Q6Grx+1a6pCtJ9dw8I6ej2ZKOMcvWT7TblgpYmYHIvGrueb0uFsHhm7w
	 XCU4WL/x3JN5uGG/PUGMqDa5+DbX2VFT8/i41yf5XZPAXxResXm635q5dcaK7Bg8T69xb
	 OaeKXLdxMWFd0eKpMUycHXLt0Kb2zcYznS6yktsVh2OXKFMHgu60WDhW0o5LkagxXHC7a
	 13GevSrR+6FAHZ/l6FpLw1A/hT/HS0TKzSKkTv5uM4nITAzEcmAXw4ArsbEJl6Qnq1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158198;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tIL4naEsOGDc+r3vxnhbbcCwtNqnBTd10WvCPnsPbaQ=;
	b=llxuLvVXBqDoYMo6ZfdRRILIFDHWlK/6F5X6qESmhzRSy2x5qdtLDjGlPJnMpflsr7CY
	 I2qEAoyb4K1X+RYLCarK0QfLnVtY8vbdtDeAY+KnATQvoa4I8rBcKHnXtr3IDHSCj3Nn0
	 ROK/rnsNv229IGWEj2S1knQ6pWp8jkISjd7nh9bQ4o/XOJCgLQTPZDvcMRP05pBXEYc82
	 L19mbRn9Q/sx+bTXiH4BH0G996FZRznPsUAu4gQVXyfrxdgzqInnIJmEF3boV1Xu03Q9h
	 SSBUnXZXPFU+qXbFlJo5pODWGp8lm+cGxcZZOGn+DJTUO/HMllOtvqGC+9K8CeJcD8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2+4OVz8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9782606A32A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2+4OVz8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A941F000C6;
	Fri, 20 Nov 2026 07:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795158197;
	bh=tIL4naEsOGDc+r3vxnhbbcCwtNqnBTd10WvCPnsPbaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2+4OVz8jiVZPsuwMWClCwZaTCEMCvyqCLJKlSfwYGDtoqfxqfknezvgY73bLWjQQ
	 KylN8WZKhHpF/zELtYVflV9T/HRyGRAt5Sp4yY7tNG6TeQvnNoC5tJT9pKyKCZMvjE
	 2Y5uqwNHEk/wJIaC+hHdDS0Qx7op5pQG4dvPhpNFcpdNzLRpDqocogCddYKMVrBaqc
	 BnAKhOW8zlTmjIixEpfLkwvBEMqWg9B1W1frogvXTAeCZEYmzBo5PxUseXzj+Ak5sU
	 B3YAMkX4gBURyrZw4WjhYp2wS8Zrotuapr65pTsesxWxOQmMwpIwxcaYfFmQTu6hPm
	 T3mNgsHkbwFfA==
Message-ID: <sashiko-outbox-224592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] can: virtio: fix virtqueue use before DRIVER_OK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Seonghyeon Lim" <forfortuna@naver.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-virtio-can-ready-v2-2-0defda2af8cb@naver.com>
References: <20261120-virtio-can-ready-v2-0-0defda2af8cb@naver.com>
 <20261120-virtio-can-ready-v2-2-0defda2af8cb@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:03:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Seonghyeon Lim <forfortuna@naver.com>
>=20
> virtio_can_probe() and virtio_can_restore() fill the RX virtqueue and
> kick it before the device is set DRIVER_OK. The virtio specification
> does not allow the driver to notify the device before DRIVER_OK.
>=20
> In restore, if the interface was up, virtio_can_open() then sends a
> START control message and waits for the reply. DRIVER_OK is only set
> by the virtio core after restore returns, so the device may never
> handle the request and the wait never completes, which hangs system
> resume:
>=20
>   task:kworker/u4:5 state:D
>   Workqueue: async async_run_entry_fn
>   Call Trace:
> [ ... ]
> virtio_can_napi_enable().
>=20
> Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-virtio-can=
-ready-v2-0-0defda2af8cb@naver.com?part=3D2

