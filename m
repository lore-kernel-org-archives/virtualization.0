From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] paravirt.h
Date: Wed, 23 Aug 2006 01:38:38 -0700
Message-ID: <44EC140E.5050703@vmware.com>
References: <1155202505.18420.5.camel@localhost.localdomain> <p73y7tg7cg7.fsf@verdi.suse.de> <44EB7F0C.60402@vmware.com> <200608231018.12571.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964786AbWHWIil@vger.kernel.org>
In-Reply-To: <200608231018.12571.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>  
>   
>> Well, I don't think anything is sufficient for a preemptible kernel.  I 
>> think that's just plain not going to work.  You could have a kernel 
>> thread that got preempted in a paravirt-op patch point, and making all 
>> the patch points non-preempt is probably a non-starter (either +12 bytes 
>> each or no native inlining). 
>>     
>
> stop machine deals with preemption.  If it didn't it would be unusable
> for the purposes the kernel uses it right now (cpu hotplug, module unloading etc.)
>   

Yes, but it can't move pre-empted threads out of a particularly 
dangerous EIP (like a piece of code we're about to patch over).  Or 
perhaps I am misunderstanding how it deals with preemption, and what it 
really does is make sure all threads are in userspace or sleep state...  
which in that case is perfectly fine.

> and machine checks. debug traps -- i assume you mean kernel debuggers -- 
> sounds like something that cannot be really controlled though.
>
> How do you control a debugger from the debugee?
>
> I don't think NMI/MCEs are a problem though because NMIs (at least oprofile/nmi watchdog) 
> and MCEs all just have global state that can be changed on a single CPU.
>   

But with paravirt-ops, that global state may include local CPU state, in 
which paravirt-ops is intimately involved.  So they could interrupt in 
the middle of the patching code, then attempt a paravirt_ops call, which 
is in an undefined state until the patching is complete.  And I would 
highly expect the debugger to  mess with debug registers, which is a 
paravirt op.  NMIs can do plenty of dangerous things to local state as 
well - reading and writing MSRs or performance counters I would imagine 
to be quite useful.

Zach
