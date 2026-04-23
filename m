Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293643C942B
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979858; cv=none; b=rj8kn5tU+1x5DQaUpn89xKbT4zSkWQZIw6lLxl9aSoQUDq/lZBnWHva2zYyz3OGoe6CPP/4WB3YoGGyMtw9DLNxeO7nkohmXtlIg4S052qVUlymLVzavt3135RXqzkWUaCXDow5C0xtQ6KcWe9k6B0ExDdwmk8UNJwmWLngd5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979858; c=relaxed/simple;
	bh=pNxE+Jon48Da1k19xOOAxOPCvGwyac2smRQSQS4swfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NT2e8RPwAeMUp8lpdMJUnM6A1lB+7u7elzR+0IU/LUeCBq8Y70GOY9KPYkI8OtXd/2orBL3Pjn8IpacMXwy3aEU7VMPeydxw7Seh0rdVWEm9wnV3aEw81N1TxgSt9Jq1cifTjQeDar+RCedTSXqzzJkcKE7kakKwMUw+TXoadHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=K/5tbAJg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ReAlOkjW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="K/5tbAJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ReAlOkjW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43D071400177;
	Thu, 23 Apr 2026 17:30:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Apr 2026 17:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776979855;
	 x=1777066255; bh=vpYVHryhzUNsLDS4RUn8sk70ly9tWfqClrbG3GB1pDo=; b=
	K/5tbAJgLFPSov/QaK1+ZnY9ezvrLTgQZXRHnAS5SQneHVg4UCEjG5JGuID8N6l5
	xSFb4TA5JauEtFxz3G2xy3doB3Twf6zvITyleWo9M8dVUJXqJld5kKkp8u8YsAXO
	7TQRomqptFPNNyN3OrpvtnJfCusKgg6NuviYSZ26AmN/jKzYO7nG2EWv8rD7ZFcS
	8dHqbuIZiliLFT+jFT/kJ/yF/5TRC4yXq4sn4KqCB9cLRaoq+onzxHdwXjSP5U/1
	Ql2OFch3zdBHkRx0eUQ31THhVAEF3QYvf9XiVpSI230Dtv5KPJsV87YRnkGZsOJi
	7CAm6JRhJVe4Q2vOPTZKCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776979855; x=
	1777066255; bh=vpYVHryhzUNsLDS4RUn8sk70ly9tWfqClrbG3GB1pDo=; b=R
	eAlOkjWhW+e8Rz2hxUzMaHIvLiY/Oeej2bz0NZ0VpU1YKKItH6zOwpyxQRovMGOp
	LcvsMZ8M/q3uljJoN9Ipgi61QXz59vA2YJjr/L9tRnnjqQaJb8dV207JMhSvVEyU
	OZbmz/kNDmD4dKARBU+2T8XDDIOdh5yYi4OJmH6ugy2ccfkwudg3e0nmSDAwY4au
	MjZrgsg7bj4aK8Xrf2ClV3T3hcGVqWPQ1EHJEC1+MRRXVpHwsLuJ7g4TjIcYUCWk
	OKx3Sj8k6OLeB55Qd82SFRZh1gmsqyusqNuUI48tmf3zkmrsfza6yfdbLmJ6QzjL
	/JoMlA4Foug5PxU1HN9JQ==
X-ME-Sender: <xms:j4_qaXuucTP-csBwgEwrMuvTCWg7qhMJjNF9zFc0QFT1LAU7F3ezEg>
    <xme:j4_qaTKlM7CSn7qQxK0704MheAtJh5hu6MO9RS0S7GXaiMffaJKzjs4mO0--Hb3CS
    SX37c5uA8iRO92zHYkL7Og4H-c9KjFHCBg97C9fYoI8Y5tx-e1v>
X-ME-Received: <xmr:j4_qaRb1Px9IpH9TCb_QGvRFfAKXeOd1rMfehk1gNqlVu5vV3FeCrt6T1EU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedukedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtth
    hopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehjghhgseii
    ihgvphgvrdgtrgdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtoheprghpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhn
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphht
    thhopeihihhshhgrihhhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:j4_qaRK63WUsOgl8lZpY4-pMjxZFVtnKndKGY0_bXEvr7K7zxaIdSg>
    <xmx:j4_qaSqFywMBJBgG9ablAj3sLCcnBXPPABauEbIz8FKY8X14Dqj1uA>
    <xmx:j4_qaSAGHgi1RR4tYMHlS1S3UPjT2Ngjs-RAxraLKZZMl2-bCeuudA>
    <xmx:j4_qaQcbgG9QnsRdsaJURoOQqovLOAABri6VRPXWnrL2a3NdHm4ywg>
    <xmx:j4_qaVWKqyWLXeuHgyTntKXPiJ_POrKgNJpH6mJcS3Z_RSTOq4Nat7iC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 17:30:53 -0400 (EDT)
Date: Thu, 23 Apr 2026 15:30:53 -0600
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
Subject: Re: [PATCH v2 1/3] vfio/pci: Set up bar resources and maps in
 vfio_pci_core_enable()
Message-ID: <20260423153053.6833135e@shazbot.org>
In-Reply-To: <20260423182517.2286030-2-mattev@meta.com>
References: <20260423182517.2286030-1-mattev@meta.com>
	<20260423182517.2286030-2-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Apr 2026 11:25:07 -0700
Matt Evans <mattev@meta.com> wrote:

> Previously BAR resource requests and the corresponding pci_iomap()
> were performed on-demand and without synchronisation, which was racy.
> Rather than add synchronisation, it's simplest to address this by
> doing both activities from vfio_pci_core_enable().
> 
> The resource allocation and/or pci_iomap() can still fail; their
> status is tracked and existing calls to vfio_pci_core_setup_barmap()
> will fail in the same way as before.  This keeps the point of failure
> as observed by userspace the same, i.e. failures to request/map unused
> BARs are benign.
> 
> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 61 +++++++++++++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_rdwr.c | 29 ++++++---------
>  include/linux/vfio_pci_core.h    |  1 +
>  3 files changed, 64 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8..c59c61861d81 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -482,6 +482,55 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM */
>  
> +static void __vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int bar = i + PCI_STD_RESOURCES;
> +
> +		if (vdev->barmap[bar])
> +			pci_iounmap(pdev, vdev->barmap[bar]);
> +		if (vdev->have_bar_resource[bar])
> +			pci_release_selected_regions(pdev, 1 << bar);
> +		vdev->barmap[bar] = NULL;
> +		vdev->have_bar_resource[bar] = false;
> +	}
> +}
> +
> +static void __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	int i;
> +
> +	/*
> +	 * Eager-request BAR resources, and iomap; soft failures are
> +	 * allowed, and consumers must check before use.
> +	 */

I'd use this to describe that soft failures maintain compatible error
signatures to previously used on-demand mapping.

> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		int ret;
> +		int bar = i + PCI_STD_RESOURCES;
> +		void __iomem *io;

Reverse Christmas tree ordering.

> +
> +		if (pci_resource_len(pdev, i) == 0)
> +			continue;
> +
> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
> +		if (ret) {
> +			pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
> +			continue;
> +		}
> +		vdev->have_bar_resource[bar] = true;
> +
> +		io = pci_iomap(pdev, bar, 0);
> +		if (io)
> +			vdev->barmap[bar] = io;
> +		else
> +			pci_warn(vdev->pdev, "Failed to iomap region %d\n", bar);
> +	}
> +}

I see you making the point in the cover letter about the resource
request vs the iomap resource, but we currently handle these together.
If either fails, setup barmap fails and the path returns error.  I
don't see any justification for now allowing the request resource to
succeed but the iomap fails.

These functions also don't need the double-underscore prefix.

> +
>  /*
>   * The pci-driver core runtime PM routines always save the device state
>   * before going into suspended state. If the device is going into low power
> @@ -568,6 +617,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> +	 __vfio_pci_core_map_bars(vdev);
>  
>  	return 0;
>  
> @@ -591,7 +641,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_dummy_resource *dummy_res, *tmp;
>  	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
> -	int i, bar;
> +	int i;
>  
>  	/* For needs_reset */
>  	lockdep_assert_held(&vdev->vdev.dev_set->lock);
> @@ -646,14 +696,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vfio_config_free(vdev);
>  
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		bar = i + PCI_STD_RESOURCES;
> -		if (!vdev->barmap[bar])
> -			continue;
> -		pci_iounmap(pdev, vdev->barmap[bar]);
> -		pci_release_selected_regions(pdev, 1 << bar);
> -		vdev->barmap[bar] = NULL;
> -	}
> +	__vfio_pci_core_unmap_bars(vdev);

I expect this doesn't need to change if we drop the separation between
resources and iomap.
 
>  	list_for_each_entry_safe(dummy_res, tmp,
>  				 &vdev->dummy_resources_list, res_next) {
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 4251ee03e146..bf7152316db4 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -200,25 +200,18 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
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
> +	/*
> +	 * The barmap is now always set up in vfio_pci_core_enable().

"now" is going to read strangely very quickly.

> +	 * Some legacy callers use this function to ensure the BAR
> +	 * resources are requested, and others to ensure the
> +	 * pci_iomap() was done, so check here:
> +	 */
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +	if (vdev->barmap[bar] == 0)
>  		return -ENOMEM;
> -	}
> -
> -	vdev->barmap[bar] = io;
> -
> +	if (!vdev->bar_has_rsrc[bar])

Typo, this won't incrementally compile.  Thanks,

Alex

> +		return -EBUSY;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f..1f508b067d82 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -101,6 +101,7 @@ struct vfio_pci_core_device {
>  	const struct vfio_pci_device_ops *pci_ops;
>  	void __iomem		*barmap[PCI_STD_NUM_BARS];
>  	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
> +	bool			have_bar_resource[PCI_STD_NUM_BARS];
>  	u8			*pci_config_map;
>  	u8			*vconfig;
>  	struct perm_bits	*msi_perm;

