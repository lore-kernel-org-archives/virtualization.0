Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD52E7F37;
	Tue, 15 Jul 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587913; cv=none; b=pOLD2djuhhaoTUeyw791v6IIrpXh3GKN+VWjhlaBkHMAAQVAzC+zC67UyNGAnGyC0LatAoqxAA+hYC06eXcxifilXU/n6wM41LqiB5DpTqIBtQmac0YJ5k3lQwsMO7gakrhJ+fp9M+Qt20KpzuTykCjtt23NqWt4cDaVFgCnMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587913; c=relaxed/simple;
	bh=fxS+g8tNbMk1/UdhRU/HlLfSUskJDrVIrYOCQQhuqIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY26acRLx8ZqXiV5n/UUwWKZ0uPgbkz5CVQemrVZ8OJ0cOFphuxpThPhREqlsV82JBceouheUCn2I/OGwisYAIu1yQmRj7tf0mTToVLCNPuZ0Hx7EYvAsmKuWCLGGpr45PgKZuqhi+Biy96fezLFWdca0s4KHHamxWEiXpbDsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4Vizggn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4Vizggn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E39CC4CEE3;
	Tue, 15 Jul 2025 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752587913;
	bh=fxS+g8tNbMk1/UdhRU/HlLfSUskJDrVIrYOCQQhuqIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4VizggnWo1DpwbZuWP/wgm3VApTeTCEOnymfwBXT+GilXimDEQE0iPIBqdfv6kCi
	 kvrSMjoaH00P8jMdB4VBav7nnidtnHwAto4lOKuhIXdRUv9zLac0k9qGP1dt9vU+Kx
	 besMzcLyEY6CL3CXJ/iulu2Ux2wmI6rIlbokZUIfssTq+7xCt4aR4/gUg5F8zwheNy
	 38Z2YuBFkCPHKo42aC2RxBV7YCSsmJFp5Nn2VHoOI+x4EAhgotJS6lFClihLkokNmk
	 clpPZozDwuZYTrNm/DjfETz/I7kal1xj7ibFiF39RZ8jyeg3fbnaBQWAnL0Q+x4geu
	 jTleqek0Z+P7g==
Date: Tue, 15 Jul 2025 16:58:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH 8/8] mm/hmm: migrate to physical address-based DMA
 mapping API
Message-ID: <20250715135828.GE5882@unreal>
References: <cover.1750854543.git.leon@kernel.org>
 <8a85f4450905fcb6b17d146cc86c11410d522de4.1750854543.git.leon@kernel.org>
 <aHZWlu7Td9ijFhhh@willie-the-truck>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZWlu7Td9ijFhhh@willie-the-truck>

On Tue, Jul 15, 2025 at 02:24:38PM +0100, Will Deacon wrote:
> Hi Leon,
> 
> On Wed, Jun 25, 2025 at 04:19:05PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Convert HMM DMA operations from the legacy page-based API to the new
> > physical address-based dma_map_phys() and dma_unmap_phys() functions.
> > This demonstrates the preferred approach for new code that should use
> > physical addresses directly rather than page+offset parameters.
> > 
> > The change replaces dma_map_page() and dma_unmap_page() calls with
> > dma_map_phys() and dma_unmap_phys() respectively, using the physical
> > address that was already available in the code. This eliminates the
> > redundant page-to-physical address conversion and aligns with the
> > DMA subsystem's move toward physical address-centric interfaces.
> > 
> > This serves as an example of how new code should be written to leverage
> > the more efficient physical address API, which provides cleaner interfaces
> > for drivers that already have access to physical addresses.
> 
> I'm struggling a little to see how this is cleaner or more efficient
> than the old code.

It is not, the main reason for hmm conversion is to show how the API is
used. HMM is built around struct page.

> 
> From what I can tell, dma_map_page_attrs() takes a 'struct page *' and
> converts it to a physical address using page_to_phys() whilst your new
> dma_map_phys() interface takes a physical address and converts it to
> a 'struct page *' using phys_to_page(). In both cases, hmm_dma_map_pfn()
> still needs the page for other reasons. If anything, existing users of
> dma_map_page_attrs() now end up with a redundant page-to-phys-to-page
> conversion which hopefully the compiler folds away.
> 
> I'm assuming there's future work which builds on top of the new API
> and removes the reliance on 'struct page' entirely, is that right? If
> so, it would've been nicer to be clearer about that as, on its own, I'm
> not really sure this patch series achieves an awful lot and the
> efficiency argument looks quite weak to me.

Yes, there is ongoing work, which is built on top of dma_map_phys() API
and can't be built without DMA phys.

My WIP branch, where I'm using it can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dmabuf-vfio

In that branch, we save one phys_to_page conversion in block datapath:
block-dma: migrate to dma_map_phys instead of map_page

and implement DMABUF exporter for MMIO pages:
vfio/pci: Allow MMIO regions to be exported through dma-buf
see vfio_pci_dma_buf_map() function.

Thanks

> 
> Cheers,
> 
> Will
> 
