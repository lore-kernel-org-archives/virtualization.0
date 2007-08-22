From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 10:07:47 -0700
Message-ID: <46CC6D63.2010204@vmware.com>
References: <46CBC842.4070100@vmware.com> <20070822102217.GE2642@bingen.suse.de> <46CC68D9.5060200@vmware.com> <20070822175918.GB8058@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765575AbXHVRNN@vger.kernel.org>
In-Reply-To: <20070822175918.GB8058@bingen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Wed, Aug 22, 2007 at 09:48:25AM -0700, Zachary Amsden wrote:
>   
>> Andi Kleen wrote:
>>     
>>> On Tue, Aug 21, 2007 at 10:23:14PM -0700, Zachary Amsden wrote:
>>>  
>>>       
>>>> In general, I/O in a virtual guest is subject to performance problems.  
>>>> The I/O can not be completed physically, but must be virtualized.  This 
>>>> means trapping and decoding port I/O instructions from the guest OS.  
>>>> Not only is the trap for a #GP heavyweight, both in the processor and 
>>>> the hypervisor (which usually has a complex #GP path), but this forces 
>>>> the hypervisor to decode the individual instruction which has faulted.  
>>>>    
>>>>         
>>> Is that really that expensive? Hard to imagine.
>>>  
>>>       
>> You have an expensive (16x cost of hypercall on some processors) 
>>     
>
> Where is the difference comming from? Are you using SYSENTER
> for the hypercall?  I can't really see you using SYSENTER,
> because how would you do system calls then? I bet system calls
> are more frequent than in/out, so if you have decide between the
> two using them for syscalls is likely faster.
>   

We use sysenter for hypercalls and also for system calls.  :)

> Also I fail to see the fundamental speed difference between
>
> mov index,register
> int 0x...
> ...
> switch (register) 
> case xxxx: do emulation
>   

Int (on p4 == ~680 cycles).

> versus
>
> out ...
> #gp
> -> switch (*eip) {
> case 0xee:  /* etc. */ 
> 	do emulation
>   

GP = ~2000 cycles.

>> to verify protection in the page tables mapping the page allows 
>> execution (P, !NX, and U/S check).  This is a lot more expensive than a 
>>     
>
> When the page is not executable or not present you get #PF not #GP. 
> So the hardware already checks that.
>
> The only case where you would need to check yourself is if you emulate
> NX on non NX capable hardware, but I can't see you doing that.
>   

No, it doesn't.  Between the #GP and decode, you have an SMP race where 
another processor can rewrite the instruction.

Zach
