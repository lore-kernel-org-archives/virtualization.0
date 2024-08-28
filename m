Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC015852B
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829058; cv=none; b=ml27ughImotizoegv3VLnDghG9Hw9/l2R7Tcmo8HuAijYfFUCDzxW98hgufCLo/iG492CfBhOaPN3dDhvAN4gFSXM9Z/N2a/XcuHdyxFaSUHeqhOZA6n1h2F0QVH596sfrYPVjwUctP1khPg3K8ijTeHw9hAPEnxD6c69sZRWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829058; c=relaxed/simple;
	bh=pmQdugeSVJzdPfSK+DQ5I6vzgJd8Kkaetn+H9sOQBKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEc1sCLDoXlS5UEbS/n6tHsPrjLrf6enAvFBxssaQmrcUsdF5f3r868uLTP6rIe3v7zXGA8tUI0uO4B/J5tORdRifLynpqjhPsPPrMATlsWSDM3f1JRWgQWcBFGbooqO8MU08Msj2v0YTg2P0xnfW21nAJeHD3LlTZAQF9IXD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBph+R7P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBph+R7P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724829056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmQdugeSVJzdPfSK+DQ5I6vzgJd8Kkaetn+H9sOQBKE=;
	b=cBph+R7POZtmk0riT821G32saoxi5Kvv74kGT8Z9MrYThCxogqdSdhK62rkQUYUHlhKxDq
	Txp41zfpu4Qs178KG4urSnr8QbfKCwzvPPrR2MF1V1GvtpgCS1lmxbZEfVhk3acLfGasnF
	8p3Grrv5Gfn8fjDx7QzyroiDszBLsiY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-cDIBEButNDi_RiHewSLEWA-1; Wed, 28 Aug 2024 03:10:52 -0400
X-MC-Unique: cDIBEButNDi_RiHewSLEWA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1df9ced6fso965490985a.2
        for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 00:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829052; x=1725433852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4exFj43hWLT00BAGeYDHEqubvTOHjaJM+W+ukum/0tY=;
        b=nC0WPdKLFa2sj+kF0pSCXUpRzRK0jSye4k6IHFWkeJZaThJaHRBjydQU8eamj9lGjp
         7o0vZuVzZiN8P61f4JKg0JrqpPR/FHzVCAyewqcQS7WlDMETB46khUpSdLeJVDkfUaBT
         XxOovL0ANrjK+su3wIU4Q2bjL3H/hXIrZilV+2Z2yjWO/jJdUEfReXvocRd7SuinAqvw
         raa1Su3DGUOiZG7D7xyPO37rpgZJBGoTXoTu0UQz3Ze7loC+6iQ1vuUFsiPLFoBcnSeQ
         u6AahS9NISQR14inGAzrkXDXLp52vvHk5BTM0XQ4XaxTEo1liiQWBX3r/WZ6a8OynnOi
         eHSw==
X-Forwarded-Encrypted: i=1; AJvYcCVIEd4/xUEuuwE3w3lo1KQyqDiDMgzG+RkZu4OWoLcfUxu/pO4SJ/8llKCJpn3KTlqeKQwclQrheIdo3tmljQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4pW9PkuT4DpbTo7mwpgVQQvzQxbZd1PVwF/Cb7tqJkLajZsCG
	Oj/gxFZ+wr1MYOrSScwXyxmZ87SwLQxmam05UeVRE9DVMTG1Nr6znoioIsGOkV50Eq0kWCkbrKB
	IRH7J+53SzRMuPQ0hoaPtqpwjIiFjqUXTledQWE/bMJk5h7MqMiT74bhyWogh1Rv5
X-Received: by 2002:a05:620a:468b:b0:79d:6276:927a with SMTP id af79cd13be357-7a68970207amr1677959885a.22.1724829052400;
        Wed, 28 Aug 2024 00:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoJpkEEQicGfWPZT1lOW4zceJ6tHVmY2Rb8P+ysJBwyYwzs7rm3IwCsm6DsOeUMwreCEmk+Q==
X-Received: by 2002:a05:620a:468b:b0:79d:6276:927a with SMTP id af79cd13be357-7a68970207amr1677958385a.22.1724829051978;
        Wed, 28 Aug 2024 00:10:51 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f319050sm617950485a.11.2024.08.28.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:10:51 -0700 (PDT)
Message-ID: <189ab84e8af230092ff94cc3f3addb499b1a581d.camel@redhat.com>
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Wed, 28 Aug 2024 09:10:47 +0200
In-Reply-To: <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
References: <20240827185616.45094-1-pstanner@redhat.com>
	 <20240827185616.45094-4-pstanner@redhat.com>
	 <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
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

On Tue, 2024-08-27 at 13:05 -0600, Jens Axboe wrote:
> On 8/27/24 12:56 PM, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > In mtip32xx, these functions can easily be replaced by their
> > respective
> > successors, pcim_request_region() and pcim_iomap(). Moreover, the
> > driver's calls to pcim_iounmap_regions() in probe()'s error path
> > and in
> > remove() are not necessary. Cleanup can be performed by PCI devres
> > automatically.
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Remove the calls to pcim_iounmap_regions().
>=20
> Looks fine to me - since it depends on other trees, feel free to take
> it
> through those:
>=20
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thank you for the review.

I have to provide a v5 because of an issue in another patch. While I'm
at it, I'd modify this patch here so that the comment above
pcim_request_region() is descriptive of the actual events:

-=09/* Map BAR5 to memory. */
+=09/* Request BAR5. */


I'd keep your Reviewed-by if that's OK. It's the only change I'd do.

Regards,
P.

