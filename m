From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Sat, 23 Sep 2006 14:51:15 +1000
Message-ID: <1158987075.26261.79.camel@localhost.localdomain>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <20060922123215.GA98728@muc.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750955AbWIWEvT@vger.kernel.org>
In-Reply-To: <20060922123215.GA98728@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-22 at 14:32 +0200, Andi Kleen wrote:
> BTW I changed my copy sorry. I redid the early PDA support
> to not be in assembler.
> 
> On Fri, Sep 22, 2006 at 09:59:45PM +1000, Rusty Russell wrote:
> > This patch actually uses the gs register to implement the per-cpu
> > sections.  It's fairly straightforward: the gs segment starts at the
> > per-cpu offset for the particular cpu (or 0, in very early boot).  
> > 
> > We also implement x86_64-inspired (via Jeremy Fitzhardinge) per-cpu
> > accesses where a general lvalue isn't needed.  These
> > single-instruction accesses are slightly more efficient, plus (being a
> > single insn) are atomic wrt. preemption so we can use them to
> > implement cpu_local_inc etc.
> 
> The problem is nobody uses cpu_local_inc() etc :/ And it is difficult
> to use in generic code because of the usual preemption issues 
> (and being slower on other archs in many cases compared to preempt disabling
> around larger block of code) 

True, they were primarily designed for the SNMP counters in networking
(as per your comment in snmp.h).  They're now dynamic per-cpu pointers,
which adds a new wrinkle though 8(

> Without that it is the same code as Jeremy's variant
> %gs memory reference + another reference with offset as far as I can see.
> 
> So while it looks nice I don't think it will have advantages. Or did
> i miss something?

Mainly that it makes more sense to use the existing per-cpu concept than
introduce another kind of per-cpu var within a special structure, but
it's also more efficient (see other post).  Hopefully it will spark
interest in making dynamic-percpu pointers use the same offset scheme,
now x86 will experience the benefits.

And we might even get a third user of local_t!

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
