From: Zachary Amsden <zach@vmware.com>
Subject: Re: huh startup_ipi_hook?
Date: Mon, 30 Apr 2007 13:30:31 -0700
Message-ID: <463651E7.60702@vmware.com>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> The current paravirt startup_ipi hook for vmware 
> commit: ae5da273fe3352febd38658d8d34484cbcfb3423
> is quite frankly ridiculous.
>
> In the middle of wake_up_secondary_cpu:
> We have:
>       /*
>        * Paravirt / VMI wants a startup IPI hook here to set up the
>        * target processor state.
>        */
>       startup_ipi_hook(phys_apicid, (unsigned long) start_secondary,
>                        (unsigned long) stack_start.esp);
>
> As far as I can tell from reading this there is a completely
> different mechanism in place to start for a secondary processor.
> Which seems sane.
>   

It is not completely different.  The startup mechanism is the same; the 
startup state is not.

> What doesn't seem sane is bothering to run the rest of the code
> for sending an INIT message to a secondary processor.  It certainly
> does not feel general at all.
>   

We need some wakeup mechanism to launch the APs; we already implement 
INIT and STARTUP IPIs for the non-paravirt case and the startup IPI is a 
good match to the wakeup we need, both in the the Linux code and the 
hypervisor.

> I think we should be intercepting this startup call at a higher level,
> where we can just say:  Start secondary cpu with this stack
> and with this esp.  Or something like that.
>
> So conceptually I think the concept makes sense but implementation
> wise I think what is currently present is totally ridiculous.
>   

A heathen notion, conceivably, but not, I hope, an unenlightened one.

We have to support two methods of booting on the same hardware.  
Traditional booting does standard SMP startup, which means the BIOS has 
put CPUs into a real mode wait loop (basically, cli;hlt, wait for INIT 
IPI).  We have to emulate traditional booting; you might not be booting 
a paravirt kernel.

Now here is where problems begin.  BSP enters paravirt mode.  It 
switches paravirt-ops over to warm and fuzzy hypercalls.  APs have no 
idea about this.  In fact, they cannot be switched into paravirt mode 
yet because not only might the BSP be running a UP kernel, which could 
crash or reboot, but more importantly, they have no code to run.  
Unfortunately, they can not run real mode code either.  Once the BSP is 
up and running paravirt style, the binary translator which we use to run 
privileged code has been hobbled at the knees.  This is an 
implementation artifact, certainly, and one that is mostly fixed now, 
but suffice it to say that interactions between CPUs in paravirt and 
non-paravirt mode are currently unsupported at best and unreliable at worst.

To get out of this real mode loop and into paravirt mode, we have to 
switch on the APs at some point.  There are major problems lurking 
here.  To follow points so far:

1) We can't start all CPUs at time-zero in paravirt mode; we might load 
any kernel, paravirt or non para
2) At the time when we are bringing up APs, BSP is in paravirt mode and 
APs are halted in real mode
3) We can't run paravirt mode code on APs without properly initialized 
segment registers for code, stack and data.
4) The i386 architecture provides no way to initialize GDTR or segment 
state on AP prior to a startup IPI.
5) We can't run real mode code on APs to go through the boot trampoline 
and initialize GDTR because of mixed mode problems.

To solve this, we modify the startup IPI to carry additional 
information; it takes almost a full state map and allows the startup IPI 
to initialize the protected mode register settings to any value the OS 
might want.  This is what startup_ipi_hook does - it tells the 
hypervisor the initial state to place the AP in when it receives a 
startup IPI.  It is the most general startup mechanism you can possibly 
have, and allows you to solve the above combination of constraints on 
any protected mode operating system.

We use it to bypass head.S completely, setting control registers and 
segments and jumping directly into paravirtualized protected mode on the 
APs at the C code entry point.  It is arguably cleaner than having some 
real mode trampoline system.

So yes, we have a very different entry method, and it carries the burden 
of maintaining a list of register and segments that the initial CPU 
state should look like on the APs.  Is it easy to break?  Yes.  Jeremy 
broke it at least twice already when reworking per-cpu state.  Did it 
affect his code in any way?  No.  And that is _good_.

Could we hack head.S into a thousand points of light and contort it so 
that both protected mode and real mode entry took the same path, running 
on some default assumed segment state provided by the hypervisor?  
Certainly.  Would this make life easier for you to have new entry points 
popping up all along head.S that all have to do these initial state 
manipulations in slightly different yet co-dependent ways?

No, the best long term solution is to fix the constraint that introduced 
the problem; drop condition 5 above, and make VMI / paravirt entry on 
APs start in real mode, just like the standard hardware, and make it 
follow the regular code in head.S.  Once we get up to C code, it is a 
simple matter to call out to the paravirt-ops code and do the same thing 
that the BSP did to get into paravirt mode, and there are no more 
odd-looking hacks hanging on the wall.  But it is a long term solution, 
not something that is feasible currently.

So that is why it is good that breakage here did not stop Jeremy from 
improving the native kernel with per-cpu data segments.  There is a 
deficiency on our end that did not impede his progress, and the burden 
of maintaining code which you (rightfully) feel is ridiculous is limited 
to those who have it.  That's why I'm listed as a maintainer for the 
code, because it is not maintenance free, but certainly we would like it 
to be hassle free for everyone else.

Zach

tatpratishedhaartham ekatattva abhyasah
"Adherence to single-minded effort prevents these impediments"
