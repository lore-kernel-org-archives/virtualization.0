From: Matias Zabaljauregui <zabaljauregui@gmail.com>
Subject: [PATCH] lguest: PAE support
Date: Fri, 05 Jun 2009 13:09:02 -0300
Message-ID: <1244218142.7700.24.camel@zetabook>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi, this version requires that host and guest have the same PAE status.
NX cap is not offered to the guest, yet.


Thanks,
Matias



Lguest PAE support

Signed-off-by: Matias Zabaljauregui <zabaljauregui@gmail.com>

---
 Documentation/lguest/lguest.txt     |    1 -
 arch/x86/include/asm/lguest.h       |    7 +-
 arch/x86/include/asm/lguest_hcall.h |    3 +-
 arch/x86/lguest/Kconfig             |    1 -
 arch/x86/lguest/boot.c              |   79 +++++++-
 drivers/lguest/Kconfig              |    2 +-
 drivers/lguest/hypercalls.c         |   10 +
 drivers/lguest/lg.h                 |    5 +
 drivers/lguest/page_tables.c        |  356 +++++++++++++++++++++++++++++++----
 9 files changed, 410 insertions(+), 54 deletions(-)

diff --git a/Documentation/lguest/lguest.txt b/Documentation/lguest/lguest.txt
index 28c7473..efb3a6a 100644
--- a/Documentation/lguest/lguest.txt
+++ b/Documentation/lguest/lguest.txt
@@ -37,7 +37,6 @@ Running Lguest:
      "Paravirtualized guest support" = Y
         "Lguest guest support" = Y
      "High Memory Support" = off/4GB
-     "PAE (Physical Address Extension) Support" = N
      "Alignment value to which kernel should be aligned" = 0x100000
         (CONFIG_PARAVIRT=y, CONFIG_LGUEST_GUEST=y, CONFIG_HIGHMEM64G=n and
          CONFIG_PHYSICAL_ALIGN=0x100000)
diff --git a/arch/x86/include/asm/lguest.h b/arch/x86/include/asm/lguest.h
index 1caf576..313389c 100644
--- a/arch/x86/include/asm/lguest.h
+++ b/arch/x86/include/asm/lguest.h
@@ -17,8 +17,13 @@
 /* Pages for switcher itself, then two pages per cpu */
 #define TOTAL_SWITCHER_PAGES (SHARED_SWITCHER_PAGES + 2 * nr_cpu_ids)
 
-/* We map at -4M for ease of mapping into the guest (one PTE page). */
+/* We map at -4M (-2M when PAE is activated) for ease of mapping
+ * into the guest (one PTE page). */
+#ifdef CONFIG_X86_PAE
+#define SWITCHER_ADDR 0xFFE00000
+#else
 #define SWITCHER_ADDR 0xFFC00000
+#endif
 
 /* Found in switcher.S */
 extern unsigned long default_idt_entries[];
diff --git a/arch/x86/include/asm/lguest_hcall.h b/arch/x86/include/asm/lguest_hcall.h
index 553810f..7ba1d81 100644
--- a/arch/x86/include/asm/lguest_hcall.h
+++ b/arch/x86/include/asm/lguest_hcall.h
@@ -12,6 +12,7 @@
 #define LHCALL_TS		8
 #define LHCALL_SET_CLOCKEVENT	9
 #define LHCALL_HALT		10
+#define LHCALL_SET_PMD		13
 #define LHCALL_SET_PTE		14
 #define LHCALL_SET_PGD		15
 #define LHCALL_LOAD_TLS		16
@@ -32,7 +33,7 @@
  * operations?  There are two ways: the direct way is to make a "hypercall",
  * to make requests of the Host Itself.
  *
- * We use the KVM hypercall mechanism. Eighteen hypercalls are
+ * We use the KVM hypercall mechanism. Sixteen hypercalls are
  * available: the hypercall number is put in the %eax register, and the
  * arguments (when required) are placed in %ebx, %ecx, %edx and %esi.
  * If a return value makes sense, it's returned in %eax.
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
index 3b9339e..f2c8003 100644
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -166,6 +166,7 @@ static void lazy_hcall3(unsigned long call,
 		async_hcall(call, arg1, arg2, arg3, 0);
 }
 
+#ifdef CONFIG_X86_PAE
 static void lazy_hcall4(unsigned long call,
 		       unsigned long arg1,
 		       unsigned long arg2,
@@ -177,6 +178,7 @@ static void lazy_hcall4(unsigned long call,
 	else
 		async_hcall(call, arg1, arg2, arg3, arg4);
 }
+#endif
 
 /* When lazy mode is turned off reset the per-cpu lazy mode variable and then
  * issue the do-nothing hypercall to flush any stored calls. */
@@ -375,8 +377,8 @@ static void lguest_cpuid(unsigned int *ax, unsigned int *bx,
 	case 1:	/* Basic feature request. */
 		/* We only allow kernel to see SSE3, CMPXCHG16B and SSSE3 */
 		*cx &= 0x00002201;
-		/* SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, TSC, FPU. */
-		*dx &= 0x07808111;
+		/* SSE, SSE2, FXSR, MMX, CMOV, CMPXCHG8B, TSC, FPU, PAE. */
+		*dx &= 0x07808151;
 		/* The Host can do a nice optimization if it knows that the
 		 * kernel mappings (addresses above 0xC0000000 or whatever
 		 * PAGE_OFFSET is set to) haven't changed.  But Linux calls
@@ -395,6 +397,11 @@ static void lguest_cpuid(unsigned int *ax, unsigned int *bx,
 		if (*ax > 0x80000008)
 			*ax = 0x80000008;
 		break;
+	case 0x80000001:
+		/* Here we should fix nx cap depending on host. */
+		/* For this version of PAE, we just clear NX bit. */
+		*dx &= ~(1 << 20);
+		break;
 	}
 }
 
@@ -528,25 +535,52 @@ static void lguest_write_cr4(unsigned long val)
 static void lguest_pte_update(struct mm_struct *mm, unsigned long addr,
 			       pte_t *ptep)
 {
+#ifdef CONFIG_X86_PAE
+	lazy_hcall4(LHCALL_SET_PTE, __pa(mm->pgd), addr,
+		    ptep->pte_low, ptep->pte_high);
+#else
 	lazy_hcall3(LHCALL_SET_PTE, __pa(mm->pgd), addr, ptep->pte_low);
+#endif
 }
 
 static void lguest_set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval)
 {
-	*ptep = pteval;
+	native_set_pte(ptep, pteval);
 	lguest_pte_update(mm, addr, ptep);
 }
 
-/* The Guest calls this to set a top-level entry.  Again, we set the entry then
- * tell the Host which top-level page we changed, and the index of the entry we
- * changed. */
+/* The Guest calls lguest_set_pud to set a top-level entry and lguest_set_pmd
+ * to set a middle-level entry when PAE is activated.
+ * Again, we set the entry then tell the Host which page we changed,
+ * and the index of the entry we changed. */
+#ifdef CONFIG_X86_PAE
+static void lguest_set_pud(pud_t *pudp, pud_t pudval)
+{
+	native_set_pud(pudp, pudval);
+
+	/* 32 bytes aligned pdpt address and the index. */
+	lazy_hcall2(LHCALL_SET_PGD, __pa(pudp) & 0xFFFFFFE0,
+		   (__pa(pudp) & 0x1F) / sizeof(pud_t));
+}
+
 static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
-	*pmdp = pmdval;
+	native_set_pmd(pmdp, pmdval);
+	lazy_hcall2(LHCALL_SET_PMD, __pa(pmdp) & PAGE_MASK,
+		   (__pa(pmdp) & (PAGE_SIZE - 1)) / sizeof(pmd_t));
+}
+#else
+
+/* The Guest calls lguest_set_pmd to set a top-level entry when PAE is not
+ * activated. */
+static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
+{
+	native_set_pmd(pmdp, pmdval);
 	lazy_hcall2(LHCALL_SET_PGD, __pa(pmdp) & PAGE_MASK,
-		   (__pa(pmdp) & (PAGE_SIZE - 1)) / 4);
+		   (__pa(pmdp) & (PAGE_SIZE - 1)) / sizeof(pmd_t));
 }
+#endif
 
 /* There are a couple of legacy places where the kernel sets a PTE, but we
  * don't know the top level any more.  This is useless for us, since we don't
@@ -559,11 +593,31 @@ static void lguest_set_pmd(pmd_t *pmdp, pmd_t pmdval)
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
+	lguest_pte_update(mm, addr, ptep);
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
@@ -1033,6 +1087,7 @@ __init void lguest_init(void)
 	pv_info.name = "lguest";
 	pv_info.paravirt_enabled = 1;
 	pv_info.kernel_rpl = 1;
+	pv_info.shared_kernel_pmd = 1;
 
 	/* We set up all the lguest overrides for sensitive operations.  These
 	 * are detailed with the operations themselves. */
@@ -1078,6 +1133,12 @@ __init void lguest_init(void)
 	pv_mmu_ops.set_pte = lguest_set_pte;
 	pv_mmu_ops.set_pte_at = lguest_set_pte_at;
 	pv_mmu_ops.set_pmd = lguest_set_pmd;
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
index 1cc3377..5415da1 100644
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -73,11 +73,21 @@ static void do_hcall(struct lg_cpu *cpu, struct hcall_args *args)
 		guest_set_stack(cpu, args->arg1, args->arg2, args->arg3);
 		break;
 	case LHCALL_SET_PTE:
+#ifdef CONFIG_X86_PAE
+		guest_set_pte(cpu, args->arg1, args->arg2,
+				__pte(args->arg3 | (u64)args->arg4 << 32));
+#else
 		guest_set_pte(cpu, args->arg1, args->arg2, __pte(args->arg3));
+#endif
 		break;
 	case LHCALL_SET_PGD:
 		guest_set_pgd(cpu->lg, args->arg1, args->arg2);
 		break;
+#ifdef CONFIG_X86_PAE
+	case LHCALL_SET_PMD:
+		guest_set_pmd(cpu->lg, args->arg1, args->arg2);
+		break;
+#endif
 	case LHCALL_SET_CLOCKEVENT:
 		guest_set_clockevent(cpu, args->arg1);
 		break;
diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index 5e7a27d..ce56ef8 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -137,6 +137,8 @@ int run_guest(struct lg_cpu *cpu, unsigned long __user *user);
  * in the kernel. */
 #define pgd_flags(x)	(pgd_val(x) & ~PAGE_MASK)
 #define pgd_pfn(x)	(pgd_val(x) >> PAGE_SHIFT)
+#define pmd_flags(x)    (pmd_val(x) & ~PAGE_MASK)
+#define pmd_pfn(x)	(pmd_val(x) >> PAGE_SHIFT)
 
 /* interrupts_and_traps.c: */
 void maybe_do_interrupt(struct lg_cpu *cpu);
@@ -169,6 +171,9 @@ int init_guest_pagetable(struct lguest *lg);
 void free_guest_pagetable(struct lguest *lg);
 void guest_new_pagetable(struct lg_cpu *cpu, unsigned long pgtable);
 void guest_set_pgd(struct lguest *lg, unsigned long gpgdir, u32 i);
+#ifdef CONFIG_X86_PAE
+void guest_set_pmd(struct lguest *lg, unsigned long gpgdir, u32 i);
+#endif
 void guest_pagetable_clear_all(struct lg_cpu *cpu);
 void guest_pagetable_flush_user(struct lg_cpu *cpu);
 void guest_set_pte(struct lg_cpu *cpu, unsigned long gpgdir,
diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
index 8a3c3a5..a03b74b 100644
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -53,6 +53,17 @@
  * page.  */
 #define SWITCHER_PGD_INDEX (PTRS_PER_PGD - 1)
 
+/* For PAE we need the PMD index as well. We use the last 2MB, so we
+ * will need the last pmd entry of the last pmd page.  */
+#ifdef CONFIG_X86_PAE
+#define SWITCHER_PMD_INDEX 	(PTRS_PER_PMD - 1)
+#define RESERVE_MEM 		2U
+#define CHECK_GPGD_MASK		_PAGE_PRESENT
+#else
+#define RESERVE_MEM 		4U
+#define CHECK_GPGD_MASK		_PAGE_TABLE
+#endif
+
 /* We actually need a separate PTE page for each CPU.  Remember that after the
  * Switcher code itself comes two pages for each CPU, and we don't want this
  * CPU's guest to see the pages of any other CPU. */
@@ -73,23 +84,58 @@ static pgd_t *spgd_addr(struct lg_cpu *cpu, u32 i, unsigned long vaddr)
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
+	page = __va(pgd_pfn(spgd) << PAGE_SHIFT);
+
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
 	/* You should never call this if the PGD entry wasn't valid */
 	BUG_ON(!(pgd_flags(spgd) & _PAGE_PRESENT));
+#endif
+
 	return &page[pte_index(vaddr)];
 }
 
@@ -101,10 +147,31 @@ static unsigned long gpgd_addr(struct lg_cpu *cpu, unsigned long vaddr)
 	return cpu->lg->pgdirs[cpu->cpu_pgd].gpgdir + index * sizeof(pgd_t);
 }
 
-static unsigned long gpte_addr(pgd_t gpgd, unsigned long vaddr)
+#ifdef CONFIG_X86_PAE
+static unsigned long gpmd_addr(pgd_t gpgd, unsigned long vaddr)
 {
 	unsigned long gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
 	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
+	return gpage + pmd_index(vaddr) * sizeof(pmd_t);
+}
+#endif
+
+static unsigned long gpte_addr(struct lg_cpu *cpu,
+				pgd_t gpgd, unsigned long vaddr)
+{
+#ifdef CONFIG_X86_PAE
+	pmd_t gpmd;
+#endif
+	unsigned long gpage;
+
+	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
+#ifdef CONFIG_X86_PAE
+	gpmd = lgread(cpu, gpmd_addr(gpgd, vaddr), pmd_t);
+	gpage = pmd_pfn(gpmd) << PAGE_SHIFT;
+	BUG_ON(!(pmd_flags(gpmd) & _PAGE_PRESENT));
+#else
+	gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
+#endif
 	return gpage + pte_index(vaddr) * sizeof(pte_t);
 }
 /*:*/
@@ -184,11 +251,20 @@ static void check_gpte(struct lg_cpu *cpu, pte_t gpte)
 
 static void check_gpgd(struct lg_cpu *cpu, pgd_t gpgd)
 {
-	if ((pgd_flags(gpgd) & ~_PAGE_TABLE) ||
+	if ((pgd_flags(gpgd) & ~CHECK_GPGD_MASK) ||
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
@@ -207,6 +283,11 @@ bool demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
 	pte_t gpte;
 	pte_t *spte;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t *spmd;
+	pmd_t gpmd;
+#endif
+
 	/* First step: get the top-level Guest page table entry. */
 	gpgd = lgread(cpu, gpgd_addr(cpu, vaddr), pgd_t);
 	/* Toplevel not present?  We can't map it in. */
@@ -228,12 +309,40 @@ bool demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
 		check_gpgd(cpu, gpgd);
 		/* And we copy the flags to the shadow PGD entry.  The page
 		 * number in the shadow PGD is the page we just allocated. */
-		*spgd = __pgd(__pa(ptepage) | pgd_flags(gpgd));
+		set_pgd(spgd, __pgd(__pa(ptepage) | pgd_flags(gpgd)));
 	}
 
+#ifdef CONFIG_X86_PAE
+	gpmd = lgread(cpu, gpmd_addr(gpgd, vaddr), pmd_t);
+	/* middle level not present?  We can't map it in. */
+	if (!(pmd_flags(gpmd) & _PAGE_PRESENT))
+		return false;
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
+			return false;
+		}
+
+		/* We check that the Guest pmd is OK. */
+		check_gpmd(cpu, gpmd);
+
+		/* And we copy the flags to the shadow PMD entry.  The page
+		 * number in the shadow PMD is the page we just allocated. */
+		native_set_pmd(spmd, __pmd(__pa(ptepage) | pmd_flags(gpmd)));
+	}
+#endif
 	/* OK, now we look at the lower level in the Guest page table: keep its
 	 * address, because we might update it later. */
-	gpte_ptr = gpte_addr(gpgd, vaddr);
+	gpte_ptr = gpte_addr(cpu, gpgd, vaddr);
 	gpte = lgread(cpu, gpte_ptr, pte_t);
 
 	/* If this page isn't in the Guest page tables, we can't page it in. */
@@ -259,7 +368,7 @@ bool demand_page(struct lg_cpu *cpu, unsigned long vaddr, int errcode)
 		gpte = pte_mkdirty(gpte);
 
 	/* Get the pointer to the shadow PTE entry we're going to set. */
-	spte = spte_addr(*spgd, vaddr);
+	spte = spte_addr(cpu, *spgd, vaddr);
 	/* If there was a valid shadow PTE entry here before, we release it.
 	 * This can happen with a write to a previously read-only entry. */
 	release_pte(*spte);
@@ -301,14 +410,23 @@ static bool page_writable(struct lg_cpu *cpu, unsigned long vaddr)
 	pgd_t *spgd;
 	unsigned long flags;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t *spmd;
+#endif
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
@@ -322,6 +440,41 @@ void pin_page(struct lg_cpu *cpu, unsigned long vaddr)
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
+static void release_pgd(pgd_t *spgd)
+{
+	/* If the entry's not present, there's nothing to release. */
+	if (pgd_flags(*spgd) & _PAGE_PRESENT) {
+		unsigned int i;
+		pmd_t *pmdpage = __va(pgd_pfn(*spgd) << PAGE_SHIFT);
+
+		for (i = 0; i < PTRS_PER_PMD; i++)
+			release_pmd(&pmdpage[i]);
+
+		/* Now we can free the page of PMDs */
+		free_page((long)pmdpage);
+		/* And zero out the PGD entry so we never release it twice. */
+		set_pgd(spgd, __pgd(0));
+	}
+}
+
+#else /* !CONFIG_X86_PAE */
 /*H:450 If we chase down the release_pgd() code, it looks like this: */
 static void release_pgd(pgd_t *spgd)
 {
@@ -341,7 +494,7 @@ static void release_pgd(pgd_t *spgd)
 		*spgd = __pgd(0);
 	}
 }
-
+#endif
 /*H:445 We saw flush_user_mappings() twice: once from the flush_user_mappings()
  * hypercall and once in new_pgdir() when we re-used a top-level pgdir page.
  * It simply releases every PTE page from 0 up to the Guest's kernel address. */
@@ -370,6 +523,9 @@ unsigned long guest_pa(struct lg_cpu *cpu, unsigned long vaddr)
 	pgd_t gpgd;
 	pte_t gpte;
 
+#ifdef CONFIG_X86_PAE
+	pmd_t gpmd;
+#endif
 	/* First step: get the top-level Guest page table entry. */
 	gpgd = lgread(cpu, gpgd_addr(cpu, vaddr), pgd_t);
 	/* Toplevel not present?  We can't map it in. */
@@ -378,7 +534,13 @@ unsigned long guest_pa(struct lg_cpu *cpu, unsigned long vaddr)
 		return -1UL;
 	}
 
-	gpte = lgread(cpu, gpte_addr(gpgd, vaddr), pte_t);
+	gpte = lgread(cpu, gpte_addr(cpu, gpgd, vaddr), pte_t);
+#ifdef CONFIG_X86_PAE
+	gpmd = lgread(cpu, gpmd_addr(gpgd, vaddr), pmd_t);
+	if (!(pmd_flags(gpmd) & _PAGE_PRESENT))
+		kill_guest(cpu, "Bad address %#lx", vaddr);
+#endif
+	gpte = lgread(cpu, gpte_addr(cpu, gpgd, vaddr), pte_t);
 	if (!(pte_flags(gpte) & _PAGE_PRESENT))
 		kill_guest(cpu, "Bad address %#lx", vaddr);
 
@@ -405,6 +567,9 @@ static unsigned int new_pgdir(struct lg_cpu *cpu,
 			      int *blank_pgdir)
 {
 	unsigned int next;
+#ifdef CONFIG_X86_PAE
+	pmd_t *pmd_table;
+#endif
 
 	/* We pick one entry at random to throw out.  Choosing the Least
 	 * Recently Used might be better, but this is easy. */
@@ -416,10 +581,27 @@ static unsigned int new_pgdir(struct lg_cpu *cpu,
 		/* If the allocation fails, just keep using the one we have */
 		if (!cpu->lg->pgdirs[next].pgdir)
 			next = cpu->cpu_pgd;
-		else
-			/* This is a blank page, so there are no kernel
-			 * mappings: caller must map the stack! */
+		else {
+#ifdef CONFIG_X86_PAE
+			/* In PAE mode, allocate a pmd page and populate the
+			 * last pgd entry. */
+			pmd_table = (pmd_t *)get_zeroed_page(GFP_KERNEL);
+			if (!pmd_table) {
+				free_page((long)cpu->lg->pgdirs[next].pgdir);
+				set_pgd(cpu->lg->pgdirs[next].pgdir, __pgd(0));
+				next = cpu->cpu_pgd;
+			} else {
+				set_pgd(cpu->lg->pgdirs[next].pgdir +
+					SWITCHER_PGD_INDEX,
+					__pgd(__pa(pmd_table) | _PAGE_PRESENT));
+				/* This is a blank page, so there are no kernel
+				 * mappings: caller must map the stack! */
+				*blank_pgdir = 1;
+			}
+#else
 			*blank_pgdir = 1;
+#endif
+		}
 	}
 	/* Record which Guest toplevel this shadows. */
 	cpu->lg->pgdirs[next].gpgdir = gpgdir;
@@ -460,10 +642,25 @@ static void release_all_pagetables(struct lguest *lg)
 
 	/* Every shadow pagetable this Guest has */
 	for (i = 0; i < ARRAY_SIZE(lg->pgdirs); i++)
-		if (lg->pgdirs[i].pgdir)
+		if (lg->pgdirs[i].pgdir) {
+#ifdef CONFIG_X86_PAE
+			pgd_t *spgd;
+			pmd_t *pmdpage;
+			unsigned int k;
+
+			/* Get the last pmd page. */
+			spgd = lg->pgdirs[i].pgdir + SWITCHER_PGD_INDEX;
+			pmdpage = __va(pgd_pfn(*spgd) << PAGE_SHIFT);
+
+			/* And release the pmd entries of that pmd page,
+			 * except for the switcher pmd. */
+			for (k = 0; k < SWITCHER_PMD_INDEX; k++)
+				release_pmd(&pmdpage[k]);
+#endif
 			/* Every PGD entry except the Switcher at the top */
 			for (j = 0; j < SWITCHER_PGD_INDEX; j++)
 				release_pgd(lg->pgdirs[i].pgdir + j);
+		}
 }
 
 /* We also throw away everything when a Guest tells us it's changed a kernel
@@ -504,24 +701,37 @@ static void do_set_pte(struct lg_cpu *cpu, int idx,
 {
 	/* Look up the matching shadow page directory entry. */
 	pgd_t *spgd = spgd_addr(cpu, idx, vaddr);
+#ifdef CONFIG_X86_PAE
+	pmd_t *spmd;
+#endif
 
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
+#ifdef CONFIG_X86_PAE
+		spmd = spmd_addr(cpu, *spgd, vaddr);
+		if (pmd_flags(*spmd) & _PAGE_PRESENT) {
+#endif
+			/* Otherwise, we start by releasing
+			 * the existing entry. */
+			pte_t *spte = spte_addr(cpu, *spgd, vaddr);
+			release_pte(*spte);
+
+			/* If they're setting this entry as dirty or accessed,
+			 * we might as well put that entry they've given us
+			 * in now.  This shaves 10% off a
+			 * copy-on-write micro-benchmark. */
+			if (pte_flags(gpte) & (_PAGE_DIRTY | _PAGE_ACCESSED)) {
+				check_gpte(cpu, gpte);
+				native_set_pte(spte,
+						gpte_to_spte(cpu, gpte,
+						pte_flags(gpte) & _PAGE_DIRTY));
+			} else
+				/* Otherwise kill it and we can demand_page()
+				 * it in later. */
+				native_set_pte(spte, __pte(0));
+#ifdef CONFIG_X86_PAE
+		}
+#endif
 	}
 }
 
@@ -572,8 +782,6 @@ void guest_set_pgd(struct lguest *lg, unsigned long gpgdir, u32 idx)
 {
 	int pgdir;
 
-	/* The kernel seems to try to initialize this early on: we ignore its
-	 * attempts to map over the Switcher. */
 	if (idx >= SWITCHER_PGD_INDEX)
 		return;
 
@@ -583,6 +791,12 @@ void guest_set_pgd(struct lguest *lg, unsigned long gpgdir, u32 idx)
 		/* ... throw it away. */
 		release_pgd(lg->pgdirs[pgdir].pgdir + idx);
 }
+#ifdef CONFIG_X86_PAE
+void guest_set_pmd(struct lguest *lg, unsigned long pmdp, u32 idx)
+{
+	guest_pagetable_clear_all(&lg->cpus[0]);
+}
+#endif
 
 /* Once we know how much memory we have we can construct simple identity
  * (which set virtual == physical) and linear mappings
@@ -596,8 +810,16 @@ static unsigned long setup_pagetables(struct lguest *lg,
 {
 	pgd_t __user *pgdir;
 	pte_t __user *linear;
-	unsigned int mapped_pages, i, linear_pages, phys_linear;
 	unsigned long mem_base = (unsigned long)lg->mem_base;
+	unsigned int mapped_pages, i, linear_pages;
+#ifdef CONFIG_X86_PAE
+	pmd_t __user *pmds;
+	unsigned int j;
+	pgd_t pgd;
+	pmd_t pmd;
+#else
+	unsigned int phys_linear;
+#endif
 
 	/* We have mapped_pages frames to map, so we need
 	 * linear_pages page tables to map them. */
@@ -610,6 +832,9 @@ static unsigned long setup_pagetables(struct lguest *lg,
 	/* Now we use the next linear_pages pages as pte pages */
 	linear = (void *)pgdir - linear_pages * PAGE_SIZE;
 
+#ifdef CONFIG_X86_PAE
+	pmds = (void *)linear - PAGE_SIZE;
+#endif
 	/* Linear mapping is easy: put every page's address into the
 	 * mapping in order. */
 	for (i = 0; i < mapped_pages; i++) {
@@ -621,6 +846,22 @@ static unsigned long setup_pagetables(struct lguest *lg,
 
 	/* The top level points to the linear page table pages above.
 	 * We setup the identity and linear mappings here. */
+#ifdef CONFIG_X86_PAE
+	for (i = 0, j; i < mapped_pages && j < PTRS_PER_PMD;
+	     i += PTRS_PER_PTE, j++) {
+		native_set_pmd(&pmd, __pmd(((unsigned long)(linear + i)
+		- mem_base) | _PAGE_PRESENT | _PAGE_RW | _PAGE_USER));
+
+		if (copy_to_user(&pmds[j], &pmd, sizeof(pmd)) != 0)
+			return -EFAULT;
+	}
+
+	set_pgd(&pgd, __pgd(((u32)pmds - mem_base) | _PAGE_PRESENT));
+	if (copy_to_user(&pgdir[0], &pgd, sizeof(pgd)) != 0)
+		return -EFAULT;
+	if (copy_to_user(&pgdir[3], &pgd, sizeof(pgd)) != 0)
+		return -EFAULT;
+#else
 	phys_linear = (unsigned long)linear - mem_base;
 	for (i = 0; i < mapped_pages; i += PTRS_PER_PTE) {
 		pgd_t pgd;
@@ -633,6 +874,7 @@ static unsigned long setup_pagetables(struct lguest *lg,
 				    &pgd, sizeof(pgd)))
 			return -EFAULT;
 	}
+#endif
 
 	/* We return the top level (guest-physical) address: remember where
 	 * this is. */
@@ -648,7 +890,10 @@ int init_guest_pagetable(struct lguest *lg)
 	u64 mem;
 	u32 initrd_size;
 	struct boot_params __user *boot = (struct boot_params *)lg->mem_base;
-
+#ifdef CONFIG_X86_PAE
+	pgd_t *pgd;
+	pmd_t *pmd_table;
+#endif
 	/* Get the Guest memory size and the ramdisk size from the boot header
 	 * located at lg->mem_base (Guest address 0). */
 	if (copy_from_user(&mem, &boot->e820_map[0].size, sizeof(mem))
@@ -663,6 +908,15 @@ int init_guest_pagetable(struct lguest *lg)
 	lg->pgdirs[0].pgdir = (pgd_t *)get_zeroed_page(GFP_KERNEL);
 	if (!lg->pgdirs[0].pgdir)
 		return -ENOMEM;
+#ifdef CONFIG_X86_PAE
+	pgd = lg->pgdirs[0].pgdir;
+	pmd_table = (pmd_t *) get_zeroed_page(GFP_KERNEL);
+	if (!pmd_table)
+		return -ENOMEM;
+
+	set_pgd(pgd + SWITCHER_PGD_INDEX,
+		__pgd(__pa(pmd_table) | _PAGE_PRESENT));
+#endif
 	lg->cpus[0].cpu_pgd = 0;
 	return 0;
 }
@@ -672,17 +926,24 @@ void page_table_guest_data_init(struct lg_cpu *cpu)
 {
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
+		|| put_user(RESERVE_MEM * 1024 * 1024,
+			&cpu->lg->lguest_data->reserve_mem)
+		|| put_user(cpu->lg->pgdirs[0].gpgdir,
+			&cpu->lg->lguest_data->pgdir))
 		kill_guest(cpu, "bad guest page %p", cpu->lg->lguest_data);
 
 	/* In flush_user_mappings() we loop from 0 to
 	 * "pgd_index(lg->kernel_address)".  This assumes it won't hit the
 	 * Switcher mappings, so check that now. */
+#ifdef CONFIG_X86_PAE
+	if (pgd_index(cpu->lg->kernel_address) == SWITCHER_PGD_INDEX &&
+		pmd_index(cpu->lg->kernel_address) == SWITCHER_PMD_INDEX)
+#else
 	if (pgd_index(cpu->lg->kernel_address) >= SWITCHER_PGD_INDEX)
+#endif
 		kill_guest(cpu, "bad kernel address %#lx",
 				 cpu->lg->kernel_address);
 }
@@ -708,16 +969,30 @@ void free_guest_pagetable(struct lguest *lg)
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
+	native_set_pmd(&switcher_pmd, pfn_pmd(__pa(switcher_pte_page) >>
+		       PAGE_SHIFT, PAGE_KERNEL_EXEC));
+
+	pmd_table = __va(pgd_pfn(cpu->lg->
+			pgdirs[cpu->cpu_pgd].pgdir[SWITCHER_PGD_INDEX])
+								<< PAGE_SHIFT);
+	native_set_pmd(&pmd_table[SWITCHER_PMD_INDEX], switcher_pmd);
+#else
+	pgd_t switcher_pgd;
+
 	/* Make the last PGD entry for this Guest point to the Switcher's PTE
 	 * page for this CPU (with appropriate flags). */
 	switcher_pgd = __pgd(__pa(switcher_pte_page) | __PAGE_KERNEL_EXEC);
 
 	cpu->lg->pgdirs[cpu->cpu_pgd].pgdir[SWITCHER_PGD_INDEX] = switcher_pgd;
 
+#endif
 	/* We also change the Switcher PTE page.  When we're running the Guest,
 	 * we want the Guest's "regs" page to appear where the first Switcher
 	 * page for this CPU is.  This is an optimization: when the Switcher
@@ -726,8 +1001,9 @@ void map_switcher_in_guest(struct lg_cpu *cpu, struct lguest_pages *pages)
 	 * page is already mapped there, we don't have to copy them out
 	 * again. */
 	pfn = __pa(cpu->regs_page) >> PAGE_SHIFT;
-	regs_pte = pfn_pte(pfn, __pgprot(__PAGE_KERNEL));
-	switcher_pte_page[(unsigned long)pages/PAGE_SIZE%PTRS_PER_PTE] = regs_pte;
+	native_set_pte(&regs_pte, pfn_pte(pfn, PAGE_KERNEL));
+	native_set_pte(&switcher_pte_page[pte_index((unsigned long)pages)],
+			regs_pte);
 }
 /*:*/
 
-- 
1.6.0.4
