From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/10] lguest: Export symbols for lguest as a module
Date: 9 Feb 2007 14:58:55 +0100
Message-ID: <20070209135855.GC18080@muc.de>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171012458.2718.30.camel@localhost.localdomain> <1171012513.2718.32.camel@localhost.localdomain> <200702091032.44547.ak@muc.de> <1171022766.2718.94.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946467AbXBIN66@vger.kernel.org>
Date: Fri, 9 Feb 2007 14:58:55 +0100
Content-Disposition: inline
In-Reply-To: <1171022766.2718.94.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 09, 2007 at 11:06:06PM +1100, Rusty Russell wrote:
> On Fri, 2007-02-09 at 10:32 +0100, Andi Kleen wrote:
> > On Friday 09 February 2007 10:15, Rusty Russell wrote:
> > 
> > > tsc_khz:
> > > 	Simplest way of telling the guest how to interpret the TSC
> > > 	counter.
> > 
> > 
> > Are you sure this will work with varying TSC frequencies? 
> 
> I'm actually quite sure it doesn't (there's a FIXME in the lguest code).
> Given the debate over how useful the TSC was, I originally didn't use
> it, but (1) it's simple, and (2) when it doesn't change, it's pretty
> accurate.

But when it changes users become pretty unhappy

> 
> > In general you should get this from cpufreq.
> 
> Hmm, ok, I'll bite: how?  Time is a mystery I've avoided so far 8)

the old x86-64 time.c (before -mm) has a example in #ifdef CONFIG_CPUFREQ


-Andi
