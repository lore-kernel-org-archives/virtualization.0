Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30521DE4E7;
	Thu, 31 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983469; cv=none; b=QtdnoSCB1APPAUE0K8Vg5GeL9VsoogNbG11sf+WntPXvE/A/kTM20qpvZ0SwSnHoi6CZrhrisFHToiAHZQ0FHUk+R+4gGClQwlODH0SISSfoEGK34z66Tw/8m6qbGGVVE/j5qepE2MhIREarbnlJlp3KmFn9H/ozHAEFMU7mFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983469; c=relaxed/simple;
	bh=fC5Kj2P9hQGv6REhbUedHA1baP40WX3wJpYks9ETIRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=punSK1KeXwIaenIBU3V0v9tYgJwJ9uuzM2vdsQXqiiz7uzVJmWYouCOVa1i/L5YGj0iZ7UvSiS8D7JluEj6Pd9zhA+/lyJ13a0worymnsJ93YCGVcuUIdhmTJvH0td3qzve4td2qL+OHmkON/j4xo/WhagpPDS+y93WB5dOAPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iKWwh1a8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKWwh1a8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p81bLGAEXCTve0S2bSlDolWBTWQ0gkC1ozZDbrTl9gw=; b=iKWwh1a88Q0pAf4bvxfAD5Txdc
	EE90MjrkC8Uduz8SZ6vXiansbV8frsRKlWXThc48w73PhEqccyoX4tMljfHq+8Rhz9i2ceiiTpnNQ
	7hjsoOf+OUPX+pHbDNVQLDykrMSNBfUePqaONzx/4EcyEuzR/wo0kYwvkbEPCkU9M1bzxAWY1d2bj
	ohP5kNlKgUTJVA9ZUQHkyV+nsX3SWV9d4/YDSTVwIwFe2VNJRwzXwJ/sEIwEa9qaSxvuX+eYykKKV
	Yo/BB2cxQ9KFglR+QaHCwdd6BFZFTPe+0RrFxYMe0Vnzv0Y1POwKGhi1jrFc7WsVSY+Z/IRvpV2Bt
	sXEcrVpw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhXDL-0000000H6sX-2SDg;
	Thu, 31 Jul 2025 17:37:11 +0000
Date: Thu, 31 Jul 2025 18:37:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <aIupx_8vOg8wQh6w@casper.infradead.org>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
 <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>

Hi Robin,

I don't know the DMA mapping code well and haven't reviewed this
patch set in particular, but I wanted to comment on some of the things
you say here.

> Marek, I'm surprised that even you aren't seeing why that would at best be
> pointless churn. The fundamental design of dma_map_page() operating on
> struct page is that it sits in between alloc_pages() at the caller and
> kmap_atomic() deep down in the DMA API implementation (which also subsumes
> any dependencies on having a kernel virtual address at the implementation
> end). The natural working unit for whatever replaces dma_map_page() will be
> whatever the replacement for alloc_pages() returns, and the replacement for
> kmap_atomic() operates on. Until that exists (and I simply cannot believe it
> would be an unadorned physical address) there cannot be any *meaningful*
> progress made towards removing the struct page dependency from the DMA API.
> If there is also a goal to kill off highmem before then, then logically we
> should just wait for that to land, then revert back to dma_map_single()
> being the first-class interface, and dma_map_page() can turn into a trivial
> page_to_virt() wrapper for the long tail of caller conversions.

While I'm sure we'd all love to kill off highmem, that's not a realistic
goal for another ten years or so.  There are meaningful improvements we
can make, for example pulling page tables out of highmem, but we need to
keep file data and anonymous memory in highmem, so we'll need to support
DMA to highmem for the foreseeable future.

The replacement for kmap_atomic() is already here -- it's
kmap_(atomic|local)_pfn().  If a simple wrapper like kmap_local_phys()
would make this more palatable, that would be fine by me.  Might save
a bit of messing around with calculating offsets in each caller.

As far as replacing alloc_pages() goes, some callers will still use
alloc_pages().  Others will use folio_alloc() or have used kmalloc().
Or maybe the caller won't have used any kind of page allocation because
they're doing I/O to something that isn't part of Linux's memory at all.
Part of the Grand Plan here is for Linux to catch up with Xen's ability
to do I/O to guests without allocating struct pages for every page of
memory in the guests.

You say that a physical address will need some adornment -- can you
elaborate on that for me?  It may be that I'm missing something
important here.
