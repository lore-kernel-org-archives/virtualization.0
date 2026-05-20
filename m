Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05FD37B03E
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311547; cv=none; b=oi2Dhs6xX40PrIEEjSe9+zdfG0cykdw5dDcoGr9BanwnWds0XcrHL5LGWTNtffk8ovqT5TfNd5FjKREMbswSkxXi3QiBqR1Xofynza0sGBf/q1ZE+pK/4AYZ1MXig+WZbx7frmNtldFM2Ztb2Y4hWO+bbUj0bk0JDzA5vwd1h6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311547; c=relaxed/simple;
	bh=nDLsWbBRmSKXN8sVjY8h1PBcs6FHyOb6mfb9ibmI4xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVd0RGkUAQ8zB0rqd4b5LWbvzSp+lVLBuyBcLos/ToSalRohIMoURgNVyaj3UVwiQVm6/KoSU1/QnhAT9biV1OWZRAFChJ8eSOQ1eEZ0sV7YBnX3bKYpxLN7f3V9fd8S4DLtBuu4nd5oTMLRVRxHjmgguznvuB1oTodT+/5hlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=VhcCgi+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UszFXeQ3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="VhcCgi+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UszFXeQ3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BC23F1D00098;
	Wed, 20 May 2026 17:12:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 20 May 2026 17:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779311543;
	 x=1779397943; bh=wMt1jtg/w5e/s1bQZEbp5IGIMFsOdz4buZTavjf/LF4=; b=
	VhcCgi+xqsKH8VqHD5cHpd4+O47draH/DdCq6Pk6dJGMSml4QOOq/WzEZR8Xx/Zf
	A46dbu83/wv7d1Y9wwCAq8V/02x7GAtv1XadfkGig2p74Yb+WqZ+PL1fjoMyKWul
	VhkpTUlBKqw8WBpGKvsQOIcevPzyYywx3mG+JsV32GYvMBpOQ9QTicOfUzQGt+D/
	7uwYhDWR/y7lQUcrfXXUsbYxA9h7Yf5H9wchLuHIxz96vGyoxo+BMnPwh3lZOTX8
	m4i+xDzEord830n5ks4RrvGskqIpvMryRsDtzQCLhhfatIVC2LsdCQvtoZieZk02
	OQkXKBN0A7UzEI2a+pwLTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779311543; x=
	1779397943; bh=wMt1jtg/w5e/s1bQZEbp5IGIMFsOdz4buZTavjf/LF4=; b=U
	szFXeQ3UMMHjINda6VlBvd1fvb7jEQJFtKebezzOrxUVo9Z0RnSRUonoIrzsGGP9
	AMe1/TEVuurARnXXmq3nqvBKr3HACqJCcQOiMaP0s9vnvTYZrWE4uM8w2BhoVZ1g
	pRDHIEwabhCy81WOJhRwW0TxH5VMyBa+oIEWmJFUN7XhQY9es/YmQyDxtOCPiHAc
	nuEipJsZLNzOZRl4ailkinU43lloreUENbS4XOEHwawRkbFNoKuCRUnVIXvBSKMX
	3Bv0iz1CWGknhWedYwg+dRp+mr5MrcUiC6M8pkckZojMOASG/EEOWBIA1Z7aTUIS
	UyDUZ4//LYoEF2VezicjA==
X-ME-Sender: <xms:tyMOarSzSIWCBilJk_LFbg61kfnXIQgtJu7J0cfnrRdvuKl0Jej1RQ>
    <xme:tyMOanDuF-D-SXaC8UvIUrCK4y2_QpWJUcreTPyZjUrJTT-Q7Ew_OLb5YnVmBXFJs
    BAEk1wwcjYkIaW3YbBS1oCYuyMogvMC48-qOERS6AfPm2aQd91z5hY>
X-ME-Received: <xmr:tyMOamTB0XY4dGokyyZY0tPGR9zjJLabSlkdEhMPpgD4NQpHYKbKCG9fnlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghtthgvvhesmhgvthgrrdgtohhmpdhrtghpth
    htohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhgghes
    iihivghpvgdrtggrpdhrtghpthhtoheprghnkhhithgrsehnvhhiughirgdrtghomhdprh
    gtphhtthhopegrphhophhplhgvsehnvhhiughirgdrtghomhdprhgtphhtthhopehlvgho
    nheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgtohhmpdhrtghp
    thhtohephihishhhrghihhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:tyMOahRP3lVoQuAMGwjXHJiTnNPuf8Wc0OVvRP4ITCbamCAtzzOn5g>
    <xmx:tyMOasI6PusRw5r5kmaCJZrqjrxW1scUJCzh4oPRIAgR_9pld7v1qw>
    <xmx:tyMOagEQ2BTGwG3Hcq9E6Z1ViCRCqYt47ZKuTFkT6Wie1jqx7mWQOw>
    <xmx:tyMOahRtQqHV7ga-pT-CpHxda9FPkfVEwauGeZy-90nnUxCo4eZHjg>
    <xmx:tyMOajNmW-o4VpyIwQ4XudQqwoqhwIVYqtI9WYsyQxIM6yPkl_xfJSQ0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 17:12:21 -0400 (EDT)
Date: Wed, 20 May 2026 15:11:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Ankit
 Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>, Shameer Kolothum
 <skolothumtho@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>, Eric Auger <eric.auger@redhat.com>, Peter Xu
 <peterx@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Zhi Wang
 <zhiw@nvidia.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <virtualization@lists.linux.dev>, alex@shazbot.org
Subject: Re: [PATCH v5 3/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with vfio_pci_core_get_iomap()
Message-ID: <20260520151152.68a1435d@shazbot.org>
In-Reply-To: <20260511145829.2993601-4-mattev@meta.com>
References: <20260511145829.2993601-1-mattev@meta.com>
	<20260511145829.2993601-4-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 07:58:25 -0700
Matt Evans <mattev@meta.com> wrote:

> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
> resource request and iomap for the BARs was performed early, and
> vfio_pci_core_setup_barmap() just checks those actions succeeded.
> 
> Move this logic to a new helper that checks success and returns the
> iomap address, replacing the various bare vdev->barmap[] lookups.
> This maintains the error behaviour of the previous on-demand
> vfio_pci_core_setup_barmap() scheme.
> 
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 20 ++++++++++++-------
>  drivers/vfio/pci/vfio_pci_core.c    | 11 +++++------
>  drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
>  drivers/vfio/pci/vfio_pci_rdwr.c    | 30 ++++++++---------------------
>  drivers/vfio/pci/virtio/legacy_io.c | 13 ++++++-------
>  include/linux/vfio_pci_core.h       | 20 ++++++++++++++++++-
>  6 files changed, 52 insertions(+), 44 deletions(-)

Applied to vfio next branch for v7.2, based on v7.1-rc4 which includes
the remainder of the series.  Thanks,

Alex
