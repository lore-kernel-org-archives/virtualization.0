From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Tue, 13 Mar 2007 13:32:49 -0700
Message-ID: <45F70A71.9090205@goop.org>
References: <45F6D1D0.6080905@goop.org> <1173816769.22180.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173816769.22180.14.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: john stultz <johnstul@us.ibm.com>
Cc: Daniel Walker <dwalker@mvista.com>, cpufreq@lists.linux.org.uk, Con Kolivas <kernel@kolivas.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

john stultz wrote:
> My gut reaction would be to avoid using clocksources for now. While
> there is some thought going into how to expand clocksources for other
> uses (Daniel is working on this, for example), the design for
> clocksources has been very focused on its utility to timekeeping, so I'm
> hesitant to try complicate the clocksources in order to multiplex
> functionality until what is really needed is well understood.
>   =


Yes, you could imagine adding it as a clocksource variant, by allowing a
clocksource to set a particular timebase:

enum clocksource_timebase {
	CLOCK_TIMEBASE_REALTIME,
	CLOCK_TIMEBASE_CPU_WORK,
	...
};

struct clocksource {
	enum clocksource_timebase timebase;
	...
}

Most of the existing clocksource infrastructure would only operate on
CLOCK_TIMEBASE_REALTIME clocksources, so I'm not sure how much overlap
there would be here.  In the case of dealing with cpufreq, there's a
certain appeal to manipulating the shift/mult parameters to reflect the
fractional speed of a cpu as it changes.

> I suspect the best approach would be see how the sched_clock interface
> can be reworked/used for what you want, as it's design goals map closest
> to the work-unit properties you list above.
>   =


sched_clock would definitely be the interface which exposes all this
stuff to the rest of the kernel.  After all, its basically a very simple
interface, though the backend implementation details may not be.

We currently have a sched_clock interface in paravirt_ops to deal with
the hypervisor aspect.  It only occurred to me this morning that cpufreq
presents exactly the same problem to the rest of the kernel, and so
there's room for a more general solution.

    J
