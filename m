From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] implement vcpu preempted check
Date: Tue, 28 Jun 2016 10:43:07 -0400
Message-ID: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org
Cc: dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, peterz@infradead.org, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, waiman.long@hpe.com, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, schwidefsky@de.ibm.com, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

change fomr v1:
	a simplier definition of default vcpu_is_preempted
	skip mahcine type check on ppc, and add config. remove dedicated macro.
	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner. 
	add more comments
	thanks boqun and Peter's suggestion.

This patch set aims to fix lock holder preemption issues.

test-case:
perf record -a perf bench sched messaging -g 400 -p && perf report

18.09%  sched-messaging  [kernel.vmlinux]  [k] osq_lock
12.28%  sched-messaging  [kernel.vmlinux]  [k] rwsem_spin_on_owner
 5.27%  sched-messaging  [kernel.vmlinux]  [k] mutex_unlock
 3.89%  sched-messaging  [kernel.vmlinux]  [k] wait_consider_task
 3.64%  sched-messaging  [kernel.vmlinux]  [k] _raw_write_lock_irq
 3.41%  sched-messaging  [kernel.vmlinux]  [k] mutex_spin_on_owner.is
 2.49%  sched-messaging  [kernel.vmlinux]  [k] system_call

We introduce interface bool vcpu_is_preempted(int cpu) and use it in some spin
loops of osq_lock, rwsem_spin_on_owner and mutex_spin_on_owner.
These spin_on_onwer variant also cause rcu stall before we apply this patch set

Pan Xinhui (4):
  kernel/sched: introduce vcpu preempted check interface
  powerpc/spinlock: support vcpu preempted check
  locking/osq: Drop the overload of osq_lock()
  kernel/locking: Drop the overload of {mutex,rwsem}_spin_on_owner

 arch/powerpc/include/asm/spinlock.h | 18 ++++++++++++++++++
 include/linux/sched.h               | 12 ++++++++++++
 kernel/locking/mutex.c              | 15 +++++++++++++--
 kernel/locking/osq_lock.c           | 10 +++++++++-
 kernel/locking/rwsem-xadd.c         | 16 +++++++++++++---
 5 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.4.11
