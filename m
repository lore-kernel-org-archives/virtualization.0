Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FE1799F
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443206; cv=none; b=W3X5UnY1Q4JQO2+PMbWmEnV3hRLVG/5yX6Oa/O0aMQg2aSqSe/TGRn0Why/ydoqI1hjCmWbyuyNCdFUsGvx2KCRl4paUHf1sx/ui/Hee1f4SNOIXpHLXSKlyQLThtR8E2zlo+SElvX6Iz+i8OAkL17fV6V4YlwBQx/BaFxHGPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443206; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn3Viot7LKoOhafc8b3vVRxvC3D7ltTk7S5xAXYHYoJB+bNiz76RA3glDQ6rBE1eFLyHkh8pPBz75whqYaWQjHxGntQ3yWKauwaWC7JKgR/kT5l+w82a42742WiPanWyRblmOT/q1DFIVBumMzqSyo4KED7s/6T64Bdr9uM913s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GMql1KQ7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMql1KQ7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GMql1KQ74+8JMbDJEcojNIGJVq
	DMA6z6ID/w5ddUG8GFg4ufbdATkIXt3qVuQv2DK9UXa3Ue4d9uoG4qci+5o3VB/4H/PiOM+ajteZD
	jceGFxAICCjL/cX4UAySg1ULxZfR6x+i6rfTp64ZyJuSuHlQIiWCeVNzSpsqS7Av95Q6gWRYxUuv8
	pB5yEpR8chhxqmeSrQn29DxqYaQ1XzfQqhteVE9ekr/pKwv2qGtocOq0/k1xjOeuN+DiKLZbZGCWJ
	QhmBqWrjE1OEzynjlaxHJL4Sba7pZ/hAKWWykWABlpziJ6IEQuGMiPA4y2kgHDmbj8zkdAh8b49vj
	+M10Aa1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZC9s-00000001rSO-0wHE;
	Wed, 31 Jul 2024 16:26:36 +0000
Date: Wed, 31 Jul 2024 09:26:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/4] mm: Document __GFP_NOFAIL must be blockable
Message-ID: <ZqplvMXNmi3NquCI@infradead.org>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731000155.109583-3-21cnbao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

