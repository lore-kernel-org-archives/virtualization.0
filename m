From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/4] Introduce a new fields "gtime" and "cgtime" in
	task_struct and signal_struct
Date: Wed, 5 Aug 2009 08:59:19 +0200
Message-ID: <20090805065919.GA6305__11979.2988793508$1249455644$gmane$org@elte.hu>
References: <46C99392.3050205@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46C99392.3050205@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>, Jeremy Fitzhardinge <jeremy@goop.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin Schwidefsky <schwidefsky@de.ibm.c>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Laurent Vivier <Laurent.Vivier@bull.net> wrote:

> [PATCH 2/4] like for cpustat, introduce the "gtime" (guest time of 
> the task) and "cgtime" (guest time of the task children) fields 
> for the tasks. Modify signal_struct and task_struct. Modify 
> /proc/<pid>/stat to display these new fields.

> --- kvm.orig/include/linux/sched.h	2007-08-20 11:11:30.000000000 +0200
> +++ kvm/include/linux/sched.h	2007-08-20 13:00:02.000000000 +0200
> @@ -515,6 +515,10 @@ struct signal_struct {
>  	 * in __exit_signal, except for the group leader.
>  	 */
>  	cputime_t utime, stime, cutime, cstime;
> +#ifdef CONFIG_GUEST_ACCOUNTING
> +	cputime_t gtime;
> +	cputime_t cgtime;
> +#endif

A handful of general (and less general) observations about these 
patches:

 1- The code is very ugly due to being an #ifdef fest. Please
    always try to avoid them.

 2- cputime_t is very coarse on x86: measured in jiffies. This means
    that with a default HZ of 250 we'll have units of 4 msecs. 
    That's almost useless to rely on in new instrumentation: an irq 
    can come in and out without accounting noticing it, etc. If we 
    do some new statistics then it should be a lot better than 
    jiffies granular.

 3- stime of vcpu tasks/threads already approximates 'guest time' 
    adequately. (as Jeremy observed it as well) Yes, it mixes 'true 
    guest mode' and 'host mode' system time, but then again due to 
    the jiffies granularity we have a _far_ bigger skew going on 
    already.

 4- namespace collision: 'gtime' is already used as 'group time' in 
    a few places. One of the two things needs to be renamed.

 5- tracepoints and perfcounters could be used to measure guest time 
    precisely, in a low-overhead mode.

These issues need to be addressed in a meaningful way. #2 probably 
means a revamping of cputime_t handling on x86 - of not just the 
gtime. But #3 is worth keeping in mind as well.

I think #5 is the most capable solution by a wide margin - we need 
just a single tracepoint to emit 'nsecs spent in guest mode' 
information and that's it. It would be a far smaller patch.

The tracepoint might even sample the guest RIP and hence could be 
used as a VM-exit profiler and 'perf record -e kvm:vm_exit + perf 
report' could be used to examine/profile/trace guest exit reasons.

	Ingo
