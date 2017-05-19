From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 10/10] paravirt: merge pv_ops_* structures into one
Date: Fri, 19 May 2017 17:47:46 +0200
Message-ID: <20170519154746.29389-11-jgross__19631.0488543988$1495208978$gmane$org@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

As there are now only very few pvops functions left when
CONFIG_PARAVIRT_FULL isn't set, merge the related structures into
one named "pv_ops".

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       | 32 ++++++++++++++++----------------
 arch/x86/include/asm/paravirt_types.h | 27 ++++-----------------------
 arch/x86/kernel/alternative.c         |  4 ++--
 arch/x86/kernel/asm-offsets.c         |  6 +++---
 arch/x86/kernel/cpu/vmware.c          |  6 +++---
 arch/x86/kernel/kvm.c                 |  6 +++---
 arch/x86/kernel/kvmclock.c            |  6 +++---
 arch/x86/kernel/paravirt.c            | 33 +++++----------------------------
 arch/x86/kernel/paravirt_patch_32.c   | 16 ++++++++--------
 arch/x86/kernel/paravirt_patch_64.c   | 16 ++++++++--------
 arch/x86/kernel/tsc.c                 |  2 +-
 arch/x86/kernel/vsmp_64.c             | 18 +++++++++---------
 arch/x86/lguest/boot.c                | 20 ++++++++++----------
 arch/x86/xen/enlighten_hvm.c          |  4 ++--
 arch/x86/xen/enlighten_pv.c           | 28 ++++++++++++----------------
 arch/x86/xen/irq.c                    | 12 ++++--------
 arch/x86/xen/mmu_hvm.c                |  2 +-
 arch/x86/xen/mmu_pv.c                 |  4 ++--
 arch/x86/xen/time.c                   | 11 ++++-------
 drivers/xen/time.c                    |  2 +-
 20 files changed, 101 insertions(+), 154 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 55e0c1807df2..0f8194ec64c9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -28,7 +28,7 @@ static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 static inline unsigned long long paravirt_sched_clock(void)
 {
-	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
+	return PVOP_CALL0(unsigned long long, pv_ops.sched_clock);
 }
 
 struct static_key;
@@ -37,23 +37,23 @@ extern struct static_key paravirt_steal_rq_enabled;
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return PVOP_CALL1(u64, pv_time_ops.steal_clock, cpu);
+	return PVOP_CALL1(u64, pv_ops.steal_clock, cpu);
 }
 
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_cpu_ops.io_delay();
+	pv_ops.io_delay();
 #ifdef REALLY_SLOW_IO
-	pv_cpu_ops.io_delay();
-	pv_cpu_ops.io_delay();
-	pv_cpu_ops.io_delay();
+	pv_ops.io_delay();
+	pv_ops.io_delay();
+	pv_ops.io_delay();
 #endif
 }
 
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
-	PVOP_VCALL1(pv_mmu_ops.exit_mmap, mm);
+	PVOP_VCALL1(pv_ops.exit_mmap, mm);
 }
 
 static inline void flush_tlb_others(const struct cpumask *cpumask,
@@ -61,7 +61,7 @@ static inline void flush_tlb_others(const struct cpumask *cpumask,
 				    unsigned long start,
 				    unsigned long end)
 {
-	PVOP_VCALL4(pv_mmu_ops.flush_tlb_others, cpumask, mm, start, end);
+	PVOP_VCALL4(pv_ops.flush_tlb_others, cpumask, mm, start, end);
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
@@ -173,22 +173,22 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 
 static inline notrace unsigned long arch_local_save_flags(void)
 {
-	return PVOP_CALLEE0(unsigned long, pv_irq_ops.save_fl);
+	return PVOP_CALLEE0(unsigned long, pv_ops.save_fl);
 }
 
 static inline notrace void arch_local_irq_restore(unsigned long f)
 {
-	PVOP_VCALLEE1(pv_irq_ops.restore_fl, f);
+	PVOP_VCALLEE1(pv_ops.restore_fl, f);
 }
 
 static inline notrace void arch_local_irq_disable(void)
 {
-	PVOP_VCALLEE0(pv_irq_ops.irq_disable);
+	PVOP_VCALLEE0(pv_ops.irq_disable);
 }
 
 static inline notrace void arch_local_irq_enable(void)
 {
-	PVOP_VCALLEE0(pv_irq_ops.irq_enable);
+	PVOP_VCALLEE0(pv_ops.irq_enable);
 }
 
 static inline notrace unsigned long arch_local_irq_save(void)
@@ -286,15 +286,15 @@ extern void default_banner(void);
 #endif
 
 #define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
+	PARA_SITE(PARA_PATCH(pv_ops, PV_IRQ_irq_disable), clobbers,	\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
+		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
+	PARA_SITE(PARA_PATCH(pv_ops, PV_IRQ_irq_enable), clobbers,	\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
+		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 34753d10ebbc..833529661acb 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -65,11 +65,9 @@ struct paravirt_callee_save {
 #endif
 
 /* general info */
-struct pv_info {
+struct pv_ops {
 	const char *name;
-};
 
-struct pv_init_ops {
 	/*
 	 * Patch may replace one of the defined code sequences with
 	 * arbitrary code, subject to the same register constraints.
@@ -80,18 +78,12 @@ struct pv_init_ops {
 	 */
 	unsigned (*patch)(u8 type, u16 clobber, void *insnbuf,
 			  unsigned long addr, unsigned len);
-};
 
-struct pv_time_ops {
 	unsigned long long (*sched_clock)(void);
 	unsigned long long (*steal_clock)(int cpu);
-};
 
-struct pv_cpu_ops {
 	void (*io_delay)(void);
-};
 
-struct pv_irq_ops {
 	/*
 	 * Get/set interrupt state.  save_fl and restore_fl are only
 	 * expected to use X86_EFLAGS_IF; all other bits
@@ -105,9 +97,7 @@ struct pv_irq_ops {
 	struct paravirt_callee_save restore_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-};
 
-struct pv_mmu_ops {
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*flush_tlb_others)(const struct cpumask *cpus,
 				 struct mm_struct *mm,
@@ -136,11 +126,7 @@ struct pv_lock_ops {
  * number for each function using the offset which we use to indicate
  * what to patch. */
 struct paravirt_patch_template {
-	struct pv_init_ops pv_init_ops;
-	struct pv_time_ops pv_time_ops;
-	struct pv_cpu_ops pv_cpu_ops;
-	struct pv_irq_ops pv_irq_ops;
-	struct pv_mmu_ops pv_mmu_ops;
+	struct pv_ops pv_ops;
 	struct pv_lock_ops pv_lock_ops;
 #ifdef CONFIG_PARAVIRT_FULL
 	struct pvfull_cpu_ops pvfull_cpu_ops;
@@ -149,12 +135,7 @@ struct paravirt_patch_template {
 #endif
 };
 
-extern struct pv_info pv_info;
-extern struct pv_init_ops pv_init_ops;
-extern struct pv_time_ops pv_time_ops;
-extern struct pv_cpu_ops pv_cpu_ops;
-extern struct pv_irq_ops pv_irq_ops;
-extern struct pv_mmu_ops pv_mmu_ops;
+extern struct pv_ops pv_ops;
 extern struct pv_lock_ops pv_lock_ops;
 
 #define PARAVIRT_PATCH(x)					\
@@ -247,7 +228,7 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
  * The call instruction itself is marked by placing its start address
  * and size into the .parainstructions section, so that
  * apply_paravirt() in arch/i386/kernel/alternative.c can do the
- * appropriate patching under the control of the backend pv_init_ops
+ * appropriate patching under the control of the backend pv_ops
  * implementation.
  *
  * Unfortunately there's no way to get gcc to generate the args setup
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c5b8f760473c..ac1a9356616b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -600,8 +600,8 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
 		memcpy(insnbuf, p->instr, p->len);
-		used = pv_init_ops.patch(p->instrtype, p->clobbers, insnbuf,
-					 (unsigned long)p->instr, p->len);
+		used = pv_ops.patch(p->instrtype, p->clobbers, insnbuf,
+				    (unsigned long)p->instr, p->len);
 
 		BUG_ON(used > p->len);
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 18a5c06c007a..6a225a90bc31 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -64,9 +64,9 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
-	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
-	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
+	OFFSET(PARAVIRT_PATCH_pv_ops, paravirt_patch_template, pv_ops);
+	OFFSET(PV_IRQ_irq_disable, pv_ops, irq_disable);
+	OFFSET(PV_IRQ_irq_enable, pv_ops, irq_enable);
 #endif
 #ifdef CONFIG_PARAVIRT_FULL
 	OFFSET(PARAVIRT_PATCH_pvfull_cpu_ops, paravirt_patch_template,
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 40ed26852ebd..6be8af37e227 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -97,14 +97,14 @@ static void __init vmware_sched_clock_setup(void)
 	d->cyc2ns_offset = mul_u64_u32_shr(tsc_now, d->cyc2ns_mul,
 					   d->cyc2ns_shift);
 
-	pv_time_ops.sched_clock = vmware_sched_clock;
+	pv_ops.sched_clock = vmware_sched_clock;
 	pr_info("using sched offset of %llu ns\n", d->cyc2ns_offset);
 }
 
 static void __init vmware_paravirt_ops_setup(void)
 {
-	pv_info.name = "VMware hypervisor";
-	pv_cpu_ops.io_delay = paravirt_nop;
+	pv_ops.name = "VMware hypervisor";
+	pv_ops.io_delay = paravirt_nop;
 
 	if (vmware_tsc_khz && vmw_sched_clock)
 		vmware_sched_clock_setup();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index da5c09789984..2aefbcea9ae4 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -280,10 +280,10 @@ NOKPROBE_SYMBOL(do_async_page_fault);
 
 static void __init paravirt_ops_setup(void)
 {
-	pv_info.name = "KVM";
+	pv_ops.name = "KVM";
 
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
-		pv_cpu_ops.io_delay = kvm_io_delay;
+		pv_ops.io_delay = kvm_io_delay;
 
 #ifdef CONFIG_X86_IO_APIC
 	no_timer_check = 1;
@@ -467,7 +467,7 @@ void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
-		pv_time_ops.steal_clock = kvm_steal_clock;
+		pv_ops.steal_clock = kvm_steal_clock;
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index d88967659098..d3c92f7ce79b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -109,13 +109,13 @@ static u64 kvm_sched_clock_read(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	if (!stable) {
-		pv_time_ops.sched_clock = kvm_clock_read;
+		pv_ops.sched_clock = kvm_clock_read;
 		clear_sched_clock_stable();
 		return;
 	}
 
 	kvm_sched_clock_offset = kvm_clock_read();
-	pv_time_ops.sched_clock = kvm_sched_clock_read;
+	pv_ops.sched_clock = kvm_sched_clock_read;
 
 	printk(KERN_INFO "kvm-clock: using sched offset of %llu cycles\n",
 			kvm_sched_clock_offset);
@@ -308,7 +308,7 @@ void __init kvmclock_init(void)
 #endif
 	kvm_get_preset_lpj();
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
-	pv_info.name = "KVM";
+	pv_ops.name = "KVM";
 }
 
 int __init kvm_setup_vsyscall_timeinfo(void)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 42da2fde1fef..cde433e495f6 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -63,7 +63,7 @@ u64 notrace _paravirt_ident_64(u64 x)
 void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
-	       pv_info.name);
+	       pv_ops.name);
 }
 
 /* Undefined instruction for dealing with missing ops pointers. */
@@ -114,11 +114,7 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 static void *get_call_destination(u8 type)
 {
 	struct paravirt_patch_template tmpl = {
-		.pv_init_ops = pv_init_ops,
-		.pv_time_ops = pv_time_ops,
-		.pv_cpu_ops = pv_cpu_ops,
-		.pv_irq_ops = pv_irq_ops,
-		.pv_mmu_ops = pv_mmu_ops,
+		.pv_ops = pv_ops,
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 		.pv_lock_ops = pv_lock_ops,
 #endif
@@ -185,37 +181,18 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
-struct pv_info pv_info = {
+__visible struct pv_ops pv_ops = {
 	.name = "bare hardware",
-};
-
-struct pv_init_ops pv_init_ops = {
 	.patch = native_patch,
-};
-
-struct pv_time_ops pv_time_ops = {
 	.sched_clock = native_sched_clock,
 	.steal_clock = native_steal_clock,
-};
-
-__visible struct pv_irq_ops pv_irq_ops = {
+	.io_delay = native_io_delay,
 	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
-};
-
-__visible struct pv_cpu_ops pv_cpu_ops = {
-	.io_delay = native_io_delay,
-};
-
-struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 	.flush_tlb_others = native_flush_tlb_others,
 	.exit_mmap = paravirt_nop,
 };
 
-EXPORT_SYMBOL_GPL(pv_time_ops);
-EXPORT_SYMBOL    (pv_cpu_ops);
-EXPORT_SYMBOL    (pv_mmu_ops);
-EXPORT_SYMBOL    (pv_info);
-EXPORT_SYMBOL    (pv_irq_ops);
+EXPORT_SYMBOL(pv_ops);
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index b5f93cb0d05f..48e44290cff0 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -1,9 +1,9 @@
 #include <asm/paravirt.h>
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
+DEF_NATIVE(pv_ops, irq_disable, "cli");
+DEF_NATIVE(pv_ops, irq_enable, "sti");
+DEF_NATIVE(pv_ops, restore_fl, "push %eax; popf");
+DEF_NATIVE(pv_ops, save_fl, "pushf; pop %eax");
 #ifdef CONFIG_PARAVIRT_FULL
 DEF_NATIVE(pvfull_mmu_ops, read_cr2, "mov %cr2, %eax");
 DEF_NATIVE(pvfull_mmu_ops, write_cr3, "mov %eax, %cr3");
@@ -43,10 +43,10 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 			end = end_##ops##_##x;			\
 			goto patch_site
 	switch (type) {
-		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_irq_ops, irq_enable);
-		PATCH_SITE(pv_irq_ops, restore_fl);
-		PATCH_SITE(pv_irq_ops, save_fl);
+		PATCH_SITE(pv_ops, irq_disable);
+		PATCH_SITE(pv_ops, irq_enable);
+		PATCH_SITE(pv_ops, restore_fl);
+		PATCH_SITE(pv_ops, save_fl);
 #ifdef CONFIG_PARAVIRT_FULL
 		PATCH_SITE(pvfull_mmu_ops, read_cr2);
 		PATCH_SITE(pvfull_mmu_ops, read_cr3);
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 473688054f0b..158943a18ca2 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -2,10 +2,10 @@
 #include <asm/asm-offsets.h>
 #include <linux/stringify.h>
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "pushq %rdi; popfq");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushfq; popq %rax");
+DEF_NATIVE(pv_ops, irq_disable, "cli");
+DEF_NATIVE(pv_ops, irq_enable, "sti");
+DEF_NATIVE(pv_ops, restore_fl, "pushq %rdi; popfq");
+DEF_NATIVE(pv_ops, save_fl, "pushfq; popq %rax");
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
@@ -52,10 +52,10 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 			end = end_##ops##_##x;			\
 			goto patch_site
 	switch(type) {
-		PATCH_SITE(pv_irq_ops, restore_fl);
-		PATCH_SITE(pv_irq_ops, save_fl);
-		PATCH_SITE(pv_irq_ops, irq_enable);
-		PATCH_SITE(pv_irq_ops, irq_disable);
+		PATCH_SITE(pv_ops, restore_fl);
+		PATCH_SITE(pv_ops, save_fl);
+		PATCH_SITE(pv_ops, irq_enable);
+		PATCH_SITE(pv_ops, irq_disable);
 #ifdef CONFIG_PARAVIRT_FULL
 		PATCH_SITE(pvfull_mmu_ops, read_cr2);
 		PATCH_SITE(pvfull_mmu_ops, read_cr3);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 714dfba6a1e7..678fc8923cb8 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -330,7 +330,7 @@ unsigned long long sched_clock(void)
 
 bool using_native_sched_clock(void)
 {
-	return pv_time_ops.sched_clock == native_sched_clock;
+	return pv_ops.sched_clock == native_sched_clock;
 }
 #else
 unsigned long long
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index b034b1b14b9c..8e003dac79fb 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -76,10 +76,10 @@ static unsigned __init vsmp_patch(u8 type, u16 clobbers, void *ibuf,
 				  unsigned long addr, unsigned len)
 {
 	switch (type) {
-	case PARAVIRT_PATCH(pv_irq_ops.irq_enable):
-	case PARAVIRT_PATCH(pv_irq_ops.irq_disable):
-	case PARAVIRT_PATCH(pv_irq_ops.save_fl):
-	case PARAVIRT_PATCH(pv_irq_ops.restore_fl):
+	case PARAVIRT_PATCH(pv_ops.irq_enable):
+	case PARAVIRT_PATCH(pv_ops.irq_disable):
+	case PARAVIRT_PATCH(pv_ops.save_fl):
+	case PARAVIRT_PATCH(pv_ops.restore_fl):
 		return paravirt_patch_default(type, clobbers, ibuf, addr, len);
 	default:
 		return native_patch(type, clobbers, ibuf, addr, len);
@@ -117,11 +117,11 @@ static void __init set_vsmp_pv_ops(void)
 
 	if (cap & ctl & (1 << 4)) {
 		/* Setup irq ops and turn on vSMP  IRQ fastpath handling */
-		pv_irq_ops.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
-		pv_irq_ops.irq_enable  = PV_CALLEE_SAVE(vsmp_irq_enable);
-		pv_irq_ops.save_fl  = PV_CALLEE_SAVE(vsmp_save_fl);
-		pv_irq_ops.restore_fl  = PV_CALLEE_SAVE(vsmp_restore_fl);
-		pv_init_ops.patch = vsmp_patch;
+		pv_ops.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
+		pv_ops.irq_enable  = PV_CALLEE_SAVE(vsmp_irq_enable);
+		pv_ops.save_fl  = PV_CALLEE_SAVE(vsmp_save_fl);
+		pv_ops.restore_fl  = PV_CALLEE_SAVE(vsmp_restore_fl);
+		pv_ops.patch = vsmp_patch;
 		ctl &= ~(1 << 4);
 	}
 	writel(ctl, address + 4);
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index 86b8b1a0c99e..ccb6647a5167 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1351,8 +1351,8 @@ static const struct lguest_insns
 {
 	const char *start, *end;
 } lguest_insns[] = {
-	[PARAVIRT_PATCH(pv_irq_ops.irq_disable)] = { lgstart_cli, lgend_cli },
-	[PARAVIRT_PATCH(pv_irq_ops.save_fl)] = { lgstart_pushf, lgend_pushf },
+	[PARAVIRT_PATCH(pv_ops.irq_disable)] = { lgstart_cli, lgend_cli },
+	[PARAVIRT_PATCH(pv_ops.save_fl)] = { lgstart_pushf, lgend_pushf },
 };
 
 /*
@@ -1388,7 +1388,10 @@ static unsigned lguest_patch(u8 type, u16 clobber, void *ibuf,
 __init void lguest_init(void)
 {
 	/* We're under lguest. */
-	pv_info.name = "lguest";
+	pv_ops.name = "lguest";
+	/* Setup operations */
+	pv_ops.patch = lguest_patch;
+
 	/* We're running at privilege level 1, not 0 as normal. */
 	pvfull_info.kernel_rpl = 1;
 	/* Everyone except Xen runs with this set. */
@@ -1400,15 +1403,12 @@ __init void lguest_init(void)
 	 */
 
 	/* Interrupt-related operations */
-	pv_irq_ops.save_fl = PV_CALLEE_SAVE(lguest_save_fl);
-	pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(lg_restore_fl);
-	pv_irq_ops.irq_disable = PV_CALLEE_SAVE(lguest_irq_disable);
-	pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(lg_irq_enable);
+	pv_ops.save_fl = PV_CALLEE_SAVE(lguest_save_fl);
+	pv_ops.restore_fl = __PV_IS_CALLEE_SAVE(lg_restore_fl);
+	pv_ops.irq_disable = PV_CALLEE_SAVE(lguest_irq_disable);
+	pv_ops.irq_enable = __PV_IS_CALLEE_SAVE(lg_irq_enable);
 	pvfull_irq_ops.safe_halt = lguest_safe_halt;
 
-	/* Setup operations */
-	pv_init_ops.patch = lguest_patch;
-
 	/* Intercepts of various CPU instructions */
 	pvfull_cpu_ops.load_gdt = lguest_load_gdt;
 	pvfull_cpu_ops.cpuid = lguest_cpuid;
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index a6d014f47e52..03165e3101f2 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -69,12 +69,12 @@ static void __init init_hvm_pv_info(void)
 
 	/* PVH set up hypercall page in xen_prepare_pvh(). */
 	if (xen_pvh_domain())
-		pv_info.name = "Xen PVH";
+		pv_ops.name = "Xen PVH";
 	else {
 		u64 pfn;
 		uint32_t msr;
 
-		pv_info.name = "Xen HVM";
+		pv_ops.name = "Xen HVM";
 		msr = cpuid_ebx(base + 2);
 		pfn = __pa(hypercall_page);
 		wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index dcf1b4183c49..9fa6698f2f26 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -144,7 +144,7 @@ static void __init xen_banner(void)
 
 	pr_info("Booting paravirtualized kernel %son %s\n",
 		xen_feature(XENFEAT_auto_translated_physmap) ?
-			"with PVH extensions " : "", pv_info.name);
+			"with PVH extensions " : "", pv_ops.name);
 	printk(KERN_INFO "Xen version: %d.%d%s%s\n",
 	       version >> 16, version & 0xffff, extra.extraversion,
 	       xen_feature(XENFEAT_mmu_pt_update_preserve_ad) ? " (preserve-AD)" : "");
@@ -998,10 +998,10 @@ void xen_setup_vcpu_info_placement(void)
 	 * percpu area for all cpus, so make use of it.
 	 */
 	if (xen_have_vcpu_info_placement) {
-		pv_irq_ops.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
-		pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
-		pv_irq_ops.irq_disable = __PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
-		pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
+		pv_ops.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
+		pv_ops.restore_fl = __PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
+		pv_ops.irq_disable = __PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
+		pv_ops.irq_enable = __PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
 		pvfull_mmu_ops.read_cr2 = xen_read_cr2_direct;
 	}
 }
@@ -1024,10 +1024,10 @@ static unsigned xen_patch(u8 type, u16 clobbers, void *insnbuf,
 	goto patch_site
 
 	switch (type) {
-		SITE(pv_irq_ops, irq_enable);
-		SITE(pv_irq_ops, irq_disable);
-		SITE(pv_irq_ops, save_fl);
-		SITE(pv_irq_ops, restore_fl);
+		SITE(pv_ops, irq_enable);
+		SITE(pv_ops, irq_disable);
+		SITE(pv_ops, save_fl);
+		SITE(pv_ops, restore_fl);
 #undef SITE
 
 	patch_site:
@@ -1067,10 +1067,6 @@ static const struct pvfull_info xen_info __initconst = {
 #endif
 };
 
-static const struct pv_init_ops xen_init_ops __initconst = {
-	.patch = xen_patch,
-};
-
 static const struct pvfull_cpu_ops xen_cpu_ops __initconst = {
 	.cpuid = xen_cpuid,
 
@@ -1267,10 +1263,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Install Xen paravirt ops */
 	pvfull_info = xen_info;
-	pv_info.name = "Xen";
-	pv_init_ops = xen_init_ops;
+	pv_ops.name = "Xen";
+	pv_ops.patch = xen_patch;
+	pv_ops.io_delay = xen_io_delay;
 	pvfull_cpu_ops = xen_cpu_ops;
-	pv_cpu_ops.io_delay = xen_io_delay;
 
 	x86_platform.get_nmi_reason = xen_get_nmi_reason;
 
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index c9dba9d8cecf..eeced2f4ccb6 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -115,13 +115,6 @@ static void xen_halt(void)
 		xen_safe_halt();
 }
 
-static const struct pv_irq_ops xen_irq_ops __initconst = {
-	.save_fl = PV_CALLEE_SAVE(xen_save_fl),
-	.restore_fl = PV_CALLEE_SAVE(xen_restore_fl),
-	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
-	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
-};
-
 static const struct pvfull_irq_ops xen_full_irq_ops __initconst = {
 	.safe_halt = xen_safe_halt,
 	.halt = xen_halt,
@@ -132,7 +125,10 @@ static const struct pvfull_irq_ops xen_full_irq_ops __initconst = {
 
 void __init xen_init_irq_ops(void)
 {
-	pv_irq_ops = xen_irq_ops;
+	pv_ops.save_fl = PV_CALLEE_SAVE(xen_save_fl);
+	pv_ops.restore_fl = PV_CALLEE_SAVE(xen_restore_fl);
+	pv_ops.irq_disable = PV_CALLEE_SAVE(xen_irq_disable);
+	pv_ops.irq_enable = PV_CALLEE_SAVE(xen_irq_enable);
 	pvfull_irq_ops = xen_full_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index 1c57f1cd545c..bf6472b444c5 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -72,7 +72,7 @@ static int is_pagetable_dying_supported(void)
 void __init xen_hvm_init_mmu_ops(void)
 {
 	if (is_pagetable_dying_supported())
-		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
+		pv_ops.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
 	register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram);
 #endif
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 7be3e21a4dac..89da3c2b8248 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2513,8 +2513,8 @@ void __init xen_init_mmu_ops(void)
 		return;
 
 	pvfull_mmu_ops = xen_mmu_ops;
-	pv_mmu_ops.flush_tlb_others = xen_flush_tlb_others;
-	pv_mmu_ops.exit_mmap = xen_exit_mmap;
+	pv_ops.flush_tlb_others = xen_flush_tlb_others;
+	pv_ops.exit_mmap = xen_exit_mmap;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index a1895a8e85c1..c5f7e5e6eea6 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -366,11 +366,6 @@ void xen_timer_resume(void)
 	}
 }
 
-static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_clocksource_read,
-	.steal_clock = xen_steal_clock,
-};
-
 static void __init xen_time_init(void)
 {
 	int cpu = smp_processor_id();
@@ -408,7 +403,8 @@ static void __init xen_time_init(void)
 
 void __ref xen_init_time_ops(void)
 {
-	pv_time_ops = xen_time_ops;
+	pv_ops.sched_clock = xen_clocksource_read;
+	pv_ops.steal_clock = xen_steal_clock;
 
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
@@ -450,7 +446,8 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
-	pv_time_ops = xen_time_ops;
+	pv_ops.sched_clock = xen_clocksource_read;
+	pv_ops.steal_clock = xen_steal_clock;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index ac5f23fcafc2..37c355734bff 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -106,7 +106,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_time_ops.steal_clock = xen_steal_clock;
+	pv_ops.steal_clock = xen_steal_clock;
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
-- 
2.12.0
