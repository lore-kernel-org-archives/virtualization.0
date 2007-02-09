From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/10] lguest: Don't rely on last-linked fallthru when
	no paravirt handler
Date: Fri, 09 Feb 2007 22:52:46 +1100
Message-ID: <1171021966.2718.82.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	 <1171012458.2718.30.camel@localhost.localdomain>
	 <200702091031.20249.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946376AbXBILxb@vger.kernel.org>
In-Reply-To: <200702091031.20249.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-09 at 10:31 +0100, Andi Kleen wrote:
> On Friday 09 February 2007 10:14, Rusty Russell wrote:
> 
> > +unhandled_paravirt:
> > +	/* Nothing wanted us: try to die with dignity (impossible trap). */ 
> > +	movl	$0x1F, %edx
> > +	pushl	$0
> > +	jmp	early_fault
> 
> Please print a real message with early_printk

If we make it thought early_fault, this will do just that.

Given this is a "never happens" situation, however... if you're actually
under Xen or lguest, you won't make it that far (lguest, at least, will
kill you on the cr2 load in early_fault, but it doesn't matter because
we won't get anywhere with early_printk anyway).

Actually, if we did BUG() here at least lguest would print something...
I wonder what Xen would do...

Rusty.
