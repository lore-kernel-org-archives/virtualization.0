Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250133;
	b=Xy2bXFkR6Nq7AV0rJLPrpKrCzIOLa/01KsvgSt15A+pkSYkY6jBMhxDJlth+VSWABOdo
	 ExHXUk37ItCO4J7zqqdzV4lDTRyOK3oqiuDv/P2+AijNqS1D0paXx2wW9hRJCrmyp2NaG
	 cS5lvin2uqiYis84DPaqKJINDcmkjSEtZ7VQjznGaVUqcpjYpJO+MgNv48KiPNG44Tu9x
	 PjvzcsiIPrtEAxJaquqw9XQhipG0sqnej6/j1+ijRBvInl+mKOuFGfZFU0sr5HTPD8Kp7
	 LmMtyMuEa02SxD9m920y7SgKQ/0hljIZuCbrS9LvlaWNtvk5X939p+LEN50gYAGyCTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250133;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iTJg2YCjC51OJ3EPD4rFVoz/yZJ6J2PaGNMU8OYKbts=;
	b=VVImGcGGNTZNO7gwQJsCnO3ZO/SigVHrIv8Orn5pQENYNISuxLM7FSp7vgTI8Q4TUdlk
	 Wbz594kRkaadOaXl8TCa08OZ7WeeXbOMjCWztIYRqqKFDplDf0oRoTLT2ShrC9GYsBIqZ
	 vd07MPGFSEOK737/br6u2G75Ppb4LTWHw4GrHZ/kKOdxvO8Hfi9eEyXdoVHjmm8z6AIi+
	 Ad649hovXkDHAs9weizHpahPijOs1rcKL/1q55FwRcMXemcLeDNrmJyt9QxzjtLzIXDoJ
	 iMFuMJUdlDk8jMeZ/VvsTVMS0DhKYdtd6BcmIydsmjfO59VjA2urfMUE9VedTzAuo9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StBcI0sj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD9606A326
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StBcI0sj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC551F0089F;
	Mon,  9 Nov 2026 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794250132;
	bh=iTJg2YCjC51OJ3EPD4rFVoz/yZJ6J2PaGNMU8OYKbts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=StBcI0sjFy0YCJGDWYGBqkfcwbkAfHLpKFOlXqyLzoHsHhUnRuk6FHX82m0gP9s/+
	 Al1Gy1adbseV8hjKAWJ28kOmGjaM2jy119nF1Dcotk3kr7YCQi/FW/9ST06hEO7OHT
	 RDsxJQV4k/Z1zphurrU/Og6ac8xTYMsCx3s3UFDq7/WcLd4PJ59eT4x5wEO1Mm6u4O
	 zrzsdZQkvCzfmO78VASqX1efmDw6Lh/tXI6ja/pNPswIW986MG5MsKNPfWgBuNSYgi
	 9G9wHJXXCBZ3+hjAxc4lImkwWb8LaDtrHxuo2+IX6aUAZegYPGONtVAN81ZWU2IedZ
	 l5LEfoxUyWdIg==
Message-ID: <sashiko-outbox-205441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit
 DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vlad Poenaru" <vlad.wing@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109184253.531677-1-vlad.wing@gmail.com>
References: <20261109184253.531677-1-vlad.wing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:48:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The virtio-net function of the AMD Pensando DSC2-200 (Elba) DPU, as
> shipped by Oracle (1af4:1041, subsystem 108e:1200), cannot DMA to
> arbitrary 64-bit bus addresses, and Oracle advises limiting it to 48
> bits. virtio_pci gives it a 64-bit mask, so its virtqueues stop
> completing requests once the IOMMU starts handing it IOVAs above 2^48.
> The card is used in OCI bare-metal shapes such as BM.Standard.E6.288.
>=20
> On those AMD EPYC 9005 hosts the AMD IOMMU supports a 6-level v1 page
> table (EFR[HATS] =3D 2), so the aperture spans all 64 bits and the IOVA
> allocator, which works down from min(mask, aperture), returns addresses
> just below 2^64:
>=20
>  - With iommu.forcedac=3D1, the first control virtqueue command never
>    completes and virtio_net hangs in probe.
>=20
> [ ... ]
>=20
> Cc: stable@vger.kernel.org # 6.5+
> Co-developed-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Kyle McMartin <jkkm@meta.com>
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109184253.5316=
77-1-vlad.wing@gmail.com?part=3D1

