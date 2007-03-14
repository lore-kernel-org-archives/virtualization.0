From: Dan Hecht <dhecht@vmware.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Wed, 14 Mar 2007 13:46:59 -0700
Message-ID: <45F85F43.9030803@vmware.com>
References: <45F6D1D0.6080905@goop.org>	
	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com> <45F77C27.8090604@goop.org>
	<45F846AB.6060200@vmware.com> <45F84E39.7030507@goop.org>
	<45F85A62.8050001@vmware.com> <45F85BBB.70707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F85BBB.70707@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: dwalker@mvista.com, john stultz <johnstul@us.ibm.com>, paulus@au.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, cpufreq@lists.linux.org.uk, schwidefsky@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 03/14/2007 01:31 PM, Jeremy Fitzhardinge wrote:
> Dan Hecht wrote:
>> Sounds good.  I don't see this in your patchset you sent yesterday
>> though; did you add it after sending out those patches?
> =

> Yes.
> =

>>   if so, could you forward the new patch?  does it explicitly prevent
>> stolen time from getting accounted as  user/system time or does it
>> just rely on NO_HZ mode sort of happening to work that way (since the
>> one shot timer is skipped ahead for missed ticks)?
> =

> Hm, not sure.  It doesn't care how often it gets called; it just
> accumulates results up to that point, but I'm not sure if the time would
> get double accounted.  Perhaps it doesn't matter when using
> xen_sched_clock().
> =


I think you might be double counting time in some cases.  sched_clock() =

isn't really relevant to stolen time accounting (i.e. cpustat->steal).

I think what you want is to make sure that the sum of the cputime passed =

to all of:

account_user_time
account_system_time
account_steal_time

adds up to the total amount of time that has passed.  I think it is sort =

of working for you (i.e. doesn't always double count stolen ticks) since =

in NO_HZ mode, update_process_time (which calls account_user_time & =

account_system_time) happens to be skipped during periods of stolen time =

due to the hrtimer_forward()'ing of the one shot expiry.

> Did the get_scheduled_time -> sched_clock make sense to you?
> =


The get_scheduled_time change should work fine for vmi.

>     J
> =

> =

> ------------------------------------------------------------------------
> =

> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: john stultz <johnstul@us.ibm.com>
> =

> ---
>  arch/i386/xen/time.c |  101 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 101 insertions(+)
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/xen/time.c
> +++ b/arch/i386/xen/time.c
> @@ -2,6 +2,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
> +#include <linux/kernel_stat.h>
>  =

>  #include <asm/xen/hypervisor.h>
>  #include <asm/xen/hypercall.h>
> @@ -14,6 +15,7 @@
>  =

>  #define XEN_SHIFT 22
>  #define TIMER_SLOP	100000	/* Xen may fire a timer up to this many ns ear=
ly */
> +#define NS_PER_TICK	(1000000000ll / HZ)
>  =

>  static DEFINE_PER_CPU(struct clock_event_device, xen_clock_events);
>  =

> @@ -28,6 +30,99 @@ struct shadow_time_info {
>  =

>  static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);
>  =

> +/* runstate info updated by Xen */
> +static DEFINE_PER_CPU(struct vcpu_runstate_info, runstate);
> +
> +/* snapshots of runstate info */
> +static DEFINE_PER_CPU(struct vcpu_runstate_info, runstate_snapshot);
> +
> +/* unused ns of stolen and blocked time */
> +static DEFINE_PER_CPU(u64, residual_stolen);
> +static DEFINE_PER_CPU(u64, residual_blocked);
> +
> +/*
> +   Runstate accounting
> + */
> +static void get_runstate_snapshot(struct vcpu_runstate_info *res)
> +{
> +	u64 state_time;
> +	struct vcpu_runstate_info *state;
> +
> +	preempt_disable();
> +
> +	state =3D &__get_cpu_var(runstate);
> +
> +	do {
> +		state_time =3D state->state_entry_time;
> +		barrier();
> +		*res =3D *state;
> +		barrier();
> +	} while(state->state_entry_time !=3D state_time);
> +
> +	preempt_enable();
> +}
> +
> +static void setup_runstate_info(void)
> +{
> +	struct vcpu_register_runstate_memory_area area;
> +
> +	area.addr.v =3D &__get_cpu_var(runstate);
> +
> +	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
> +			       smp_processor_id(), &area))
> +		BUG();
> +
> +	get_runstate_snapshot(&__get_cpu_var(runstate_snapshot));
> +}
> +
> +static void do_stolen_accounting(void)
> +{
> +	struct vcpu_runstate_info state;
> +	struct vcpu_runstate_info *snap;
> +	u64 blocked, runnable, offline, stolen;
> +	cputime_t ticks;
> +
> +	get_runstate_snapshot(&state);
> +
> +	WARN_ON(state.state !=3D RUNSTATE_running);
> +
> +	snap =3D &__get_cpu_var(runstate_snapshot);
> +
> +	/* work out how much time the VCPU has not been runn*ing*  */
> +	blocked =3D state.time[RUNSTATE_blocked] - snap->time[RUNSTATE_blocked];
> +	runnable =3D state.time[RUNSTATE_runnable] - snap->time[RUNSTATE_runnab=
le];
> +	offline =3D state.time[RUNSTATE_offline] - snap->time[RUNSTATE_offline];
> +
> +	*snap =3D state;
> +
> +	/* Add the appropriate number of ticks of stolen time,
> +	   including any left-overs from last time.  Passing NULL to
> +	   account_steal_time accounts the time as stolen. */
> +	stolen =3D runnable + offline + __get_cpu_var(residual_stolen);
> +	ticks =3D 0;
> +	while(stolen >=3D NS_PER_TICK) {
> +		ticks++;
> +		stolen -=3D NS_PER_TICK;
> +	}
> +	__get_cpu_var(residual_stolen) =3D stolen;
> +	account_steal_time(NULL, ticks);
> +
> +	/* Add the appropriate number of ticks of blocked time,
> +	   including any left-overs from last time.  Passing idle to
> +	   account_steal_time accounts the time as idle/wait. */
> +	blocked +=3D __get_cpu_var(residual_blocked);
> +	ticks =3D 0;
> +	while(blocked >=3D NS_PER_TICK) {
> +		ticks++;
> +		blocked -=3D NS_PER_TICK;
> +	}
> +	__get_cpu_var(residual_blocked) =3D blocked;
> +	account_steal_time(idle_task(smp_processor_id()), ticks);
> +}
> +
> +
> +
> +/* Get the CPU speed from Xen */
>  unsigned long xen_cpu_khz(void)
>  {
>  	u64 cpu_khz =3D 1000000ULL << 32;
> @@ -264,6 +359,8 @@ static irqreturn_t xen_timerop_timer_int
>  		ret =3D IRQ_HANDLED;
>  	}
>  =

> +	do_stolen_accounting();
> +
>  	return ret;
>  }
>  =

> @@ -338,6 +435,8 @@ static irqreturn_t xen_vcpuop_timer_inte
>  		ret =3D IRQ_HANDLED;
>  	}
>  =

> +	do_stolen_accounting();
> +
>  	return ret;
>  }
>  =

> @@ -380,6 +479,8 @@ static void xen_setup_timer(int cpu)
>  	evt->cpumask =3D cpumask_of_cpu(cpu);
>  	evt->irq =3D irq;
>  	clockevents_register_device(evt);
> +
> +	setup_runstate_info();
>  =

>  	put_cpu_var(xen_clock_events);
>  }
> =

> =

> ------------------------------------------------------------------------
> =

> Subject: Implement xen_sched_clock
> =

> Implement xen_sched_clock, which returns the number of ns the current
> vcpu has been actually in the running state (vs blocked,
> runnable-but-not-running, or offline) since boot.
> =

> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: john stultz <johnstul@us.ibm.com>
> =

> ---
>  arch/i386/xen/enlighten.c |    2 +-
>  arch/i386/xen/time.c      |   14 ++++++++++++++
>  arch/i386/xen/xen-ops.h   |    1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/xen/enlighten.c
> +++ b/arch/i386/xen/enlighten.c
> @@ -664,7 +664,7 @@ static const struct paravirt_ops xen_par
>  	.set_wallclock =3D xen_set_wallclock,
>  	.get_wallclock =3D xen_get_wallclock,
>  	.get_cpu_khz =3D xen_cpu_khz,
> -	.get_scheduled_cycles =3D native_read_tsc,
> +	.sched_clock =3D xen_sched_clock,
>  =

>  #ifdef CONFIG_X86_LOCAL_APIC
>  	.apic_write =3D paravirt_nop,
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/xen/time.c
> +++ b/arch/i386/xen/time.c
> @@ -16,6 +16,8 @@
>  #define XEN_SHIFT 22
>  #define TIMER_SLOP	100000	/* Xen may fire a timer up to this many ns ear=
ly */
>  #define NS_PER_TICK	(1000000000ll / HZ)
> +
> +static cycle_t xen_clocksource_read(void);
>  =

>  static DEFINE_PER_CPU(struct clock_event_device, xen_clock_events);
>  =

> @@ -120,6 +122,18 @@ static void do_stolen_accounting(void)
>  	account_steal_time(idle_task(smp_processor_id()), ticks);
>  }
>  =

> +/* Xen sched_clock implementation.  Returns the number of RUNNING ns */
> +unsigned long long xen_sched_clock(void)
> +{
> +	struct vcpu_runstate_info state;
> +	cycle_t now =3D xen_clocksource_read();
> +
> +	get_runstate_snapshot(&state);
> +
> +	WARN_ON(state.state !=3D RUNSTATE_running);
> +
> +	return state.time[RUNSTATE_running] + (now - state.state_entry_time);
> +}
>  =

>  =

>  /* Get the CPU speed from Xen */
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/i386/xen/xen-ops.h
> +++ b/arch/i386/xen/xen-ops.h
> @@ -14,6 +14,7 @@ void __init xen_time_init(void);
>  void __init xen_time_init(void);
>  unsigned long xen_get_wallclock(void);
>  int xen_set_wallclock(unsigned long time);
> +unsigned long long xen_sched_clock(void);
>  =

>  void xen_mark_init_mm_pinned(void);
>  =
