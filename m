Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE681AED31;
	Thu,  4 Jul 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098335; cv=none; b=P3llhFkUxjhKGCHOxoGEA5kPXeNrnT1Raxk7woqeisuY7FTFZZ679Q6D6EPsfz0ThNEf6rvqwRjCKazhFWRlW9MbNUTtekXdvHhl9n/1bfXMRYRJ95Rmy0TwgsXxBzUwnFBeDrDZoS2Gxq/aTbzU/XHhQ3ATPDRbgCf5WsFPtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098335; c=relaxed/simple;
	bh=VLX+/UE8oDKDooF+ghZH28ShzdJLeLVP+bDPayL7B3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCbbin/NguOwTwuNzSdHvIYYG7w+VQYiRVouRWb8iu0rrTQMpRAddHH0QWoeQ6EzepQOF0TreBGHi1T8s5ufbvpbhHXSVyVrAWYhWGr0i48GG04+LGaU73No2hPTnZBCZRK3YQ9K1k/c6FaCGjPyp4sBGqdPsMbQCLINbhUjQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gowb/ffi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gowb/ffi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zfd3k+e/2iCQZpiP/1H67Ibzd3SlkkBWIgLCprwuUXY=; b=gowb/ffi2fiTQAxLXhOLHl+gPF
	98pHv/VFFWSfVSvc4LK8nlNHdz18GJXCrxVVx2EI2DzjpCtc5cAlitlA6eSNLA0e4Ezn/slM7Xk4K
	s8eCyC4zF4RB1ik6EAsoDIY4KzG9IN1l6ua1boCoVx9s6nprIAymVGGaIm7ZQKcPxULNxDTN+koAb
	iaSAYs/CuqUyhIZdB+Rc58f4GXG4fvwF+BZOx/SuolHv9yw7+Tp/PvNChf1dMTlxi3B4pDcks3+Yx
	NicW7UmyRPPjqxupjjHoAFHzEFZ6aqcrqUgQYhvv0sjOjiYF9LlatJ62iI48WJMhcN4w4syo7spN9
	EbXduQcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPM96-0000000ADpW-3LPn;
	Thu, 04 Jul 2024 13:05:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F358F300694; Thu,  4 Jul 2024 15:05:05 +0200 (CEST)
Date: Thu, 4 Jul 2024 15:05:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Merrifield <tim.merrifield@broadcom.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, alex.james@broadcom.com,
	doug.covelli@broadcom.com, jeffrey.sheldon@broadcom.com
Subject: Re: [PATCH 0/2] Support userspace hypercalls for TDX
Message-ID: <20240704130505.GT11386@noisy.programming.kicks-ass.net>
References: <cover.1720046911.git.tim.merrifield@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046911.git.tim.merrifield@broadcom.com>

On Wed, Jul 03, 2024 at 11:35:59PM +0000, Tim Merrifield wrote:
> VMCALL and VMMCALL instructions are used by x86 guests to request services
> from the host VMM. Both VMCALL and VMMCALL are not restricted to CPL 0.
> This allows userspace software like open-vm-tools to communicate directly
> with the VMM.
> 
> In the context of confidential VMs, direct communication with the host may
> violate the security model. Existing binaries that make use of hypercalls
> and are not hardened against malicious hypervisors can become a possible
> attack surface. For this reason, user-level VMCALLs are not currently
> forwarded to the host on TDX VMs. This breaks any user-level software that
> use these instructions.
> 
> But if user-level software is aware of the risks and has been hardened to
> address any known violations of the security model, then it seems
> reasonable to allow hypercalls from this process to proceed.

And how are we to ascertain the software using these hooks is deemed
secure? What security risks are there for the kernel if a malicious
userspace process asks for these rights?

The kernel must assume malice on the part of userspace.
