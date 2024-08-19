Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003B171AA
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071772; cv=none; b=IC0UjSoNkfLvFyJHP7zJTi0uuw74+qWJKzQxj4aPl2sXPLDR/1ufZsXkwYkT5OEhqRjInB4Gh9y4BRr4NgVDz7u6ZDy9x3uPtZBS6aS3dAB5f86NQA68PiiXSAr2Gh6TNty9NY6D+T3PavcEBM7Z+awWyhllL0Bnv2G74Ry1GC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071772; c=relaxed/simple;
	bh=iMEX1IreU9Sp5p9wSHJYCYhDGzkJISLw+6vmF7iYw94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvAswtDA/L4yHngFzupqifhhKfgV3ndUEDpr5M0WSo6gJ+pI1L/ArK27/9aDWYE8fmLor+M6b1SIhgp7qiADZ5W/qoyvS06R52k8vs5t9ni5cOyHRD3PKMm1KdtKYTtNd4YM8xPo6vmSZ6Y240M7VyGmIFmlEbRtFrPISObhNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 229CF68B05; Mon, 19 Aug 2024 14:49:25 +0200 (CEST)
Date: Mon, 19 Aug 2024 14:49:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, torvalds@linux-foundation.org,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <20240819124924.GA7642@lst.de>
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com> <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com> <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com> <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 19, 2024 at 02:33:06PM +0200, David Hildenbrand wrote:
> It should all be caught during testing either way. And if some OOT module 
> does something nasty, that's not our responsibility.
>
> BUG_ON is not a way to write assertions into the code.

So you'd rather create exploits than crashing on a fundamental API
violation?  That's exactly what the series is trying to fix.

