Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66F2E36F6;
	Mon,  4 Aug 2025 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754278717; cv=none; b=OhyiS3bSBXlts9BR5kPRSRH84f3LmqmIiYL/j8k7fRrW5UmJBz0YD0c2XmV0cSP/62BsGKPelexoLLViyn862YaW/Y5Wy8oErbCDC/KsIlU2QKqxUqpFSHsfPLeauoq2Zsyo9xWTN8PUvrp5MOFtWs63muARyQ2lOtD+8qwzLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754278717; c=relaxed/simple;
	bh=SOeerCe2y6K5nRKWsYQD+Gw3CrMokUtIY1kTl7H92Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDpCrFrrQUzopFF2+opqgRcbokp/xSRvYNbVMXD01AE9aHhTXKs1FP5k+juedTHTkBsZ0U5UOtHWDSPi+JXyxb/QRboHBBejuicFXg0cz/22unpAWy9sC7yDRkWhQ3DLywmFWDTPO8W44c3jLA1WRVF9KzeaJl2LefsJIC7Vrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vIsLKdYF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vIsLKdYF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SmxoINSQKVJVK+Bn4i2QXaigutnESsGDJWcnHJouMq8=; b=vIsLKdYFH8YXGskFCYuFxM0Kri
	4LEo9ReJIfgKFC95xymdzIuZHgWmCy4G3xVF1JqLP/afdrq9I84T2Y/HuFvZL4VO6QmU21lsUX/J7
	vabemJeVXNbK57caQoIcupupdF5BH7q6dfJPU0J/aad1iPWgFP1Pta6YnAxGVC/HxIlB76K9yRSGM
	9j3b/WmA+tZKaDnoC39qDIVxVYX23JxNjVp20InQWi7XyuBDNDCOuusdG9eda9qGfK1Uki2htTbQ5
	+Xwy3IqaT9W3uDTeg3KYHyV0grcCXOdru7B95ajExnsHQEygus1gpnlTvvukrNJXtwkIJZ4HcTmaN
	wXIAK1ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uim1N-000000099Z0-0JOE;
	Mon, 04 Aug 2025 03:37:57 +0000
Date: Mon, 4 Aug 2025 04:37:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Message-ID: <aJArFNkuP8DJIdMY@casper.infradead.org>
References: <CGME20250625131920eucas1p271b196cde042bd39ac08fb12beff5baf@eucas1p2.samsung.com>
 <cover.1750854543.git.leon@kernel.org>
 <35df6f2a-0010-41fe-b490-f52693fe4778@samsung.com>
 <20250627170213.GL17401@unreal>
 <20250630133839.GA26981@lst.de>
 <69b177dc-c149-40d3-bbde-3f6bad0efd0e@samsung.com>
 <f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com>
 <aIupx_8vOg8wQh6w@casper.infradead.org>
 <20250803155906.GM26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803155906.GM26511@ziepe.ca>

On Sun, Aug 03, 2025 at 12:59:06PM -0300, Jason Gunthorpe wrote:
> Matthew, do you think it makes sense to introduce types to make this
> clearer? We have two kinds of values that a phys_addr_t can store -
> something compatible with kmap_XX_phys(), and something that isn't.

I was with you up until this point.  And then you said "What if we have
a raccoon that isn't a raccoon" and my brain derailed.

> This was recently a long discussion in ARM KVM as well which had a
> similar confusion that a phys_addr_t was actually two very different
> things inside its logic.

No.  A phys_addr_t is a phys_addr_t.  If something's abusing a
phys_addr_t to store something entirely different then THAT is what
should be using a different type.  We've defined what a phys_addr_t
is.  That was in Documentation/core-api/bus-virt-phys-mapping.rst
before Arnd removed it; to excerpt the relevant bit:

---

- CPU untranslated.  This is the "physical" address.  Physical address
  0 is what the CPU sees when it drives zeroes on the memory bus.

[...]
So why do we care about the physical address at all? We do need the physical
address in some cases, it's just not very often in normal code.  The physical
address is needed if you use memory mappings, for example, because the
"remap_pfn_range()" mm function wants the physical address of the memory to
be remapped as measured in units of pages, a.k.a. the pfn.

---

So if somebody is stuffing something else into phys_addr_t, *THAT* is
what needs to be fixed, not adding a new sub-type of phys_addr_t for
things which are actually phys_addr_t.

> We clearly have these two different ideas floating around in code,
> page tables, etc.

No.  No, we don't.  I've never heard of this asininity before.

