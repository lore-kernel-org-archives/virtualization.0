Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99116B3B7
	for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243169; cv=none; b=SLe4wIbb8I3VoHkZ/YbY9GYn1zZyFLB7XWry+0GcPXWFhGH3Yrb83nuWtAjsJRqi/JUcCCLjntLVYsMMV5LIEKBlGBVVzERoZR9lIpExzQ6A/xhp3/ONccxXK/7Z6tcI9De9ibuxWrRjqgQThfwdXo/762zkwe8pH0bIR46iwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243169; c=relaxed/simple;
	bh=kW2VqGrolN/VEoRIr+pu9F37y2nTmIqDv+Snge4AAqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFsZm33hmtfWQqyFLz5kD/0vUZZyjJGqKYmy2wnuXDG6TnhhAG7u0PqpUGg2CtLsL6OSYLob+Ww3lX5ZfpZ5Iw5lPM3FebU+43/UqfIELK2mnnUuvOfBWpKkrHs61ZPenAYK8p6XXEW/Q8QvR7EdmcS+OCkz82YrIiz6oIv4mQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/qZqaCS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/qZqaCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kW2VqGrolN/VEoRIr+pu9F37y2nTmIqDv+Snge4AAqg=;
	b=e/qZqaCSvFNCWfptF/YkL18R0ShKsiuqGE6cOjxSlyMuIbgKEEPxci85tJccc+diT8KLV5
	/L7WNPLR3BgH9VlzOEm4/S2hxoMe5h7GG1v26hLeFRx8O6vdw0aFDtI3yeslQoVwTE4a+e
	SwlbnvYwb2UGk6xz3V9EiRyhXG/+F48=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-IVHzILHUO-GYzQE4pWo8vA-1; Wed, 21 Aug 2024 08:26:04 -0400
X-MC-Unique: IVHzILHUO-GYzQE4pWo8vA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6bf8d9867a3so42566476d6.1
        for <virtualization@lists.linux.dev>; Wed, 21 Aug 2024 05:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243164; x=1724847964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+8Zd9p9xEaFFxq9bSwT6CVTjqvDBBcELEezra/NBmQ=;
        b=d58PCkwu/j7xfsMoTS6RloavLZ3t0opOkbncSb+fTfg5qA/FxR8web648+KHEPvOAg
         sX7Ncbn5E1FoZSXB+QJ60JzK1dB4WQfZvzs3JdPW9NO56b9Jc6G2xfHqb8pCtXYsn+UX
         vU22cGHjJ9QQrVy+FjwD6pd/H9kpQykvIjoaLfA/251RAXC9aBEtiwb0Rfc/4bPwaUOZ
         rI74sdEA1qq23bRGt5FSH3CdtnfWXf6bjCOD8+AhCJunwD4mvT154iCgWQg4RAX6YrmT
         xNCTeFkUBv/XWcZ6hhqntMsLhRkWYguYnBnPfOFBpHsd3lU1JMcDVRMxIlhlxFntyTG7
         iG7g==
X-Forwarded-Encrypted: i=1; AJvYcCV9NQNCrIHTc27sMrqjg0INsiHIK2gvHFfLt5c33EeqvsMlOhAhbAkyAxbAIJkdfC3c0fDczN8T7p32g0d3yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX0uXRqSf73KDOe6RErw2dSlEmrsTQbEWNctr0VTlbiguc4162
	pWoZxplV83kfGhtPSOI4V+5/Dbj8+Bg5VeSpXXDT3ndGP8bE6OYoi/6jTA2dieiwtYdf5FF5OTt
	9/iJMErjZN240X1ZnFMPU1sGbHPLEwdUjXRZ5jOXEQwCSYUnaVLeYvlc/MljyA/SX
X-Received: by 2002:a05:6214:4881:b0:6bf:a721:9945 with SMTP id 6a1803df08f44-6c1567fabf5mr30554726d6.24.1724243163962;
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0sBOMGGLa2XcF/yRLMaOTYNrH07fkAWiC1e2c/uh8oASqBZoK+O1goCyf57ZnaX9oaF0YiA==
X-Received: by 2002:a05:6214:4881:b0:6bf:a721:9945 with SMTP id 6a1803df08f44-6c1567fabf5mr30554416d6.24.1724243163535;
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0dcdasm60220946d6.140.2024.08.21.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
Message-ID: <cf9591d720c9b25dafd46b627ff8b6ed9f417745.camel@redhat.com>
Subject: Re: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev,  stable@vger.kernel.org, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:25:57 +0200
In-Reply-To: <20240821081213-mutt-send-email-mst@kernel.org>
References: <20240821071842.8591-2-pstanner@redhat.com>
	 <20240821071842.8591-9-pstanner@redhat.com>
	 <20240821081213-mutt-send-email-mst@kernel.org>
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

On Wed, 2024-08-21 at 08:12 -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 21, 2024 at 09:18:40AM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() a string later passed to
> > pcim_iomap_regions() is
> > placed on the stack. Neither pcim_iomap_regions() nor the functions
> > it
> > calls copy that string.
> >=20
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have
> > disappeared.
> >=20
> > Fix the bug by allocating the string on the heap through
> > devm_kasprintf().
> >=20
> > Cc: stable@vger.kernel.org=09# v6.3
> > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Closes:
> > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanado=
o.fr/
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> I don't get why is this a part of a cleanup series -
> looks like an unrelated bugfix?

It was discovered in the discussion of v1 of this series.

It indeed is an unrelated bugfix and could be merged separately. But my
patch #8 depends on it.

So it would be convenient to merge it into mainline through this
series, and have stable just pick patch #7.

Or should it be done differently, in your opinion?

P.

>=20
>=20
> > ---
> > =C2=A0drivers/vdpa/solidrun/snet_main.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index 99428a04068d..4d42a05d70fc 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -555,7 +555,7 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > =C2=A0
> > =C2=A0static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > =C2=A0{
> > -=09char name[50];
> > +=09char *name;
> > =C2=A0=09int ret, i, mask =3D 0;
> > =C2=A0=09/* We don't know which BAR will be used to communicate..
> > =C2=A0=09 * We will map every bar with len > 0.
> > @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0=09=09return -ENODEV;
> > =C2=A0=09}
> > =C2=A0
> > -=09snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > +=09name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > +=09if (!name)
> > +=09=09return -ENOMEM;
> > +
> > =C2=A0=09ret =3D pcim_iomap_regions(pdev, mask, name);
> > =C2=A0=09if (ret) {
> > =C2=A0=09=09SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > --=20
> > 2.46.0
>=20

