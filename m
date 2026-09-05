Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0D2326945
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570862; cv=none; b=UGOdujn7L1EDvsGHOS1PoSnXegdXUUB9hQephM+vtLdrU7yD5S7xZsbYBWB6vyPHOA5Tj3gS0rqMogMGIP99f9WV6wdBF9qptvQpZHAejq7GB8euA1gRXeJ43c9QrO1qFFTXm6v+8aSvBVC0exwoJCA53fHCk41BfvGcTkme84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570862; c=relaxed/simple;
	bh=QPVT+o/C1zYT5EQjFtZ/FZMzcRZw8sXAfNgg1KYJXyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6pMYaPhb4Mgl/FtiKbZi1pr5n4RJXD4sVUlepWIifxwj5Vb7ix9cwz2/VDVExuV1xz/KpXCNfFisHu5wKREkEdJz1okQ79577zdwG20/vvm2ziNqnLOAzV/1m912hUSfAJgzrOu4Lelvurw7SmLxlqp7zwM2vfhPj25MRNZV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CFA2A60338; Sat, 05 Sep 2026 03:14:17 +0200 (CEST)
Date: Sat, 5 Sep 2026 03:14:17 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
	virtualization@lists.linux.dev, Sungho Bae <baver.bae@lge.com>
Subject: Re: [PATCH] virtio_console: pass gfp flag through in alloc_buf()
Message-ID: <apts2h6pyF1ePHBW@strlen.de>
References: <e084d7ed4c03020da3de5cbe1eb3a0c2055cbbd6.1787966331.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e084d7ed4c03020da3de5cbe1eb3a0c2055cbbd6.1787966331.git.tanggeliang@kylinos.cn>

Geliang Tang <geliang@kernel.org> wrote:

[ CC Sungho Bae ]

Ping, I still get this splat on mainline, this patch fixes things for
me, so

Tested-by: Florian Westphal <fw@strlen.de>

Could someone push this to Linus please (if not yet queued up)?

Thanks.

> put_chars() correctly passes GFP_ATOMIC, but alloc_buf() silently
> discards it and allocates with GFP_KERNEL, which may sleep.
> 
> Pass the caller-supplied gfp flag through to kmalloc_flex() so
> that atomic callers get atomic allocations.
> 
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")


Hmm, probably:

Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ownership")

... as that adds "gfp_t gfp", but doesn't fix up kmalloc_flex() which
has GFP_KERNEL as a hidden argument via macro expansion.
