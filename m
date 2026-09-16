Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58851992E;
	Wed, 16 Sep 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596061; cv=none; b=tocJm/KhhoOBFK5gDeirI1pluxDU7RzLIiQya5vjAmdORYygUVpqwcaSWIIBdot8uCMDvvTukIBtW06x74/GuFh7kFzoZZFkK55n5sMzOE2QrLzieRTP3QRSsE51CUqPX5a9VMQfY7pogaC2HaZTU+tdvAXUTzGZThvCB5tImK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596061; c=relaxed/simple;
	bh=7/ELyZ/rqVuW87CRHaEGvoi6cNA4oV1gq5fOlZadBPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcoNIHksDYgtiahmgC1++dWZYsynUIcRi66KFcEGa0TFqa/SUQwHF9rutppidmgDCHVZuHhFgPY+CyO4ra44FC3GOsSd4smDBzrQpU2B2zGGVPZJ4LKDxyI+iP+cgPHjBTeqBkltkmalTK3w0QzuS7KuJ+0lLrUGti9jqdXFZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+4F/iEK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+4F/iEK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1411F00899;
	Wed, 16 Sep 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596038;
	bh=Zd5ILNFZM9D91G4R7kCKSKdxUur1/Nzf61Jqb4Y9MOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+4F/iEKrQyI/qpPSsRXpdde+0mwLofZm3w6d09EF64qLS353sGOs+ABdf4aCcVLs
	 djPx/6q5toYBoYn9QjhMqgfZMy9WZNuobF/7tdp9ANkml0pSyJbNgxgDTBzd44luXL
	 j2+dTX8igGSicaB+oBvGnNS6NfgKSNuebLHhr6wj8jZEvh6GafCyGzburPmV03Twd/
	 JVK3Qa8+nPDGKZ+Hibe/UbpSivBIuj/69zhr4xxp4AzJs5sfsA3cBfRCVFkPwoghuU
	 VaFveWlJXrZqklVY36yKrZUb0gJZI2GesYHjD8kvExRrSH04bE7Mtp5+/JfB48wzh6
	 Kku0pDGdLv1aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/12] remoteproc: always report VIRTIO_F_VERSION_1
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, robh@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, conor+dt@kernel.org
In-Reply-To: <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:00:37 +0000
Message-Id: <20260916220037.DE1411F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] remoteproc: host-firmware protocol mismatch by forcing VIRTIO_F_VE=
RSION_1
--

commit 425d88ad507f29f8586fd7c8c447cf1bcdba6678
Author: Francesco Valla <francesco@valla.it>

remoteproc: always report VIRTIO_F_VERSION_1 feature

There is currently no way to report the VIRTIO_F_VERSION_1 using the
resource table alone, as the per-vdev feature array is limited to 32
bits.

> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/=
remoteproc_virtio.c
> index 74e0da970f1d8..cfd66d9d1c9e5 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -249,7 +249,7 @@ static u64 rproc_virtio_get_features(struct virtio_de=
vice *vdev)
> =20
>  	rsc =3D (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
> =20
> -	return rsc->dfeatures;
> +	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);

[Severity: High]
Will this forcefully advertise Virtio 1.0 support to the host virtio
core, misleading it into Modern mode?

By injecting VIRTIO_F_VERSION_1 into rsc->dfeatures, the host virtio core
will preserve the feature since it is a transport feature. This configures
virtio_ring as strict Little-Endian and assumes Modern struct layouts.

[ ... ]

> @@ -275,14 +275,16 @@ static int rproc_virtio_finalize_features(struct vi=
rtio_device *vdev)
>  	/* Give virtio_rproc a chance to accept features. */
>  	rproc_transport_features(vdev);
> =20
> -	/* Make sure we don't have any features > 32 bits! */
> -	BUG_ON((u32)vdev->features !=3D vdev->features);
> +	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSI=
ON_1 */
> +	if (WARN_ON_ONCE((u32)vdev->features !=3D
> +			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> +		return -1;
> =20
>  	/*
>  	 * Remember the finalized features of our vdev, and provide it
>  	 * to the remote processor once it is powered on.
>  	 */
> -	rsc->gfeatures =3D vdev->features;
> +	rsc->gfeatures =3D vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);

[Severity: High]
Does hiding the VIRTIO_F_VERSION_1 feature from the remote firmware
guarantee a feature mismatch between the host and device?

Since rproc_virtio_finalize_features() masks the bit out before passing
the negotiated features back to the firmware, the firmware remains unaware
and operates in Legacy mode using guest-native endianness and Legacy struct
sizes.

Could this lead to dropped messages or crashes due to differing endianness
assumptions, particularly on Big-Endian hosts where vring formatting will
break?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D5
