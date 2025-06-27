Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD417A306;
	Fri, 27 Jun 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043738; cv=none; b=tpSf4EI36esC1BvzaA6VfNvyjgXbY3c6bdLwUYb2wMzhRNnFrJGvM0U/gWtfBjXYesvvN5/nRb45jxKl7c3jt/AAjVU+0QTPUadRi6MS0JMpUOAvKPNAgePE5TOI6pO0QYN0WwEdJfeaKXXada1O1PgHdZkIJTM1zfzk4LWIagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043738; c=relaxed/simple;
	bh=tYzCzCM3VZZF7WSTA7gi5cm/krCk6YzEM9VmpLpknjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np1DbNcBKornihZGTPKcpXcU2WRWOcUisLnnQMHgL7Ro45H2ndseGKNTTusR5L3i5hR3YCIv5/FKfH6StYlDdV7rCQn923C+nWILTBdJwA3Bfp0ptpImHKDLV6OS4WlXYwjJIpLWbuKdLzPQPqBuM+58XpvSBRuGOMaGEoiiih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvSgedwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvSgedwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EE2C4CEE3;
	Fri, 27 Jun 2025 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751043738;
	bh=tYzCzCM3VZZF7WSTA7gi5cm/krCk6YzEM9VmpLpknjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvSgedwLkGNl0rMmzrS3+y77Cdl6mvdnS/K1+GmEohvH0tjCCcyHtHpGONE48PbuE
	 klXY+q4z8M1Sr6BMdy5xKLE+7d0yKqmUTsHjPtcmxh4vJJtZd+k3yW/hyDz3WRQrN7
	 9wzjcEy3jjvepJtDybVtHKrX2dD+yzLWynuamatcAKtm3zUP2H46mTYvoCARqj66Pz
	 6UkaSbTPpQWjV9eejBMr9V3CGDdGIUzKXNzrhwjf9KcP57JXzI9oiJZKCpv4d77ArY
	 EG95TYcKm5S2WkFdvbxGcvfwd6s5pEsCWXf4aKpX4Whf3v+9N/L6udSPyAT+368SB1
	 8wWh+cVapuQEw==
Date: Fri, 27 Jun 2025 20:02:13 +0300
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
Message-ID: <20250627170213.GL17401@unreal>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>

On Fri, Jun 27, 2025 at 03:44:10PM +0200, Marek Szyprowski wrote:
> On 25.06.2025 15:18, Leon Romanovsky wrote:
> > This series refactors the DMA mapping to use physical addresses
> > as the primary interface instead of page+offset parameters. This
> > change aligns the DMA API with the underlying hardware reality where
> > DMA operations work with physical addresses, not page structures.
> >
> > The series consists of 8 patches that progressively convert the DMA
> > mapping infrastructure from page-based to physical address-based APIs:
> >
> > The series maintains backward compatibility by keeping the old
> > page-based API as wrapper functions around the new physical
> > address-based implementations.
> 
> Thanks for this rework! I assume that the next step is to add map_phys 
> callback also to the dma_map_ops and teach various dma-mapping providers 
> to use it to avoid more phys-to-page-to-phys conversions.

Probably Christoph will say yes, however I personally don't see any
benefit in this. Maybe I wrong here, but all existing .map_page()
implementation platforms don't support p2p anyway. They won't benefit
from this such conversion.

> 
> I only wonder if this newly introduced dma_map_phys()/dma_unmap_phys() 
> API is also suitable for the recently discussed PCI P2P DMA? While 
> adding a new API maybe we should take this into account?

First, immediate user (not related to p2p) is blk layer:
https://lore.kernel.org/linux-nvme/bcdcb5eb-17ed-412f-bf5c-303079798fe2@nvidia.com/T/#m7e715697d4b2e3997622a3400243477c75cab406

+static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter, struct phys_vec *vec)
+{
+	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
+			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	if (dma_mapping_error(dma_dev, iter->addr)) {
+		iter->status = BLK_STS_RESOURCE;
+		return false;
+	}
+	iter->len = vec->len;
+	return true;
+}

Block layer started to store phys addresses instead of struct pages and
this phys_to_page() conversion in data-path will be avoided.

> My main concern is the lack of the source phys addr passed to the dma_unmap_phys() 
> function and I'm aware that this might complicate a bit code conversion 
> from old dma_map/unmap_page() API.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 
