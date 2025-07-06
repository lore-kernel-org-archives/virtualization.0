Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9161A76D0;
	Sun,  6 Jul 2025 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751781612; cv=none; b=BqcFkGGakU/+PaE+ZDIX/B/q2KSypGvY8oy50cK7PGYhdCZt9I/MHAYf1HYptDDQZK1Uwa2m9wTw2EmRXguEQeND9U4ndc7HvmEraIAt9C5rdO+8VbEDsZ8rSrM+ELk7rL6v7br22nw8Gipoi76JyE6LdA+0TII2OzVf4iPVL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751781612; c=relaxed/simple;
	bh=6LXeYQHiR9KdMFnH25UR1nczxh0conAegX4pfPWuIkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfF7Ojq6JMMoeGp3+1XvJgtAiYWus88dik8LjqM40mYsZDb25TlXUhFJKBHjlPNvIdo3QUyKMQTbbqA7/eifHfYJE9oRi48ozewy5DvjVWe2C0IJiok1eIkDuIdcT1rN4bSmz0w4fXoQx4eNHoTKet7deThGOPUiNYWYdOevdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGudv65b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGudv65b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5853DC4CEED;
	Sun,  6 Jul 2025 06:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751781612;
	bh=6LXeYQHiR9KdMFnH25UR1nczxh0conAegX4pfPWuIkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGudv65bW/I8lfKVqqK+2DB/GumrSqAs4KGqsf9lwb5vIM0lf5rqwLOiBIWp47ysv
	 4r0WG7tURWg1tGnjjq79aeVVQsZyXGj8cR1nXlmSb/tIyQdxWa5jBPwYgk4Ibn8/K9
	 8aclrjMylHDqCzPAf4qXddw9XneKJKYKYM0CiGX5G6xkO/XRKoQ3qrE6gYkXOWmNgu
	 3ThVFn2essmngu1U6ie6u/JjbUhg1oKvSHUs8gt+5x+lYChW6F8Iwx5TWrOW2nYZQ7
	 U+zyKgjP6FtLwjG/hLHgAU67WZV0PzQ/Jx8mTjGv1yy23vzA7uiG8kCNLs0kGzeagw
	 h+sF92nUwh5Nw==
Date: Sun, 6 Jul 2025 09:00:07 +0300
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
Message-ID: <20250706060007.GP6278@unreal>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627170213.GL17401@unreal>

On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
> On Fri, Jun 27, 2025 at 03:44:10PM +0200, Marek Szyprowski wrote:
> > On 25.06.2025 15:18, Leon Romanovsky wrote:
> > > This series refactors the DMA mapping to use physical addresses
> > > as the primary interface instead of page+offset parameters. This
> > > change aligns the DMA API with the underlying hardware reality where
> > > DMA operations work with physical addresses, not page structures.
> > >
> > > The series consists of 8 patches that progressively convert the DMA
> > > mapping infrastructure from page-based to physical address-based APIs:
> > >
> > > The series maintains backward compatibility by keeping the old
> > > page-based API as wrapper functions around the new physical
> > > address-based implementations.
> > 
> > Thanks for this rework! I assume that the next step is to add map_phys 
> > callback also to the dma_map_ops and teach various dma-mapping providers 
> > to use it to avoid more phys-to-page-to-phys conversions.
> 
> Probably Christoph will say yes, however I personally don't see any
> benefit in this. Maybe I wrong here, but all existing .map_page()
> implementation platforms don't support p2p anyway. They won't benefit
> from this such conversion.
> 
> > 
> > I only wonder if this newly introduced dma_map_phys()/dma_unmap_phys() 
> > API is also suitable for the recently discussed PCI P2P DMA? While 
> > adding a new API maybe we should take this into account?
> 
> First, immediate user (not related to p2p) is blk layer:
> https://lore.kernel.org/linux-nvme/bcdcb5eb-17ed-412f-bf5c-303079798fe2@nvidia.com/T/#m7e715697d4b2e3997622a3400243477c75cab406
> 
> +static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> +		struct blk_dma_iter *iter, struct phys_vec *vec)
> +{
> +	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
> +			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
> +	if (dma_mapping_error(dma_dev, iter->addr)) {
> +		iter->status = BLK_STS_RESOURCE;
> +		return false;
> +	}
> +	iter->len = vec->len;
> +	return true;
> +}
> 
> Block layer started to store phys addresses instead of struct pages and
> this phys_to_page() conversion in data-path will be avoided.

I almost completed main user of this dma_map_phys() callback. It is
rewrite of this patch [PATCH v3 3/3] vfio/pci: Allow MMIO regions to be exported through dma-buf
https://lore.kernel.org/all/20250307052248.405803-4-vivek.kasireddy@intel.com/

Whole populate_sgt()->dma_map_resource() block looks differently now and
it is relying on dma_map_phys() as we are exporting memory without
struct pages. It will be something like this:

   89         for (i = 0; i < priv->nr_ranges; i++) {
   90                 phys = pci_resource_start(priv->vdev->pdev,
   91                                           dma_ranges[i].region_index);
   92                 phys += dma_ranges[i].offset;
   93
   94                 if (priv->bus_addr) {
   95                         addr = pci_p2pdma_bus_addr_map(&p2pdma_state, phys);
   96                         fill_sg_entry(sgl, dma_ranges[i].length, addr);
   97                         sgl = sg_next(sgl);
   98                 } else if (dma_use_iova(&priv->state)) {
   99                         ret = dma_iova_link(attachment->dev, &priv->state, phys,
  100                                             priv->mapped_len,
  101                                             dma_ranges[i].length, dir, attrs);
  102                         if (ret)
  103                                 goto err_unmap_dma;
  104
  105                         priv->mapped_len += dma_ranges[i].length;
  106                 } else {
  107                         addr = dma_map_phys(attachment->dev, phys, 0,
  108                                             dma_ranges[i].length, dir, attrs);
  109                         ret = dma_mapping_error(attachment->dev, addr);
  110                         if (ret)
  111                                 goto unmap_dma_buf;
  112
  113                         fill_sg_entry(sgl, dma_ranges[i].length, addr);
  114                         sgl = sg_next(sgl);
  115                 }
  116         }
  117
  118         if (dma_use_iova(&priv->state) && !priv->bus_addr) {
  119                 ret = dma_iova_sync(attachment->dev, &pri->state, 0,
  120                                     priv->mapped_len);
  121                 if (ret)
  122                         goto err_unmap_dma;
  123
  124                 fill_sg_entry(sgl, priv->mapped_len, priv->state.addr);
  125         }

> 
> > My main concern is the lack of the source phys addr passed to the dma_unmap_phys() 
> > function and I'm aware that this might complicate a bit code conversion 
> > from old dma_map/unmap_page() API.

It is not needed for now, all p2p logic is external to DMA API.

Thanks

> > 
> > Best regards
> > -- 
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> > 
> > 
> 
