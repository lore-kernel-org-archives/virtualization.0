Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE338F92F
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192485; cv=none; b=DXQwj0GwyI/nfNqV46QZI1yQ1KnzNaQRrmF9EejHIHrXwQqptzxnZUnbE64c2V9kBmJq+uucy0vrH316iPIOocjoR9gmKfLeLbYAa63pAPn/A7ARcReyWj9rEKtHoYOKJSHhNsYLvmS2buJXTe5ffb8+7fYgyHYRX2WWbWHSZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192485; c=relaxed/simple;
	bh=mJ4Wm3E2/rZktTizof/81ryrKyz4CZ6QItVv7zucHVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPBdvhOb3pGJmut2DAUDgxT1UTYKLM2CDai0gpUaeH8PxsLj3gYTi9PuoBGOg+Lm9Z1eAgAF0GOnCW74gUex4DQf8kqKgef3cLaq857W+/2Xo6ni01rbrwMxGR7ow3z29U3K2OxLNRnCxOT2l88Go5GUma5MEar3CXh8P6ipqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=i5q9+7yn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=opWwyNjM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="i5q9+7yn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opWwyNjM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 20828EC007A;
	Thu,  7 May 2026 18:21:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 07 May 2026 18:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778192480;
	 x=1778278880; bh=Gh4OSjP3zNBwkOQ2z6YniOnM1TA/lZE1WxkyBie8Agg=; b=
	i5q9+7ynx7C+dPft+lSOCdOPax+lbxOD/tWQY8onMNHvVriQ3DySH1HjmPVc1O0T
	Draa1F2NMoAX3iCEVcwZIQBf/8dtkLWUdE4u31KmIon1v8HjgCmmRxhISvefp8ar
	O2C0Syufd9zrt72GG0By8Oi5Y0EFDkrN31777i9jkhOwYmVyp7Z4to0A2/pYp+FJ
	Rdb0Yjvk/WsfqhJ0ytAtD7z2x6G2515crokAYoalt0oCQVo8GqCMs6PcpbkNs0QR
	JXlSa3MvJAgv6rojaAhnLHUHhirV8OxxPPfPyQAijJ81B5VxO74c5jJvj3jxo8nm
	T/bYvTE8zmpvHlafyqmHKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778192480; x=
	1778278880; bh=Gh4OSjP3zNBwkOQ2z6YniOnM1TA/lZE1WxkyBie8Agg=; b=o
	pWwyNjMc572387uxo/u8lKUikQpA20C/6Topz0KfwXndv/PsPwfApeDapsJFMS84
	9eLGp288rQwAeP7ZAuBG2p5CY1TI/5WGVG4JiC1WAODO5csYumx4LPcSRykB4dO9
	0bTLixRkpnnW71N4IRzN/jn+wbbGDPoUehKU5w921snQmkBS2RKK6cplL4Rz+xN0
	ZvAIl0F103jjvQTOYXvZecAHvj5OjJW3jG98NlO9Hkn+NJThqrzie7cJpAMHeGO1
	FPyNUyWgMrGDxoYE3Vbjr+QbubHr3aRfx+/rv8VuFE1x1RQpSqpKtE/MhOsLQoGn
	Hw89bqLLsWMTAsAXitsLA==
X-ME-Sender: <xms:XxD9aa5KxrOdyJQwysKf0A9MhOU5yIhZHRjreb0IGZhlQ4WaBH1fwQ>
    <xme:XxD9aen4k5Hh7Wux8zXWsd81KHwj6iEuKUfGLLPtoqQQvV_9ymHscgQFC3D12RTLl
    HcwBJ4w_AhY74AwbcxTjiaDaJsXi44fb4tIjSa92iJSZeHXsV5jPw>
X-ME-Received: <xmr:XxD9aQEELn_XazZmGDSXNLqE6E7c9r-bY0cUKFzAt-Xu_grAoEBdFPEdVpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekleffveeiueehieeiieefleetffehieffkeelvdeljeegtdfhvdejhedu
    ffelvdenucffohhmrghinhepshgrshhhihhkohdruggvvhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhr
    ghdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmrghtthgvvhesmhgvthgrrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehi
    nhhtvghlrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoh
    eprghnkhhithgrsehnvhhiughirgdrtghomhdprhgtphhtthhopegrphhophhplhgvsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehskhholhhothhh
    uhhmthhhohesnhhvihguihgrrdgtohhmpdhrtghpthhtohephihishhhrghihhesnhhvih
    guihgrrdgtohhm
X-ME-Proxy: <xmx:XxD9aSE2Rap711ZOx_QM0MryJdd4ZB48WuF1lBgWOrEqopS83lDOaQ>
    <xmx:XxD9aY3RJH3S12JogD5BPm2KME_CKk-s4r_4iPku0v4X7pFT93aaBw>
    <xmx:XxD9aUd-CDMHuIJ_--F74dKPDkqUwu7J01xJRZzGt8xInZcynD8LZQ>
    <xmx:XxD9aaJNPPPWkKH1UOjh4Y0zNql7mzwrU-sPsG3a9fjuq3hDzsN-Og>
    <xmx:YBD9aYwjCVnIAcTFiaWV2l6OJdkVtPWSBUqUr-kuDcmjnNxucUdXZuC->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 18:21:17 -0400 (EDT)
Date: Thu, 7 May 2026 16:21:16 -0600
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
Subject: Re: [PATCH v4 1/3] vfio/pci: Set up BAR resources and maps in
 vfio_pci_core_enable()
Message-ID: <20260507162116.3b9cbd98@shazbot.org>
In-Reply-To: <20260505173835.2324179-2-mattev@meta.com>
References: <20260505173835.2324179-1-mattev@meta.com>
	<20260505173835.2324179-2-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 10:38:29 -0700
Matt Evans <mattev@meta.com> wrote:

> Previously BAR resource requests and the corresponding pci_iomap()
> were performed on-demand and without synchronisation, which was racy.
> Rather than add synchronisation, it's simplest to address this by
> doing both activities from vfio_pci_core_enable().
> 
> The resource allocation and/or pci_iomap() can still fail; their
> status is tracked and existing calls to vfio_pci_core_setup_barmap()
> will fail in a similar way to before.  This keeps the point of failure
> as observed by userspace the same, i.e. failures to request/map unused
> BARs are benign.
> 
> Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 36 +++++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_rdwr.c | 26 +++++++----------------
>  2 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8..62931dc381d8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -482,6 +482,39 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM */
>  
> +/*
> + * Eager-request BAR resources, and iomap them.  Soft failures are
> + * allowed, and consumers must check the barmap before use in order to
> + * give compatible user-visible behaviour with the previous on-demand
> + * allocation method.
> + */
> +static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int bar = i + PCI_STD_RESOURCES;
> +
> +		vdev->barmap[bar] = ERR_PTR(-ENODEV);
> +
> +		if (!pci_resource_len(pdev, i))
> +			continue;
> +
> +		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
> +			pci_dbg(vdev->pdev, "Failed to reserve region %d\n", bar);
> +			vdev->barmap[bar] = ERR_PTR(-EBUSY);
> +			continue;
> +		}
> +
> +		vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
> +		if (!vdev->barmap[bar]) {

Sashiko notes[1] correctly that we need to release the requested region
here.

[1]https://sashiko.dev/#/patchset/20260505173835.2324179-1-mattev@meta.com

> +			pci_dbg(vdev->pdev, "Failed to iomap region %d\n", bar);
> +			vdev->barmap[bar] = ERR_PTR(-ENOMEM);
> +		}
> +	}
> +}
> +
>  /*
>   * The pci-driver core runtime PM routines always save the device state
>   * before going into suspended state. If the device is going into low power
> @@ -568,6 +601,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> +	vfio_pci_core_map_bars(vdev);
>  
>  	return 0;
>  
> @@ -648,7 +682,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		bar = i + PCI_STD_RESOURCES;
> -		if (!vdev->barmap[bar])
> +		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
>  			continue;
>  		pci_iounmap(pdev, vdev->barmap[bar]);
>  		pci_release_selected_regions(pdev, 1 << bar);
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 4251ee03e146..3bfbb879a005 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -198,27 +198,15 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>  
> +/*
> + * The barmap is set up in vfio_pci_core_enable().  Callers use this
> + * function to check that the BAR resources are requested or that the
> + * pci_iomap() was done.
> + */
>  int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>  {
> -	struct pci_dev *pdev = vdev->pdev;
> -	int ret;
> -	void __iomem *io;
> -
> -	if (vdev->barmap[bar])
> -		return 0;
> -
> -	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> -	if (ret)
> -		return ret;
> -
> -	io = pci_iomap(pdev, bar, 0);
> -	if (!io) {
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		return -ENOMEM;
> -	}
> -
> -	vdev->barmap[bar] = io;
> -
> +	if (IS_ERR(vdev->barmap[bar]))
> +		return PTR_ERR(vdev->barmap[bar]);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);

