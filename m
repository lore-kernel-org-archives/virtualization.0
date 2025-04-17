Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826D189902
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894777; cv=none; b=DyqAsNY/PLWL5p4BFDM9euHvK+InKwSZ+tJFxWeqj7UF8ECPqzSwABys7QyKDQ/RED5oXx7PoJF76W5qFnzeXNjkA3liOlGp5uoY73v6BRiYCJD0W5a7uenV/Oi0xlx9MyZ9XaEDGg2+pMty8b+ze8p64pr4/EFRcngotOrSPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894777; c=relaxed/simple;
	bh=v2x4hFoubcQi9ZZRNcUzMtAy9/ejIC2CLfcg0Z7T1s4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJpyzXVkr/JsANfAj4pBaVY88kpuSyliUpKN+4OrD1ZsHlXnAZGbrLBFy2I6LeJViGFEgqJZWlGX8CZlZ3nsW0na/Y/R2cs9C0dKDZFFsHh4rZRwsOnVHBwFNgFvyQMdXI/Dg6SrowodlW2QN0WHNP1jlGzakCWXUY+vat74mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xiCwG7Un; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xiCwG7Un"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZddJh0HwLz9sjc;
	Thu, 17 Apr 2025 14:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1744894772; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51vweVEcUGCNRfQ4076cptc2aU0LE9uyLpE4JQL7dTg=;
	b=xiCwG7UntZlu1mkOFcCnQBI8kn85BvBzSH+PwkuOail+q2Lv/1BX/kqrv/wFvyDutjtby8
	wBPcrHJkRyOmUwEcaGK372XvHHCUnz5flZ9NupLLw/FwwBYzk5Ep7euWGvSrsRpshdwRCs
	0FlTKo3DaG1f2UMaP/OfxrF+gw87gxtju6qYttC+4jvHAqh9XynfZ73HKfUi0r5DeN7Mnt
	fOEPLF684WIZiNmkADFOXpTdd5yIodNqL24mav8CuolL04FhxjJWw/QRe6OEY+9u7t5S7I
	0s4bf9FRGPQetvLG2YXvLLCIiKUiBUDAWrGcAHCpRJEZd9Pn0lp4zdg0s1muzA==
Message-ID: <0f5768efe0828802435affa444a615dd9fefad08.camel@mailbox.org>
Subject: Re: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI devres API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "phasta@kernel.org"
 <phasta@kernel.org>, Srujana Challa <schalla@marvell.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Shijith Thotton <sthotton@marvell.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Satha Koteswara Rao Kottidi
 <skoteshwar@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 17 Apr 2025 14:59:28 +0200
In-Reply-To: <MW4PR18MB5244B9A5E105A514BB3D5272A6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20250417080211.19970-2-phasta@kernel.org>
	 <MW4PR18MB5244915E54967510C5356B4DA6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
	 <a57d5f6f47ec8ba2860df853aca324e96320eba5.camel@mailbox.org>
	 <MW4PR18MB5244B9A5E105A514BB3D5272A6BC2@MW4PR18MB5244.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-META: z4crme3k945xyf5yhq3gyr5piqsyqget
X-MBO-RS-ID: 5cf4e34f0750923ffa0

On Thu, 2025-04-17 at 12:56 +0000, Vamsi Krishna Attunuru wrote:
>=20
>=20
> > -----Original Message-----
> > From: Philipp Stanner <phasta@mailbox.org>
> > Sent: Thursday, April 17, 2025 4:09 PM
> > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; Philipp Stanner
> > <phasta@kernel.org>; Srujana Challa <schalla@marvell.com>; Michael
> > S.
> > Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Xuan
> > Zhuo <xuanzhuo@linux.alibaba.com>; Eugenio P=C3=A9rez
> > <eperezma@redhat.com>; Shijith Thotton <sthotton@marvell.com>; Dan
> > Carpenter <dan.carpenter@linaro.org>; Satha Koteswara Rao Kottidi
> > <skoteshwar@marvell.com>
> > Cc: virtualization@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
> > devres API
> >=20
> > On Thu, 2025-04-17 at 09:=E2=80=8A02 +0000, Vamsi Krishna Attunuru wrot=
e: >
> > > > > -----
> > Original Message----- > > From: Philipp Stanner
> > <phasta@=E2=80=8Akernel.=E2=80=8Aorg> > >
> > Sent: Thursday, April 17, 2025 1:=E2=80=8A32 PM > > To: Srujana
> >=20
> > On Thu, 2025-04-17 at 09:02 +0000, Vamsi Krishna Attunuru wrote:
> > >=20
> > >=20
> > > > -----Original Message-----
> > > > From: Philipp Stanner <phasta@kernel.org>
> > > > Sent: Thursday, April 17, 2025 1:32 PM
> > > > To: Srujana Challa <schalla@marvell.com>; Vamsi Krishna
> > > > Attunuru
> > > > <vattunuru@marvell.com>; Michael S. Tsirkin <mst@redhat.com>;
> > > > Jason
> > > > Wang <jasowang@redhat.com>; Xuan Zhuo
> > <xuanzhuo@linux.alibaba.com>;
> > > > Eugenio P=C3=A9rez <eperezma@redhat.com>; Shijith Thotton
> > > > <sthotton@marvell.com>; Dan Carpenter
> > > > <dan.carpenter@linaro.org>;
> > > > Philipp Stanner <phasta@kernel.org>; Satha Koteswara Rao
> > > > Kottidi
> > > > <skoteshwar@marvell.com>
> > > > Cc: virtualization@lists.linux.dev;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: [EXTERNAL] [PATCH] vdpa/octeon_ep: Use non-hybrid PCI
> > > > devres API
> > > >=20
> > > > octeon enables its PCI device with pcim_enable_device(). This,
> > > > implicitly, switches the function pci_request_region() into
> > > > managed
> > > > mode, where it becomes a devres function. The PCI subsystem
> > > > wants to
> > > > remove this hybrid nature from its interfaces.
> > > > octeon enables its PCI device with pcim_enable_device(). This,
> > > > implicitly, switches the function pci_request_region() into
> > > > managed
> > > > mode, where it becomes a devres function.
> > > >=20
> > > > The PCI subsystem wants to remove this hybrid nature from its
> > > > interfaces. To do so, users of the aforementioned combination
> > > > of
> > > > functions must be ported to non-hybrid functions.
> > > >=20
> > > > Moreover, since both functions are already managed in this
> > > > driver,
> > > > the calls to
> > > > pci_release_region() are unnecessary.
> > > >=20
> > > > Remove the calls to pci_release_region().
> > > >=20
> > > > Replace the call to sometimes-managed pci_request_region() with
> > > > one
> > > > to the always-managed pcim_request_region().
> > >=20
> >=20
> > Hi,
> >=20
> > > Thanks you, Philipps, for the patch. The Octeon EP driver does
> > > not use
> > > managed calls for handling resource regions.
> > > This is because the PCIe PF function reduces its resources to
> > > share
> > > them with its VFs and later restores them to original size once
> > > the
> > > VFs are released. Due to this resource sharing requirement, the
> > > driver
> > > cannot use the always-managed request regions calls.
> >=20
> > so this would mean that the driver is already broken.
> > pci_request_region() in your driver is always-managed since you
> > call
> > pcim_enable_device(). Or am I missing something?
>=20
> Driver is not actually broken. Yes, pci_request_region is always
> managed in the driver due to pcim_enable_device().
> But inside pcim_request_region(), res->type is considered as
> PCIM_ADDR_DEVRES_TYPE_REGION and
> pcim_addr_resource_release() releases entire bar. Whereas my driver
> needs type=3DPCIM_ADDR_DEVRES_TYPE_MAPPING
> so that pci_iounmap() get called. If I use this patch, driver reload
> was failing for VF devices with below errors
>=20
> [90662.789921] octep_vdpa 0000:17:02.0: BAR 4: can't reserve [mem
> 0x207ff0000000-0x207ff07fffff 64bit pref]
> [90662.789922] octep_vdpa 0000:17:02.0: Failed to request BAR:4
> region
>=20
> As you suggested below, I prefer to have non-managed version (use
> pci_request_region()) and explicit remove() at required
> places for now.

Would you then mind replacing pcim_enable_device() with
pci_enable_device()? Should I send you a patch for that or do you want
to do that yourself?

That should do the trick.=20

P.

>=20
> >=20
> > The only way for you to, currently, have non-managed versions is by
> > using
> > pci_enable_device() instead and then doing pci_disable_device()
> > manually in
> > remove() and the other appropriate places.
> >=20
> > This patch should not change behavior in any way.
> >=20
> > If you're sure that having no management is not a problem, then we
> > could
> > simply drop this patch and I later remove the hybrid feature from
> > PCI. Then
> > your call to pci_request_region() will become unmanaged, even if
> > you keep
> > the pcim_enable_device().
> >=20
> > Tell me if you have a preference.
> >=20
> > P.
> >=20
> > >=20
> > > >=20
> > > > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > > > ---
> > > > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 4 +---
> > > > 1 file changed, 1 insertion(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > > > b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > > > index f3d4dda4e04c..e0da6367661e 100644
> > > > --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > > > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > > > @@ -391,7 +391,7 @@ static int octep_iomap_region(struct
> > > > pci_dev
> > > > *pdev,
> > > > u8 __iomem **tbl, u8 bar)=C2=A0 {
> > > > 	int ret;
> > > >=20
> > > > -	ret =3D pci_request_region(pdev, bar,
> > > > OCTEP_VDPA_DRIVER_NAME);
> > > > +	ret =3D pcim_request_region(pdev, bar,
> > > > OCTEP_VDPA_DRIVER_NAME);
> > > > 	if (ret) {
> > > > 		dev_err(&pdev->dev, "Failed to request BAR:%u
> > > > region\n",
> > bar);
> > > > 		return ret;
> > > > @@ -400,7 +400,6 @@ static int octep_iomap_region(struct
> > > > pci_dev
> > > > *pdev,
> > > > u8 __iomem **tbl, u8 bar)
> > > > 	tbl[bar] =3D pci_iomap(pdev, bar, pci_resource_len(pdev,
> > > > bar));
> > > > 	if (!tbl[bar]) {
> > > > 		dev_err(&pdev->dev, "Failed to iomap
> > > > BAR:%u\n", bar);
> > > > -		pci_release_region(pdev, bar);
> > > > 		ret =3D -ENOMEM;
> > > > 	}
> > > >=20
> > > > @@ -410,7 +409,6 @@ static int octep_iomap_region(struct
> > > > pci_dev
> > > > *pdev,
> > > > u8 __iomem **tbl, u8 bar)=C2=A0 static void
> > > > octep_iounmap_region(struct
> > > > pci_dev *pdev, u8 __iomem **tbl, u8 bar)=C2=A0 {
> > > > 	pci_iounmap(pdev, tbl[bar]);
> > > > -	pci_release_region(pdev, bar);
> > > > }
> > > >=20
> > > > static void octep_vdpa_pf_bar_shrink(struct octep_pf *octpf)
> > > > --
> > > > 2.48.1
> > >=20
>=20

