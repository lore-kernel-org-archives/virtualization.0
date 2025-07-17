Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E11A2541
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758726; cv=none; b=o7fPugi/9gKUqg/c3uHWgbJx9gVdcdqta/UaoiPeeSVSxKNIZ2XRmX6C9cOm0P5CbuhUhZfHGeAe81GMmysXqO2Kh5Y9EsUikPhT/ypOku9kprpddKV8hIMqrqqN9gkeNt7Gxw5AIED9aqKU+4FE0kidL5sO6xo19UMRwEIkwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758726; c=relaxed/simple;
	bh=z2z9OenFaQFo8Yw+Ya8ieWGGBBMxpYWICf7q48CcMh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4jcR1TlShzNMa4flwtZ5D1zQi9HhsYDpvSq3X3RqKidsfOTTyD7vczLQTvzns2472Cow5D3Cfw2+XzSSIETODm26xmS82Zwo9a0BRjyt1t/G5M134XKPdMkJhF+B3W5Ges/Xy6XxZwP3O35qDup1HW6AvxLgrC+hM47vX0ZBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dAkCEFW7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAkCEFW7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R9eaq33RkhcFSbSUjoHcP2qsAeTezdphMnOwT07Jogs=; b=dAkCEFW7R9Nx+/WaIHraywab9Q
	AgWaJU7MNoGm7yepEf62oCavTkja01r1Lwye5NdPC13NC6DfejmMfsENaDDUkCjtQLJFjDLyfOVyK
	FXHosrN10mpBmHKutwFTfWenl4l6+OOVozs7wpU39uiX7UOQ6ujvAs2dkEzo3G/dd2LBLK8URp/7N
	lLQtT5s900dnX6lp+24pkrs10Yh1MOytQYD7HmYI+brjpJBf0LpFtW6rt3e1OhGaqRggSoPB/hpz/
	8ItqkV00yiE3gUrx0FH4FQJDCiPbK/AmvTKy9PxXQg6BP8pDYBaJbWe0zEtrVyI+jvJsDoVeJ6fXK
	oUi2aCgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucObz-0000000AFdC-3BT9;
	Thu, 17 Jul 2025 13:25:23 +0000
Date: Thu, 17 Jul 2025 06:25:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org
Subject: Re: [PATCH V2 9/9] vduse: switch to use virtio map API instead of
 DMA API
Message-ID: <aHj5wwaQHyRAcrcN@infradead.org>
References: <20250717080237.6518-1-jasowang@redhat.com>
 <20250717080237.6518-10-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717080237.6518-10-jasowang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jul 17, 2025 at 04:02:37PM +0800, Jason Wang wrote:
> Lacking the support of device specific mapping supported in virtio,
> VDUSE must trick the DMA API in order to make virtio-vdpa transport
> work. This is done by advertising vDPA device as dma device with a
> VDUSE specific dma_ops even if it doesn't do DMA at all.
> 
> This will be fixed by this patch. Thanks to the new mapping operations
> support by virtio and vDPA. VDUSE can simply switch to advertise its
> specific mappings operations to virtio via virtio-vdpa then DMA API is
> not needed for VDUSE any more.

This can now drop the depends on HAS_DMA and ARCH_HAS_DMA_OPS for
VDPA_USER.

