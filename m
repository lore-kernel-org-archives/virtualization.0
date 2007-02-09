From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/10] lguest: Export symbols for lguest as a module
Date: Fri, 09 Feb 2007 23:06:06 +1100
Message-ID: <1171022766.2718.94.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	 <1171012458.2718.30.camel@localhost.localdomain>
	 <1171012513.2718.32.camel@localhost.localdomain>
	 <200702091032.44547.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423021AbXBIMGx@vger.kernel.org>
In-Reply-To: <200702091032.44547.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-09 at 10:32 +0100, Andi Kleen wrote:
> On Friday 09 February 2007 10:15, Rusty Russell wrote:
> 
> > tsc_khz:
> > 	Simplest way of telling the guest how to interpret the TSC
> > 	counter.
> 
> 
> Are you sure this will work with varying TSC frequencies? 

I'm actually quite sure it doesn't (there's a FIXME in the lguest code).
Given the debate over how useful the TSC was, I originally didn't use
it, but (1) it's simple, and (2) when it doesn't change, it's pretty
accurate.

> In general you should get this from cpufreq.

Hmm, ok, I'll bite: how?  Time is a mystery I've avoided so far 8)

Thanks!
Rusty.
