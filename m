From: Alok Kataria <akataria@vmware.com>
Subject: Process accounting in interrupt diabled cases
Date: Fri, 06 Mar 2009 15:03:35 -0800
Message-ID: <1236380615.4637.67.camel__20951.1692556136$1236380852$gmane$org@alok-dev1>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: schwidefsky@de.ibm.com, virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I am not sure, but I think this may be a process accounting bug.

If interrupts are disabled for a considerable amount of time ( say
multiple ticks), the process accounting code will still account a single
tick for such cases, on the next interrupt tick.
Shouldn't we have some way to fix that case like we do for NO_HZ
restart_sched_tick case, where we account for multiple idle ticks.
 
IOW, doesn't process accounting need to account for these cases when
interrupts are disabled for more than one tick period?

I stumbled across this while trying to find a solution to figure out the
amount of stolen time from Linux, when it is running under a hypervisor.
One of the solutions could be to ask the hypervisor directly for this
info, but in my quest to find a generic solution I think the below would
work too.
The total process time accounted by the system on a cpu ( system, idle,
wait and etc) when deducted from the amount TSC counter has advanced
since boot, should give us this info about the cputime stolen from the
kernel  (by either hypervisor or other cases like say, SMI) on a
particular CPU. 
i.e. PCPU_STOLEN = (TSC since boot)  - (PCPU-idle + system + wait + ...)

But for this to work the above problem about process accounting in
interrupt disabled cases need to work correctly. 

Let me know if I overlooking any case where the above assumption might
not hold true.

Thanks,
Alok
