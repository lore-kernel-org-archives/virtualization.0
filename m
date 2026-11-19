Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083031;
	b=aq4HVl5vgMMITmoL5RLRgRZv4bbYbW27MqzAG3UkhvvvevvTp4ODQGBN6sp8t4Pvr0ik
	 IpCVxZe8jCdJpSKawnYJLP4FScIJjhOKsIaU3w725Q8MNyreoJw7VCk3st5Q2guSt1F4T
	 K8Kk+7JgCu4UG3lpUHMZOfJrk+SMhRnD6AeaFdKbngEQi3v/Wghd7SFq1oo9d6RygZFQd
	 sqo+4SLK3Lp+2xBFgnW1pWts2EGDdRnn4Nm98OYPYaO0EzLVY9HqId8Gx+OKFrBHlX9Mx
	 CtbgNlJwgfZ2V6CEsr38jhaQCxDCrEImUBgYAoLKoxYwbWT1vi3wuILU/0nXRZkXrRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y6eN5tn5JH5p5uSHgWpIoxKZXcxYNMxgyb317FtCUuY=;
	b=RBbd2e9O7JPk+SU9S5QJNces25jyyTJwdAuyFt7zfIGEy4cBv7WS2Z912RkF7YyeWdbD
	 svmgujdZE0BrIlg5f6OT79XiydTXIN+ZXgglj1ItNyUbcc2ewEhGYm5Yh0qMGORdNswcP
	 MRmZc6R10cEJjCi3kezD14j9osh871mkMXEeO6/jEbiGOP93k1dJeTQSEVCJpaVHIdmF6
	 bTNSbkqi7K7vkyIuVEXAPsc9jNmg6GxyyV14Tpd+mKFwMbW4r7A+M94U2GMoyby7F/Ufa
	 olqUmmKvZasZylXQNa75tr/IPC/yy4ntVRa6ZAvFJ44rDBUxjskRjJd6yFC13jw+GHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haRnm9zd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C9606A320
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=haRnm9zd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1129F1F000C4;
	Thu, 19 Nov 2026 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083031;
	bh=y6eN5tn5JH5p5uSHgWpIoxKZXcxYNMxgyb317FtCUuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haRnm9zdCgBvMn2rtcBR+VamINOfF/1qoIDXhxFgbsXYIVRT0MNufeupqXsdiaSA0
	 PuAAznNT/TPWMWsERDtr2e/FflQxKOF63PmbFiKGm/hq0BfftFdukjk0w0VVBsaHF6
	 XKv8penXY1qgM/X7jdotieQuanOP/ivs7dOz722Fui/KbDD9+UI5PnD4T4eus7/sCz
	 j/jL2ZmOuOqvxnn+1AaA2y+YBdJ3pvuZMDTjo0pBuP2oksOsTZOh/v6+g49p+YIKPa
	 zxCqU4c9+tCtW6YE5JWjg/eSVYLJ5N88ydhzT24jLvocZEzKnLz6ROIkCersE1YUbE
	 v+YHDvShw0pZA==
Message-ID: <sashiko-outbox-222919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio: Release the OF node when unregistering the
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yige Jiang" <yigejiang86@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261119085343.virtio-of-node-a02bd3cf522b@gmail.com>
References: <20261119085343.virtio-of-node-a02bd3cf522b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:10:30 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtio_device_of_init() acquires the OF node reference once during device
> registration. virtio_dev_remove() currently puts it on each driver unbind,
> although rebinding the driver does not acquire a new reference. Repeated
> unbinds can therefore consume references not owned by the virtio device.
> Conversely, unregistering a device that never bound to a driver leaves
> the reference held.
>=20
> Move the put to unregister_virtio_device() so it is paired with device
> registration. Save the node pointer before device_unregister(), which
> can free the virtio device, and put it after unregister has completed the
> driver removal.
>=20
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/sashiko-outbox-203883@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119085343.virt=
io-of-node-a02bd3cf522b@gmail.com?part=3D1

