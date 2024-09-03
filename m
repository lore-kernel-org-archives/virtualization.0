Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0951D6C46;
	Tue,  3 Sep 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348471; cv=none; b=QI2hO2aIt+oZEG1iSIjA1tcxT+SSqnwrLvrJ0Pm6QiZOG5TYRLAguqbiQ5+gCvmmjrjyudApZtuqU+5P8LJj3SguOCgiQsEcLADCxCrzpS7FOImUPoYCHnH86yerfBZe+X3W6kW3cLncaXEFhQ7dPdLFhv0dzPnGc0Rn9eV0vHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348471; c=relaxed/simple;
	bh=aeaA2a5vzKDuxVbiVuifdH1E1Rnyj25ZBVitW+tRHbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it408ZBQZ6dMu3n/XE7+CAlvWOx2JRimaTNVqmqSVG7qv2CoEvqBAhMaSmJ4gKKlOH1u03NBF92PegmAd12WHUVzTgexEvKqVC7JIfh4deQZtN3xQbXfP9MWtdFI2AXuMhMkCwv/8xA7Vxg0UGeVaD2dB2M6WxAAoVk+msDDGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1D91227A8E; Tue,  3 Sep 2024 09:27:44 +0200 (CEST)
Date: Tue, 3 Sep 2024 09:27:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	"Michael S . Tsirkin " <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-media@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org
Subject: Re: clearly mark DMA_OPS support as an architecture feature v2
Message-ID: <20240903072744.GA2082@lst.de>
References: <20240828061104.1925127-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828061104.1925127-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

I've pulled this into the dma-mapping for-next tree, although I'd
love to see one of the vdpa maintainers look over patch 1.  I'm
pretty sure it's correct, but a confirmation would be good.

