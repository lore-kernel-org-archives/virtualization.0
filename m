Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E518A92C
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 18:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115193; cv=none; b=LiSDH5RNX/kWFp1eWS+QO7x5ZV7Pc/Xgz5BLeZGC1NZHRUfqctNSsRn4Jt4J+dK6rQQg64FFAIV3OwOnqWrHxDCLy3eF1k5dJOWdmGsKx4dKP7zk6oFD0tmG5CAlBKOYEWKvlqiUC1Raatz7lTlgahX6vsrS5+pO2rvcD5sUv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115193; c=relaxed/simple;
	bh=QYl1o6aIb/H6JeAi/h7zYqnROa8f+kg4MUmDK3nBxno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6BGAd1xJ0urs79yEEu/BisJGSl27kSS2d7nV9uZd0ljBsir4Hlnvh+2vU748FknzOxyTbNNKmJym/3VmRKRFuRq316WDcRPgIynNVOg6vVh10NBXX3YOoPHyTS6Ydces36pItGNQpybH49Inxh8utIk+HH+VINwYfJcS7ULVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DpNqIx6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpNqIx6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734115190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYl1o6aIb/H6JeAi/h7zYqnROa8f+kg4MUmDK3nBxno=;
	b=DpNqIx6jRiJPhu7lwExGkUVI2nFySsBs11K2D0lQF9027tV+MIT3lWueET5+v9cgvRVRRS
	4ugvzqhDn5nYSQ+KjHAqajc9ET5NkFqce+br0H0TzIqLw5+ENecOH8P6uHPD1zbvODmans
	eJNNyBMUgxHzlwlx26T/O8VtJ98vAOM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-CVs0anQiPiCb0hDjbs8WiA-1; Fri, 13 Dec 2024 13:39:49 -0500
X-MC-Unique: CVs0anQiPiCb0hDjbs8WiA-1
X-Mimecast-MFC-AGG-ID: CVs0anQiPiCb0hDjbs8WiA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e3cbf308so864615f8f.2
        for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 10:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734115188; x=1734719988;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3cmFsOycNOgC9BLdxjtj4gNk2h7ZOfj0CcPdOOHaB8=;
        b=q9ETa3iIbKXkeIpfQbi0PJYx/B8k7GhcY/GnzugOs9AnFDV/D1KtHXm5ilhEx/nmUx
         vuwaZ+QYZ6VRl5YOvv33Z7+lWF2ORgZrWyaxO3rzCGv5Lje+POrzYA/CuRi8/GzQefKh
         ZdSdpKKhCmFA/259b57a6y+X5l2PeVeHQrU6kOpHZZ12pN+rePhlbVkDp57R0ozL9qDx
         xt4BEtCtl+vWIEI1fdcIFZvfSsGDFnGMcgutDTF2TUHbkcc2DOOLBSykIEl5UUxdwyXl
         uurhjf+tAK+aPfELDBTM9UBsMMsztLHHRNX6CObNIrHlWVMvDDClipuromTktkvTRt35
         B/xg==
X-Forwarded-Encrypted: i=1; AJvYcCUifoNM2iekhGvnllk9qmD26d7i3y5tzlw1m6g1Rv6Q+9h8U3e2chD4MUolBgntfjwsRbxQpzXut3jDRv94GQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJum1/XYh+y0Lz+Y0eJqItcnR1u2DHpv932cZNxhfuAIUMjTy0
	QjdMvVVZH7vhRagIxvjXZ96eYtmgjktdtKWW5GrA9I1QmIpUFZ3u4LSJXB585mCdqYV4WWf5eb7
	b4qp37R1/70/XXN+7al5UCOlMPaD/C8CKs9X/umCMiMHQk584t/9GOaEJOoZ53IU9
X-Gm-Gg: ASbGncuDunYOGJq04CzevH005oeAe85JUjwQSuPUzoI2/nlVdwh4Qn/cNxtzQ/5AMxI
	IyjuQo1y8MSkWZkRgiA5eBMQcWzTyMgTPl+ym3lr6Esv8bhUjL56WvY835UcSYUBbMJm7lUeUvG
	GAQ+4WEAgybpHdsO3nKSA941qB00q8z5j/9BRDygTkYCv19Wq+ITYZ1j8eXGNgxGAH5/O9Arr0C
	oDq+j1h81SdLq/U4XuBo10ayUgMDK4P671rF/PhIpiSOoB2iG58hpMscvcDpaHjHM2yFUQiMzl6
	2uFCLiACY+nOepaUmHTYkSzAk9VX5/P508l9gWLRsrtwMh4Kn1IhpEPu6CFrbivJWozrsMHSQ98
	rPhAneeZngFpmZcJA
X-Received: by 2002:a5d:5986:0:b0:385:dea3:6059 with SMTP id ffacd0b85a97d-3889ad32e66mr3127498f8f.49.1734115187852;
        Fri, 13 Dec 2024 10:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLa3jJsqtYsc5AY0Ty/8UhIHCPB+WGSKX76RT8lLl69x2aAbXZD/4nY0oas16QhNRCrg0q/A==
X-Received: by 2002:a5d:5986:0:b0:385:dea3:6059 with SMTP id ffacd0b85a97d-3889ad32e66mr3127480f8f.49.1734115187442;
        Fri, 13 Dec 2024 10:39:47 -0800 (PST)
Received: from ?IPv6:2001:16b8:2dc8:6700:cf37:cd3f:fa76:dfb9? (200116b82dc86700cf37cd3ffa76dfb9.dip.versatel-1u1.de. [2001:16b8:2dc8:6700:cf37:cd3f:fa76:dfb9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016373sm243712f8f.36.2024.12.13.10.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:39:47 -0800 (PST)
Message-ID: <08e922383c726a72574ea24eb2db520d40de4c47.camel@redhat.com>
Subject: Re: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Fri, 13 Dec 2024 19:39:46 +0100
In-Reply-To: <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
References: <20241211104704.208354-2-pstanner@redhat.com>
	 <vr7gh5y7ooomyj6hazju7khcuyvw5qs2xjsybj33ztcim3vtc4@gdbozbxlcsi3>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPj8bMLaQrJkbXIW2MoUhA34WDbyFiI61LK-2MOzLsY_1734115188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-12-13 at 16:10 +0100, Stefano Garzarella wrote:
> On Wed, Dec 11, 2024 at 11:47:05AM +0100, Philipp Stanner wrote:
> > The PCI functions
> >=20
> > =09pcim_iomap_regions()
> > =09pcim_iounmap_regions()
> > =09pcim_iomap_table()
> >=20
> > have been deprecated by the PCI subsystem.
> >=20
> > Replace these functions with their successors pcim_iomap_region()
> > and
> > pcim_iounmap_region().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > Changes in v3:
> > =C2=A0- Move __iomem *io declaration into the loop. (Stefano)
> >=20
> > Changes in v2:
> > =C2=A0- Fix build warning because of dead variable.
> > =C2=A0- Make "bars_found" a boolean, since only true or false are
> > relevant.
> > ---
> > drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++--------------
> > ---
> > 1 file changed, 26 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index c8b74980dbd1..643e335f00f1 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,59 +556,58 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > {
> > =09char *name;
> > -=09int ret, i, mask =3D 0;
> > +=09unsigned short i;
> > +=09bool bars_found =3D false;
> > +
> > +=09name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > +=09if (!name)
> > +=09=09return -ENOMEM;
> > +
> > =09/* We don't know which BAR will be used to communicate..
> > =09 * We will map every bar with len > 0.
> > =09 *
> > =09 * Later, we will discover the BAR and unmap all other
> > BARs.
> > =09 */
> > =09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (pci_resource_len(pdev, i))
> > -=09=09=09mask |=3D (1 << i);
> > +=09=09void __iomem *io;
> > +
> > +=09=09if (pci_resource_len(pdev, i) =3D=3D 0)
> > +=09=09=09continue;
> > +
> > +=09=09io =3D pcim_iomap_region(pdev, i, name);
> > +=09=09if (IS_ERR(io)) {
> > +=09=09=09SNET_ERR(pdev, "Failed to request and map
> > PCI BARs\n");
> > +=09=09=09return PTR_ERR(io);
> > +=09=09}
> > +
> > +=09=09psnet->bars[i] =3D io;
> > +=09=09bars_found =3D true;
> > =09}
> >=20
> > =09/* No BAR can be used.. */
> > -=09if (!mask) {
> > +=09if (!bars_found) {
> > =09=09SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > =09=09return -ENODEV;
> > =09}
> >=20
> > -=09name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > -=09if (!name)
> > -=09=09return -ENOMEM;
> > -
> > -=09ret =3D pcim_iomap_regions(pdev, mask, name);
> > -=09if (ret) {
> > -=09=09SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > -=09=09return ret;
> > -=09}
> > -
> > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (mask & (1 << i))
> > -=09=09=09psnet->bars[i] =3D
> > pcim_iomap_table(pdev)[i];
> > -=09}
> > -
> > =09return 0;
> > }
> >=20
> > static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
> > *snet)
> > {
> > =09char *name;
> > -=09int ret;
> >=20
> > =09name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-
> > bars", pci_name(pdev));
> > =09if (!name)
> > =09=09return -ENOMEM;
> >=20
> > =09/* Request and map BAR */
> > -=09ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet-
> > >cfg.vf_bar), name);
> > -=09if (ret) {
> > +=09snet->bar =3D pcim_iomap_region(pdev, snet->psnet-
> > >cfg.vf_bar, name);
>=20
> Could we also use a temporary variable here as we did in=20
> psnet_open_pf_bar()?

We can. Some maintainers want it so, others so

>=20
> It seems to me that no one uses `!snet->bar` for now to check whether
> they are configured or not, but maybe better to prevent, WDYT?

So it seems that this driver is a bit special as its probe() function
can take different paths running into one of the respective request
functions.
Doesn't look to me as if pcim_iomap_region() could fail and the driver
would still load?

Anyways, better safe than sorry. If you think it's safer I can modify
it so those pointers are valid or NULL.


P.

>=20
> Thanks,
> Stefano
>=20
> > +=09if (IS_ERR(snet->bar)) {
> > =09=09SNET_ERR(pdev, "Failed to request and map PCI BAR
> > for a VF\n");
> > -=09=09return ret;
> > +=09=09return PTR_ERR(snet->bar);
> > =09}
> >=20
> > -=09snet->bar =3D pcim_iomap_table(pdev)[snet->psnet-
> > >cfg.vf_bar];
> > -
> > =09return 0;
> > }
> >=20
> > @@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet
> > *psnet, u32 off)
> >=20
> > static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct
> > psnet *psnet)
> > {
> > -=09int i, mask =3D 0;
> > +=09unsigned short i;
> >=20
> > =09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > =09=09if (psnet->bars[i] && i !=3D psnet->barno)
> > -=09=09=09mask |=3D (1 << i);
> > +=09=09=09pcim_iounmap_region(pdev, i);
> > =09}
> > -
> > -=09if (mask)
> > -=09=09pcim_iounmap_regions(pdev, mask);
> > }
> >=20
> > /* Read SNET config from PCI BAR */
> > --=20
> > 2.47.1
> >=20
>=20

