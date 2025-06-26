Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235A202962;
	Thu, 26 Jun 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963510; cv=none; b=lftw26Mgd1YhdsbNjuFhmZxEEOGLYyczi+TmlgiUq1FYZkDSghSeSKlbER86Dn7kfJck6NnFZzMc7+7GEUb0rDCxGWV4+pi3GHKrPYHbn/2ZyIZPlFkuMeYfk5h38bjxM3xOS6dDocO/wZkvc69zZUc8y93rJ68B7Y845AszHCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963510; c=relaxed/simple;
	bh=qpuwIbsfFlx+vQqZ7u2g19cFy4P5mUElZNbXy5mDaBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DffjyGoMemON5YXn9Bm3XXTe4Ib4sjw5kdcEmNNJPwSN4WVuYjl0ec74s/6mo4CHC/5+1qTZjItIrd8aaajGLfsV+BGs5bgK4hsXaUsmGuKdRQS/JZaWn8zTVD1R52qEsjatHm8nSyhe54PiSPaLWHuOi+8w2oFp8mi/puWqfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLP472CC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLP472CC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC281C4CEEB;
	Thu, 26 Jun 2025 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963509;
	bh=qpuwIbsfFlx+vQqZ7u2g19cFy4P5mUElZNbXy5mDaBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLP472CCTg+PhX1yKdunFpJsdMOjYvhGyAgWrimK7DWPKkMd17pKMc1fIfwaPlCPA
	 JIJRXr+shFAtyLcZe8XBwbY11mrvGDzVdJ3RsltqtREBwQkFGd8GfGcQGFurfXwhRi
	 Gh6t0AupUp/xt8ImCbK8nrHJ6hmurZkalNqu+4nWd0M/d9ZfOF4iAVk+oNuFVT055z
	 IXMV0SFHieGPFmST8cP/2Lrg5B0eeTJyP2e7jxgpdTCHDGUFGS4ovBwL7ynEjAeKFJ
	 dwGKMZLnO96ObPriGbwvv4YKtLXuQsSnKwE/DIyBvIi2T6xOA6FnnFe1RuVAtw0cbK
	 QWmFFBkB6n4+g==
Date: Thu, 26 Jun 2025 21:45:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexander Potapenko <glider@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
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
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/8] kmsan: convert kmsan_handle_dma to use physical
 addresses
Message-ID: <20250626184504.GK17401@unreal>
References: <cover.1750854543.git.leon@kernel.org>
 <cabe5b75fe1201baa6ecd209546c1f0913fc02ef.1750854543.git.leon@kernel.org>
 <CAG_fn=XWP-rpV-D2nV-a3wMbzqLn2T-43tyGnoS2AhVGU8oZMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XWP-rpV-D2nV-a3wMbzqLn2T-43tyGnoS2AhVGU8oZMw@mail.gmail.com>

On Thu, Jun 26, 2025 at 07:43:06PM +0200, Alexander Potapenko wrote:
> On Wed, Jun 25, 2025 at 3:19 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi Leon,
> 
> >
> > Convert the KMSAN DMA handling function from page-based to physical
> > address-based interface.
> >
> > The refactoring renames kmsan_handle_dma() parameters from accepting
> > (struct page *page, size_t offset, size_t size) to (phys_addr_t phys,
> > size_t size).
> 
> Could you please elaborate a bit why this is needed? Are you fixing
> some particular issue?

It is soft of the fix and improvement at the same time.
Improvement: 
It allows direct call to kmsan_handle_dma() without need
to convert from phys_addr_t to struct page for newly introduced
dma_map_phys() routine.

Fix:
It prevents us from executing kmsan for addresses that don't have struct page
(for example PCI_P2PDMA_MAP_THRU_HOST_BRIDGE pages), which we are doing
with original code.

dma_map_sg_attrs()
 -> __dma_map_sg_attrs()
  -> dma_direct_map_sg()
   -> PCI_P2PDMA_MAP_THRU_HOST_BRIDGE and nents > 0
    -> kmsan_handle_dma_sg();
     -> kmsan_handle_dma(g_page(item) <---- this is "fake" page.

We are trying to build DMA API that doesn't require struct pages.

> 
> > A PFN_VALID check is added to prevent KMSAN operations
> > on non-page memory, preventing from non struct page backed address,
> >
> > As part of this change, support for highmem addresses is implemented
> > using kmap_local_page() to handle both lowmem and highmem regions
> > properly. All callers throughout the codebase are updated to use the
> > new phys_addr_t based interface.
> 
> KMSAN only works on 64-bit systems, do we actually have highmem on any of these?

I don't know, but the original code had this check:
  344         if (PageHighMem(page)) 
  345                 return;

Thanks
