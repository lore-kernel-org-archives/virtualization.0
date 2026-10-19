Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9E57F1D9
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420171; cv=none; b=iCBpr6z7rsJdt+TkxE+7iShJIgzF7SbAZJopkpBCOSmaAhM9arUaVqQ98oEEfyuz/BLHoMOHUHXRO7nBgGWLo9FeVba+C2CzPWKRIKaeBVmm46jE6lMm57gZFa/7JYKd1Dhm2Nf/c3QgV7HqEeN43exGMeKv8pS9aTieWyfR58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420171; c=relaxed/simple;
	bh=i53zQxqpKmyQ1yBuSDROQO/FWWWnQzbbqby0nxLUc0s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ppxikt4CAcEKW0LZLt672Sx/2ueyicC5Y0i2jbfgYoKmweR4+h9h6zRrbN/V+EGONnjFJflG9E7Un8Cpi2q9aAZi2+As0xtozQ7WGBOc4I8Gq0LAF6AMicmMDyp8wFtME5Yb0WTCZt+z7wpadvYYATwfILclshy9AeW27Rqs8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3E+aDxF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3E+aDxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F291F000C4;
	Mon, 19 Oct 2026 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420170;
	bh=0x//DFvZeDsP8//MRYZQo4Rfj4AUi6xz1a6RNO+VZWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3E+aDxF3RQEQtiGlQF9r8M9MlOsA7jirZvX4GmxT0eZHPfEBqsUpRip3ymgmVOJc
	 6e0xKu/WDLAqQnGxQu4jcCqRrhu4AJdNfjTd4LYoIYVxATW4pKaCfI6PjNdfzw5xAs
	 uLYVzKr5tpW37SiL2FHviqE5EUWoj7g0vQm0KD0sdFh3NHBRQE+FRiALZ/AfMpZXj0
	 VTiY4LRHdqY6WDdJYBhgLLP/p5OIeO4JFz+vlmWZuxFRuzolHSK1v8zUeGb4MxvEEc
	 9QlK7ghbe9BDUr5Dr83CiMUSpeVDD/55OXOI9jUcq4YC9mm0DM57bjWconY+1/xMgA
	 aoGtz9yHEkG7w==
Message-ID: <sashiko-outbox-177401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] vdpa_sim: hold iommu_lock across
 dma_unmap passthrough transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-159-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-159-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:29:29 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Xiong Weimin <xiongweimin@kylinos.cn>
>=20
> [ Upstream commit 7b411448c668bfab0d0e572cee5a592cea396ce7 ]
>=20
> vdpasim_dma_map() updates the IOTLB and the passthrough (iommu_pt)
> state under iommu_lock.  vdpasim_dma_unmap() clears iommu_pt and
> resets the IOTLB before taking iommu_lock, then deletes the mapping
> while holding the lock.
>=20
> A concurrent dma_map(), dma_unmap(), or reset path that also touches
> the same address space can therefore observe or modify the IOTLB and
> iommu_pt state without consistent locking.
>=20
> Perform the passthrough transition and range deletion under the same
> iommu_lock scope, matching dma_map().
>=20
> Tested-on: openEuler VM (6.16.8, /usr/src/linux-6.16.8)
> Tested-by: Xiong Weimin <xiongweimin@kylinos.cn>
>=20
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <20260626020545.607600-3-15927021679@163.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-159-sashal@kernel.org?part=3D1

