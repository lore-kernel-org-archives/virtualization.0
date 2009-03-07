From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Process accounting in interrupt diabled cases
Date: Fri, 06 Mar 2009 16:37:37 -0800
Message-ID: <49B1C1D1.4070603@goop.org>
References: <1236380615.4637.67.camel@alok-dev1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1236380615.4637.67.camel@alok-dev1>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Alok Kataria wrote:
> Hi,
>
> I am not sure, but I think this may be a process accounting bug.
>
> If interrupts are disabled for a considerable amount of time ( say
> multiple ticks), the process accounting code will still account a single
> tick for such cases, on the next interrupt tick.
> Shouldn't we have some way to fix that case like we do for NO_HZ
> restart_sched_tick case, where we account for multiple idle ticks.
>  
> IOW, doesn't process accounting need to account for these cases when
> interrupts are disabled for more than one tick period?
>   

Why are interrupts being disabled for so long?  If its happening often 
enough to upset process accounting, then surely the fix is to not 
disable interrupts for such a long time?

> I stumbled across this while trying to find a solution to figure out the
> amount of stolen time from Linux, when it is running under a hypervisor.
> One of the solutions could be to ask the hypervisor directly for this
> info, but in my quest to find a generic solution I think the below would
> work too.
> The total process time accounted by the system on a cpu ( system, idle,
> wait and etc) when deducted from the amount TSC counter has advanced
> since boot, should give us this info about the cputime stolen from the
> kernel

You're assuming that the tsc is always going to be advancing at a 
constant rate in wallclock time?  Is that a good assumption?  Does 
VMWare virtualize the tsc to make this valid?  If something's going to 
the effort of virtualizing tsc, how do you know they're not also 
excluding stolen time?  Is the tsc guaranteed to be synchronized across 
cpus?

>   (by either hypervisor or other cases like say, SMI)

(In the past I've argued that stolen time is not a binary property; your 
time can be "stolen" when you're running on a slow CPU, as well as 
explicit behind-the-scenes context switching, which could well be worth 
accounting for.)

>  on a
> particular CPU. 
> i.e. PCPU_STOLEN = (TSC since boot)  - (PCPU-idle + system + wait + ...)
>   

What timebase is the kernel using to measure idle, system, wait, ...?  
Presumably something that doesn't include stolen time.  In that case 
this just comes down to "PCPU_STOLEN = TOTAL_TIME - PCPU_UNSTOLEN_TIME", 
where you're proposing that TOTAL_TIME is the tsc.

Direct use of the tsc definitely doesn't work in a Xen PV guest because 
the tsc is the raw physical cpu tsc; but Xen also provides everything 
you need to derive a globally-meaningful timebase from the tsc.  Xen 
also provides per-vcpu info on time spent blocked, runnable (ie, could 
run but no pcpu available), running and offline.

    J
