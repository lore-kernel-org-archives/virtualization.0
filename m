Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BDC20FAAB;
	Wed, 30 Jul 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873901; cv=none; b=UJ3hi4dMFEjba4ANqOxFOa059n/1Hvxj52D0sOFin70f85zGbtQhfQAcvBxA6vPzY+qQLwTqUpF/ehAV5uQAs+U5jWprAfYmSj4i3r3xCAjHlqIs74l2Q7NdaV/DQlSmLEq7Qckzb9RvuY5ikbZtKdCdd/dYefW+se4gfXyeAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873901; c=relaxed/simple;
	bh=asevILIzuNSddmtdG/bl/3I8QPtBkx8UBm3bkjmoh2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=da528wNR8mSEHp8E3aoEMCAqfxb1lnJW9W9KPtbke+Qv7EppGQuEDJ7FmWf2VZBDoDFdUoXWgWWp6hBi9AVPJpIP4M9vPwMXqi3Nt8KXFNKHdHcMBE5Kr509UWVFNcwbnxn+DAW5Kdib3fzYRhZdEm+iulTvsF3ZziaSjV5TMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E047C1E5E;
	Wed, 30 Jul 2025 04:11:30 -0700 (PDT)
Received: from [10.57.3.116] (unknown [10.57.3.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E3A73F673;
	Wed, 30 Jul 2025 04:11:34 -0700 (PDT)
Message-ID: <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
Date: Wed, 30 Jul 2025 12:11:32 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
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
 linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal> <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-08 11:27 am, Marek Szyprowski wrote:
> On 30.06.2025 15:38, Christoph Hellwig wrote:
>> On Fri, Jun 27, 2025 at 08:02:13PM +0300, Leon Romanovsky wrote:
>>>> Thanks for this rework! I assume that the next step is to add map_phys
>>>> callback also to the dma_map_ops and teach various dma-mapping providers
>>>> to use it to avoid more phys-to-page-to-phys conversions.
>>> Probably Christoph will say yes, however I personally don't see any
>>> benefit in this. Maybe I wrong here, but all existing .map_page()
>>> implementation platforms don't support p2p anyway. They won't benefit
>>> from this such conversion.
>> I think that conversion should eventually happen, and rather sooner than
>> later.
> 
> Agreed.
> 
> Applied patches 1-7 to my dma-mapping-next branch. Let me know if one
> needs a stable branch with it.

As the maintainer of iommu-dma, please drop the iommu-dma patch because 
it is broken. It does not in any way remove the struct page dependency 
from iommu-dma, it merely hides it so things can crash more easily in 
circumstances that clearly nobody's bothered to test.

> Leon, it would be great if You could also prepare an incremental patch
> adding map_phys callback to the dma_maps_ops, so the individual
> arch-specific dma-mapping providers can be then converted (or simplified
> in many cases) too.

Marek, I'm surprised that even you aren't seeing why that would at best 
be pointless churn. The fundamental design of dma_map_page() operating 
on struct page is that it sits in between alloc_pages() at the caller 
and kmap_atomic() deep down in the DMA API implementation (which also 
subsumes any dependencies on having a kernel virtual address at the 
implementation end). The natural working unit for whatever replaces 
dma_map_page() will be whatever the replacement for alloc_pages() 
returns, and the replacement for kmap_atomic() operates on. Until that 
exists (and I simply cannot believe it would be an unadorned physical 
address) there cannot be any *meaningful* progress made towards removing 
the struct page dependency from the DMA API. If there is also a goal to 
kill off highmem before then, then logically we should just wait for 
that to land, then revert back to dma_map_single() being the first-class 
interface, and dma_map_page() can turn into a trivial page_to_virt() 
wrapper for the long tail of caller conversions.

Simply obfuscating the struct page dependency today by dressing it up as 
a phys_addr_t with implicit baggage is not not in any way helpful. It 
only makes the code harder to understand and more bug-prone. Despite the 
disingenuous claims, it is quite blatantly the opposite of "efficient" 
for callers to do extra work to throw away useful information with 
page_to_phys(), and the implementation then have to re-derive that 
information with pfn_valid()/phys_to_page().

And by "bug-prone" I also include greater distractions like this 
misguided idea that the same API could somehow work for non-memory 
addresses too, so then everyone can move on bikeshedding VFIO while 
overlooking the fundamental flaws in the whole premise. I mean, besides 
all the issues I've already pointed out in that regard, not least the 
glaring fact that it's literally just a worse version of *an API we 
already have*, as DMA API maintainer do you *really* approve of a design 
that depends on callers abusing DMA_ATTR_SKIP_CPU_SYNC, yet will still 
readily blow up if they did then call a dma_sync op?

Thanks,
Robin.
