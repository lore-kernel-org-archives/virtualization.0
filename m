Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224373;
	b=KZtZI4DOdBXjC1k55IhtPGywTQwA24d+Lt25ALrqhxJj3JXp75g7Gojwp87AjuIiHpX/
	 jZQe/rDECia3lU/7NL5XY214DeLKS+cyGp4hN5ZrCt9eq35ZWLDzS9/pKD5zyIaChJ1Wz
	 qgzSsDKphR7yChk5fU3YN4jHD8vlKZu9+K/XDNyMy7DhVyhTQw1z3uTIbdJPPwThDFAXl
	 3OXSlAuYIW+0V5Bcsyp4SXd4O8rl04dTj+aHa2Dl5pZkzz5C+X9de+E82sBiYmERTP6of
	 Lo4mTFSmTZcH//QIhurJpyWbU4PTob9UvQx/Htn3EkBbS7eyE2vIh8GgoLbKC1MtDOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0zosl/VrG7OQ16Iq/QF/9aJqs8MJURfCv1LXwxO/TDs=;
	b=GDF3rVHMxLtwXZu7T9v6k9xtV56i37oNJ8Jsl/d6LOX4zU51ALOMFEfZzVQW/nNN2tE5
	 idiUDWdL6X+r1RcwBZBN+fuXUpUF6t8qVjIkwI2XsvaiJsaeAsKPfUkLMUvNu492EEi+3
	 2C0/8wXk4FZ7Gy+jaTr7NUz4c0gfTK/R79F5rSA3KdHZlZP1UzYMuhj4iP8gSs8WzW/Jp
	 32CujwuG0PkjhyAr/N6DF/YTknqDn9sF00iQoP4hJAz7tcQhOcwj5pZOkS5BI7yxx/WXK
	 jOmxlxQaYDB7BYqde6sZj9LgL79kC5cy0y92easOkdzlzq9v0R99PzIF2qoDveQxPIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYINmXyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6573606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYINmXyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8219F1F0089F;
	Mon,  9 Nov 2026 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224372;
	bh=0zosl/VrG7OQ16Iq/QF/9aJqs8MJURfCv1LXwxO/TDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYINmXyu1iwCYFFqEnZaQhacQLxbVAdL7R8O3tL2yE87ltix9onRxhyfuXdRaWcIT
	 ggtoUJVLEgn70ktTtq4Wvc9O4b2t4o5t0b1ShDka7eXdNHvhMkDpwHkverAHHyzjqe
	 T9uD1AQHmkrksLwiOC1miATVb1meF9Nz0OZIo7txpVS1tiXMnHJ4nfxgH6ZVEdub8v
	 Rmb79pkaR7rzbnaORgc2yYc9Bt5h29vzsR49hU66B22WssOMvZ/wp8xwtBMKcFdNdM
	 xkDkr+JNJq/7yZdBH2WX82mEIq1UNWP0KhsjltGttCQ8zp48049uzdR8JLasNNk2Tl
	 WFfvfiCeiaYww==
Message-ID: <sashiko-outbox-204883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/3] virtio_net: Don't DMA map the kernel image
 for the AF_XDP TX header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108193845.73621-2-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
 <20261108193845.73621-2-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:39:32 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtnet_xsk_pool_enable() DMA maps the static xsk_hdr, which lives in
> the kernel image. On arm64 the kernel image is mapped in the vmalloc
> area, so when the device uses the DMA API the mapping is rejected:
>=20
>   virtio_net virtio0: rejecting DMA map of vmalloc memory
>   WARNING: drivers/virtio/virtio_ring.c:3882 ...
>=20
> and binding an AF_XDP zero-copy socket fails with -ENOMEM.
>=20
> Allocate the all-zero header per send queue when the pool is enabled
> and free it when it is disabled.
>=20
> This was found while testing AF_XDP in QEMU on arm64, not in
> production. Tested in QEMU (TCG, arm64 virt, virtio-net-pci with
> iommu_platform=3Don) with a KASAN kernel: binding an XDP_ZEROCOPY socket
> fails without this patch and succeeds with it.
>=20
> Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108193845.7362=
1-1-yanhaishuang@cmss.chinamobile.com?part=3D1

