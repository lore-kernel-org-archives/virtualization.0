Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A62FB62C
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786113; cv=none; b=lqhlCx4KqMLCBCgiy2frDsmvm6geqa+hgu5AM8P/tKc9nuH5Fe1FT/C0UR31Gwx5cLRssngQ9zkkT5hhJWaXa2AGY/P2eT8nzlIdcKBhyVB8sTWJhgNknT92jbR/7tG94Fm3/ZnuUyz8uV/czZ8qqc2G06ZzthBaCK5DzZ+Sm1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786113; c=relaxed/simple;
	bh=IGSVEUhw3KS9OViN0YA5llbQX0U0Ew/Koagt/GO9fAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGxH4BseFp7DaSbZokSNxArSsDIGHEQW5QGJxKWMO4vka/LiF4sJE6lngU7GGRixYywURJw+3KTDCiZdkmr/by2UFM0CuX9SkHe/Z0vj9D0sdvgoooFsPhWF/jL+GNX9uL4MskZngSCv+2KsujBuFCHO/O3eQCiqqTaRiUkZjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=0QvVRV21; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="0QvVRV21"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8CD9320890;
	Thu, 21 Aug 2025 16:21:43 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O0v0MIfmKoIl; Thu, 21 Aug 2025 16:21:43 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 03F662088E;
	Thu, 21 Aug 2025 16:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 03F662088E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1755786103;
	bh=IG1S4f0ZLBcta+pgtT/MmOkkmpatwuZ5bkW22UFsx0Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=0QvVRV21mQSIRqynA7ylHYqkQHUWoiaTjXWUnKUJ0VOUFMTGIMEEOTLIYOf6ZY7Gi
	 Uzz6p9024z94a78lKXl2DNt9PN+ujw/LT+Jl8FYatWQpJfJ112Sj4ENob+yzzGZX/X
	 C80i4+NziYm1DbZ5IjE+OD22ETnBuwsuGeFtc5GSMzx5nYegtES9BJGdJ1MUbN12fU
	 8aaAPtIVaUk8pOJJGeCyNKD8lc3bYLS14VzQ35RZc5T/wCx0DkMoBKXmjlSow+lJ4Q
	 wkTiqq3PF5WGwxwTOfsjyWtECZ2GIm9AoRERTraJaTSVseNT6nA9QvJ8zF81hX8lcr
	 vKT77j58idSmg==
Received: from secunet.com (10.182.7.193) by EXCH-02.secunet.de (10.32.0.172)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 16:21:42 +0200
Received: (nullmailer pid 2403903 invoked by uid 1000);
	Thu, 21 Aug 2025 14:21:41 -0000
Date: Thu, 21 Aug 2025 16:21:41 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: syzbot <syzbot+b6ae1c4eede4e0ea287f@syzkaller.appspotmail.com>,
	<ajay.kaher@broadcom.com>, <alexey.makhalov@broadcom.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <jgross@suse.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<syzkaller-bugs@googlegroups.com>, <tglx@linutronix.de>,
	<virtualization@lists.linux.dev>, <x86@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Aakash Kumar S <saakashkumar@marvell.com>
Subject: Re: [syzbot] [x86?] BUG: soft lockup in xfrm_timer_handler
Message-ID: <aKcrddsfOz5G1yVW@secunet.com>
References: <68a2dd64.050a0220.e29e5.0096.GAE@google.com>
 <95833405-18aa-48ad-a5d6-4f659dfbf08a@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95833405-18aa-48ad-a5d6-4f659dfbf08a@intel.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-02.secunet.de (10.32.0.172)

On Tue, Aug 19, 2025 at 07:46:35AM -0700, Dave Hansen wrote:
> On 8/18/25 00:59, syzbot wrote:
> > Call Trace:
> >  <IRQ>
> ...
> >  spin_lock include/linux/spinlock.h:351 [inline]
> >  __xfrm_state_delete+0xba/0xca0 net/xfrm/xfrm_state.c:818
> >  xfrm_timer_handler+0x18f/0xa00 net/xfrm/xfrm_state.c:716
> >  __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
> >  __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1825
> >  hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
> >  handle_softirqs+0x283/0x870 kernel/softirq.c:579
> >  __do_softirq kernel/softirq.c:613 [inline]
> >  invoke_softirq kernel/softirq.c:453 [inline]
> >  __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
> >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
> >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
> 
> >From that call trace, I'd suspect a deadlock from the xfrm code not
> releasing the lock somewhere, not x86 code.
> 
> One thing that stands out is that of the ~20 or so uses of
> '->xfrm.xfrm_state_lock', the call site in the trace is the only one
> that uses spin_lock() instead of spin_lock_bh(). I didn't look at it for
> long, so maybe there's a good reason for it. But it did catch my eye.

That's the one in __xfrm_state_delete. This function has 3 callers,
one ist xfrm_timer_handler itself and two others that disabled
bottom halves bevore calling. That should be save.

We had a recent patch that changed xfrm_alloc_spi, this function
changed the locking behaviour and shows up in the trace:

commit 94f39804d891 ("xfrm: Duplicate SPI Handling")

I don't see an obvious problem, but it changed the locking
used here.

I've Cced the author.
