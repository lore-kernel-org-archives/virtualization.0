Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FB38F226
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580033; cv=none; b=qkSfGzqiDVT6/KpiJ0lmuz3FznAnwd/F0xXCNI7uyZ/7w+Mk5XvXZCfc3OaMFt0wRLtWtAz8qMHCKAlqVdVe4MnNGr/e/T0uAOhwLLGrsGxt3/AkI+cYS65j5pSdtqXXc/GpQTdRac51NqO2lgwtZLpe8i8PhK7lDDP+RBDPErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580033; c=relaxed/simple;
	bh=mX88KiNrXDfYCdOvNKxqZ8nscwaMzs0zZ7rkv23iXSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=attiONP1KtOaQqJE4qmdi7wPpCvVuUShVd+Hg2/At6EVHmmnE0EzGJCnCT/kw3Oq1XbuIqTs8RBAtSU99nkeN0MYQOd8hr4ZG1qRkhGmuftJQ8x3S60INtJPz9arync98HzY7OqI6PkhjlGjGGzmy4+BHG0TNJZ3TtW6IPMKGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cGd733G/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofJ4FrLN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cGd733G/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofJ4FrLN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 26A7FEC0105;
	Thu, 30 Apr 2026 16:13:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 16:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777580031;
	 x=1777666431; bh=vxlHiEKvZF72jqXelHvMGuNIYm0K1ZJgieKnU1OCtSA=; b=
	cGd733G/CCxo7YU+2b+rAQRWjLzq+4sPUibSP4Lji2CQbTi5Rv+MN5U/aWLQ30P5
	jCOJL9JV5pRIRR9cZRf+kXJMgTXFxt6e7VyAAKQJ3kZZW5rOsdcyS+pX3Kv2bJHC
	9rtm31rtzeb66YhwjK3JC40qiOiTebn9sdcC0mSJjsHD/JOZVApIE8ivFKjGE9O0
	zZkqeU1cAQJc4waJtJmklwJsgBgu0oHfl3N5pVVBjQl2SX2Wrl7HuzlZCk3W4Xcl
	Yrm/j2C/PohDfCOsOe3XQyUyGCQymvWilFLeu/McmL3Fis6yz19qgvkYh92tynJ/
	R7jXqMCCB7WObiPn5l99HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777580031; x=
	1777666431; bh=vxlHiEKvZF72jqXelHvMGuNIYm0K1ZJgieKnU1OCtSA=; b=o
	fJ4FrLNRtLiM6UawA7bfIo2UEin49q6sdhdEPNWflgfX4l7h7B7wdiWsYTrMUsat
	gtHlLHKIzm6NIiCXZw4wY1cOkFZAEFvPsi7IVUpCRtggVdKoQuLgS7ySTBAnr+fo
	6HeJ2SpL1fQOBYLV5jGOYpdYYy6C1ix1zt5j0fXyNuDNx3gpVyiCrQ+MJ7cfUkmb
	qe9EtZA0JdqOhHKFtLfG0tGIngn1hgvtPl72RITAFQIa5DSI/zNtItOqWPitvRaJ
	1cWCDKwTrrDO9ozj25vH5x/BuFaoBQ6tcoydG2myFRF8dEpuqgQIJg05CqRfVR6k
	OEUrBQ1zGPvmOrUXtZ3FA==
X-ME-Sender: <xms:_rfzaSlEOv0QYqbf1svqJIbKT-8wX63rRHLQsBtk-BckHu3of-RMNA>
    <xme:_rfzaUGOl5vo_ZmekdhGCyjMSpYL770vB0YJ3AGMMSb-W1rfbIEAAcnBIBPGOoDAi
    pA-agPRCKpvzXNFzzkTKmuysYFQ5jnYTPzRpfPxakQwWrcXdAzelg>
X-ME-Received: <xmr:_rfzaWGTaogJQ-qhaChb7bsEP0V4ZHD9IpKFJ9czloZKf593UmSsygYOEqk>
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
X-ME-Proxy: <xmx:_rfzac0F1RueckYc6LcsxyzS8PYvqiHgSM8eHB3_RQ6jtza0mqIA9Q>
    <xmx:_rfzaYc9AL4gaTjG_WKXnLYUFMHLE6PPjaFS1o65lyV8F4MnqHOzYg>
    <xmx:_rfzaeI7jIN3CsCJOmoJSP1U1Bh37DuBaeMBlBsOsZoh87J8dQd0Hg>
    <xmx:_rfzaeFB0TQekBewqxqJmPoYs3FleSmG8UmWXlU-kToMcYPLFQg0lw>
    <xmx:_7fzaYS0e9HyPmar5b1UHc9eMA31z7ssyQ1X5HQSwnxd_-8ry9PLq8FG>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 16:13:49 -0400 (EDT)
Date: Thu, 30 Apr 2026 14:13:48 -0600
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
Subject: Re: [PATCH v3 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with vfio_pci_core_get_iomap()
Message-ID: <20260430141348.725be59c@shazbot.org>
In-Reply-To: <20260430100340.2787446-3-mattev@meta.com>
References: <20260430100340.2787446-1-mattev@meta.com>
 <20260430100340.2787446-3-mattev@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 03:03:21 -0700
Matt Evans <mattev@meta.com> wrote:

> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
> resource request and iomap for the BARs was performed early, and
> vfio_pci_core_setup_barmap() just checks those actions succeeded.
> 
> Move this logic to a new helper that checks success and returns the
> iomap address, replacing the various bare vdev->barmap[] lookups.
> This maintains the error behaviour of the previous on-demand
> vfio_pci_core_setup_barmap() scheme.> 
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 17 +++++++------
>  drivers/vfio/pci/vfio_pci_core.c    | 11 ++++-----
>  drivers/vfio/pci/vfio_pci_rdwr.c    | 37 +++++++----------------------
>  drivers/vfio/pci/virtio/legacy_io.c | 13 +++++-----
>  include/linux/vfio_pci_core.h       | 19 ++++++++++++++-
>  5 files changed, 47 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..2f5ec60c15d9 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -184,13 +184,11 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
>  
>  	/*
>  	 * GPU readiness is checked by reading the BAR0 registers.
> -	 *
> -	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
> -	 * register reads on first fault before establishing any GPU
> -	 * memory mapping.
> +	 * The BAR map was just set up by vfio_pci_core_enable() and,
> +	 * although the readiness check checks validity of the BAR0
> +	 * map, assert early that the map was successful:
>  	 */
> -	ret = vfio_pci_core_setup_barmap(vdev, 0);
> -	if (ret)
> +	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
>  		goto error_exit;
>  
>  	if (nvdev->resmem.memlength) {
> @@ -265,6 +263,7 @@ static int
>  nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  {
>  	struct vfio_pci_core_device *vdev = &nvdev->core_device;
> +	void __iomem *io;
>  	int ret;
>  
>  	lockdep_assert_held_read(&vdev->memory_lock);
> @@ -275,7 +274,11 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  	if (!__vfio_pci_memory_enabled(vdev))
>  		return -EIO;
>  
> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	io = vfio_pci_core_get_iomap(vdev, 0);
> +	if (IS_ERR(io))
> +		return PTR_ERR(io);
> +
> +	ret = nvgrace_gpu_wait_device_ready(io);

I suspect the preference would be to test:

	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
		goto error_exit;

in nvgrace_gpu_open_device(), then just use:

	ret = nvgrace_gpu_wait_device_ready(vfio_pci_core_get_iomap(vdev, 0);

here.


>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index eab4f2626b39..feaf894ac118 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1760,7 +1760,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	struct pci_dev *pdev = vdev->pdev;
>  	unsigned int index;
>  	u64 phys_len, req_len, pgoff, req_start;
> -	int ret;
> +	void __iomem *bar_io;
>  
>  	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>  
> @@ -1794,12 +1794,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
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
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index f66ad3d96481..7f14dd46de17 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -198,26 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>  
> -int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
> -{
> -	/*
> -	 * The barmap is set up in vfio_pci_core_enable().  Callers
> -	 * use this function to check that the BAR resources are
> -	 * requested or that the pci_iomap() was done.
> -	 */
> -	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> -		return -EINVAL;
> -
> -	/* Did vfio_pci_core_map_bars() set it up yet? */
> -	if (!vdev->barmap[bar])
> -		return -ENODEV;
> -
> -	if (IS_ERR(vdev->barmap[bar]))
> -		return PTR_ERR(vdev->barmap[bar]);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
> -
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite)
>  {
> @@ -269,13 +249,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
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
> @@ -430,6 +408,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
>  	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
>  	struct vfio_pci_ioeventfd *ioeventfd;
> +	void __iomem *io;
>  
>  	/* Only support ioeventfds into BARs */
>  	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
> @@ -447,9 +426,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	if (count == 8)
>  		return -EINVAL;
>  
> -	ret = vfio_pci_core_setup_barmap(vdev, bar);
> -	if (ret)
> -		return ret;
> +	io = vfio_pci_core_get_iomap(vdev, bar);
> +	if (IS_ERR(io))
> +		return PTR_ERR(io);
>  
>  	mutex_lock(&vdev->ioeventfds_lock);
>  
> @@ -486,7 +465,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>  	}
>  
>  	ioeventfd->vdev = vdev;
> -	ioeventfd->addr = vdev->barmap[bar] + pos;
> +	ioeventfd->addr = io + pos;
>  	ioeventfd->data = data;
>  	ioeventfd->pos = pos;
>  	ioeventfd->bar = bar;
> diff --git a/drivers/vfio/pci/virtio/legacy_io.c b/drivers/vfio/pci/virtio/legacy_io.c
> index 1ed349a55629..c868b2177310 100644
> --- a/drivers/vfio/pci/virtio/legacy_io.c
> +++ b/drivers/vfio/pci/virtio/legacy_io.c
> @@ -299,19 +299,18 @@ int virtiovf_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>  static int virtiovf_set_notify_addr(struct virtiovf_pci_core_device *virtvdev)
>  {
>  	struct vfio_pci_core_device *core_device = &virtvdev->core_device;
> -	int ret;
> +	void __iomem *io;
>  
>  	/*
>  	 * Setup the BAR where the 'notify' exists to be used by vfio as well
>  	 * This will let us mmap it only once and use it when needed.
>  	 */
> -	ret = vfio_pci_core_setup_barmap(core_device,
> -					 virtvdev->notify_bar);
> -	if (ret)
> -		return ret;
> +	io = vfio_pci_core_get_iomap(core_device,
> +				     virtvdev->notify_bar);
> +	if (IS_ERR(io))
> +		return PTR_ERR(io);
>  
> -	virtvdev->notify_addr = core_device->barmap[virtvdev->notify_bar] +
> -			virtvdev->notify_offset;
> +	virtvdev->notify_addr = io + virtvdev->notify_offset;
>  	return 0;
>  }
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f..5598071c5ea3 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -188,7 +188,6 @@ int vfio_pci_core_match_token_uuid(struct vfio_device *core_vdev,
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
> -int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
>  pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
>  						pci_channel_state_t state);
>  ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
> @@ -234,6 +233,24 @@ static inline bool is_aligned_for_order(struct vm_area_struct *vma,
>  			   !IS_ALIGNED(pfn, 1 << order)));
>  }
>  
> +/*
> + * Returns a BAR's iomap base, or an ERR_PTR() if, for example, the
> + * BAR isn't valid, its resource wasn't acquired, or its iomap
> + * failed.
> + */
> +static inline void __iomem __must_check *
> +vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, int bar)
> +{
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Did vfio_pci_core_map_bars() set it up yet? */
> +	if (!vdev->barmap[bar])
> +		return ERR_PTR(-ENODEV);
> +
> +	return vdev->barmap[bar];
> +}
> +

Regarding the previously exported symbol, if the concern is that it was
a GPL symbol and now it's a static inline, it's not doing anything that
couldn't easily be open coded, so I don't see an issue.  Thanks,

Alex
