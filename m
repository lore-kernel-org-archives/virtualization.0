Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F9322A35
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532395; cv=none; b=dks8/4ueUu8uUIsXeNRjXy8G+8XT0MkQMtbZ0BCw80ehL+Sj4Z8npKau7GXiIHykaMswqIRXvQaaSHS4lYyo96lZCccTNLmyBsI4JZAGwGlqqwkkuVCi4g/p8IoycdehRt4UDIHhgkASmVlCUbnf1mUWfBmsD2SY1mzgomuEicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532395; c=relaxed/simple;
	bh=EI7ph71E7vzBhJM3BGJQWwVv5bNRggTZ4F6M7dXxS+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXJoPL1jOt7ZDsmKurgm7bzW1uaPwbO6EgvmElfHxpZqTGapNXKSbS4sP/0Y9okHDVGmd9YWVqhrIFjFG+4Y4lHWxPMHUzpJNuNKp2t//njypKhI9H035WPFnng04LMCCEk1FtSZF9Eg+QN5mts19HNLybr1TNnR7oc3J2xbbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=do9qhutU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="do9qhutU"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a9f56b1f2so26119876d6.3
        for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755532392; x=1756137192; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj+qz5uWtdxe1t/4yn/fG3Kx2sOHLsT2H8fxH0m0kcM=;
        b=do9qhutU79r3ie4oTb0wCvS//5Eun/BuH+gx8ikO3sPCYIwusCADRi2JVk4uL4J8jw
         xFPXPQ6ILPEZG1cmTcBTJcKnA4wOUd3SbxAxlF1rJXHXxZjaQK66AesgF5LKu7E/t7fK
         OYwGcAiensI+se9PvlLlUdeMRPPPvDnrK4S5BRVGDTtb2feZI9MqlKZ9joWLQiWujQYl
         HReW7eQ7J0tZRRvk7ewHVPHHIE+f1o84nsgc1aubGg8Vyx2LXvGXXv+SULKYYx5RwHx5
         S18OOMSXxe2tbZ1qzXRq+GzAtiXt0ihc61fIMABNjC1hOJT/xhM5DHlIjlRRb14nd5FW
         H1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532392; x=1756137192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj+qz5uWtdxe1t/4yn/fG3Kx2sOHLsT2H8fxH0m0kcM=;
        b=pL4rtI96w2N5P8qIdGYW/Ug3lFLFQHS7/0FgLJCOscyTASBVCZYMyzyhQBXal0HKGl
         qKhW63AxQ80f0XEZYydTTWfmpigaBQzVVct5nMlFIxRn1L+l/9Cz28+hx/Sc2eXoOzCi
         MuWCGQO/rh47ph+mYymVyt0QS2mmhOeTWB9Ayo+ThjnCD9tObagx+mkdV8xMkzEMMkDJ
         b+SqYE7L4m+z6RBBfQOZmx0yH4BJ6O6rtEwQlKoTrj0SguMM4EI+7Td3QGfFaTykBKh9
         LLbG6GJEmnosBTS4Afr6D357iCyNqq/eUH91ngKTjBoiLwi8nfp3ACmeEPeVo0hLfMRi
         C7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxxA2nZHbfTQjS5LJGcWpaDI+DSkZvD+fo0VIvu03jPQfgxiaHuA2YeqNar7nacanLhVcnVaoSTVbkgMB1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAH26+A14YlncGVyhD/x7dTxVYSaPjiupbh+7s6S33QG/pOCtp
	8LeVQ3WjStPP/jFfTLwah6aPppK3cU5cxKq7QiCWT2oSD+86EEtu1AOgfAaCj/xeV1Y=
X-Gm-Gg: ASbGncu1gvgXnjSZtn6rITULXqrH1GLxm6VTd13PlWKOvum+fpfrlYAgFFk9wlyRSfC
	FCw1wyX5VeuRyzN9BqpfZKxuYFmoLvWiyubVK3z/OuGjAdt5MoxsyW/faubyiDFo2RPAMdQgInw
	HmH9bOzbbfH6yVG0Ji4O9bT58N4yzIh0s7YMR2morMLk9UzUqJFdEvI+r05iHelmUKC71aO4Bw9
	cod80+JQMFiiTjMRhZduTYPvd3Rq3+X+b1wpWlAdTB/2WE5c9UGPPJ+6cpP5S0Lwl2OnDHsb6o0
	0Dy692GDPEOSlQvmdtNkh91ZFkV5TBwJN5gbTcZl1LnKPHcHSPDGLO1C4517IQHR2xYcpHic
X-Google-Smtp-Source: AGHT+IHy5xjjBQNaLhq2Kl2pjcBSM8TtgEpdzaR3B4TcAc3XiKHcP9uaHgX//cMvSIYk535Uc7uNQQ==
X-Received: by 2002:a05:6214:20ad:b0:709:e519:fbfb with SMTP id 6a1803df08f44-70ba7b5df3cmr141480306d6.22.1755532392375;
        Mon, 18 Aug 2025 08:53:12 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba90bcf7esm54232646d6.31.2025.08.18.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:53:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uo2AY-00000004OfV-46ks;
	Mon, 18 Aug 2025 12:53:10 -0300
Date: Mon, 18 Aug 2025 12:53:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
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
Message-ID: <20250818155310.GG599331@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
 <20250808121515.GE377696@ziepe.ca>
 <20250814233018.GA31418@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250815003958.GE599331@ziepe.ca>
 <20250815023236.GA30997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815023236.GA30997@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Aug 14, 2025 at 07:32:36PM -0700, Shyam Saini wrote:
> On Thu, Aug 14, 2025 at 09:39:58PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 14, 2025 at 04:30:18PM -0700, Shyam Saini wrote:
> > > or were you referring to [2]?
> > > 
> > > In that case, the PCI child node data needs to be parsed, which is
> > > currently handled individually by each host controller driver.
> > 
> > Yes, this looks like it may be what I was thinking of, the pci@1,0
> > specifes the BDF effectively
> 
> In that case, we'll need to parse the child DTS nodes properly
> within of_iommu_get_resv_regions(). I'll include this in v4.

Kinda surprised this isn't happening already? It would be good to
refer to the original specs and describe how whatetever you propose is
aligned there.

> > Presumably this is a fixed issue of the platform. You never did
> > explain how your system has such werdio behavior, or how something
> > like iommu=pt can function on it...
> Yes, this issue is platform-specific. On this platform, the default MSI IOVA
> range overlaps with an address region that is reserved for another purpose,
> Other than that we haven't observed any obvious issues for DMA operations

Usually DRAM is at the default MSI IOVA address, so if you run
iommu=pt then presumably your DRAM map has a nice hole in it.. But
maybe the memory map told the OS about that.

Jason
