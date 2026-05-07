Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE1351C3D
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192506; cv=none; b=Y4duuumC1SaVbb7kTcX5/l8wqDEHYopv/GDdtbWtP7KaYnOucfKRME6LSaUm6Izcr6A2hKPQp+7wuP615+mgS5wWh1AWuOm4sHXuUrrBfllRZwJmmherkWtgAr5fK/JkxGoIMPcWVXANnMj9KURtiHhhPisYuNgXUNkb9irubOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192506; c=relaxed/simple;
	bh=B6PkRFnBwULiKTLVeHPqJePBw2wjZKORS2+nLlQEVno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHe7X2NnRh1jdZNbxuyKFOCmiAXy9nU1WOe2PAZ9+ZyLyUirGj2W/w4mhYJBBTEv1FSHqCM6iE16t7MRe2diQ9frnxRfR8LzedFmyDrlMq+qUsVMtwz/u4S8dgkIqPCU7WnLymGuT5HYJpSighYhl0Iabp1Rz8H1SZxGGAlH5mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dpopOEHI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fOBiXlTx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dpopOEHI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOBiXlTx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B468C1400160;
	Thu,  7 May 2026 18:21:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 07 May 2026 18:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778192503;
	 x=1778278903; bh=m8qT/uG2/sqQFesEBYSUx1JIfzriE/AaKRh6WVZOQ7I=; b=
	dpopOEHINIRq3CQlaThXbIqSQQcvUpv/g/OYAioUi3IogtOYvopm3LRz9KsMhBlz
	3+wPho+I1njtwS2pc4sYfCoBFWTBErjU9J4vXrH17td98HeEVeFY4nE0VJXDGOlq
	jSzlypPU0bVMUCklXlbBtXp5zDuBz3zPVeINEI7IHQCdOjYWYhYxPkg+eLL/b6Fl
	tR82DkYNU/5Ei8i0R7DpU0GDL5IwOfsx44tu0emE1gxBTGLi900QXC2Jr3EzlKj5
	qUIX6CqzDP/pam3HnAK5yxWWS25+Lbj3M+7LO4ueGu7gE/aQ3a6l+yi4NetpWnRQ
	C5hs5POtBXC4Su1dzVnLhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778192503; x=
	1778278903; bh=m8qT/uG2/sqQFesEBYSUx1JIfzriE/AaKRh6WVZOQ7I=; b=f
	OBiXlTx97TnP69OwkduqaR+Lbw8wHPuOvfzKVsEmAFOEtjzc0OLZAdPcYx2kU/oR
	UrQjsVqizCYWgSgf3wkGDWSlaYBKjhnCSq3tGO5YnnIm1vTwwFYu2o2wRBtaMnyl
	aQUvbUxKlgU0BONS4ZcBMlaEFwgQLu30fDGr9qQKsYrOAip28VW5QcIvxrqHON2v
	SGJArHxJj1bxYtvMq9itA+7w1Q1j0yT1LBnDvioOl8DfKuFg9I9HMH7l5WtC8+K1
	yCWEj8OzZmZRjwRsVVInrjIbMQKpNjSw6PJMPjijUlYkPw76uzwI5pAdB6BglQUl
	DYlV9zXhptT0gsZpDGNig==
X-ME-Sender: <xms:dxD9acGRPXtoY-8mBy3zzKRyWC5U8lk8Eoabb82JBvrEqEU2sqmExg>
    <xme:dxD9aQBOvKhJ7ImQYM5liFkGmxTaINBgKLOI3QmF2w90ijrjehyj1mhe-ou5y-C4i
    96hE_dWVxx6t-Z0MjlkRSqaW9F-qRZ057a_Rzg9VozJ9pZEVAsSKA>
X-ME-Received: <xmr:dxD9aczoAPsfmF6zHbe84Qo1B_kUB7v4eSLeRM6qZBb9KTSEiLKLETmh7eU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dxD9aZACw9GV6VsKtbpXDd68U24Lb8osFQT285NBtnhcKQ6-NHvRqA>
    <xmx:dxD9adCWtAsuqXDj5FZtVuF9PN1TM-BEYz_ervqtTLhjo_nEiM00oQ>
    <xmx:dxD9ac6tPQVBdCiIe94TxzJSD0QptvMySvseVLnL_sqIt6bO8ntiGA>
    <xmx:dxD9aR3UCB8i4xb5U-6DA5OERAMDFISRGm96aV8ahmrlbrPFx-ik2w>
    <xmx:dxD9aSOui77DmPrQ7HMF5mhCTDZhC2IXm1p0qIInTR_4lDCvxrrkEC8G>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 18:21:42 -0400 (EDT)
Date: Thu, 7 May 2026 16:21:41 -0600
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
Subject: Re: [PATCH v4 3/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with vfio_pci_core_get_iomap()
Message-ID: <20260507162141.072483ce@shazbot.org>
In-Reply-To: <20260505173835.2324179-4-mattev@meta.com>
References: <20260505173835.2324179-1-mattev@meta.com>
	<20260505173835.2324179-4-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 10:38:31 -0700
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
>  drivers/vfio/pci/nvgrace-gpu/main.c | 11 ++++-------
>  drivers/vfio/pci/vfio_pci_core.c    | 11 +++++------
>  drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
>  drivers/vfio/pci/vfio_pci_rdwr.c    | 30 ++++++++---------------------
>  drivers/vfio/pci/virtio/legacy_io.c | 13 ++++++-------
>  include/linux/vfio_pci_core.h       | 20 ++++++++++++++++++-
>  6 files changed, 43 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..e153002258ce 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -184,13 +184,10 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
>  
>  	/*
>  	 * GPU readiness is checked by reading the BAR0 registers.
> -	 *
> -	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
> -	 * register reads on first fault before establishing any GPU
> -	 * memory mapping.
> +	 * The BAR map was just set up by vfio_pci_core_enable(), so
> +	 * check that was successful and bail early if not:
>  	 */
> -	ret = vfio_pci_core_setup_barmap(vdev, 0);
> -	if (ret)
> +	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
>  		goto error_exit;

Sashiko notes we're not setting ret here.  The bots are also paranoid
about the unreachable condition that the get_iomap below could return an
ERR_PTR.  Maybe head off both by adding an __iomem pointer to the
nvgrace_gpu_pci_core_device struct and a temporary one here.  Store the
iomap in the temporary variable, use it to test for IS_ERR() and
PTR_ERR(), then set the pointer in the structure after the last error
condition here.  Add one line in the close_device to set it NULL.  Then
just use nvdev->bar0_io below.

>  
>  	if (nvdev->resmem.memlength) {
> @@ -275,7 +272,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  	if (!__vfio_pci_memory_enabled(vdev))
>  		return -EIO;
>  
> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	ret = nvgrace_gpu_wait_device_ready(vfio_pci_core_get_iomap(vdev, 0));
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 62931dc381d8..5c8bd13f10d0 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1761,7 +1761,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	struct pci_dev *pdev = vdev->pdev;
>  	unsigned int index;
>  	u64 phys_len, req_len, pgoff, req_start;
> -	int ret;
> +	void __iomem *bar_io;
>  
>  	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>  
> @@ -1795,12 +1795,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  		return -EINVAL;
>  
>  	/*
> -	 * Even though we don't make use of the barmap for the mmap,
> -	 * we need to request the region and the barmap tracks that.
> +	 * Ensure the BAR resource region is reserved for use.
>  	 */
> -	ret = vfio_pci_core_setup_barmap(vdev, index);
> -	if (ret)
> -		return ret;
> +	bar_io = vfio_pci_core_get_iomap(vdev, index);
> +	if (IS_ERR(bar_io))
> +		return PTR_ERR(bar_io);
>  
>  	vma->vm_private_data = vdev;
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 69a5c2d511e6..46cd44b22c9c 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -248,7 +248,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	 * else.  Check that PCI resources have been claimed for it.
>  	 */
>  	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
> -	    vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index))
> +	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
>  		return -ENODEV;
>  
>  	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 3bfbb879a005..7f14dd46de17 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -198,19 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>  
> -/*
> - * The barmap is set up in vfio_pci_core_enable().  Callers use this
> - * function to check that the BAR resources are requested or that the
> - * pci_iomap() was done.
> - */
> -int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
> -{
> -	if (IS_ERR(vdev->barmap[bar]))
> -		return PTR_ERR(vdev->barmap[bar]);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
> -
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite)
>  {
> @@ -262,13 +249,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  		 */
>  		max_width = VFIO_PCI_IO_WIDTH_4;
>  	} else {
> -		int ret = vfio_pci_core_setup_barmap(vdev, bar);
> -		if (ret) {
> -			done = ret;
> +		io = vfio_pci_core_get_iomap(vdev, bar);
> +		if (IS_ERR(io)) {
> +			done = PTR_ERR(io);
>  			goto out;
>  		}
> -
> -		io = vdev->barmap[bar];
>  	}
>  
>  	if (bar == vdev->msix_bar) {
> @@ -423,6 +408,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
>  	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
>  	struct vfio_pci_ioeventfd *ioeventfd;
> +	void __iomem *io;
>  
>  	/* Only support ioeventfds into BARs */
>  	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> @@ -440,9 +426,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	if (count == 8)
>  		return -EINVAL;
>  
> -	ret = vfio_pci_core_setup_barmap(vdev, bar);
> -	if (ret)
> -		return ret;
> +	io = vfio_pci_core_get_iomap(vdev, bar);
> +	if (IS_ERR(io))
> +		return PTR_ERR(io);

Sashiko seems to note a real existing error here that should also be
pulled out to a separate fix.  Given the right offset, this could
generate a negative BAR value.  The test at the end of the previous
chunk should should be expanded to `if (bar < 0 || bar > ...BAR5...)`.
Do you want to pick that up in this series?  I think it's the only case
that lets that slip through.  Thanks,

Alex
