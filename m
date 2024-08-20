Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7D18E345
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141387; cv=none; b=ADiATu3axWSAEVKGHBAcJwxTyVWxNWmCtpdemqkEveU4mwCkZv+ABNXk4NwbHBmI5Fp3lzetkZQBCTrGettMxnl8u6T0Rf8QVBG54wmNGiWCqQw3OkrmZiovvt5HA7PHyo7VGGZnONAoThYgXFzqxN4WXgJi+OAQj0qnvms+QOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141387; c=relaxed/simple;
	bh=Tc8g8qFsguADZpbCbg2ZeMsuhKbmAlkOwjHQW31v8T4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTUizkWyGu62yOBgJvSp43QVXr1xrz1YltkSTU0QFjAqd5AP8hKB6inNTZIT0jw/t7XiM8gxfOY7zQvDcFGgt2GgUQr0Nw2+y5+jpumIZFZVWzVpyVnoDS/lNptl33AjObzrOllD8VTkFH2jB+JXYrtnH1WG6HShtFK57ujEbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWJq0047; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWJq0047"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724141384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df70XQ1ykgUQrw1fVZpz027YZA27sohQWW93y4fszco=;
	b=KWJq0047esZBssF2KbIVpwJzEKo3YLfJndjvGgSC77EJt0fPN4LbNKsDS1pEYhICntw2zF
	CNDj5WteeS1ZZtaBB9vyTduKRGDVEZMBTb3eGtI8LNZKYmy9UxdTnUa62V3m5XSYsCxAP6
	4fUA8l+04Ngc/IJ2fD36xZk4FXWc2+U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-_gmT8vjrP4C0w-j6hBmcVg-1; Tue, 20 Aug 2024 04:09:42 -0400
X-MC-Unique: _gmT8vjrP4C0w-j6hBmcVg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f01b609ac9so4215971fa.1
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 01:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141381; x=1724746181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pczNxSocdM26pcn5q5hEVOERw14zQBRp0K6rH/Gt/U8=;
        b=MkBaW4SA/P/deMGSXApY8KT73i/+tuh6qM5b3sEzYu6MXmojMeqtZvbYvjAzqLJXW3
         1AUy4qLBi9pnG9IbYiIuUMI6f5ZJBAaOOg8THlp4ZSaOW8cI2/sojNLyb0RRkXAbH3hb
         UgTkplwc8KwItmQzGOnvhHHqbEDWgMF/Ed4nR7D2LA5FUpe0VOn6Kjmrrz64kqvevSg8
         oGqACvgKRdQCIdzjYWd91PjRlcS9rJccgE039BlzBfD/DPhi8gXEFXebhXt/NQlMrPvP
         Fyb0Lh4wdpJ/hSrxoEua6VlsLxmHi9c14eSnhO9LkfznU9vzhXfP+Q2kMYs+J5v/BF/b
         ZhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDCt9A6OOlrwPlfoW7sO4EGEa7UGaPdnCdRfJEbvM89WWjwMlb6+daXxvTbm9S7GHpMDJ6CMVlBTNiTWUVJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6xv4GUHZTjZHmL7XQbS7ShVPaYF8DRULoVqxA2As4yZXfTf5T
	dEDgZjrUJcY+0Vu3KeXSHYJdzglKR8Eyt7RB2UaLKpNYhMdD2Tvxz/NVMKwT9UmNeJ0wS3g7+0n
	Rc+0alKUwf7WDbG89QcpzPcrte4ostBFbaxM5NBugT1yeocp0yfmRLUgZMvhXBbyI
X-Received: by 2002:a05:651c:2211:b0:2ef:24a9:6aa8 with SMTP id 38308e7fff4ca-2f3be3e14b8mr44110211fa.0.1724141380710;
        Tue, 20 Aug 2024 01:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUKjHSOAziZ7PYgWrAVl4EdFwjiCRVXWWzixF1wxqW29HSPOlA0o0CuaPTeGWaikDKakA/tA==
X-Received: by 2002:a05:651c:2211:b0:2ef:24a9:6aa8 with SMTP id 38308e7fff4ca-2f3be3e14b8mr44109861fa.0.1724141380001;
        Tue, 20 Aug 2024 01:09:40 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935909sm728451466b.112.2024.08.20.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:09:39 -0700 (PDT)
Message-ID: <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, onathan Corbet
 <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 10:09:37 +0200
In-Reply-To: <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-10-pstanner@redhat.com>
	 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-08-19 at 20:19 +0200, Christophe JAILLET wrote:
> Le 19/08/2024 =C3=A0 18:51, Philipp Stanner a =C3=A9crit=C2=A0:
> > solidrun utilizes pcim_iomap_regions(), which has been deprecated
> > by the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
> > things because it forces usage of quite a complicated bitmask
> > mechanism.
> > The bitmask handling code can entirely be removed by replacing
> > pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table() with
> > pci_iomap_region().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/vdpa/solidrun/snet_main.c | 47 +++++++++++--------------=
-
> > -----
> > =C2=A0 1 file changed, 16 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index 99428a04068d..abf027ca35e1 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,33 +556,24 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > =C2=A0 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > =C2=A0 {
> > =C2=A0=C2=A0=09char name[50];
> > -=09int ret, i, mask =3D 0;
> > +=09int i;
> > +
> > +=09snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > +
> > =C2=A0=C2=A0=09/* We don't know which BAR will be used to communicate..
> > =C2=A0=C2=A0=09 * We will map every bar with len > 0.
> > =C2=A0=C2=A0=09 *
> > =C2=A0=C2=A0=09 * Later, we will discover the BAR and unmap all other
> > BARs.
> > =C2=A0=C2=A0=09 */
> > =C2=A0=C2=A0=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (pci_resource_len(pdev, i))
> > -=09=09=09mask |=3D (1 << i);
> > -=09}
> > -
> > -=09/* No BAR can be used.. */
> > -=09if (!mask) {
> > -=09=09SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > -=09=09return -ENODEV;
> > -=09}
> > -
> > -=09snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > -=09ret =3D pcim_iomap_regions(pdev, mask, name);
> > -=09if (ret) {
> > -=09=09SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > -=09=09return ret;
> > -=09}
> > +=09=09if (pci_resource_len(pdev, i)) {
> > +=09=09=09psnet->bars[i] =3D pcim_iomap_region(pdev,
> > i, name);
>=20
> Hi,
>=20
> Unrelated to the patch, but is is safe to have 'name' be on the
> stack?
>=20
> pcim_iomap_region()
> --> __pcim_request_region()
> --> __pcim_request_region_range()
> --> request_region() or __request_mem_region()
> --> __request_region()
> --> __request_region_locked()
> --> res->name =3D name;
>=20
> So an address on the stack ends in the 'name' field of a "struct
> resource".

Oh oh...

>=20
> According to a few grep, it looks really unusual.
>=20
> I don't know if it is used, but it looks strange to me.


I have seen it used in the kernel ringbuffer log when you try to
request something that's already owned. I think it's here, right in
__request_region_locked():

/*
 * mm/hmm.c reserves physical addresses which then
 * become unavailable to other users.  Conflicts are
 * not expected.  Warn to aid debugging if encountered.
 */
if (conflict->desc =3D=3D IORES_DESC_DEVICE_PRIVATE_MEMORY) {
=09pr_warn("Unaddressable device %s %pR conflicts with %pR",
=09=09conflict->name, conflict, res);
}


Assuming I interpret the code correctly:
The conflicting resource is found when a new caller (e.g. another
driver) tries to get the same region. So conflict->name on the original
requester's stack is by now gone and you do get UB.

Very unlikely UB, since only rarely drivers race for the same resource,
but still UB.

But there's also a few other places. Grep for "conflict->name".

>=20
>=20
> If it is an issue, it was apparently already there before this patch.

I think this has to be fixed.

Question would just be whether one wants to fix it locally in this
driver, or prevent it from happening globally by making the common
infrastructure copy the string.


P.


>=20
> > +=09=09=09if (IS_ERR(psnet->bars[i])) {
> > +=09=09=09=09SNET_ERR(pdev, "Failed to request
> > and map PCI BARs\n");
> > +=09=09=09=09return PTR_ERR(psnet->bars[i]);
> > +=09=09=09}
> > +=09=09}
> > =C2=A0=20
> > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (mask & (1 << i))
> > -=09=09=09psnet->bars[i] =3D
> > pcim_iomap_table(pdev)[i];
> > =C2=A0=C2=A0=09}
> > =C2=A0=20
> > =C2=A0=C2=A0=09return 0;
> > @@ -591,18 +582,15 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
> > *snet)
> > =C2=A0 {
> > =C2=A0=C2=A0=09char name[50];
> > -=09int ret;
> > =C2=A0=20
> > =C2=A0=C2=A0=09snprintf(name, sizeof(name), "snet[%s]-bar",
> > pci_name(pdev));
> > =C2=A0=C2=A0=09/* Request and map BAR */
> > -=09ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet-
> > >cfg.vf_bar), name);
> > -=09if (ret) {
> > +=09snet->bar =3D pcim_iomap_region(pdev, snet->psnet-
> > >cfg.vf_bar, name);
>=20
> Same
>=20
> Just my 2c.
>=20
> CJ
>=20
> > +=09if (IS_ERR(snet->bar)) {
> > =C2=A0=C2=A0=09=09SNET_ERR(pdev, "Failed to request and map PCI BAR
> > for a VF\n");
> > -=09=09return ret;
> > +=09=09return PTR_ERR(snet->bar);
> > =C2=A0=C2=A0=09}
> > =C2=A0=20
> > -=09snet->bar =3D pcim_iomap_table(pdev)[snet->psnet-
> > >cfg.vf_bar];
> > -
> > =C2=A0=C2=A0=09return 0;
> > =C2=A0 }
> > =C2=A0=20
> > @@ -650,15 +638,12 @@ static int psnet_detect_bar(struct psnet
> > *psnet, u32 off)
> > =C2=A0=20
> > =C2=A0 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct
> > psnet *psnet)
> > =C2=A0 {
> > -=09int i, mask =3D 0;
> > +=09int i;
> > =C2=A0=20
> > =C2=A0=C2=A0=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > =C2=A0=C2=A0=09=09if (psnet->bars[i] && i !=3D psnet->barno)
> > -=09=09=09mask |=3D (1 << i);
> > +=09=09=09pcim_iounmap_region(pdev, i);
> > =C2=A0=C2=A0=09}
> > -
> > -=09if (mask)
> > -=09=09pcim_iounmap_regions(pdev, mask);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /* Read SNET config from PCI BAR */
>=20
>=20

