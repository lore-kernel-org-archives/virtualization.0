Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E630C359
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318421; cv=none; b=NnE7dE22qNP7l58Y6gcfxg+hXyfhZXQJLGAyR6y2nl4njSn5A8LzSlJUCsv8f+AEeaCOO0f75z+HftX+0ndL1Sh+HZzNd5CjwGEf6RuJuAd+N+EVliMl9FqPiDTNztGR0qNvGbP4V39g5c3dYcWaJHyA7SdhVa/1UUk/TNgLz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318421; c=relaxed/simple;
	bh=kL0Vtw+iePKp4mxXk49bsuyKV2vV08txbV9fCNpa5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/X0crDgzp/t8UwaLj2QA3QvGVEFHvChOsFUVuT0ZVPezfVfbOxsQi7ablCR7t4M0VYp4BLqL6HL82d9HDJ3PN5OSiEiinAhg7aFBS5aqEVEKAEeDo6dadADV7bCrfUN0uG9VfK3JrC38r6oLK0NscbaP8SkfnnoQ90QJFJmvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QYHqLXwm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QYHqLXwm"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cbc593a67aso89574485a.2
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318418; x=1773923218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bVLYsZeqdLLR0Cw+BVzWgzWP+lyAr3AqcCFZTxFfl4=;
        b=QYHqLXwmsE3RmI7dCNEMnMY4iVLxaoo6Xr4Nc83+5RbzLQOLtBFXWbdUH/bmpEPFNI
         4GrJx9H8U0tHQZT9w7rkuqWY57VBNUOkvl0kxkKOx8T+LBEWf7S8RLBa18YULEEutGz1
         1Lgpa417NIm4+TNw4Uj69dbw608MTHa4aIlvkDzL06MhxFVfb9zJALtSMAr6ewSt97nO
         9XWt23XqUg0sX6CaltS+D9BxAyZlx9szRO7RtnmBE7KLYOFCkLIJ1ON4HowXtQqnhJsi
         ytaXEmGvRg1mInQ96leeevH3+TNG3sEC+pmc58z/WjOK+p4K65M6td3ulKMuZKQ3gL4l
         Anmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318418; x=1773923218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bVLYsZeqdLLR0Cw+BVzWgzWP+lyAr3AqcCFZTxFfl4=;
        b=lToy8TUZlCEQnGn6OSltHz8t7HLn7cod6iJqLxKmtZjBsyGz/5YHr+mqLRn0Wdyvdd
         Gd55TkcdPBtmFWQOww3199Qw7nKpZX19QJEV73zFLEoktKyQBRhV43nS6D1FesOoeLCZ
         1Mvcilyni8dVgkoYG2UFRrvqjLbXZECHb7RgFHTiSSI6V7SY8Nnh9h748cX5HEOCYgsj
         t1EGqnpnGqju+LrVETNzqFJq/6C/80+xONp2zN0iHzYOgJx57oNRkxiYFf3HbIQ5DtjZ
         bfqVG5Sjc971zprINcl5nvNojqydu1HvSu8qDpKFzsdpHrfkjN+UdFIg5rLnYDY7yAcC
         dzcw==
X-Forwarded-Encrypted: i=1; AJvYcCUHPwGHZbj9NusxAPep2zlBue0T5iRwYfU5rWl6ZWtzjtK6wr5vDlvIhSQyzVBXmYn7hVoy8AuDPUF/nQ17QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YznjmLZAum2ydUSMGo7ArOZ1HvFLZHtShhxoywbAWVRbde06a3N
	8tRF3Cqge5R8SOp6mIaL271YrqdOeCCiTI3o5fV+bqmDPxgr4TZwNilBC69aax6Dmbs=
X-Gm-Gg: ATEYQzw3Ly41kMBL7ZxvL8kWKrg2fNG15lGVf9jUUUlDs8W8WS0ui24fm+RbhcWV5Bz
	fqSTJgTxUTH1Y37AOg2xoquxx039hkh6uzhcGhpeGowBkUj1YPSD5NqleOX5aAL/Ezv9O5alzhs
	KWnawBSeME3iS5CL18YySnRcMxBa6pNPcmzJ74hnqQz+W3QYlPHbyFsyeZgakFH1EIQG5eKR2hD
	kpBtnczPaGBmwctHAV1c/6VnESf4faGa2WSjfhQazmSAWXmjnDJXOFNbEyr7gkVZPtYw4c+F4/6
	wrKz7Fxt7BveFwiI/nrrQ3dk90zmuWSD66rdS9VuNSzT3Zf+jjq4o3Lbbzm2yGcFi24j+jrmmNO
	vLQ+qwy6HM9B5NjABrIHnnYNDl1uPa2l00tTZ1vS46X0GFsmI4KhAOZDKiAK80/xS0ej9IWBeLn
	igqm2sO1noTkE+kcsllEYl/ZX68kbs3b5/03i6rGAU4qDuMPe9PNG8vlxph67w4uzlsl5Vr2RJB
	9APwuHg
X-Received: by 2002:a05:620a:4692:b0:8cd:9322:7c55 with SMTP id af79cd13be357-8cda193043amr787228385a.17.1773318418176;
        Thu, 12 Mar 2026 05:26:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm328304485a.12.2026.03.12.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:26:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f7l-00000006ewH-1owB;
	Thu, 12 Mar 2026 09:26:45 -0300
Date: Thu, 12 Mar 2026 09:26:45 -0300
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
Subject: Re: [PATCH v2 8/8] mm/hmm: Indicate that HMM requires DMA coherency
Message-ID: <20260312122645.GG1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:51PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> HMM mirroring can work on coherent systems without SWIOTLB path only.
> Until introduction of DMA_ATTR_REQUIRE_COHERENT, there was no reliable
> way to indicate that and various approximation was done:

HMM is fundamentally about allowing a sophisticated device to
independently DMA to a process's memory concurrently with the CPU
accessing the same memory. It is similar to SVA but does not rely on
IOMMU support. Since the entire use model is concurrent access to the
same memory it becomes fatally broken as a uAPI if SWIOTLB is
replacing the memory, or the CPU caches are incoherent with DMA.

Till now there was no reliable way to indicate that and various
approximation was done:

> int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
>                       size_t nr_entries, size_t dma_entry_size)
> {
> <...>
>         /*
>          * The HMM API violates our normal DMA buffer ownership rules and can't
>          * transfer buffer ownership.  The dma_addressing_limited() check is a
>          * best approximation to ensure no swiotlb buffering happens.
>          */
>         dma_need_sync = !dev->dma_skip_sync;
>         if (dma_need_sync || dma_addressing_limited(dev))
>                 return -EOPNOTSUPP;

Can it get dropped now then?

> So let's mark mapped buffers with DMA_ATTR_REQUIRE_COHERENT attribute
> to prevent DMA debugging warnings for cache overlapped entries.

Well, that isn't the main motivation, this prevents silent data
corruption if someone tries to use hmm in a system with swiotlb or
incoherent DMA,

Looks OK otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
