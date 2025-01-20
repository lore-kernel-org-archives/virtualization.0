Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83F196DB1
	for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364400; cv=none; b=XCvzWT67ffRzVfPNo4V63/8gwa9qCs9EpP7IfzjoONwlb7quM11AS+Aot3ZT9lkNptdNo+Smz7ITqUqcxan3j/ED7wZc9b8PBj81CJjnDu/bgEE4D6hJblkq6bkskynp03MF3Uo/l01+kURk1CbdaY3ltxB/rbH/vD9mhIdnif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364400; c=relaxed/simple;
	bh=UTq3ImzsnsB8ba/oS22wapx7P47mkBvf3MOUq2GdfM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4CmxvGhg9/oqOFfs2QSy0U4HFgWtdrYFDYaV8aFEvbhe07zy1jNazRiaqascKi1yAmXaABc/Dhy0QY2x4JYNIAPHx2FPqZA4pwnpxYMGfspVl5qKhsKIhRwaJANLkO2vNilyf4H52cvqbzdcm0aXkVM1sGwTeXomUa5qcVvizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACUanQhv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACUanQhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737364397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UTq3ImzsnsB8ba/oS22wapx7P47mkBvf3MOUq2GdfM8=;
	b=ACUanQhvob1m74RT2h783MaF7ba2AhFOamLjyqhk2yvRif3GGr1PcrDnbAhXiDZNQ3JvAD
	XDRFQoye9m8okaWYfrEEAl0PpZkyy+Q9b4P69lB4kchOYSJ9vLqTC8JfJHKyrw1snjlL0C
	Rud5U37NuXT+qp1nYphtSQy0rx8OtYU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-68j57YYOMpK_pG4RJWmhQw-1; Mon, 20 Jan 2025 04:13:15 -0500
X-MC-Unique: 68j57YYOMpK_pG4RJWmhQw-1
X-Mimecast-MFC-AGG-ID: 68j57YYOMpK_pG4RJWmhQw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso8267606a91.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 01:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737364394; x=1737969194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOis2+SGh36gSDpTA7G0VGC55LeC+q410Z9E2bu9Wh0=;
        b=SuMmg6FfrQpsgalg3bZtWvCNLlsdgJBjkGZVVagcGEaNKyrLQ8SjvBWVxn19ZsC+Ul
         7h+EVkh68LyIXdz+avIHmYkq3TYtfM8cSB7Rnqr1oqnococFycNhpOE4fCbD3nKUhBnu
         YAKK7/UJqk15ClNi0KVR5nl+v03l/psSn0x8nZb3YAgyfVf+0PIQulJ8t0M0C3CKnP24
         0q9uelfwIfy+iWrSkq+kwxntnWa0mYlehGog2dXlthLiA9UuuYGFmH7qw9VDsrlcueJX
         1j3tGzSApPNXMpFCj9tvg1XcpGHuESuJ7B52SY0A12qbdsFIF96HrAXLzsah24/LT1gf
         XZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWOoBFGloisa9+YHVfiNkDPtTWsRKKnq8KRThdxETItnymXg1VgAgSu5kji9u2alSWD8cs2IdtvAKFLqAdX4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy71eO4ZeYsu3FUJVvezUlZctNhY1th9eppA7BhM2zps+zLDZ6s
	AmUOphwJ5LDc4T2Aicwal7QFDaUQkkcYAAyFcUvy24jHP/7sT12ITAPWK4vGqXrqLglOOnV/NKS
	gztGJZKu5NWd+K0hLiNWeDYBCVSLxmqtIM54i9wytzTkb0OvKbqkmqila30m8thER
X-Gm-Gg: ASbGnctyfuLHlla2Txa2SV2olhHgGN0pRPn+tBSbkClnMFxG66HCIArqDpaeLUf8prx
	S+8am0pOPbfIdV/XSFX3mDSP2yoN3M4e/17WrTGU+YVycfdQQvsx3LhcrSgdWtDMI1ipisPps/6
	0D1jlnc1cC5xg8L+w4whFiCSXy9KF4nEEbDTlF/JPdqJTW2ByxXxttuPRkLuJYHCmasU5C7jDUy
	wWgivGMIjgmc9JlR67m+Nyvd5aBR/mMsX9XgYXzAhxhtj5ezCb0M67rvd7/c/BqURqEK3Wk7eCB
	a8SlubxzgbvPxvAUvgnX
X-Received: by 2002:a17:90b:4f92:b0:2ee:d9d4:64a8 with SMTP id 98e67ed59e1d1-2f7284e2e9fmr33034784a91.0.1737364394253;
        Mon, 20 Jan 2025 01:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbLGwRcnbdpES2YQU/wa7wXYeibOgJAduA3aSxYxgLMxcouveQNO7OewgTeWoxgUudCiICAA==
X-Received: by 2002:a17:90b:4f92:b0:2ee:d9d4:64a8 with SMTP id 98e67ed59e1d1-2f7284e2e9fmr33034758a91.0.1737364393879;
        Mon, 20 Jan 2025 01:13:13 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77619e6a5sm7860060a91.26.2025.01.20.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:13:13 -0800 (PST)
Message-ID: <e28c7cb2437d2dee73447db2db1d80646803e63a.camel@redhat.com>
Subject: Re: [PATCH v4] vdpa: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jan 2025 10:13:03 +0100
In-Reply-To: <enuhuc7tjc5ez33c23lgzyy2nhiy54lykshlk5xurl4r6ilnsd@qnhrvku4xpxa>
References: <20241219094428.21511-2-phasta@kernel.org>
	 <enuhuc7tjc5ez33c23lgzyy2nhiy54lykshlk5xurl4r6ilnsd@qnhrvku4xpxa>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZCn62AGo-jdEJwpypcQ2ZEoOp59jqQaovM9LdEx8-g4_1737364394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-12-19 at 10:51 +0100, Stefano Garzarella wrote:
> On Thu, Dec 19, 2024 at 10:44:29AM +0100, Philipp Stanner wrote:
> > From: Philipp Stanner <pstanner@redhat.com>
> >=20
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
> > Changes in v4:
> > =C2=A0- snet_open_vf_bar(): use distinct temporary variable to ensure
> > =C2=A0=C2=A0 snet->bar is never an ERR_PTR. (Stefano)
>=20
> Thanks for that!
>=20
> I don't have a device to test, but it LGTM:
>=20
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Hi all,

can someone please finally merge this?

Thanks,
Philipp


>=20
>=20
> >=20
> > Changes in v3:
> > =C2=A0- Move __iomem *io declaration into the loop. (Stefano)
> >=20
> > Changes in v2:
> > =C2=A0- Fix build warning because of dead variable.
> > =C2=A0- Make "bars_found" a boolean, since only true or false are
> > relevant.
> > ---
> > drivers/vdpa/solidrun/snet_main.c | 57 +++++++++++++++-------------
> > ---
> > 1 file changed, 28 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index c8b74980dbd1..55ec51c17ab3 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,58 +556,60 @@ static const struct vdpa_config_ops
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
> > +=09void __iomem *io;
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
> > +=09io =3D pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar,
> > name);
> > +=09if (IS_ERR(io)) {
> > =09=09SNET_ERR(pdev, "Failed to request and map PCI BAR
> > for a VF\n");
> > -=09=09return ret;
> > +=09=09return PTR_ERR(io);
> > =09}
> >=20
> > -=09snet->bar =3D pcim_iomap_table(pdev)[snet->psnet-
> > >cfg.vf_bar];
> > +=09snet->bar =3D io;
> >=20
> > =09return 0;
> > }
> > @@ -656,15 +658,12 @@ static int psnet_detect_bar(struct psnet
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
> >=20
>=20

