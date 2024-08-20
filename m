Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD6149005
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139618; cv=none; b=JfqwjNiHjR7OG8H0/bhlMVaD8VeBzxrONUxthqZznvhrToFjxw0V/ij6pXj0rBfRDyA48pa57k/O+oWDZS1BfFTpo6p4CbAkCzOJQ9I7FlWPFvxAuz45toRGTEGG9iB+AvaiEeS2/W+/1C1PEgsJHenPEMQv2LqK5GGulb2znDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139618; c=relaxed/simple;
	bh=O375hKLRtHWXaobV9o40/HHIx3SHwITf/9oOBuwIG90=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgpjJJU5ufusiHJmdujrbOzOo4RNUb/1KV5fC+EWgmCn7pB+EhZyeH1Oe8FOpmsJrShWdwMGQwOgo0HE1M2BjYPQlaIxM5EBSjC9igjpNQHrADlrjw2JfHcBs53ZrFzdKjbXLeCIaBJh8eeY8Xp1bA+MEZAY8S6Z8qy6Ts8KE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDNuGtz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDNuGtz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724139615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxzUdmNZBc9jEjirNcUdJ3a5fT7IPVhG9RuosEJ8BVw=;
	b=PDNuGtz3It2a/stSCkZ37bwZN9bWQce22E7/9PSMP1I3QwzzKNpsusIKdCV9rkmApmwEhT
	BHrhWZLTCnYe3/HIpBny0QnTVYa3T9WcZzEViEidVTkaaxCVtFWcYwlBEniSBmhRHDIpZS
	4JDHoHHagwoOel9S3qZlyLUH+fKu4KU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-KxzVJTvxM1qJxLHglYbhrw-1; Tue, 20 Aug 2024 03:40:14 -0400
X-MC-Unique: KxzVJTvxM1qJxLHglYbhrw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef2b4482e5so5173761fa.3
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 00:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139612; x=1724744412;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI6kfa5oLV045Jmdu7a0CojUb3GQJzHs7H4OiymNEbE=;
        b=E9zVOyJtlFWqvMIDW4+TsBrBMQMeCTsi+frn8bdw7+DYpbqkEWXytLLOOIIZ/R8WGw
         QdQSEp/iXH6u0+TkytkOBawYuvkDd2IK3KoeRnMQGijbgNeRS1SnIDa5p2oVRB9r1h8m
         ytinPloi44s+tTJoiYcKuIC3I/yw6Tzs2jfyK+PJTarwnJS/amncyRH3QE0R2PB3Xmya
         3m9LQ1+poY3uesWrv7lJH0oCrRpABP8oLuaWdRA+FWdGPDrlx7RE8BCN5ApnkXIobuuY
         a+wauxe69B3x/0a+62IlF1D0xffdKHmxEnPhCG5HZtZHBPNSQu2zF5BrfQU7gjkVMMgt
         bGUw==
X-Forwarded-Encrypted: i=1; AJvYcCUcBs+MkrclVHKn9j5+3xDHgwXVNfdFA4dsw5BUTQwmVAltYP1K9L9GqlAab1+xEvm244/uPpGWWlMdK7/0Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsixgPxAIbiHUPfBb2PuvJ7N6+/lV2HemKZgdjvTr5otwpOSq0
	yMt8t4SQfizZlj/7Kw+VaZbuWNRadzJZjUy2NAKqQUFc8EI1PsgQwx0d73rKKYh075Ld11/InJ0
	jhcZ+hyLSc5pdqPBXeKLJgLYOb6/EgRcT+t5NcJDs4aPY53xQUWysCmO8q4ZwpElo
X-Received: by 2002:a05:6512:3d04:b0:52f:c0dd:d168 with SMTP id 2adb3069b0e04-5331c6e53bfmr4778909e87.7.1724139612398;
        Tue, 20 Aug 2024 00:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuY9Bjt5iBWcm2YKpDyt42mNkBOnX16tyh4gc9tacJQihXtDb0AW33sxGPjl0kWgtMyZPzMQ==
X-Received: by 2002:a05:6512:3d04:b0:52f:c0dd:d168 with SMTP id 2adb3069b0e04-5331c6e53bfmr4778883e87.7.1724139611750;
        Tue, 20 Aug 2024 00:40:11 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm726051366b.100.2024.08.20.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:40:11 -0700 (PDT)
Message-ID: <5d70794731198ec7bc59bd95e50a8aa81cf97c7b.camel@redhat.com>
Subject: Re: [PATCH 6/9] ethernet: cavium: Replace deprecated PCI functions
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
Date: Tue, 20 Aug 2024 09:40:09 +0200
In-Reply-To: <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-8-pstanner@redhat.com>
	 <ZsONiNkdXGMKMbRL@smile.fi.intel.com>
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

On Mon, 2024-08-19 at 21:23 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 06:51:46PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with the function pcim_iomap_region().
>=20
> ...
>=20
> cavium_ptp_probe()
>=20
> > -=09pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
> > +=09pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
> > =C2=A0
> > =C2=A0error_free:
> > =C2=A0=09devm_kfree(dev, clock);
>=20
> Both are questionable. Why do we need either of them?

You seem to criticize my pcim_iounmap_region() etc. in other unwind
paths, too. I think your criticism is often justified. This driver
here, however, was the one which made me suspicious and hesitate and
removing those calls; because of the code below:


=09pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);

error_free:
=09devm_kfree(dev, clock);

error:
=09/* For `cavium_ptp_get()` we need to differentiate between the case
=09 * when the core has not tried to probe this device and the case when
=09 * the probe failed.  In the later case we pretend that the
=09 * initialization was successful and keep the error in
=09 * `dev->driver_data`.
=09 */
=09pci_set_drvdata(pdev, ERR_PTR(err));
=09return 0;
}


So in case of an error they return 0 and do... stuff.

I don't want to touch that without someone who maintains (and, ideally,
understands) the code details what's going on here.


P.

