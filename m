Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF086199FC8
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228582; cv=none; b=A/ULVoul865b4LVKV7siJYIvnvLXZKbHpmgr57fnp4V7BUdGlChiaY06vn+PkoJ8BxEaQgI2SgPZRCyEbQgZTnjEgyiVJzG1w9VKULpw3LCblofKrojq155n3tPbN01++n46bHdvx+3FJTeeyIgKHhVpyQnsqkpQbikTnScBIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228582; c=relaxed/simple;
	bh=cEHplF4jMNpHGE9hNUkCPOYDmxJtkGT5UCfOE9j7f2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS31hjdilCSp6vgjBn9FamDIlpOqCw/uRwZWdevWpqHhpU9VbbpZYypKFylElNi+CYFaQN6hlmdlwcKRGjA0fEbWaROHtJnkulTQQHx2125ODxiZ7Bk7PiMqfhPSnTW4o94mC5ykmWC2sezCcyft/gAwEZnIY7UAAQ8dHPNpoes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGaHn/W9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGaHn/W9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8643235f99so243005066b.3
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228579; x=1724833379; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQJjqDz75DIjtI14ka6f6g6hkoeor8vPcSYTvVZiR7E=;
        b=OGaHn/W9WLGdi5GUg+RYnQAYDmx3z7zJlE1Z9hlK5AjppCFxMNilQ5ymnzgLvXywW4
         DMYUS60/vy5TvHwL7jUz+m05Hb3oj4/w7+QXvH6gn4GWhwGXm1N+eBEK08dfaUhhMPmC
         2EtZofoyAkk6xc1GATgjLBKsgoRIqnFxVyn0EaFffxBVGUERLBj9cQNi3AMa+NK7vTF7
         S03HIOUEa1z4ktXMyKBcN4vEAteiC+RfIIzg5smqQuDFURQGLVBx5VnU9oSG8PWdZdOq
         +AvDrs2+12Z/gAqeINbzltt/84ZM8X1Tf/FoVFIR91HYzkSMR7xUUwYhCfTgLGE/t3Ky
         zSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228579; x=1724833379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQJjqDz75DIjtI14ka6f6g6hkoeor8vPcSYTvVZiR7E=;
        b=F7ohVI6kyU0fDnwaPC5kjQJjLv+r6t4OhjRfk2TWPIDQTUG4NvWpf83AwL5vWpuNo/
         i+PMYd1NlEYLGSvfjLzNr40Uz2vVVBUZOglDa7n6/zsxSxC7yE4sUf9N2JybrgkBBpOp
         dfEThk12gwgaLTiKvjg9G/6NXbuam3AIvx1etPUeAAHZ/5zI6n/NcEba54QIn6QTCsvc
         GGXnOFomakE6epNQNbOp8ggWVwRcmIF6HwMNyEXmenuYrrJlqRKuIvKcnVXDjV5l5mu3
         aXZpXrIvnkLTeR+Z68QFsXpBCTr+WX/gW0hFGRD935HfJdXxGctg7ix24evgxOze9wf9
         NUNw==
X-Forwarded-Encrypted: i=1; AJvYcCXJIslJ2V0fINdIldNGxf8FPOWNZr03FGJ7z5zbUUQBBeTjLMG2SZHDwjiWJoNyxmuICGFdJ0UjyLsRA62w2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFUCjNF3T6+jQu7taCNqb0G5fyAzIWOs9D1vV1x73biHS0b9dV
	yncWpjLRBAJZevGhT+AeEYEXGlu5MF7P4/dygcKgjOe+PUP3/h6E62saUsQJm3ttC82+XIIz1M+
	ugdVtl2TXrHcaHdXL8zersS8V9u8=
X-Google-Smtp-Source: AGHT+IFIFdj7MeWYmPsiZH+WByhUHnKbrwVECRxS82N0iKD7flWPDhWf1z7riSsL+51FW+V5a66YfnwTfRw3oCdVfqc=
X-Received: by 2002:a17:907:f784:b0:a7a:9d1e:3b25 with SMTP id
 a640c23a62f3a-a866f36312emr101512566b.30.1724228578962; Wed, 21 Aug 2024
 01:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-4-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-4-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:22:22 +0300
Message-ID: <CAHp75Vey-zwZG3FrU2fr0ZiQXBO7SV4UfoeutVwVPfk6vKvuTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] fpga/dfl-pci.c: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
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
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:19=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Port dfl-pci.c to the successor, pcim_iomap_region().
>
> Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

>  static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
>  {
> -       if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
> +       void __iomem *bar0;
> +
> +       bar0 =3D pcim_iomap_region(pcidev, 0, DRV_NAME);
> +       if (IS_ERR(bar0))
>                 return NULL;
>
> -       return pcim_iomap_table(pcidev)[0];
> +       return bar0;
>  }

Now this becomes an unneeded wrapper on pcim_ioremap_region(). Can we
kill this helper completely?

--=20
With Best Regards,
Andy Shevchenko
