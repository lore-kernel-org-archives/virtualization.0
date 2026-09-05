Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AD2931E5
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629636; cv=none; b=Pk7My8v191i683qPL69g47fsuj/qmx4UHbpUmx5NJkBW+rF0AJ9DI94COvv9uL2y/IDornpngvmmYwj20OBJaG16Opl2wUkeZBHy+31BfP+kF6g8LrGHMd3Pr0joFQa9Nyald4oRc0gPo7oIyK3qJra6MSj0zFgQm44KtoBfVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629636; c=relaxed/simple;
	bh=QsyyRp9qZ9JfhjFRadP/3MTeQ/TUQv1Z7ZWMFWPVMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQkOfk64oiYdsuO/+Cgi3NFW1jR6xmTcrTQTYc44kKDHcsB23jzSUOeIaqOY+6Bdo1GTUwUZTg6vaOoiA/2FmiLvWd1vyeQtIM8A7DYwzvIO1wAC5T1luPsZGMIeGM36Lbs90aUwdLfj8MmP9cwofoakJlWehEHys+J2VLX1TWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4uD6SXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4uD6SXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B1A1F00A3A;
	Sat,  5 Sep 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788629634;
	bh=/n8dkButbmElXT8d/b95l/TgsFhXtmajeIVAGWhoLls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4uD6SXSgB4WV1z0mjOjU3BH8R53bxSS/46oiRiRw977YLZX0C9yrfpjLsUUlgpr4
	 F1CV2StNz8vwzaCRy2Lu3363uuy06ocVenEDxLamB04cS0Ba8IEh8PlSNVs2vXscQr
	 XdUCbWIrzs3SpO8C+oK0uyjLci5rmN5Ns5tFR9so=
Date: Sat, 5 Sep 2026 19:32:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_console: pass gfp flag through in alloc_buf()
Message-ID: <2026090559-wavy-chase-7b71@gregkh>
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

On Sat, Aug 29, 2026 at 09:20:39AM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The `gfp` parameter of alloc_buf() has been dead code since the
> function was introduced. The underlying allocation was always
> hardcoded to GFP_KERNEL - first via kmalloc(..., GFP_KERNEL), then
> via kmalloc_flex(*buf, sg, pages, GFP_KERNEL), and most recently
> via kmalloc_flex(*buf, sg, pages) which defaults to GFP_KERNEL.
> 
> This causes a "sleeping function called from invalid context" BUG
> when the hvc console flush path calls put_chars() with IRQs
> disabled:
> 
>   BUG: sleeping function called from invalid context at \
>        include/linux/sched/mm.h:322
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 416, \
> 	       name: test_progs
>   ...
>   Call Trace:
>    __kmalloc_noprof+0x468/0x7c0
>    alloc_buf.isra.0+0x42/0x260
>    put_chars+0x1e5/0x2f0
>    hvc_console_print+0x29d/0x6e0
>    console_emit_next_record+0x21d/0x480
>    console_flush_one_record+0x431/0x6a0
>    console_unlock+0xda/0x1c0
>    vprintk_emit+0x300/0x350
> 
> put_chars() correctly passes GFP_ATOMIC, but alloc_buf() silently
> discards it and allocates with GFP_KERNEL, which may sleep.
> 
> Pass the caller-supplied gfp flag through to kmalloc_flex() so
> that atomic callers get atomic allocations.
> 
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Sorry for the delay, I took this earlier patch instead:
	https://lore.kernel.org/r/20260810-serial-v1-1-abbe51602c13@debian.org

