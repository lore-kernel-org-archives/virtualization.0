From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 12:22:17 +0200
Message-ID: <20070822102217.GE2642@bingen.suse.de>
References: <46CBC842.4070100@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760234AbXHVJ2i@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CBC842.4070100@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2007 at 10:23:14PM -0700, Zachary Amsden wrote:
> In general, I/O in a virtual guest is subject to performance problems.  
> The I/O can not be completed physically, but must be virtualized.  This 
> means trapping and decoding port I/O instructions from the guest OS.  
> Not only is the trap for a #GP heavyweight, both in the processor and 
> the hypervisor (which usually has a complex #GP path), but this forces 
> the hypervisor to decode the individual instruction which has faulted.  

Is that really that expensive? Hard to imagine.

e.g. you could always have a fast check for inb/outb at the beginning
of the #GP handler. And is your initial #GP entry really more expensive
than a hypercall? 

> Worse, even with hardware assist such as VT, the exit reason alone is 
> not sufficient to determine the true nature of the faulting instruction, 
> requiring a complex and costly instruction decode and simulation.

It's unclear to me why that should be that costly.

Worst case it's a switch()

-Andi
