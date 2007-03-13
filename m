From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Stolen and degraded time and schedulers
Date: Tue, 13 Mar 2007 14:27:04 -0700
Message-ID: <1173821224.1416.24.camel@dwalker1>
References: <45F6D1D0.6080905@goop.org>
	<1173816769.22180.14.camel@localhost>  <45F70A71.9090205@goop.org>
Reply-To: dwalker@mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F70A71.9090205@goop.org>
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
Cc: cpufreq@lists.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-03-13 at 13:32 -0700, Jeremy Fitzhardinge wrote:

> Most of the existing clocksource infrastructure would only operate on
> CLOCK_TIMEBASE_REALTIME clocksources, so I'm not sure how much overlap
> there would be here.  In the case of dealing with cpufreq, there's a
> certain appeal to manipulating the shift/mult parameters to reflect the
> fractional speed of a cpu as it changes.

The frequency tracking you mention is done to some extent inside the
timekeeping adjustment functions, but I'm not sure it's totally accurate
for non-timekeeping, and it also tracks things like interrupt latency.
Tracking frequency changes where it's important to get it right
shouldn't be done I think ..

If you want accurate time accounting, don't use the TSC .

> sched_clock would definitely be the interface which exposes all this
> stuff to the rest of the kernel.  After all, its basically a very simple
> interface, though the backend implementation details may not be.

The sched_clock interface is basically a stripped down clocksource..
I've implemented sched_clock as a clocksource in the past ..

> We currently have a sched_clock interface in paravirt_ops to deal with
> the hypervisor aspect.  It only occurred to me this morning that cpufreq
> presents exactly the same problem to the rest of the kernel, and so
> there's room for a more general solution.

Are there other architecture which have this per-cpu clock frequency
changing issue? I worked with several other architectures beyond just
x86 and haven't seen this issue ..

Daniel
