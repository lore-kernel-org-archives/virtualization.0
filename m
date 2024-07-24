Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50625155A24
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826851; cv=none; b=AeXuwf0YSkXCPrID1vhoCevYjT0w2ex9xAtXNmVPr2xwNcEnFJAc6MbiuejQdYLXgPAUhojtZSIqAeCzR0oz7nGeBNU/eSmMSCvuXIf2tJyzyopLWX3qv9amBE3bIX4V+ddmRnA2xqNgV+7heftBRyJ08Ii9H9NZmqCMEJvyI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826851; c=relaxed/simple;
	bh=oK5PXIOM0Rqv+EulZDkoG3XkpD4ZMr++ktm3w8QnPlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQPBlK6G95lRKIfJSWRSIMT/mKgVnz58CrsLFygpGta5Tirsn3Tmpb3VpNmwdMtdx/5ZNeoSWUoFnWm5bJFimC/MnNirWRy+HjjYYmaapmtgFbBw3KnM3H0bzN0qREAOqAXH6R1Oo38ypFfFu5bKRCcbeU/TxCKOpN+R0RMjCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2nEXqn+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2nEXqn+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QYUAYKNVGiDZfrUKcYDM3BEMBDYiIsZnK62rgUn/E9Y=; b=E2nEXqn+bj0uv4LnxnwABC1Ta8
	rJr2cVqK365oEXMhbVAs3b/64DmZ7Wp0SOqefL7ZCKS+PTcKRmM2r3hbNE8QAyrcS7Xsc160THB/O
	QYmVP8kM1bM2aGuhOFWw4WTi7Y91YlrhHjw77tEsZCSaPANFUUKOPyZFKsf5vp5peLmacTSKGA0C3
	bfLHnaKAzp38B+3FF1fvQLZza037VQdddlh69v1k2ptcBk339tu8I1vzb1Ws596c7tvP/+Z7n6mWF
	HcCelRUsPPGoQFWGI+RlD/ZmKQG5f8rMvDHph1ZwhG7p1ykWDJWxw/RiLAw5zSCPGw1pKyBV/sJuC
	CM3fn/EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWboi-0000000FPe5-3NvU;
	Wed, 24 Jul 2024 13:14:04 +0000
Date: Wed, 24 Jul 2024 06:14:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hch@infradead.org, iamjoonsoo.kim@lge.com, lstoakes@gmail.com,
	mhocko@suse.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev, hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqD-HGwkp0HkJFqH@infradead.org>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <CAGsJ_4ywzECk0tE+HUHO-Em75hZ1gsDtbh9aN_XnYoJjecHRrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ywzECk0tE+HUHO-Em75hZ1gsDtbh9aN_XnYoJjecHRrg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 09:58:36PM +1200, Barry Song wrote:
> This is true, but I assume this won't incur overhead at runtime since the
> compiler resolves GFP_KERNEL | GFP_NOFAIL at compile-time.
> Only readers might find some bits are duplicated OR twice?

It's not really the overhead.  Having a single main flag make it very
easy to grep for and find abuses.

