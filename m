From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 09:48:25 -0700
Message-ID: <46CC68D9.5060200@vmware.com>
References: <46CBC842.4070100@vmware.com> <20070822102217.GE2642@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933157AbXHVQxt@vger.kernel.org>
In-Reply-To: <20070822102217.GE2642@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Tue, Aug 21, 2007 at 10:23:14PM -0700, Zachary Amsden wrote:
>   
>> In general, I/O in a virtual guest is subject to performance problems.  
>> The I/O can not be completed physically, but must be virtualized.  This 
>> means trapping and decoding port I/O instructions from the guest OS.  
>> Not only is the trap for a #GP heavyweight, both in the processor and 
>> the hypervisor (which usually has a complex #GP path), but this forces 
>> the hypervisor to decode the individual instruction which has faulted.  
>>     
>
> Is that really that expensive? Hard to imagine.
>   

 You have an expensive (16x cost of hypercall on some processors) 
privilege transition, you have to decode the instruction, then you have 
to verify protection in the page tables mapping the page allows 
execution (P, !NX, and U/S check).  This is a lot more expensive than a 
hypercall.

> e.g. you could always have a fast check for inb/outb at the beginning
> of the #GP handler. And is your initial #GP entry really more expensive
> than a hypercall? 
>   

The number of reasons for #GP is enormous, and there are too many paths 
to optimize with fast checks.  We do have a fast check for inb/outb; 
it's just not fast enough.

On P4, hypercall entry is 120 cycles.  #GP is about 2000.  Modern 
processors are better, but a hypercall is always faster than a fault.  
Many times, the hypercall can be handled and ready to return before a 
#GP would even complete.

On workloads that sit there and hammer network cards, these costs become 
significant, and latency sensitive network benchmarks suffer.

>> Worse, even with hardware assist such as VT, the exit reason alone is 
>> not sufficient to determine the true nature of the faulting instruction, 
>> requiring a complex and costly instruction decode and simulation.
>>     
>
> It's unclear to me why that should be that costly.
>
> Worst case it's a switch()
>   

There are 24 different possible I/O operations; sometimes with a port 
encoded in the instruction, sometimes with input in the DX register, 
sometimes with a rep prefix, and for 3 different operand sizes.

Combine that with the MMU checks required, and it's complex and branchy 
enough to justify short-circuiting the whole thing with a simple hypercall.

Zach
