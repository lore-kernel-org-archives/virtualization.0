From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Sun, 27 Apr 2014 23:39:23 +0530
Message-ID: <535D47D3.20202__48857.7947406613$1398622425$gmane$org@linux.vnet.ibm.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/17/2014 08:33 PM, Waiman Long wrote:
> v8->v9:
>    - Integrate PeterZ's version of the queue spinlock patch with some
>      modification:
>      http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
>    - Break the more complex patches into smaller ones to ease review effort.
>    - Fix a racing condition in the PV qspinlock code.
>
> v7->v8:
>    - Remove one unneeded atomic operation from the slowpath, thus
>      improving performance.
>    - Simplify some of the codes and add more comments.
>    - Test for X86_FEATURE_HYPERVISOR CPU feature bit to enable/disable
>      unfair lock.
>    - Reduce unfair lock slowpath lock stealing frequency depending
>      on its distance from the queue head.
>    - Add performance data for IvyBridge-EX CPU.
>
> v6->v7:
>    - Remove an atomic operation from the 2-task contending code
>    - Shorten the names of some macros
>    - Make the queue waiter to attempt to steal lock when unfair lock is
>      enabled.
>    - Remove lock holder kick from the PV code and fix a race condition
>    - Run the unfair lock & PV code on overcommitted KVM guests to collect
>      performance data.
>
> v5->v6:
>   - Change the optimized 2-task contending code to make it fairer at the
>     expense of a bit of performance.
>   - Add a patch to support unfair queue spinlock for Xen.
>   - Modify the PV qspinlock code to follow what was done in the PV
>     ticketlock.
>   - Add performance data for the unfair lock as well as the PV
>     support code.
>
> v4->v5:
>   - Move the optimized 2-task contending code to the generic file to
>     enable more architectures to use it without code duplication.
>   - Address some of the style-related comments by PeterZ.
>   - Allow the use of unfair queue spinlock in a real para-virtualized
>     execution environment.
>   - Add para-virtualization support to the qspinlock code by ensuring
>     that the lock holder and queue head stay alive as much as possible.
>
> v3->v4:
>   - Remove debugging code and fix a configuration error
>   - Simplify the qspinlock structure and streamline the code to make it
>     perform a bit better
>   - Add an x86 version of asm/qspinlock.h for holding x86 specific
>     optimization.
>   - Add an optimized x86 code path for 2 contending tasks to improve
>     low contention performance.
>
> v2->v3:
>   - Simplify the code by using numerous mode only without an unfair option.
>   - Use the latest smp_load_acquire()/smp_store_release() barriers.
>   - Move the queue spinlock code to kernel/locking.
>   - Make the use of queue spinlock the default for x86-64 without user
>     configuration.
>   - Additional performance tuning.
>
> v1->v2:
>   - Add some more comments to document what the code does.
>   - Add a numerous CPU mode to support >= 16K CPUs
>   - Add a configuration option to allow lock stealing which can further
>     improve performance in many cases.
>   - Enable wakeup of queue head CPU at unlock time for non-numerous
>     CPU mode.
>
> This patch set has 3 different sections:
>   1) Patches 1-7: Introduces a queue-based spinlock implementation that
>      can replace the default ticket spinlock without increasing the
>      size of the spinlock data structure. As a result, critical kernel
>      data structures that embed spinlock won't increase in size and
>      break data alignments.
>   2) Patches 8-13: Enables the use of unfair queue spinlock in a
>      virtual guest. This can resolve some of the locking related
>      performance issues due to the fact that the next CPU to get the
>      lock may have been scheduled out for a period of time.
>   3) Patches 14-19: Enable qspinlock para-virtualization support
>      by halting the waiting CPUs after spinning for a certain amount of
>      time. The unlock code will detect the a sleeping waiter and wake it
>      up. This is essentially the same logic as the PV ticketlock code.
>
> The queue spinlock has slightly better performance than the ticket
> spinlock in uncontended case. Its performance can be much better
> with moderate to heavy contention.  This patch has the potential of
> improving the performance of all the workloads that have moderate to
> heavy spinlock contention.
>
> The queue spinlock is especially suitable for NUMA machines with at
> least 2 sockets, though noticeable performance benefit probably won't
> show up in machines with less than 4 sockets.
>
> The purpose of this patch set is not to solve any particular spinlock
> contention problems. Those need to be solved by refactoring the code
> to make more efficient use of the lock or finer granularity ones. The
> main purpose is to make the lock contention problems more tolerable
> until someone can spend the time and effort to fix them.

For kvm part feel free to add:
Tested-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

V9 testing has shown no hangs.
I was able to do some performance testing. here are the results:

Overall we are seeing good improvement for pv-unfair version.

System : 32 cpu sandybridge with HT on. (4 node machine with 32 GB each)
Guest: 8GB with 16 vcpu/VM.
Average was taken over 8-10 data points.

Base = 3.15-rc2	with PRAVIRT_SPINLOCK = y
A = 3.15-rc2 + qspinlock v9 patch with QUEUE_SPINLOCK = y 
PRAVIRT_SPINLOCK = y PARAVIRT_UNFAIR_LOCKS = y (unfair lock)
B =  3.15-rc2 + qspinlock v9 patch with QUEUE_SPINLOCK = y 
PRAVIRT_SPINLOCK = n PARAVIRT_UNFAIR_LOCKS = n (queue spinlock without 
paravirt)
C = 3.15-rc2 + qspinlock v9 patch with  QUEUE_SPINLOCK = y 
PRAVIRT_SPINLOCK = y  PARAVIRT_UNFAIR_LOCKS = n (queue spinlock with 
paravirt)


Ebizzy % improvements
========================
overcommit A		B		C
0.5x	4.4265    	2.0611    	1.5824
1.0x	0.9015    	-7.7828   	4.5443
1.5x	46.1162   	-2.9845   	-3.5046
2.0x	99.8150   	-2.7116   	4.7461

Dbench 	%improvements
overcommit A		B		C
0.5x	3.2617    	3.5436    	2.5676
1.0x	0.6302    	2.2342    	5.2201
1.5x	5.0027    	4.8275    	3.8375
2.0x	23.8242   	4.5782    	12.6067

Absolute values of base results: (overcommit, value, stdev)
Ebizzy ( records / sec with 120 sec run)
0.5x 20941.8750 (2%)
1.0x 17623.8750 (5%)
1.5x  5874.7778 (15%)
2.0x  3581.8750 (7%)

Dbench (throughput in MB/sec)
0.5x 10009.6610 (5%)
1.0x  6583.0538 (1%)
1.5x  3991.9622 (4%)
2.0x  2527.0613 (2.5%)
