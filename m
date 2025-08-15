Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5339295504;
	Fri, 15 Aug 2025 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225158; cv=none; b=VNtTZGmZAHbWypZklECMGpDbwppu7ughgaTFONmWKWYcz1BWYQPJYD9l8bjhsr59Yk59WH1Q9QOL5HquaR6ZZkyjCCxAyb2OjP3urBz7toCmxtWpXrLb5Lr1/OXP4A5E0BA7bg7O6fmRlF4bKr3LXZZ7GEi2pMOhbUbFXIfzC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225158; c=relaxed/simple;
	bh=jb5aUAIOPmXQlX/Gkg+Ce77q59K2k4DHix2ig07Lyyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQOv0Q6hScSFivK9FoPYAoM27WjuItrLrd+PvWwVWLB/Rp5TbtRk3AhT4vURf93Yfk8Tfpwd8TQ0yp/kx1m2Hw1KpPKKxiqDQjqCrPj6+n3wCPQ7Y88T+KQ6P6ecnDbcBsTqgzSGB+AgC62nz2l5nxTMpz6s7Vf+FzGeJDEiVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BOcqGEZc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BOcqGEZc"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 440FB2015E67; Thu, 14 Aug 2025 19:32:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 440FB2015E67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755225156;
	bh=SfVLrp5MpeYOXpVpoxxNlTvQJ1uMnDQpTS8cxvxTiM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOcqGEZcYK/2LHjZDb7xkXurRNzYTfC7qbXD1W0BEtudQ+SR358Agacb9YpCR7Pii
	 5dOU+pKT38r+DtzAhG0k5ZVAQ6Ky89TFgGDHKZxvbiFNW8N6BJOuEehjvAg/BA8JFH
	 q9OoHT6v9cg0jfey0UKbmRyGV6j3tz2MujrkMF6c=
Date: Thu, 14 Aug 2025 19:32:36 -0700
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
Message-ID: <20250815023236.GA30997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
 <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250815003958.GE599331@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815003958.GE599331@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 14, 2025 at 09:39:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 14, 2025 at 04:30:18PM -0700, Shyam Saini wrote:
> > or were you referring to [2]?
> > 
> > In that case, the PCI child node data needs to be parsed, which is
> > currently handled individually by each host controller driver.
> 
> Yes, this looks like it may be what I was thinking of, the pci@1,0
> specifes the BDF effectively
> 

In that case, we'll need to parse the child DTS nodes properly
within of_iommu_get_resv_regions(). I'll include this in v4.

> > This might not be a strong argument, but since firmware updates tend
> > to happen less frequently than OS updates, any addition or modification
> > to the FDT would require a firmware update. Wouldn't it be more
> > maintainable to keep this logic in Linux, which is easier to update
> > and typically updated more often?
> 
> The DT is supposed to describe the HW, if the PCI device has an issue
> with its dma ranges then it seems reasonable to me the FW will use the
> existing standards based way to describe that issue?

If that's the preferred approach, I'll revise the next version accordingly

> Presumably this is a fixed issue of the platform. You never did
> explain how your system has such werdio behavior, or how something
> like iommu=pt can function on it...
Yes, this issue is platform-specific. On this platform, the default MSI IOVA
range overlaps with an address region that is reserved for another purpose,
Other than that we haven't observed any obvious issues for DMA operations

Thanks,
Shyam
