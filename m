Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89070189B99
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140370; cv=none; b=ST9fkpaivo1Me8UNZ9goKg+3FeBO5/Y9DY52sSD9TN9Wt0Kd9XnL/czUHCVYQXRopBy0/Oyr6PH9qa7TpEPYNPvO4+0IdqbpZynvqTxbC7BH0YqP1O3e9DpPFoFjW1bSvS0hcxWftdv5Q+K9U2D26qtEz+NiJ7RaMdGC5Iksvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140370; c=relaxed/simple;
	bh=E3moRxRTX6JqCQ+Nk3VGwB60d7xMCZ9uzBRro5gwz1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr3KrSlNee9hXVWXkcHj/ANi/FFzKcOOdIiA0q/A9Ukn++Qqm7YQGMLRWC8CijyrUquMVVqY85oyvTMvr4MN031hAe6+oq5auiN4kPajJzmRU8Ga3WwziP2W1W+xWgf1hVbzIgjxzbBdpPp+T7Pa5esqhQV0OZPhRivZV3cHObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+6m0JY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+6m0JY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724140367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3moRxRTX6JqCQ+Nk3VGwB60d7xMCZ9uzBRro5gwz1k=;
	b=d+6m0JY5GIZKNkQShlnGnQCpY6MRF3PzrBcoPNrK3LB9vgb8ej8HBJ++eIZqKSX4mPbhcO
	kU9XQ23xWceTqa7Seg0Ap1liBnSszGWmOT1dwch9g23f3QbKkOttjC5kmX2KVjSsLYLBsm
	Zo6oPGkuo0Sm/LPe+jlbRPTjhwjRXFg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-H4WBfNCuPgqBEjSVhPgCag-1; Tue, 20 Aug 2024 03:52:44 -0400
X-MC-Unique: H4WBfNCuPgqBEjSVhPgCag-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5beca778be0so657009a12.2
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 00:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724140363; x=1724745163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeiSyPiPKmNnwOfGWuoS296+qVzydzMPMNriUvsyur4=;
        b=V5jGnHi4uyc7WIhCN8ONl63GtW+1ZVrBnVhKIZdecnyUYsYHE8K5J2NaQwCCVXCQUF
         iIL/QM9KWDCL8ElQIYyW86heyBU/JIqNIyQ62ri6nOxJrYCgQm+CMubgrF9HkH4gYf85
         mGZmcpwbb84+Q7yVlq5HVp2Yi1+fqdId6gvyogrgdBAL2/iQNGQIthrB5a9wprAQ1lEK
         yljfnHhcqXYwxfIUPE6i5b2AazGby3H/7NQZXlr9RLTeSY0qMjO3FRfZPkIJaQP/p3/Q
         82AK59DfOeROs94wXJAFqt567HZGw/BbNxcwZVfRufBEY57NgHx+1mtbQJAgpGTFV5/s
         ys6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhuGyxEHMS6K6OC7htK7ZALs9hq+w8gkcrv3JwbYGfBtfS16dkh80jqvmkKWx9K7wFLe8cQFBDywCXnw5L3F5vCSSBjZ4WfRX/cVn6EiQ=
X-Gm-Message-State: AOJu0YwLmsrHjs/MFSpBjKzvT6Ge+kajWdDFyKotNPTSjIBBcBMNF/d0
	jJ90Nyd/LDXvAwQQfbrYmPBG2usFnDghnYVYxfxMIO+MOaUdLF6e4HtB9cRPIqc2FIeDp1sG2Lw
	2FQqhiWMj/j8WlGFHmdr8Cms/Tnsn8BghY5DBX1A54htwIuAdUfG4THOupwsBgkhn
X-Received: by 2002:a17:907:7da8:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a8392f0f09amr559789766b.8.1724140363126;
        Tue, 20 Aug 2024 00:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCcSzDTDTcLcwJLqj7qP91xXOb0HQ7Ix0WDiy6h5hU0b8EQrJaBGayIlt+2svr7xzZZtOaow==
X-Received: by 2002:a17:907:7da8:b0:a7a:a33e:47cd with SMTP id a640c23a62f3a-a8392f0f09amr559788066b.8.1724140362524;
        Tue, 20 Aug 2024 00:52:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946973sm722531566b.160.2024.08.20.00.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:52:42 -0700 (PDT)
Message-ID: <ef48369d230ef1912da157e7b437040bece6b5f4.camel@redhat.com>
Subject: Re: [PATCH 7/9] ethernet: stmicro: Simplify PCI devres usage
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
Date: Tue, 20 Aug 2024 09:52:40 +0200
In-Reply-To: <ZsOO2uuGmD97Mocj@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-9-pstanner@redhat.com>
	 <ZsOO2uuGmD97Mocj@smile.fi.intel.com>
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

On Mon, 2024-08-19 at 21:28 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:47PM +0200, Philipp Stanner wrote:
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
>=20
> ...
>=20
> loongson_dwmac_probe()
>=20
> > +=09memset(&res, 0, sizeof(res));
> > +=09res.addr =3D pcim_iomap_region(pdev, 0, pci_name(pdev));
> > +=09if (IS_ERR(res.addr)) {
> > +=09=09ret =3D PTR_ERR(res.addr);
> > +=09=09goto err_disable_device;
>=20
> It seems your series reveals issues in the error paths of .probe():s
> in many drivers...
>=20
> If we use pcim variant to enable device, why do we need to explicitly
> disable it?

No.

>=20
> > =C2=A0=09}
>=20
> ...
>=20
> loongson_dwmac_remove()
>=20
> > =C2=A0=09pci_disable_msi(pdev);
> > =C2=A0=09pci_disable_device(pdev);
>=20
> Not sure why we need these either...

It's complicated.

The code uses pciM_enable_device(), but here in remove
pci_disable_device().

pcim_enable_device() sets up a disable callback which only calls
pci_disable_device() if pcim_pin_device() has not been called.

This code doesn't seem to call pcim_pin_device(), so I think
pci_disable_device() could be removed.


I definitely would not feel confident touching pci_disable_msi(),
though. The AFAIK biggest problem remaining in PCI devres is that the
MSI code base implicitly calls into devres, see here [1]


P.


[1] https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.ca=
mel@redhat.com/

