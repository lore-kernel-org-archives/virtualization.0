Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F1208A9
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410185; cv=none; b=rWx7LjLC82pseeVeglznN5WRcw1yx4AyzCBY4bEdVJbw7A5MAd+TY5FcML5zleAwGFYpWstNmlCwkAG/BjBW46LjF0PUg68NH2oXftTTtmmSavmQMZYgjxfmp9PxUgVr/1Js0GZtiNbvUPoedtJe4qIeeuBoNU0nc437fjF7EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410185; c=relaxed/simple;
	bh=7KM4xGp4HlmfivR3OmdYM85IdsrIUugdEnzXveqN3NU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tpQfVRUqTRZkbRTua0dX02e7NvMdlNS8tnaoYJvO92FZ2WK6A4c5X/C1z7fkvr8NceySD66RwNivrwpZkP/7BGacEURsuBbPQIwl4fupHGKtktnfbZDixxLc9J1gLlEM+/syS1GMho3lZHz4tdKn16HtYrnHyWxfQKen2RoKz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TjN39GP2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TjN39GP2"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZjHwL4HJmz9tRC;
	Wed, 23 Apr 2025 14:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745410178; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0jC58EfDbgWI0/tDSxSeNIT9SElMZbwhS6KdJFqF6U=;
	b=TjN39GP24kDOqITpSTyTXHWv2/OYcMYUl7gsDGsanyFD7iHHFhcDZ8imo0znrROtKm+ZDr
	xdTA7lKtsCw6dsaInzG9l/2BMdaTYDqSL6ZreCITNucF1xbsOyCXt2AGIo2o02wpU00Czi
	NIzVsB+fG0dQQKNE+K3YZHRIaufSXrZyJMfEP5S1Yt6LbMfJuA3w5xgrQRLzNxqoZ9dHN6
	x2FXpG2XC82+InNRNX+YOgIDgHtEwcFSdQHDdRmthtpBdaSfXg2Ba3gn9j7rEaPhDMZIGK
	jXvKdDHyZr6nlQbeqDGrBtscsLgONGX5uNm/w2ClKTimYKDx+WqARJx38vbLJQ==
Message-ID: <f7c67d6cb24e94b9fd053b144f616d71354f114e.camel@mailbox.org>
Subject: Re: [PATCH v2] vdpa/octeon_ep: Control PCI dev enabling manually
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, schalla@marvell.com, 
 vattunuru@marvell.com, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Shijith Thotton
 <sthotton@marvell.com>, Dan Carpenter <dan.carpenter@linaro.org>, Satha Rao
 <skoteshwar@marvell.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Wed, 23 Apr 2025 14:09:34 +0200
In-Reply-To: <20250423103909.59063-2-phasta@kernel.org>
References: <20250423103909.59063-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-ID: 96cd80a0a5606745c10
X-MBO-RS-META: 5wrhks35ng1jssaf3jb64kukjh6p3gsx

On Wed, 2025-04-23 at 12:39 +0200, Philipp Stanner wrote:
> PCI region request functions such as pci_request_region() currently
> have
> the problem of becoming sometimes managed functions, if
> pcim_enable_device() instead of pci_enable_device() was called. The
> PCI
> subsystem wants to remove this deprecated behavior from its
> interfaces.
>=20
> octeopn_ep enables its device with pcim_enable_device(), but does so
> only to get automatic disablement. The driver wants to manage its PCI
> resources manually, without devres.
>=20
> The easiest way not to use automatic resource management at all is by
> also handling device enable- and disablement manually.
>=20
> Replace pcim_enable_device() with pci_enable_device(). Add the
> necessary
> calls to pci_disable_device().	struct
> list_head		pending_list;
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Was formerly called "Use non-hybrid PCI devres API"
>=20
> Changes in v2:
> =C2=A0 - Don't replace the request functions. Enable / disable manually
> =C2=A0=C2=A0=C2=A0 instead. (Vamsi)
> ---
> =C2=A0drivers/vdpa/octeon_ep/octep_vdpa_main.c | 16 +++++++++++-----
> =C2=A01 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index f3d4dda4e04c..0a282f9186f4 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -492,6 +492,8 @@ static void octep_vdpa_remove(struct pci_dev
> *pdev)
> =C2=A0		octep_vdpa_remove_vf(pdev);
> =C2=A0	else
> =C2=A0		octep_vdpa_remove_pf(pdev);
> +
> +	pci_disable_device(pdev);

Taking a second glance, we probably want to do this only for PF, don't
we?

So VF would use pcim_enable_device(), but none of the request
functions, and PF would replace its pcim_enable_device(), and to
compensate for that only the PF remove / deactivate path would actively
call pci_disable_device. Right?

P.

> =C2=A0}
> =C2=A0
> =C2=A0static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const cha=
r
> *name,
> @@ -825,7 +827,7 @@ static int octep_vdpa_probe_pf(struct pci_dev
> *pdev)
> =C2=A0	struct octep_pf *octpf;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D pcim_enable_device(pdev);
> +	ret =3D pci_enable_device(pdev);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "Failed to enable device\n");
> =C2=A0		return ret;
> @@ -834,15 +836,17 @@ static int octep_vdpa_probe_pf(struct pci_dev
> *pdev)
> =C2=A0	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "No usable DMA configuration\n");
> -		return ret;
> +		goto disable_pci;
> =C2=A0	}
> =C2=A0	octpf =3D devm_kzalloc(dev, sizeof(*octpf), GFP_KERNEL);
> -	if (!octpf)
> -		return -ENOMEM;
> +	if (!octpf) {
> +		ret =3D -ENOMEM;
> +		goto disable_pci;
> +	}
> =C2=A0
> =C2=A0	ret =3D octep_iomap_region(pdev, octpf->base,
> OCTEP_HW_MBOX_BAR);
> =C2=A0	if (ret)
> -		return ret;
> +		goto disable_pci;
> =C2=A0
> =C2=A0	pci_set_master(pdev);
> =C2=A0	pci_set_drvdata(pdev, octpf);
> @@ -856,6 +860,8 @@ static int octep_vdpa_probe_pf(struct pci_dev
> *pdev)
> =C2=A0
> =C2=A0unmap_region:
> =C2=A0	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> +disable_pci:
> +	pci_disable_device(pdev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0

