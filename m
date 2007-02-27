From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove HAVE_ARCH_MM_LIFETIME,
	define no-op architecture implementations
Date: Tue, 27 Feb 2007 12:04:40 -0600
Message-ID: <1172599480.3408.28.camel@mulgrave.il.steeleye.com>
References: <20070227081337.434798469@goop.org>
	 <20070227081632.356636957@goop.org>
	 <1172589358.3408.2.camel@mulgrave.il.steeleye.com>
	 <45E46889.9090801@goop.org>
	 <1172597726.3408.25.camel@mulgrave.il.steeleye.com>
	 <45E470D6.7050401@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751939AbXB0SFV@vger.kernel.org>
In-Reply-To: <45E470D6.7050401@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-02-27 at 09:56 -0800, Jeremy Fitzhardinge wrote:
> include/asm-generic isn't in the compile include path; its contents are
> only ever used if they're explicitly included by some other asm/
> header.  I seem to remember there was some debate about this, but I
> don't really understand the rationale for the current arrangement; it
> makes sense to me to have asm-generic as a set of fallback default includes.

Yes ... I forgot about that ... we'd need an asm/mmu_context_paravirt.h
on every arch.

I suppose this is just me being lazy ... I'm currently doing a bit of a
rewrite in asm-parisc/mmu_context.h and I didn't want a massive merge
conflict.

James
