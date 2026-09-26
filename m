Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7F391E7B
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790458463; cv=none; b=BbfCQKap11zY9KECxbTueb9aC/Kb1BunSOAk1vxXZWwqIhofNLvfr8lLwokLr7t0IyRrMW5PMO56EaGSMbdng9EgfnSRJdW/fSl25L8itME66u6mSx/J4cag0Ci5vd6zgv/j+S3aGgBIHPfR+v+qbSZMcoznAwYC+Dpq5Bic/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790458463; c=relaxed/simple;
	bh=yPFH+wyO/JZezxvJoGrU6Pr8ftlgrHxqLbLLaMsQeqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dT7vGXLsscM4cSYAKG+4D9sjYqIAth9w7zM1dT/BNvBuSpJiJcOorVK5FuxO7xRGfvRlb96ApV7NPbqpdPtN4znRPfa+XQNEvEDpAL2x+U1j8rq/6B4A+T2LrG94SoYapwCE3jZIr9FhFR343ebjlJwU1sbIkYVnU0ST1ew9NeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgXoEpGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgXoEpGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D61F000FF;
	Sat, 26 Sep 2026 21:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790458461;
	bh=d1ZKJhak51SGw94VniqLlZUTFMmDUZmUuUatjH3/EQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RgXoEpGlWkMA1Btc9pzZqaN+s5o59Tx7NjM6JqaWTITc2P3ybik6owhQbX9y2PSUl
	 oS1j+XavBwdHjrrE4Tg2hoQLOiEgXeSHGVZjTfFCjkoWWTMwqQUkqSpc5jsTTt+d6b
	 2wGOrX0aAa19WM3YonkP8u7fklsYhAP6VgQBiRqIVqLUWPn0WpLWqXEqtCsUGOZ5HV
	 X3RriBOmBbpk9/FAYMfBJwtMC4M1zXDqXXYwQb5MPNUt7YK56M28pQ2UeV3lDBALVj
	 /nVEE2mMwmrtm/WS+BITZ3+jo2lVYTtgZEIIVcUx67b74xYX9/gbt0+31hdveQC1aO
	 eBtTc1Hd4k/lA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vdpa/vp_vdpa: Wait for device reset to complete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260926211507.1330179-1-oss.patchbox@gmail.com>
References: <20260926211507.1330179-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 21:34:21 +0000
Message-Id: <20260926213421.9E5D61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vdpa: infinite wait in vp_vdpa_reset() on surprise removal
--

commit ae50410e662342786548e32b0e3164421c8c5862
Author: Yuho Choi <oss.patchbox@gmail.com>

vdpa/vp_vdpa: Wait for device reset to complete

This commit modifies vp_vdpa_reset() to poll the device status after writing
0, waiting for it to become 0. This ensures the device reset completes befo=
re
tearing down IOTLB/IOMMU mappings or freeing IRQs.

> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index f2eb654b1665a..4285cb968479a 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
[ ... ]
> @@ -236,6 +237,9 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>  	u8 s =3D vp_vdpa_get_status(vdpa);
> =20
>  	vp_modern_set_status(mdev, 0);
> +	/* Wait for the reset to complete */
> +	while (vp_modern_get_status(mdev))
> +		fsleep(1000);

[Severity: High]
Could this unbounded wait cause an infinite loop during a surprise removal?

If the underlying PCI device undergoes a surprise removal (hot-unplug) or a
fatal bus error, memory-mapped I/O reads via vp_modern_get_status() will
persistently return all-ones (0xFF).

Since there is no timeout or explicit check for the 0xFF PCIe disconnect
state, could this lead to a permanent kernel thread hang in uninterruptible
sleep?

> =20
>  	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>  		vp_vdpa_free_irq(vp_vdpa);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926211507.1330=
179-1-oss.patchbox@gmail.com?part=3D1
