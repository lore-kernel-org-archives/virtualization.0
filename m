Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159536215A
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580029; cv=none; b=WlNwsh/ewdkaaz+Sz5FHICRq0qUX4+/xEIwTs6VKTCHkRJ0nk7JPa1qP9tFpl8Ko/n2F+ubZAWVicMCFYnIx1UCnVfWZg1DmRPjBO3fGjbDoJZs4rxaD7Or4oOECPsq1PieTWCAzUWBeTbf/mLgudaa9oRhofYJ2QEByWbmQz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580029; c=relaxed/simple;
	bh=htVJlPxrPXgNpjom9YkxjKPWZedAld3wE3vOYDRQAXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Df7nPrSeM+K4WoiOnfJTtExhFZAWw7I1rZKe4fXnTYZeQHTjiNlg9+sXsSF/2ruSMfHfvU1WbBtHaVLNvkO3G3GfCnE5Ga8g8zImFp/oddP3UpyDbBcjYTaLX+2kYY1mptebcVSQBwa2fQ3BMO2WXVnu8++T/7JK7n9vE80qUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Jgzprs5a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EbnDxgk1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Jgzprs5a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EbnDxgk1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E41A1400111;
	Thu, 30 Apr 2026 16:13:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 16:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777580025;
	 x=1777666425; bh=H7YcHR7i43pz1umKuCVYnnMBP2nE8tcxH2McSHb7LoM=; b=
	Jgzprs5adRBt2SfPD2ILFf8uasdHU3UNej/WlUd3ie2HXwpQu85SVsi7xeezEUag
	SGtyRZiqcyLBfj5Z+z+e6PPb210iB88XCyBNu8R2MDxyYkp8PBytsqL77Cjl0dVF
	FCmGslnY4ZE+mJgp5l3qSNLR4QnCIclAnvMY/ednDIN7RO9ri1bmDllM+bsVyAbW
	I/1hjgX1BMgCToScFXfslFGPJmuHSggrkNYZCmNLhULYc0+pGsRyzLxfUAHfRFVt
	JFkVGTcCXRB6SHzTzINsLzT4mon0l6Ccv7aTESl+qdqUA16dYzBWFM1GZvl556qZ
	GuNSOGnEOmibZSBxtgcosg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777580025; x=
	1777666425; bh=H7YcHR7i43pz1umKuCVYnnMBP2nE8tcxH2McSHb7LoM=; b=E
	bnDxgk1CviuvvAQIudVzl1luu7n/nmR2sg2EiaE7KcE4oaz03956MZ6XdzB1Y996
	5J0ItTLQNZTk4kQxYTUdTQxBIyXdUb2e4gnt/9IViaYV8+7BMLojhNTsU/8fPTfM
	zEOsTbiwojZtYvsR9JR+5KziIfV8Q5L7s6nuJspxEPKIv3C4jwY3YbTVo18V8bxU
	UZcSzL+UVXK2iBewP+l9bsZbxE0RawpkAolwF6CHuXBsi0Gs/6jkHf5xJ21wTMra
	w9clq/luRR9Bepv7aQR57hg/uCTx2I2EPKFovn+ME/mqV6SzhQsL+XzDy5lBluG7
	xr2ivKuzxg7mYzHDFP+nA==
X-ME-Sender: <xms:-LfzaUZItlNUTE3NuYu5aBY0ftvCs7WquA1QCIcI4RhtWT-kmAv2bQ>
    <xme:-LfzaaGCueAkX9ZBRr9aP0zbwPc-ltr-IxF8UYFzNoeCgj2I9zr9ozjb1jwAMVXKK
    wZzRBOIedy5BsRFDssYZvtFoFR-6PlyycZ0Vxp4PMKTO07YN8vk>
X-ME-Received: <xmr:-LfzaVn3hHFQO0ArdiqrklKpWYI1uuMKmeZlMVP9O08ccHUwyWX1pawz1ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtth
    hopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjghhgseii
    ihgvphgvrdgtrgdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphht
    thhopeihihhshhgrihhhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:-LfzaZniC50YIHVepcIXRlpwFSmz_dvVnj8dZn5-7bonvne50gITHg>
    <xmx:-LfzaaUQUGntpgEQC95X28Xw-meJqA-NX5ZhjgoAjUTFRBASFwvRWA>
    <xmx:-LfzaX_rQZZwRsDVfjCNnJRBvS0kQrOcVXAr3mHrFq1XmoB8vBmE2w>
    <xmx:-LfzaXoecArW8d1Mop5dVIV4meFiTNfnyj6EG3Uo1Wz8paTMWTYtJA>
    <xmx:-bfzaUTZls0jr6lS3ZRZK_7WBcp1lTR8C0WfuhPI5ohtkVM0aA_WFtn1>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 16:13:43 -0400 (EDT)
Date: Thu, 30 Apr 2026 14:13:41 -0600
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
Subject: Re: [PATCH v3 1/3] vfio/pci: Set up bar resources and maps in
 vfio_pci_core_enable()
Message-ID: <20260430141341.163ed827@shazbot.org>
In-Reply-To: <20260430100340.2787446-2-mattev@meta.com>
References: <20260430100340.2787446-1-mattev@meta.com>
 <20260430100340.2787446-2-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 03:03:20 -0700
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
> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")

Neither of these introduced races, they only moved what they were
already doing into a function or made use of that shared function for
what they were already doing.  I'm inclined to believe the raciness
existed from the introduction, 89e1f7d4c66d.

> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 33 ++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_rdwr.c | 29 ++++++++++++----------------
>  2 files changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8..eab4f2626b39 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -482,6 +482,38 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM */
>  
> +static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i;
> +
> +	/*
> +	 * Eager-request BAR resources, and iomap.  Soft failures are
> +	 * allowed, and consumers must check the barmap before use in
> +	 * order to give compatible user-visible behaviour with the
> +	 * previous on-demand allocation method.
> +	 */
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int bar = i + PCI_STD_RESOURCES;
> +		void __iomem *io = ERR_PTR(-ENODEV);

It would collapse the nesting depth to just do:

		vdev->barmap[bar] = ERR_PTR(-ENODEV);

		if (!pci_resource_len(pdev, i))
			continue;

		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
			pci_dbg(vdev->pdev, "Failed to reserve region %d\n", bar);
			vdev->barmap[bar] = ERR_PTR(-EBUSY);
			continue;
		}

		vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
		if (!vdev->barmap[bar]) {
			pci_dbg(vdev->pdev, "Failed to iomap region %d\n", bar);
			vdev->barmap[bar] = ERR_PTR(-ENOMEM);
		}

It's debatable what level to use for the errors, but we were previously
silent on this, so going all the way to pci_warn() seems unnecessary.

> +
> +		if (pci_resource_len(pdev, i) > 0) {
> +			if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
> +				pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
> +				io = ERR_PTR(-EBUSY);
> +			} else {
> +				io = pci_iomap(pdev, bar, 0);
> +				if (!io) {
> +					pci_warn(vdev->pdev, "Failed to iomap region %d\n",
> +						 bar);
> +					io = ERR_PTR(-ENOMEM);
> +				}
> +			}
> +		}
> +		vdev->barmap[bar] = io;
> +	}
> +}
> +
>  /*
>   * The pci-driver core runtime PM routines always save the device state
>   * before going into suspended state. If the device is going into low power
> @@ -568,6 +600,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> +	vfio_pci_core_map_bars(vdev);
>  
>  	return 0;

You're missing the barmap test in vfio_pci_core_disable() now, it's
still testing for NULL, which is (almost?) never true.  It needs to
convert to IS_ERR_OR_NULL().

>  
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 4251ee03e146..f66ad3d96481 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -200,25 +200,20 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>  
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
> +	/*
> +	 * The barmap is set up in vfio_pci_core_enable().  Callers
> +	 * use this function to check that the BAR resources are
> +	 * requested or that the pci_iomap() was done.
> +	 */

Looks like a function level comment to be placed above the function
definition.  TBH, the comment in the previous function could also be
pulled up as a function level comment.

> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)

Maybe `if ((unsigned)bar >= PCI_STD_NUM_BARS)` but really author
preference here.

> +		return -EINVAL;
>  
> -	vdev->barmap[bar] = io;
> +	/* Did vfio_pci_core_map_bars() set it up yet? */
> +	if (!vdev->barmap[bar])
> +		return -ENODEV;

What hits this?  Should it be a WARN_ON_ONCE?  It would need to be a use
case that accesses barmap outside of the window between enable and
disable, where I think we're defining the contract that it's only valid
between those events.  Both this and the range check could move to the
iomap implemenation to keep the Fixes: patch reasonably small since
afaik they're not triggered.  The BAR range test could be WARN_ON_ONCE
as well, only driver bugs should hit it.  Thanks,

Alex

>  
> +	if (IS_ERR(vdev->barmap[bar]))
> +		return PTR_ERR(vdev->barmap[bar]);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);

