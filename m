From: Dan Hecht <dhecht@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Tue, 06 Mar 2007 16:42:16 -0800
Message-ID: <45EE0A68.6010406@vmware.com>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	 <20070306084647.GA16280@elte.hu>  <45ED2C82.3080008@vmware.com>	 <1173178774.24738.311.camel@localhost.localdomain>	 <45EDD82F.90204@vmware.com> <1173225182.24738.507.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161043AbXCGAmO@vger.kernel.org>
In-Reply-To: <1173225182.24738.507.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, ak@suse.de, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>, Dan Hecht <dhecht@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/06/2007 03:53 PM, Thomas Gleixner wrote:
>> 2) Virtual interrupts have a relatively high overhead as compared with 
>> native interrupts.  So, in vmitime, we wanted to be able to lower the 
>> timer interrupt rate at runtime, even if HZ is a compile time constant 
>> (and set to something high, like 1000hz).  While we could hack this in 
>> by using evt->min_delta_ns, it wouldn't really work since process time 
>> accounting would be wrong.  Instead, we should allow the 
>> tick_sched_timer in cases (c) and (d) to have runtime configurable 
>> period, and then scale the time value accordingly before passing to 
>> account_system_time.  This is probably something the Xen folks will want 
>> also, since I think Xen itself only gets 100hz hard timer, and so it can 
>> implement at best a oneshot virtual timer with 100hz resolution.  Any 
>> objections to us doing something like this?
> 
> Yes. It's gross hackery. 
> 
> 1) We want to have a cleanup of the tick assumptions _all_ over the
> place and this is going to be real hard work.
> 
> 2) As I said above. The time accounting for virtualization needs to be
> fixed in a generic way.
> 
> I'm not going to accept some weird hackery for virtualization, which is
> of exactly ZERO value for the kernel itself. Quite the contrary it will
> make the cleanup harder and introduce another hard to remove thing,
> which will in the worst case last for ever.
>

Okay, to confirm I'm on the same page as you, you want to move process 
time accounting from being periodic sampled based to being trace based? 
i.e. at the system-call/interrupt boundaries, read clocksource and 
compute directly the amount of system/user/process time?

Do you know if anyone has explored this?  I thought there was a 
discussion about this a while back but it was rejected due to the 
sample-based approach having much lower overheads on high system call 
rate workloads.
