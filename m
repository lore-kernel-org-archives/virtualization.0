From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 09:41:58 -0800
Message-ID: <45EEF966.6060902@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	
	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	
	<1173178774.24738.311.camel@localhost.localdomain>	
	<45EDD82F.90204@vmware.com>	
	<1173225182.24738.507.camel@localhost.localdomain>	
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	
	<1173228544.24738.514.camel@localhost.localdomain>	
	<45EE0D10.7070807@vmware.com>	
	<1173230305.24738.529.camel@localhost.localdomain>	
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173256666.24738.576.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: tglx@linutronix.de
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> That's a pure academic exercise. When we are at the point where
> nanoseconds are to coarse - sometimes after we both retired - the
> internal resolution will be femtoseconds or whatever fits.
>
> Again: paravirt should use a common infrastructure for this. Virtual
> clocksource and virtual clockevent devices, which operate on ktime_t and
> not on some artificial clock chip emulation frequency. The backend
> implementation will be still per hypervisor, but we have _ONE_ device
> emulation model, which is exposed to the kernel instead of five.
>   =


Different hypervisors have different time interfaces for good reasons -
mostly because the real hardware is such a mess, and there's no clear
"good" answer.  In other words, for the same reason that the new clock
infrastructure exists.

Xen, for example, uses the tsc as the principle timebase in the
hypervisor interface. A shared memory region is updated from time to
time with the tsc frequency and other parameters, and the guest is
expected to compute the current time in ns by extrapolating using the
current tsc value.  This only works because the hypervisor goes to some
effort to synchronize the tsc between the (real) cpus, but its otherwise
much the same as using the raw tsc.

Other hypervisors may take other approaches, depending on what the real
underlying hardware is and the real requirements.  One could imagine a
hypervisor exposing an hpet mapping, for example, or just having some
kind of completely synthetic time source.

The point is that if we were to build an abstraction layer over all of
these just so that we could have a single clocksource/event
implementation, it would be pretty much equivalent to the existing clock
infrastructure, and would add no value.

I was very pleased when I saw the clocksource/event mechanisms go into
the kernel because it means different hypervisors can have a clock*
implementation to match their own particular time model/interface
without having to clutter up the pv_ops interface, and still have a
well-defined interface to the rest of the kernel's time infrastructure.

I don't think having a clock implementation for each hypervisor is such
a big deal.  The Xen one, for example, is 300 lines of straightforward code.

> Abstractions for the abstractions sake are braindead. There is no real
> reason to implement 128 bit math into that path just to make the virtual
> clockevent device look like real hardware.
>
> The abstraction of clockevents helps you to get rid of hardwired
> hardware assumptions, but you insist on creating them artificially for
> reasons which are beyond my grasp.
>   =


The hypervisor may present abstracted time hardware, but there is real
time hardware under there somewhere, and there are benefits to making
the abstraction as thin as possible.  Xen chooses to express its time
interfaces in ns and so is a good direct match for the Linux time
infrastructure, but it still has to the 128-bit cycles<->ns conversion
*somewhere*, because the underlying hardware is still using cycles.  It
sounds like the VMWare folks have chosen to directly use cycles in order
to avoid that conversion altogether.

> Jeremy spent a couple of hours to get NO_HZ running for Xen yesterday
> instead of writing up lengthy excuses, why it is soooo hard and takes
> sooo much time and the current interface is sooo insufficient.
>   =


Yep, it worked out well.  The only warty thing in there is the asm
128-bit math needed in scale_delta() to convert tsc cycles to ns.  John
Stultz had suggested (on a much earlier incarnation of this code) that
it could be generally useful and could be hoisted to somewhere more
common.  I've included the whole thing below.

    J


--

#include <linux/kernel.h>
#include <linux/interrupt.h>
#include <linux/clocksource.h>
#include <linux/clockchips.h>

#include <asm/xen/hypercall.h>

#include <xen/events.h>
#include <xen/interface/xen.h>
#include <xen/interface/vcpu.h>

#include "xen-ops.h"

#define XEN_SHIFT 22

/* These are perodically updated in shared_info, and then copied here. */
struct shadow_time_info {
	u64 tsc_timestamp;     /* TSC at last update of time vals.  */
	u64 system_timestamp;  /* Time, in nanosecs, since boot.    */
	u32 tsc_to_nsec_mul;
	int tsc_shift;
	u32 version;
};

static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);

/* Xen time at startup */
static s64 startup_offset;

unsigned long xen_cpu_khz(void)
{
	u64 cpu_khz =3D 1000000ULL << 32;
	const struct vcpu_time_info *info =3D
		&HYPERVISOR_shared_info->vcpu_info[0].time;

	do_div(cpu_khz, info->tsc_to_system_mul);
	if (info->tsc_shift < 0)
		cpu_khz <<=3D -info->tsc_shift;
	else
		cpu_khz >>=3D info->tsc_shift;

	return cpu_khz;
}

/*
 * Reads a consistent set of time-base values from Xen, into a shadow data
 * area.
 */
static void get_time_values_from_xen(void)
{
	struct vcpu_time_info   *src;
	struct shadow_time_info *dst;

	src =3D &read_pda(xen.vcpu)->time;
	dst =3D &get_cpu_var(shadow_time);

	do {
		dst->version =3D src->version;
		rmb();
		dst->tsc_timestamp     =3D src->tsc_timestamp;
		dst->system_timestamp  =3D src->system_time;
		dst->tsc_to_nsec_mul   =3D src->tsc_to_system_mul;
		dst->tsc_shift         =3D src->tsc_shift;
		rmb();
	} while ((src->version & 1) | (dst->version ^ src->version));

	put_cpu_var(shadow_time);
}

/*
 * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
 * yielding a 64-bit result.
 */
static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
{
	u64 product;
#ifdef __i386__
	u32 tmp1, tmp2;
#endif

	if (shift < 0)
		delta >>=3D -shift;
	else
		delta <<=3D shift;

#ifdef __i386__
	__asm__ (
		"mul  %5       ; "
		"mov  %4,%%eax ; "
		"mov  %%edx,%4 ; "
		"mul  %5       ; "
		"xor  %5,%5    ; "
		"add  %4,%%eax ; "
		"adc  %5,%%edx ; "
		: "=3DA" (product), "=3Dr" (tmp1), "=3Dr" (tmp2)
		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
#elif __x86_64__
	__asm__ (
		"mul %%rdx ; shrd $32,%%rdx,%%rax"
		: "=3Da" (product) : "0" (delta), "d" ((u64)mul_frac) );
#else
#error implement me!
#endif

	return product;
}

static u64 get_nsec_offset(struct shadow_time_info *shadow)
{
	u64 now, delta;
	rdtscll(now);
	delta =3D now - shadow->tsc_timestamp;
	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
}

static cycle_t xen_clocksource_read(void)
{
	struct shadow_time_info *shadow =3D &get_cpu_var(shadow_time);
	cycle_t ret;

	get_time_values_from_xen();

	ret =3D shadow->system_timestamp + get_nsec_offset(shadow);

	put_cpu_var(shadow_time);

	return ret;
}

static void xen_read_wallclock(struct timespec *ts)
{
	const struct shared_info *s =3D HYPERVISOR_shared_info;
	u32 version;
	u64 delta;
	struct timespec now;

	/* get wallclock at system boot */
	do {
		version =3D s->wc_version;
		rmb();
		now.tv_sec  =3D s->wc_sec;
		now.tv_nsec =3D s->wc_nsec;
		rmb();
	} while ((s->wc_version & 1) | (version ^ s->wc_version));

	delta =3D xen_clocksource_read();	/* time since system boot */
	delta +=3D now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;

	now.tv_nsec =3D do_div(delta, NSEC_PER_SEC);
	now.tv_sec =3D delta;

	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
}

unsigned long xen_get_wallclock(void)
{
	struct timespec ts;

	xen_read_wallclock(&ts);

	return ts.tv_sec;
}

int xen_set_wallclock(unsigned long now)
{
	/* do nothing for domU */
	return -1;
}

static struct clocksource xen_clocksource __read_mostly =3D {
	.name =3D "xen",
	.rating =3D 400,
	.read =3D xen_clocksource_read,
	.mask =3D ~0,
	.mult =3D 1<<XEN_SHIFT,		/* time directly in nanoseconds */
	.shift =3D XEN_SHIFT,
	.flags =3D CLOCK_SOURCE_IS_CONTINUOUS,
};

static void xen_set_mode(enum clock_event_mode mode,
			 struct clock_event_device *evt)
{
	switch(mode) {
	case CLOCK_EVT_MODE_PERIODIC:
		/* unsupported */
		WARN_ON(1);
		break;

	case CLOCK_EVT_MODE_ONESHOT:
		break;

	case CLOCK_EVT_MODE_UNUSED:
	case CLOCK_EVT_MODE_SHUTDOWN:
		HYPERVISOR_set_timer_op(0);  /* cancel timeout */
		break;
	}
}

static int xen_set_next_event(unsigned long delta,
			      struct clock_event_device *evt)
{
	s64 event =3D startup_offset + ktime_to_ns(evt->next_event);

	if (HYPERVISOR_set_timer_op(event) < 0)
		BUG();

	/* We may have missed the deadline, but there's no real way of
	   knowing for sure.  If the event was in the past, then we'll
	   get an immediate interrupt. */

	return 0;
}

static const struct clock_event_device xen_clockevent =3D {
	.name =3D "xen",
	.features =3D CLOCK_EVT_FEAT_ONESHOT,

	.max_delta_ns =3D 0x7fffffff,
	.min_delta_ns =3D 100,	/* ? */

	.mult =3D 1<<XEN_SHIFT,
	.shift =3D XEN_SHIFT,
	.rating =3D 500,

	.set_mode =3D xen_set_mode,
	.set_next_event =3D xen_set_next_event,
};
static DEFINE_PER_CPU(struct clock_event_device, xen_clock_events);

static irqreturn_t xen_timer_interrupt(int irq, void *dev_id)
{
	struct clock_event_device *evt =3D &__get_cpu_var(xen_clock_events);
	irqreturn_t ret;

	ret =3D IRQ_NONE;
	if (evt->event_handler) {
		cycle_t now =3D xen_clocksource_read();
		s64 event =3D startup_offset + ktime_to_ns(evt->next_event);

		/* filter out spurious tick timer events */
		if (now >=3D event)
			evt->event_handler(evt);
		ret =3D IRQ_HANDLED;
	}

	return ret;
}

static void xen_setup_timer(int cpu)
{
	const char *name;
	struct clock_event_device *evt;
	int irq;

	printk(KERN_DEBUG "installing Xen timer for CPU %d\n", cpu);

	name =3D kasprintf(GFP_KERNEL, "timer%d", cpu);
	if (!name)
		name =3D "<timer kasprintf failed>";

	irq =3D bind_virq_to_irqhandler(VIRQ_TIMER, cpu, xen_timer_interrupt,
				      SA_INTERRUPT, name, NULL);

	evt =3D &get_cpu_var(xen_clock_events);
	memcpy(evt, &xen_clockevent, sizeof(*evt));

	evt->cpumask =3D cpumask_of_cpu(cpu);
	evt->irq =3D irq;
	clockevents_register_device(evt);

	put_cpu_var(xen_clock_events);
}

__init void xen_time_init(void)
{
	get_time_values_from_xen();

	clocksource_register(&xen_clocksource);

	/* get offset between hypervisor and kernel monotonic clocks */
	startup_offset =3D xen_clocksource_read() - ktime_to_ns(ktime_get());

	/* Set initial system time with full resolution */
	xen_read_wallclock(&xtime);
	set_normalized_timespec(&wall_to_monotonic,
				-xtime.tv_sec, -xtime.tv_nsec);

	tsc_disable =3D 0;

	xen_setup_timer(0);
}
