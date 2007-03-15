From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Thu, 15 Mar 2007 12:33:47 -0700
Message-ID: <45F99F9B.40806@goop.org>
References: <45F6D1D0.6080905@goop.org>	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>	<1173821224.1416.24.camel@dwalker1>	<45F71EA5.2090203@goop.org>	<45F74515.7010808@vmware.com>	<45F77C27.8090604@goop.org>	<45F846AB.6060200@vmware.com>	<45F84E39.7030507@goop.org> <17912.55404.556847.350399@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933176AbXCOTd7@vger.kernel.org>
In-Reply-To: <17912.55404.556847.350399@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Dan Hecht <dhecht@vmware.com>, dwalker@mvista.com, cpufreq@lists.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, schwidefsky@de.ibm.com, Rik van Riel <riel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Paul Mackerras wrote:
> A cycle on one thread of a machine with SMT/hyperthreading when the
> other thread is idle *isn't* equivalent to a cycle when the other
> thread is busy.  We run into this on POWER5, where we have hardware
> that counts cycles when each of the two threads in each core gets to
> dispatch instructions (on each cycle, one thread or the other gets to
> dispatch).  That helps but still doesn't give a totally accurate
> estimate of how much computation a given process has managed to do.
>   

Yes, but it doesn't need to be 100% accurate to be useful; it just needs
to better characterize the amount of work done.  You could get a better
approximation by using two scaling factors: work done with other thread
idle, and work done when other thread busy.

>> I often nice my kernel builds
>> (which cpufreq takes as a hint to not ramp up the cpu speed) on my
>> laptop so to save power.
>>     
>
> Just as a side note - that's probably actually a bad strategy; you
> almost certainly consume less total energy by running the cpu at full
> speed until the build is done and then going to the deepest sleep mode
> you can achieve.
>   

It seems to me that a 5min build at 1/4 power is better than running for
2.5min at full power - voltage scaling gives you n^2 power use scaling,
remember.  Not that I've measured it or anything.

> What was the original proposal?  I came into this discussion late...
>   

My core proposal is basically that sched_clock() should try to return a
time which scales with the amount of work done by a CPU rather than
measure real time.  This helps solve two problems:

    * it accounts for time stolen by a hypervisor, since a stolen CPU
      does no work
    * it accounts for cpus running a lower operating points, since they
      do less work per unit time

You could also use it to take into account time stolen by interrupts,
SMM, thermal limiting and so on.  The idea is that processes shouldn't
get penalized for CPU time that they had no opportunity to use.

This is almost completely compatible with how sched_clock() is currently
used, except that the scheduler also uses it to measure sleeping time. 
This doesn't make much sense in my proposal because sched_clock() is an
inherently per-CPU time measure, and sleeping doesn't involve any CPU by
definition.  It also doesn't make much sense to say that a process slept
for less time simply because it wasn't using the CPU while it was being
stolen/running slowly.

Despite this, it works better than expected because the current
scheduler adjusts the sched_clock-derived process timestamps as they
move between runqueues, so they never get too far out of whack.

I've implemented sched_clock to only count non-stolen CPU nanoseconds in
the Xen-paravirt_ops implementation; we'll see how it works out.

    J
