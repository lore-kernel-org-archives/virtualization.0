Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565041BCA19;
	Thu, 30 Jan 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279299; cv=none; b=YkpVpKbe9YcXrTa9eVppvVgN6Cv7LBNNIZngOI456DldPif3xkhvwwfo6iWQnNvRBvWTRiDgE+W+KM4qcgNySGLBNLfldjAiEDWi0BimZMhqmx1YKeQwMf1uL3uJjTg2zB9UM/nI8MDNY+5SciIDN0mhuOPkHpkFnVa+Fc+fT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279299; c=relaxed/simple;
	bh=R6X/7sY7ocgSMPkpP4c8Bi44j9vvoJF8tlv8eIpjY2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OejOcZYARDOQcLxHS7Vl/Dzj+j2gitGzplBDawTwMf79KTjrNN8w/bTuxYYfquNvJJusEozaZqMEO8z7BENnRgs5S3+J0Qunvrk8+wzGHZXrKLk+8YTiQRo9Caflr845crp4GlarafoH6zsBqKxh8CIHT1y2MHmTRM5GI1OObOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MIcR8ice; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MIcR8ice"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 905C92109CFE; Thu, 30 Jan 2025 15:21:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 905C92109CFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738279297;
	bh=AGuysM/Bjj0ONpOPPfU5fE2E0xCxqB9WfBikr1jbeyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIcR8ice7xefiWpV+MDI9m+ggfFAsrrfOqh41JrzHYFs5HKza7PZg5WWqrG0sp+mI
	 SHBL24uGENLjYmvamJ2Ilcn5OjnROY0ol9G2DAz8vLWfZxvFGLDruWkoHc8Cc9ZwMA
	 IuYu804xIKrL6FSigmRolmWBtGCsTRCrCAbBj06I=
Date: Thu, 30 Jan 2025 15:21:37 -0800
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250130232137.GA14836@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
 <20250120142643.GM674319@ziepe.ca>
 <67901659.170a0220.20b206.f1f5SMTPIN_ADDED_BROKEN@mx.google.com>
 <20250122001924.GT674319@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122001924.GT674319@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jason,

Apologies for delayed reponse,

> On Tue, Jan 21, 2025 at 01:49:10PM -0800, Jacob Pan wrote:
> 
> > > On Thu, Jan 16, 2025 at 03:23:04PM -0800, Shyam Saini wrote:
> > > > Hi,
> > > > 
> > > > Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> > > > assuming that all platforms have this address available for MSI IOVA
> > > > reservation. However, this is not always the case, as some platforms
> > > > reserve this address for other purposes.  
> > > 
> > > Can you explain this some more? This address is in the kernel
> > > controlled IOVA space, there are few ways a platform can impact this.
> > > 
> > > How is the platform impacting it? Is the non-functional IOVA always
> > > reflected in the iommu_get_resv_regions()?
> > 
> > I don't know the platform impact but just to clarify, are you asking
> > whether this non-functional IOVA is also under IORT RMR or other FW
> > tables? I don't think it is.
> 
> No, I'm asking how can you possibly have a HW platform where
> MSI_IOVA_BASE is unable to be used for DMA?
> 
> MSI_IOVA_BASE is 128M, and most ARM platforms put DRAM starting at
> 0. Most ARM VMMs put DRAM starting at 0 too.
> 
> So a platform saying that DMA to 128M doesn't work is pretty broken,
> to the point it is hard to believe there is a HW issue at work here?

Correct, this is limitation with our HW.
Since we can't fix it in hardware, we would need to fix it in Linux.

> > But this special IOVA is reflected in iommu_get_resv_regions() the same
> > way as the hardcoded MSI_IOVA_BASE. So each iommu group's
> > reserved_regions should show.
> 
> That's great
> 
> > > Why not avoid this conflict in your platform software?
> > I had the same question but it seems there is not enough difference
> > (than the standard smmu) to justify a platform code. i.e. platform
> > specific iommu_get_resv_regions(), is that what you are suggesting?
> 
> And here I mean, why not stop marking it reserved in the ACPI/DT
> inside your firwmare or hypervisor?

even if we reserve it in dts we would still need some address reserved for MSI IOVA

> This smells like some SW component using the same address Linux uses
> for some odd purpose. Just change it and let Linux keep using the
> address it wants?

Unfortunately, it is an HW issue.

Are you okay with this passing custom MSI_IOVA via DTS approach ?

Thanks,
Shyam

