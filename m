Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19930215F48;
	Tue,  8 Jul 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972412; cv=none; b=I3B+4++N+s5RcXUBQCcxH/xVvMOcHQf0RaeE3YoEcaVsWZoAZNeAuSDl+H9fodGUdIurTaCx7nXS6ExsbulBnTKb9Xr67Vc0eVPUymHpaH9Rocng3xYWI8haJT94yZejYqEyg/JgY5NOxHfOFF2RVEZaQroTYRRVn71F6ZHNt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972412; c=relaxed/simple;
	bh=5KL6rrIwnrg38ZqhQ6AB+QdSfe6gyMAir5Sbq2Mfv3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbDGJleet/NgmFPzduxvuc47+X+wYR1zagYThzM7WNI3gFzoyU0Mt5VjcfyxNuGjLxpHui/+JWDd1mqfXoheF6Joa/oVBJauNo2YzQXCRtKBJk1zEppkycZIISuzOVcgFiR3i8qr4CgVtRDx+QJF3fjPS6LFSJ5O+QMfjPekpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN8tyuqT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN8tyuqT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91044C4CEED;
	Tue,  8 Jul 2025 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751972411;
	bh=5KL6rrIwnrg38ZqhQ6AB+QdSfe6gyMAir5Sbq2Mfv3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uN8tyuqTvou8o+R/mOO7Yg6n7PNJtUdZ+ZUyob65HmWP0T0yfwWgfI24HMU0r7HN3
	 Iv/9p5Qz7yq0z6SfYzlZ8O2jah6vPR/66HY1GS8sn0oA5aCV40mCMlXhKGhFKpd9Gw
	 Yph0pSgvARTjakjLBRtoXJw/nf2FE8wmvZmAoLV7nUPfAwX721yMnt+1OjeZvHyC1T
	 bIwx5u1WR+ImqC7oRVd+WsK/GJVIJvuKAO2RfbXeHnmDDi/HpwuTz/p5FXQ0xPx0Ct
	 90/w7Kne0qNm0Sy8IV//jt9S9XVQk4W6wzdF4ltAHTLfCKmlrEIN9liVg613NYj5yK
	 29yiJVGsn+RvQ==
Date: Tue, 8 Jul 2025 14:00:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250708110007.GF592765@unreal>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>

On Tue, Jul 08, 2025 at 12:27:09PM +0200, Marek Szyprowski wrote:
> On 30.06.2025 15:38, Christoph Hellwig wrote:
> > On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
> >>> Thanks for this rework! I assume that the next step is to add map_phys
> >>> callback also to the dma_map_ops and teach various dma-mapping providers
> >>> to use it to avoid more phys-to-page-to-phys conversions.
> >> Probably Christoph will say yes, however I personally don't see any
> >> benefit in this. Maybe I wrong here, but all existing .map_page()
> >> implementation platforms don't support p2p anyway. They won't benefit
> >> from this such conversion.
> > I think that conversion should eventually happen, and rather sooner than
> > later.
> 
> Agreed.
> 
> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one 
> needs a stable branch with it.

Thanks a lot, I don't think that stable branch is needed. Realistically
speaking, my VFIO DMA work won't be merged this cycle, We are in -rc5,
it is complete rewrite from RFC version and touches pci-p2p code (to
remove dependency on struct page) in addition to VFIO, so it will take
time.

Regarding, last patch (hmm), it will be great if you can take it.
We didn't touch anything in hmm.c this cycle and have no plans to send PR.
It can safely go through your tree.

> 
> Leon, it would be great if You could also prepare an incremental patch 
> adding map_phys callback to the dma_maps_ops, so the individual 
> arch-specific dma-mapping providers can be then converted (or simplified 
> in many cases) too.

Sure, will do.

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
