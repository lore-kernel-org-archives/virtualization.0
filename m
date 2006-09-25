From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Tue, 26 Sep 2006 09:33:14 +1000
Message-ID: <1159227195.26986.68.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <4514663E.5050707@goop.org>
	 <1158985882.26261.60.camel@localhost.localdomain>
	 <45172AC8.2070701@goop.org>
	 <1159146974.26986.30.camel@localhost.localdomain>
	 <45173287.8070204@goop.org>
	 <1159152678.26986.38.camel@localhost.localdomain>
	 <45176865.7020300@goop.org>
	 <1159164232.26986.59.camel@localhost.localdomain>
	 <45177664.3060103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751684AbWIYXdT@vger.kernel.org>
In-Reply-To: <45177664.3060103@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2006-09-24 at 23:25 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > I don't think so.  There's *never* address subtraction, there's
> > sometimes 32 bit wrap (glibc uses this to effect subtraction, sure).
> > But there's no wrap here.
> >   
> Hm, I guess, so long as you assume the kernel data segment is always 
> below the kernel heap.

Agreed, we should BUG_ON() in case anyone ever changes this...  I will
create a patch for this...

> > To test, I changed the following:
> >
> > --- smpboot.c.~8~	2006-09-25 15:51:50.000000000 +1000
> > +++ smpboot.c	2006-09-25 16:00:36.000000000 +1000
> > @@ -926,8 +926,9 @@
> >  					      unsigned long per_cpu_off)
> >  {
> >  	unsigned limit, flags;
> > +	extern char __per_cpu_end[];
> >  
> > -	limit = (1 << 20);
> > +	limit = PAGE_ALIGN((long)__per_cpu_end) >> PAGE_SHIFT;
> >   
> limit is a size, rather than the end address, so this isn't quite right.

I think it's OK.  For every "%gs:var", var will be less than
__per_cpu_end.

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
