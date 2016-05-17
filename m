From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v3 0/6] powerpc use pv-qpsinlock instead of spinlock
Date: Tue, 17 May 2016 15:49:41 +0800
Message-ID: <1463471387-5115-1-git-send-email-xinhui.pan__16976.8732660033$1463506575$gmane$org@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Cc: mnipxh@163.com, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, waiman.long@hpe.com, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

change fome v1:
	separate into 6 pathes from one patch
	some minor code changes.

benchmark test results are below.
run 3 tests on pseries IBM,8408-E8E with 32cpus, 64GB memory
perf bench futex hash
perf bench futex lock-pi
perf record -advRT || perf bench sched messaging -g 1000 || perf report

summary:
_____test________________spinlcok______________pv-qspinlcok_____
|futex hash	|	556370 ops	|	629634 ops	|
|futex lock-pi	|	362 ops		|	367 ops		|
|workloads	|	23%		|	13%		|

details:

spinlock:
test 1)
# Running futex/hash benchmark...
Run summary [PID 9962]: 32 threads, each operating on 1024 [private] futexes for 10 secs.
Averaged 556370 operations/sec (+- 0.61%), total secs = 10

test 2)
# Running futex/lock-pi benchmark...
Run summary [PID 9962]: 32 threads doing pi lock/unlock pairing for 10 secs.
Averaged 362 operations/sec (+- 0.00%), total secs = 10

test 3)
perf bench sched messaging -g 1000
perf record -avdRT and perf report
# Samples: 2M of event 'cycles:ppp'
# Event count (approx.): 2045582241213
#
# Overhead  Command          Shared Object        Symbol
# ........  ...............  ...................  ........................................................
#
    22.96%  sched-messaging  [kernel.kallsyms]    [k] _raw_spin_lock_irqsave
    19.76%  sched-messaging  [kernel.kallsyms]    [k] __spin_yield
     2.09%  sched-messaging  [kernel.kallsyms]    [k] __slab_free
     2.07%  sched-messaging  [kernel.kallsyms]    [k] unix_stream_read_generic


pv-qspinlock:

test 1)
# Running futex/hash benchmark...
Run summary [PID 3219]: 32 threads, each operating on 1024 [private] futexes for 10 secs.
Averaged 629634 operations/sec (+- 0.38%), total secs = 10

test 2)
# Running futex/lock-pi benchmark...
Run summary [PID 3219]: 32 threads doing pi lock/unlock pairing for 10 secs.
Averaged 367 operations/sec (+- 0.00%), total secs = 10

test 3)
perf bench sched messaging -g 1000
perf record -avdRT and perf report
# Samples: 1M of event 'cycles:ppp'
# Event count (approx.): 1250040606393
#
# Overhead  Command          Shared Object                   Symbol
# ........  ...............  ..............................  ........................................................
#
     9.87%  sched-messaging  [kernel.vmlinux]                [k] __pv_queued_spin_lock_slowpath
     3.66%  sched-messaging  [kernel.vmlinux]                [k] __pv_queued_spin_unlock
     3.37%  sched-messaging  [kernel.vmlinux]                [k] __slab_free
     3.06%  sched-messaging  [kernel.vmlinux]                [k] unix_stream_read_generic


Pan Xinhui (6):
  qspinlock: powerpc support qspinlock
  powerpc: pseries/Kconfig: qspinlock build config
  powerpc: lib/locks.c: cpu yield/wake helper function
  pv-qspinlock: powerpc support pv-qspinlock
  pv-qspinlock: use cmpxchg_release in __pv_queued_spin_unlock
  powerpc: pseries: pv-qspinlock build config/make

 arch/powerpc/include/asm/qspinlock.h               | 39 +++++++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      | 38 +++++++++++++++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h | 13 +++++++
 arch/powerpc/include/asm/spinlock.h                | 31 +++++++++------
 arch/powerpc/include/asm/spinlock_types.h          |  4 ++
 arch/powerpc/kernel/Makefile                       |  1 +
 arch/powerpc/kernel/paravirt.c                     | 44 ++++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 36 ++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig             |  9 +++++
 arch/powerpc/platforms/pseries/setup.c             |  5 +++
 kernel/locking/qspinlock_paravirt.h                |  2 +-
 11 files changed, 209 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
1.9.1
