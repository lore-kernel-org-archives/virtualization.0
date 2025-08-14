Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2701FAC34;
	Thu, 14 Aug 2025 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755214225; cv=none; b=QMJhlpFE35Gksq3PZ0jaHKMSnJYNCMsI5gTn/9viJc+qEumrV7Jh7gSViSXnX3ad57aS0nBV5M99EUrEy59RIyQXvGgGJgUOPwWjvmwRy74lUJ2ELc38XQx3twzeU8dbJ9ra/SOdfIajPEJW3gsRKSkNkMZJsZwWxsDHDw4RfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755214225; c=relaxed/simple;
	bh=1qMHNrAntP47/3sI+MxFungka23Ot422MCBrtY+Cx/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgAYtP9U1VN0Gz3VS7oB9Czxc7k9Mu2M0b8AL5n5wxsISOKFEftcmyQdUuyq6azG/SYzGi3U/x0AX6K1R6o9GYVlO9bZHIDYD7fXap9jBOfMx5qzbmmBqJ8yGIWBXPFQHrd2alyXg/CiZVIBQg5UF30AadOga09rwpd9E02ED5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mFpxwWvY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mFpxwWvY"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id 18EBF2018F18; Thu, 14 Aug 2025 16:30:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18EBF2018F18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755214218;
	bh=HJpg2pS7/i5/eJlR85F2V9d17QqSosoQgMmN8Oxuetc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFpxwWvYUtB7xtV+IEmQnssxxYT8+OJINsLzStaw5+XVPEGLowQhZZQd5A+IyC97p
	 k/XxIeFcy/t6UkH30eLkDXWkafBTl+BQIoTt+YoyJ14kTP+LbLHcKKzrgdX9FPb4c1
	 X+Knpbr9bVs6ctgbJeEGGOXFjs4PzWndk1zR58d0=
Date: Thu, 14 Aug 2025 16:30:18 -0700
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
Message-ID: <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808121515.GE377696@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Jason,

On Fri, Aug 08, 2025 at 09:15:15AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 06, 2025 at 02:55:38PM -0700, Shyam Saini wrote:
> > Individual PCI devices lack dedicated device tree nodes, but
> 
> This is not the case, you can put PCI devices in the DT as well, there
> is a syntax for it. Why not do that and have the FW populate it on the
> device node itself?

sorry, I missed that, were you referring to [1] CONFIG_PCI_DYNAMIC_OF_NODES
approach?

I tried a PoC with that and got the expected results. However, it requires
hardcoding PCI device IDs using DECLARE_PCI_FIXUP_FINAL?

or were you referring to [2]?

In that case, the PCI child node data needs to be parsed, which is
currently handled individually by each host controller driver.

This might not be a strong argument, but since firmware updates tend
to happen less frequently than OS updates, any addition or modification
to the FDT would require a firmware update. Wouldn't it be more
maintainable to keep this logic in Linux, which is easier to update
and typically updated more often?
  
> You should CC all the device tree maintainers on something like this
> as well.
> 

sure, Cc'd some more folks

[1] https://lwn.net/Articles/939317/
[2] https://elixir.bootlin.com/linux/v6.16/source/arch/arm64/boot/dts/nvidia/tegra186.dtsi#L1340

Thanks,
Shyam
