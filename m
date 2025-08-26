Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CA1C6FE8;
	Tue, 26 Aug 2025 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170959; cv=none; b=Z+dM1il93+jhHrfGza9fgnHxVR9lx09Wa1Dl1K3ZMFT08PH08mEfA97zPiLRNOYj4+6VSdMhj6v/rDM2kMZS+QMrrV1E8oOFDJ+2FuhhWEnxS/yLp6pViAX5xop+ogefrg+x8X1kEhh0ylnpzS18uGnLgxJ5oVQzYgOGw0dXa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170959; c=relaxed/simple;
	bh=kwE9T2napWDQIi8ICaB3dOVpNakmaY8PwBjAto4q6z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTx7R+N8qeQQ/hH2GIHvsMqSM95llg5MkGksJZT6J/Aj74Z6fPJJdSbwabEqmp3tquGcic4gZcATn81DWqc/smYfA7vyw7uResrfNjyC9rFez/zPatS8dWdDTQ2nv1zrNmbZ99p5l61soj97wZfZjXCA4mkGXgkU0FLMIQPx7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SCOaDPbr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SCOaDPbr"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id EC06C211829B; Mon, 25 Aug 2025 18:15:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC06C211829B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756170957;
	bh=BDhBrrex6g5QaN9laTXmAgCa/05IrHo33281B3Hc3OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCOaDPbrhTWDx26NAZDc9zk+UaPWJQFOnMx5s6aDmbJWEJtnk+D0lvohw3+XojSPK
	 Qv3pWi6wrhkhJMYhP0mVuPXz/iBl6yuihWoQs/Zmwfrsd+rddgzfRP3dWr8jAaSeUM
	 F+DYnYoRI+Wyl5NUEWaHe385v3/AAG5+kS1Nf69M=
Date: Mon, 25 Aug 2025 18:15:57 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com, robh@kernel.org,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI
 devices
Message-ID: <20250826011557.GA2980@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
 <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250815003958.GE599331@ziepe.ca>
 <20250815023236.GA30997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250818155310.GG599331@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818155310.GG599331@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jason,

On Mon, Aug 18, 2025 at 12:53:10PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 14, 2025 at 07:32:36PM -0700, Shyam Saini wrote:
> > On Thu, Aug 14, 2025 at 09:39:58PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 14, 2025 at 04:30:18PM -0700, Shyam Saini wrote:
> > > > or were you referring to [2]?
> > > > 
> > > > In that case, the PCI child node data needs to be parsed, which is
> > > > currently handled individually by each host controller driver.
> > > 
> > > Yes, this looks like it may be what I was thinking of, the pci@1,0
> > > specifes the BDF effectively
> > 
> > In that case, we'll need to parse the child DTS nodes properly
> > within of_iommu_get_resv_regions(). I'll include this in v4.
> 
> Kinda surprised this isn't happening already? It would be good to
> refer to the original specs and describe how whatetever you propose is
> aligned there.

Just to confirm, does the v3 version of this series look good to you?
If so, I’ll go ahead and respin the series with the iommu_set_sw_msi()
change and address the other review comments from Jacob.

Otherwise having pci devices nodes in the fdt or dts needs additional
handling, let me know your preference :)

> 
> > > Presumably this is a fixed issue of the platform. You never did
> > > explain how your system has such werdio behavior, or how something
> > > like iommu=pt can function on it...
> > Yes, this issue is platform-specific. On this platform, the default MSI IOVA
> > range overlaps with an address region that is reserved for another purpose,
> > Other than that we haven't observed any obvious issues for DMA operations
> 
> Usually DRAM is at the default MSI IOVA address, so if you run
> iommu=pt then presumably your DRAM map has a nice hole in it.. But
> maybe the memory map told the OS about that.
>
 
our DRAM for this platform starts at higher offset, way beyond MSI_IOVA.


Thanks,
Shyam 
