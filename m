Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEF16D313
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139002; cv=none; b=NE+lksYtBmUT68ZlthFT2irspYoCDrYu0uoMFnfLYkqzWBuaW4OJxm/ZhZXdhCsDf1Zh5kmvHJH/ilgF4o/Neoyc4ieVq27Cr5jaGQuHrMlB5/00i+TYXb0it/Bg7k+d08CncuVqqbr5kidl/v387jj/Xd+sckcsu0fTI2mHMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139002; c=relaxed/simple;
	bh=AlJM5Qv/GX1s6egsP+eZlh57ESRHviZz0UwPlmxz6+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+W6qJ3ZSH/sPqrCHua5amCDAnasrCyVZ3hrpqH0MYLOhIWvcJ+hH+XPfsR56vm+sxn/pezjJEbDaNeL/hiYT6X8zJcaHlAGj3E0e+mT006y4jKHf1m1swC56nQYNn3lQrUcq3xcciWGg9u+MiDKSa4SK1IcyiF7ryOl9Y5ACkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzoalZin; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzoalZin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724138999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlJM5Qv/GX1s6egsP+eZlh57ESRHviZz0UwPlmxz6+w=;
	b=NzoalZini66av893UJI3DF554hu5qjZ15I+KY0BcxwpTMkWBP/wXTaHe7/I7m6S9pROYS4
	JviWGwuCW0QM8GjO5YkM8+p3O6d9SgfD0ivLnshbqib9sxDdjY0NNNC2uiTk+JFhtMhTmg
	30CmLTiOdGROQxSsRJQDC+lvmLy4Xtw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-bjhnmjgGOZGPnUZitLh7Rw-1; Tue, 20 Aug 2024 03:29:57 -0400
X-MC-Unique: bjhnmjgGOZGPnUZitLh7Rw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5334448595aso33747e87.1
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 00:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138995; x=1724743795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1KpD0+PO3KEd8vqUb0exw949el+ZQlXzH10gWUK9kY=;
        b=piqEm3OSIkk+8sILpjcWehUYXlGM75YsyJ7W2wazIuj7P/0thgokUdVnGIgdbHeJHZ
         ut8IvCLFN9KIDnesKlzmFtpjnFaBMIJjUCkWr9HYwV4gRY8U8SHnUixkxcBHEAKoeFRJ
         OJg4+lIFrAbrI/oare3mtr71OHwB4G6HqohRAgWYl8YFCv7mInbI4Fhmy87S0R8q7cWa
         1sRjdhFNXKCDxDTGN/I56xpSbjPtkoqGJlZ8FucD3doJDoYmF2nckLYUfP9oDfi5q6gu
         ZOIC5Ud/WGPNc0KGYQZiEisrJFwglkYTYnpBkGBLz99xolYzNiTX1oY/iKDZAKtv+/Ep
         uCJg==
X-Forwarded-Encrypted: i=1; AJvYcCUylWn0QNhYMLORSyozOH2Bg5OCqg8cBro1K2UMgWo26hmszMxST+6JNG9nHVY4ckJwyysWMJ3OfDoVuFKDAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy59zLlSF1ie60rqwf+EvW4KfVtONNqxLJfosuycCPRbqu7ZbOg
	OhRcWl1/ghoOv+tYXcooe8iOnQtv0eJ0fVB65iHf0xntj/GKkLC+88dxVui/L2O1q5dIK0ZUcG+
	V17/3LsrZWdJcKgrkSFn368RnJVHx9rpDlRNl6ARkOQPQH71d4YJrUKEqZGHCpHFz
X-Received: by 2002:a05:6512:b26:b0:52e:9b87:2340 with SMTP id 2adb3069b0e04-5331c6e45bdmr4732143e87.6.1724138995626;
        Tue, 20 Aug 2024 00:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkOoAmJQBqRwOrXRXs1aVQSYuEizZw5AiMeBmrPImJpZCWeJexcEAw/Dy4dkV+vYq52Tea8Q==
X-Received: by 2002:a05:6512:b26:b0:52e:9b87:2340 with SMTP id 2adb3069b0e04-5331c6e45bdmr4732103e87.6.1724138995010;
        Tue, 20 Aug 2024 00:29:55 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839471b4sm725856366b.164.2024.08.20.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:29:54 -0700 (PDT)
Message-ID: <e406ba06180571564b47872f090623b19e4ad87e.camel@redhat.com>
Subject: Re: [PATCH 4/9] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Hannes Reinecke <hare@suse.de>,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 09:29:52 +0200
In-Reply-To: <ZsOJONEA2x93bSpO@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-6-pstanner@redhat.com>
	 <ZsOJONEA2x93bSpO@smile.fi.intel.com>
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

On Mon, 2024-08-19 at 21:04 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:44PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > In mtip32xx, these functions can easily be replaced by their
> > respective
> > successors, pcim_request_region() and pcim_iomap(). Moreover, the
> > driver's call to pcim_iounmap_regions() is not necessary, because
> > it's
> > invoked in the remove() function. Cleanup can, hence, be performed
> > by
> > PCI devres automatically.
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Remove the call to pcim_iounmap_regions().
>=20
> ...
>=20
> int mtip_pci_probe()
>=20
> > =C2=A0setmask_err:
> > -=09pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> > +=09pcim_release_region(pdev, MTIP_ABAR);
>=20
> But why?

EMOREINFOREQUIRED
Why I replace it or why I don't remove it completely?

>=20
> ...
>=20
> mtip_pci_remove()
>=20
> > =C2=A0=09pci_disable_msi(pdev);
> > =C2=A0
> > -=09pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
>=20
> This is okay.

Removing it is okay, you mean.

>=20
> ...
>=20
> > =C2=A0=09pci_set_drvdata(pdev, NULL);
>=20
> Side note: This is done by driver core for the last 10+ years=E2=80=A6

Ah you know Andy, kernel programmers be like: "When you're hunting you
better make sure the wild sow is really dead before you load it in your
trunk" ;p

P.

>=20

