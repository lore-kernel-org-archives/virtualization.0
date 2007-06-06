From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 10:39:02 +0200
Message-ID: <46668EC6.76E4.0078.0@novell.com>
References: <20070522140941.802382212@goop.org>
	<20070522141252.030961467@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070522141252.030961467@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

>+cycle_t xen_clocksource_read(void)
>+{
>+	struct shadow_time_info *shadow =3D &get_cpu_var(shadow_time);
>+	cycle_t ret;
>+
>+	get_time_values_from_xen();
>+
>+	ret =3D shadow->system_timestamp + get_nsec_offset(shadow);
>+
>+	put_cpu_var(shadow_time);
>+
>+	return ret;
>+}

I'm afraid this mechanism is pretty unreliable on SMP: getnstimeofday() =
and
do_gettimeofday() both use the difference between the last snapshot taken
and the current value read from the clock source. Since I had added this
clocksource code to our kernel, I had reproducible hangs on one of the
systems I regularly work with (you may have seen the respective thread
on xen-devel), which recently I finally found time to look into. The issue =
is
that on that system, transition into ACPI mode takes over 600ms (SMM
execution, and hence no interrupts delivered during that time), and with
Xen using the PIT (PM timer support was added by Keir as a result of this,
but that doesn't cure the problem here, it just reduces the likelihood =
it'll
be encountered) platform time and local time got pretty much out of sync.

Xen itself knows to deal with this (by using an error correction factor to
slow down the local [TSC-based] clock), but for the kernel such a =
situation
may be fatal: If clocksource->cycle_last was most recently set on a CPU
with shadow->tsc_to_nsec_mul sufficiently different from that where
getnstimeofday() is being used, timekeeping.c's __get_nsec_offset() will
calculate a huge nanosecond value (due to cyc2ns() doing unsigned
operations), worth abut 4000s. This value may then be used to set a
timeout that was intended to be a few milliseconds, effectively yielding
a hung app (and perhaps system).

I'm sure the time keeping code can't deal with negative values returned
from __get_nsec_offset() (timespec_add_ns() is an example, used in
__get_realtime_clock_ts()), otherwise a potential solution might have
been to set the clock source's multiplier and shift to one and zero
respectively. But I think that a clock source can be expected to be
monotonic anyway, which Xen's interpolation mechanism doesn't
guarantee across multiple CPUs. (I'm actually beginning to think that
this might also be the reason for certain test suites occasionally =
reporting
timeouts to fire early.)

Unfortunately so far I haven't been able to think of a reasonable solution
to this - a simplistic approach like making xen_clocksource_read() check
the value it is about to return against the last value it returned doesn't
seem to be a good idea (time might appear to have stopped over some
period of time otherwise), nor does attempting to adjust the shadowed
tsc_to_nsec_mul values (because the kernel can't know whether it should
boost the lagging CPU or throttle the rushing one).

Jan
