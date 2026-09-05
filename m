Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADE24C06A
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788608354; cv=none; b=FPXLOT7ERQk2zRe3LnIby6qnvJcGoWhITyBu0tMBVyIYzM9sCUbKo3Naf4Wyd7iTOh6Ev737qF/o99LlTuEW+juyZoVkEuOe7GVhJPvqhiXu5qplpK9VCjY103hE5PkQSOyeDPRdV0h0jp9pRre82RMRJqHBE+5zjC4kGGaWMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788608354; c=relaxed/simple;
	bh=ms3bbQHL2H1xfalBGqYkOVN550DsV3bPTy1lW3PV8JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u347oO78lQenkpOSg6GNkVnYKeXKnV0rwBGIFoTGd9jH1DAFlFkpR+qN4gjJhztKfEtDB1q4s8GIqxxoe7waG18dGoeNlW8VYoPnY5DZuHNw+ZkXbZw7jhm6gl6I/7OBTapaqD8aHb2xhbfJPeYz1mLjtXiHMMxEr7cIChUCVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tZoUXair; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tZoUXair"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6B1F00A3D;
	Sat,  5 Sep 2026 11:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788608353;
	bh=2tlgomVy7BXdK+Ajg1QqoAxIyl6NUDXmFo48a5B71rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tZoUXairVRxm7y3O6w1Fvy4b5eqZL3w5S2OelXuqbFgsFnKMMZL+8hRm8gTXbvuyZ
	 Rl+aP1dFbGjokTHmKryOzTWG/t+J96kQOrnqkMhwozVllPnPt50eqQ5lBrMhqwh3ny
	 KsBrK/AzqxWZGgb/TG5LL8YTqc6TSws0mvZ9Zagc=
Date: Sat, 5 Sep 2026 13:37:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Westphal <fw@strlen.de>
Cc: Geliang Tang <geliang@kernel.org>, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	virtualization@lists.linux.dev, Sungho Bae <baver.bae@lge.com>
Subject: Re: [PATCH] virtio_console: pass gfp flag through in alloc_buf()
Message-ID: <2026090555-abstract-unshipped-385b@gregkh>
References: <e084d7ed4c03020da3de5cbe1eb3a0c2055cbbd6.1787966331.git.tanggeliang@kylinos.cn>
 <apts2h6pyF1ePHBW@strlen.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apts2h6pyF1ePHBW@strlen.de>

On Sat, Sep 05, 2026 at 03:14:17AM +0200, Florian Westphal wrote:
> Geliang Tang <geliang@kernel.org> wrote:
> 
> [ CC Sungho Bae ]
> 
> Ping, I still get this splat on mainline, this patch fixes things for
> me, so
> 
> Tested-by: Florian Westphal <fw@strlen.de>
> 
> Could someone push this to Linus please (if not yet queued up)?
> 
> Thanks.
> 
> > put_chars() correctly passes GFP_ATOMIC, but alloc_buf() silently
> > discards it and allocates with GFP_KERNEL, which may sleep.
> > 
> > Pass the caller-supplied gfp flag through to kmalloc_flex() so
> > that atomic callers get atomic allocations.
> > 
> > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> 
> 
> Hmm, probably:
> 
> Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ownership")
> 
> ... as that adds "gfp_t gfp", but doesn't fix up kmalloc_flex() which
> has GFP_KERNEL as a hidden argument via macro expansion.

Sorry, this is on me, I've been swamped, will try to get this to him
"soon".

greg k-h
