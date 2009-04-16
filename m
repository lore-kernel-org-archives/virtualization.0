From: Matias Zabaljauregui <zabaljauregui@gmail.com>
Subject: NULL pointer dereference at __switch_to()  ( __unlazy_fpu  )   
	with lguest PAE patch
Date: Thu, 16 Apr 2009 14:21:14 -0300
Message-ID: <1239902474.7166.49.camel@zetabook>
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
To: suresh.b.siddha@intel.com, Patrick McHardy <kaber@trash.net>, odie@cs.aau.dk, Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org, lguest@ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Hi, 

For some days I have been looking for the bug that causes an easily reproducible oops in the guest 
when I apply my PAE support _draft_ patch (appended at the end of this mail) to lguest. 

This is the oops: 

Setting kernel variables...done.
Will now mount local filesystems:.
Will now activate swapfile swap:done.
Cleaning /tmp...
[   84.749676] BUG: unable to handle kernel NULL pointer dereference at 00000005
[   84.749676] IP: [<c0101f6e>] __switch_to+0xd/0x12d
[   84.749676] *pdpt = 000000001fa12001 *pde = 0000000000000000
[   84.749676] Oops: 0000 [#1] PREEMPT
[   84.749676] last sysfs file: /sys/kernel/uevent_seqnum
[   84.749676] Modules linked in:
[   84.749676]
[   84.749676] Pid: 1066, comm: find Not tainted (2.6.30-rc2-00167-gcd97824-dirty #1)
[   84.749676] EIP: 0061:[<c0101f6e>] EFLAGS: 00000092 CPU: 0
[   84.749676] EIP is at __switch_to+0xd/0x12d
[   84.749676] EAX: 00000001 EBX: dfa371b0 ECX: df8b0430 EDX: dfa371b0
[   84.749676] ESI: 00000001 EDI: df887200 EBP: df865ec4 ESP: df865eac
[   84.749676]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0069
[   84.749676] Process find (pid: 1066, ti=df864000 task=df8b0430 task.ti=dfa0e000)
[   84.749676] Stack:
[   84.749676]  00000000 00000001 df8b0464 dfa371b0 df8b0430 df887200 df865ee0 c0101b7d
[   84.749676]  00000004 c040f544 dfa371b0 dfa13bc0 dfa13540 dfa0ff58 c03211b7 df865f28
[   84.749676]  00000286 00000000 00393bc7 df865f20 dfa371b0 dfa37340 dfa5d8a0 dfa371b0
[   84.749676] Call Trace:
[   84.749676]  [<c0101b7d>] ? lazy_hcall1+0x32/0xac
[   84.749676]  [<c03211b7>] ? __schedule+0x2c2/0x31f
[   84.749676]  [<c0321226>] ? schedule+0x12/0x24
[   84.749676]  [<c01225ff>] ? do_wait+0x1ec/0x363
[   84.749676]  [<c011c4a7>] ? default_wake_function+0x0/0xd
[   84.749676]  [<c020fabe>] ? copy_to_user+0x2a/0x34
[   84.749676]  [<c01227e5>] ? sys_wait4+0x6f/0x85
[   84.749676]  [<c012280e>] ? sys_waitpid+0x13/0x15
[   84.749676]  [<c01037c5>] ? syscall_call+0x7/0xb
[   84.749676] Code: 00 01 80 00 6a 00 6a 00 6a 00 8d 4d b0 31 d2 89 f0 e8 d3 d7 01 00 8d 65 f4 5b 5e 5f c9 c3 55 89 e5 57 56 53 83 ec 0c 89 c6 89 d3 <8b> 40 04 8b 40 0c a8 01 74 56 a8 10 8b be 60 02 00 00 74 1b 83
[   84.749676] EIP: [<c0101f6e>] __switch_to+0xd/0x12d SS:ESP 0069:df865eac
[   84.749676] CR2: 0000000000000005
[   84.749676] ---[ end trace 54cfaaa2a7bf67ca ]---
[   84.749676] Fixing recursive fault but reboot is needed!




and looking for the NULL dereference, it seems to be in __unlazy_fpu


# gdb -q vmlinux

(gdb) list *0xc0101f6e
0xc0101f6e is in __switch_to (/usr/src/linux-2.6/arch/x86/include/asm/i387.h:273).
268	extern int save_i387_xstate(void __user *buf);
269	extern int restore_i387_xstate(void __user *buf);
270	
271	static inline void __unlazy_fpu(struct task_struct *tsk)
272	{
273		if (task_thread_info(tsk)->status & TS_USEDFPU) {
274			__save_init_fpu(tsk);
275			stts();
276		} else
277			tsk->fpu_counter = 0;




This oops disappears when I use    no387   and   nofxsr    guest kernel parameters in lguest command invocation




Now, this is only happening with my PAE patch applied, so I assume that my code is broken. 
But these seems to be the same symptoms discussed in this thread:

http://lkml.indiana.edu/hypermail/linux/kernel/0806.2/0787.html


So I thought that maybe you can help me with some hints.

I really appreciate your help,
Matias



Here is my patch: 



diff --git a/arch/x86/include/asm/lguest.h b/arch/x86/include/asm/lguest.h
index 1caf576..ffbf1ac 100644
--- a/arch/x86/include/asm/lguest.h
+++ b/arch/x86/include/asm/lguest.h
@@ -17,8 +17,13 @@
 /* Pages for switcher itself, then two pages per cpu */
 #define TOTAL_SWITCHER_PAGES (SHARED_SWITCHER_PAGES + 2 * nr_cpu_ids)
 
+#ifdef CONFIG_X86_PAE
+/* We map at -2M for ease of mapping into the guest (one PTE page). */
+#define SWITCHER_ADDR 0xFFE00000
+#else
 /* We map at -4M for ease of mapping into the guest (one PTE page). */
 #define SWITCHER_ADDR 0xFFC00000
+#endif
 
 /* Found in switcher.S */
 extern unsigned long default_idt_entries[];
diff --git a/arch/x86/include/asm/lguest_hcall.h b/arch/x86/include/asm/lguest_hcall.h
index 0f4ee71..3860153 100644
--- a/arch/x86/include/asm/lguest_hcall.h
+++ b/arch/x86/include/asm/lguest_hcall.h
@@ -17,6 +17,7 @@
 #define LHCALL_SET_PMD		15
 #define LHCALL_LOAD_TLS		16
 #define LHCALL_NOTIFY		17
+#define LHCALL_SET_PUD		18
 
 #define LGUEST_TRAP_ENTRY 0x1F
 
diff --git a/arch/x86/lguest/Kconfig b/arch/x86/lguest/Kconfig
index 8dab8f7..3871804 100644
--- a/arch/x86/lguest/Kconfig
+++ b/arch/x86/lguest/Kconfig
@@ -2,7 +2,6 @@ config LGUEST_GUEST
 	bool "Lguest guest support"
 	select PARAVIRT
 	depends on X86_32
-	depends on !X86_PAE
 	select VIRTIO
 	select VIRTIO_RING
 	select VIRTIO_CONSOLE
diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
index e94a11e..ce7b010 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -359,8 +359,12 @@ static void lguest_cpuid(unsigned int *ax, unsigned int *bx,
 	case 1:	/* Basic feature request. */
 		/* We only allow kernel to see SSE3, CMPXCHG16B and SSSE3 */
 		*cx &= 0x00002201;
-		/* SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, TSC, FPU. */
+		/* SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, TSC, FPU, PAE. */
+#ifdef CONFIG_X86_PAE
+		*dx &= 0x07808151;
+#else
 		*dx &= 0x07808111;
+#endif
 		/* The Host can do a nice optimization if it knows that the
 		 * kernel mappings (addresses above 0xC0000000 or whatever
 		 * PAGE_OFFSET is set to) haven't changed.  But Linux calls
@@ -518,18 +522,30 @@ static void lguest_pte_update(struct mm_struct *mm, unsigned long addr,
 static void lguest_set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval)
 {
-	*ptep = pteval;
+	native_set_pte(ptep, pteval);
 	lguest_pte_update(mm, addr, ptep);
 }
 
+#ifdef CONFIG_X86_PAE
 /* The Guest calls this to set a top-level entry.  Again, we set the entry then
  * tell the Host which top-level page we changed, and the index of the entry we
  * changed. */
+static void lguest_set_pud(pud_t *pudp, pud_t pudval)
+{
+	native_set_pud (pudp, pudval);
+
+	/* 32 bytes aligned pdpt address. */
+	lazy_hcall2(LHCALL_SET_PUD, __pa(pudp) & 0xFFFFFFE0,
+		   (__pa(pudp) & 0x1F) / sizeof(pud_t));
+}
+#endif
+
+/* The Guest calls this to set a PMD entry, when PAE is active */
 static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
-	*pmdp = pmdval;
+	native_set_pmd (pmdp, pmdval);
 	lazy_hcall2(LHCALL_SET_PMD, __pa(pmdp) & PAGE_MASK,
-		   (__pa(pmdp) & (PAGE_SIZE - 1)) / 4);
+		   (__pa(pmdp) & (PAGE_SIZE - 1)) / sizeof(pmd_t));
 }
 
 /* There are a couple of legacy places where the kernel sets a PTE, but we
@@ -543,11 +559,31 @@ static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
  * which brings boot back to 0.25 seconds. */
 static void lguest_set_pte(pte_t *ptep, pte_t pteval)
 {
-	*ptep = pteval;
+	native_set_pte(ptep, pteval);
+	if (cr3_changed)
+		lazy_hcall1(LHCALL_FLUSH_TLB, 1);
+}
+
+#ifdef CONFIG_X86_PAE
+static void lguest_set_pte_atomic(pte_t *ptep, pte_t pte)
+{
+	native_set_pte_atomic(ptep, pte);
 	if (cr3_changed)
 		lazy_hcall1(LHCALL_FLUSH_TLB, 1);
 }
 
+void lguest_pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	native_pte_clear(mm, addr, ptep);
+	lazy_hcall3(LHCALL_SET_PTE, lguest_data.pgdir, addr, 0);
+}
+
+void lguest_pmd_clear(pmd_t *pmdp)
+{
+	lguest_set_pmd(pmdp, __pmd(0));
+}
+#endif
+
 /* Unfortunately for Lguest, the pv_mmu_ops for page tables were based on
  * native page table operations.  On native hardware you can set a new page
  * table entry whenever you want, but if you want to remove one you have to do
@@ -1017,6 +1053,7 @@ __init void lguest_init(void)
 	pv_info.name = "lguest";
 	pv_info.paravirt_enabled = 1;
 	pv_info.kernel_rpl = 1;
+	pv_info.shared_kernel_pmd = 1;
 
 	/* We set up all the lguest overrides for sensitive operations.  These
 	 * are detailed with the operations themselves. */
@@ -1062,6 +1099,13 @@ __init void lguest_init(void)
 	pv_mmu_ops.set_pte = lguest_set_pte;
 	pv_mmu_ops.set_pte_at = lguest_set_pte_at;
 	pv_mmu_ops.set_pmd = lguest_set_pmd;
+
+#ifdef CONFIG_X86_PAE
+	pv_mmu_ops.set_pte_atomic = lguest_set_pte_atomic;
+	pv_mmu_ops.pte_clear = lguest_pte_clear;
+	pv_mmu_ops.pmd_clear = lguest_pmd_clear;
+	pv_mmu_ops.set_pud = lguest_set_pud;
+#endif
 	pv_mmu_ops.read_cr2 = lguest_read_cr2;
 	pv_mmu_ops.read_cr3 = lguest_read_cr3;
 	pv_mmu_ops.lazy_mode.enter = paravirt_enter_lazy_mmu;
diff --git a/drivers/lguest/Kconfig b/drivers/lguest/Kconfig
index a3d3cba..8f63845 100644
--- a/drivers/lguest/Kconfig
+++ b/drivers/lguest/Kconfig
@@ -1,6 +1,6 @@
 config LGUEST
 	tristate "Linux hypervisor example code"
-	depends on X86_32 && EXPERIMENTAL && !X86_PAE && FUTEX
+	depends on X86_32 && EXPERIMENTAL && FUTEX
 	select HVC_DRIVER
 	---help---
 	  This is a very simple module which allows you to run
diff --git a/drivers/lguest/hypercalls.c b/drivers/lguest/hypercalls.c
index 54d66f0..c5d6678 100644
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -78,6 +78,11 @@ static void do_hcall(struct lg_cpu *cpu, struct hcall_args *args)
 	case LHCALL_SET_PMD:
 		guest_set_pmd(cpu->lg, args->arg1, args->arg2);
 		break;
+#ifdef CONFIG_X86_PAE
+	case LHCALL_SET_PUD:
+		guest_set_pud(cpu->lg, args->arg1, args->arg2);
+		break;
+#endif
 	case LHCALL_SET_CLOCKEVENT:
 		guest_set_clockevent(cpu, args->arg1);
 		break;
diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index ac8a4a3..514a6c0 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -18,7 +18,7 @@ int init_pagetables(struct page **switcher_page, unsigned int pages);
 
 struct pgdir
 {
-	unsigned long gpgdir;
+	pgd_t *gpgdir;
 	pgd_t *pgdir;
 };
 
@@ -137,6 +137,8 @@ int run_guest(struct lg_cpu *cpu, unsigned long __user *user);
  * in the kernel. */
 #define pgd_flags(x)	(pgd_val(x) & ~PAGE_MASK)
 #define pgd_pfn(x)	(pgd_val(x) >> PAGE_SHIFT)
+#define pmd_flags(x)    (pmd_val(x) & ~PAGE_MASK)
+#define pmd_pfn(x)	(pmd_val(x) >> PAGE_SHIFT)
 
 /* interrupts_and_traps.c: */
 void maybe_do_interrupt(struct lg_cpu *cpu);
@@ -168,6 +170,9 @@ int init_guest_pagetable(struct lguest *lg);
 void free_guest_pagetable(struct lguest *lg);
 void guest_new_pagetable(struct lg_cpu *cpu, unsigned long pgtable);
 void guest_set_pmd(struct lguest *lg, unsigned long gpgdir, u32 i);
+#ifdef CONFIG_X86_PAE
+void guest_set_pud(struct lguest *lg, unsigned long gpgdir, u32 i);
+#endif
 void guest_pagetable_clear_all(struct lg_cpu *cpu);
 void guest_pagetable_flush_user(struct lg_cpu *cpu);
 void guest_set_pte(struct lg_cpu *cpu, unsigned long gpgdir,
diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
index a059cf9..77014d8 100644
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -47,12 +47,20 @@
  *  (vii) Setting up the page tables initially.
  :*/
 
+void guest_pagetable_clear_all(struct lg_cpu *cpu);
 
 /* 1024 entries in a page table page maps 1024 pages: 4MB.  The Switcher is
  * conveniently placed at the top 4MB, so it uses a separate, complete PTE
  * page.  */
 #define SWITCHER_PGD_INDEX (PTRS_PER_PGD - 1)
 
+/* For PAE we need the PMD index as well. We can use the last 2MB, so we
+ * will need the last pmd entry of the last pmd page. */
+#ifdef CONFIG_X86_PAE
+
+#define SWITCHER_PMD_INDEX (PTRS_PER_PMD - 1)
+#endif
+
 /* We actually need a separate PTE page for each CPU.  Remember that after the
  * Switcher code itself comes two pages for each CPU, and we don't want this
  * CPU's guest to see the pages of any other CPU. */
@@ -73,39 +81,90 @@ static pgd_t *spgd_addr(struct lg_cpu *cpu, u32 i, unsigned long vaddr)
 {
 	unsigned int index = pgd_index(vaddr);
 
+#ifndef CONFIG_X86_PAE
 	/* We kill any Guest trying to touch the Switcher addresses. */
 	if (index >= SWITCHER_PGD_INDEX) {
 		kill_guest(cpu, "attempt to access switcher pages");
 		index = 0;
 	}
+#endif
 	/* Return a pointer index'th pgd entry for the i'th page table. */
 	return &cpu->lg->pgdirs[i].pgdir[index];
 }
 
+#ifdef CONFIG_X86_PAE
+/* This routine then takes the PGD entry given above, which contains the
+ * address of the PMD page.  It then returns a pointer to the PMD entry for the
+ * given address. */
+static pmd_t *spmd_addr(struct lg_cpu *cpu, pgd_t spgd, unsigned long vaddr)
+{
+	unsigned int index = pmd_index(vaddr);
+	pmd_t *page;
+
+	/* We kill any Guest trying to touch the Switcher addresses. */
+	if (pgd_index(vaddr) == SWITCHER_PGD_INDEX &&
+					index >= SWITCHER_PMD_INDEX) {
+		kill_guest(cpu, "attempt to access switcher pages");
+		index = 0;
+	}
+
+	/* You should never call this if the PGD entry wasn't valid */
+	BUG_ON(!(pgd_flags(spgd) & _PAGE_PRESENT));
+
+	page = __va(pgd_pfn(spgd) << PAGE_SHIFT);
+	return &page[index];
+}
+#endif
+
 /* This routine then takes the page directory entry returned above, which
  * contains the address of the page table entry (PTE) page.  It then returns a
  * pointer to the PTE entry for the given address. */
-static pte_t *spte_addr(pgd_t spgd, unsigned long vaddr)
+static pte_t *spte_addr(struct lg_cpu *cpu, pgd_t spgd, unsigned long vaddr)
 {
+#ifdef CONFIG_X86_PAE
+	pmd_t *pmd = spmd_addr(cpu, spgd, vaddr);
+	pte_t *page = __va(pmd_pfn(*pmd) << PAGE_SHIFT);
+
+	/* You should never call this if the PMD entry wasn't valid */
+	BUG_ON(!(pmd_flags(*pmd) & _PAGE_PRESENT));
+#else
 	pte_t *page = __va(pgd_pfn(spgd) << PAGE_SHIFT);
+
 	/* You should never call this if the PGD entry wasn't valid */
 	BUG_ON(!(pgd_flags(spgd) & _PAGE_PRESENT));
-	return &page[(vaddr >> PAGE_SHIFT) % PTRS_PER_PTE];
+#endif
+	return &page[pte_index(vaddr)];
 }
 
 /* These two functions just like the above two, except they access the Guest
  * page tables.  Hence they return a Guest address. */
-static unsigned long gpgd_addr(struct lg_cpu *cpu, unsigned long vaddr)
+static pgd_t *gpgd_addr(struct lg_cpu *cpu, unsigned long vaddr)
 {
 	unsigned int index = vaddr >> (PGDIR_SHIFT);
-	return cpu->lg->pgdirs[cpu->cpu_pgd].gpgdir + index * sizeof(pgd_t);
+	return cpu->lg->pgdirs[cpu->cpu_pgd].gpgdir + index;
+}
+
+#ifdef CONFIG_X86_PAE
+static unsigned long gpmd_addr(pgd_t gpgd, unsigned long vaddr)
+{
+	unsigned long gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
+	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
+	return gpage + pmd_index(vaddr) * sizeof(pmd_t);
 }
+#endif
 
-static unsigned long gpte_addr(pgd_t gpgd, unsigned long vaddr)
+static unsigned long gpte_addr(struct lg_cpu *cpu,
+				pgd_t gpgd, unsigned long vaddr)
 {
+#ifdef CONFIG_X86_PAE
+	pmd_t gpmd = lgread(cpu,
+		(unsigned long) gpmd_addr(gpgd, vaddr), pmd_t);
+	unsigned long gpage = pmd_pfn(gpmd) << PAGE_SHIFT;
+#else
 	unsigned long gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
 	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
-	return gpage + ((vaddr>>PAGE_SHIFT) % PTRS_PER_PTE) * sizeof(pte_t);
+#endif
+	return gpage + pte_index(vaddr) * sizeof(pte_t);
 }
 /*:*/
 
@@ -184,11 +243,24 @@ static void check_gpte(struct lg_cpu *cpu, pte_t gpte)
 
 static void check_gpgd(struct lg_cpu *cpu, pgd_t gpgd)
 {
+#ifdef CONFIG_X86_PAE
+	if ((pgd_flags(gpgd) & ~_PAGE_PRESENT) ||
+#else
 	if ((pgd_flags(gpgd) & ~_PAGE_TABLE) ||
+#endif
 	   (pgd_pfn(gpgd) >= cpu->lg->pfn_limit))
 		kill_guest(cpu, "bad page directory entry");
 }
 
+#ifdef CONFIG_X86_PAE
+static void check_gpmd(struct lg_cpu *cpu, pmd_t gpmd)
+{
+	if ((pmd_flags(gpmd) & ~_PAGE_TABLE) ||
+	   (pmd_pfn(gpmd) >= cpu->lg->pfn_limit))
+		kill_guest(cpu, "bad page middle directory entry");
+}
+#endif
+
 /*H:330
  * (i) Looking up a page table entry when the Guest faults.
  *
@@ -207,8 +279,14 @@ bool demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
 	pte_t gpte;
 	pte_t *spte;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t *spmd;
+	pmd_t gpmd;
+#endif
+
 	/* First step: get the top-level Guest page table entry. */
-	gpgd = lgread(cpu, gpgd_addr(cpu, vaddr), pgd_t);
+	gpgd = lgread(cpu, (unsigned long) gpgd_addr(cpu, vaddr), pgd_t);
+
 	/* Toplevel not present?  We can't map it in. */
 	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
 		return false;
@@ -231,9 +309,38 @@ bool demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
 		*spgd = __pgd(__pa(ptepage) | pgd_flags(gpgd));
 	}
 
+#ifdef CONFIG_X86_PAE
+	gpmd = lgread(cpu, (unsigned long) gpmd_addr(gpgd, vaddr), pmd_t);
+	/* middle level not present?  We can't map it in. */
+	if (!(pmd_flags(gpmd) & _PAGE_PRESENT))
+		return 0;
+
+	/* Now look at the matching shadow entry. */
+	spmd = spmd_addr(cpu, *spgd, vaddr);
+
+	if (!(pmd_flags(*spmd) & _PAGE_PRESENT)) {
+		/* No shadow entry: allocate a new shadow PTE page. */
+		unsigned long ptepage = get_zeroed_page(GFP_KERNEL);
+
+		/* This is not really the Guest's fault, but killing it is
+		* simple for this corner case. */
+		if (!ptepage) {
+			kill_guest(cpu, "out of memory allocating pte page");
+			return 0;
+		}
+
+		/* We check that the Guest pmd is OK. */
+		check_gpmd(cpu, gpmd);
+
+		/* And we copy the flags to the shadow PMD entry.  The page
+		 * number in the shadow PMD is the page we just allocated. */
+		*spmd = __pmd(__pa(ptepage) | pmd_flags(gpmd));
+	}
+#endif
+
 	/* OK, now we look at the lower level in the Guest page table: keep its
 	 * address, because we might update it later. */
-	gpte_ptr = gpte_addr(gpgd, vaddr);
+	gpte_ptr = gpte_addr(cpu, gpgd, vaddr);
 	gpte = lgread(cpu, gpte_ptr, pte_t);
 
 	/* If this page isn't in the Guest page tables, we can't page it in. */
@@ -259,7 +366,7 @@ bool demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
 		gpte = pte_mkdirty(gpte);
 
 	/* Get the pointer to the shadow PTE entry we're going to set. */
-	spte = spte_addr(*spgd, vaddr);
+	spte = spte_addr(cpu, *spgd, vaddr);
 	/* If there was a valid shadow PTE entry here before, we release it.
 	 * This can happen with a write to a previously read-only entry. */
 	release_pte(*spte);
@@ -301,14 +408,24 @@ static bool page_writable(struct lg_cpu *cpu, unsigned long vaddr)
 	pgd_t *spgd;
 	unsigned long flags;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t *spmd;
+#endif
+
 	/* Look at the current top level entry: is it present? */
 	spgd = spgd_addr(cpu, cpu->cpu_pgd, vaddr);
 	if (!(pgd_flags(*spgd) & _PAGE_PRESENT))
 		return false;
 
+#ifdef CONFIG_X86_PAE
+	spmd = spmd_addr(cpu, *spgd, vaddr);
+	if (!(pmd_flags(*spmd) & _PAGE_PRESENT))
+		return false;
+#endif
+
 	/* Check the flags on the pte entry itself: it must be present and
 	 * writable. */
-	flags = pte_flags(*(spte_addr(*spgd, vaddr)));
+	flags = pte_flags(*(spte_addr(cpu, *spgd, vaddr)));
 
 	return (flags & (_PAGE_PRESENT|_PAGE_RW)) == (_PAGE_PRESENT|_PAGE_RW);
 }
@@ -322,8 +439,45 @@ void pin_page(struct lg_cpu *cpu, unsigned long vaddr)
 		kill_guest(cpu, "bad stack page %#lx", vaddr);
 }
 
+#ifdef CONFIG_X86_PAE
+static void release_pmd(pmd_t *spmd)
+{
+	/* If the entry's not present, there's nothing to release. */
+	if (pmd_flags(*spmd) & _PAGE_PRESENT) {
+		unsigned int i;
+		pte_t *ptepage = __va(pmd_pfn(*spmd) << PAGE_SHIFT);
+		/* For each entry in the page, we might need to release it. */
+		for (i = 0; i < PTRS_PER_PTE; i++)
+			release_pte(ptepage[i]);
+		/* Now we can free the page of PTEs */
+		free_page((long)ptepage);
+		/* And zero out the PMD entry so we never release it twice. */
+		native_set_pmd(spmd, __pmd(0));
+	}
+}
+
+/*H:450 If we chase down the release_pgd() code, it looks like this: */
+static void release_pgd(pgd_t *spgd)
+{
+	/* If the entry's not present, there's nothing to release. */
+		if (pgd_flags(*spgd) & _PAGE_PRESENT) {
+		unsigned int i;
+		pmd_t *pmdpage = __va(pgd_pfn(*spgd) << PAGE_SHIFT);
+
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			release_pmd(&pmdpage[i]);
+
+		/* Now we can free the page of PMDs */
+		free_page((long)pmdpage);
+		/* And zero out the PGD entry so we never release it twice. */
+		native_set_pud ((pud_t *)spgd, __pud(0));
+	}
+}
+
+#else /* !CONFIG_X86_PAE */
+
 /*H:450 If we chase down the release_pgd() code, it looks like this: */
-static void release_pgd(struct lguest *lg, pgd_t *spgd)
+static void release_pgd(pgd_t *spgd)
 {
 	/* If the entry's not present, there's nothing to release. */
 	if (pgd_flags(*spgd) & _PAGE_PRESENT) {
@@ -342,15 +496,18 @@ static void release_pgd(struct lguest *lg, pgd_t *spgd)
 	}
 }
 
+#endif
+
 /*H:445 We saw flush_user_mappings() twice: once from the flush_user_mappings()
  * hypercall and once in new_pgdir() when we re-used a top-level pgdir page.
  * It simply releases every PTE page from 0 up to the Guest's kernel address. */
 static void flush_user_mappings(struct lguest *lg, int idx)
 {
 	unsigned int i;
+
 	/* Release every pgd entry up to the kernel's address. */
 	for (i = 0; i < pgd_index(lg->kernel_address); i++)
-		release_pgd(lg, lg->pgdirs[idx].pgdir + i);
+		release_pgd(lg->pgdirs[idx].pgdir + i);
 }
 
 /*H:440 (v) Flushing (throwing away) page tables,
@@ -370,15 +527,30 @@ unsigned long guest_pa(struct lg_cpu *cpu, unsigned long vaddr)
 	pgd_t gpgd;
 	pte_t gpte;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t gpmd;
+#endif
+
+
 	/* First step: get the top-level Guest page table entry. */
-	gpgd = lgread(cpu, gpgd_addr(cpu, vaddr), pgd_t);
+	gpgd = lgread(cpu, (unsigned long) gpgd_addr(cpu, vaddr), pgd_t);
 	/* Toplevel not present?  We can't map it in. */
 	if (!(pgd_flags(gpgd) & _PAGE_PRESENT)) {
 		kill_guest(cpu, "Bad address %#lx", vaddr);
 		return -1UL;
 	}
 
-	gpte = lgread(cpu, gpte_addr(gpgd, vaddr), pte_t);
+	gpte = lgread(cpu, gpte_addr(cpu, gpgd, vaddr), pte_t);
+
+#ifdef CONFIG_X86_PAE
+	gpmd = lgread(cpu, (unsigned long) gpmd_addr(gpgd, vaddr), pmd_t);
+	if (!(pmd_flags(gpmd) & _PAGE_PRESENT))
+		kill_guest(cpu, "Bad address %#lx", vaddr);
+#endif
+
+	gpte = lgread(cpu, (unsigned long) gpte_addr(cpu, gpgd, vaddr), pte_t);
+
+
 	if (!(pte_flags(gpte) & _PAGE_PRESENT))
 		kill_guest(cpu, "Bad address %#lx", vaddr);
 
@@ -388,7 +560,7 @@ unsigned long guest_pa(struct lg_cpu *cpu, unsigned long vaddr)
 /* We keep several page tables.  This is a simple routine to find the page
  * table (if any) corresponding to this top-level address the Guest has given
  * us. */
-static unsigned int find_pgdir(struct lguest *lg, unsigned long pgtable)
+static unsigned int find_pgdir(struct lguest *lg, pgd_t *pgtable)
 {
 	unsigned int i;
 	for (i = 0; i < ARRAY_SIZE(lg->pgdirs); i++)
@@ -401,10 +573,13 @@ static unsigned int find_pgdir(struct lguest *lg, unsigned long pgtable)
  * allocate a new one (and so the kernel parts are not there), we set
  * blank_pgdir. */
 static unsigned int new_pgdir(struct lg_cpu *cpu,
-			      unsigned long gpgdir,
+			      pgd_t *gpgdir,
 			      int *blank_pgdir)
 {
 	unsigned int next;
+#ifdef CONFIG_X86_PAE
+	pmd_t *pmd_table;
+#endif
 
 	/* We pick one entry at random to throw out.  Choosing the Least
 	 * Recently Used might be better, but this is easy. */
@@ -413,13 +588,36 @@ static unsigned int new_pgdir(struct lg_cpu *cpu,
 	if (!cpu->lg->pgdirs[next].pgdir) {
 		cpu->lg->pgdirs[next].pgdir =
 					(pgd_t *)get_zeroed_page(GFP_KERNEL);
+
 		/* If the allocation fails, just keep using the one we have */
 		if (!cpu->lg->pgdirs[next].pgdir)
 			next = cpu->cpu_pgd;
+
+#ifdef CONFIG_X86_PAE
+		else {
+			/* In PAE mode, allocate a pmd page and populate the
+			 * last pgd entry. */
+			pmd_table = (pmd_t *) get_zeroed_page(GFP_KERNEL);
+			if (!pmd_table){
+				free_page ((long) cpu->lg->pgdirs[next].pgdir);
+				native_set_pud((pud_t *)cpu->lg->pgdirs[next].pgdir, __pud(0));
+				next = cpu->cpu_pgd;
+			}
+			else {
+
+				native_set_pud((pud_t *) cpu->lg->pgdirs[next].pgdir +
+						SWITCHER_PGD_INDEX,
+				     __pud(__pa(pmd_table) | _PAGE_PRESENT));
+
+				/* This is a blank page, so there are no kernel
+				 * mappings: caller must map the stack! */
+				*blank_pgdir = 1;
+			}
+		}
+#else
 		else
-			/* This is a blank page, so there are no kernel
-			 * mappings: caller must map the stack! */
 			*blank_pgdir = 1;
+#endif
 	}
 	/* Record which Guest toplevel this shadows. */
 	cpu->lg->pgdirs[next].gpgdir = gpgdir;
@@ -431,7 +629,7 @@ static unsigned int new_pgdir(struct lg_cpu *cpu,
 
 /*H:430 (iv) Switching page tables
  *
- * Now we've seen all the page table setting and manipulation, let's see what
+ * Now we've seen all the page table setting and manipulation, let's see
  * what happens when the Guest changes page tables (ie. changes the top-level
  * pgdir).  This occurs on almost every context switch. */
 void guest_new_pagetable(struct lg_cpu *cpu, unsigned long pgtable)
@@ -439,11 +637,11 @@ void guest_new_pagetable(struct lg_cpu *cpu, unsigned long pgtable)
 	int newpgdir, repin = 0;
 
 	/* Look to see if we have this one already. */
-	newpgdir = find_pgdir(cpu->lg, pgtable);
+	newpgdir = find_pgdir(cpu->lg, (pgd_t *)pgtable);
 	/* If not, we allocate or mug an existing one: if it's a fresh one,
 	 * repin gets set to 1. */
 	if (newpgdir == ARRAY_SIZE(cpu->lg->pgdirs))
-		newpgdir = new_pgdir(cpu, pgtable, &repin);
+		newpgdir = new_pgdir(cpu, (pgd_t *)pgtable, &repin);
 	/* Change the current pgd index to the new one. */
 	cpu->cpu_pgd = newpgdir;
 	/* If it was completely blank, we map in the Guest kernel stack */
@@ -456,14 +654,30 @@ void guest_new_pagetable(struct lg_cpu *cpu, unsigned long pgtable)
  * when we destroy the Guest. */
 static void release_all_pagetables(struct lguest *lg)
 {
-	unsigned int i, j;
+	unsigned int i, j, k;
+
+#ifdef CONFIG_X86_PAE
+	pgd_t *spgd;
+	pmd_t *pmdpage;
+#endif
 
 	/* Every shadow pagetable this Guest has */
 	for (i = 0; i < ARRAY_SIZE(lg->pgdirs); i++)
-		if (lg->pgdirs[i].pgdir)
+		if (lg->pgdirs[i].pgdir) {
 			/* Every PGD entry except the Switcher at the top */
 			for (j = 0; j < SWITCHER_PGD_INDEX; j++)
-				release_pgd(lg, lg->pgdirs[i].pgdir + j);
+				release_pgd(lg->pgdirs[i].pgdir + j);
+#ifdef CONFIG_X86_PAE
+			/* Get the last pmd page. */
+			spgd = lg->pgdirs[i].pgdir + SWITCHER_PGD_INDEX;
+			pmdpage = __va(pgd_pfn(*spgd) << PAGE_SHIFT);
+
+			/* And release the pmd entries of that pmd page,
+			 * except for the switcher pmd. */
+			for (k = 0; k < SWITCHER_PMD_INDEX; k++)
+				release_pmd(&pmdpage[k]);
+#endif
+		}
 }
 
 /* We also throw away everything when a Guest tells us it's changed a kernel
@@ -505,23 +719,39 @@ static void do_set_pte(struct lg_cpu *cpu, int idx,
 	/* Look up the matching shadow page directory entry. */
 	pgd_t *spgd = spgd_addr(cpu, idx, vaddr);
 
+#ifdef CONFIG_X86_PAE
+	pmd_t *spmd;
+#endif
+
 	/* If the top level isn't present, there's no entry to update. */
 	if (pgd_flags(*spgd) & _PAGE_PRESENT) {
-		/* Otherwise, we start by releasing the existing entry. */
-		pte_t *spte = spte_addr(*spgd, vaddr);
-		release_pte(*spte);
-
-		/* If they're setting this entry as dirty or accessed, we might
-		 * as well put that entry they've given us in now.  This shaves
-		 * 10% off a copy-on-write micro-benchmark. */
-		if (pte_flags(gpte) & (_PAGE_DIRTY | _PAGE_ACCESSED)) {
-			check_gpte(cpu, gpte);
-			*spte = gpte_to_spte(cpu, gpte,
-					     pte_flags(gpte) & _PAGE_DIRTY);
-		} else
-			/* Otherwise kill it and we can demand_page() it in
-			 * later. */
-			*spte = __pte(0);
+
+#ifdef CONFIG_X86_PAE
+		spmd = spmd_addr(cpu, *spgd, vaddr);
+		if (pmd_flags(*spmd) & _PAGE_PRESENT) {
+#endif
+
+			/* Otherwise, we start by releasing
+			 * the existing entry. */
+			pte_t *spte = spte_addr(cpu, *spgd, vaddr);
+			release_pte(*spte);
+
+			/* If they're setting this entry as dirty or accessed,
+			 *  we might as well put that entry they've given us
+			 * in now.  This shaves 10% off a
+			 * copy-on-write micro-benchmark. */
+			if (pte_flags(gpte) & (_PAGE_DIRTY | _PAGE_ACCESSED)) {
+				check_gpte(cpu, gpte);
+				native_set_pte (spte, 
+						gpte_to_spte(cpu, gpte,
+						pte_flags(gpte) & _PAGE_DIRTY));
+			} else
+				/* Otherwise kill it and we can demand_page()
+				 * it in later. */
+				native_set_pte (spte, __pte(0));
+#ifdef CONFIG_X86_PAE
+		}
+#endif
 	}
 }
 
@@ -547,7 +777,7 @@ void guest_set_pte(struct lg_cpu *cpu,
 				do_set_pte(cpu, i, vaddr, gpte);
 	} else {
 		/* Is this page table one we have a shadow for? */
-		int pgdir = find_pgdir(cpu->lg, gpgdir);
+		int pgdir = find_pgdir(cpu->lg, (pgd_t *)gpgdir);
 		if (pgdir != ARRAY_SIZE(cpu->lg->pgdirs))
 			/* If so, do the update. */
 			do_set_pte(cpu, pgdir, vaddr, gpte);
@@ -568,9 +798,38 @@ void guest_set_pte(struct lg_cpu *cpu,
  *
  * So with that in mind here's our code to to update a (top-level) PGD entry:
  */
-void guest_set_pmd(struct lguest *lg, unsigned long gpgdir, u32 idx)
+
+#ifdef CONFIG_X86_PAE
+void guest_set_pud(struct lguest *lg, unsigned long pudp, u32 idx)
+{
+	int pgdir;
+	pgd_t *gpgdir = (pgd_t *) pudp;
+
+	if (idx >= SWITCHER_PGD_INDEX){
+		printk ("tryied to map on the last pgd entry\n");
+		return;
+	
+	}
+
+	/* If they're talking about a page table we have a shadow for... */
+	pgdir = find_pgdir(lg, gpgdir);
+	if (pgdir < ARRAY_SIZE(lg->pgdirs))
+		/* ... throw it away. */
+		release_pgd(lg->pgdirs[pgdir].pgdir + idx);
+
+}
+
+void guest_set_pmd(struct lguest *lg, unsigned long pmdp, u32 idx)
+{
+	guest_pagetable_clear_all(&lg->cpus[0]); //ugly
+}
+
+#else /*!CONFIG_X86_PAE*/
+
+void guest_set_pmd(struct lguest *lg, unsigned long pmdp, u32 idx)
 {
 	int pgdir;
+	pgd_t *gpgdir = (pgd_t *) pmdp;
 
 	/* The kernel seems to try to initialize this early on: we ignore its
 	 * attempts to map over the Switcher. */
@@ -581,8 +840,9 @@ void guest_set_pmd(struct lguest *lg, unsigned long gpgdir, u32 idx)
 	pgdir = find_pgdir(lg, gpgdir);
 	if (pgdir < ARRAY_SIZE(lg->pgdirs))
 		/* ... throw it away. */
-		release_pgd(lg, lg->pgdirs[pgdir].pgdir + idx);
+		release_pgd(lg->pgdirs[pgdir].pgdir + idx);
 }
+#endif
 
 /* Once we know how much memory we have we can construct simple identity
  * (which set virtual == physical) and linear mappings
@@ -596,8 +856,14 @@ static unsigned long setup_pagetables(struct lguest *lg,
 {
 	pgd_t __user *pgdir;
 	pte_t __user *linear;
-	unsigned int mapped_pages, i, linear_pages, phys_linear;
 	unsigned long mem_base = (unsigned long)lg->mem_base;
+ 	unsigned int mapped_pages, i, linear_pages;
+#ifdef CONFIG_X86_PAE
+	u64 *pmds;
+	unsigned int j;
+#else
+	unsigned int phys_linear;
+#endif	
 
 	/* We have mapped_pages frames to map, so we need
 	 * linear_pages page tables to map them. */
@@ -609,6 +875,9 @@ static unsigned long setup_pagetables(struct lguest *lg,
 
 	/* Now we use the next linear_pages pages as pte pages */
 	linear = (void *)pgdir - linear_pages * PAGE_SIZE;
+#ifdef CONFIG_X86_PAE
+	pmds = (void *)linear - PAGE_SIZE;
+#endif
 
 	/* Linear mapping is easy: put every page's address into the
 	 * mapping in order. */
@@ -619,8 +888,26 @@ static unsigned long setup_pagetables(struct lguest *lg,
 			return -EFAULT;
 	}
 
+#ifdef CONFIG_X86_PAE
 	/* The top level points to the linear page table pages above.
 	 * We setup the identity and linear mappings here. */
+	for (i = 0, j = 0; i < mapped_pages; i += PTRS_PER_PTE, j++) {
+		pmd_t pmd;
+		pmd = __pmd( ((unsigned long)(linear+i) - mem_base) |
+			_PAGE_PRESENT | _PAGE_RW | _PAGE_USER);
+		if (copy_to_user(&pmds[j], &pmd, sizeof(pmd)) != 0)
+			return -EFAULT;
+	}
+	pgd_t pgd;
+	pgd = __pgd((((u32)pmds) - mem_base) | _PAGE_PRESENT);
+
+	if (copy_to_user(&pgdir[0], &pgd, sizeof(pgd)) != 0)
+		return -EFAULT;
+
+	if (copy_to_user(&pgdir[3], &pgd, sizeof(pgd)) != 0)
+		return -EFAULT;
+
+#else
 	phys_linear = (unsigned long)linear - mem_base;
 	for (i = 0; i < mapped_pages; i += PTRS_PER_PTE) {
 		pgd_t pgd;
@@ -633,6 +920,7 @@ static unsigned long setup_pagetables(struct lguest *lg,
 				    &pgd, sizeof(pgd)))
 			return -EFAULT;
 	}
+#endif
 
 	/* We return the top level (guest-physical) address: remember where
 	 * this is. */
@@ -648,6 +936,10 @@ int init_guest_pagetable(struct lguest *lg)
 	u64 mem;
 	u32 initrd_size;
 	struct boot_params __user *boot = (struct boot_params *)lg->mem_base;
+#ifdef CONFIG_X86_PAE
+	pgd_t *pgd;
+	pmd_t *pmd_table;
+#endif
 
 	/* Get the Guest memory size and the ramdisk size from the boot header
 	 * located at lg->mem_base (Guest address 0). */
@@ -657,12 +949,23 @@ int init_guest_pagetable(struct lguest *lg)
 
 	/* We start on the first shadow page table, and give it a blank PGD
 	 * page. */
-	lg->pgdirs[0].gpgdir = setup_pagetables(lg, mem, initrd_size);
-	if (IS_ERR_VALUE(lg->pgdirs[0].gpgdir))
-		return lg->pgdirs[0].gpgdir;
+	lg->pgdirs[0].gpgdir = (pgd_t *) setup_pagetables(lg, mem, initrd_size);
+	if (IS_ERR_VALUE((int) lg->pgdirs[0].gpgdir))
+		return (int) lg->pgdirs[0].gpgdir;
 	lg->pgdirs[0].pgdir = (pgd_t *)get_zeroed_page(GFP_KERNEL);
 	if (!lg->pgdirs[0].pgdir)
 		return -ENOMEM;
+#ifdef CONFIG_X86_PAE
+	pgd = lg->pgdirs[0].pgdir;
+	pmd_table = (pmd_t *) get_zeroed_page(GFP_KERNEL);
+	if (!pmd_table)
+		return -ENOMEM;
+
+	native_set_pud((pud_t *) pgd + SWITCHER_PGD_INDEX,
+			__pud(__pa(pmd_table) | _PAGE_PRESENT));
+
+#endif
+
 	lg->cpus[0].cpu_pgd = 0;
 	return 0;
 }
@@ -670,21 +973,36 @@ int init_guest_pagetable(struct lguest *lg)
 /* When the Guest calls LHCALL_LGUEST_INIT we do more setup. */
 void page_table_guest_data_init(struct lg_cpu *cpu)
 {
+#ifdef CONFIG_X86_PAE
+	const unsigned long reserve_mb = 2;
+#else
+	const unsigned long reserve_mb = 4;
+#endif
+
 	/* We get the kernel address: above this is all kernel memory. */
 	if (get_user(cpu->lg->kernel_address,
-		     &cpu->lg->lguest_data->kernel_address)
-	    /* We tell the Guest that it can't use the top 4MB of virtual
-	     * addresses used by the Switcher. */
-	    || put_user(4U*1024*1024, &cpu->lg->lguest_data->reserve_mem)
-	    || put_user(cpu->lg->pgdirs[0].gpgdir, &cpu->lg->lguest_data->pgdir))
+		&cpu->lg->lguest_data->kernel_address)
+		/* We tell the Guest that it can't use the top 2 or 4 MB
+		 * of virtual addresses used by the Switcher. */
+		|| put_user(reserve_mb * 1024 * 1024,
+			&cpu->lg->lguest_data->reserve_mem)
+		|| put_user((unsigned long) cpu->lg->pgdirs[0].gpgdir,
+					&cpu->lg->lguest_data->pgdir))
 		kill_guest(cpu, "bad guest page %p", cpu->lg->lguest_data);
 
 	/* In flush_user_mappings() we loop from 0 to
 	 * "pgd_index(lg->kernel_address)".  This assumes it won't hit the
 	 * Switcher mappings, so check that now. */
+#ifdef CONFIG_X86_PAE
+	if (pgd_index(cpu->lg->kernel_address) == SWITCHER_PGD_INDEX)
+		if (pmd_index(cpu->lg->kernel_address) == SWITCHER_PMD_INDEX)
+			kill_guest(cpu, "bad kernel address %#lx",
+					cpu->lg->kernel_address);
+#else
 	if (pgd_index(cpu->lg->kernel_address) >= SWITCHER_PGD_INDEX)
 		kill_guest(cpu, "bad kernel address %#lx",
 				 cpu->lg->kernel_address);
+#endif
 }
 
 /* When a Guest dies, our cleanup is fairly simple. */
@@ -708,15 +1026,28 @@ void free_guest_pagetable(struct lguest *lg)
 void map_switcher_in_guest(struct lg_cpu *cpu, struct lguest_pages *pages)
 {
 	pte_t *switcher_pte_page = __get_cpu_var(switcher_pte_pages);
-	pgd_t switcher_pgd;
 	pte_t regs_pte;
 	unsigned long pfn;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t switcher_pmd;
+	pmd_t *pmd_table;
+
+	switcher_pmd = pfn_pmd(__pa(switcher_pte_page) >>
+				PAGE_SHIFT, __pgprot(__PAGE_KERNEL));
+	pmd_table = __va(pgd_pfn(cpu->lg->
+			pgdirs[cpu->cpu_pgd].pgdir[SWITCHER_PGD_INDEX])
+								<< PAGE_SHIFT);
+	pmd_table[SWITCHER_PMD_INDEX] = switcher_pmd;
+
+#else
+	pgd_t switcher_pgd;
+
 	/* Make the last PGD entry for this Guest point to the Switcher's PTE
 	 * page for this CPU (with appropriate flags). */
 	switcher_pgd = __pgd(__pa(switcher_pte_page) | __PAGE_KERNEL);
-
 	cpu->lg->pgdirs[cpu->cpu_pgd].pgdir[SWITCHER_PGD_INDEX] = switcher_pgd;
+#endif
 
 	/* We also change the Switcher PTE page.  When we're running the Guest,
 	 * we want the Guest's "regs" page to appear where the first Switcher
@@ -727,7 +1058,8 @@ void map_switcher_in_guest(struct lg_cpu *cpu, struct lguest_pages *pages)
 	 * again. */
 	pfn = __pa(cpu->regs_page) >> PAGE_SHIFT;
 	regs_pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL));
-	switcher_pte_page[(unsigned long)pages/PAGE_SIZE%PTRS_PER_PTE] = regs_pte;
+	switcher_pte_page[(unsigned long)pages / PAGE_SIZE % PTRS_PER_PTE]
+								= regs_pte;
 }
 /*:*/
 
@@ -752,21 +1084,23 @@ static __init void populate_switcher_pte_page(unsigned int cpu,
 
 	/* The first entries are easy: they map the Switcher code. */
 	for (i = 0; i < pages; i++) {
-		pte[i] = mk_pte(switcher_page[i],
-				__pgprot(_PAGE_PRESENT|_PAGE_ACCESSED));
+		native_set_pte(&pte[i], mk_pte(switcher_page[i],
+				__pgprot(_PAGE_PRESENT|_PAGE_ACCESSED)));
 	}
 
 	/* The only other thing we map is this CPU's pair of pages. */
 	i = pages + cpu*2;
 
 	/* First page (Guest registers) is writable from the Guest */
-	pte[i] = pfn_pte(page_to_pfn(switcher_page[i]),
-			 __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED|_PAGE_RW));
+	native_set_pte(&pte[i], pfn_pte(page_to_pfn(switcher_page[i]),
+			 __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED|_PAGE_RW)));
 
 	/* The second page contains the "struct lguest_ro_state", and is
 	 * read-only. */
-	pte[i+1] = pfn_pte(page_to_pfn(switcher_page[i+1]),
-			   __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED));
+	native_set_pte(&pte[i+1],pfn_pte(page_to_pfn(switcher_page[i+1]),
+			   __pgprot(_PAGE_PRESENT|_PAGE_ACCESSED)) );
+
+// look rules for set_pte at pgtable-3level.h
 }
 
 /* We've made it through the page table code.  Perhaps our tired brains are
