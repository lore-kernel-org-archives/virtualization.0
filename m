Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6B207A27;
	Tue, 27 May 2025 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379270; cv=none; b=dNRddONculgeCUH/z/SWZwc7NILiwj+675SOEh2i/rctFzsjNbylmmAWvrrCgpMZrNlGMRi4PxsfeMqP5P2+ba26uYfhHtuuYsImlRDIJh6BCHAbuAeRqMG4nlayfhhR9ZbS/ahEKYe/ZAM7Z5KBKNcAPEoXxi65E9cORZxnicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379270; c=relaxed/simple;
	bh=7GKxYuv5Vr/d8b2IGkk6xvPMU5lRg1mooQDF7lgAReM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOIGG0oM8FRobnw6V094SvdGEjsZwpXTU2REvZCeQakUI7QvB3c1MqZO0F70KmXyQqVkj1pBP4tshciOoomeOKRn7VkDop+MrSl/EyAnnLM7O5C6Zt23zBUvXSporaqvreDn22DBoL70ieeZ+Bn2MKJLUQqlXsXT9szcaKkP9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=euIM5FSt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="euIM5FSt"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 6047B206B75B; Tue, 27 May 2025 13:54:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6047B206B75B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748379268;
	bh=/nOb2IbI84Kaa2XFPBAKF8GWOnZOxE+uNv5R7RcONAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euIM5FSt51mWaeFVaqjKxwKE1Ny8Fhawc0URU7A/KkGCox3iJnuNHnVHXO+27cESv
	 ufjqo7aC9fVMct8gfNCgoR0V3enjOhaXtK5ZrMSKj5PC+kRhrFohDNsUcxM4JxmjIn
	 2TXRd+aZlZ8ZI0nFgb294FotquDG+hPCMs3VABEA=
Date: Tue, 27 May 2025 13:54:28 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525190703.GD12328@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, May 25, 2025 at 04:07:03PM -0300, Jason Gunthorpe wrote:
> On Tue, May 20, 2025 at 03:42:24PM -0700, Shyam Saini wrote:
> > Hi Jason,
> > 
> > apologies for the delayed response.
> > 
> > > On Wed, Apr 16, 2025 at 11:04:27AM -0700, Jacob Pan wrote:
> > > 
> > > > Per last discussion "SMMU driver have a list of potential addresses and
> > > > select the first one that does not intersect with the non-working IOVA
> > > > ranges.". If we don't know what the "non-working IOVA" is, how do we
> > > > know it does not intersect the "potential addresses"?
> > > 
> > > I had understood from previous discussions that this platform is
> > > properly creating IOMMU_RESV_RESERVED regions for the IOVA that
> > > doesn't work. Otherwise everything is broken..
> > > 
> > > Presumably that happens through iommu_dma_get_resv_regions() calling
> > > of_iommu_get_resv_regions() on a DT platform. There is a schema
> > > describing how to do this, so platform firmware should be able to do it..
> > > 
> > > So the fix seems trivial enough to me:
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index b4c21aaed1266a..ebba18579151bc 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -3562,17 +3562,29 @@ static int arm_smmu_of_xlate(struct device *dev,
> > >  static void arm_smmu_get_resv_regions(struct device *dev,
> > >  				      struct list_head *head)
> > >  {
> > > -	struct iommu_resv_region *region;
> > > -	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > > -
> > > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> > > -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> > > -	if (!region)
> > > -		return;
> > > -
> > > -	list_add_tail(&region->list, head);
> > > +	static const u64 msi_bases[] = { MSI_IOVA_BASE, 0x12340000 };
> > >  
> > >  	iommu_dma_get_resv_regions(dev, head);
> > 
> > my understand is, this hook is not called for all the devices, eg: pcie dts node
> > doesn't use [1] "iommus" property instead it uses "iommu-map" property
> > as a consequence, [1] while loop exits prematurely and iommu_dma_get_resv_regions()
> > is not called, so there is no IOVA reservation for the pcie device. 
> 
> I can't really understand this sentance.
> 
> The above is the only place that creates a IOMMU_RESV_SW_MSI so it is
> definately called and used, right? If not where does your
> IOMMU_RESV_SW_MSI come from?

code tracing and printks in that code path suggests iommu_dma_get_resv_regions()
called by vfio-pci driver, i didn't mention vfio-pci in my last reply since it
doesn't have an associated device tree node, sorry about that

By enabling this [1] dev_dbg message i get this:

vfio-pci 0000:01:00.2: device is behind an iommu

In case of 0000:01:00.2 device, when it invokes iommu_dma_get_resv_regions(),
code hit [2] this path

> 
> This function is also the only thing that computes the reserved ranges
> that iommu_get_resv_regions() returns.
> 
> As above, I've asked a few times now if your resv_regions() is
> correct, meaning there is a reserved range covering the address space
> that doesn't have working translation. That means
> iommu_get_resv_regions() returns such a range.

sorry about missing that, i see msi iova being reserved:

cat /sys/kernel/iommu_groups/*/reserved_regions
0x0000000008000000 0x00000000080fffff msi
0x0000000008000000 0x00000000080fffff msi
0x0000000008000000 0x00000000080fffff msi
0x0000000008000000 0x00000000080fffff msi
[output trimmed]

> 
> If you don't have that then you have a bigger platform problem, IMHO,
> as vfio/iommufd only respect reserved ranges.
> 
> Otherwise, what is the issue you see, exactly? Did you even try it?
> 

Yes, i tried that,

This is how my dts node looked like
reserved-memory {
               faulty_iova: resv_faulty {
                       iommu-addresses = <&pcieX 0x8000000 0x100000>;
               };
               ..
               ..
}

&pcieX {
    memory-region = <&faulty_iova>;
};

I see it working for the devices which are calling iommu_get_resv_regions(), eg if I
specify faulty_iova for dma controller dts node then i see an additional entry
in the related group, say Y: /sys/kernel/iommu_groups/Y/reserved_regions

Did i misunderstood? appreciate your help on this

Thanks,
Shyam

[1] https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/of/device.c#L170
[2] https://elixir.bootlin.com/linux/v6.15-rc7/source/drivers/iommu/of_iommu.c#L145
