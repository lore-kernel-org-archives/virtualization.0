Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B1221FC1;
	Wed, 28 May 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472179; cv=none; b=BRpFgMHW4wS+mJc4qC4kWW4WJpFpSHUaHhz3px6bNKYKcTmhoMVfT20RaSWFle5fxuQ44d13HqZzsX6mSqKeuuXho1mTAQwOnlslzzut4xdXrsy0z0hdl7FPp1gw5SAzxP3/03qP+92WPrFVEP2p+SdmcYENUaVFfH7AY8YGORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472179; c=relaxed/simple;
	bh=2gBNwsOeGW7Yv6KEgKzYQWe+cGkLFTh7Ui3Y6qQWXVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2x10bzflxKaLFYIMh2LmYc6E7k2doqIIJ+JB4Becv0Y/FmiypYVY61HvFUAog++PegCd8s36gzlvyZYjUquLpg6zlgS/9kQChnYQ52Bb7pCLuj2giYZddasL6RSJ9KQRfFs/FH2NPjZ4z+xaST1cvn2ViVFCdH+Rvz6o9ZFIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eEO2qnr/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eEO2qnr/"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 112512068337;
	Wed, 28 May 2025 15:42:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 112512068337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748472177;
	bh=BBNnTlhHJfRhv50gKjTeM2IF6Sms1SVDjpmf3Got7WQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=eEO2qnr/d9KBIV2c9UfOMrsgOxO8ffJ8l9rq15vuEQBLDFh5iBI555Do3su8BZVjI
	 kLM+luZtvxH46g0otgcojJ+UHPeWMEbsvfAZyVUdSVvlv2DAxduzoBCXsWO9aXsDnK
	 tgc4dE26hxnh6h5muSK7GIUUmcJbcjj4uIw6yP7U=
Date: Wed, 28 May 2025 15:42:55 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 virtualization@lists.linux.dev, will@kernel.org, eric.auger@redhat.com,
 code@tyhicks.com, eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250528154255.769e07dc@DESKTOP-0403QTC.>
In-Reply-To: <20250528000425.GC146260@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
	<20250410230008.GA6905@ziepe.ca>
	<67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
	<20250416181759.GF493866@ziepe.ca>
	<20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20250525190703.GD12328@ziepe.ca>
	<20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20250528000425.GC146260@ziepe.ca>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Tue, 27 May 2025 21:04:25 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, May 27, 2025 at 01:54:28PM -0700, Shyam Saini wrote:
> > > The above is the only place that creates a IOMMU_RESV_SW_MSI so
> > > it is definately called and used, right? If not where does your
> > > IOMMU_RESV_SW_MSI come from?  
> > 
> > code tracing and printks in that code path suggests
> > iommu_dma_get_resv_regions() called by vfio-pci driver,   
> 
> Yes, I know it is, that is how it setups the SW_MSI.
> 
> > > As above, I've asked a few times now if your resv_regions() is
> > > correct, meaning there is a reserved range covering the address
> > > space that doesn't have working translation. That means
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
> 
Just to double confirm, the expected reserved region should be marked as
"direct" instead of "msi", right?

> > Yes, i tried that,
> > 
> > This is how my dts node looked like
> > reserved-memory {
> >                faulty_iova: resv_faulty {
> >                        iommu-addresses = <&pcieX 0x8000000
> > 0x100000>; };
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
> 
> So what is the problem if you have figured out how to fix up
> /sys/kernel/iommu_groups/Y/reserved_regions?
> 
> If you found some cases where you can't get /sys/../reserved_regions
> to report the right things from the DT then that needs to be addressed
> first before you think about fixing SW_MSI.
> 
> I very vaguely recall we have some gaps on OF where the DMA-API code
> is understanding parts of the DT that don't get mapped into
> reserved_regions and nobody has cared to fix it because it only
> effects VFIO. You may have landed in the seat that has to fix it :)
> 
> But I still don't have a clear sense of what your actual problem is as
> you are show DT that seems reasonable and saying that
> /sys/../reserved_regions is working..
> 
> Jason

