Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44C1B85C5;
	Tue, 21 Jan 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496160; cv=none; b=HJ1XWvL/PFPCiBwrA6sATCu8boI4Ld7fWPAQy8TKQDWpe7P9N0Z6u+NDsovAC5+MO7AblluGs5nhwLY1DQcL+Au7I+GnJ0GaaVMQ+/ZUq8TXA3o7smTOL7Wva57HAxfHWooeYGBw5zCOtc93tbUdgB3vj2A6Ukl0CQqTmrcsScc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496160; c=relaxed/simple;
	bh=/CxD3M7Lbs0okD8Rf4npomzQ6l6xnlT+owgsJ2n+7I8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX/4J2dlU5oqzp6i6fPGxx//CuWef56APEKvaAsmI4PTgwcU0F8a0CacuHQQ9WIOuQYWJiIxe14O8AoZrkZ+z5wnAZHcAL8tihCekLes5flPvLxPuBdzLZ/dtYk4hV6ERErsvEn1QHXzIY+pP34Bwj8I1E4hJhc4thGKmcSMrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AnhMTBG5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AnhMTBG5"
Received: from DESKTOP-0403QTC. (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D406205A9EC;
	Tue, 21 Jan 2025 13:49:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D406205A9EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737496152;
	bh=CRKKcyPjoabyj6UhYawNm7cMg5b+yHqOJ+jXOfGN160=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=AnhMTBG5w0v57AHdyDrH4rfPMLpZGLXbxSxM/kulCk1lIzsyrkv2JKeRXmYR7oW/p
	 uiXeHo2ayumznqIIaVwHPWld1D4Ep4fJEXar+ZvMO7uvNCQEG0aKLI+e0g1YQexhZR
	 xSem6n7ei8EIEw2f0J3o8+6OA/3FR7fFnMikja4s=
Date: Tue, 21 Jan 2025 13:49:10 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 virtualization@lists.linux.dev, will@kernel.org, eric.auger@redhat.com,
 code@tyhicks.com, eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250121134910.11797062@DESKTOP-0403QTC.>
In-Reply-To: <20250120142643.GM674319@ziepe.ca>
References: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
	<20250120142643.GM674319@ziepe.ca>
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

On Mon, 20 Jan 2025 10:26:43 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Jan 16, 2025 at 03:23:04PM -0800, Shyam Saini wrote:
> > Hi,
> > 
> > Currently, the MSI_IOVA_BASE address is hard-coded to 0x80000000,
> > assuming that all platforms have this address available for MSI IOVA
> > reservation. However, this is not always the case, as some platforms
> > reserve this address for other purposes.  
> 
> Can you explain this some more? This address is in the kernel
> controlled IOVA space, there are few ways a platform can impact this.
> 
> How is the platform impacting it? Is the non-functional IOVA always
> reflected in the iommu_get_resv_regions()?

I don't know the platform impact but just to clarify, are you asking
whether this non-functional IOVA is also under IORT RMR or other FW
tables? I don't think it is.

But this special IOVA is reflected in iommu_get_resv_regions() the same
way as the hardcoded MSI_IOVA_BASE. So each iommu group's
reserved_regions should show.

> Why not avoid this conflict in your platform software?
I had the same question but it seems there is not enough difference
(than the standard smmu) to justify a platform code. i.e. platform
specific iommu_get_resv_regions(), is that what you are suggesting?

> > There was an [1] attempt to fix this problem by passing the MSI IOVA
> > base as a kernel command line parameter.   
> 
> Yuk
> 
> > In the previous attempt,
> > Will suggested reserving the MSI IOVA at runtime whenever there is a
> > conflict with the default MSI_IOVA_BASE. However, dynamically
> > reserving this address has debuggability concerns, as it becomes
> > difficult to track IOMMU mapping failures.  
> 
> Still, this approach seems like the best to me..
> 
> > This patch series aims to address the issue by introducing a new DTS
> > property, "arm,smmu-pci-msi-iova-data". This property allows the
> > configuration of MSI IOVA with a custom MSI base address and a
> > custom length for IOMMU/SMMU drivers. It accommodates platforms
> > that do not have the default MSI base address available for MSI
> > reservation.  
> 
> My understand was using DT to set kernel configurables was frowned
> upon? Ultimately MSI_IOVA_BASE is an arbitary choice by kernel
> software.
> 
> Jason

