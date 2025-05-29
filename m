Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198B1D63D8;
	Thu, 29 May 2025 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748556528; cv=none; b=ecirKygmWMhMVH2ZZOLX1w6Nr2+XVqackcMP4DVJq1TlCReuRRs+66/hH+0K1yc+HBxbkpbnrWPgxk74RK/hs9QBzLlF40vf/edEBPRXgELSpb8B4cVa2+j7t5JSJCvb+Afdvip+I3icxNYdw/HO9i/E+30IE8i5yZC3OH6lljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748556528; c=relaxed/simple;
	bh=cGiGOMXLaYTmt7AaI+VhQm+s+r9LaPFKl+EsXixyGgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN2D1r1e/vxXPUXs3c+wJ7tbqKWYNDQ125QTvLgXJmGn2KrrI5uRbFprdscBO6fYhj+BzE3KnuE+DMCsYgSvm2tF+QVsQ+PHP9hAsgOt9rcsuBCtzaHV7s4HOJ3peHZ3GL+nDwynObR1QIpTWza+DTFEVk9+4a4upT2ubWaHZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LHMwxnqH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LHMwxnqH"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 055982078637; Thu, 29 May 2025 15:08:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 055982078637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748556520;
	bh=juarSgwBFGe3iViHJxllLX5IRN9Zg1P5MRm4SRs7zB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LHMwxnqHXXo3wa+V+35wQifLfvXLriHKHW5eGkkdJAjqAkADrNIZdIxDyen4qxLBx
	 4WjJ/ExVEV4qmWcel4XSNsNtuShzmN84HakhkafW1rJbAg1hkLGTLf1ayRVa6iaHer
	 IJoO60jJYrYbH59KUyDuBJZ/IbSn3zDGk7uP/yno=
Date: Thu, 29 May 2025 15:08:39 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250529220839.GA9911@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
 <20250529182219.GA20289@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250529183815.GA236098@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529183815.GA236098@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 29, 2025 at 03:38:15PM -0300, Jason Gunthorpe wrote:
> On Thu, May 29, 2025 at 11:22:19AM -0700, Shyam Saini wrote:
> > > All IOVA that the platform cannot DMA from should be reported in the
> > > reserved_regions file as "reserved". You must make your platform
> > > achieve this.
> > 
> > so should it be for all the iommu groups?
> > 
> >                 no_dma_mem {
> >                        reg = <0x0 0x8000000 0x0 0x100000>;
> >                         no-map;
> >                 };
> >  
> > i think that's how we reserve memory in general, eg: ramoops
> > but this doesn't show up in:
> >   /sys/kernel/iommu_groups/*/reserved_regions
> 
> I don't know anymore, I've forgotten these details about DT, you will
> need to consult with DT experts..

no worries, added maintainers and the list

> > > But I still don't have a clear sense of what your actual problem is as
> > > you are show DT that seems reasonable and saying that
> > > /sys/../reserved_regions is working..
> > 
> > /sys/../reserved_regions is working for certain devices like dma controller
> > but it doesn't work for pcie devices and its vfio-pcie driver calling
> > iommu_get_resv_regions() but we don't have dts node for vfio.
> > I have confirmed this about pcie on two different platforms, it seems to be
> > OF DMA-API gap that you hinted above, happy to work on that :), it would be
> > great if you can share any other reference discussions to that problem
> 
> Some of it was around the dma_mask and the ranges, but I'm not sure
> exactly what is your issue here..
> 
> It is very important the the dma-iommu.c code also knows not to use
> the non-working IOVA or your system will be buggy and eventually fail.
> If that isn't happening you have a critical bug beyond the SW_MSI
> issue.

thanks, i will look into this

> The easiest way to fix it is to have reserved_regions report the right
> stuff.
> 
> > When i specify this for dma controller:
> > 
> > 		faulty_iova: resv_faulty {
> > 			iommu-addresses = <&dmaX 0x8000000 0x100000>;
> > 		};
> > &dmaX {
> > 	memory-region = <&faulty_iova>;
> > };
> > 
> > I see following:
> > $ cat /sys/kernel/iommu_groups/y/reserved_regions 
> > 0x0000000008000000 0x00000000080fffff reserved
> > 0x00000000a0000000 0x00000000a00fffff msi
> 
> See, that looks better. You need to make that happen for all the
> effected devices.
> 
> > Upon investigation, our hardware team confirmed that the memory region
> > containing 0x08000000 is already mapped for other peripherals, making it
> > unavailable for MSI usage.
> 
> See, that's just wrong HW design. The path from PCI to the SMMU should
> not have any other decodes on it, isn't that SBSA?

I am not 100% sure

> How does your platform work at all? Isn't 0x08000000 physical memory in
> your address map? 

unfornately, this 0x08000000 physical address is not in our address map

Thanks,
Shyam
