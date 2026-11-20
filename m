Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171554;
	b=w3KwldAoYlbpawt4tuIvJUtgz8iC7XDeVg4Ob1ADVtF0GgzMxdI/PECD5xXcgtInr8aJ
	 f4DHMIFmjEqo24vYnK6HEODUPQtxi7J5QMhtnKwTVu+s1t73hxZZieZU2WN/0rkCqnQqq
	 WDzS/He2/sFP46KFOreGMNoeCbNaapPaJKXRcKoUQsAGx4nQY+xoYGyCtSjZeobzhI/+4
	 2I+r1Nxim7p7Ea7GTTd4BinYij8a3EK0J/TcipSj7aWXTrtpXJiAbH0FqkZvPpaTHRM3h
	 jfAnCWEm9qcVToZm+xd8RHJ3qRBYp8r92KPDpTeoOHuI6RkFDeQC6IFJDGTKX4VCgzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jBBriqUs2x6FmGLFnMUUetykHj+R/KTOzWVOMYrRds8=;
	b=rOtUiwo3C0UsSOxP9VGP39TURdREOOaqD8it+GHwQugKSVF934kaEGxEHx8NDRzDQJgd
	 z9Ma1A3/GARwroME+Qppp0sDFHL1S6wIpIK/TExpX/VaH5YzPnxQhdywVrqsguFrnqtI1
	 spgpHndyidYTc1uxwuKkQqS/qdyAe6+OmiS6DCSTCWvsU30wn9P0WirkZayjt0vWn2PMe
	 v/2xDvA8u3mlE23QjbHQVlCs+Xvtm9jWDu/D1ScXC+/ugju2vRvi5D+sxmBurWp6DXhQw
	 RkQprMCYGGN+0jMUVcLeV5angXcwA93N2aeEWW0dbYeKb9AyJub2m8NoeuEmZKVqe6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhFnr5r+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246A60A261A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhFnr5r+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512291F00AD3;
	Fri, 20 Nov 2026 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171553;
	bh=jBBriqUs2x6FmGLFnMUUetykHj+R/KTOzWVOMYrRds8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhFnr5r+MsTEedav5ZPUiG7KXOE9e2mIvVyEJeA4ZzND/bua40fRVllxx+JRDSv/d
	 0a+86eOtcS1PclUE1I54PBLN42khk3g4UZY7sS0Cs8pniw2nNukE6/8JuzLU2AcEn7
	 zcmIa6iMiiuQqzr0t1egf+vZgtnmySaZjCXbUxEFL9fRJo0ALhwsZri/gqL55dcU80
	 kH5WiIsVLnViOKG8CxeVHFNOaFa3Bm/m6up7SfGK5VJz8M6XEVMn9PLPKoAUlhkK33
	 uKrHJtGU0kxD4K40QrIiA3tnWZwMhxp1k+7kjD4ZnDzU1rKo7c/20p51Dh6JBO1eup
	 yCTi+OwSxiq/Q==
Message-ID: <sashiko-outbox-224954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] iommu: Use resource_size_t for reserved region
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikash Garodia" <vikash.garodia@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-2-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
 <20261120-add_iommu_ranges-v8-2-d90486973b73@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 10:45:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
> region can be larger than 4GiB, but its length is stored as size_t,
> which is only 32-bit there. The length gets truncated.
> Use resource_size_t for the length so it matches the width of
> phys_addr_t and holds the full size of the region.
>=20
> Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@=
oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-add_iommu_=
ranges-v8-0-d90486973b73@oss.qualcomm.com?part=3D2

