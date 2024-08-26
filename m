Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B4130A7D
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653835; cv=none; b=A6X0klKJjL/VyCRggl34NQCRMNqtUSysutgPb22VNzysWsomZKkxvAtE6IeQjWb4fy0ORi/82RYMqT0W77tabXN8veJgaCC6uTgARFkkBwkyXZ36lZFfA/Dvp9pCl+ROppaNHQntUNnWd3gCT3ftGfG12SP7zkKzdHbd4vaRCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653835; c=relaxed/simple;
	bh=5nxishIfe/1ssux79NyxoEgk0FairCh1OMu70D4Eejk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAeMJIwig/vECTnZ7VSu+mRLLsIJk5Dx2fOMlDcXE8QQuF3jaPR+57LXgrTKIuiUI+xb7V9xw3QJXpNxpuVSWC2xZ3JBLonmJGiwCnA4C1njJbhUpeqN2Z1zdIKjte0ANjt21KKbl7Zhg8FF3EO9ttVgsgkhhPUAVo8Z26HMn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UReVbBcz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UReVbBcz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nxishIfe/1ssux79NyxoEgk0FairCh1OMu70D4Eejk=;
	b=UReVbBcz5VyTAglvycSyplmkWRc7/Aco2x81kVt3Hte2pGHjKgtUfoavKS9wIaNoyEV6RW
	WYePFuPa91jIhm7kF+beT4XNBdNpgevgwKrkp+m32L9Wx4TeT9LaSp0HbGL15UGABmQRsG
	xlebBHecWS1gkdtsLR1Rm8G2WI9DfoA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-HIPutgOdM36QpMPHD4Ag_g-1; Mon, 26 Aug 2024 02:30:31 -0400
X-MC-Unique: HIPutgOdM36QpMPHD4Ag_g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6bf7bb58632so49211216d6.2
        for <virtualization@lists.linux.dev>; Sun, 25 Aug 2024 23:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653831; x=1725258631;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJFTNQ6Wct6NFpa/rz2wXYP7UMNXrnzBHL4pGlquRbc=;
        b=n9U9liShfURcutwR6u0WIEt9/8Wcz9PVJ09ILcZt+OC4/kp7TIBTj8aXXA7TXG7Sxd
         KWWczo8RP2RD05+cEeRtrSX2Mmkv/asmzMwEgqpV6s81ExfmItisjXE/pUbPO4I7ubEt
         QarMkc8nykFseQUW+qd82CcZj39T+SXn7vv3HMsUMo72wjwf/TqE//UZfozP7e0Z7cuz
         GRv1Mc2w2k8ArAHjz+4d1mUI3pjp0FT0w9g1iFoNF8VbFrFe6CP4NZzLkRE3uW8i/8A8
         RrUf1ak5VzmkGbpfcq5qAYXjU/0wRPA6jIvcvqL9nz49uHDckZbCMrcol/47Cke725Oo
         pGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6/ddc/6c/GHBHRNeMpCO67Mb7nx+PEXhKM8ul4qNUetlP6tsNhfFjG3AhSE6LFS+Y/cnbpx0yydr3PqbOGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXlO5nULoNR6VooX2A6CAGv4ErU/oeOSzdNf94yv61UaaZZ1Tr
	HDZrsMnnQdvGS8RQs0AaA89sa3t9YlCEubmu4ScgbTPnBIQcyo2eG9J3IiknRC19pxpgAz8n2ba
	L09+mW7ntdKAqkFLcgPbVkd16sz+MbaBh8fsUlU7yledhDcv9L9pPlt+IitDy7MCZ
X-Received: by 2002:a05:6214:3a87:b0:6c1:6b38:2fa4 with SMTP id 6a1803df08f44-6c16dc7ae95mr108606426d6.24.1724653831062;
        Sun, 25 Aug 2024 23:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjcrM+de6Fn6cHOIaSi480as1GF3hlSLum1vFYi4hcws7Awk5SxCY7Nx45ugpgCSJ72TftWg==
X-Received: by 2002:a05:6214:3a87:b0:6c1:6b38:2fa4 with SMTP id 6a1803df08f44-6c16dc7ae95mr108605926d6.24.1724653830595;
        Sun, 25 Aug 2024 23:30:30 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0685sm43302446d6.101.2024.08.25.23.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:30:30 -0700 (PDT)
Message-ID: <6e93c43e6e513559f0306085211245578c2c9d3f.camel@redhat.com>
Subject: Re: [PATCH v3 6/9] ethernet: stmicro: Simplify PCI devres usage
From: Philipp Stanner <pstanner@redhat.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Damien Le Moal <dlemoal@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org,  linux-fpga@vger.kernel.org,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Mon, 26 Aug 2024 08:30:23 +0200
In-Reply-To: <6q4pcpyqqt6mhj422pfkgggvwu7jhweu5446y6prcjgjql6xeq@jztt7z4fr6rg>
References: <20240822134744.44919-1-pstanner@redhat.com>
	 <20240822134744.44919-7-pstanner@redhat.com>
	 <6q4pcpyqqt6mhj422pfkgggvwu7jhweu5446y6prcjgjql6xeq@jztt7z4fr6rg>
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

On Fri, 2024-08-23 at 12:29 +0300, Serge Semin wrote:
> Hi Philipp
>=20
> On Thu, Aug 22, 2024 at 03:47:38PM +0200, Philipp Stanner wrote:
> > stmicro uses PCI devres in the wrong way. Resources requested
> > through pcim_* functions don't need to be cleaned up manually in
> > the
> > remove() callback or in the error unwind path of a probe()
> > function.
> >=20
> > Moreover, there is an unnecessary loop which only requests and
> > ioremaps
> > BAR 0, but iterates over all BARs nevertheless.
> >=20
> > Furthermore, pcim_iomap_regions() and pcim_iomap_table() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with pcim_iomap_region().
> >=20
> > Remove the unnecessary manual pcim_* cleanup calls.
> >=20
> > Remove the unnecessary loop over all BARs.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> Thanks for the series. But please note the network subsystem
> dev-process requires to submit the cleanup/feature changes on top of
> the net-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

That seems a policy I haven't seen so far; usually the assumption is
that you branch out from Linus's master.

Anyways, I of course am going to help with setting up something
mergeable

>=20
> Just recently a Yanteng' (+cc) series
> https://lore.kernel.org/netdev/cover.1723014611.git.siyanteng@loongson.cn=
/
> was merged in which significantly refactored the Loongson MAC driver.
> Seeing your patch isn't based on these changes, there is a high
> probability that the patch won't get cleanly applied onto the
> net-next tree. So please either rebase your patch onto the net-next
> tree, or at least merge in the Yanteng' series in your tree and
> rebase the patch onto it and let's hope there have been no other
> conflicting patches merged in into the net-next tree.

I'll take a look into that, thx


P.

>=20
> -Serge(y)
>=20
>=20
> > ---
> > =C2=A0.../ethernet/stmicro/stmmac/dwmac-loongson.c=C2=A0 | 25 +++++----=
------
> > ----
> > =C2=A0.../net/ethernet/stmicro/stmmac/stmmac_pci.c=C2=A0 | 18 +++++----=
----
> > =C2=A02 files changed, 12 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > index 9e40c28d453a..5d42a9fad672 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> > @@ -50,7 +50,7 @@ static int loongson_dwmac_probe(struct pci_dev
> > *pdev, const struct pci_device_id
> > =C2=A0=09struct plat_stmmacenet_data *plat;
> > =C2=A0=09struct stmmac_resources res;
> > =C2=A0=09struct device_node *np;
> > -=09int ret, i, phy_mode;
> > +=09int ret, phy_mode;
> > =C2=A0
> > =C2=A0=09np =3D dev_of_node(&pdev->dev);
> > =C2=A0
> > @@ -88,14 +88,11 @@ static int loongson_dwmac_probe(struct pci_dev
> > *pdev, const struct pci_device_id
> > =C2=A0=09=09goto err_put_node;
> > =C2=A0=09}
> > =C2=A0
> > -=09/* Get the base address of device */
> > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (pci_resource_len(pdev, i) =3D=3D 0)
> > -=09=09=09continue;
> > -=09=09ret =3D pcim_iomap_regions(pdev, BIT(0),
> > pci_name(pdev));
> > -=09=09if (ret)
> > -=09=09=09goto err_disable_device;
> > -=09=09break;
> > +=09memset(&res, 0, sizeof(res));
> > +=09res.addr =3D pcim_iomap_region(pdev, 0, pci_name(pdev));
> > +=09if (IS_ERR(res.addr)) {
> > +=09=09ret =3D PTR_ERR(res.addr);
> > +=09=09goto err_disable_device;
> > =C2=A0=09}
> > =C2=A0
> > =C2=A0=09plat->bus_id =3D of_alias_get_id(np, "ethernet");
> > @@ -116,8 +113,6 @@ static int loongson_dwmac_probe(struct pci_dev
> > *pdev, const struct pci_device_id
> > =C2=A0
> > =C2=A0=09loongson_default_data(plat);
> > =C2=A0=09pci_enable_msi(pdev);
> > -=09memset(&res, 0, sizeof(res));
> > -=09res.addr =3D pcim_iomap_table(pdev)[0];
> > =C2=A0
> > =C2=A0=09res.irq =3D of_irq_get_byname(np, "macirq");
> > =C2=A0=09if (res.irq < 0) {
> > @@ -158,18 +153,10 @@ static void loongson_dwmac_remove(struct
> > pci_dev *pdev)
> > =C2=A0{
> > =C2=A0=09struct net_device *ndev =3D dev_get_drvdata(&pdev->dev);
> > =C2=A0=09struct stmmac_priv *priv =3D netdev_priv(ndev);
> > -=09int i;
> > =C2=A0
> > =C2=A0=09of_node_put(priv->plat->mdio_node);
> > =C2=A0=09stmmac_dvr_remove(&pdev->dev);
> > =C2=A0
> > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (pci_resource_len(pdev, i) =3D=3D 0)
> > -=09=09=09continue;
> > -=09=09pcim_iounmap_regions(pdev, BIT(i));
> > -=09=09break;
> > -=09}
> > -
> > =C2=A0=09pci_disable_msi(pdev);
> > =C2=A0=09pci_disable_device(pdev);
> > =C2=A0}
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > index 352b01678c22..f89a8a54c4e8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
> > @@ -188,11 +188,11 @@ static int stmmac_pci_probe(struct pci_dev
> > *pdev,
> > =C2=A0=09=09return ret;
> > =C2=A0=09}
> > =C2=A0
> > -=09/* Get the base address of device */
> > +=09/* Request the base address BAR of device */
> > =C2=A0=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > =C2=A0=09=09if (pci_resource_len(pdev, i) =3D=3D 0)
> > =C2=A0=09=09=09continue;
> > -=09=09ret =3D pcim_iomap_regions(pdev, BIT(i),
> > pci_name(pdev));
> > +=09=09ret =3D pcim_request_region(pdev, i,
> > pci_name(pdev));
> > =C2=A0=09=09if (ret)
> > =C2=A0=09=09=09return ret;
> > =C2=A0=09=09break;
> > @@ -205,7 +205,10 @@ static int stmmac_pci_probe(struct pci_dev
> > *pdev,
> > =C2=A0=09=09return ret;
> > =C2=A0
> > =C2=A0=09memset(&res, 0, sizeof(res));
> > -=09res.addr =3D pcim_iomap_table(pdev)[i];
> > +=09/* Get the base address of device */
> > +=09res.addr =3D pcim_iomap(pdev, i, 0);
> > +=09if (!res.addr)
> > +=09=09return -ENOMEM;
> > =C2=A0=09res.wol_irq =3D pdev->irq;
> > =C2=A0=09res.irq =3D pdev->irq;
> > =C2=A0
> > @@ -231,16 +234,7 @@ static int stmmac_pci_probe(struct pci_dev
> > *pdev,
> > =C2=A0 */
> > =C2=A0static void stmmac_pci_remove(struct pci_dev *pdev)
> > =C2=A0{
> > -=09int i;
> > -
> > =C2=A0=09stmmac_dvr_remove(&pdev->dev);
> > -
> > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -=09=09if (pci_resource_len(pdev, i) =3D=3D 0)
> > -=09=09=09continue;
> > -=09=09pcim_iounmap_regions(pdev, BIT(i));
> > -=09=09break;
> > -=09}
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int __maybe_unused stmmac_pci_suspend(struct device *dev)
> > --=20
> > 2.46.0
> >=20
> >=20
>=20

