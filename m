Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E851FCFDB
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886359; cv=none; b=gki43dwNG2NQYN5FqnaPi7oSk9xJFHJytU4GE1WkLUqtrMkcPl8Ta0ii1eZTxB4UBouY5usWo0kWqmmBcCQ0jtNUIedUA/aLTW4b54gtdrndzxayUVoUdfVJblnno5pAWN5J3dJdYlKYVkunvz0ZoCKBaOYraOdRZ97YUbcf6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886359; c=relaxed/simple;
	bh=FScuytPa7BVtESYhlq0/ySpyt5XQoXcBSARNnZUAQk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYZHw3bEW7dmAZdNuICZiQgquDb6fb/8ybYdgWHa7EP4JgOzBQnQ5wDt06s4w/88vP55ABmAyKU5xe4x0BCKSMygsWagRvK1Z6zhT3j3uaysA+XSWE5fcoqJS6eaCzG7duTeXj7QsAFcc5hEhBAp6ZQJ7qB0fGxzbkE4HDZZYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OblIvBKG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OblIvBKG"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZdZBg4Db6z9scS;
	Thu, 17 Apr 2025 12:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744886347; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQLlTUlWNFBKex/ZjXydkFbFf0c+8GjaEBRE38VDF7g=;
	b=OblIvBKGl8ll6MyS+W5A1C0MjamQS+o1lKEP9iaU9ZGIVGIIBlFrfbC2oGs1ziIzSt6PAz
	FYeIk7racX2GXO+3SzkaRZdwz6+pSzOyE6K8Dcv91ZQXQU+8vhNAxENqh37r6FesJ4P/DX
	wwdiFmxPoBJVI3vo1Yp0OeJdDQ/1uQU1GCbUUySBnb/sNhopi4Ew+HAF5p99mi4V80ZS64
	3448dg5D0nimWTxQ2z+0xriyya+CoNCINTyTRuxA/A+etbPgSe0HAqjFpJCmDGhzgqRVYK
	Eq7Na8OYujERjr+BUt34DopaHs/gmAvKxqRLgQxbn2kyWoUDRu0Wgme+DdVIwQ==
Message-ID: <a57d5f6f47ec8ba2860df853aca324e96320eba5.camel@mailbox.org>
Subject: Re: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, Philipp Stanner
 <phasta@kernel.org>, Srujana Challa <schalla@marvell.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Shijith Thotton <sthotton@marvell.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Satha Koteswara Rao Kottidi
 <skoteshwar@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 17 Apr 2025 12:39:03 +0200
In-Reply-To: <MW4PR18MB5244915E54967510C5356B4DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20250417080211.19970-2-phasta@kernel.org>
	 <MW4PR18MB5244915E54967510C5356B4DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: rb5uzba7q5c5x9fspej4193ndgothiej
X-MBO-RS-ID: 87fe8f476df6e81c675

On Thu, 2025-04-17 at 09:02 +0000, Vamsi Krishna Attunuru wrote:
>=20
>=20
> > -----Original Message-----
> > From: Philipp Stanner <phasta@kernel.org>
> > Sent: Thursday, April 17, 2025 1:32 PM
> > To: Srujana Challa <schalla@marvell.com>; Vamsi Krishna Attunuru
> > <vattunuru@marvell.com>; Michael S. Tsirkin <mst@redhat.com>; Jason
> > Wang <jasowang@redhat.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>;
> > Eugenio P=C3=A9rez <eperezma@redhat.com>; Shijith Thotton
> > <sthotton@marvell.com>; Dan Carpenter <dan.carpenter@linaro.org>;
> > Philipp Stanner <phasta@kernel.org>; Satha Koteswara Rao Kottidi
> > <skoteshwar@marvell.com>
> > Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
> > devres
> > API
> >=20
> > octeon enables its PCI device with pcim_enable_device(). This,
> > implicitly,
> > switches the function pci_request_region() into managed mode, where
> > it
> > becomes a devres function. The PCI subsystem wants to remove this
> > hybrid
> > nature from its interfaces.=20
> > octeon enables its PCI device with pcim_enable_device(). This,
> > implicitly,
> > switches the function pci_request_region() into managed mode, where
> > it
> > becomes a devres function.
> >=20
> > The PCI subsystem wants to remove this hybrid nature from its
> > interfaces. To
> > do so, users of the aforementioned combination of functions must be
> > ported
> > to non-hybrid functions.
> >=20
> > Moreover, since both functions are already managed in this driver,
> > the calls to
> > pci_release_region() are unnecessary.
> >=20
> > Remove the calls to pci_release_region().
> >=20
> > Replace the call to sometimes-managed pci_request_region() with one
> > to the
> > always-managed pcim_request_region().
>=20

Hi,

> Thanks you, Philipps, for the patch. The Octeon EP driver does not
> use managed calls for handling resource regions.=20
> This is because the PCIe PF function reduces its resources to share
> them with its VFs and later restores them to original size
> once the VFs are released. Due to this resource sharing requirement,
> the driver cannot use the always-managed request
> regions calls.

so this would mean that the driver is already broken.
pci_request_region() in your driver is always-managed since you call
pcim_enable_device(). Or am I missing something?

The only way for you to, currently, have non-managed versions is by
using pci_enable_device() instead and then doing pci_disable_device()
manually in remove() and the other appropriate places.

This patch should not change behavior in any way.

If you're sure that having no management is not a problem, then we
could simply drop this patch and I later remove the hybrid feature from
PCI. Then your call to pci_request_region() will become unmanaged, even
if you keep the pcim_enable_device().

Tell me if you have a preference.

P.

>=20
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 4 +---
> > 1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > index f3d4dda4e04c..e0da6367661e 100644
> > --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > @@ -391,7 +391,7 @@ static int octep_iomap_region(struct pci_dev
> > *pdev,
> > u8 __iomem **tbl, u8 bar)=C2=A0 {
> > 	int ret;
> >=20
> > -	ret =3D pci_request_region(pdev, bar,
> > OCTEP_VDPA_DRIVER_NAME);
> > +	ret =3D pcim_request_region(pdev, bar,
> > OCTEP_VDPA_DRIVER_NAME);
> > 	if (ret) {
> > 		dev_err(&pdev->dev, "Failed to request BAR:%u
> > region\n",
> > bar);
> > 		return ret;
> > @@ -400,7 +400,6 @@ static int octep_iomap_region(struct pci_dev
> > *pdev,
> > u8 __iomem **tbl, u8 bar)
> > 	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev,
> > bar));
> > 	if (!tbl[bar]) {
> > 		dev_err(&pdev->dev, "Failed to iomap BAR:%u\n",
> > bar);
> > -		pci_release_region(pdev, bar);
> > 		ret =3D -ENOMEM;
> > 	}
> >=20
> > @@ -410,7 +409,6 @@ static int octep_iomap_region(struct pci_dev
> > *pdev,
> > u8 __iomem **tbl, u8 bar)=C2=A0 static void octep_iounmap_region(struct
> > pci_dev
> > *pdev, u8 __iomem **tbl, u8 bar)=C2=A0 {
> > 	pci_iounmap(pdev, tbl[bar]);
> > -	pci_release_region(pdev, bar);
> > }
> >=20
> > static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
> > --
> > 2.48.1
>=20

