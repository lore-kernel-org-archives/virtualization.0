Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AE1CBEBD
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228488; cv=none; b=GhtkP2vKEp8fQQ9r5hTNSVad8/X9CEYna5T1x4eD+TqwKGnU2fCTW06pD4OQXGYW2zyfhKXuaIM7V8X8p3QZBI98ylcuBXkGrtHYkBOyptN4KSJAp1v23+gGPu7OBBAojwBdVmJQuy7Axo4NdpetAhbUQ/1V0PXLioIjEhH9rbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228488; c=relaxed/simple;
	bh=waui0D5SCOdKeUgU0MnJN8TxtZ1Y7sPbMQkuwpwtiUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+yBgqw/ttYxD1draRgtldFvTiX9Vri2RYRpzWJpk9wj46Kose/UdxpilCgAkIo9kSIk+O+vUESZvbhEjwKSVamGTGB3ClXLGUHZVJxZpq8G9BSYTVa4lqAuyFk8xBU1riiH5h+qMV7y9ffUJpvPvooId3e2+2pWlN97Goq+mAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/sFOph8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/sFOph8"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53346132365so1521074e87.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228485; x=1724833285; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1mM7VOy3wYhnD2rAhzlxVmwa5gojTJ+lhe9geIJYUs=;
        b=k/sFOph84/vdDde3IcmIIw0I4QUABoKUilJqTFV5eAVFDYQ+Z0Erc+mbph9Xl50ni6
         xbRnPP3U2OmuRvKYEEy8DYG0yEVQdmdFFxbcHT2Gqb+V7Nu9PNTSxrQL8ZlwkK1Z0JJW
         MZk2gf4mIaokPk2+a/8zZU6DaVNOFJzlcmNVjWu22ypEudmQUS4rEcB1uWhloPE81lck
         Qy48spndp8uCrUOMZ3TCIn2tdn8gi/bu3E0FNSsHdqSYROdY/tSN+3SHBVTfS17nO8ql
         WeY8SSlgofwtLBc3k4v/6KSN7k9QmZTZkeiYJrkTjaBAKIIosQPEek98O4LoU2yKOMeK
         0Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228485; x=1724833285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1mM7VOy3wYhnD2rAhzlxVmwa5gojTJ+lhe9geIJYUs=;
        b=VaJsYIUGdBEMCofdKmfQw9fy0BrzGfLuVyJTTxqUnbEzUHb7mPe8ORiMNxic3mjZDX
         JHkPtzwxxIGwZj0PIunas1s73Abp6Fn5dXrs9bg2yGmNBW446QRfHuJeUW2hGZADlFUx
         t8Lq0ALlrBCx7wCEzY5U1QgaQpR10n/OpCiAnH2KpUasERkv/5Z68P2x0nvJhEGzSfTd
         v7nslx5oa8Dwd2hGvDjiYjcGwcqENh8+3aLaWfgsOo4DXUDpmxVSBwvYiFMk8RUNYcsr
         sS/jBNEymLTGz1ojGI02Q4QQFmJfpxX3sjxCqOqxEtCbutCXfWT6zY/VAwJm3zyHnDGb
         m38g==
X-Forwarded-Encrypted: i=1; AJvYcCWSt/p+gji8gadCmWLmY/TkuK9GowkkIKZrxvPabM9YDuktm7L93vfzA23Xdx1orwTKl3g/5Mvw+Gm6r/5v2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMVhMTvipV7sy4rS5HAOL/N7fZqzoTr9i4+aMEnpw6Q3b6T7NA
	gIGeG4YAbHSeEhKBiahGIy7p43VuwEh07C5nluqTsDHox3/EfC1XC/I2nvtJnaTYje0E5ZPJqUD
	uw45DqyPaO2n1AtuJ+fP9TDvv/90=
X-Google-Smtp-Source: AGHT+IE5lCR7HVY/g4hFvBV/RGv3qIBpIhbmfnMcQQ7lowungeDx3xymow/Bwb+dY3WdhUTB7lf53PrUHtbP7MuHfPo=
X-Received: by 2002:a05:6512:3512:b0:533:482f:afbe with SMTP id
 2adb3069b0e04-533485af9eamr639466e87.24.1724228484968; Wed, 21 Aug 2024
 01:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-5-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-5-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:20:48 +0300
Message-ID: <CAHp75Ve02c61V7pyAhbJr15jt5nb7Sjn58HzhoY6VH0C7YKVDA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] block: mtip32xx: Replace deprecated PCI functions
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
> In mtip32xx, these functions can easily be replaced by their respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's calls to pcim_iounmap_regions() in probe()'s error path and in
> remove() are not necessary. Cleanup can be performed by PCI devres
> automatically.
>
> Replace pcim_iomap_regions() and pcim_iomap_table().
>
> Remove the calls to pcim_iounmap_regions().

...

>  setmask_err:
> -       pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
> -
>  iomap_err:

Now one of the labels is redundant.

>         kfree(dd);
>         pci_set_drvdata(pdev, NULL);

--=20
With Best Regards,
Andy Shevchenko
