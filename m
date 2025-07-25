Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A4C2528E1;
	Fri, 25 Jul 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473901; cv=none; b=fWQHnCsLIiH2x9Q2hi0Mrpq19MsPd6/ng+mj++AajE1xsyYQY0Xnm7/30oyATiqOYennzwfEzPqYy9HeSfAWtb+73/3uqp3UyeLXVzKfbfV2Afj6dIGgbBJgJ+TmNXy9/X6+n/E8ogvatDCo7JcMYFM9m5X8HVWQ4tP9V67w7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473901; c=relaxed/simple;
	bh=8+OH0jpnYCxLHJivUXbltpTlvIRJChdCd+Jh3a0RZJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J90eKvwEUrK8PXPIMqaH3QSelf/2QniG/0flrwLrxqfovdx1sWe+BiXe5J7AfLzLSedyIziwDSCYrZjiHIQLe1NQe/AWRRV0afGK0nieD72SJEtK6r6nr9d6JTnhOCvOV5lzq3LT6PTUQiHLDLekKD1S3CffK+S6OxOpJQxe6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E344176C;
	Fri, 25 Jul 2025 13:04:51 -0700 (PDT)
Received: from [10.57.4.83] (unknown [10.57.4.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 167FB3F6A8;
	Fri, 25 Jul 2025 13:04:52 -0700 (PDT)
Message-ID: <02240cf7-c4d4-4296-9b1e-87b4231874a1@arm.com>
Date: Fri, 25 Jul 2025 21:04:50 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] dma-mapping: fail early if physical address is mapped
 through platform callback
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
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
 <5fc1f0ca52a85834b3e978c5d6a3171d7dd3c194.1750854543.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <5fc1f0ca52a85834b3e978c5d6a3171d7dd3c194.1750854543.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-25 2:19 pm, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> All platforms which implement map_page interface don't support physical
> addresses without real struct page. Add condition to check it.

As-is, the condition also needs to cover iommu-dma, because that also 
still doesn't support non-page-backed addresses. You can't just do a 
simple s/page/phys/ rename and hope it's OK because you happen to get 
away with it for coherent, 64-bit, trusted devices.

Thanks,
Robin.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   kernel/dma/mapping.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 709405d46b2b..74efb6909103 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -158,6 +158,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	phys_addr_t phys = page_to_phys(page) + offset;
> +	bool is_pfn_valid = true;
>   	dma_addr_t addr;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> @@ -170,8 +171,20 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
>   	else if (use_dma_iommu(dev))
>   		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
> -	else
> +	else {
> +		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> +			is_pfn_valid = pfn_valid(PHYS_PFN(phys));
> +
> +		if (unlikely(!is_pfn_valid))
> +			return DMA_MAPPING_ERROR;
> +
> +		/*
> +		 * All platforms which implement .map_page() don't support
> +		 * non-struct page backed addresses.
> +		 */
>   		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> +	}
> +
>   	kmsan_handle_dma(phys, size, dir);
>   	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
>   	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);

