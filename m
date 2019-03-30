From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/5] x86: Convert some slow-path static_cpu_has() callers to
	boot_cpu_has()
Date: Sat, 30 Mar 2019 12:20:19 +0100
Message-ID: <20190330112022.28888-3-bp__23535.851021164$1553944869$gmane$org@alien8.de>
References: <20190330112022.28888-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190330112022.28888-1-bp@alien8.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dominik Brodowski <linux@dominikbrodowski.net>, virtualization@lists.linux-foundation.org, Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <nadav.amit@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>, Jann Horn <jannh@google.com>, Aubrey Li <aubrey.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org, Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@amacapital.net>, Masami Hiramatsu <mhiramat@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Borislav Petkov <bp@suse.de>

Using static_cpu_has() is pointless on those paths, convert them to the
boot_cpu_has() variant.

No functional changes.

Reported-by: Nadav Amit <nadav.amit@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: linux-edac@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/fpu/internal.h  |  7 +++----
 arch/x86/kernel/apic/apic_numachip.c |  2 +-
 arch/x86/kernel/cpu/aperfmperf.c     |  6 +++---
 arch/x86/kernel/cpu/common.c         |  2 +-
 arch/x86/kernel/cpu/mce/inject.c     |  2 +-
 arch/x86/kernel/cpu/proc.c           | 10 +++++-----
 arch/x86/kernel/ldt.c                | 14 +++++++-------
 arch/x86/kernel/paravirt.c           |  2 +-
 arch/x86/kernel/process.c            |  4 ++--
 arch/x86/kernel/reboot.c             |  2 +-
 arch/x86/kernel/vm86_32.c            |  2 +-
 11 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index fb04a3ded7dd..745a19d34f23 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -253,7 +253,7 @@ static inline void copy_xregs_to_kernel_booting(struct xregs_state *xstate)
 
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 	else
 		XSTATE_OP(XSAVE, xstate, lmask, hmask, err);
@@ -275,7 +275,7 @@ static inline void copy_kernel_to_xregs_booting(struct xregs_state *xstate)
 
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (static_cpu_has(X86_FEATURE_XSAVES))
+	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 	else
 		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
@@ -497,8 +497,7 @@ static inline void fpregs_activate(struct fpu *fpu)
  *  - switch_fpu_finish() restores the new state as
  *    necessary.
  */
-static inline void
-switch_fpu_prepare(struct fpu *old_fpu, int cpu)
+static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (static_cpu_has(X86_FEATURE_FPU) && old_fpu->initialized) {
 		if (!copy_fpregs_to_fpstate(old_fpu))
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 78778b54f904..a5464b8b6c46 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -175,7 +175,7 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 	this_cpu_write(cpu_llc_id, node);
 
 	/* Account for nodes per socket in multi-core-module processors */
-	if (static_cpu_has(X86_FEATURE_NODEID_MSR)) {
+	if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
 		rdmsrl(MSR_FAM10H_NODE_ID, val);
 		nodes = ((val >> 3) & 7) + 1;
 	}
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 804c49493938..64d5aec24203 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -83,7 +83,7 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!cpu_khz)
 		return 0;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
@@ -99,7 +99,7 @@ void arch_freq_prepare_all(void)
 	if (!cpu_khz)
 		return;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
 	for_each_online_cpu(cpu)
@@ -115,7 +115,7 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 	if (!cpu_khz)
 		return 0;
 
-	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return 0;
 
 	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..95a5faf3a6a0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1668,7 +1668,7 @@ static void setup_getcpu(int cpu)
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
 
-	if (static_cpu_has(X86_FEATURE_RDTSCP))
+	if (boot_cpu_has(X86_FEATURE_RDTSCP))
 		write_rdtscp_aux(cpudata);
 
 	/* Store CPU and node number in limit. */
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3f82afd0f46f..a6026170af92 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -526,7 +526,7 @@ static void do_inject(void)
 	 * only on the node base core. Refer to D18F3x44[NbMcaToMstCpuEn] for
 	 * Fam10h and later BKDGs.
 	 */
-	if (static_cpu_has(X86_FEATURE_AMD_DCM) &&
+	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
 		toggle_nb_mca_mst_cpu(amd_get_nb_id(cpu));
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 2c8522a39ed5..cb2e49810d68 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -35,11 +35,11 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 		   "fpu_exception\t: %s\n"
 		   "cpuid level\t: %d\n"
 		   "wp\t\t: yes\n",
-		   static_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
-		   static_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
-		   static_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
-		   static_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
-		   static_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   boot_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
+		   boot_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
+		   boot_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
+		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
 		   c->cpuid_level);
 }
 #else
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 6135ae8ce036..b2463fcb20a8 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -113,7 +113,7 @@ static void do_sanity_check(struct mm_struct *mm,
 		 * tables.
 		 */
 		WARN_ON(!had_kernel_mapping);
-		if (static_cpu_has(X86_FEATURE_PTI))
+		if (boot_cpu_has(X86_FEATURE_PTI))
 			WARN_ON(!had_user_mapping);
 	} else {
 		/*
@@ -121,7 +121,7 @@ static void do_sanity_check(struct mm_struct *mm,
 		 * Sync the pgd to the usermode tables.
 		 */
 		WARN_ON(had_kernel_mapping);
-		if (static_cpu_has(X86_FEATURE_PTI))
+		if (boot_cpu_has(X86_FEATURE_PTI))
 			WARN_ON(had_user_mapping);
 	}
 }
@@ -156,7 +156,7 @@ static void map_ldt_struct_to_user(struct mm_struct *mm)
 	k_pmd = pgd_to_pmd_walk(k_pgd, LDT_BASE_ADDR);
 	u_pmd = pgd_to_pmd_walk(u_pgd, LDT_BASE_ADDR);
 
-	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+	if (boot_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
 		set_pmd(u_pmd, *k_pmd);
 }
 
@@ -181,7 +181,7 @@ static void map_ldt_struct_to_user(struct mm_struct *mm)
 {
 	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
 
-	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+	if (boot_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
 		set_pgd(kernel_to_user_pgdp(pgd), *pgd);
 }
 
@@ -208,7 +208,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	spinlock_t *ptl;
 	int i, nr_pages;
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return 0;
 
 	/*
@@ -271,7 +271,7 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 		return;
 
 	/* LDT map/unmap is only required for PTI */
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
@@ -311,7 +311,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 	unsigned long start = LDT_BASE_ADDR;
 	unsigned long end = LDT_END_ADDR;
 
-	if (!static_cpu_has(X86_FEATURE_PTI))
+	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	tlb_gather_mmu(&tlb, mm, start, end);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c0e0101133f3..7bbaa6baf37f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -121,7 +121,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 58ac7be52c7a..16a7113e91c5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -236,7 +236,7 @@ static int get_cpuid_mode(void)
 
 static int set_cpuid_mode(struct task_struct *task, unsigned long cpuid_enabled)
 {
-	if (!static_cpu_has(X86_FEATURE_CPUID_FAULT))
+	if (!boot_cpu_has(X86_FEATURE_CPUID_FAULT))
 		return -ENODEV;
 
 	if (cpuid_enabled)
@@ -666,7 +666,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 	if (c->x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (!cpu_has(c, X86_FEATURE_MWAIT) || static_cpu_has_bug(X86_BUG_MONITOR))
+	if (!cpu_has(c, X86_FEATURE_MWAIT) || boot_cpu_has_bug(X86_BUG_MONITOR))
 		return 0;
 
 	return 1;
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 725624b6c0c0..d62ebbc5ec78 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -108,7 +108,7 @@ void __noreturn machine_real_restart(unsigned int type)
 	write_cr3(real_mode_header->trampoline_pgd);
 
 	/* Exiting long mode will fail if CR4.PCIDE is set. */
-	if (static_cpu_has(X86_FEATURE_PCID))
+	if (boot_cpu_has(X86_FEATURE_PCID))
 		cr4_clear_bits(X86_CR4_PCIDE);
 #endif
 
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index a092b6b40c6b..6a38717d179c 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -369,7 +369,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
 	preempt_disable();
 	tsk->thread.sp0 += 16;
 
-	if (static_cpu_has(X86_FEATURE_SEP)) {
+	if (boot_cpu_has(X86_FEATURE_SEP)) {
 		tsk->thread.sysenter_cs = 0;
 		refresh_sysenter_cs(&tsk->thread);
 	}
-- 
2.21.0
