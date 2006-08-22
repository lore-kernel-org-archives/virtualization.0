From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 15:02:52 -0700
Message-ID: <44EB7F0C.60402@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain>	<44DB7596.6010503@goop.org>	<1156254965.27114.17.camel@localhost.localdomain>	<200608221544.26989.ak@muc.de> <44EB3BF0.3040805@vmware.com>	<1156271386.2976.102.camel@laptopd505.fenrus.org>	<1156275004.27114.34.camel@localhost.localdomain>	<44EB584A.5070505@vmware.com> <44EB5A76.9060402@vmware.com> <p73y7tg7cg7.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751306AbWHVWCz@vger.kernel.org>
In-Reply-To: <p73y7tg7cg7.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> Zachary Amsden <zach@vmware.com> writes:
>   
>> That is a really nasty problem.  You need a synchronization primitive
>> which guarantees a flat stack, so you can't do it in the interrupt
>> handler as I have tried to do.  I'll bang my head on it awhile.  In
>> the meantime, were there ever any solutions to the syscall patching
>> problem that might lend me a clue as to what to do (or not to do, or
>> impossible?).
>>     
>
> stop_machine_run() solves the problem I think. It is currently not 
> exported though. I don't think there's anything in there that couldn't
> be reimplemented in a module, but then we could also just export it
> if there's a useful user.
>   

Well, I don't think anything is sufficient for a preemptible kernel.  I 
think that's just plain not going to work.  You could have a kernel 
thread that got preempted in a paravirt-op patch point, and making all 
the patch points non-preempt is probably a non-starter (either +12 bytes 
each or no native inlining).  Finding out after the fact that you have a 
kernel thread that was preempted in a patch point is very hard work, but 
it is possible.  The fixing it up is where you need to take liberties 
with reality.

stop_machine_run() is almost what I want, but even that is not 
sufficient.  You also need to disable NMIs and debug traps, which is 
pretty hairy, but doable.  The problem with stop_machine_run() is that I 
don't just want the kernel to halt running on remote CPUs, I want the 
kernel on all CPUs to actually do something simultaneously - the entry 
into paravirt mode requires a hypervisor call on each CPU, and 
stop_machine() doesn't provide a facility to fire a callback on each CPU 
from the stopmachine state.

Since this code is so rather, um, custom, I was going to reimplement 
stop_machine in the module.

Zach
