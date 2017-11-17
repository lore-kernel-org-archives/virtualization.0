From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter
	real idle path
Date: Fri, 17 Nov 2017 12:36:31 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711171229100.7700@nanos>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
	<20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.20.1711152240010.2146@nanos>
	<46086489-5a01-16e1-9314-70ae53c01952@gmail.com>
	<alpine.DEB.2.20.1711161048000.2191@nanos>
	<564b8a6e-8ddd-4e3d-c670-10f1697e6c06@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1194012674-1510918384=:7700"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <564b8a6e-8ddd-4e3d-c670-10f1697e6c06@gmail.com>
Content-ID: <alpine.DEB.2.20.1711171233290.7700@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu0@gmail.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Quan Xu <quan.xu03@gmail.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1194012674-1510918384=:7700
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.20.1711171233291.7700@nanos>

On Fri, 17 Nov 2017, Quan Xu wrote:
> On 2017-11-16 17:53, Thomas Gleixner wrote:
> > That's just plain wrong. We don't want to see any of this PARAVIRT crap in
> > anything outside the architecture/hypervisor interfacing code which really
> > needs it.
> > 
> > The problem can and must be solved at the generic level in the first place
> > to gather the data which can be used to make such decisions.
> > 
> > How that information is used might be either completely generic or requires
> > system specific variants. But as long as we don't have any information at
> > all we cannot discuss that.
> > 
> > Please sit down and write up which data needs to be considered to make
> > decisions about probabilistic polling. Then we need to compare and contrast
> > that with the data which is necessary to make power/idle state decisions.
> > 
> > I would be very surprised if this data would not overlap by at least 90%.
> > 
> 1. which data needs to considerd to make decisions about probabilistic polling
> 
> I really need to write up which data needs to considerd to make
> decisions about probabilistic polling. At last several months,
> I always focused on the data _from idle to reschedule_, then to bypass
> the idle loops. unfortunately, this makes me touch scheduler/idle/nohz
> code inevitably.
> 
> with tglx's suggestion, the data which is necessary to make power/idle
> state decisions, is the last idle state's residency time. IIUC this data
> is duration from idle to wakeup, which maybe by reschedule irq or other irq.

That's part of the picture, but not complete.

> I also test that the reschedule irq overlap by more than 90% (trace the
> need_resched status after cpuidle_idle_call), when I run ctxsw/netperf for
> one minute.
> 
> as the overlap, I think I can input the last idle state's residency time
> to make decisions about probabilistic polling, as @dev->last_residency does.
> it is much easier to get data.

That's only true for your particular use case.

> 
> 2. do a HV specific idle driver (function)
> 
> so far, power management is not exposed to guest.. idle is simple for KVM
> guest,
> calling "sti" / "hlt"(cpuidle_idle_call() --> default_idle_call())..
> thanks Xen guys, who has implemented the paravirt framework. I can implement
> it
> as easy as following:
> 
>              --- a/arch/x86/kernel/kvm.c

Your email client is using a very strange formatting. 

>              +++ b/arch/x86/kernel/kvm.c
>              @@ -465,6 +465,12 @@ static void __init kvm_apf_trap_init(void)
>                      update_intr_gate(X86_TRAP_PF, async_page_fault);
>               }
> 
>              +static __cpuidle void kvm_safe_halt(void)
>              +{
>          +        /* 1. POLL, if need_resched() --> return */
>          +
>              +        asm volatile("sti; hlt": : :"memory"); /* 2. halt */
>              +
>          +        /* 3. get the last idle state's residency time */
>              +
>          +        /* 4. update poll duration based on last idle state's
> residency time */
>              +}
>              +
>               void __init kvm_guest_init(void)
>               {
>                      int i;
>              @@ -490,6 +496,8 @@ void __init kvm_guest_init(void)
>                      if (kvmclock_vsyscall)
>                              kvm_setup_vsyscall_timeinfo();
> 
>              +       pv_irq_ops.safe_halt = kvm_safe_halt;
>              +
>               #ifdef CONFIG_SMP
> 
> 
> then, I am no need to introduce a new pvops, and never modify
> schedule/idle/nohz code again.
> also I can narrow all of the code down in arch/x86/kernel/kvm.c.
> 
> If this is in the right direction, I will send a new patch set next week..

This is definitely better than what you proposed so far and implementing it
as a prove of concept seems to be worthwhile.

But I doubt that this is the final solution. It's not generic and not
necessarily suitable for all use case scenarios.

Thanks,

	tglx
--8323329-1194012674-1510918384=:7700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323329-1194012674-1510918384=:7700--
