Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848E1876;
	Thu, 31 Jul 2025 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941683; cv=none; b=nNK/eq3dxS6OeieXtZp3boBqeNFAthrCKLKMDTg5oIKuT++I75veOE43Qrc+K1cW8oert4DS/9ZS4ILO/dFTR9/pa0dTEtgAgtZJvayQgUulwhwbRhBQkDDo06By4s9QLE+ARichyGBEohB3KNtK76qsXn6LtLskhABsHFumka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941683; c=relaxed/simple;
	bh=I82Ku1sBUzvQwy4NqAe/XyR//viXY99kTa/2l5/jmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm8UFiBZljZaBkeYvr0gPHO2gL3rTdm26w2ts24RZArdeEsxtuP1dZvCE8maDhSH4Ke65BxsZj6ZimUwN0ZNUdBF4Z47e+irs+rmVlQPTeyUIOoYuWT8ZbKvofv5nMgQ3ZwoDMwWpjNx8s9VNd6UzrvAfUVqpD6+9oUVcmO4VgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKKF3Cek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKKF3Cek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ED7C4CEEF;
	Thu, 31 Jul 2025 06:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753941682;
	bh=I82Ku1sBUzvQwy4NqAe/XyR//viXY99kTa/2l5/jmhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKKF3Cekf++SZHUOWA04jjlZuOEM8jGgJfAc0aVSPmvXHb//UmelF3TSqVbMPTbIj
	 MP6ZY5kK/EHxFqzZkhJ00XfylribvAhaYrLfaOpKcfokV5B/m/YCRirZ6t18pB4ZsQ
	 bsaI+/poV49jhLpK/ZRr0Q26G8cpUoxT/F6a+V9gIC9BqoNiSkyVuYGzpHG8jsb4gD
	 kIHsaNE1F48jrFXtV51opjZqdV2cVTpPGIvzjcT2MgCfaAhoBQdDME7Z3UNkBRnB9F
	 9X1Zop5ceYd7F2qaq0bvgxU4gZ8+qznN5tM1C/ZQL7YhzeOUqryCvMmIs0/hr+BEoT
	 BFZZ8xU/xu5mA==
Date: Thu, 31 Jul 2025 09:01:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <20250731060117.GR402218@unreal>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
 <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
 <20250730134026.GQ402218@unreal>
 <20250730142818.GL26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730142818.GL26511@ziepe.ca>

On Wed, Jul 30, 2025 at 11:28:18AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 30, 2025 at 04:40:26PM +0300, Leon Romanovsky wrote:

<...>

> > The most reasonable way to prevent DMA_ATTR_SKIP_CPU_SYNC leakage is to
> > introduce new DMA attribute (let's call it DMA_ATTR_MMIO for now) and
> > pass it to both dma_map_phys() and dma_iova_link(). This flag will
> > indicate that p2p type is PCI_P2PDMA_MAP_THRU_HOST_BRIDGE and call to
> > right callbacks which will set IOMMU_MMIO flag and skip CPU sync,
> 
> So the idea is if the memory is non-cachable, no-KVA you'd call
> dma_iova_link(phys_addr, DMA_ATTR_MMIO) and dma_map_phys(phys_addr,
> DMA_ATTR_MMIO) ?

Yes

> 
> And then internally the dma_ops and dma_iommu would use the existing
> map_page/map_resource variations based on the flag, thus ensuring that
> MMIO is never kmap'd or cache flushed?
> 
> dma_map_resource is really then just
> dma_map_phys(phys_addr, DMA_ATTR_MMIO)?
> 
> I like this, I think it well addresses the concerns.

Yes, I had this idea and implementation before. :(

> 
> Jason
> 
