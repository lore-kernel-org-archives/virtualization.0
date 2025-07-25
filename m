Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF549257426;
	Fri, 25 Jul 2025 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473956; cv=none; b=FnumYyePOtK3q39MioGkfq3cEr51DE5ebVO7dQQFnWDTGdn3J9c3SGa/kkbrMrN9gO+H6Br9mg1PB6ZClKUHUgZRvzvp+mDEeOBJNjMxcrLPpVUyy13o9UR9bRtZYD+aH8so9YsNNu+Cu8g7uWEbA8B8Lnib23R1TdaVjjPMcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473956; c=relaxed/simple;
	bh=ODc8BUbdLA0Xu8RNO9sp6CmCixwXABeVZzZOWA0RFI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKkB8HcfYG0fbD88iYz/4pn81reApyDPq/AkGnWwDR5ORHovnl4T+d7mwQrP6iCm/FelVeE+SVnm0hCHeFYYuSOHh8Uc4zYM+u325CAc534wi8IsglLXjzfiPKKaj3O74dsGn6iqZYCihyOo/RRyMKRYv9CdZ+L4voXXcXHl1OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BFC91A00;
	Fri, 25 Jul 2025 13:05:47 -0700 (PDT)
Received: from [10.57.4.83] (unknown [10.57.4.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7893F6A8;
	Fri, 25 Jul 2025 13:05:48 -0700 (PDT)
Message-ID: <751e7ece-8640-4653-b308-96da6731b8e7@arm.com>
Date: Fri, 25 Jul 2025 21:05:46 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux.dev, virtualization@lists.linux.dev,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <cover.1750854543.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <cover.1750854543.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-25 2:18 pm, Leon Romanovsky wrote:
> This series refactors the DMA mapping to use physical addresses
> as the primary interface instead of page+offset parameters. This
> change aligns the DMA API with the underlying hardware reality where
> DMA operations work with physical addresses, not page structures.

That is obvious nonsense - the DMA *API* does not exist in "hardware 
reality"; the DMA API abstracts *software* operations that must be 
performed before and after the actual hardware DMA operation in order to 
preserve memory coherency etc.

Streaming DMA API callers get their buffers from alloc_pages() or 
kmalloc(); they do not have physical addresses, they have a page or 
virtual address. The internal operations of pretty much every DMA API 
implementation that isn't a no-op also require a page and/or virtual 
address. It is 100% logical for the DMA API interfaces to take a page or 
virtual address (and since virt_to_page() is pretty trivial, we already 
consolidated the two interfaces ages ago).

Yes, once you get right down to the low-level arch_sync_dma_*() 
interfaces that passes a physical address, but that's mostly an artefact 
of them being factored out of old dma_sync_single_*() implementations 
that took a (physical) DMA address. Nearly all of them then use __va() 
or phys_to_virt() to actually consume it. Even though it's a 
phys_addr_t, the implicit guarantee that it represents page-backed 
memory is absolutely vital.

Take a step back; what do you imagine that a DMA API call on a 
non-page-backed physical address could actually *do*?

- Cache maintenance? No, it would be illogical for a P2P address to be 
cached in a CPU cache, and anyway it would almost always crash because 
it requires page-backed memory with a virtual address.

- Bounce buffering? Again no, that would be illogical, defeat the entire 
point of a P2P operation, and anyway would definitely crash because it 
requires page-backed memory with a virtual address.

- IOMMU mappings? Oh hey look that's exactly what dma_map_resource() has 
been doing for 9 years. Not to mention your new IOMMU API if callers 
want to be IOMMU-aware (although without the same guarantee of not also 
doing the crashy things.)

- Debug tracking? Again, already taken care of by dma_map_resource().

- Some entirely new concept? Well, I'm eager to be enlightened if so!

But given what we do already know of from decades of experience, obvious 
question: For the tiny minority of users who know full well when they're 
dealing with a non-page-backed physical address, what's wrong with using 
dma_map_resource?

Does it make sense to try to consolidate our p2p infrastructure so 
dma_map_resource() could return bus addresses where appropriate? Yes, 
almost certainly, if it makes it more convenient to use. And with only 
about 20 users it's not too impractical to add some extra arguments or 
even rejig the whole interface if need be. Indeed an overhaul might even 
help solve the current grey area as to when it should take dma_range_map 
into account or not for platform devices.

> The series consists of 8 patches that progressively convert the DMA
> mapping infrastructure from page-based to physical address-based APIs:

And as a result ends up making said DMA mapping infrastructure slightly 
more complicated and slightly less efficient for all its legitimate 
users, all so one or two highly specialised users can then pretend to 
call it in situations where it must be a no-op anyway? Please explain 
convincingly why that is not a giant waste of time.

Are we trying to remove struct page from the kernel altogether? If yes, 
then for goodness' sake lead with that, but even then I'd still prefer 
to see the replacements for critical related infrastructure like 
pfn_valid() in place before we start trying to reshape the DMA API to fit.

Thanks,
Robin.

> The series maintains backward compatibility by keeping the old
> page-based API as wrapper functions around the new physical
> address-based implementations.
> 
> Thanks
> 
> Leon Romanovsky (8):
>    dma-debug: refactor to use physical addresses for page mapping
>    dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
>    iommu/dma: rename iommu_dma_*map_page to iommu_dma_*map_phys
>    dma-mapping: convert dma_direct_*map_page to be phys_addr_t based
>    kmsan: convert kmsan_handle_dma to use physical addresses
>    dma-mapping: fail early if physical address is mapped through platform
>      callback
>    dma-mapping: export new dma_*map_phys() interface
>    mm/hmm: migrate to physical address-based DMA mapping API
> 
>   Documentation/core-api/dma-api.rst |  4 +-
>   arch/powerpc/kernel/dma-iommu.c    |  4 +-
>   drivers/iommu/dma-iommu.c          | 14 +++----
>   drivers/virtio/virtio_ring.c       |  4 +-
>   include/linux/dma-map-ops.h        |  8 ++--
>   include/linux/dma-mapping.h        | 13 ++++++
>   include/linux/iommu-dma.h          |  7 ++--
>   include/linux/kmsan.h              | 12 +++---
>   include/trace/events/dma.h         |  4 +-
>   kernel/dma/debug.c                 | 28 ++++++++-----
>   kernel/dma/debug.h                 | 16 ++++---
>   kernel/dma/direct.c                |  6 +--
>   kernel/dma/direct.h                | 13 +++---
>   kernel/dma/mapping.c               | 67 +++++++++++++++++++++---------
>   kernel/dma/ops_helpers.c           |  6 +--
>   mm/hmm.c                           |  8 ++--
>   mm/kmsan/hooks.c                   | 36 ++++++++++++----
>   tools/virtio/linux/kmsan.h         |  2 +-
>   18 files changed, 159 insertions(+), 93 deletions(-)
> 

