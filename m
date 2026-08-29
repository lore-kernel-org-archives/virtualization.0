Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C241C72;
	Sat, 29 Aug 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984095; cv=none; b=PZJHvSAnVKM485kH27AvkqXEXKaejkgC+LXZfgSCYwni9HF37l2fUwswBcHo/p1S+4OYS2xtD+qlb7jnJmwwge1kvyilIDcR0YAAAeFcSr2IvWU/TWNYUoPjU1kAbFy9mdw7gC861yb6/6PbV5wqLFzcSAyzYm7QCHGdSPUzpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984095; c=relaxed/simple;
	bh=5p7oz9+y1/I/OjCHrsSLFHZsn4rgyi136hYVU2LnHX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCxCZq5W9hs9uSxbmJ5np303+y/o7CspCCWR0hjLWYMjeJ7VJHBwvDnRiKlGiI7ZKJDm7H+Aur2jCgjaUC+c+dbcNuGXUNXzQ1WCGsPLaBVJAU/pXAqEnTbnhCcGlahlaTLFpG5pBCIot0L4g0zsgrIhqtKhqxm3Et/wjclemFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+U/5qwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+U/5qwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375F91F000E9;
	Sat, 29 Aug 2026 06:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787984093;
	bh=AitE20c6FqFVkyobnvqCiZrcfwyStShQ7Xqfhzj3WWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+U/5qwamfaLJlZsmkryhcuSd3f7+xSn6aO2zLgn5m7wTvr6VqfjfskJ6ABHSX2Rn
	 RxCgBPXEHYZeMDkSGbQgiZT1JcNuHLQNsCIPWAT/nLY6O0Aldx1RWscLvx28tqHZmb
	 otTQuZKSXf/HpiadmoGA60fbtfcRPEgGqo6Bw+gY=
Date: Sat, 29 Aug 2026 08:13:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Sungho Bae <baver.bae@gmail.com>, Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Sungho Bae <baver.bae@lge.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] virtio_console: allocate the port_buffer with the
 caller's gfp
Message-ID: <2026082953-gizmo-subsidy-5296@gregkh>
References: <20260810-serial-v1-1-abbe51602c13@debian.org>
 <CAMozUa9Z472cNXHwQNxsgp7wu3MsiL4kG77uoWocQdzC2L+n8w@mail.gmail.com>
 <apHDesMwQSebN3VS@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apHDesMwQSebN3VS@gmail.com>

On Fri, Aug 28, 2026 at 10:21:50AM -0700, Breno Leitao wrote:
> On Wed, Aug 19, 2026 at 08:36:25PM +0900, Sungho Bae wrote:
> > >
> > > put_chars() runs from the hvc console write path with preemption
> > > disabled, so it asks alloc_buf() for GFP_ATOMIC. Only the data buffer
> > > gets it: the struct port_buffer itself keeps the GFP_KERNEL default, so
> > > the allocation can enter direct reclaim and sleep. A write to /dev/kmsg
> > > on a CONFIG_DEBUG_ATOMIC_SLEEP kernel splats:
> > >
> > >   BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:320
> > >   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: virtme-ng-init
> > >   preempt_count: 1, expected: 0
> > >   Preemption disabled at:
> > >   [<ffffffff813fd90d>] vprintk_emit+0x17d/0x510
> > >   Call Trace:
> > >    <TASK>
> > >    dump_stack_lvl+0x69/0xa0
> > >    __might_resched+0x37a/0x4d0
> > >    __kmalloc_cache_noprof+0x94/0x5f0
> > >    put_chars+0x209/0x3e0
> > >    hvc_console_print+0x234/0x640
> > >    console_flush_all+0x4fc/0x950
> > >    console_unlock+0xbf/0x1b0
> > >    vprintk_emit+0x312/0x510
> > >    devkmsg_emit+0xba/0x110
> > >    devkmsg_write+0x21b/0x2e0
> > >    vfs_write+0x4dc/0x9d0
> > >    ksys_write+0x108/0x1e0
> > >    do_syscall_64+0xfa/0x460
> > >    </TASK>
> > >
> > > Pass gfp on to that allocation too.
> > >
> > > Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ownership")
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > Acked-by: Sungho Bae <baver.bae@lge.com>
> 
> Greg, are you the one that should pick this up?
> 
> The regression fixed here is now on Linus' tree.

I can, after -rc1 is out, sorry.

greg k-h
