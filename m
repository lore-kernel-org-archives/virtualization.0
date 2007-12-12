From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 14/19] unify non-paravirt parts of desc.h
Date: Wed, 12 Dec 2007 10:53:59 -0200
Message-ID: <11974641314148-git-send-email-gcosta__9298.82936548001$1197474842$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11974640441088-git-send-email-gcosta@redhat.com>
	<11974640522688-git-send-email-gcosta@redhat.com>
	<1197464057242-git-send-email-gcosta@redhat.com>
	<11974640653022-git-send-email-gcosta@redhat.com>
	<1197464070228-git-send-email-gcosta@redhat.com>
	<11974640752137-git-send-email-gcosta@redhat.com>
	<11974640813511-git-send-email-gcosta@redhat.com>
	<11974640872474-git-send-email-gcosta@redhat.com>
	<11974640932406-git-send-email-gcosta@redhat.com>
	<11974640983333-git-send-email-gcosta@redhat.com>
	<11974641042757-git-send-email-gcosta@redhat.com>
	<11974641102691-git-send-email-gcosta@redhat.com>
	<11974641172402-git-send-email-gcosta@redhat.com>
	<11974641243264-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11974641243264-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch unifies the non-paravirt part of desc_{32,64}.h into
desc.h. Most of it, is simply common code, that is moved to
the shared header. The only exception is the set_ldt_desc in desc_64.h,
which is changed - included its name - to accomodate for the way
the ldt is set up in i386.

Also, constant definitions used in desc_32.h are moved to desc_defs.h

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/desc.h           |   87 ++++++++++++++++++++++++++++++++++++++
 include/asm-x86/desc_32.h        |   66 ----------------------------
 include/asm-x86/desc_64.h        |   64 ++++-----------------------
 include/asm-x86/mmu_context_64.h |    4 +-
 4 files changed, 99 insertions(+), 122 deletions(-)

Index: linux-2.6-x86/include/asm-x86/desc.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc.h
+++ linux-2.6-x86/include/asm-x86/desc.h
@@ -1,5 +1,92 @@
+#ifndef _ASM_DESC_H_
+#define _ASM_DESC_H_
+
+#include <asm/desc_defs.h>
+
+#ifndef __ASSEMBLY__
+#include <asm/mmu.h>
+
+extern struct desc_ptr idt_descr;
+extern gate_desc idt_table[];
+
+#endif
+
 #ifdef CONFIG_X86_32
 # include "desc_32.h"
 #else
 # include "desc_64.h"
 #endif
+
+#ifndef __ASSEMBLY__
+
+#define _LDT_empty(info) (\
+	(info)->base_addr	== 0	&& \
+	(info)->limit		== 0	&& \
+	(info)->contents	== 0	&& \
+	(info)->read_exec_only	== 1	&& \
+	(info)->seg_32bit	== 0	&& \
+	(info)->limit_in_pages	== 0	&& \
+	(info)->seg_not_present	== 1	&& \
+	(info)->useable		== 0)
+
+#ifdef CONFIG_X86_64
+#define LDT_empty(info) (_LDT_empty(info) && ((info)->lm == 0))
+#else
+#define LDT_empty(info) (_LDT_empty(info))
+#endif
+
+static inline void clear_LDT(void)
+{
+	set_ldt(NULL, 0);
+}
+
+/*
+ * load one particular LDT into the current CPU
+ */
+static inline void load_LDT_nolock(mm_context_t *pc)
+{
+	set_ldt(pc->ldt, pc->size);
+}
+
+static inline void load_LDT(mm_context_t *pc)
+{
+	preempt_disable();
+	load_LDT_nolock(pc);
+	preempt_enable();
+}
+
+static inline unsigned long get_desc_base(unsigned long *desc)
+{
+	unsigned long base;
+	base = ((desc[0] >> 16)  & 0x0000ffff) |
+		((desc[1] << 16) & 0x00ff0000) |
+		(desc[1] & 0xff000000);
+	return base;
+}
+
+#else
+/*
+ * GET_DESC_BASE reads the descriptor base of the specified segment.
+ *
+ * Args:
+ *    idx - descriptor index
+ *    gdt - GDT pointer
+ *    base - 32bit register to which the base will be written
+ *    lo_w - lo word of the "base" register
+ *    lo_b - lo byte of the "base" register
+ *    hi_b - hi byte of the low word of the "base" register
+ *
+ * Example:
+ *    GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah)
+ *    Will read the base address of GDT_ENTRY_ESPFIX_SS and put it into %eax.
+ */
+#define GET_DESC_BASE(idx, gdt, base, lo_w, lo_b, hi_b) \
+	movb idx*8+4(gdt), lo_b; \
+	movb idx*8+7(gdt), hi_b; \
+	shll $16, base; \
+	movw idx*8+2(gdt), lo_w;
+
+
+#endif /* __ASSEMBLY__ */
+
+#endif
Index: linux-2.6-x86/include/asm-x86/desc_32.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc_32.h
+++ linux-2.6-x86/include/asm-x86/desc_32.h
@@ -11,8 +11,6 @@
 #include <linux/smp.h>
 #include <linux/percpu.h>
 
-#include <asm/mmu.h>
-
 struct gdt_page
 {
 	struct desc_struct gdt[GDT_ENTRIES];
@@ -24,8 +22,6 @@ static inline struct desc_struct *get_cp
 	return per_cpu(gdt_page, cpu).gdt;
 }
 
-extern struct desc_ptr idt_descr;
-extern gate_desc idt_table[];
 extern void set_intr_gate(unsigned int irq, void * addr);
 
 static inline void pack_descriptor(struct desc_struct *desc,
@@ -172,68 +168,6 @@ static inline void __set_tss_desc(unsign
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
-
-static inline void clear_LDT(void)
-{
-	set_ldt(NULL, 0);
-}
-
-/*
- * load one particular LDT into the current CPU
- */
-static inline void load_LDT_nolock(mm_context_t *pc)
-{
-	set_ldt(pc->ldt, pc->size);
-}
-
-static inline void load_LDT(mm_context_t *pc)
-{
-	preempt_disable();
-	load_LDT_nolock(pc);
-	preempt_enable();
-}
-
-static inline unsigned long get_desc_base(unsigned long *desc)
-{
-	unsigned long base;
-	base = ((desc[0] >> 16)  & 0x0000ffff) |
-		((desc[1] << 16) & 0x00ff0000) |
-		(desc[1] & 0xff000000);
-	return base;
-}
-
-#else /* __ASSEMBLY__ */
-
-/*
- * GET_DESC_BASE reads the descriptor base of the specified segment.
- *
- * Args:
- *    idx - descriptor index
- *    gdt - GDT pointer
- *    base - 32bit register to which the base will be written
- *    lo_w - lo word of the "base" register
- *    lo_b - lo byte of the "base" register
- *    hi_b - hi byte of the low word of the "base" register
- *
- * Example:
- *    GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah)
- *    Will read the base address of GDT_ENTRY_ESPFIX_SS and put it into %eax.
- */
-#define GET_DESC_BASE(idx, gdt, base, lo_w, lo_b, hi_b) \
-	movb idx*8+4(gdt), lo_b; \
-	movb idx*8+7(gdt), hi_b; \
-	shll $16, base; \
-	movw idx*8+2(gdt), lo_w;
-
 #endif /* !__ASSEMBLY__ */
 
 #endif
Index: linux-2.6-x86/include/asm-x86/desc_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/desc_64.h
+++ linux-2.6-x86/include/asm-x86/desc_64.h
@@ -9,16 +9,13 @@
 
 #include <linux/string.h>
 #include <linux/smp.h>
-#include <asm/desc_defs.h>
 
 #include <asm/segment.h>
-#include <asm/mmu.h>
 
 extern struct desc_struct cpu_gdt_table[GDT_ENTRIES];
 
 #define load_TR_desc() asm volatile("ltr %w0"::"r" (GDT_ENTRY_TSS*8))
 #define load_LDT_desc() asm volatile("lldt %w0"::"r" (GDT_ENTRY_LDT*8))
-#define clear_LDT()  asm volatile("lldt %w0"::"r" (0))
 
 static inline unsigned long __store_tr(void)
 {
@@ -30,7 +27,6 @@ static inline unsigned long __store_tr(v
 
 #define store_tr(tr) (tr) = __store_tr()
 
-extern gate_desc idt_table[];
 extern struct desc_ptr cpu_gdt_descr[];
 
 static inline void write_ldt_entry(struct desc_struct *ldt,
@@ -138,23 +134,19 @@ static inline void set_tss_desc(unsigned
 		IO_BITMAP_OFFSET + IO_BITMAP_BYTES + sizeof(unsigned long) - 1);
 }
 
-static inline void set_ldt_desc(unsigned cpu, void *addr, int size)
+static inline void set_ldt(void *addr, int entries)
 {
-	set_tssldt_descriptor(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT],
-			     (unsigned long)addr, DESC_LDT, size * 8 - 1);
+	if (likely(entries == 0))
+		__asm__ __volatile__("lldt %w0"::"q" (0));
+	else {
+		unsigned cpu = smp_processor_id();
+
+		set_tssldt_descriptor(&get_cpu_gdt_table(cpu)[GDT_ENTRY_LDT],
+			     (unsigned long)addr, DESC_LDT, entries * 8 - 1);
+		__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
+	}
 }
 
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	&& \
-	(info)->lm		== 0)
-
 static inline void load_TLS(struct thread_struct *t, unsigned int cpu)
 {
 	unsigned int i;
@@ -164,42 +156,6 @@ static inline void load_TLS(struct threa
 		gdt[i] = t->tls_array[i];
 }
 
-/*
- * load one particular LDT into the current CPU
- */
-static inline void load_LDT_nolock(mm_context_t *pc, int cpu)
-{
-	int count = pc->size;
-
-	if (likely(!count)) {
-		clear_LDT();
-		return;
-	}
-
-	set_ldt_desc(cpu, pc->ldt, count);
-	load_LDT_desc();
-}
-
-static inline void load_LDT(mm_context_t *pc)
-{
-	int cpu = get_cpu();
-
-	load_LDT_nolock(pc, cpu);
-	put_cpu();
-}
-
-extern struct desc_ptr idt_descr;
-
-static inline unsigned long get_desc_base(const void *ptr)
-{
-	const u32 *desc = ptr;
-	unsigned long base;
-	base = ((desc[0] >> 16)  & 0x0000ffff) |
-		((desc[1] << 16) & 0x00ff0000) |
-		(desc[1] & 0xff000000);
-	return base;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif
Index: linux-2.6-x86/include/asm-x86/mmu_context_64.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/mmu_context_64.h
+++ linux-2.6-x86/include/asm-x86/mmu_context_64.h
@@ -43,7 +43,7 @@ static inline void switch_mm(struct mm_s
 		load_cr3(next->pgd);
 
 		if (unlikely(next->context.ldt != prev->context.ldt)) 
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 	}
 #ifdef CONFIG_SMP
 	else {
@@ -56,7 +56,7 @@ static inline void switch_mm(struct mm_s
 			 * to make sure to use no freed page tables.
 			 */
 			load_cr3(next->pgd);
-			load_LDT_nolock(&next->context, cpu);
+			load_LDT_nolock(&next->context);
 		}
 	}
 #endif
