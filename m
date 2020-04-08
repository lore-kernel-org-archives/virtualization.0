From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 22/26] kvm/paravirt: Encapsulate KVM pv switching logic
Date: Tue,  7 Apr 2020 22:03:19 -0700
Message-ID: <20200408050323.4237-23-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

KVM pv-ops are dependent on KVM features/hints which are exposed
via CPUID. Decouple the probing and the enabling of these ops from
__init so they can be called post-init as well.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/Kconfig      |  1 +
 arch/x86/kernel/kvm.c | 87 ++++++++++++++++++++++++++++++-------------
 2 files changed, 63 insertions(+), 25 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 605619938f08..e0629558b6b5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -809,6 +809,7 @@ config KVM_GUEST
 	depends on PARAVIRT
 	select PARAVIRT_CLOCK
 	select ARCH_CPUIDLE_HALTPOLL
+	select PARAVIRT_RUNTIME
 	default y
 	---help---
 	  This option enables various optimizations for running under the KVM
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index e56d263159d7..31f5ecfd3907 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/nmi.h>
 #include <linux/swait.h>
+#include <linux/memory.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -262,12 +263,20 @@ do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned lon
 }
 NOKPROBE_SYMBOL(do_async_page_fault);
 
+static bool kvm_pv_io_delay(void)
+{
+	bool cond = kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY);
+
+	paravirt_stage_alt(cond, cpu.io_delay, kvm_io_delay);
+
+	return cond;
+}
+
 static void __init paravirt_ops_setup(void)
 {
 	pv_info.name = "KVM";
 
-	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
-		pv_ops.cpu.io_delay = kvm_io_delay;
+	kvm_pv_io_delay();
 
 #ifdef CONFIG_X86_IO_APIC
 	no_timer_check = 1;
@@ -432,6 +441,15 @@ static bool pv_tlb_flush_supported(void)
 		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME));
 }
 
+static bool kvm_pv_steal_clock(void)
+{
+	bool cond = kvm_para_has_feature(KVM_FEATURE_STEAL_TIME);
+
+	paravirt_stage_alt(cond, time.steal_clock, kvm_steal_clock);
+
+	return cond;
+}
+
 static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 #ifdef CONFIG_SMP
@@ -624,6 +642,17 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 	native_flush_tlb_others(flushmask, info);
 }
 
+static bool kvm_pv_tlb(void)
+{
+	bool cond = pv_tlb_flush_supported();
+
+	paravirt_stage_alt(cond, mmu.flush_tlb_others,
+			   kvm_flush_tlb_others);
+	paravirt_stage_alt(cond, mmu.tlb_remove_table,
+			   tlb_remove_table);
+	return cond;
+}
+
 static void __init kvm_guest_init(void)
 {
 	int i;
@@ -635,16 +664,11 @@ static void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF))
 		x86_init.irqs.trap_init = kvm_apf_trap_init;
 
-	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
+	if (kvm_pv_steal_clock())
 		has_steal_clock = 1;
-		pv_ops.time.steal_clock = kvm_steal_clock;
-	}
 
-	if (pv_tlb_flush_supported()) {
-		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
-		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
+	if (kvm_pv_tlb())
 		pr_info("KVM setup pv remote TLB flush\n");
-	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_set_eoi_write(kvm_guest_apic_eoi_write);
@@ -849,33 +873,46 @@ asm(
 
 #endif
 
+static inline bool kvm_para_lock_ops(void)
+{
+	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
+	return kvm_para_has_feature(KVM_FEATURE_PV_UNHALT) &&
+		!kvm_para_has_hint(KVM_HINTS_REALTIME);
+}
+
+static bool kvm_pv_spinlock(void)
+{
+	bool cond = kvm_para_lock_ops();
+	bool preempt_cond = cond &&
+			kvm_para_has_feature(KVM_FEATURE_STEAL_TIME);
+
+	paravirt_stage_alt(cond, lock.queued_spin_lock_slowpath,
+			   __pv_queued_spin_lock_slowpath);
+	paravirt_stage_alt(cond, lock.queued_spin_unlock.func,
+			   PV_CALLEE_SAVE(__pv_queued_spin_unlock).func);
+	paravirt_stage_alt(cond, lock.wait, kvm_wait);
+	paravirt_stage_alt(cond, lock.kick, kvm_kick_cpu);
+
+	paravirt_stage_alt(preempt_cond,
+			   lock.vcpu_is_preempted.func,
+			   PV_CALLEE_SAVE(__kvm_vcpu_is_preempted).func);
+	return cond;
+}
+
 /*
  * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
  */
 void __init kvm_spinlock_init(void)
 {
-	/* Does host kernel support KVM_FEATURE_PV_UNHALT? */
-	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
-		return;
-
-	if (kvm_para_has_hint(KVM_HINTS_REALTIME))
-		return;
 
 	/* Don't use the pvqspinlock code if there is only 1 vCPU. */
 	if (num_possible_cpus() == 1)
 		return;
 
-	__pv_init_lock_hash();
-	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_ops.lock.queued_spin_unlock =
-		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_ops.lock.wait = kvm_wait;
-	pv_ops.lock.kick = kvm_kick_cpu;
+	if (!kvm_pv_spinlock())
+		return;
 
-	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_ops.lock.vcpu_is_preempted =
-			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
-	}
+	__pv_init_lock_hash();
 }
 
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
-- 
2.20.1
