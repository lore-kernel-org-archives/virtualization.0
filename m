Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185998;
	b=BZRsPhOJs2keuNX5tHW6aAJJRcCQMsBFCu0ZFBsCyzEZID44DimkmJguO2ul7EwjQIpk
	 w82PE5a5TEs7F0x03/OT6j+4KE29kwtbMnsFWdKHZdkDA2IKY16FNbC09sc0t+XQzNYrb
	 xkGDoJP0+0q2kF3bZOw6jh+XV2q+t69F3MxQAjWfRSzd5d7ns22hNmxiqydZw7rLddeS2
	 mc1NHu6lwUORDtVu8nWt88QtO0SNCYTQHRPfWbhhy8YYUado7rdxYqUroS6s3sUMJ64+B
	 SZV3WREi8whbu2Jh20ZrsY58G9m9Y5pOaZKwa8+tEhTzl7K3f1JWBQfP4rr/bKJdvAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Dd9tsnDaKr+OfILD8hcNK0Px3VqNIAE/+46JY/6x8I=;
	b=4Z67ScfL4CeicIqhYd9/QDuSslKZuxA5UZkYz+LZ/V5oRUJKPufdKtShM6vFJ8pk/ZYJ
	 +MDOS5ZVRFaJ9M4QDj0f78HsWarjW+VL9HN1jZBLxWr3il9+JZXtLJm2RMc2B5S2arpBX
	 2cIn7Pu3xEchaL6dcH2oc4EeP7S6j1gXjKEQdmyHWV+DYTvelAszWMyF7gaRlVJvveDFt
	 cbiH/IRKEkRiqx6Lji0ScGOjsJu4+9Y5k8Pohd0tVYEQJyzqiZXA5wsPe8JUv6jwV4evl
	 Xspkbodhh7Mg8mS9lBLNiXBrBUrbV5Dsv8FY0X4eDrwYXwe3m+ZhKz8X9DXCITeKe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q6sQGXJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B5606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6sQGXJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78531F000C6;
	Fri, 20 Nov 2026 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185998;
	bh=+Dd9tsnDaKr+OfILD8hcNK0Px3VqNIAE/+46JY/6x8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6sQGXJ/A0aiy9wDblTvysZpw1nuetQKQk80+gIv+K1pwIGpofePgZueymami58aX
	 3fG4R4jtfwju34fl3F6eS79fdbQ9LpgMolL739vlNg/2G19/6UqfP2lNYjLGOSGKia
	 ovoCL+f0ZSUTlVtJ2vFhztHcgXCTATJzE2lM7H+A9+3pcDEgtnl/0aQe2icCgcOat0
	 TixqzBB6e+SfuOEi8jFX0woeGBTm/3a7iPFDdW58W38foIVyz97txr5+78jBeImHoy
	 DJ1JQ/Np4YlJxAtjxu4JB0fS4Iyps1QyXVcyqe9G6JZyx55xz+onAMi60nyQGMTSqB
	 3z6THUnBDUj9g==
Message-ID: <sashiko-outbox-225408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] virtio_net: check RX buffer length before DMA
 sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Petrzhikovskii" <vladimir@dfb.sh>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120143953.1560229-1-vladimir@dfb.sh>
References: <20261120143953.1560229-1-vladimir@dfb.sh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:46:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> [ Upstream commit 29dfa436bc488056a84ee423ba82336db453e2a6 ]
>=20
> An RX queue that uses the DMA API (rq->use_page_pool_dma, for example
> with VIRTIO_F_ACCESS_PLATFORM) syncs each received buffer with
> page_pool_dma_sync_for_cpu() using the length the device wrote to the
> used ring, and checks that length against the posted buffer only after
> the sync.
>=20
> With SWIOTLB bouncing (swiotlb=3Dforce, or a confidential-computing
> guest), the sync copies from the shared bounce buffer into the guest's
> private page, so an oversized length also copies the bytes the device
> wrote past the posted buffer over the neighbouring page pool fragments.
> The later check drops the packet, but the copy has already happened. A
> malicious device, such as a host the confidential guest does not
> trust, can overwrite guest kernel memory next to an RX buffer with
> [ ... ]
>   with the reproducer described above: without this patch the marker
>   reaches the guest page for small and mergeable buffers; with it the
>   sync stops at the posted length and the packets are counted in
>   rx_length_errors. ]
> Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120143953.1560=
229-1-vladimir@dfb.sh?part=3D1

