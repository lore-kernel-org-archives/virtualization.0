From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] mm: fix comment formatting in
	asm-generic/pgtable.h:__ptep_modify_prot_
Date: Fri, 13 Jun 2008 09:18:00 +0200
Message-ID: <20080613071800.GA11976@elte.hu>
References: <patchbomb.1212192268@localhost> <20080602111339.GB18586@elte.hu>
	<4843EF6A.20305@goop.org>
	<200806030946.00434.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <200806030946.00434.rusty@rustcorp.com.au>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> > -	/* Get the current pte state, but zero it out to make it
> > -	   non-present, preventing the hardware from asynchronously
> > -	   updating it. */
> > +	/*
> > +	 * Get the current pte state, but zero it out to make it
> > +	 * non-present, preventing the hardware from asynchronously
> > +	 * updating it.
> > +	 */
> 
> Since there is debate over whether winged comments are a feature, I'm 
> not sure this can be termed a "fix".

Well, if you compare the two variants above Jeremy's solution looks 
visually more pleasing, so yes it is an improvement and a fix.

( And it's even very obvious in this case, the vertical line gives a
  clear delineation of the information and separates it from the code
  sections. )

Also, according to Documentation/CodingStyle:

| The preferred style for long (multi-line) comments is:
|
|        /*
|         * This is the preferred style for multi-line
|         * comments in the Linux kernel source code.
|         * Please use it consistently.
|         *
|         * Description:  A column of asterisks on the left side,
|         * with beginning and ending almost-blank lines.
|         */

arch/x86 and include/asm-x86 follows that rule. (And we'd follow it even 
if the issue was typographically debatable [which it isnt] because 
consistency is visual rule #0 )

	Ingo
