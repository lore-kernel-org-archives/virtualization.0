Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176052;
	b=R6dGdMXPqP5yUIqVAEeG6UuvPhQ5JY2GIv8YhNHQCBmdG93TF2Jk27nZByO6OSmIkDj0
	 eb7T0A5KAzxMyMVN0eKdkba8RtdfSLsHAE6589ZvCarxfUbDgfWdCLuW8NBiJ6UTs9SVn
	 Ee0qvPJKN2ANuNWukyXoPrcibuuJtnURHyci10iq8E1VPW+lwpNcdMXGO742TGVdVq8k+
	 xo0h6ON+uj24DY/ioNgBgqgmnbqwAQPStVvkXiLLtwYeG7lsrgmtx6hhIoFO/jPAzw2wB
	 Jd8UWATfQKPM5BE4N6F7o/OaC9H9sYQURJojG+JRXfGfkyfOB+/HBYfoBbxAoN5/gmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176052;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=c7L8QzpwJmA5NoCwf8pmLA+mt32PGw/GRe/irnTHErc=;
	b=ZrSESkZqaIuBCHXsrIuDzUMUMAiiAhdPE4vBgTKhgrtvKzCbBLaq4QvT95Vaa+2Nqj9K
	 vaTRIoTocV8xNhw04L52HTP2DRQ6w9AJsN1Ltjizqhu9kJ1DIUHC7oQD4Mg1QG0S1rFN5
	 8zHe9wPawTVoTuGHU4F3VMBUSpUgNX8ebdi2A0SYsn9yA1g8b4CajpvYTEeCR3DEjSfUf
	 bgi9OtdXz1c+mC8ZMmLIwpkDVfWRMfwats4DYKCwsCVZjEuEDPUKxx1S+FosImamxOVVI
	 t9eStoHGxUwPfwOGwZqFT9Gt1TFznNosxr+Rv8vm9oX+LeRHl0NmgjbksCQhD6KbzJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ghnBZkl9;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1E606A31A;
	Wed, 28 Oct 2026 08:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ghnBZkl9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c7L8QzpwJmA5NoCwf8pmLA+mt32PGw/GRe/irnTHErc=; b=ghnBZkl9w2iShH6ilw0Xk+VLzM
	XfDNf2o/GRN4RtNJDh1C+F81c0iWa8Ub15VgAhqWifOGvARIJJD/FTSbc9iSdn8TKSWG41MNvsbNJ
	AJfRMdtxl4DcZbjLBy2+KqqAMDoo0ljsAM7d90zscrXew6p9lxDdaEaV5tXZlYt7Is3sKKnWoOM42
	aJEMgRj7k2h+GyBd4ENJuzDQiRu1/vzalVK6u4q2DQMiJP6uctU2wzJLkPp5CoJf/GBQJ2GosOb7P
	wSX2Bwn+6CYzKFcyu3HjrOu0dalv6bhGfYUxNvgINbDs3E7gXHndsP1adG/3IRRdUmJJjp7XfWjph
	s7Uqs4rA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLz0I-0000000Fndl-0zJL;
	Wed, 28 Oct 2026 08:27:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08E3B30120E; Wed, 28 Oct 2026 09:27:25 +0100 (CET)
Date: Wed, 28 Oct 2026 09:27:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v1] x86/vmware: Fix i386 high-bandwidth hypercall
 arguments
Message-ID: <20261028082724.GE2668804@noisy.programming.kicks-ass.net>
References: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab10678a8f50053934b62b56af81f881c1d3798.1788414669.git.zack.rusin@broadcom.com>

On Thu, Sep 03, 2026 at 12:07:20PM -0400, Zack Rusin wrote:
> The high-bandwidth hypercall helpers push %ebp before loading the in6
> operand into it. On i386 without frame pointers, both GCC and Clang can
> address the memory-constrained operand relative to %esp. The push then
> moves the stack and the helpers load the wrong value.
> 
> Typical i386 configurations use the frame-pointer unwinder and happen to
> address the operand through %ebp. However, UNWINDER_GUESS is available
> with EXPERT and permits the affected frame-pointer-disabled configuration.
> vmwgfx is also available on i386 and calls both helpers.
> 
> Stage in6 through %eax before changing either stack register, then save
> %ebp and copy the staged value into it. Load the VMware magic immediately
> before the string I/O instruction. Mark %eax early-clobber so it cannot
> also provide in6 or an address register for it. Use the same sequence on
> x86-64, where the full-width register preserves in6.
> 
> Fixes: 34bf25e820ae ("x86/vmware: Introduce VMware hypercall API")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

So I despise all these hypercalls that muck about with the [BS]P
registers. The Intel function call convention is much older than any of
them and yet they chose to violate it.

This is both vmware and hyperv.

If if were just me I'd have nak'ed the lot. But alas.

At least ARM64 people are (afaik) holding up and telling hyperv its
their problem.

