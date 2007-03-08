From: Zachary Amsden <zach@vmware.com>
Subject: Re: hardwired VMI crap
Date: Thu, 08 Mar 2007 02:06:08 -0800
Message-ID: <45EFE010.7080108@vmware.com>
References: <45EE1EA3.90803@vmware.com> <1173256666.24738.576.camel@localhost.localdomain> <45EEF966.6060902@goop.org> <Line.LNX.4.64.0703071304080.1851@d.namei> <45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com> <1173302503.24738.795.camel@localhost.localdomain> <45EF372E.7030600@goop.org> <1173308717.24738.898.camel@localhost.localdomain> <45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030637AbXCHKGL@vger.kernel.org>
In-Reply-To: <20070308091019.GA19460@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, Jeremy Fitzhardinge <jeremy@goop.org>, john stultz <johnstul@us.ibm.com>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pratap Subrahmanyam <pratap@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, Daniel Hecht <dhecht@vmware.com>, Daniel Arai <arai@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Zachary Amsden <zach@vmware.com> wrote:
>
>   
>> The correct solution here is to properly separate the APIC, SMP, and 
>> timer code so the logic of it which we want to reuse is separated from 
>> the hardware dependence.  Clock events and clocksources take care of 
>> most of the timer issues, but there is still ugliness from SMP timer 
>> events depending on having part of the APIC infrastructure for wiring 
>> the interrupt gates.
>>     
>
> what are you talking about? A clockevents driver does not need to know 
> about lapic details, at all. In terms of interrupt gates for the 
> hypervisor to notify about clock events - use a virtual interrupt 
> controller via genirq.
>   

See my last e-mail.  It is not possible on i386, since local per-cpu 
interrupts are only supported via the APIC.

> if you want to use hardwired hardware details as your API: DO IT WITHOUT 
> MODIFYING LINUX. If you want anything more intelligent, something more 
> 'paravirtual' - WORK WITH US AND WORK WITH THE OTHER HYPERVISORS. So far 
> all i've seen from you was excuses and stonewalling on every step! We 
>   

So far, all you have done is not complain about our code until it was 
merged, the pursue every tactic possible to break it.  It is not us that 
are stonewalling.

> told you about the need to do VMI-timer ontop of clockevents last year 
> already! You resisted virtually EVERY SINGLE cleanup suggestion since 
> your stuff got upstream and you ONLY acted when a change was force-fed 
> to you. Just count the number of emails you wrote, versus the patches 
> you did. And your code is barely 2 weeks in! That is unacceptable.

Which cleanups have we resisted in particular?  I can't recall any.  
Just count the number of emails you wrote versus the patches and helpful 
suggestions you made.  No, instead, you broke our code, in many ways, 
with the untouchable aim of cleaning up the kernel source to do things 
the way you think they should be done in a future release.

Our code is in the tree now, and any attempts to break it using such 
justifications as easing maintenance for kernel developers in future 
releases are flat out false and improper.  We are working to correct 
flaws that we have and properly conform to the changing interfaces such 
as the timer subsystem, and also to interoperate properly with the full 
set of available configurations.

In the meantime, having code that uses slightly older interfaces in the 
kernel tree is not wrong in any way - it is pragmatic, because that code 
is working today, and not only that, the sanest thing to do in a release 
cycle.  And our code in the tree to be released imposes zero burden on 
anyone except for us.  Are we stopping you from rewriting the timer 
subsystem in the -rc tree?  How?  Because this code is supposed to be 
settled.  Your deliberate breaking of our code forces us to come up with 
workarounds that might be considered inappropriate, but nevertheless, 
necessary.  Who has to deal with and adapt to this?  Certainly not you.  
The burden to maintain the correctness of our code is on us.

Working together to make sure that this code completely integrates with 
all this new development is the right thing to do - in the development 
tree.  Why you insist on stopping our code in the tip kernel release 
tree is beyond me, as there is no purpose to it other than to block our 
code.

Zach
