Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93215AD83
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832103; cv=none; b=sbVmQ4hI7D3/85zwRfQKHU+HgWCPaa2I09RKv6uDEn6a1QPV982GFazNMhymHvjxZUPMJCNO0U9SM07DnYq2iNqaWKpLlUeb6U+T0egk7u8PTi58VGmR5uLl8sgz7ZpZle00msyXodL7hQ3V+/6K0Hf9pu/IRcep+elxcl4MQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832103; c=relaxed/simple;
	bh=NGup4d420CVuQK0YfcZV/QTTJ5BDVZMKk9C05yJC+zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8E5bRbI1tjHm1rynLBeCONQA3i3+MKWsg++hDtGmrZeUZLlEmdkG0WcxyMde5HdluLZ17xZjwbrwEdfs4T8p+jRcvpcSe+KP8SZCdEu5PFMjqBVeXjc0sPmeLppoL48glQRaBXWP4zWXJBtTGXTQq4RdXSAYyEXy5a5Rus+XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sSBynAQ6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSBynAQ6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=crMY3yh38upJJIZqKdBkz6jKnqXn28NamV7YqV6NS/s=; b=sSBynAQ6F/fAVILYBCQxEtrV71
	xyRh2ORRd1ET7ZmGKxrbXDit7f1kvTuE6C+cxh1/fQ+bofqsJhw+Lg5g1CrseBjYE2J3t44khsTA7
	F5VuHRiK6juMHBXxEdoJy436ZR+VYpWfs50F1QouiyW5RnkJeDbsCl7svnuNpbQm2nPshc9+rpr3u
	kJBAp/1S/nweLxOkcONJER8/Vc+xnEka6UndCWBZU1X1/x6RK0nj9CMkIUklwg7yhkmUJXl0xDvQd
	j0gmgu/ZvGw+PDQMzDGv4zC/x+wB/dxTTFQngp9Jiqw+r+WyNVWAfX0omPL2xXvJbO0mw0+cCiPUW
	hvMgAujQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWdBP-0000000Fdci-3Hfd;
	Wed, 24 Jul 2024 14:41:35 +0000
Date: Wed, 24 Jul 2024 07:41:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqESn11SG7fU4cG-@infradead.org>
References: <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka>
 <ZqEAUbtkIMCwVpgB@infradead.org>
 <ZqECPiU-3fJozzpB@tiehlicka>
 <400b2f6f-f7f0-4888-99ee-7327faad7e5c@suse.cz>
 <ZqED4bEIJGGHxsHY@infradead.org>
 <ZqEGAh6R7yoR5L1n@tiehlicka>
 <ZqEHuaUGuuUaL_AY@infradead.org>
 <5b9fa06a-bcef-447c-899b-fe3fb10315bf@suse.cz>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b9fa06a-bcef-447c-899b-fe3fb10315bf@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 04:39:11PM +0200, Vlastimil Babka wrote:
> On 7/24/24 3:55 PM, Christoph Hellwig wrote:
> > On Wed, Jul 24, 2024 at 03:47:46PM +0200, Michal Hocko wrote:
> >> OK, now it makes more sense ;) I have absolutely no objections to
> >> prefering scoped NO{FS,IO} interfaces of course. And that would indeed
> >> eliminate a need for defining GFP_NO{FS,IO}_NOFAIL alternatives.
> > 
> > Yes.  My proposal would be:
> > 
> > GFP_NOFAIL without any modifiers it the only valid nofail API.
> 
> Where GFP_NOFAIL is GFP_KERNEL | __GFP_NOFAIL (and not the more limited one
> as defined in patch 4/5).

Yes.

> > File systems / drivers can combine іt with the scoped nofs/noio if
> > needed.
> 
> Sounds good, how quickly we can convert existing __GFP_NOFAIL users remains
> to be seen...

I took a quick look at the file system ones and they look pretty easy.  I
think it would be good to a quick scriped run for everything that does
GFP_KERNEL | __GFP_NOFAIL right now, and then spend a little time on
the rest.
