Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E9193079
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686937; cv=none; b=BXSI8k+AJ8q4hcofjvfMQWK5tfqRYbknLr5TgiQgJdUmGo/xYkfNfR6aWrgJ5z399y2JLyEadoLViQUHnsacRCBobsik/emQ0aftuODV2XYHgLE5sFKfSdJ8taxc+T3m1zZFO0u1pzrxv9flzHPQKU6RwPFyz1xLsdUv+APK/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686937; c=relaxed/simple;
	bh=xM8pXW+HgjT0erxnOsIGtoopuFkOjZ2IcKxNFrbxs24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCZrOFK+2hXKBDQAUS40EMbewcaWyu1MUrgWV9+P2/V97lwdYGNOXpxnHNiz3bBBVCgwueURk6fFsIesudDF8A4Dnm4eXzr4rbv9SSHowIobN34NKL8NziYwtDqQV/DZtB1olu5D6kaLZvX0L2MfePcVoYtM/oBMJHNy8l0ajI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZGXwm8b; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZGXwm8b"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533462b9428so7614292e87.3
        for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724686933; x=1725291733; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH/rM9r8vy15gTO0SvqG09ShUwI8MYLfcApXi3x19VU=;
        b=LZGXwm8bH2+R3WbuVOmTn14xpRNiSn96cQYgvhcuhI34bIwLeNJrL4yr2npoPmDATS
         GukAA/hR8Q5jQy1eHLpm2NmKK4UzDh7aoXPdIC/HsXYBd/ot97KptcA/1QwfnJHVBVDI
         CT3+GWdZQtpCU7UtmpIQVZNU20pBxC0KKKegG1AYK8m2vP4u1l/KCRUcoERSskTfOo1k
         tbPhDphSilNFIiWIkEwFf6UHZ0YrmMXjyEt2dqBp0sviHCtXEz4n+zu9vz7AqjOxsm4/
         a0OKaC2Ns+zco+J8AWY7pRu+t9hhe824rOnxXM3d+HCuIU0lAsL1/PRoGTIRs3bIdalv
         B1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686933; x=1725291733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH/rM9r8vy15gTO0SvqG09ShUwI8MYLfcApXi3x19VU=;
        b=c6NIFVqhbwpw/eYe5x2CfCao+vdTpwaO116MuAtjLRNL8I+kAH0pwAWim+R49LXAml
         hiCgeov9CQE28+9jqR7xrh3Hx7y0Os+FQ+p6+0t3YtsCkbFzsmXt7DCIYGZMPbu+Ipyu
         V9B57rgfunUp59RWjetKBpCMldfr10T0NimKi7ccpflDtK7nNXg0qBXOEMJWiKwjPDj7
         a94fHw20Ulc+p6lyadLGaq2fv09wS8d/i9FbT2ITmFqyvludqFyT5QMX63qNwJI5QcjJ
         wOVrJn2YU3XD/CcLvYOCyUdP5PHIHnf9plWenIpeziV/aXBr/s16s90ZND5wlsSjzip6
         gIAA==
X-Forwarded-Encrypted: i=1; AJvYcCXOB/s0urg8SJQxxf52IxraBxOANJ0KokhpKkOkCCktRCn/Eymb3/vzM1gyPHFOW/6TLbRTQm8WGPdXodrqgw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd2g6v/iMPPfi7rPlMTUkuxXHuv/jXoxkP5u6c/bp5aQAvUHPm
	091a7TFvQ4+LMay6YKRYZGepAA7eydZZv1NnPp9BLecgfQHfkFBtr6UiF662+/uXUg/IVkPSoSD
	w/U5zLiH6wGqVSLGuYu6ZmSvDIZY=
X-Google-Smtp-Source: AGHT+IEO+gUPPoFWhnVIZyFPIRMKkPjZZ1g7sFSpxYSDeKMazFoujBp34K9I3yoSDp0PEZ365NhxrirOyyk84oqJOVc=
X-Received: by 2002:ac2:4e06:0:b0:52e:936e:a237 with SMTP id
 2adb3069b0e04-53438846debmr7930724e87.16.1724686932982; Mon, 26 Aug 2024
 08:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240822134744.44919-1-pstanner@redhat.com> <20240822134744.44919-6-pstanner@redhat.com>
 <ZsdO2q8uD829hP-X@smile.fi.intel.com> <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
In-Reply-To: <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Aug 2024 18:41:36 +0300
Message-ID: <CAHp75VfKS_PWer2hEH8x0qgBUEPx05p8BA=c0UirAWjg0SaLeA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:51=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
> On Thu, 2024-08-22 at 17:44 +0300, Andy Shevchenko wrote:
> > On Thu, Aug 22, 2024 at 03:47:37PM +0200, Philipp Stanner wrote:

...

> > > -   err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> > > pci_name(pdev));
> > > -   if (err)
> > > +   clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > > pci_name(pdev));
> > > +   if (IS_ERR(clock->reg_base)) {
> > > +           err =3D PTR_ERR(clock->reg_base);
> > >             goto error_free;
> > > -
> > > -   clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> > > +   }
> >
> > Perhaps
> >
> >       clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > pci_name(pdev));
> >       err =3D PTR_ERR_OR_ZERO(clock->reg_base);
> >       if (err)
> >               goto error_free;
> >
> > This will make your patch smaller and neater.
> >
> > P.S. Do you use --histogram diff algo when preparing patches?
>
> So far not.
> Should one do that?

Id doesn't alter your code, it's in addition to what I suggested, but
as Linus shared that there is no reason to avoid using --histogram not
only in Linux kernel, but in general as it produces more
human-readable diff:s.

--=20
With Best Regards,
Andy Shevchenko
