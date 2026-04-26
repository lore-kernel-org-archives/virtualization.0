Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922B783A14;
	Sun, 26 Apr 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201524; cv=none; b=ERGNi/brLRBd8ATgjjc+jPfr2oHeC1Gk0CKSxhCvX1nvZIYejeCFRdG4pcJQpFLQ8Z/QcySoilX47nhNozvrXXseveY8i4m1IY/7N5OkGn7oO+ivZQPQupKiIB4E2bvaoSz9Kiool34PyTSzjEGzjoST7gYUoxw8Q9H3exFLPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201524; c=relaxed/simple;
	bh=T8PZsTWRmGPxDQZ9K0n9ZD4B8ab2lpKvy3Anau/SJBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+cyuK/TKhDCFuzrUUJPLzPydgSoEn/R2NNVvpIeUlW6cmO1EAGD+8SBqxsq95YfCIcFgclhgMdbmulMNJOAuMPli0x3wsE1rvyLNNkWhavAJ8HCDFicMGoPZRkCKN2j6QJ75XcR6dFuu43QX/l32fnM/OpfruHmxEa9WjuXNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSpBs5hk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSpBs5hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E94C2BCAF;
	Sun, 26 Apr 2026 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777201524;
	bh=T8PZsTWRmGPxDQZ9K0n9ZD4B8ab2lpKvy3Anau/SJBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSpBs5hkoBlpY54b5XwS79il5lhgBSMA9/eS2d14ECcuuCeGu5/hyE1X73bMn95UN
	 yyR4da5LTQYPyHc/nmSvzGTtb1gAicZEin//zV89WTCWr5IwzxJIed7PeAHHQrd3nq
	 3bVGa8rb5iX14VTkKGdPy+KUdd54jJMl6R5MpT2X5Vk16W3gxevALDadG5wAJMf9jd
	 T9+Qpp0Fy8meB+SSjDnPeLVwgIaVXB/m6imidmn1SRTc+84/oeXIV2YW1B+0qSe0pq
	 kbhrFNzPMvN3LdrguRVOh9rPnPS8d5Egt4N0Y75nS3gRFuJGxv6pjqGBJbT4lgc8p3
	 +llv2+APbnNGQ==
Date: Sun, 26 Apr 2026 14:05:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matt Evans <mattev@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>, Kees Cook <kees@kernel.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with checks for resource/map
Message-ID: <20260426110517.GB440345@unreal>
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-3-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423182517.2286030-3-mattev@meta.com>

On Thu, Apr 23, 2026 at 11:25:08AM -0700, Matt Evans wrote:
> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
> resource request and iomap for the BARs was performed early, and
> vfio_pci_core_setup_barmap() now just checks those actions succeeded.
> 
> There were two types of callers:
>  - Those that need the iomap, because they'll access the BAR
>  - Those that need the resource, because they'll map/export it
> 
> This replaces vfio_pci_core_setup_barmap() with two helpers,
> vfio_pci_core_check_barmap_valid() and vfio_pci_core_check_bar_rsrc(),
> to make it clear which behaviour is required in each caller.
> 
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c |  8 +++-----
>  drivers/vfio/pci/vfio_pci_core.c    |  5 ++---
>  drivers/vfio/pci/vfio_pci_rdwr.c    | 22 ++--------------------
>  drivers/vfio/pci/virtio/legacy_io.c |  4 ++--
>  include/linux/vfio_pci_core.h       | 23 ++++++++++++++++++++++-
>  5 files changed, 31 insertions(+), 31 deletions(-)

<...>

> +/* Returns 0 if vdev->barmap[bar] can be accessed, otherwise errno */
> +static inline int
> +vfio_pci_core_check_barmap_valid(struct vfio_pci_core_device *vdev, int bar)
> +{
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +	if (vdev->barmap[bar] == 0)

I understand this line was copied from an earlier implementation, but
barmap[bar] is a pointer, and it is set to NULL when it is released.

 if (!dev->barmap[bar])
   return -ENOMEM;

Thanks

> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +/* Returns 0 if BAR has a valid resource reserved for use, otherwise errno */
> +static inline int vfio_pci_core_check_bar_rsrc(struct vfio_pci_core_device *vdev,
> +					       int bar)
> +{
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +	if (!vdev->have_bar_resource[bar])
> +		return -EBUSY;
> +	return 0;
> +}
> +
>  static inline bool is_aligned_for_order(struct vm_area_struct *vma,
>  					unsigned long addr,
>  					unsigned long pfn,
> -- 
> 2.47.3
> 
