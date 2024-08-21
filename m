Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE81B1D5F
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228409; cv=none; b=dWdeUWawChTqurYtVc2ruS3PACS+r9/9GSYtL2WeHnOYBh8NAGW9AaMS4sx0zAXUdLOskYhCBMfeGXP7SLBR8m6CHcQ5sbZXvt/BSA6qUUDYshMh97e/WLmWP/FqbhSY0r+OxoyaI7PtgJBm9nZvU2jTaHEBZqN04+3UPncdQrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228409; c=relaxed/simple;
	bh=LMgYW2l8J8PfBaP56tNWVU26fU07THjrd9Mbd01ueEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dwfh82gt4iqSfD/KGtTZ1kPlthu74hMCja5Z0aZEUuTE8ZJflnQFwcSt0yRsp+/FCFbBg/9yV+bJC0opXKqZysVsCDasEBsfrtCyxQVYXr7DKaFmVRuahvkopMpncRNMchJpAApG8DOMmDX4uwRz17ZEWvfhN/qdbW6ZZpiW8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro/kHWz+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro/kHWz+"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so43459121fa.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724228406; x=1724833206; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdhYZISuTETd5XZ8LEV8qzxmVjQjEonrE8b5iyMQ2ws=;
        b=Ro/kHWz+hp8nlcxiKa/SW8ZYcHNaw1Lw4gcUPqtMHSTbc+7dOlVMloufpbOYwy/RKb
         znYZnC2oiZ0oNpCtTdiLR0scBz9skeD+PI7BEg8xd7iC1HB8lfad7q1QezJN3+UpRIkD
         2Sr6NoezRkHwHCYMtrrPUGGnRulWEbuA2D4rC7pQeI6nK3Fh5i/67Zqt/hedVaWA1ntr
         Z5gOmV75rOj7L65EF5IrBRNVQVwjaYffb5YzeK0aH7mF634skHa6DZZgVNm5vVWNyhqF
         GLb87lPO0MuHm/5IjxqXQP2Xh9FaBPRcXnHqIrg8lZd+lFD+qBE4DQQuCWFr7ZnUZfWq
         FQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228406; x=1724833206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdhYZISuTETd5XZ8LEV8qzxmVjQjEonrE8b5iyMQ2ws=;
        b=i3BCjnkjgT48QfZTMNjFpqNlQUElV12GGJLwj0SLXUrFMtqnQEDTiE0BoizTs6JhAg
         36L2D9pp9D7Wsg5JkMqhVQUvKFqP8+jebmufvMtUTW7BgszRczEPHygs1DItuefrp/nk
         Dk4J9ygJzeE4BH4HyZgEEzKWReheEbczdZNnC8UmppCqfZ2GufJPK9HZIHiZDc3QCWmv
         xZ+5U2B/Oc0qGwmpFuRMhpDRN8hB0mSK31QdzdWDfr2zP8gbyYuYia8J77hVvMLc5Otu
         LKv8/4B4F/D4PLvaCQnVDH5hTobL1GIBLhyJZzEhVmMGQppBQueCtfwWe8v+1DDPgdsG
         UX0w==
X-Forwarded-Encrypted: i=1; AJvYcCVwPQ3lVftL99bw2iSiHqoZP3QZM0pwtrc9DjfmDKbXY/+8C27rJmZZFLfDLxqiZphS9KoEhn7vFbrKigDuXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpQmvRmh6Elo1xj+F+JORBSKNxiTCjiQTCU5vy/2UzX+x6YBVB
	IlOuuYWxFNsrwmvjVb7yNwWbBZslE2vP71HI+mqqGFgkjy5nA2I5WaZYcuf5pnchQflyuXryVf3
	K0iPPK+ZHeeCqZMtqHQws4tjQqrU=
X-Google-Smtp-Source: AGHT+IGy365Pc9TKJF5GAK0armKU9Hpgj1dovYSvRFuHJ1yV+fMbVBAOtQzki539dYAOujtFA/EPC2D0nPczB6xkNv0=
X-Received: by 2002:a2e:854f:0:b0:2f1:67de:b536 with SMTP id
 38308e7fff4ca-2f3f8890618mr10493191fa.24.1724228406003; Wed, 21 Aug 2024
 01:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240821071842.8591-2-pstanner@redhat.com> <20240821071842.8591-10-pstanner@redhat.com>
In-Reply-To: <20240821071842.8591-10-pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Aug 2024 11:19:30 +0300
Message-ID: <CAHp75Ve13TpA+OdUbiehZORjbNEi9qjJK3bg=C5CscoC=G=f4Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] vdap: solidrun: Replace deprecated PCI functions
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
> solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
> things because it forces usage of quite a complicated bitmask mechanism.
> The bitmask handling code can entirely be removed by replacing
> pcim_iomap_regions() and pcim_iomap_table().
>
> Replace pcim_iomap_regions() and pcim_iomap_table() with
> pci_iomap_region().

...

>  static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>  {
>         char name[50];
> -       int ret;
>
>         snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));

Shouldn't this be also devm_kasprintf()?

>         /* Request and map BAR */
> -       ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), na=
me);
> -       if (ret) {
> +       snet->bar =3D pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, na=
me);
> +       if (IS_ERR(snet->bar)) {
>                 SNET_ERR(pdev, "Failed to request and map PCI BAR for a V=
F\n");
> -               return ret;
> +               return PTR_ERR(snet->bar);
>         }
>
> -       snet->bar =3D pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
> -
>         return 0;
>  }

--=20
With Best Regards,
Andy Shevchenko
