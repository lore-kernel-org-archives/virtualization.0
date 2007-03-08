From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 08/17] paravirt_ops - memory managment
Date: Thu, 08 Mar 2007 01:02:17 -0500
Message-ID: <1173333737.25848.9.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-mm.patch)
Memory management for paravirt_ops.

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/arch/x86_64/mm/fault.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/mm/fault.c
+++ clean-start/arch/x86_64/mm/fault.c
@@ -180,7 +180,7 @@ void dump_pagetable(unsigned long addres
 	pmd_t *pmd;
 	pte_t *pte;
 =

-	asm("movq %%cr3,%0" : "=3Dr" (pgd));
+	pgd =3D (pgd_t *)read_cr3();
 =

 	pgd =3D __va((unsigned long)pgd & PHYSICAL_PAGE_MASK); =

 	pgd +=3D pgd_index(address);
@@ -347,7 +347,7 @@ asmlinkage void __kprobes do_page_fault(
 	prefetchw(&mm->mmap_sem);
 =

 	/* get the address */
-	__asm__("movq %%cr2,%0":"=3Dr" (address));
+	address =3D read_cr2();
 =

 	info.si_code =3D SEGV_MAPERR;
 =

Index: clean-start/arch/x86_64/mm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/mm/init.c
+++ clean-start/arch/x86_64/mm/init.c
@@ -384,7 +384,7 @@ void __meminit init_memory_mapping(unsig
 	} =

 =

 	if (!after_bootmem)
-		asm volatile("movq %%cr4,%0" : "=3Dr" (mmu_cr4_features));
+		mmu_cr4_features =3D read_cr4();
 	__flush_tlb_all();
 }
 =

@@ -398,7 +398,7 @@ void __cpuinit zap_low_mappings(int cpu)
 		 * For AP's, zap the low identity mappings by changing the cr3
 		 * to init_level4_pgt and doing local flush tlb all
 		 */
-		asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+		write_cr3(__pa_symbol(&init_level4_pgt));
 	}
 	__flush_tlb_all();
 }
Index: clean-start/include/asm-x86_64/mmu_context.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/mmu_context.h
+++ clean-start/include/asm-x86_64/mmu_context.h
@@ -42,7 +42,7 @@ static inline void switch_mm(struct mm_s
 		load_cr3(next->pgd);
 =

 		if (unlikely(next->context.ldt !=3D prev->context.ldt)) =

-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -55,7 +55,7 @@ static inline void switch_mm(struct mm_s
 			 * to make sure to use no freed page tables.
 			 */
 			load_cr3(next->pgd);
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 		}
 	}
 #endif
Index: clean-start/include/asm-x86_64/page.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/page.h
+++ clean-start/include/asm-x86_64/page.h
@@ -64,16 +64,44 @@ typedef struct { unsigned long pgd; } pg
 =

 typedef struct { unsigned long pgprot; } pgprot_t;
 =

+static inline unsigned long native_pte_val(pte_t pte)
+{
+	return pte.pte;
+}
+
+static inline unsigned long native_pud_val(pud_t pud)
+{
+	return pud.pud;
+}
+
+
+static inline unsigned long native_pmd_val(pmd_t pmd)
+{
+	return pmd.pmd;
+}
+
+static inline unsigned long native_pgd_val(pgd_t pgd)
+{
+	return pgd.pgd;
+}
+
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).pmd)
 #define pud_val(x)	((x).pud)
 #define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
 =

 #define __pte(x) ((pte_t) { (x) } )
 #define __pmd(x) ((pmd_t) { (x) } )
 #define __pud(x) ((pud_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
+#endif /* CONFIG_PARAVIRT */
+
+#define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 =

 #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
Index: clean-start/include/asm-x86_64/pgtable.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/pgtable.h
+++ clean-start/include/asm-x86_64/pgtable.h
@@ -55,50 +55,62 @@ extern unsigned long empty_zero_page[PAG
  */
 #define PTRS_PER_PTE	512
 =

-#define pte_ERROR(e) \
-	printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), pte_val(=
e))
-#define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), pmd_val(=
e))
-#define pud_ERROR(e) \
-	printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), pud_val(=
e))
-#define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), pgd_val(=
e))
-
-#define pgd_none(x)	(!pgd_val(x))
-#define pud_none(x)	(!pud_val(x))
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define set_pte native_set_pte
+#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+#define set_pmd native_set_pmd
+#define set_pud native_set_pud
+#define set_pgd native_set_pgd
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } w=
hile (0)
+#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
+#define pud_clear native_pud_clear
+#define pgd_clear native_pgd_clear
+#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
+#endif
 =

-static inline void set_pte(pte_t *dst, pte_t val)
+static inline void native_set_pte(pte_t *dst, pte_t val)
 {
-	pte_val(*dst) =3D pte_val(val);
+	dst->pte =3D pte_val(val);
 } =

-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
 =

-static inline void set_pmd(pmd_t *dst, pmd_t val)
+
+static inline void native_set_pmd(pmd_t *dst, pmd_t val)
 {
-        pmd_val(*dst) =3D pmd_val(val); =

+	dst->pmd =3D pmd_val(val);
 } =

 =

-static inline void set_pud(pud_t *dst, pud_t val)
+static inline void native_set_pud(pud_t *dst, pud_t val)
 {
-	pud_val(*dst) =3D pud_val(val);
+	dst->pud =3D pud_val(val);
 }
 =

-static inline void pud_clear (pud_t *pud)
+static inline void native_set_pgd(pgd_t *dst, pgd_t val)
 {
-	set_pud(pud, __pud(0));
+	dst->pgd =3D pgd_val(val);
 }
-
-static inline void set_pgd(pgd_t *dst, pgd_t val)
+static inline void native_pud_clear (pud_t *pud)
 {
-	pgd_val(*dst) =3D pgd_val(val); =

-} =

+	set_pud(pud, __pud(0));
+}
 =

-static inline void pgd_clear (pgd_t * pgd)
+static inline void native_pgd_clear (pgd_t * pgd)
 {
 	set_pgd(pgd, __pgd(0));
 }
 =

-#define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
+#define pgd_none(x)	(!pgd_val(x))
+#define pud_none(x)	(!pud_val(x))
+
+#define pte_ERROR(e) \
+	printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), pte_val(=
e))
+#define pmd_ERROR(e) \
+	printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), pmd_val(=
e))
+#define pud_ERROR(e) \
+	printk("%s:%d: bad pud %p(%016lx).\n", __FILE__, __LINE__, &(e), pud_val(=
e))
+#define pgd_ERROR(e) \
+	printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), pgd_val(=
e))
 =

 struct mm_struct;
 =

@@ -238,7 +250,6 @@ static inline unsigned long pmd_bad(pmd_
 =

 #define pte_none(x)	(!pte_val(x))
 #define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } w=
hile (0)
 =

 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))	/* FIXME: is this
 						   right? */
@@ -247,11 +258,11 @@ static inline unsigned long pmd_bad(pmd_
 =

 static inline pte_t pfn_pte(unsigned long page_nr, pgprot_t pgprot)
 {
-	pte_t pte;
-	pte_val(pte) =3D (page_nr << PAGE_SHIFT);
-	pte_val(pte) |=3D pgprot_val(pgprot);
-	pte_val(pte) &=3D __supported_pte_mask;
-	return pte;
+	unsigned long pte;
+	pte =3D (page_nr << PAGE_SHIFT);
+	pte |=3D pgprot_val(pgprot);
+	pte &=3D __supported_pte_mask;
+	return __pte(pte);
 }
 =

 /*
@@ -345,7 +356,6 @@ static inline int pmd_large(pmd_t pte) {
 			pmd_index(address))
 #define pmd_none(x)	(!pmd_val(x))
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
-#define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define pfn_pmd(nr,prot) (__pmd(((nr) << PAGE_SHIFT) | pgprot_val(prot)))
 #define pmd_pfn(x)  ((pmd_val(x) & __PHYSICAL_MASK) >> PAGE_SHIFT)
 =

@@ -362,19 +372,20 @@ static inline int pmd_large(pmd_t pte) {
 /* physical address -> PTE */
 static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
 { =

-	pte_t pte;
-	pte_val(pte) =3D physpage | pgprot_val(pgprot); =

-	pte_val(pte) &=3D __supported_pte_mask;
-	return pte; =

+	unsigned long pte;
+	pte =3D physpage | pgprot_val(pgprot);
+	pte &=3D __supported_pte_mask;
+	return __pte(pte);
 }
  =

 /* Change flags of a PTE */
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+static inline pte_t pte_modify(pte_t pte_old, pgprot_t newprot)
 { =

-	pte_val(pte) &=3D _PAGE_CHG_MASK;
-	pte_val(pte) |=3D pgprot_val(newprot);
-	pte_val(pte) &=3D __supported_pte_mask;
-       return pte; =

+	unsigned long pte =3D pte_val(pte_old);
+	pte &=3D _PAGE_CHG_MASK;
+	pte |=3D pgprot_val(newprot);
+	pte &=3D __supported_pte_mask;
+       return __pte(pte);
 }
 =

 #define pte_index(address) \
Index: clean-start/include/asm-x86_64/tlbflush.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/include/asm-x86_64/tlbflush.h
+++ clean-start/include/asm-x86_64/tlbflush.h
@@ -4,6 +4,7 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 =

+
 static inline unsigned long get_cr3(void)
 {
 	unsigned long cr3;
@@ -16,7 +17,7 @@ static inline void set_cr3(unsigned long
 	asm volatile("mov %0,%%cr3" :: "r" (cr3) : "memory");
 }
 =

-static inline void __flush_tlb(void)
+static inline void __native_flush_tlb(void)
 {
 	set_cr3(get_cr3());
 }
@@ -33,17 +34,24 @@ static inline void set_cr4(unsigned long
 	asm volatile("mov %0,%%cr4" :: "r" (cr4) : "memory");
 }
 =

-static inline void __flush_tlb_all(void)
+static inline void __native_flush_tlb_all(void)
 {
 	unsigned long cr4 =3D get_cr4();
 	set_cr4(cr4 & ~X86_CR4_PGE);	/* clear PGE */
 	set_cr4(cr4);			/* write old PGE again and flush TLBs */
 }
 =

-#define __flush_tlb_one(addr) \
+#define __native_flush_tlb_one(addr) \
 	__asm__ __volatile__("invlpg (%0)" :: "r" (addr) : "memory")
 =


+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define __flush_tlb __native_flush_tlb
+#define __flush_tlb_one __native_flush_tlb_one
+#define __flush_tlb_all __native_flush_tlb_all
+#endif /* CONFIG_PARAVIRT */
 /*
  * TLB flushing:
  *

--
