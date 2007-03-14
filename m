From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Stolen and degraded time and schedulers
Date: Tue, 13 Mar 2007 21:37:59 -0700
Message-ID: <45F77C27.8090604@goop.org>
References: <45F6D1D0.6080905@goop.org>	
	<1173816769.22180.14.camel@localhost>	<45F70A71.9090205@goop.org>
	<1173821224.1416.24.camel@dwalker1> <45F71EA5.2090203@goop.org>
	<45F74515.7010808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F74515.7010808@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Dan Hecht <dhecht@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, dwalker@mvista.com, john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, cpufreq@lists.linux.org.uk, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> With your previous definition of work time, would it be that:
>
> monotonic_time =3D=3D work_time + stolen_time ??

(By monotonic time, I presume you mean monotonic real time.)  Yes, I
suppose you could, but I don't think that's terribly useful.   I think
work_time is probably most naturally measured in cpu clock cycles rather
than an actual time unit.  You could convert it to ns, but I don't see
the point.

I know its a term in general use, but I don't think the term "stolen
time" is all that useful, particularly when we're talking about a more
general notion of cpu work contributing to the progress of process
execution.  In the cpufreq case, time isn't "stolen" per se.

(I guess I don't like the term stolen time because you don't refer to
time spent on other processes as being stolen from your process: its
just processor time being distributed.)

> i.e. would you be defining stolen_time to include the time lost to
> processes due to the cpu running at a lower frequency?  How does this
> play into the other potential users, besides sched_clock(), of stolen
> time?  We should make sure that the abstraction introduced here makes
> sense in those places too.

Be specific.  What other uses are there?

> For example, the stuff that happens in update_process_times().  I
> think we'd want to account the stolen time to cpustat->steal.

I guess we could do something for that.  Would we account non-full-speed
cpus to it?  Maybe?

How is cpustat->steal used?  How does it get out to usermode?


>   Also we'd probably want account for stolen time with regards to
> task_running_tick().  (Though, in the latter case, maybe we first have
> to move the scheduler away from assuming HZ rate decrementing of
> p->time_slice to get this right. i.e. remove the tick based assumption
> from the scheduler, and then maybe stolen time falls in more naturally
> when accounting time slices).

I think the important part is that sched_clock() be used to actually
compute how much time each process gets.  The fact that a time quantum
gets stolen is less important.  Or do you mean something else?

> I guess taking your cpufreq as an example of work_time progressing
> slower than monotonic_time (and assuming that the remaining time is
> what you would call stolen), then e.g. top would report 50% of your
> cpu stolen when you cpu is running at 1/2 max rate.

Yes.  In the same way that clock modulation gates the cpu clock, the
hypervisor effectively gates the clock by giving time to other vcpus.

> And p->time_slice would decrement at 1/2 the rate it normally did when
> running at 1/2 speed.  Is this the right thing to do?  If so, then I
> agree it makes sense to model hypervisor stolen time in terms of your
> "work time".

Yes, that's my thought.

>   But, if not, then maybe the amount of work you can get done during a
> period of time that is not stolen and the stolen time itself are
> really two different notions, and shouldn't be confused.  I can see
> arguments both ways. =


It seems to me like a nice opportunity to solve two problems with one
mechanism.

    J
