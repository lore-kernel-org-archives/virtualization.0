Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663014437A
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 02:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452332; cv=none; b=hUnyKFZVwl/BdUTcanDIPvpDS0f+ilD8J5Mfc/qOJMCZBwU0XNb5gT+ASecmQG45k5UHNnlLr3PU38gjlY6taeueqHpeQL4GBzuQ5fBRVD2Wtkj0NoOJTNp5hNjDD56cKLOgQ+ITFGYTcLyz5xIb7ayvRA6Jt3a4FvhFFZZk8+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452332; c=relaxed/simple;
	bh=psSwgMWe1elT1U8qnXgITerD+WZPDcBSA++06zwT/mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbsBYUIuAulHdcUosOPv6P5bCBghPLKDfEq6+tupDKwic8MwmX1JARoRZRN+6JyYjjVD45eNJq8YDamNsnCAnuJzz1oEeJQsXCksm37Pb2RGQnLIRKarQlAPsCtuMOGiy1ENyw8c9AODkbJm4xw0iveYl2INaKtAsKRAu13aaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCXmADwZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCXmADwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733452329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3S7L9cV5CfeVxO8g8iOYfQ1CSd9bs4P7h0GpTlREvk=;
	b=aCXmADwZwlZyL1W0EXEG80secrjjQE9tcof+xfQEVKWAFgCeTg6xLrKrQVrpNtVdRfmzpj
	SJkGxJXrFdBNkwL8HQmrRdDvpxGNxYDsDlgLdFxD40LaYkgsTwRaDtoxo+DKj/RA1kItaU
	Axt/Be7YSNJs0iUeWG5XY5HkfJ8oMJE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-DLCdlY1uNFCmwDklIu0biQ-1; Thu, 05 Dec 2024 21:32:08 -0500
X-MC-Unique: DLCdlY1uNFCmwDklIu0biQ-1
X-Mimecast-MFC-AGG-ID: DLCdlY1uNFCmwDklIu0biQ
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee46799961so1898199a91.2
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 18:32:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452327; x=1734057127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3S7L9cV5CfeVxO8g8iOYfQ1CSd9bs4P7h0GpTlREvk=;
        b=P/64CGfkTiurUzvz0oX0OiKf+S1Whu+ahzMt5YA5BCN7tRrkXYxOxF+xoEir6CCK3m
         l6TBxaUzMcb9ZRncYI30ienDEgvLsOFVRzhD1W5FgPfMQjBIvM4ZXb8bTGKYdmJ1plRd
         XlZ90mbNLTYxEYw3Jt7eaCqKZppckU6wjl4A8eBUPn3FAeuY2oD5+iMUo8idqlPmj9Yy
         NGFQf/E+80Y3mLk0tC9MT0bt7FDd0siFZmpTuuc8z7xenFLrgue/6eAf+Ocl4sSy2j9E
         SgcGH++p7jGZ9LkGbhqwQTw0T1dl9t7wzFDb66xRQni3BuppnivUxRGt1OWIbyKIhDVT
         XBJA==
X-Gm-Message-State: AOJu0YyoHPCyroNXJZVFRw+zp+dXOknSiVTXSaPDgTyA5iwfwQaCglIH
	tbleIx9Lb5MVtGvN0SRhZROxU83Pstr8xaT3mQMHYweazmZ/tiLY+jzGzStR0cb0BzJ7yFl7JAu
	pP68G/loV3eFOAa7fBVtkUFn+L8XkE21ZsBgT1GaDEVVFxQ9OlAb2Tpep7VUFH2tuvJuaYsVTxi
	EitdAktTW5imf0AY8nvh2kOzLIRSqwddzEhqPvJa8=
X-Gm-Gg: ASbGncslc2ccUwH0gI4mhyd6xFu6AqueygtR7SzI2M9EGnsX3UqeZYg1BVIprRXwmor
	YVag9JdEtMgVG6OemM5OU9xbELJXbjbup0Q==
X-Received: by 2002:a17:90a:d450:b0:2ee:d958:1b18 with SMTP id 98e67ed59e1d1-2ef6ab27052mr1747254a91.36.1733452326943;
        Thu, 05 Dec 2024 18:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhXJCyWb9HqzY2+QoDErhsAlFYoLsDYEfHhVuqbZB1A7HCi3OjW3Rr6hN1lh6neRiTf7dqSPpRL70foPxIPRc=
X-Received: by 2002:a17:90a:d450:b0:2ee:d958:1b18 with SMTP id
 98e67ed59e1d1-2ef6ab27052mr1747223a91.36.1733452326522; Thu, 05 Dec 2024
 18:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com> <CACGkMEueyPOfgA4W72CMCZHP06fHw07PxbpvKzxm=O2udhRLxA@mail.gmail.com>
In-Reply-To: <CACGkMEueyPOfgA4W72CMCZHP06fHw07PxbpvKzxm=O2udhRLxA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:31:55 +0800
Message-ID: <CACGkMEvhZJCidEf2b5-cppvnX4=JwhbVX_cT9x+LMKLh_N3NcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GCBHMvq7td65VFSlrJf4jnBgKIOiSDmPXMMbTxZN7rg_1733452327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:25=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Nov 21, 2024 at 9:45=E2=80=AFPM Shijith Thotton <sthotton@marvell=
.com> wrote:
> >
> > Updated the driver to utilize all the MSI-X interrupt vectors supported
> > by each OCTEON endpoint VF, instead of relying on a single vector.
> > Enabling more interrupts allows packets from multiple rings to be
> > distributed across multiple cores, improving parallelism and
> > performance.
> >
> > Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> > ---
> > v1:
> > - https://lore.kernel.org/virtualization/20241120070508.789508-1-sthott=
on@marvell.com
> >
> > Changes in v2:
> > - Handle reset getting called twice.
> > - Use devm_kcalloc to allocate irq array.
> > - IRQ is never zero. Adjusted code accordingly.
> >
> >  drivers/vdpa/octeon_ep/octep_vdpa.h      | 10 +--
> >  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   |  2 -
> >  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 90 ++++++++++++++++--------
> >  3 files changed, 64 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_=
ep/octep_vdpa.h
> > index 046710ec4d42..2d4bb07f91b3 100644
> > --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> > +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> > @@ -29,12 +29,12 @@
> >  #define OCTEP_EPF_RINFO(x) (0x000209f0 | ((x) << 25))
> >  #define OCTEP_VF_MBOX_DATA(x) (0x00010210 | ((x) << 17))
> >  #define OCTEP_PF_MBOX_DATA(x) (0x00022000 | ((x) << 4))
> > -
> > -#define OCTEP_EPF_RINFO_RPVF(val) (((val) >> 32) & 0xF)
> > -#define OCTEP_EPF_RINFO_NVFS(val) (((val) >> 48) & 0x7F)
> > +#define OCTEP_VF_IN_CTRL(x)        (0x00010000 | ((x) << 17))
> > +#define OCTEP_VF_IN_CTRL_RPVF(val) (((val) >> 48) & 0xF)
> >
> >  #define OCTEP_FW_READY_SIGNATURE0  0xFEEDFEED
> >  #define OCTEP_FW_READY_SIGNATURE1  0x3355ffaa
> > +#define OCTEP_MAX_CB_INTR          8
> >
> >  enum octep_vdpa_dev_status {
> >         OCTEP_VDPA_DEV_STATUS_INVALID,
> > @@ -50,7 +50,6 @@ struct octep_vring_info {
> >         void __iomem *notify_addr;
> >         u32 __iomem *cb_notify_addr;
> >         phys_addr_t notify_pa;
> > -       char msix_name[256];
> >  };
> >
> >  struct octep_hw {
> > @@ -68,7 +67,8 @@ struct octep_hw {
> >         u64 features;
> >         u16 nr_vring;
> >         u32 config_size;
> > -       int irq;
> > +       int nb_irqs;
> > +       int *irqs;
> >  };
> >
> >  u8 octep_hw_get_status(struct octep_hw *oct_hw);
> > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_hw.c
> > index 1d4767b33315..d5a599f87e18 100644
> > --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> > @@ -495,8 +495,6 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, str=
uct pci_dev *pdev)
> >         if (!oct_hw->vqs)
> >                 return -ENOMEM;
> >
> > -       oct_hw->irq =3D -1;
> > -
> >         dev_info(&pdev->dev, "Device features : %llx\n", oct_hw->featur=
es);
> >         dev_info(&pdev->dev, "Maximum queues : %u\n", oct_hw->nr_vring)=
;
> >
> > diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/oc=
teon_ep/octep_vdpa_main.c
> > index cd55b1aac151..e10cb26a3206 100644
> > --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> > @@ -47,13 +47,30 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdp=
a_device *vdpa_dev)
> >  static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
> >  {
> >         struct octep_hw *oct_hw =3D data;
> > -       int i;
> > +       int i, ring_start, ring_stride;
> > +
> > +       /* Each device has multiple interrupts (nb_irqs) shared among r=
eceive
> > +        * rings (nr_vring). Device interrupts are mapped to specific r=
eceive
> > +        * rings in a round-robin fashion. Only rings handling receive
> > +        * operations require interrupts, and these are at even indices=
.
> > +        *
> > +        * For example, if nb_irqs =3D 8 and nr_vring =3D 64:
> > +        * 0 -> 0, 16, 32, 48;
> > +        * 1 -> 2, 18, 34, 50;
> > +        * ...
> > +        * 7 -> 14, 30, 46, 62;
> > +        */
> > +       ring_start =3D (irq - oct_hw->irqs[0]) * 2;
> > +       ring_stride =3D oct_hw->nb_irqs * 2;
> >
> > -       for (i =3D 0; i < oct_hw->nr_vring; i++) {
> > -               if (oct_hw->vqs[i].cb.callback && ioread32(oct_hw->vqs[=
i].cb_notify_addr)) {
> > -                       /* Acknowledge the per queue notification to th=
e device */
> > +       for (i =3D ring_start; i < oct_hw->nr_vring; i +=3D ring_stride=
) {
> > +               if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {
>
> Could oct_hw->vqs[i].cb_notify_addr change? If not, maybe we can cache
> it somewhere to avoid the read here.

Ok, it looks like the device reuse the notify addr somehow works like an IS=
R.

Thanks

