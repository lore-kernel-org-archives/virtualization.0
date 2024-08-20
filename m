Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB814189F4B
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141629; cv=none; b=IsRrk2VgmwtcrWULFGg9IfPetn3KMsnHVkgjTQu3gXwMu5pnUoxQ+A5GIGAK438qYLXBVj487tGfxGCcGNbyoCTpyrg6nb4mkorvQcZ2j8qkd+wkZiDuwQ+hS/kOT6V+DFWhtvYEBEiciYzVtvpZkT0BYqjIASQqZPmwuR8I+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141629; c=relaxed/simple;
	bh=5x2Zwvil69v7j2QTmo/ru3l3YhUvaf/XafPWpjOjfD8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPsxRJOqzHlLwqtxijrLqPcSehieRHtHc7HT44WXS3jDwd2KcHGYl0rSgcbCwHwBiuiVMowG2LZRDki5jHB78g8dxNGQh1YJf5eYP9bdpOZTKJgykdGNmvB+Hn0km12QVFLlYH9CtCVjhL+P+jfbdu86GacvJMqioqH9Z3lBZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+ZmSPrW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+ZmSPrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724141626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5x2Zwvil69v7j2QTmo/ru3l3YhUvaf/XafPWpjOjfD8=;
	b=V+ZmSPrWuPW6iLzzX/1uzcNwn98hDSrf6VhFntnNxB76lX0aWT4ijx7J/jymC2ubpNZoSc
	S+b3c5MZ348SKGP2k32ka4MpVzVZtZng0TyzFIh+Ta/wL9DolYpmYLiPrNL/2iNRMVE0dJ
	RpN3S3RxZZugSzgnHCeCxk/5URbfDM4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-4-9EtGCeP0e2zUSx1kA4aA-1; Tue, 20 Aug 2024 04:13:44 -0400
X-MC-Unique: 4-9EtGCeP0e2zUSx1kA4aA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52fc215b7f0so593812e87.3
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 01:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141623; x=1724746423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5x2Zwvil69v7j2QTmo/ru3l3YhUvaf/XafPWpjOjfD8=;
        b=v8B9CjEBq9zpbXl2lVl6yyjn1UPhkLYPj2sheE06HfyMH8Ve66rms8nSjlOXfotyv9
         Irkx8sUA1j85bZkBADTzFHHsi+mfsrlfB6CBsHWUnf7ySnpi82jdlDUEHvyXunMPdZfl
         t9Bybyn00Me8E2ct2HbAol4ivw0+0YHscsU7ZHCMYwPfq4a8yrPu0vxjyJQZXF+Dxffa
         g98O4Tt1C5uce2yIngSMLJA12NBx0TgjVDLs+XYdA6rulYib3B32XXUOT8fHbNLREkF+
         Sc9tcQX4VHkxvbuVh3xWcaMqmjRTBnpV3gudBaJB+Y/OM2RVTBAwWotjNIVH5lmXPMcW
         b7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWDOryuDASVuISW0JSSRUUy9k1tllZZwEZP417eMN7ZN0iwfsfRVZVHXzE2qBi0EYIPtiGs5kkBHg4/lkMEzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTrgCUQmoA6A+iKhO5LISR3jL7jxr5vHHikdE1DuNorxwVdHdE
	IlrUBQsCGMq51XjZwuREUie+qres86pkhMEvJcYeqCc34VbcyN3rDemEcR0ARwkrYZxwHS5PwIT
	Ba3bAAd4gst63UBs2YlLf1W69NCZ/SGYaXkcgv4VE/X9uPs1p0xSMOOBRtqiNB69e
X-Received: by 2002:a05:6512:10c1:b0:530:e0fd:4a85 with SMTP id 2adb3069b0e04-5331c6d4a61mr5183740e87.4.1724141623058;
        Tue, 20 Aug 2024 01:13:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZQZIXMi/Gkd3uNyVjKj7Xpsxjs4S0/m1lMVeXOF/ppQ1u+jlQhYOCzCKjOM9+Rw34AQB54A==
X-Received: by 2002:a05:6512:10c1:b0:530:e0fd:4a85 with SMTP id 2adb3069b0e04-5331c6d4a61mr5183700e87.4.1724141622413;
        Tue, 20 Aug 2024 01:13:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935616sm724162966b.123.2024.08.20.01.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:13:42 -0700 (PDT)
Message-ID: <419e91cb2b698a450497dfc1fb86f2c46eb7d8fb.camel@redhat.com>
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>, Christophe JAILLET
	 <christophe.jaillet@wanadoo.fr>
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
 Brown <broonie@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-block@vger.kernel.org,
 linux-fpga@vger.kernel.org,  linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 10:13:40 +0200
In-Reply-To: <ZsOQPbVGQFtUYSww@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-10-pstanner@redhat.com>
	 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
	 <ZsOQPbVGQFtUYSww@smile.fi.intel.com>
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

On Mon, 2024-08-19 at 21:34 +0300, Andy Shevchenko wrote:
> On Mon, Aug 19, 2024 at 08:19:28PM +0200, Christophe JAILLET wrote:
> > Le 19/08/2024 =C3=A0 18:51, Philipp Stanner a =C3=A9crit=C2=A0:
>=20
>=20
> ...
>=20
> > Unrelated to the patch, but is is safe to have 'name' be on the
> > stack?
> >=20
> > pcim_iomap_region()
> > --> __pcim_request_region()
> > --> __pcim_request_region_range()
> > --> request_region() or __request_mem_region()
> > --> __request_region()
> > --> __request_region_locked()
> > --> res->name =3D name;
> >=20
> > So an address on the stack ends in the 'name' field of a "struct
> > resource".
> >=20
> > According to a few grep, it looks really unusual.
> >=20
> > I don't know if it is used, but it looks strange to me.
>=20
> It might be used when printing /proc/iomem, but I don't remember by
> heart.
>=20
> > If it is an issue, it was apparently already there before this
> > patch.
>=20
> This series seems to reveal a lot of issues with the probe/remove in
> many
> drivers. I think it's better to make fixes of them before this series
> for
> the sake of easier backporting.

Just so we're in sync:
I think the only real bug here so far is the one found by Christophe.

The usages of pci_disable_device(), pcim_iounmap_regions() and the like
in remove() and error unwind paths are not elegant and make devres kind
of useless =E2=80=93 but they are not bugs. So I wouldn't backport them.

P.

>=20
> If here is a problem, the devm_kasprintf() should be used.
>=20

