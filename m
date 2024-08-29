Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0571A3BDD
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943000; cv=none; b=tYaMOzEPIhW4L9/1ijzxgQG0Ti/loyGvq4R872Si3GsrmBnR1SPT7ScfhlwcAXM9thPspBwo2IPMoI6EQBlx8yM9uYbAh390GxVDx13Cc2upPixpuwXogcIaoEYUdeCUJ0axaC+UnVd1CRu+qvMyELclxQx/9t6GMzNe5empks0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943000; c=relaxed/simple;
	bh=S2sT6L9UUzta00cejZJS50RWMrLlQc0scK9J+l0UXXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAEj8Xzu96SHpTPcyDDN+3/r1+8HW+IAE/aTKg8hoc7Iof6jjNX+eqgNS+6rJFCX5q3CYZLFp+jOa49/38SHaNofwRCjF7UKzCiyZrf2jeJZFseLHJ1AD7j+pvEUyspJm0WGqMvTDVfQLponI8R/awHVU2es31Q8ggmOCDxzHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eA2/LinP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA2/LinP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724942996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2sT6L9UUzta00cejZJS50RWMrLlQc0scK9J+l0UXXw=;
	b=eA2/LinP/DXAdWp+P/u5Ma1iSWB3zM3SKuUcSPq6R+hyWbO+LVRNljFejIH5j35ixTDoze
	haUmP/l6sKRDgRivHydLTpeMxsB9HBxUa10H2erl/q+ofJJ9iQhYccWKwcQpVvofH5IXiM
	ZgM1FBzuAzGjgo+dFkIFiZb/FxMWZGs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-V1f7mncFP3Oy8bbddHSUtw-1; Thu, 29 Aug 2024 10:49:55 -0400
X-MC-Unique: V1f7mncFP3Oy8bbddHSUtw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371b187634fso835269f8f.0
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 07:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942994; x=1725547794;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2sT6L9UUzta00cejZJS50RWMrLlQc0scK9J+l0UXXw=;
        b=nFO2GoHU/gQ1pC3AC25sTVm23WvWi00WLTbUlZI59lMBl/SINjx2Uhsf5roZlKS5ZQ
         DDBgjPCrBvFqh9S5XTtBaqOkNRiW+N4NnIbLySpwZ4Be4i3ZOeZ5iu6Bbbs2zVxAflVF
         +N1Z3uc08HQEOctfKF/aNn9RjKd5WfaJ2PfQJNed73vgY7qMlaXi7sRVkBfuZDENFfn+
         wnvEoy3if5RC1x2N4anGBFJvth89pT11PlKc9xMieLakVwUyhQtYwMtFcsu5yb7g5xUQ
         Zg8BoBG45FKEpAZteOkkCRZCNdfrerg8CZ1iczDVNKmv2B8mrq7unt8qO7kP5tEmt7HK
         hhKw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFfEbwaqLgj2LlQcTNSYq8agaOwYuLNJGqcjQF/az5JFyeFW7bZHh6idn4hqVLf+GINP5OpLDYAFRPUZelw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTaVFMjymgKhctnBvvTbtEUAb1URf9RkSSuJyhnlCjOy5lnGtt
	sU3H4OL3B/SVFdfrHs3/TmY2DTZK9ikhfXnpaL5ugj5qHlIB2xmc3SyHzxn1DbbiRu1nsyGZLNt
	nt4Zts51wDnxN2cUkrlH7I720FjV4iKVXX9Fr8AVwX6mlBcxMUFs/drzUSiAEDG5o
X-Received: by 2002:a05:6000:d90:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-374a02323eemr1808472f8f.25.1724942993929;
        Thu, 29 Aug 2024 07:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrfaIGeH0p8et8OYjnOCquSTWs4QXgyhcRTReJhUV0MD6wVymReUMbJDmaEmmHD/MIBOPsJA==
X-Received: by 2002:a05:6000:d90:b0:362:69b3:8e4d with SMTP id ffacd0b85a97d-374a02323eemr1808372f8f.25.1724942993389;
        Thu, 29 Aug 2024 07:49:53 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf7fa745sm33827915e9.31.2024.08.29.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:49:52 -0700 (PDT)
Message-ID: <2cc5984b65beb6805f8d60ffd9627897b65b7700.camel@redhat.com>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 linux-block@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,  linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
 virtualization@lists.linux.dev, stable@vger.kernel.org, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Date: Thu, 29 Aug 2024 16:49:50 +0200
In-Reply-To: <20240829104124-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
	 <20240829141844.39064-7-pstanner@redhat.com>
	 <20240829102320-mutt-send-email-mst@kernel.org>
	 <CAHp75Ve7O6eAiNx0+v_SNR2vuYgnkeWrPD1Umb1afS3pf7m8MQ@mail.gmail.com>
	 <20240829104124-mutt-send-email-mst@kernel.org>
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

On Thu, 2024-08-29 at 10:41 -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 29, 2024 at 05:26:39PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 29, 2024 at 5:23=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> > wrote:
> > >=20
> > > On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > passed to
> > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > string.
> > > >=20
> > > > Should the string later ever be used, this, consequently,
> > > > causes
> > > > undefined behavior since the stack frame will by then have
> > > > disappeared.
> > > >=20
> > > > Fix the bug by allocating the strings on the heap through
> > > > devm_kasprintf().
> > > >=20
> > > > Cc: stable@vger.kernel.org=C2=A0=C2=A0=C2=A0 # v6.3
> > > > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > > > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > > Closes:
> > > > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wa=
nadoo.fr/
> > > > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > >=20
> > > Post this separately, so I can apply?
> >=20
> > Don't you use `b4`? With it it as simple as
> >=20
> > =C2=A0 b4 am -P 6 $MSG_ID_OF_THIS_SERIES
> >=20
> > --=20
> > With Best Regards,
> > Andy Shevchenko
>=20
> I can do all kind of things, but if it's posted as part of a
> patchset,
> it is not clear to me this has been tested outside of the patchset.
>=20

Separating it from the series would lead to merge conflicts, because
patch 7 depends on it.

If you're responsible for vdpa in general I could send patches 6 and 7
separately to you.

But number 7 depends on number 1, because pcim_iounmap_region() needs
to be public. So if patches 1-5 enter through a different tree than
yours, that could be a problem.


P.

