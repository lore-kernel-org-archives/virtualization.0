Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BB4D2ED4;
	Sat,  5 Sep 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629623; cv=none; b=oZagcbVCz500Y7FmnJWC8LTorEtGOFZp3xwIfFLDk5nHuHEYSuq9wLM9movbc0Mqn4CNoBqZkRLwIzpPKfQHoLe91uGDgFBEsBa0PNipB6EXPgn9sQGOJnU5DuuoeI6xwZyvwYCxOkK6UX75xbr3YS2ksLH4POD2H7WU/dOjWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629623; c=relaxed/simple;
	bh=RNRXIX9FpEZrjpisVdSs9aeiozRGAA+gvWV7xy8XHPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuokS989Mop5vFLYkDX8TjxkSML9oW0Ux84WbrjtgDkxcuz/YPWdouZgD7KGh88v6hJbciLgS6EBcMD6AHa4uY3Z2KiNLIMmDxedcBG5AHP8VNoOoVEG9vWn0GZaHfqOC+I5WOJOeMBf9x/kee08gWpJNrchkdRIvBMPznph0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=puXY8OSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="puXY8OSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8D41F00A3A;
	Sat,  5 Sep 2026 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788629621;
	bh=Fx8PK7Xfj/j2ZGtYledhEA7oMw4OIGw0ZlkfNZ2ElJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=puXY8OSOt//tFUAZBgEoU/R7pSPidOf4XlAE4UqbNeR9vAl5gZYwO3F3Q2+un1amB
	 Z/mGbMoLHgzel6+FzUyavLCh5s1pdhsIME5HhoC43BvsTRrA4qim6Pbjmkq9sbjfBM
	 FkfK4Di3JZySLDt+ul5peZABin2ISXpjfMHzXDAU=
Date: Sat, 5 Sep 2026 19:31:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, Sungho Bae <baver.bae@lge.com>
Subject: Re: [PATCH] virtio_console: Fix alloc_buf(.gfp) usage
Message-ID: <2026090538-crease-uncross-6227@gregkh>
References: <20260828153706.GR687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828153706.GR687043@noisy.programming.kicks-ass.net>

On Fri, Aug 28, 2026 at 05:37:06PM +0200, Peter Zijlstra wrote:
> 
> Commit fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer
> ownership") added a .gfp argument to alloc_buf(), but forgot to convert
> all allocation calls.
> 
> The result is that any GFP_ATOMIC calls, such as those from:
> 
>   hvc_console_print()
>     put_chars()
>       alloc_buf(.gfp = GFP_ATOMIC)
> 
> will trip the might_sleep_if() check when used from an atomic context.
> 
> Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> 

Sorry for the delay, I took this earlier patch instead:
	https://lore.kernel.org/r/20260810-serial-v1-1-abbe51602c13@debian.org
