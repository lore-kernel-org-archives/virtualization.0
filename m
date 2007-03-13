From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 2/9] Sched clock paravirt op fix.patch
Date: Tue, 13 Mar 2007 08:26:27 -0700
Message-ID: <45F6C2A3.4040305@goop.org>
References: <200703020254.l222sOaM009656@zach-dev.vmware.com> <20070313140129.GB92373@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753266AbXCMP0a@vger.kernel.org>
In-Reply-To: <20070313140129.GB92373@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Thu, Mar 01, 2007 at 06:54:24PM -0800, Zachary Amsden wrote:
>   
>> The custom_sched_clock hook is broken.  The result from sched_clock needs to be
>> in nanoseconds, not in CPU cycles.  The TSC is insufficient for this purpose,
>> because TSC is poorly defined in a virtual environment, and mostly represents
>> real world time instead of scheduled process time (which can be interrupted
>> without notice when a virtual machine is descheduled).
>>
>> To make the scheduler consistent, we must expose a different nature of time,
>> that is scheduled time.  So deprecate this custom_sched_clock hack and turn it
>> into a paravirt-op, as it should have been all along.  This allows the tsc.c
>> code which converts cycles to nanoseconds to be shared by all paravirt-ops
>> backends.
>>
>> It is unfortunate to add a new paravirt-op, but this is a very distinct
>> abstraction which is clearly different for all virtual machine implementations,
>> and it gets rid of an ugly indirect function which I ashamedly admit I hacked
>> in to try to get this to work earlier, and then even got in the wrong units.
>>
>> Please apply.
>>     
>
> I think it's better to remove this completely and not allow paravirt
> to hook into sched_clock.  After all a hypervisor stealing time is no
> different from interrupts stealing time and we don't try to handle
> that either. 
>   

Well, its a matter of degree.  If your busy vcpu is sharing a real cpu
with 9 other busy vcpus, then you'll only see about 10% of the real cpu
cycles.  If we had legitimate loads in which 90% of the cpu were taken
up by interrupt processing, then I think we definitely would try to
account for that time properly.

SMM interrupts, in which the CPU is stolen from the kernel entirely, is
a better analogy.  But again, they're expected to be rare and
insignificant.  In a virtual machine, on the other hand, you could
expect the majority of cpu time to be stolen by other things running on
the same physical machine.

In other words, regardless of whether this particular pv_op lives or
dies, we're going to need to have to deal with stolen time properly.  I
think this hook is reasonable and useful step towards doing that.

    J
