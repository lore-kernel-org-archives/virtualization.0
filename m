Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171347;
	b=YqYpoN32htRTjTyTS4PNrKQmTE0DL86fF1+YZylmCu0fGliqieDlucAobcdzS9o9CI/O
	 TGnRrVHl8KNxLnkw+3ZeTB2r1izv+c7vN+piouiLUtJAXgNdCXEldx4grM8tHeIbYtdYx
	 NOhgSmdq9v/FdyHFeTodLK7njHzpQHCvfATRYfirj4Mrb1O25z+VxOU9MO84dWk1p+89R
	 kSXclPtTkzg289U0macp5DoStob7rkgDG9aVkDY75dUTKNtClD76u4VaceG8yKJ3oqQCe
	 Xczh1j+NGyM2bvruaAGvcflzXmPST2ORofW0tB4bxPUyIucDh1zIQu4+zwhpjgy258g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g/swiZzXHZF0fMeAN9l9jg4Q0iJENhSSRVyAd5Och+Q=;
	b=2mjo613rp+JwkoOcyk9DyN863GTCaRT13q48fRrdCwGj44yULB0fZWpRkedoo3WdU0ES
	 N3Vk4QQRFPfdFrIOiB6FXvtxQvtXSuzFX8z0hUVoe2ZRdZaCbcrNKKR6eYMG6vYLqJeDQ
	 5LI0UVt0QDsq87duI+jemecOwmRvOn/v/LBamVZTO5kysPUv1tLo3iEsYRqg2zGhPnwrw
	 +JkCnZ2mW/2SSTCLkoyDhw4BCjS8cOiucMS52cv0ysuQ/1CoSlNL5kEIWV1lhaSINrYsQ
	 0um0f4SLjSZbhQQaXHbXTanO8vw9sOw1LddmVvHmmrnY61xNqcWmm0uVIxyBnAuJeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maHfMZZT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE57606A320
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maHfMZZT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4211F000D1;
	Fri, 20 Nov 2026 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171346;
	bh=g/swiZzXHZF0fMeAN9l9jg4Q0iJENhSSRVyAd5Och+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=maHfMZZTeiTBfHWwbKU9F1y+o4OdAtoVlSpcPi7oqsdWUUyJoPdnVCJDozv3soG1z
	 ird9hso0fPBGM29xU7QN0TYAYdX4H/na5FIWsJovnxrDJPEZ7wMJx+eceYlv/JTSnG
	 0aH0m/nms15GQbhEQcaZuHQ2BLH5vrZ93cCWY/S6PStulB6IaFWa5WziDGEsI4PoVb
	 XNhFCXtb0b7K5j2Fi2nKiADe+N4GZG17eQ8seEqIGf3kLjA/7dZERzK00KpNprUoP5
	 B2atjp+zwtTfuemWjZ7uWXtc83rc8PpPhVOMZcmEO6JT7K2VwtmdTm0ajjKPk0btJN
	 zUUK3taBa971A==
Message-ID: <sashiko-outbox-224951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-3-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
 <20261120-add_iommu_ranges-v8-3-d90486973b73@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:42:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Currently, the OF_IOMMU code is built when OF and IOMMU_API are enabled.
> However, the code also uses OF address parsing helpers, which are only
> available when OF_ADDRESS is enabled. Since this dependency is not
> expressed in Kconfig, when OF_ADDRESS is disabled the code relies on
> CONFIG_OF_ADDRESS guards and a __maybe_unused annotation to avoid
> compilation issues.
>=20
> The only architecture supporting OF without OF_ADDRESS is SPARC, which
> does not use OF_IOMMU. Therefore, make the OF_IOMMU code depend on
> OF_ADDRESS so that it is built only when the required address parsing
> support is available, avoiding the CONFIG_OF_ADDRESS guards and
> __maybe_unused annotation in the code. No functional change is intended.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-add_iommu_=
ranges-v8-0-d90486973b73@oss.qualcomm.com?part=3D3

