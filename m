From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Tue, 21 Aug 2007 23:03:17 -0700
Message-ID: <46CBD1A5.8070702@vmware.com>
References: <46CBC842.4070100@vmware.com> <46CBD0F5.2080709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757243AbXHVGId@vger.kernel.org>
In-Reply-To: <46CBD0F5.2080709@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Avi Kivity <avi@qumranet.com>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

H. Peter Anvin wrote:
> Zachary Amsden wrote:
>   
>> In general, I/O in a virtual guest is subject to performance problems. 
>> The I/O can not be completed physically, but must be virtualized.  This
>> means trapping and decoding port I/O instructions from the guest OS. 
>> Not only is the trap for a #GP heavyweight, both in the processor and
>> the hypervisor (which usually has a complex #GP path), but this forces
>> the hypervisor to decode the individual instruction which has faulted. 
>> Worse, even with hardware assist such as VT, the exit reason alone is
>> not sufficient to determine the true nature of the faulting instruction,
>> requiring a complex and costly instruction decode and simulation.
>>
>> This patch provides hypercalls for the i386 port I/O instructions, which
>> vastly helps guests which use native-style drivers.  For certain VMI
>> workloads, this provides a performance boost of up to 30%.  We expect
>> KVM and lguest to be able to achieve similar gains on I/O intensive
>> workloads.
>>
>>     
>
> What about cost on hardware?
>   

On modern hardware, port I/O is about the most expensive thing you can 
do.  The extra function call cost is totally masked by the stall.  We 
have measured with port I/O converted like this on real hardware, and 
have seen zero measurable impact on macro-benchmarks.  Micro-benchmarks 
that generate massively repeated port I/O might show some effect on 
ancient hardware, but I can't even imagine a workload which does such a 
thing, other than a polling port I/O loop perhaps - which would not be 
performance critical in any case I can reasonably imagine.

Zach
