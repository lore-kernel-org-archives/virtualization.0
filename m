Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694217;
	b=HqsAOyAh3JMUzuXmIKxgOVHNWwTuQjPVcZgQ06qAfYUAPsO4dNwnHUCvCEnMMTMLZSTk
	 e/E1ZzjqX49K3at4nep6CSjKaBFsWNoYhE+rOujyoWFqacIWdGIDHiagElO08PLAHNIJW
	 Feoscj5Ue+7BfCsbr7Tz3w3XMw+Eamw6js0IZvkjkBWagVFeIB5R/lLKmKFhzMqYYNapl
	 2M38/K7MjWkSe9nhetCnHsC3aKwVGg0AhHhIxAMikBwPp0mxIhDp38HkEcCx9zznZnHQA
	 W/1l4FwbIIWsEoO1MfHgO5QYxyOY53zC9PRyhwfMN2ICZIl4WG5mQYbiuuABZWEZprg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=imPNzyruwpVy9hRQKwmsa3oQD53cJcVk2x05+NDIy3U=;
	b=Ix1uhypHxnnsHp6lcDOWjC81AAUpj9cfp6O9sz1oloeUElboLPupVzd9yxvxxROVTgH/
	 b8i9AxMSPzbniMMpE0NYe4H3xOtR5334WBe/zRs5Uq7xZ0DnFOjpW6cTv3RTMDw2OP9eQ
	 TRwT9yLHBSiNR55DrPrSqBBNLJlbaYB0JXZT7+GzmfNPSyBbMm01rXtFQMMNHjhhaGD3s
	 E/bwWUbo76Zi67QDHbCagf1zdCEMuiFptHd5uHDvOdmH4nxCyh0DDgRFgSgxBlvFLADbZ
	 r6ikcS6v0rFVMrneZPKsejg9h9cBQR09Uj0Bm+sEYWX0+T2Z5w9l+0mhlcn4h1W7xZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3nR5VOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9460A6F56
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3nR5VOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8D41F01186;
	Thu, 22 Oct 2026 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694217;
	bh=imPNzyruwpVy9hRQKwmsa3oQD53cJcVk2x05+NDIy3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m3nR5VOI02ShD076hiJ4PAceGs/+6Bf+UeMEheyVsOIChvHbyqZgp65S8fV5HsrWP
	 ZyA78XsNUL1Anj168a2B2pjWJzLmwqFSA/ZB/WCjDrIaz7ft+XNBpSbW9xNTmeL1V/
	 Lw5t8Qr3AbWxyqT9B7LIafMYln1ipEeS/JO/w5V/wRRGJCSg3Kuu1b8r1RWiFnkRkW
	 zgLUK3ZzdE95r6dOcB8wnvTyju3PtRyLZIehpIy8DPQGlEjNtNLoOFuaH/oa3dVoFy
	 52pr/NRbHbgy/EzpYwIq+CjTzkOZ2VsvFkJWECaSMDHtbT5K/XoqKJEaOHP2wgf06u
	 qC508xTbMoJXg==
Message-ID: <sashiko-outbox-181930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lianjie Wang" <karin0.zst@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261022182710.2055771-1-karin0.zst@gmail.com>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:36:56 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> __virtnet_get_hw_stats() passes the vq_index of each record in the
> device's statistics reply to virtnet_fill_stats() without checking it,
> so the device decides where the driver writes the counters.
>=20
> For ethtool -S, virtnet_fill_stats() uses vq_index as an offset into the
> output array, which the ethtool core sized for curr_queue_pairs. A
> record with the vq_index of a higher queue makes the driver write past
> the end of the array.
>=20
> For the per-queue netlink stats, the queue type also comes from
> vq_index. A receive record in reply to a request for a transmit queue
> makes the driver fill the struct netdev_queue_stats_tx on the stack as
> if it were a struct netdev_queue_stats_rx. If the device offers
> VIRTIO_NET_STATS_TYPE_RX_SPEED, this writes one counter to the eight
> bytes after the tx struct.
> [ ... ]
>=20
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Fixes: d888f04c09bb ("virtio-net: support queue stat")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <karin0.zst@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182710.2055=
771-1-karin0.zst@gmail.com?part=3D1

