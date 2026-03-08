Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C545274B46
	for <virtualization@lists.linux.dev>; Sun,  8 Mar 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993964; cv=none; b=nvdcr/N4DNIEjgGQ0NNaMuTZieA+aLzpntTHc2G1iQ4t5TEttVKNF19uFGj61SJClzUkZdsMXN72LHytWUhmLWSoYr1SZLleIOgV5/y1dWjKakCxkgiUO/+UoI2nCAtuCUd/N7jGqfbSBhfMH403apEaXPoGYjdMT5+BJuFSOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993964; c=relaxed/simple;
	bh=RFwQC+ynapVSJqHtn5HxtDxJR3xhkceo/7GA/6B7F8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhBnbJjj4XYb+I/g6fJD0QAehajVv/vknyi0nKtOSWDu/A6n1HtoibdBNg+tnIinLy+XEj+Gg32TlAfuLpQfQ5abSux1aj0mI87obVRYOmX93eaNwwohlxYsU+ua9GsrukZYj1RbxGcTDEhctdG35OuUph1hxyIV+0OcXZlKhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m4eM8tpo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m4eM8tpo"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd8c6e365eso877585a.0
        for <virtualization@lists.linux.dev>; Sun, 08 Mar 2026 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772993962; x=1773598762; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8l9HCiIJk8f6YJBdD7T3EgoBIxuKKvMDtuYccvH3ixY=;
        b=m4eM8tpofeGk2S+laJgQCpr+3JN2+Xqh92Yx5XkaKjpsG8LyZF12hvhcfCevEIQPee
         i1y+eNvnPT78s0dymmqNMC1KRQRi/Q6xUzGAC96f+KQRh8f7xU5cLcQQZImo4lQEax5x
         KBrDZSBJHLa+Ioid6YD5De4Lgg28PbA02RAnNZccBbsGtYKJegASU15PNGVhB/Ssrfbe
         WAogb36/Id3OGbcyP4uSVDX7iVkAtU/+0ceDhWzzbTDlnIZl04/OSnfLvZu3/80B83fu
         kr5X42c0SxkKKxpwFNzVBDclT73X94LCOILOimoj70EwClJk3xb5olWalYZueTCodw/m
         wEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772993962; x=1773598762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l9HCiIJk8f6YJBdD7T3EgoBIxuKKvMDtuYccvH3ixY=;
        b=ChA+uuPB1pRyLvYMqN/vMWaKiCy5dsYdJ2dkDrCvevpG4KLZxdt5BFDEcIL8wOas17
         EPagrUd45/Eq2fGrk9qW9KZKAD3c5ncM7zpZyMAynShdjdxg8jvU9HhmoFE86GViJ48Z
         ZIoA4K1N/K/EespdmpKna3xPT2Vb1z4cq4Tdx/0pLp3lZB1CgsZKuLJxSw9p1Hyc1uqK
         oPB2ZqKu8AR++rzYdLfALlHQ4wV2zyUCJArX4kbpg1FzjpQJP/LM7//1+xJamb4PMtjI
         5famST02scOm6G1hD1KBP/TuE3NBa0A9gUcegTHGQRLLTZ7FW4ltcbOICFnp3qCI33Y/
         CTqg==
X-Forwarded-Encrypted: i=1; AJvYcCVV6zb4LRkZBPEvQd8P0qbuwF2fWgTe4xYhlE9LPaPG7yrbii89/RVX8KBpTMqsfx2em4DcTPxLgfqLK1uCOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1zaA2B1q5uU5zFkgA+K5FwJMVf4kLHz+HViq9RXNAeuBOveD1
	Uo7/Ftqy7ln9mSOMy2ijKdxNA2fIn2cC8yPjLJOKIt97JYLsQxAJ4jS+vBNEBIPM8ow=
X-Gm-Gg: ATEYQzxKtRMn4fMSOQkLeuLd8gFvenVu2Jgjue+jeauDHf6uwIl30J0avNS49okFaKw
	MdnFp86sKJ56DDtchSV3Q28yL/d2WIe4aVi6i/fqws4HevHJ6vyCOyFk8EvyLD2lwl+IAIBD5xM
	VPLX6/dQhJH4aU5nna9N3bvVnwIg1x469hXVxJKXE7Lg1pYzXvJJHvS/cEPNautmuNkRLdC9aXJ
	ro2XxHYjW9wXyRKA3MqkWCwg4jjAV50JiHtBSmSpFIbNop0kNew7Jnp7tRGEZ5AN2++seDBSIZS
	8LNCn0MamCyjHaWce+KPKogFD0KA5p1LxRWNktY1NPqfpt4fEhAfvovGAhGDw2UiEIl/BPhstIJ
	tyCP6lyxeJbWuznljWgb3l3LnY9ua7AlpmoofGSpy9x5PrnvDE1jMQ8jEKWDNaEUrry3SUiLEKH
	J6EMNWGljw2qXubBc+3kzS+GVmTE2/n6IdAkuLW8Jm+7pgmfXFDOVo39N1cl2hdOJ/84EfMIHpZ
	4TcMiDyzt5SDFR2wOM=
X-Received: by 2002:ac8:574b:0:b0:506:534b:7871 with SMTP id d75a77b69052e-508f496e9b7mr109431651cf.46.1772993962390;
        Sun, 08 Mar 2026 11:19:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f653c566sm48622921cf.8.2026.03.08.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:19:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzIim-0000000AbBt-0YB7;
	Sun, 08 Mar 2026 15:19:20 -0300
Date: Sun, 8 Mar 2026 15:19:20 -0300
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
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: Clarify valid conditions for CPU cache
 line overlap
Message-ID: <20260308181920.GH1687929@ziepe.ca>
References: <20260307-dma-debug-overlap-v1-0-c034c38872af@nvidia.com>
 <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307-dma-debug-overlap-v1-2-c034c38872af@nvidia.com>

On Sat, Mar 07, 2026 at 06:49:56PM +0200, Leon Romanovsky wrote:

> -This attribute indicates the CPU will not dirty any cacheline overlapping this
> -DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
> -multiple small buffers to safely share a cacheline without risk of data
> -corruption, suppressing DMA debug warnings about overlapping mappings.
> -All mappings sharing a cacheline should have this attribute.
> +DMA_ATTR_CPU_CACHE_OVERLAP

This is a very specific and well defined use case that allows some cache
flushing behaviors to work only under the promise that the CPU doesn't
touch the memory to cause cache inconsistencies.

> +Another valid use case is on systems that are CPU-coherent and do not use
> +SWIOTLB, where the caller can guarantee that no cache maintenance operations
> +(such as flushes) will be performed that could overwrite shared cache lines.

This is something completely unrelated. 

What I would really like is a new DMA_ATTR_REQUIRE_COHERENT which
fails any mappings requests that would use any SWIOTLB or cache
flushing.

It should only be used by callers like RDMA/DRM/etc where they have
historical uAPI that has never supported incoherent DMA operation and
are an exception to the normal DMA API requirements.

The problem is to limit the use of that flag to only a few approved
places. I fear adding such a flag wide open would open the door to
widespread driver abuse. These days we have 'export symbol for module'
so maybe there is a way to do it with safety?

I'd really like this right now because CC systems are forcing SWIOTLB
and things like RDMA userspace are unfixably broken with SWIOTLB. The
uAPI it has simply cannot work with it. I'd much rather to immediate
fail than suffer data corruption. Jiri was looking at adding some
hacky "is cc" check, but I'd far prefer a proper flag that covered all
the uAPI breaking cases.

Jason
