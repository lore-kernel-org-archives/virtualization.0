Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004629;
	b=hzzcB3Kr2Ms3nJvhnjchkROCGWLfZB5oHxDFAgsjfqEycAY2Tgxe7JLbrKKijRND2yLJ
	 gkCcRdn5nuKoQK5TwPsDhnM3iDvpPb/zO0kxolmg/uc+xfxw1F3wMeGCfC1JpgZawjnJg
	 YRoruwhucmqAUlqsmFknL84IgrIjAOQFIgrMq8doi/5QTFqEu+fxSF9KyZ87T1Ou00ogR
	 TQhfLwd6afk+9BTb3zCSY4oUmjLYOjsKORhpTmDPMA2+Pfy3nTWvAhcHvHdsdfU/NFSCY
	 pOpFB10yx3A0gCNW2AUaVEQwaTmoZTfmWAWM8D5DhwV5y9gQu1VFiOBMn4sGUmw4rWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004629;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ioYZSbScc9PKASHqZeWIO1+8CpY/nx6dRgug1LdGp2U=;
	b=FCjgbX/8M/RFOENhk9xyNKiRTbtw0OT3n00lJ/JN5xCVlztD0iFi/0lT+RSUhtff5BAw
	 wdnc1NN6nyoKwxOeqmCeA9890EDhYGCOP0xr4Tt39jjs8p0FGPPT7PAEnIM3wWlqEz1Hf
	 HGH/V5zId5wjnjCBUw7KWhYVWL+52qbv7WDybpufu8kwg4rDJ86ZfuXMyBFEsG8hSDVMh
	 5mkCjme356byD4K6NQ76L4u658vMh0X7bEZYuGgxfXtWceFzynIM6/fKUH6zcw42G4V2V
	 UfQNdshjXd6dEbS/h/bCvUYHE9UMurKmdWFreGaJSIbririYZRPof+7AcV9hqOhBDyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcKl1Nm2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF4606A328
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcKl1Nm2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D61F01829;
	Mon, 26 Oct 2026 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004628;
	bh=ioYZSbScc9PKASHqZeWIO1+8CpY/nx6dRgug1LdGp2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcKl1Nm2Ao8mAVrkAfXq6iiQHskwk50nEJ4PBvf1CRhYbGJouMxJVl3Lv9Zh/v30T
	 Anu/cXarDyU5MNA3vjEJN4y0WdGIcewvuPElI+S9pJK83PXsR3CnSjpGC4GXDhSAfy
	 o+eqF9isPjVRge1+8+0dX2DPTbkNO/TBgdf543JItSZ+bU68rvqlSlq45Sy/sMX9gM
	 Mj5DW9nSex+7oZj/wEG5K3cTfiOsKO8bwfKGYlTkNv7LQl/y4hN8zCEB83vL4haKPN
	 3yKmvavoQu/0nVrep/C0YqDDsngjtTVtkeGhFUzVC/dr/jytWRsvhEzxRGV0x4y8kq
	 FIlixA0fMTk8A==
Message-ID: <sashiko-outbox-184698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 6/6] tun: add rx timestamp to the vnet header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Trumtrar" <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-6-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-6-008af03cd43b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:50:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Reference implementation of the device side of VIRTIO_NET_F_RX_TSTAMP: if
> the configured vnet_hdr_sz covers the tstamp field, write the current
> TAI time into the header when a packet is handed to userspace or vhost.
> __tun_vnet_hdr_put() now takes the full struct virtio_net_common_hdr
> and copies as much of it as vnet_hdr_sz holds.
>=20
> This is not intended to be merged. A full test needs a QEMU that knows
> the feature and sets the matching vnet_hdr_sz in
> virtio_net_set_mrg_rx_bufs(); see
> https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps
>=20
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-v6-7-topic=
-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de?part=3D6

