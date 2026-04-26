Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1A201278;
	Sun, 26 Apr 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202171; cv=none; b=mvKE+xvgCIIxGePtWyN5eoNHhtyM6YsR4U0MOZvqGxuGsixnmpDwin3ZeBvAe99DqkFHH4EKjIisfYzOs/wVeZ7yxXGpKoY8EBqcdu6URBePSgHF6zkehc/Mxe7Zw77q1OTD4WsuUqPXJEDNtsu9OR6Gc67uwMAY+qo8gjCrnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202171; c=relaxed/simple;
	bh=Wn2FRa5CGuL62SGQEo1Ts5OEuIpTDHE10o9+L8T2HW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7Ntc8mhHN73VA+qTyFc9fGcOBd+bKXpxF3QIgR19c41T7VD8SlidMWRCjOJWCWwy7ZM1JN/+VINt+CoFxG4gHOKkjpUhWyqF5dWIorQVK7GXuQfMQ30r1bDT+fBnBlIomxmfjydiDuS+q7obwE7YC05VfejIgQ0LtmeTBLjADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bffs8Sql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bffs8Sql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5589C2BCAF;
	Sun, 26 Apr 2026 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777202171;
	bh=Wn2FRa5CGuL62SGQEo1Ts5OEuIpTDHE10o9+L8T2HW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bffs8Sqla4K8yZAcERyMs2wMx+4HAEyv3CllkIZclJ7Uh7Fzt6U7yyMPMIvDhdLGi
	 cIbmHPZ0PPaBlsW5O2gqmf1b7A3xRba/LaYHzFrIs31E0iYbyAET9ehMfrJro1Ga3P
	 JqxJFrqqaMauWAikdOATba+e+Drv41x5SOMsQ7553xoI7iQPFw+z9kyY0vbdg4PRhh
	 M1Xu4y5lhpdP1nYloyYlEl9rgNwzvJqUIrQQQxHjm/zGPP5J4Sdq2YDNtzM7mEgtd2
	 faQkwWsCDW2a7H/rlBX6qhx7H9X/wpGGWnN1IvWpCGvxt8qryKFiHvjPuBRihvymu/
	 4mWAqbJiz4UKA==
Date: Sun, 26 Apr 2026 14:16:06 +0300
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
Subject: Re: [PATCH v2 3/3] vfio/pci: Check BAR resources before exporting a
 DMABUF
Message-ID: <20260426111606.GC440345@unreal>
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-4-mattev@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423182517.2286030-4-mattev@meta.com>

On Thu, Apr 23, 2026 at 11:25:09AM -0700, Matt Evans wrote:
> A DMABUF exports access to BAR resources and, although they are
> requested at startup time, we need to ensure they really were reserved
> before exporting.  Otherwise, it's possible to access unreserved
> resources through the export.
> 
> Add a check to the DMABUF-creation path.
> 
> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> Signed-off-by: Matt Evans <mattev@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
