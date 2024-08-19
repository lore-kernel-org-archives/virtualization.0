Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBEF16B3AC
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072033; cv=none; b=nYbOrbJJ0MZcu/nkijfRSgYPDkonqWb8wZfD4Nqdc5jd1CK1QWC6aEvdNTGECFiU/PFbgHuCDxs6SWHVs01PgiPlJweaa28WpL7DOjXd8hzt4gG+hvPABmPLignB8tF9ARHBFW5saal3H0gnuArSXZysTNGeSj9dw6YZLj+QweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072033; c=relaxed/simple;
	bh=w9B9axIp81BRxihD33bjM9QSzzbUkpo2hvdZHKXtVIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0d35HbSwrNAcNn7fWU0vBVJ5E5GXJgSMZ91qgxD/0E4023+yeqEAGJqzPYUhJdDYT6sLWL4yxKwhWbmEOTnBNCyaGr0uEUugs58ntyGXg2emz/JTNUpRcbqBXGy4cLKzHyVX3khhzafFzhg20Wuyvzu2mdhKJqVdG79deyRej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF34D68BFE; Mon, 19 Aug 2024 14:53:46 +0200 (CEST)
Date: Mon, 19 Aug 2024 14:53:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, mhocko@suse.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <20240819125346.GA7992@lst.de>
References: <20240817062449.21164-1-21cnbao@gmail.com> <20240817062449.21164-4-21cnbao@gmail.com> <5654b71c-1d9d-4c48-b28b-664662da8897@redhat.com> <CAGsJ_4xF0YVS4TiaJwQ=YDeTTXg7hhNJOxzTYWy1cwu1YmLd5Q@mail.gmail.com> <416ac265-ced2-4f90-a347-0a256edf7fdf@redhat.com> <CAGsJ_4xNmi9nuZaLVjWgBA4cVqyDYVupQ1Hzygbnq98OiP9p8g@mail.gmail.com> <54a4619d-e826-465e-9a0f-0a8f37798e15@redhat.com> <20240819124924.GA7642@lst.de> <a31af580-f420-4b34-8945-0269914a901b@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31af580-f420-4b34-8945-0269914a901b@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 19, 2024 at 02:51:06PM +0200, David Hildenbrand wrote:
> On 19.08.24 14:49, Christoph Hellwig wrote:
>> On Mon, Aug 19, 2024 at 02:33:06PM +0200, David Hildenbrand wrote:
>>> It should all be caught during testing either way. And if some OOT module
>>> does something nasty, that's not our responsibility.
>>>
>>> BUG_ON is not a way to write assertions into the code.
>>
>> So you'd rather create exploits than crashing on a fundamental API
>> violation?  That's exactly what the series is trying to fix.
>
> I'd rather have a sane API that doesn't even allow this level of 
> flexibility with NOFAIL.
>
> But probably I'm missing more details here why this all has to be so 
> complicated ;)

Well, the only way to do that is to remove (__)GFP_NOFAIL and require
either explicit _nofail variants without a way to pass gfp flags, or
endless loops in the callers.  I suggested the first one earlier, but
no one liked it due to the API complexity and overhead.  And I've not
heard anyone arguing for the latter yet.

One other way might be a compile time check that requires any GPF
flag that contains (__)GFP_NOFAIL to be a compile time constants.
This is true for many but not all callers currently.

