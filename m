Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FA1ACED6
	for <virtualization@lists.linux.dev>; Mon,  9 Dec 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752810; cv=none; b=FFpXlg6Of+lik5qzoIG32bMjQaWsP8GU5pk2hkcesw6fbqtTcNwnvxKh9QwlQefAeIljEg6CsXiJa3Pb1wsET2l2MaslGY8EkhwqmVy/92HvclpYduk9G4BdwPiQtjMaU/GHdurK9pm8sICBtufmEmJQcX+9chl2wJzSFPcqHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752810; c=relaxed/simple;
	bh=t+6ExezcAWJOfUWCdGlGZzuoK/7zZ2IldXX9zpwmRnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEiTzIYhMHi9GP6HO5xqvSm+C4dZydCCMpwvu0avn9icAHeuY2MfxLzbZJ3N8uVQsH7VuGYea/nRPx1HEZ+wcqXsPc7p2PLCS2B7lT3HfU1BGRydg3Hth27D2ojXxEY8gXgOY9BOM5WKING+HH+QMxR++Fn7+A2pwKUh337gMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1mXkd0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1mXkd0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733752806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+6ExezcAWJOfUWCdGlGZzuoK/7zZ2IldXX9zpwmRnk=;
	b=U1mXkd0opvO37XTb08gXVjl72jf3z3V7JFQ5kO1pc+uSjwRtDq9Ym4ABWkqrvmVAHYoe6m
	n6B6HF/spzvfZLUENnocjvtTihq/wZ/oJfzQ5FjixF7f80PDllbOQh/fEpEwkVDsTuyT8b
	PqN03sWV4xstMMcnV7/QMNqN5+DMK2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-xvF-WhghPbyJtXkJd1HYKA-1; Mon, 09 Dec 2024 09:00:02 -0500
X-MC-Unique: xvF-WhghPbyJtXkJd1HYKA-1
X-Mimecast-MFC-AGG-ID: xvF-WhghPbyJtXkJd1HYKA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434e9e1b4d7so11800715e9.3
        for <virtualization@lists.linux.dev>; Mon, 09 Dec 2024 06:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752802; x=1734357602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCinklkjigCgS0jKysyYQNawyzGFbbjhT/H2okLIUXE=;
        b=sjOQ4XJz0DDRx/2INFJH++9P/iE9MEDZQcxiJYupAMboJaMadVaSCCZmxe1z2NqnGT
         NXNy4rPJLSH72LIty7/IxYz/1R4VoH1+4fjaEQFdAesnEb4Sf3XwTGJT1ulaBYIjXVCd
         qYO75UPWvjYvs5JAR1aFwnRvKr39nj+7XID0x5ai/cgK1J2jhmW0OnxDddfG2gTC6JUK
         ItwSi608utwWXILvX7DcpIJBdhjckeM7rVrnh7+FVaP0W1GAVMTWq4KYTYkMetrrlJPZ
         G53MdaXkWhHwQqDCFG+KZw6zgSVHuhYZN1l1LhnKc4VXD733opo/C4Oalttk5Z1XDezB
         q/IA==
X-Forwarded-Encrypted: i=1; AJvYcCVa+akd4cBGO/J/R/OmVjy0KnyWpAT46sTKpTPxUvgkmWa1I370vaBR+TJICXOyfm+9ERIsTtnMkcFAJYrEFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6tqZEYMVsX8MJzKRIqRm4tljI8MVJJS1sa2xaU7y4BJFV8xMl
	GLk1IURHaAwAskiv9f6ilDdo31qiw9fXMHFuSjRCb76ySc+ylwS/SeEBHCeih1EzgMbscvvhFGL
	IyMIyK8SQP/V+84Pt34RP6Sz5nSjtCGQpIsaSwpRp5fcj/3HepY1xjGLm7p74Odmt
X-Gm-Gg: ASbGncuvrqJkG0+bA+qs/EqjxcHYc7Yb//rXYqeBLJK4fJA+3WF47QPMawExpWmCRGM
	sUXwNIGgvsqP0cgx8/EmKqtj8amMkf4dv5N53msndEMeX/hijfsrf4FCYvAqZxdSIJxCOBO1HGU
	4tVpoC4KseXwXxu7bEv9quF6vi8zCBuV7m1ymGbK5QsrXlNd2qvi+VYamgRyl3mdfuhjgNY6idi
	mqK60cZy/3boZN+C9U26ihNDeU53qVM6gLe0PrQenyhqeupannxcL6Fi56/H7DqjPcqlqmwKHAD
X-Received: by 2002:a5d:64ab:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3862b33f3d0mr10459801f8f.5.1733752801661;
        Mon, 09 Dec 2024 06:00:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD8yoSQI/o9NyRQ9nL3G8Ec4Yb63GP/cbt9ujdYqnPDIttZz6GWVr7Hj38Vw1jKYW5HojffA==
X-Received: by 2002:a5d:64ab:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-3862b33f3d0mr10459774f8f.5.1733752801285;
        Mon, 09 Dec 2024 06:00:01 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eba653a0sm83272245e9.22.2024.12.09.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:00:00 -0800 (PST)
Message-ID: <416477913eed1837a3efb0d9a952ea5ee37f538b.camel@redhat.com>
Subject: Re: [PATCH v2] vdpa: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Mon, 09 Dec 2024 15:00:00 +0100
In-Reply-To: <whzxo7v7ocomwvx2onrccrrnfc7eg5g5yeusoifmmflaiawaa6@xylztblydibz>
References: <20241209115118.125940-2-pstanner@redhat.com>
	 <whzxo7v7ocomwvx2onrccrrnfc7eg5g5yeusoifmmflaiawaa6@xylztblydibz>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NRpIPXW27gnVwJ1jvhm_PSHfPyTYNRjGgl9Olgt-t6Q_1733752802
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-12-09 at 14:31 +0100, Stefano Garzarella wrote:
> On Mon, Dec 09, 2024 at 12:51:18PM +0100, Philipp Stanner wrote:
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
> > Changes in v2:
> > =C2=A0- Fix build warning because of dead variable.
> > =C2=A0- Make "bars_found" a boolean, since only true or false are
> > relevant.
> > ---
> > drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++--------------
> > ---
> > 1 file changed, 25 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index c8b74980dbd1..1b9841698a1a 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,59 +556,57 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > {
> > =09char *name;
> > -=09int ret, i, mask =3D 0;
> > +=09unsigned short i;
> > +=09bool bars_found =3D false;
> > +=09void __iomem *io;
>=20
> I would suggest to move this declaration (*io) inside the for loop
> where=20
> it's used.

If you prefer that, OK

>=20
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
> > +=09=09if (pci_resource_len(pdev, i) =3D=3D 0)
> > +=09=09=09continue;
> > +
> > +=09=09io =3D pcim_iomap_region(pdev, i, name);
> > +=09=09if (IS_ERR(io)) {
> > +=09=09=09SNET_ERR(pdev, "Failed to request and map
> > PCI BARs\n");
> > +=09=09=09return PTR_ERR(io);
>=20
> Now instead of calling pcim_iomap_regions() once, we need to call=20
> pcim_iomap_region() multiple times.
> If one of these fails, should we unmap the ones we mapped before?

Nope =E2=80=93 pcim_ functions are managed and psnet_open_pf_bar() is calle=
d
only in the probe() path. Failure of the primer will lead to the latter
returning the error, causing devres to unmapp everything that has so
far been mapped.

P.

>=20
> Thanks,
> Stefano
>=20
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
> > @@ -656,15 +654,12 @@ static int psnet_detect_bar(struct psnet
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

