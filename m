Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7C218EBA;
	Thu, 29 May 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542941; cv=none; b=Sv1Om1Bvpy99unPjnRRtbOuGAJX2GaryfJn+eVPf5AgAMxAaKFjYqP/Qcrr5hG5Y5K560mbl61grj3zw/3ndHk2Hdh+CDAQv+o4HQfqtwzF7EGjZaX2SK/DVROtk2WLM2neJvtp3ha6mpF6KJrntwruaSIl5AVu3Wco2/1NompQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542941; c=relaxed/simple;
	bh=IxRUv0yRFXS7zWyuEDMfUlf6Imbrrv1oX3cFtlL/1wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTwvEK69sIelHtmLI1P8Ff2U+16CoTuYFcZP7O1Bhqs8uzUl0ioajHk7vT75vIXGQbsvTvW7Q1QKXIALTPCZQiTrGAjk4wutWjBryoLvJwqk5QlDId/R03jSwjPQ1h6Q4zJQDsg+lbeQ1pV0Au4gTLuKBJKTd+pkYKXb+bJA9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WRwwteRk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WRwwteRk"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 8A59F2078632; Thu, 29 May 2025 11:22:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A59F2078632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748542939;
	bh=YNUyfyg1HbaBDiYAUpaOAIe/tOlUxr3f8C7O9P4Zl4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRwwteRkcy3o05WG0KDJfOEL2Sk4Q0gxIYKM00uEeHmjwhMdhh3RPW5hTfEXDrgeK
	 D5FSvORQZBKOdYa1WdudMDFpbVX5ye5V4OFoSwcKLpkSB90tX/RplK4BzifQMiVk0z
	 zaU1gr1yS/SiWZkwTBSbD5y5cmDQuSkEEGw2oZ4Q=
Date: Thu, 29 May 2025 11:22:19 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250529182219.GA20289@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528000425.GC146260@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 27, 2025 at 09:04:25PM -0300, Jason Gunthorpe wrote:
> On Tue, May 27, 2025 at 01:54:28PM -0700, Shyam Saini wrote:
> > > The above is the only place that creates a IOMMU_RESV_SW_MSI so it is
> > > definately called and used, right? If not where does your
> > > IOMMU_RESV_SW_MSI come from?
> > 
> > code tracing and printks in that code path suggests iommu_dma_get_resv_regions()
> > called by vfio-pci driver, 
> 
> Yes, I know it is, that is how it setups the SW_MSI.
> 
> > > As above, I've asked a few times now if your resv_regions() is
> > > correct, meaning there is a reserved range covering the address space
> > > that doesn't have working translation. That means
> > > iommu_get_resv_regions() returns such a range.
> > 
> > sorry about missing that, i see msi iova being reserved:
> > 
> > cat /sys/kernel/iommu_groups/*/reserved_regions
> > 0x0000000008000000 0x00000000080fffff msi
> > 0x0000000008000000 0x00000000080fffff msi
> > 0x0000000008000000 0x00000000080fffff msi
> > 0x0000000008000000 0x00000000080fffff msi
> > [output trimmed]
> 
> But this does not seem correct, you should have a "reserved" region
> covering 0x8000000 as well because you say your platform cannot do DMA
> to 0x8000000 and this is why you are doing all this.
> 
> All IOVA that the platform cannot DMA from should be reported in the
> reserved_regions file as "reserved". You must make your platform
> achieve this.

so should it be for all the iommu groups?

                no_dma_mem {
                       reg = <0x0 0x8000000 0x0 0x100000>;
                        no-map;
                };
 
i think that's how we reserve memory in general, eg: ramoops
but this doesn't show up in:
  /sys/kernel/iommu_groups/*/reserved_regions

 
> > Yes, i tried that,
> > 
> > This is how my dts node looked like
> > reserved-memory {
> >                faulty_iova: resv_faulty {
> >                        iommu-addresses = <&pcieX 0x8000000 0x100000>;
> >                };
> >                ..
> >                ..
> > }
> > 
> > &pcieX {
> >     memory-region = <&faulty_iova>;
> > };
> > 
> > I see it working for the devices which are calling
> > iommu_get_resv_regions(), eg if I specify faulty_iova for dma
> > controller dts node then i see an additional entry in the related
> > group
> 
> Exactly, it has to flow from the DT into the reserved_regions, that is
> essential.
 
> So what is the problem if you have figured out how to fix up
> /sys/kernel/iommu_groups/Y/reserved_regions?

sorry, i haven't yet
 
> If you found some cases where you can't get /sys/../reserved_regions
> to report the right things from the DT then that needs to be addressed
> first before you think about fixing SW_MSI.
> 
> I very vaguely recall we have some gaps on OF where the DMA-API code
> is understanding parts of the DT that don't get mapped into
> reserved_regions and nobody has cared to fix it because it only
> effects VFIO. You may have landed in the seat that has to fix it :)

I think this is the case we are dealing with?

> But I still don't have a clear sense of what your actual problem is as
> you are show DT that seems reasonable and saying that
> /sys/../reserved_regions is working..

/sys/../reserved_regions is working for certain devices like dma controller
but it doesn't work for pcie devices and its vfio-pcie driver calling
iommu_get_resv_regions() but we don't have dts node for vfio.
I have confirmed this about pcie on two different platforms, it seems to be
OF DMA-API gap that you hinted above, happy to work on that :), it would be
great if you can share any other reference discussions to that problem

When i specify this for dma controller:

		faulty_iova: resv_faulty {
			iommu-addresses = <&dmaX 0x8000000 0x100000>;
		};
&dmaX {
	memory-region = <&faulty_iova>;
};

I see following:
$ cat /sys/kernel/iommu_groups/y/reserved_regions 
0x0000000008000000 0x00000000080fffff reserved
0x00000000a0000000 0x00000000a00fffff msi

Clarifying the Issue with MSI and SMMU Faults on Our Platform:

We are encountering SMMU faults when using our userspace tool/driver that
relies on MSI. Specifically, the issue arises when the MSI_IOVA_BASE is set
to the current default value of 0x08000000.

The observed fault is as follows:

arm-smmu 64000000.iommu: Unhandled context fault: fsr=0x402, iova=0x00000040,
fsynr=0x2f0013, cbfrsynra=0x102, cb=15

Upon investigation, our hardware team confirmed that the memory region
containing 0x08000000 is already mapped for other peripherals, making it
unavailable for MSI usage.

eg: using 0xa0000000 as MSI_IOVA_BASE solves our problem.

let me know if you have any other questions

Thanks,
Shyam
