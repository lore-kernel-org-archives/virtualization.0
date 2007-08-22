From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Tue, 21 Aug 2007 22:40:40 -0700
Message-ID: <46CBCC58.3010700@vmware.com>
References: <46CBC842.4070100@vmware.com> <46CBCADF.2070400@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754091AbXHVFqM@vger.kernel.org>
In-Reply-To: <46CBCADF.2070400@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Zachary Amsden wrote:
>   
>> In general, I/O in a virtual guest is subject to performance
>> problems.  The I/O can not be completed physically, but must be
>> virtualized.  This means trapping and decoding port I/O instructions
>> from the guest OS.  Not only is the trap for a #GP heavyweight, both
>> in the processor and the hypervisor (which usually has a complex #GP
>> path), but this forces the hypervisor to decode the individual
>> instruction which has faulted.  Worse, even with hardware assist such
>> as VT, the exit reason alone is not sufficient to determine the true
>> nature of the faulting instruction, requiring a complex and costly
>> instruction decode and simulation.
>>
>> This patch provides hypercalls for the i386 port I/O instructions,
>> which vastly helps guests which use native-style drivers.  For certain
>> VMI workloads, this provides a performance boost of up to 30%.  We
>> expect KVM and lguest to be able to achieve similar gains on I/O
>> intensive workloads.
>>
>>     
>
>
> Won't these workloads be better off using paravirtualized drivers? 
> i.e., do the native drivers with paravirt I/O instructions get anywhere
> near the performance of paravirt drivers?
>   

Yes, in general, this is true (better off with paravirt drivers).  
However, we have "paravirt" drivers which run in both 
fully-paravirtualized and fully traditionally virtualized environments.  
As a result, they use native port I/O operations to interact with 
virtual hardware.

Since not all hypervisors have paravirtualized driver infrastructures 
and guest O/S support yet, these hypercalls can be advantages to a wide 
range of scenarios.  Using I/O hypercalls as such gives exactly the same 
performance as paravirt drivers for us, by eliminating the costly decode 
path, and the simplicity of using the same driver code makes this a huge 
win in code complexity.

Zach
