Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985935;
	b=UeIpGir0KS9FWvTwLso3t5XQ9R3PPqlnPJqOmtwIicCHW7LxsbVUPMPpHDShkD/RkoAp
	 0t5jQx+YjDJLqme/xor/gj3b7kK7BTM7VJdov57NMDr2WJ4wsWFWn2p+E5gw6dDgaQl5V
	 atoqmHPxtjEq2QlwfhOdG0gDcBfwy1EmOCA/jo+hzmH500GNnbQv8Q9E9pTazdoFR88cZ
	 0BWAlkRRvLpyMhtrNzGF5C4nNahhUBGtx6pwnLJoIeIOfB0gdFtb8wYAoo9Iw9irE0q8T
	 OX6+/0mL2RNW4OnACxo5PJSBbkRKP4eQzZkTqQBxyroP0gZRx//geUuC694LjTFRgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AaJ5QneA3JYb70jzVK58WxfLxuqYwolxEGNF1Pho2z4=;
	b=phzoKym3p3/cvM+LNp9t5+Y8c1Rj06idz071riE+1w5SnuC4coAwFQfb7MqFGc4h72/l
	 eoAsS2iz5sQyTw1kWOjmBbm7c3d/yiZi4PBWPJ/42Egl2tWUXNLSZ1/Y50MmsCbmA9hfP
	 eoM+H3bMVhlgG+7ImBcTqMnHFSczDFi2zW71HqOWZXBHPS3KNGbB2GtjH4KBwdgnhRsA6
	 eHLiPQCuQHOnNlCmp8t10+jFLq11DjOmH4MciPwrFe1FxlzxrdCyiSnh+OSkGhWTVgCBT
	 dYvGDaddJBNMeRp3mHRzWwciFk7p8xHlEN/ukHzJuq/qp6aPBFiLVQNcfJ2OwVIvZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xh0u3L93;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1163606A32E
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xh0u3L93
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508AE1F0089F;
	Fri,  6 Nov 2026 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985935;
	bh=AaJ5QneA3JYb70jzVK58WxfLxuqYwolxEGNF1Pho2z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xh0u3L93pnDipofPuQNuuzFckMzlt1YFzJp0UMAaSwaeNYPoz7adiVp/6GbY/R9Mu
	 Yu+EhYIWBdqk0koNWzIf61FmOJTPB6C5QBP3m7/3/3WTArXbAcsBQnMlm+ErB4ygdd
	 bxEv77Gd60lMYtwO0Zk3fAuHKGh9afXM2QFRhwYGY5xlQ/lU6gnOTdKs8c1qiCDFuK
	 5yByUCEPfQNLlrN963Ttv+6Mepl8qMmTu8oM0BZUPMfMl+0aOE+eilQoZQaKD0Z09v
	 FNj5jmTcr2tGsW0FvmOYov7UnjmDr0ViF6ZTM+GrUHlfQFnWMfRj5anSCk5+JXisA3
	 gDYGqbM1Ntt1w==
Message-ID: <sashiko-outbox-201920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:25:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The "iommu-addresses" property describes an identity 1:1 mapping between
> an IOVA range and the physical memory specified by "reg" in the same
> reserved-memory node. Without "reg", there is no physical memory to map.
>=20
> The DT schema now requires "reg" whenever "iommu-addresses" is present.
> Align the kernel implementation with this requirement.
> https://github.com/devicetree-org/dt-schema/pull/207
>=20
> An identity mapping requires matching IOVA and "reg" ranges. Reject
> mismatched ranges and report an error.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-add_iommu_=
ranges-v7-0-5c0f72083e52@oss.qualcomm.com?part=3D4

