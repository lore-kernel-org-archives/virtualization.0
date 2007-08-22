From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 19:59:18 +0200
Message-ID: <20070822175918.GB8058@bingen.suse.de>
References: <46CBC842.4070100@vmware.com> <20070822102217.GE2642@bingen.suse.de> <46CC68D9.5060200@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933378AbXHVRFj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CC68D9.5060200@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 22, 2007 at 09:48:25AM -0700, Zachary Amsden wrote:
> Andi Kleen wrote:
> >On Tue, Aug 21, 2007 at 10:23:14PM -0700, Zachary Amsden wrote:
> >  
> >>In general, I/O in a virtual guest is subject to performance problems.  
> >>The I/O can not be completed physically, but must be virtualized.  This 
> >>means trapping and decoding port I/O instructions from the guest OS.  
> >>Not only is the trap for a #GP heavyweight, both in the processor and 
> >>the hypervisor (which usually has a complex #GP path), but this forces 
> >>the hypervisor to decode the individual instruction which has faulted.  
> >>    
> >
> >Is that really that expensive? Hard to imagine.
> >  
> 
> You have an expensive (16x cost of hypercall on some processors) 

Where is the difference comming from? Are you using SYSENTER
for the hypercall?  I can't really see you using SYSENTER,
because how would you do system calls then? I bet system calls
are more frequent than in/out, so if you have decide between the
two using them for syscalls is likely faster.

For an int XYZ gate i wouldn't expect that much difference to
a #GP fault.

Also I fail to see the fundamental speed difference between

mov index,register
int 0x...
...
switch (register) 
case xxxx: do emulation

versus

out ...
#gp
-> switch (*eip) {
case 0xee:  /* etc. */ 
	do emulation

> privilege transition, you have to decode the instruction, then you have 

out is usually a single byte. Shouldn't be very expensive
to decode. In fact it should be roughly equivalent to your
hypercall multiplex.

> to verify protection in the page tables mapping the page allows 
> execution (P, !NX, and U/S check).  This is a lot more expensive than a 

When the page is not executable or not present you get #PF not #GP. 
So the hardware already checks that.

The only case where you would need to check yourself is if you emulate
NX on non NX capable hardware, but I can't see you doing that.

> There are 24 different possible I/O operations; sometimes with a port 
> encoded in the instruction, sometimes with input in the DX register, 
> sometimes with a rep prefix, and for 3 different operand sizes.

Most of this is a single byte which is the same as the hypercall
demux. Essentially a table lookup if you use the obvious switch()

-Andi
