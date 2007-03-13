From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Tue, 13 Mar 2007 14:59:01 -0700
Message-ID: <45F71EA5.2090203@goop.org>
References: <45F6D1D0.6080905@goop.org>	 <1173816769.22180.14.camel@localhost>
	<45F70A71.9090205@goop.org> <1173821224.1416.24.camel@dwalker1>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173821224.1416.24.camel@dwalker1>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: dwalker@mvista.com
Cc: cpufreq@lists.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Daniel Walker wrote:
> The frequency tracking you mention is done to some extent inside the
> timekeeping adjustment functions, but I'm not sure it's totally accurate
> for non-timekeeping, and it also tracks things like interrupt latency.
> Tracking frequency changes where it's important to get it right
> shouldn't be done I think ..
>
> If you want accurate time accounting, don't use the TSC .
>   =


I'm not sure I follow you here.  Clocksources have the means to adjust
the rate of time progression, mostly to warp the time for things like
ntp.  The stability or otherwise of the tsc is irrelevant.

If you had a clocksource which was explicitly using the rate at which a
CPU does work as a timebase, then using the same warping mechanism would
allow you to model CPU speed changes.

> The sched_clock interface is basically a stripped down clocksource..
> I've implemented sched_clock as a clocksource in the past ..
>   =


Yes, that works.  But a clocksource is strictly about measuring the
progression of real time, and so doesn't generally measure how much work
a CPU has done.

>> We currently have a sched_clock interface in paravirt_ops to deal with
>> the hypervisor aspect.  It only occurred to me this morning that cpufreq
>> presents exactly the same problem to the rest of the kernel, and so
>> there's room for a more general solution.
>>     =

>
> Are there other architecture which have this per-cpu clock frequency
> changing issue? I worked with several other architectures beyond just
> x86 and haven't seen this issue ..

Well, lots of cpus have dynamic frequencies.  Any scheduler which
maintains history will suffer the same problem, even on UP.  If
processes A and B are supposed to have the same priority and they both
execute for 1ms of real time, did they make the same amount of
progress?  Not if the cpu changed speed in between.

And any system which commonly runs virtualized (s390, power, etc) will
need to deal with the notion of stolen time.

    J
