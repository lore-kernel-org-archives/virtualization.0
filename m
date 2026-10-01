Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C641735B;
	Thu,  1 Oct 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875478; cv=none; b=nAFORV2uOIajvA5fDK/E1PR9uoKEP5yDTGVyWhI7yAob864AuLaqXqzBHe1UmXjG4b0XFU3Mdtvd0+U9FuA/P1mHLp6axZS7YSEDhlM1G4YP6tfc7NMWglSNCjyFev+c10Nj55w4QovvGvZDGrouuuNWwMnztGIkBYAzJiI7CbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875478; c=relaxed/simple;
	bh=A7nvrSNhwg7+3eBeRYtFeN2iJrTjFQD/KVzLmBJDqLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GcWlfKcRwl3LWfJYsGj+yzHHHnn0K7TI7HBameW/fHoEECrWA8+XaJusW7ZgcRHQ6pUkvXMkoKo2cB4b4xUwYfZJFYNE77KIP9npuNVO4jKJsllcJfzRxwN2AOQtB0mg5bnlZlrvyxDtIIQi2ib0Yp4wuBVELpMopTosgjdF5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQkIcrog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQkIcrog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FC21F000FF;
	Thu,  1 Oct 2026 17:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790875477;
	bh=FE4Cq0CtewOTsCJ/B4fM40TbxadqFwNygwkEhdHMe3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQkIcrognOrL/56Wuw0Bep6M+YV36xMLIMsTOSKPNBqLGF97M6lZ1gWrXGnUYCgNR
	 j8ri1IV963o3RdMf4+bEe7O/aqxCCw3sveG8GufE7ISjtTyg89XFV8dGZzhxbDqNfo
	 6yPNrSZO00kidxQEMT7d38j3wAGEDvT44Y21zJ2cEuCOP17goJK/sLGjASdnGR/hq8
	 ucyq5bXs6lMthZtZQIbcCPJJQHMrOmTfYxMqujZYhIw0Y44EAK7Z4O1Vm1k+zlV3+R
	 5ILsVzI9nWmBmp5IKXpzDRp9R3Gjh2+PwDpF9Tpj3hO7Ua7mNkrFqS3gbU6qqEYdkl
	 ExYcT/rFLpTGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
References: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 17:24:35 +0000
Message-Id: <20261001172436.72FC21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>=20
> virtio_vsock_vqs_del() frees the virtqueues via del_vqs() but never
> clears vsock->vqs[]. If a later virtio_vsock_restore() fails to
> reallocate them (its error path is a bare "goto out" that only unlocks
> and returns), the driver is left bound with a dangling vqs[]. The next
> virtio_vsock_vqs_del() - on a second freeze or on remove/unbind - then
> passes a freed vring_virtqueue to virtqueue_detach_unused_buf(), a slab
> use-after-free. KASAN on a guest with a virtio-vsock device, after a
> restore made to fail by fault injection:
>=20
>   BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   Read of size 4 at addr ... by task repro
>    virtqueue_detach_unused_buf
>    virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
> [ ... ]
>=20
> Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume=
")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-vsock-rest=
ore-uaf-send-v1-1-5da60f707506@eldare.de?part=3D1

