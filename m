Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047D158A01
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827415; cv=none; b=fFzG66kaekfzpVJzHdZo/dTGgBrvyR5ytL4dW/6z3nI4ea8lSBSMcmXgulBAP6ZMEBROrbpKskiUUvP9qWwkg8LxDrjtA0+rr2kLt63GQSiby0FtDEHTta4Rj6cI+5UvmKPjZsP9Nc0HX2ohBMMPrCr/ma25/cWgRQccWuxx14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827415; c=relaxed/simple;
	bh=kJmSUyWHhaALt3X8CM3M5BPxurv+/4DKWnjHf/hw45Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCONsJPAoEAqxBQ4VJh+iEU4f41JVwNSZEqYONcyaSoeiXeWGeDRhvuWZpMqANOWyQoYz5EEcTlR3wpVPdq9smOueiI9jIE99rtKcgqIHhYS0YOjVojm/J/vC0BJyKxvqgmOAoVFd5iDQTBq8X2nBssFVpAsL/tVnY3jd60x6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T6EKofbh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6EKofbh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aGDmrf70xonv6Qm91bhRo10OdhYvaEykAIZYXVPLJ8w=; b=T6EKofbhHAV0bXikVRXIvzascT
	JLhhFq6JmRbVL4FEZWPnF3KmN9egpn/MLIznUPvYW0FPL45+dnJ7bP65/vjNKq8bKvoiQShdEklKO
	4o9F37RzB9UXMEBMJpRgEoXBDgOL7aFOhY6XITr6GOZmQ/r55u15i6Y07FAbJ3b6P+ng6ev99fSTm
	IsojksZSOczxUCn5ZCVkPSYIUuujhd2VTfXCE6ns7od/dNBgCECWR1OdXp8zhkTZCv0Ymo+kyZcyN
	NYCuBVGzywsHFEIFOjOXpy26okIsTUJr6a1gT8nSiJUEBC4mSUtgQStNoLff3LWu35p4xMmt6dxTT
	sApTpSbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWbxp-0000000FQlv-0NY5;
	Wed, 24 Jul 2024 13:23:29 +0000
Date: Wed, 24 Jul 2024 06:23:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
	Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	iamjoonsoo.kim@lge.com, lstoakes@gmail.com, penberg@kernel.org,
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
	v-songbaohua@oppo.com, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqEAUbtkIMCwVpgB@infradead.org>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
 <68ee812b-3b96-4c8b-9a54-70d4742488bb@suse.cz>
 <ZqD9-yzGxQIFlxGQ@infradead.org>
 <ZqD_ydjhUI_GCgSg@tiehlicka>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqD_ydjhUI_GCgSg@tiehlicka>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 24, 2024 at 03:21:13PM +0200, Michal Hocko wrote:
> Scope API is tricky here. Exactly because the scope itself could have
> opportunistic GFP_NOWAIT allocations.

Really, where?  That just sounds f**cked up as callers using any kind
of nofail API can be broken by a caller higher in the stack.

And that's totally independ of adding a NOFS/NOIO helper, so it'll need
to be fixed.

Adding more NOFS/NOIO wrappers while we're trying to kill the flag just
is not helpful going forward.

