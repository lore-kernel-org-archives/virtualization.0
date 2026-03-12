Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89285D8F0
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317983; cv=none; b=DTjjYQqXSt8EyeKkXdhfwfUrd4GJZFlwDbLBiqWjorZ8hnV+HVmmPoq1t8D63iLeDsprVFCjouzaAgw8bKj/MktHo+TJrbHd1VYSklH5PEqjTWD17FybpzbVw8/OMk4Jg8RZhNmQbs+h0PB6Xz53uHBCkn5kxXJmlunQ4xlhS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317983; c=relaxed/simple;
	bh=Oj/7ehc0cCCCDQU/7pS4vL4fF7AXLJnL/YyNxYgW3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCBv0VZhzmgZEuJ5T0FrrxtoX+g7tNBMWXXsMSTdEKWE08dAzNiga3/EQCgs6lbGXqDlLS1Ach+LtvMFt2Ip5L59D+yuVc+wl9QVJQ/VcyJKtlNsIN/jIXmpJUvdqsu6UklKBb0DEDCJjl0nvSmNHJINOCzd1tSHNOLEdmk61v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D9Mu/2d1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D9Mu/2d1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd7aab92dfso118245885a.0
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773317980; x=1773922780; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=D9Mu/2d1rI3rO/NLHwvfL6+MnJBWcR9td1nnToy+ohlP1Jpv17K5jc/zLs5tZC3dV2
         7AyA6wxy7epVHAWeGPKEME2GTDuUrGLPxgl4V4ZGMYB5o+gCil+ut6ALpBedTS0SwWVm
         NbrOoLhw+dOXe5JMZR2CGUrO7nGHY/RxgZpuuwIPKKW7FuJh/Y2qTIMbEzutooYF66Gf
         OAzZC5DsYXrsUVg3B/Zj6UU8ESCVUXT0DB4Zfe7iRgZxxwrZlUe5Ipqixu89NGmjgUh8
         FdV4nvKbTx4BRGDh78Z2+SpCk9wQCyNYfBtG53QwIacYNx/mbYMpg8q+yoMh4QdVaY67
         GOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317980; x=1773922780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=K9P9U1xbegT9Pr7HXz6e9RTBq0y35nmvYZ1WhJcSlI1dIV2x5f0Zf9NFrYNDANnD36
         bT87vi0/95EPrylGG2hB6SVpQwWv5Ox+w0UzlJ7hHbrq3ZhHono5HKl2TlQyUbeCnKP9
         mTPpHF0JzS1XbfKgATD675VmZjZsPIMfeFBQ9Tkm3MmBj30wFh/5NmIcW728sGtZYRlM
         sUFaSCIPBTz86b8MVXo0EvblnUbdewNDlqGu6nANk2yzPC/KSDrxbIOBYCLSbab2Dyue
         qpx+echnJ8j/ObQMZarnuU+25A7C0MqRijX7avOXk/LX9nNOen4REC3E3aHOcM0rknWD
         RX2g==
X-Forwarded-Encrypted: i=1; AJvYcCXqlyuQfLzwHt+F9aYOJ/HA6/sv3Mp5sTgn1NsOINkRIvvYCCYAQ7OHhrthlttQNIJkWkgy4xGdoVn9ujwPyg==@lists.linux.dev
X-Gm-Message-State: AOJu0YynyOEt1piMnhLxL2hSq4li725Rb5b2npuekxXMDNBdTTSSMCnZ
	SXe7Sw+rf1WmIAWYjULHKU5/BKaJHXGLRF/H4bNazi11/x65mo6EtgwT2TgxhXlwEck=
X-Gm-Gg: ATEYQzwa5C+7rDKB4gUXM6mvtuusbFcWkhpPffCcfRUY+ytg0tjwNIm3WkG1xsJvnrO
	bHWvQHqsNr4eShhjiXpSugt1Mv6MfnIKiFCjU4sk49zgK79yffJT9UTyt6hhZOJ4JE0gkqhQ/Gw
	8h+hDXSBAvQoIjFgO/IuSA/CAfGLmq3y4Y+kPsSPzCulFj72KXgKccW/IqPLoazrdyNESAaSZZO
	IiFTKYw7L1mV7aJMX6XiKyTydMuwybCFLuBcTzuabmRCzptPCD6rpwSjGXU7P7l8wLKlACmuErw
	Ozw+//r0UQdM9+EQxciUNe8rHBSlt9d75gFlVriuHwVD92CLp4KZCSLD6+GAa8UeVVZ9+IkVHAr
	JQS+5dRjlsfK9A4whOUjf0TbFTc/p6GcGu11qTQnb2Paj47f8IZG3Au6lc+xU2D68fjaaRroqEP
	b8YCAdKKNaqgZnBEnlR7+MZA6LZhGZkvdYXxvfNxfGx7FHZ6dn6rRz91YcgJ0HBMOSvgCD2nnNG
	lYktzis
X-Received: by 2002:a05:620a:4041:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cdaa7b6b03mr382866785a.15.1773317979843;
        Thu, 12 Mar 2026 05:19:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm321675885a.34.2026.03.12.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:19:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f0r-00000006esN-1WXU;
	Thu, 12 Mar 2026 09:19:37 -0300
Date: Thu, 12 Mar 2026 09:19:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/8] dma-mapping: Introduce DMA require coherency
 attribute
Message-ID: <20260312121937.GD1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mapping buffers which carry this attribute require DMA coherent system.
> This means that they can't take SWIOTLB path, can perform CPU cache overlap
> and doesn't perform cache flushing.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-attributes.rst | 12 ++++++++++++
>  include/linux/dma-mapping.h               |  7 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  kernel/dma/debug.c                        |  3 ++-
>  kernel/dma/mapping.c                      |  6 ++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 48cfe86cc06d7..69d094f144c70 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -163,3 +163,15 @@ data corruption.
>  
>  All mappings that share a cache line must set this attribute to suppress DMA
>  debug warnings about overlapping mappings.
> +
> +DMA_ATTR_REQUIRE_COHERENT
> +-------------------------
> +
> +The mapping buffers which carry this attribute require DMA coherent system. This means
> +that they can't take SWIOTLB path, can perform CPU cache overlap and doesn't perform
> +cache flushing.

DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
system where SWIOTLB or cache management is required. This should only
be used to support uAPI designs that require continuous HW DMA
coherence with userspace processes, for example RDMA and DRM. At a
minimum the memory being mapped must be userspace memory from
pin_user_pages() or similar.

Drivers should consider using dma_mmap_pages() instead of this
interface when building their uAPIs, when possible.

It must never be used in an in-kernel driver that only works with
kernal memory.

> @@ -164,6 +164,9 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>  	if (WARN_ON_ONCE(!dev->dma_mask))
>  		return DMA_MAPPING_ERROR;
>  
> +	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
> +		return DMA_MAPPING_ERROR;

This doesn't capture enough conditions.. is_swiotlb_force_bounce(),
dma_kmalloc_needs_bounce(), dma_capable(), etc all need to be blocked
too

So check it inside swiotlb_map() too, and maybe shift the above
into the existing branches:

        if (!dev_is_dma_coherent(dev) &&
            !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
                arch_sync_dma_for_device(phys, size, dir);

Jason
