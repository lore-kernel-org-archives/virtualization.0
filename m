Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822127;
	b=PjZ9xLgj/xHOgL7Ge6emizMJFOj4WwInckgZY1mS+Zlq+dnlKF7max2falIaP+Zvv9zj
	 PwSdKO09YmHjbeUxQLQvIVhkwaUIl+G7qq41be3YsyJVA5uYCbysdHCWk5N0uHVf+TP6r
	 XfbATCY6dD9v3S3HSIN8AIz5gO5AtVlca/BoLbtZ16IdmxN8ZPZE2qU/tvtxj1iztbSzG
	 pMyhXcRk5c16ZPsxu3acPqizTh3Ry/oS5yd2WIX6+bLW82//QuSK/H4KZcJMv4u7ESnuK
	 uIx9oXO89a0y9uYFUbwU4bPnJbgCV60mdpv6mt0y2XhBqKx/y4yKv6Lel2CPhvDe4Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822127;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2y5EJVoBwjp7xF2pE/TyR3fnQoJet9B47BW5u68FSWw=;
	b=32MOes5n0au+uckmVdPinm0Ob40aqQOXMwG4jjGI1dYRV2RUCP92MwRMV97w2l2g0n6V
	 vYTbgSGvurXSaP01PfHCpuVOOufU21e8UJxunRrkva8u/Jv0QMILvenIt5T5SH7lcVp+j
	 QRs8uylXJOkl1neS0TNESvBgIlB+bq94+oON6bwtmS0H8Lrz1xzyyNAAhrBhh7EdSRonB
	 B+vVZGNPh6SPFDrc5skmGh2PMLHSHSIS2ZsXdk+Js1e48lCSBlc5M5QXpqGLbISgxG+YO
	 z0aOqfy7kWOpH3GHzlEyuFL++Po+V2/S4H/1OTpIkbaMZ/2Zr39YjcVT0F68vby9v0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7i5Xvcc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6349606A31C
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7i5Xvcc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D131F000C5;
	Mon, 16 Nov 2026 09:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822127;
	bh=2y5EJVoBwjp7xF2pE/TyR3fnQoJet9B47BW5u68FSWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7i5XvccbzziOQ+K9WsIzm9WmKQ0lLpURa1euS8dC+5dWvwrM3qWeGMYeGfKVdUrg
	 +WJjgAH/PLbdjlifymdsYqkPSeOOQTCU8hk3brflvA3cWxFLNNJ+i7gdCgglcRjaWK
	 pOdiT4mPX55QrkNhYlplowyaQAdCY893WU01+YxCSuvi2wjUOmR6WfXx9qhPHXZQuI
	 lnijm6OUbEvsUHmev5WLaXfz4V3UNOfsF2HwLB3ThzNikuzmvlKkNHnb8lNP1KK6Pf
	 fBe01/rjF0YMir/VOWDER6jB2QzRDk4+DeBm88UIo42jdVYfgrXfyrrraHSu0JrX7Q
	 S1AaEzbgImIcg==
Message-ID: <sashiko-outbox-216629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/4] virtio_net: report a failed stats command as
 an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <lian@is.s.u-tokyo.ac.jp>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261116092445.3391334-5-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
 <20261116092445.3391334-5-lian@is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:42:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> __virtnet_get_hw_stats() returns 0 when the VIRTIO_NET_CTRL_STATS_GET
> command fails, so ethtool -S reports every hardware counter as 0
> without the "Failed to get hw stats." warning.
>=20
> Return -EINVAL instead, as virtnet_probe() does for
> VIRTIO_NET_CTRL_STATS_QUERY.
>=20
> Claude Opus 5.5 was used to draft this patch. To test, the virtio-net
> device in QEMU was modified to offer device statistics and to fail the
> command. With this patch, ethtool -S triggers the warning.
>=20
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.or=
g/
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116092445.3391=
334-1-lian@is.s.u-tokyo.ac.jp?part=3D4

