Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057D3BF68D;
	Tue, 18 Aug 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044010; cv=none; b=hGun8S2n2mBCsZ8MF81xqE9BNbFz7yyoE5hXv5zaSJPRNzZ9GiFllB6EEg/56G+Aq7FHHofr2M5uSpjY+leeFvBQ+tQlH7Qjrp/fYvBu1VQrz179vUz+tL8drmU8Oi+eRxS08tUgROiInmQWqCI1NwK85Mv1IDAPG7HPZmHdUiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044010; c=relaxed/simple;
	bh=eGOP+bOYShoK++60xGq1ZAj3aVrm1jJKQ3EwOsIsl2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBgK1oPCzOSukWP62Yr1rLZBDKqr1DDFZsIUFCkf7hkN1MkeWn/qD64+jyzLo0iz1Wk/lw1R7E4lJvSWYknFOclpLrWSvUeeSBU3BB86ixz3G/OIXTjP4QVksY4RRHL2WWV93bkSUmlo0+ieyUE9r1FzWBeGJit3PyZFJwqSHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UKWLa/u4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UKWLa/u4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YyeaFwovL8SdoJRBPLeKKg71tL0z+AZtCEo0gPl6Rps=; b=UKWLa/u4SfJFFAsBAeM3zippxf
	ZdD8qBy01GDCFuMq7tn9ef9XKgXqHXPKdvdKpdYOc5qLhiVy02kWYH/fu59RZEHUy+fa76IJVfX7Z
	P6r8kjs18iWKYDP73zqVKxbcqgZlFMzMf1QKn9jADmUoA1aHyG1wj3Hm6UogTJDq6FckWujH5DqbK
	qC2qcdifG+Kko+HTxDw6jfuNYfHwOQQdzvF+9FW1jMCY7p7RpK0lmDrLp3X1gSAx0aBaxFg3A6T0n
	5mg8RpE4E9frGbf10VN/FP/JdBztLXr76g4DUyWWgI/2+YNZ15dzbobAfmxpMKTJ0tCGT+s+4ZjLf
	rOhd3d9A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwFmM-008ttu-00;
	Tue, 18 Aug 2026 09:06:42 +0000
Date: Tue, 18 Aug 2026 02:06:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sungho Bae <baver.bae@lge.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH] virtio_console: allocate the port_buffer with the
 caller's gfp
Message-ID: <aoQggUaBZC9GeY1Y@gmail.com>
References: <20260810-serial-v1-1-abbe51602c13@debian.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-serial-v1-1-abbe51602c13@debian.org>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 09:40:00AM -0700, Breno Leitao wrote:
> put_chars() runs from the hvc console write path with preemption
> disabled, so it asks alloc_buf() for GFP_ATOMIC. Only the data buffer
> gets it: the struct port_buffer itself keeps the GFP_KERNEL default, so
> the allocation can enter direct reclaim and sleep. A write to /dev/kmsg
> on a CONFIG_DEBUG_ATOMIC_SLEEP kernel splats:
> 
>   BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:320
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: virtme-ng-init
>   preempt_count: 1, expected: 0
>   Preemption disabled at:
>   [<ffffffff813fd90d>] vprintk_emit+0x17d/0x510
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x69/0xa0
>    __might_resched+0x37a/0x4d0
>    __kmalloc_cache_noprof+0x94/0x5f0
>    put_chars+0x209/0x3e0
>    hvc_console_print+0x234/0x640
>    console_flush_all+0x4fc/0x950
>    console_unlock+0xbf/0x1b0
>    vprintk_emit+0x312/0x510
>    devkmsg_emit+0xba/0x110
>    devkmsg_write+0x21b/0x2e0
>    vfs_write+0x4dc/0x9d0
>    ksys_write+0x108/0x1e0
>    do_syscall_64+0xfa/0x460
>    </TASK>
> 
> Pass gfp on to that allocation too.
> 
> Fixes: fc220d6be3c7 ("virtio_console: refactor __send_to_port() buffer ownership")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Ping? 
