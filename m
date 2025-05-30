Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5662BA36;
	Fri, 30 May 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640648; cv=none; b=sZhht16XCnOXRrB+csszcCcTROTc88hizD9YmHxDUPt6qPECnvH6W0u5TNyws8i0YGrlRXwyI2vLVuKt3qLEw9Y2XuawqvHOsX57ykvkH85Tj/oi1fqsvMYFSM2vAdobPr6dFojY8pfM6H93ik5SFBJQMGgBBseMhxaNin0eBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640648; c=relaxed/simple;
	bh=ZvHTUUrkzBkwuUj6TKjjqHBsV6QqHhnxPn7h3nD+YZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7osR8kjO8qQdnDZjRDSS1gqPtOk1wtn4Zws+1s/P4pemDREPULK1bfgUbUA10rN9ZbvFennGnLmZ1/WFuXzH2ZFNPhvaRjoAKBE4wHS4xp+Ua02SimPQRGI9494os9dVNtSToKXB/9QL6B4CrHsrpRnwemMD2veiyYv46ju+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OWRQTxL6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OWRQTxL6"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 366942113A61; Fri, 30 May 2025 14:30:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 366942113A61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748640646;
	bh=P+xpyLgkx3NxlBQZizLlW9t13l6riTws+UBfMfvteTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWRQTxL6E48CZlvqdoqH+qgYZTbGwXOTN7cb8ZfJ/gHqlckSdz5BYGGewCF0rYGUF
	 h4TDa4EDlcI59i+dC3XP5YcclkB1yNJ2GQeZC/t49MJVU07DMmWxcJ950iKxT+uNcv
	 42tq9Q4U+P0uAiGNxMkDQXxmVQCIMIpBcaxJqf7o=
Date: Fri, 30 May 2025 14:30:46 -0700
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Jacob Pan <jacob.pan@linux.microsoft.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250530213046.GA27644@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250525190703.GD12328@ziepe.ca>
 <20250527205428.GA14019@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250528000425.GC146260@ziepe.ca>
 <20250529182219.GA20289@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250529183815.GA236098@ziepe.ca>
 <20250529220839.GA9911@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250530131328.GB236098@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530131328.GB236098@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jason,

On Fri, May 30, 2025 at 10:13:28AM -0300, Jason Gunthorpe wrote:
> On Thu, May 29, 2025 at 03:08:39PM -0700, Shyam Saini wrote:
> > > How does your platform work at all? Isn't 0x08000000 physical memory in
> > > your address map? 
> > 
> > unfornately, this 0x08000000 physical address is not in our address map
> 
> Is your issue PCI related, do you have a PCI switch without ACS mapped
> here?

this platform that we are discussing doesn't have ACS caps, it relies on pci
ACS quirk.

Thanks,
Shyam
