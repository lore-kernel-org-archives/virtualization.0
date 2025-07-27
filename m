Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F23B7A8;
	Sun, 27 Jul 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753597833; cv=none; b=WqqIaKGlzOzmyBdQ5WncXXvCuLKWpjTwmUuKgxNV2XKE8tT9ChcJ8MdDrebpzjSUIs+zYDSwXjlyqwdyaYL+fRDs1TCGU+Fpr+ASh9TGFT4BypY42ukqOXgj4FXG+ffnTiy2OWCTh+RENggxoUZKT2t7q5PHgoH3OviAw4zDf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753597833; c=relaxed/simple;
	bh=JJ+HLI2Xg1lbocAOdaQhvUAP42x5alyGCI2q27jF8yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtD894M6iphk/CirXRnQX5nOnxBxvGMczlTNakgGluWbWqZ3OaUgfx/GDppdILV2yDwF77sNMg/1LcsAQnQsAy4gn5rUYBispVMv9wj9sQXZOrfOPOq67IjLtiXyVFWkgokDwrDS/HIfFERssE9Q4l1Av5KkzLwCRkjzfSFXqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O08zmCcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O08zmCcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8F2C4CEEB;
	Sun, 27 Jul 2025 06:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753597832;
	bh=JJ+HLI2Xg1lbocAOdaQhvUAP42x5alyGCI2q27jF8yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O08zmCcVnVLnA+ZHOWb+eSajAvE6pm7DaQ8NMn+fNKRDLa2pRo5BX8aW+a83tPDqU
	 GgXaGRHEjqMTQaTSEwiTq+LZsr8fgXvxAZupxxQHihlRCEGeKRTYN9ZBvXGeZH5v6l
	 cNbEkyR0f0fisjYOpU+PgL5jY4ZNEON7FnZKH71NVsw/KoC5dN6YmBpvTPLR3GvZbC
	 q9K5qaRFyq+a0yKXV5afTeXYdwYrJheYw2Wafv+rq71uOtdWWY/B2IP14x5XV0q/f0
	 7brS93dUX/SVOI+l3RFg45/NhN//8bCTqZoEMGjszephsi3GB/4IZrVBAlBjvQt1f+
	 qDDzVvsJtuDAA==
Date: Sun, 27 Jul 2025 09:30:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH 6/8] dma-mapping: fail early if physical address is
 mapped through platform callback
Message-ID: <20250727063028.GX402218@unreal>
References: <cover.1750854543.git.leon@kernel.org>
 <5fc1f0ca52a85834b3e978c5d6a3171d7dd3c194.1750854543.git.leon@kernel.org>
 <02240cf7-c4d4-4296-9b1e-87b4231874a1@arm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02240cf7-c4d4-4296-9b1e-87b4231874a1@arm.com>

On Fri, Jul 25, 2025 at 09:04:50PM +0100, Robin Murphy wrote:
> On 2025-06-25 2:19 pm, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > All platforms which implement map_page interface don't support physical
> > addresses without real struct page. Add condition to check it.
> 
> As-is, the condition also needs to cover iommu-dma, because that also still
> doesn't support non-page-backed addresses. You can't just do a simple
> s/page/phys/ rename and hope it's OK because you happen to get away with it
> for coherent, 64-bit, trusted devices.

It needs to be follow up patch. Is this what you envision? 

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index e1586eb52ab34..31214fde88124 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -167,6 +167,12 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
            arch_dma_map_phys_direct(dev, phys + size))
                addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
        else if (use_dma_iommu(dev))
+               if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
+                   !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+                       is_pfn_valid = pfn_valid(PHYS_PFN(phys));
+
+               if (unlikely(!is_pfn_valid))
+                       return DMA_MAPPING_ERROR;
                addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
        else {
                struct page *page = phys_to_page(phys);
~
~
~

Thanks
