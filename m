From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 11/11] qspinlock, kvm: Add paravirt support
Date: Sun, 15 Jun 2014 14:47:08 +0200
Message-ID: <20140615130154.400698797__15546.9933095903$1402838025$gmane$org@chello.nl>
References: <20140615124657.264658593@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=peterz-qspinlock-kvm.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/kvm.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/Kconfig.locks  |    2 -
 2 files changed, 59 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/kvm.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/kvm.c
+++ linux-2.6/arch/x86/kernel/kvm.c
@@ -569,6 +569,7 @@ static void kvm_kick_cpu(int cpu)
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
 }
 
+#ifndef CONFIG_QUEUE_SPINLOCK
 enum kvm_contention_stat {
 	TAKEN_SLOW,
 	TAKEN_SLOW_PICKUP,
@@ -796,6 +797,51 @@ static void kvm_unlock_kick(struct arch_
 		}
 	}
 }
+#else /* QUEUE_SPINLOCK */
+
+#include <asm-generic/qspinlock.h>
+
+PV_CALLEE_SAVE_REGS_THUNK(__pv_init_node);
+PV_CALLEE_SAVE_REGS_THUNK(__pv_link_and_wait_node);
+PV_CALLEE_SAVE_REGS_THUNK(__pv_kick_node);
+
+PV_CALLEE_SAVE_REGS_THUNK(__pv_wait_head);
+PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_unlock);
+
+void kvm_wait(int *ptr, int val)
+{
+	unsigned long flags;
+
+	if (in_nmi())
+		return;
+
+	/*
+	 * Make sure an interrupt handler can't upset things in a
+	 * partially setup state.
+	 */
+	local_irq_save(flags);
+
+	/*
+	 * check again make sure it didn't become free while
+	 * we weren't looking.
+	 */
+	if (ACCESS_ONCE(*ptr) != val)
+		goto out;
+
+	/*
+	 * halt until it's our turn and kicked. Note that we do safe halt
+	 * for irq enabled case to avoid hang when lock info is overwritten
+	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
+	 */
+	if (arch_irqs_disabled_flags(flags))
+		halt();
+	else
+		safe_halt();
+
+out:
+	local_irq_restore(flags);
+}
+#endif /* QUEUE_SPINLOCK */
 
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
@@ -808,8 +854,20 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
+#ifdef CONFIG_QUEUE_SPINLOCK
+	pv_lock_ops.init_node = PV_CALLEE_SAVE(__pv_init_node);
+	pv_lock_ops.link_and_wait_node = PV_CALLEE_SAVE(__pv_link_and_wait_node);
+	pv_lock_ops.kick_node = PV_CALLEE_SAVE(__pv_kick_node);
+
+	pv_lock_ops.wait_head = PV_CALLEE_SAVE(__pv_wait_head);
+	pv_lock_ops.queue_unlock = PV_CALLEE_SAVE(__pv_queue_unlock);
+
+	pv_lock_ops.wait = kvm_wait;
+	pv_lock_ops.kick = kvm_kick_cpu;
+#else
 	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(kvm_lock_spinning);
 	pv_lock_ops.unlock_kick = kvm_unlock_kick;
+#endif
 }
 
 static __init int kvm_spinlock_init_jump(void)
Index: linux-2.6/kernel/Kconfig.locks
===================================================================
--- linux-2.6.orig/kernel/Kconfig.locks
+++ linux-2.6/kernel/Kconfig.locks
@@ -229,7 +229,7 @@ config ARCH_USE_QUEUE_SPINLOCK
 
 config QUEUE_SPINLOCK
 	def_bool y if ARCH_USE_QUEUE_SPINLOCK
-	depends on SMP && !PARAVIRT_SPINLOCKS
+	depends on SMP && !(PARAVIRT_SPINLOCKS && XEN)
 
 config ARCH_USE_QUEUE_RWLOCK
 	bool
