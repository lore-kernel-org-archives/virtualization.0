Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033038D006;
	Fri, 28 Aug 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937727; cv=none; b=rBXqnWb1U7Ujdhdx3wwdoEDNg4Pr7X8buLMlCNSZruq6l5gp6rw5Y395l7mPXZpJ7uGX+xrIeCSyHC8nggtVXNVDnwXcb/15v2RLBYwgfeCAwW1MSApZBjKuZqd6bj5YSPMDFjoAGdvsT6IkimA1vdggRp6Hgey16MdFSLLzays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937727; c=relaxed/simple;
	bh=SXnRl/WPEYz5LVyGEhE0mLc30G0QaGvTh6rXG5qM9GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlaT5L7ZY7aohqyb3DWa6qUCYRxzuYfUVdBHnqbn+KWohMuRgzr+aGlwlLGT+YtQGg5tht/kvWMgYPutbMqBsWCqf+XeR7tfA1H7hkmsM+nFdqCJwooBt5jyIVxCNRD8NHBtoHVWE1FqPV+RbBVkYYO7z7Cd84O2foDi+HWVeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GPDovQFr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GPDovQFr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VECtLxGkdYQVuUoAVC5EqpdeKshWxk0zDpBjDyHvFew=; b=GPDovQFrO97Y6XbC9dYzMHNVXV
	EiT+AlJgGvcLucxlDfqhk9XAfTQDKwxoFfvyYhmhY4ryaGwPraT94Q9oxBFrd0pfvjLCMDkQ5JPZb
	+52XxrL3NoZm3rlr9iomrFlkzu2ysb4NYQLi1qaJxxT0pdPcwnN5ryt/BTiZOInsFA1Y3rUJ3AHkk
	3Gwj6xNbS8W0h/O/lVuLzz9MzuijfLnSHMBXwQt3I1sgQKjmGxj6NwIbiciX8yCMlqxMTN1GDmK5d
	pTUQTScTmu7v+BFjGn6cJqBiSQsXlffLwZXfXT/qeT7a/KkQAPJkDK1+8ok85F2TAhUQ8R+IDCYK+
	76uUBf1w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x00H6-00Gvz1-23;
	Fri, 28 Aug 2026 17:21:56 +0000
Date: Fri, 28 Aug 2026 10:21:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Sungho Bae <baver.bae@gmail.com>, gregkh@linuxfoundation.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sungho Bae <baver.bae@lge.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] virtio_console: allocate the port_buffer with the
 caller's gfp
Message-ID: <apHDesMwQSebN3VS@gmail.com>
References: <20260810-serial-v1-1-abbe51602c13@debian.org>
 <CAMozUa9Z472cNXHwQNxsgp7wu3MsiL4kG77uoWocQdzC2L+n8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMozUa9Z472cNXHwQNxsgp7wu3MsiL4kG77uoWocQdzC2L+n8w@mail.gmail.com>
X-Debian-User: leitao

On Wed, Aug 19, 2026 at 08:36:25PM +0900, Sungho Bae wrote:
> >
> > put_chars() runs from the hvc console write path with preemption
> > disabled, so it asks alloc_buf() for GFP_ATOMIC. Only the data buffer
> > gets it: the struct port_buffer itself keeps the GFP_KERNEL default, so
> > the allocation can enter direct reclaim and sleep. A write to /dev/kmsg
> > on a CONFIG_DEBUG_ATOMIC_SLEEP kernel splats:
> >
> >   BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:320
> >   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: virtme-ng-init
> >   preempt_count: 1, expected: 0
> >   Preemption disabled at:
> >   [<ffffffff813fd90d>] vprintk_emit+0x17d/0x510
> >   Call Trace:
> >    <TASK>
> >    dump_stack_lvl+0x69/0xa0
> >    __might_resched+0x37a/0x4d0
> >    __kmalloc_cache_noprof+0x94/0x5f0
> >    put_chars+0x209/0x3e0
> >    hvc_console_print+0x234/0x640
> >    console_flush_all+0x4fc/0x950
> >    console_unlock+0xbf/0x1b0
> >    vprintk_emit+0x312/0x510
> >    devkmsg_emit+0xba/0x110
> >    devkmsg_write+0x21b/0x2e0
> >    vfs_write+0x4dc/0x9d0
> >    ksys_write+0x108/0x1e0
> >    do_syscall_64+0xfa/0x460
> >    </TASK>
> >
> > Pass gfp on to that allocation too.
> >
> > Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ownership")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Acked-by: Sungho Bae <baver.bae@lge.com>

Greg, are you the one that should pick this up?

The regression fixed here is now on Linus' tree.

Thanks
--breno
