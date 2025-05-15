Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002B282F1
	for <virtualization@lists.linux.dev>; Thu, 15 May 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293280; cv=none; b=q+YGM5uwiphwwsz3y5p0+WX7qBdVw+lsgzRyixnxqb234RyM9cMHeOZAK/47XC0WLenZg1YilLai91HaRSV7aGzPA/Dn/nuvdfIMdBg1QWoHiR5+Aqz46esnWF/vTkZuhSsEg7jPl2X+9FkAc18EUKo5yM0tLlv1aZDjgSWffgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293280; c=relaxed/simple;
	bh=AdiOzKd1rAm178x2PI7l6wU3wLgZH0OiaXgsBhxCeMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIjfwxOi9EuIhgmHoCeg70B/dTVEhPAgputAqaIVGRqCB9Hx8mtpnRxDWM1eRX5WNZ1nDQ9WJN13W1MQzOQooqW4gx0bf1fy0j2DhFusavgF9sLRsr0xVUzsU1Bbe0RE8pXg7gHbonOQgPZz5/o6uPZ/ch1PwZ7zbpG6T7uys/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MsqpcZxi; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MsqpcZxi"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZyhKd1Fhwz9sd7;
	Thu, 15 May 2025 09:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747293269; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tN/OjUP+F6ny/aTLHg6lQwqtubMOvdX5Usteik+4erk=;
	b=MsqpcZxivPqCxu/8noY1ASy7Vgd+/guOaewqqIbACu92A1XqKqzTrFoY+vBT64jfkB5GNH
	JqbPP1TrTWzUf/n8zYfaOM5ysHEkoCpCTPlmgHZLHbqywfZjIcryq02hh4PIZzQ5LQPZnq
	BpvcMhUWBE8K2vdVXZmjHywsDn+LMrmtlOdlDuRWe5cWENSfDMtM2aqUURPkGoNW7+snZm
	Q3r8LOoY0WFgPMxuA9hUZozhv+OMtvFc3zcWx4HDWbaSA3ehekYemNoV97+phv6i8jYVlP
	ppUfNpEWxlbGCSwxMKD8FDE8myjdBPYqMlOpU2XpJXkZKb4ya4WTRpEP/5bysg==
Message-ID: <f6e5e4c0f32f8ecb3be71181042082d2d8a9533b.camel@mailbox.org>
Subject: Re: [PATCH v4] vdpa/octeon_ep: Control PCI dev enabling manually
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, schalla@marvell.com, 
 vattunuru@marvell.com, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Shijith Thotton
 <sthotton@marvell.com>, Dan Carpenter <dan.carpenter@linaro.org>, Satha Rao
 <skoteshwar@marvell.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 15 May 2025 09:14:22 +0200
In-Reply-To: <20250508085134.24084-2-phasta@kernel.org>
References: <20250508085134.24084-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: 9qmrm7e38ipgezxi671tj9uij9ejszxe
X-MBO-RS-ID: 53e957ff3b9784b003f

On Thu, 2025-05-08 at 10:51 +0200, Philipp Stanner wrote:
> PCI region request functions such as pci_request_region() currently
> have
> the problem of becoming sometimes managed functions, if
> pcim_enable_device() instead of pci_enable_device() was called. The
> PCI
> subsystem wants to remove this deprecated behavior from its
> interfaces.
>=20
> octeopn_ep enables its device with pcim_enable_device() (for VF. PF
> uses
> manual management), but does so only to get automatic disablement.
> The
> driver wants to manage its PCI resources for VF manually, without
> devres.
>=20
> The easiest way not to use automatic resource management at all is by
> also handling device enable- and disablement manually.
>=20
> Replace pcim_enable_device() with pci_enable_device(). Add the
> necessary
> calls to pci_disable_device().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Acked-by: Vamsi Attunuru <vattunuru@marvell.com>

Hi again,

this is the last of 12 drivers blocking me from removing a few hundred
lines of broken code from PCI. Would be great if it could be sent to
Linus next merge window.

Can someone take this patch in?

Thx
P.

> ---
> Changes in v4:
> =C2=A0 - s/AF/PF
> =C2=A0 - Add Vamsi's AB
>=20
> Changes in v3:
> =C2=A0 - Only call pci_disable_device() for the PF version. For AF it
> would
> =C2=A0=C2=A0=C2=A0 cause a WARN_ON because pcim_enable_device()'s callbac=
k will also
> =C2=A0=C2=A0=C2=A0 try to disable.
> ---
> =C2=A0drivers/vdpa/octeon_ep/octep_vdpa_main.c | 17 ++++++++++++-----
> =C2=A01 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index f3d4dda4e04c..9b49efd24391 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -454,6 +454,9 @@ static void octep_vdpa_remove_pf(struct pci_dev
> *pdev)
> =C2=A0		octep_iounmap_region(pdev, octpf->base,
> OCTEP_HW_MBOX_BAR);
> =C2=A0
> =C2=A0	octep_vdpa_pf_bar_expand(octpf);
> +
> +	/* The pf version does not use managed PCI. */
> +	pci_disable_device(pdev);
> =C2=A0}
> =C2=A0
> =C2=A0static void octep_vdpa_vf_bar_shrink(struct pci_dev *pdev)
> @@ -825,7 +828,7 @@ static int octep_vdpa_probe_pf(struct pci_dev
> *pdev)
> =C2=A0	struct octep_pf *octpf;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D pcim_enable_device(pdev);
> +	ret =3D pci_enable_device(pdev);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "Failed to enable device\n");
> =C2=A0		return ret;
> @@ -834,15 +837,17 @@ static int octep_vdpa_probe_pf(struct pci_dev
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
> @@ -856,6 +861,8 @@ static int octep_vdpa_probe_pf(struct pci_dev
> *pdev)
> =C2=A0
> =C2=A0unmap_region:
> =C2=A0	octep_iounmap_region(pdev, octpf->base, OCTEP_HW_MBOX_BAR);
> +disable_pci:
> +	pci_disable_device(pdev);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0

