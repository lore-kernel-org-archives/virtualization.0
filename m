From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v8 0/6] Implement qspinlock/pv-qspinlock on ppc
Date: Mon,  5 Dec 2016 10:19:20 -0500
Message-ID: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
To: linux-kernel@vger.kernel.org
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Hi All,
  this is the fairlock patchset. You can apply them and build successfully.
patches are based on linux-next
  qspinlock can avoid waiter starved issue. It has about the same speed in
single-thread and it can be much faster in high contention situations
especially when the spinlock is embedded within the data structure to be
protected.

v7 -> v8:
	add one patch to drop a function call under native qspinlock unlock.
	Enabling qspinlock or not is a complier option now.
	rebase onto linux-next(4.9-rc7)
v6 -> v7:
	rebase onto 4.8-rc4
v1 -> v6:
	too many details. snip. 

some benchmark result below

perf bench
these numbers are ops per sec, So the higher the better.
*******************************************
on pSeries with 32 vcpus, 32Gb memory, pHyp.
------------------------------------------------------------------------------------
	test case		| pv-qspinlock  |  qspinlock 	| current-spinlock
------------------------------------------------------------------------------------
futex hash			| 618572	| 552332	| 553788
futex lock-pi			| 364		| 364		| 364
sched pipe			| 78984		| 76060		| 81454
------------------------------------------------------------------------------------

unix bench:
these numbers are scores, So the higher the better.
************************************************
on PowerNV with 16 cores(cpus) (smt off), 32Gb memory:
-------------
pv-qspinlock and qspinlock have very similar results because pv-qspinlock use native version
which is only having one callback overhead
------------------------------------------------------------------------------------
	test case		| pv-qspinlock and qspinlock | current-spinlock
------------------------------------------------------------------------------------
Execl Throughput                               761.1             761.4
File Copy 1024 bufsize 2000 maxblocks         1259.8            1286.6
File Copy 256 bufsize 500 maxblocks            782.2             790.3
File Copy 4096 bufsize 8000 maxblocks         2741.5            2817.4
Pipe Throughput                               1063.2            1036.7
Pipe-based Context Switching                   284.7             281.1
Process Creation                               679.6             649.1
Shell Scripts (1 concurrent)                  1933.2            1922.9
Shell Scripts (8 concurrent)                  5003.3            4899.8
System Call Overhead                           900.6             896.8
                                             ==========================
System Benchmarks Index Score                 1139.3 	 	 1133.0
--------------------------------------------------------------------------- ---------

*******************************************
on pSeries with 32 vcpus, 32Gb memory, pHyp.
------------------------------------------------------------------------------------
	test case		|	pv-qspinlock |	qspinlock | current-spinlock
------------------------------------------------------------------------------------
Execl Throughput                             877.1         891.2         872.8
File Copy 1024 bufsize 2000 maxblocks       1390.4        1399.2        1395.0
File Copy 256 bufsize 500 maxblocks          882.4         889.5         881.8
File Copy 4096 bufsize 8000 maxblocks       3112.3        3113.4        3121.7
Pipe Throughput                             1095.8        1162.6        1158.5
Pipe-based Context Switching                 194.9         192.7         200.7
Process Creation                             518.4         526.4         509.1
Shell Scripts (1 concurrent)                1401.9        1413.9        1402.2
Shell Scripts (8 concurrent)                3215.6        3246.6        3229.1
System Call Overhead                         833.2         892.4         888.1
                                          ====================================
System Benchmarks Index Score               1033.7        1052.5        1047.8
------------------------------------------------------------------------------------

******************************************
on pSeries with 32 vcpus, 16Gb memory, KVM.
------------------------------------------------------------------------------------
	test case		|	pv-qspinlock |	qspinlock | current-spinlock
------------------------------------------------------------------------------------
Execl Throughput                             497.4        518.7         497.8
File Copy 1024 bufsize 2000 maxblocks       1368.8       1390.1        1343.3
File Copy 256 bufsize 500 maxblocks          857.7        859.8         831.4
File Copy 4096 bufsize 8000 maxblocks       2851.7       2838.1        2785.5
Pipe Throughput                             1221.9       1265.3        1250.4
Pipe-based Context Switching                 529.8        578.1         564.2
Process Creation                             408.4        421.6         287.6
Shell Scripts (1 concurrent)                1201.8       1215.3        1185.8
Shell Scripts (8 concurrent)                3758.4       3799.3        3878.9
System Call Overhead                        1008.3       1122.6        1134.2
                                          =====================================
System Benchmarks Index Score               1072.0       1108.9        1050.6
------------------------------------------------------------------------------------

Pan Xinhui (6):
  powerpc/qspinlock: powerpc support qspinlock
  powerpc: pSeries/Kconfig: Add qspinlock build config
  powerpc: lib/locks.c: Add cpu yield/wake helper function
  powerpc/pv-qspinlock: powerpc support pv-qspinlock
  powerpc: pSeries: Add pv-qspinlock build config/make
  powerpc/pv-qspinlock: Optimise native unlock path

 arch/powerpc/include/asm/qspinlock.h               |  93 ++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h      |  52 +++++++
 .../powerpc/include/asm/qspinlock_paravirt_types.h |  13 ++
 arch/powerpc/include/asm/spinlock.h                |  35 +++--
 arch/powerpc/include/asm/spinlock_types.h          |   4 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/paravirt.c                     | 157 +++++++++++++++++++++
 arch/powerpc/lib/locks.c                           | 122 ++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig             |  16 +++
 arch/powerpc/platforms/pseries/setup.c             |   5 +
 10 files changed, 485 insertions(+), 13 deletions(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt_types.h
 create mode 100644 arch/powerpc/kernel/paravirt.c

-- 
2.4.11
