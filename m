Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E6383A9
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828330; cv=none; b=VtiDCj75Evfd7EXgG+9PKzGq22HpxZRmyhDvWdOqAVsXFbK4fARQVvO3dhOvcnOS/qnEnLXRRCOzXissCL+VI7FRWnQZ0TwAjCIAcblNlOikicQ6GxKwMf6WnuNqQz/ojH1epiIjqg1cB2nIlairGG7WFmDZtf7aV1MSyC3On+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828330; c=relaxed/simple;
	bh=0v+CVxTYq3Gbd5r+G9NTqFSG5V3tl4pVOXjBLir2xY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTW1KQBavDjBlqesjyuiO1kKySmdvV58Jwj1gAU6pvYy9ZPtgN3kvd9D+zzA9T1RKuz+oZIrSZQ8EpJOLUT/XUMAErXyjXPR1djeRgjmFxaRm82t5xJfdt4JP+3FMuHgVGhxzJD7AYyA9UnhhlDYuryn3fbCNMwMEwwkbyg9LyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EN/3Ds8z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EN/3Ds8z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b/KEzmx1aMMGRJQpHAjdbVT5z73BzbBw+LIwhc43mRI=; b=EN/3Ds8zwhG6he2rQH2e04Bkq+
	iUsMRkJH6sJWwWivU8LahkjYMU2RLUSIK5dSQJ1101Gcm4Cx9YuG6WTC/hgMg/0h1ydvh1DFB8FVq
	Ra5gjh9mhRQkTHVUNfZe6s/a2ggnwGB5LjNE48sXGyB8dODsMy5Y2JuPhays+uhf/nWuLJQf9n2Hw
	pAvCj+5xp9PqBBGGIIX+0joALiSxukDavmiHMCx83N3TIcjTXdjqveaJAd5RN9TYpMMpCvrOzZaD8
	QTUWA3xWkfqjbVuq7/MdQkv2M5jUCt0PgtshZA1Mx4pq7kGb/al8Xv7Z1+P4V68IwtE21qNfm7xtO
	kuuIHyOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWcCX-0000000FTDi-29nF;
	Wed, 24 Jul 2024 13:38:41 +0000
Date: Wed, 24 Jul 2024 06:38:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@infradead.org>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqED4bEIJGGHxsHY@infradead.org>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org>
 <ZqECPiU-3fJozzpB@tiehlicka>
 <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 03:33:19PM +0200, Vlastimil Babka wrote:
> > I do not see this a problem. There is no real reason to have a NOWAIT
> > allocation down the stack that has a different fallback strategy.
> > I am not saying that this is the current practice because I do not know
> > that but I am saying that this is not impossible to imagine and it makes
> > scoped NOFAIL context subtle and error prone.
> 
> I don't think Christoph proposed scoped NOFAIL, just use scoped NOFS/NOIO
> together with GFP_KERNEL_NOFAIL intead of introducing GFP_NOFS_NOFAIL.

Yes, exactly.

And I didn't think Michal thought I meant something different, maybe
that's why it felt really confusing.
