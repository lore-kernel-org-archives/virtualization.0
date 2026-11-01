Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552414;
	b=2sqvAQW5gvNUvV/dPRCY/IN+tJvB4m8+LJ2rIAgZ+EePpUhBUDPmX6luQOR9vCo/fSnt
	 9QJ5qT5FVl9ji75RXrvpFlkj60h//bYvqOTMij7e4EHHx0waB0W4PBTazDrFjklNvhNKC
	 0PmZNfOHK9VceJS+KRVggXIBRdq6Df81d6it5ttlYW6g5jodsYN7qjE1PPXluAWDor2fy
	 DwSVuPIxuYSQd3Zg2x/bwUPcyqM7KhUf3wk1HSWycKqaJqT3QwV74mHvS1XsYq1ZWmQyd
	 jin1rN/6ueQL0VEvkLFwhie4t6h4p6BqBC6hia/zXr0K5gIApsncFaRuHwIKXGasgHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552414;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X7FsGPBngEV3YpYG/HLXXDRPYysMgMNbjXbZcWLQpOg=;
	b=rKkL6pidsC6cN7ySr+2Lz5vmfgnuDVN21Jv29a4dD70eAza+2YBwsi5CRfUnC0potDn0
	 4FwPV0hyIO9gwxNFmmhuipdpELIqb7dG5b44lvuEmTdleq/Qi0ewT+1pc6t3i/0JKX2gv
	 xWPBK+O1S8kXxK4CZdxT/oh6fs+mpuYi8Ai+fbseTUYrrCEJ6X4YbPff1F6gy7EeOsM1D
	 Ra6Y7ByCJPqNn4iYIgSxjZWb4sQdmfnLAVY1TgpLfsfJo6oMXNDYg4C4npptQjCGGvQaN
	 0IO5PI1QgIepTwbbBfarKzlXnOhcX2Qh/bCaQaGnMzQJIQ3sgg2WCJj4X1qlmE8OCyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5ieD+pW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DB606A324
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5ieD+pW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F031F000C1;
	Sun,  1 Nov 2026 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793552414;
	bh=X7FsGPBngEV3YpYG/HLXXDRPYysMgMNbjXbZcWLQpOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5ieD+pWxAS+Tc4/K8OYBJRtu2M3zxHvDe14OCQ6mQvMCsXhI1hLSQAeagfs53ZCJ
	 781BYlNDbxXVhtqZcSzil30Je1PA+L8w7fQHfii9LV51/jN9p/n0Me2HpIeid+cbMN
	 PkeueuLfqVlb/H0/ai0fyCrREaQp6IA5yab5Pxfpb0g1PNfehPHwFgaitbsiI+7Z65
	 RKZscngnMm4AMSU7QaREIIalAsdFPJcEjcczUjcwYiySa6UyyRcZACVrd+0c7Oep3t
	 UWVYq2c6VkLE7f2PId5xx7Mxz0Oc9UCb5HNAkexLj5GqlR5IhGb1dJUXQR2/L9CxAg
	 chaePI0mo1ZQg==
Message-ID: <sashiko-outbox-192517@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] virtio_blk: fail the probe when a virtqueue is too
 small for a request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stjepan Poljak" <stjepan.poljak@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261101165307.2557421-2-stjepan.poljak@gmail.com>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
 <20261101165307.2557421-2-stjepan.poljak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:00:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Without VIRTIO_RING_F_INDIRECT_DESC a request takes at least three ring
> descriptors: the header, one segment and the status. Nothing checks
> that the virtqueues hold that many, and a smaller one fails in a way
> that depends on the queue depth. With the default depth, num_free / 2,
> a virtqueue of one descriptor gives a depth of 0, which
> blk_mq_alloc_tag_set() refuses, and the probe fails without saying why:
>=20
>   virtio_blk virtio0: probe with driver virtio_blk failed with error -22
>=20
> With a depth of at least one, from a virtqueue of two or from
> virtio_blk.queue_depth, the probe succeeds and the first request never
> fits: virtqueue_add_split() warns and returns -ENOSPC, and the hardware
> queue is stopped to wait for descriptors that even an empty ring does
> not have.
>=20
> Check the virtqueue sizes right after the virtqueues are set up, before
> the queue depth is derived from them, and fail the probe with a reason
> when the smallest one cannot hold a request:
>=20
>   virtio_blk virtio0: virtqueue size 1 is too small for a request
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101165307.2557=
421-1-stjepan.poljak@gmail.com?part=3D1

