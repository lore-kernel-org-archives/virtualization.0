Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C61799F
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443288; cv=none; b=Z+dXGfeaPmajBd0cTVm/CgLe5GBQzPXG+FoqBPxzVYCez3Y/M6F3a1eUSBlmG4unW7FRi9whOj1IsXhRfHuLYgSFHiiFheWaXfiA/FoqFvce+PV23CgCKcOwTyaEtQC/vkZE/36fsdScBoubm+uVV9lUmKnRwH75W/mzHXVWP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443288; c=relaxed/simple;
	bh=1uGuqEawwEetuwfOwGQoCBPgW8K2cDlsXtq4mKXKcY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5dCwKi7yOFybT55iNN+1hsiHWxlqXvRTt+JyCwxDjifwy4WqvtUMFTow1eo5SIM+Ae/2EFdPT3IrfabwRDfGWi3axEl5S5YKIlY6BKEql9STP6u1Si7yF+8fBJ+G9U+0STSHjMnfWFIj/g8Ohxm4tkHzn66+J6eVciO02JTSP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x1Damflr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x1Damflr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1uGuqEawwEetuwfOwGQoCBPgW8K2cDlsXtq4mKXKcY0=; b=x1DamflrGRW3k2ykLLgcwhkAY+
	/1l2xYG2wV/woCpd+mq9p/nbniTEIhjWGywWPb02aWdZBcryMvZO1nxoYr0SUUVN0BNfgs2dN1rpM
	zMIBEOPcw1QXc8F/Bllh7R+jQE+J8qypm0XLXngg+089NkzGGbOsdmoQhYSrkfqj7n8bLUG34Sau3
	tNAFLzTgTLR/7o8SWlXDmqdB/3V0swERgmRj3IuQIkGAjon8SoCpUsjQszyJlfTKEhjboJrC8S1Qo
	8VNWebMotFYEtikK8skp+0tjMQuXqqBq2meTmcwT/885Fs2gB0tMpAr2ekWDw233geUmKF2BUgddR
	WOYQ7d8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZCBF-00000001rlM-2FiH;
	Wed, 31 Jul 2024 16:28:01 +0000
Date: Wed, 31 Jul 2024 09:28:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, mhocko@suse.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/4] mm: BUG_ON to avoid NULL deference while
 __GFP_NOFAIL fails
Message-ID: <ZqpmEcMyyihv8OMO@infradead.org>
References: <20240731000155.109583-1-21cnbao@gmail.com>
 <20240731000155.109583-4-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731000155.109583-4-21cnbao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good (inline or not):

Reviewed-by: Christoph Hellwig <hch@lst.de>

