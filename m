From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/2] paravirt.h header
Date: Tue, 22 Aug 2006 16:43:07 +1000
Message-ID: <1156228988.26898.15.camel@localhost.localdomain>
References: <1156226116.26898.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1156226116.26898.8.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 15:55 +1000, Rusty Russell wrote:
> OK, this is the revised paravirt.h (Andi has seen this before),

No, it wasn't.  That was the old patch, which won't apply.

This is the right one (and applied with a little fuzz against rc4-mm2).

Sorry,
Rusty.


Create a paravirt.h header for all the critical operations which need
to be replaced with hypervisor calls, and include that instead of
defining native operations, when CONFIG_PARAVIRT.

This patch does the dumbest possible replacement of paravirtualized
instructions: calls through a "paravirt_ops" structure.  Currently
these are function implementations of native hardware: hypervisors
will override the ops structure with their own variants.

All the pv-ops functions are declared "fastcall" so that a specific
register-based ABI is used, to make inlining assember easier.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -179,6 +179,17 @@ config X86_ES7000
 	  should say N here.
 =

 endchoice
+
+config PARAVIRT
+	bool "Paravirtualization support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  Paravirtualization is a way of running multiple instances of
+	  Linux on the same machine, under a hypervisor.  This option
+	  changes the kernel so it can modify itself when it is run
+	  under a hypervisor, improving performance significantly.
+	  However, when run without a hypervisor the kernel is
+	  theoretically slower.  If in doubt, say N.
 =

 config ACPI_SRAT
 	bool
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_HPET_TIMER) 	+=3D hpet.o
 obj-$(CONFIG_HPET_TIMER) 	+=3D hpet.o
 obj-$(CONFIG_K8_NB)		+=3D k8.o
 obj-$(CONFIG_AUDIT)		+=3D audit.o
+obj-$(CONFIG_PARAVIRT)		+=3D paravirt.o
 =

 EXTRA_AFLAGS   :=3D -traditional
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -74,4 +74,11 @@ void foo(void)
 	DEFINE(VDSO_PRELINK, VDSO_PRELINK);
 =

 	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
+#ifdef CONFIG_PARAVIRT
+	OFFSET(PARAVIRT_irq_disable, paravirt_ops, irq_disable);
+	OFFSET(PARAVIRT_irq_enable, paravirt_ops, irq_enable);
+	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
+	OFFSET(PARAVIRT_iret, paravirt_ops, iret);
+	OFFSET(PARAVIRT_read_cr0, paravirt_ops, read_cr0);
+#endif
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -76,13 +76,6 @@ NT_MASK		=3D 0x00004000
 NT_MASK		=3D 0x00004000
 VM_MASK		=3D 0x00020000
 =

-/* These are replaces for paravirtualization */
-#define DISABLE_INTERRUPTS		cli
-#define ENABLE_INTERRUPTS		sti
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define INTERRUPT_RETURN		iret
-#define GET_CR0_INTO_EAX		movl %cr0, %eax
-
 #ifdef CONFIG_PREEMPT
 #define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
 #else
@@ -809,6 +802,19 @@ 1:	INTERRUPT_RETURN
 	.long 1b,iret_exc
 .previous
 =

+#ifdef CONFIG_PARAVIRT
+ENTRY(native_iret)
+1:	iret
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+
+ENTRY(native_irq_enable_sysexit)
+	sti
+	sysexit
+#endif
+
 KPROBE_ENTRY(int3)
 	RING0_INT_FRAME
 	pushl $-1			# mark this as an int
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/desc.h
+++ b/include/asm-i386/desc.h
@@ -64,6 +64,9 @@ static inline void pack_gate(__u32 *a, _
 #define DESCTYPE_DPL3	0x60	/* DPL-3 */
 #define DESCTYPE_S	0x10	/* !system */
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*=
8))
 #define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LD=
T*8))
 =

@@ -98,6 +101,7 @@ static inline void write_dt_entry(void *
 #define write_ldt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
 #define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
 #define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#endif /* CONFIG_PARAVIRT */
 =

 static inline void _set_gate(int gate, unsigned int type, void *addr, unsi=
gned short seg)
 {
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/irqflags.h
+++ b/include/asm-i386/irqflags.h
@@ -10,6 +10,9 @@
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #ifndef __ASSEMBLY__
 =

 static inline unsigned long __raw_local_save_flags(void)
@@ -24,9 +27,6 @@ static inline unsigned long __raw_local_
 =

 	return flags;
 }
-
-#define raw_local_save_flags(flags) \
-		do { (flags) =3D __raw_local_save_flags(); } while (0)
 =

 static inline void raw_local_irq_restore(unsigned long flags)
 {
@@ -66,18 +66,6 @@ static inline void halt(void)
 	__asm__ __volatile__("hlt": : :"memory");
 }
 =

-static inline int raw_irqs_disabled_flags(unsigned long flags)
-{
-	return !(flags & (1 << 9));
-}
-
-static inline int raw_irqs_disabled(void)
-{
-	unsigned long flags =3D __raw_local_save_flags();
-
-	return raw_irqs_disabled_flags(flags);
-}
-
 /*
  * For spinlocks, etc:
  */
@@ -90,9 +78,33 @@ static inline unsigned long __raw_local_
 	return flags;
 }
 =

+#else
+#define DISABLE_INTERRUPTS		cli
+#define ENABLE_INTERRUPTS		sti
+#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
+#define INTERRUPT_RETURN		iret
+#define GET_CR0_INTO_EAX		movl %cr0, %eax
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifndef __ASSEMBLY__
+#define raw_local_save_flags(flags) \
+		do { (flags) =3D __raw_local_save_flags(); } while (0)
+
 #define raw_local_irq_save(flags) \
 		do { (flags) =3D __raw_local_irq_save(); } while (0)
 =

+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & (1 << 9));
+}
+
+static inline int raw_irqs_disabled(void)
+{
+	unsigned long flags =3D __raw_local_save_flags();
+
+	return raw_irqs_disabled_flags(flags);
+}
 #endif /* __ASSEMBLY__ */
 =

 /*
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/msr.h
+++ b/include/asm-i386/msr.h
@@ -1,5 +1,9 @@
 #ifndef __ASM_MSR_H
 #define __ASM_MSR_H
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 =

 /*
  * Access to machine-specific registers (available on 586 and better only)
@@ -77,6 +81,7 @@ static inline void wrmsrl (unsigned long
      __asm__ __volatile__("rdpmc" \
 			  : "=3Da" (low), "=3Dd" (high) \
 			  : "c" (counter))
+#endif	/* !CONFIG_PARAVIRT */
 =

 /* symbolic names for some interesting MSRs */
 /* Intel defined MSRs. */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -143,6 +143,9 @@ static inline void detect_ht(struct cpui
 #define X86_EFLAGS_VIP	0x00100000 /* Virtual Interrupt Pending */
 #define X86_EFLAGS_ID	0x00200000 /* CPUID detection flag */
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
@@ -154,6 +157,34 @@ static inline void __cpuid(unsigned int =

 		  "=3Dd" (*edx)
 		: "0" (*eax), "2" (*ecx));
 }
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, register)				\
+		__asm__("movl %%db" #register ", %0"		\
+			:"=3Dr" (var))
+#define set_debugreg(value, register)			\
+		__asm__("movl %0,%%db" #register		\
+			: /* no output */			\
+			:"r" (value))
+
+/*
+ * Set IOPL bits in EFLAGS from given mask
+ */
+static inline void set_iopl_mask(unsigned mask)
+{
+	unsigned int reg;
+	__asm__ __volatile__ ("pushfl;"
+			      "popl %0;"
+			      "andl %1, %0;"
+			      "orl %2, %0;"
+			      "pushl %0;"
+			      "popfl"
+				: "=3D&r" (reg)
+				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
+}
+#endif /* CONFIG_PARAVIRT */
 =

 /*
  * Generic CPUID function
@@ -508,33 +539,6 @@ static inline void load_esp0(struct tss_
 	regs->esp =3D new_esp;					\
 } while (0)
 =

-/*
- * These special macros can be used to get or set a debugging register
- */
-#define get_debugreg(var, register)				\
-		__asm__("movl %%db" #register ", %0"		\
-			:"=3Dr" (var))
-#define set_debugreg(value, register)			\
-		__asm__("movl %0,%%db" #register		\
-			: /* no output */			\
-			:"r" (value))
-
-/*
- * Set IOPL bits in EFLAGS from given mask
- */
-static inline void set_iopl_mask(unsigned mask)
-{
-	unsigned int reg;
-	__asm__ __volatile__ ("pushfl;"
-			      "popl %0;"
-			      "andl %1, %0;"
-			      "orl %2, %0;"
-			      "pushl %0;"
-			      "popfl"
-				: "=3D&r" (reg)
-				: "i" (~X86_EFLAGS_IOPL), "r" (mask));
-}
-
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/segment.h
+++ b/include/asm-i386/segment.h
@@ -128,5 +128,7 @@
 #define SEGMENT_LDT		0x4
 #define SEGMENT_GDT		0x0
 =

+#ifndef CONFIG_PARAVIRT
 #define get_kernel_rpl()  0
 #endif
+#endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -17,8 +17,12 @@
  * (the type definitions are in asm/spinlock_types.h)
  */
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
+#endif /* CONFIG_PARAVIRT */
 =

 #define __raw_spin_is_locked(x) \
 		(*(volatile signed char *)(&(x)->slock) <=3D 0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -82,6 +82,9 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define savesegment(seg, value) \
 	asm volatile("mov %%" #seg ",%0":"=3Drm" (value))
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #define read_cr0() ({ \
 	unsigned int __dummy; \
 	__asm__ __volatile__( \
@@ -133,16 +136,17 @@ __asm__ __volatile__ ("movw %%dx,%1\n\t"
 #define write_cr4(x) \
 	__asm__ __volatile__("movl %0,%%cr4": :"r" (x))
 =

-/*
- * Clear and set 'TS' bit respectively
- */
-#define clts() __asm__ __volatile__ ("clts")
-#define stts() write_cr0(8 | read_cr0())
-
-#endif	/* __KERNEL__ */
-
 #define wbinvd() \
 	__asm__ __volatile__ ("wbinvd": : :"memory")
+
+/* Clear the 'TS' bit */
+#define clts() __asm__ __volatile__ ("clts")
+#endif/* CONFIG_PARAVIRT */
+
+/* Set the 'TS' bit */
+#define stts() write_cr0(8 | read_cr0())
+
+#endif	/* __KERNEL__ */
 =

 static inline unsigned long get_limit(unsigned long segment)
 {
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/arch/i386/kernel/paravirt.c
@@ -0,0 +1,367 @@
+/*  Paravirtualization interfaces
+    Copyright (C) 2006 Rusty Russell IBM Corporation
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+*/
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <asm/bug.h>
+#include <asm/paravirt.h>
+#include <asm/desc.h>
+
+static fastcall void native_cpuid(unsigned int *eax, unsigned int *ebx,
+				  unsigned int *ecx, unsigned int *edx)
+{
+	/* must be "asm volatile" so that it won't be optimised out in
+	   native_sync_core  */
+	asm volatile ("cpuid"
+		      : "=3Da" (*eax),
+			"=3Db" (*ebx),
+			"=3Dc" (*ecx),
+			"=3Dd" (*edx)
+		      : "0" (*eax), "2" (*ecx));
+}
+
+static fastcall unsigned int native_get_debugreg(int regno)
+{
+	unsigned int val =3D 0; 	/* Damn you, gcc! */
+
+	switch (regno) {
+	case 0:
+		asm("movl %%db0, %0" :"=3Dr" (val)); break;
+	case 1:
+		asm("movl %%db1, %0" :"=3Dr" (val)); break;
+	case 2:
+		asm("movl %%db2, %0" :"=3Dr" (val)); break;
+	case 3:
+		asm("movl %%db3, %0" :"=3Dr" (val)); break;
+	case 6:
+		asm("movl %%db6, %0" :"=3Dr" (val)); break;
+	case 7:
+		asm("movl %%db7, %0" :"=3Dr" (val)); break;
+	default:
+		BUG();
+	}
+	return val;
+}
+
+static fastcall void native_set_debugreg(int regno, unsigned int value)
+{
+	switch (regno) {
+	case 0:
+		asm("movl %0,%%db0"	: /* no output */ :"r" (value));
+		break;
+	case 1:
+		asm("movl %0,%%db1"	: /* no output */ :"r" (value));
+		break;
+	case 2:
+		asm("movl %0,%%db2"	: /* no output */ :"r" (value));
+		break;
+	case 3:
+		asm("movl %0,%%db3"	: /* no output */ :"r" (value));
+		break;
+	case 6:
+		asm("movl %0,%%db6"	: /* no output */ :"r" (value));
+		break;
+	case 7:
+		asm("movl %0,%%db7"	: /* no output */ :"r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+static fastcall void native_clts(void)
+{
+	asm volatile ("clts");
+}
+
+static fastcall unsigned int native_read_cr0(void)
+{
+	unsigned int val;
+	asm volatile("movl %%cr0,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall void native_write_cr0(unsigned int val)
+{
+	asm volatile("movl %0,%%cr0": :"r" (val));
+}
+
+static fastcall unsigned int native_read_cr2(void)
+{
+	unsigned int val;
+	asm volatile("movl %%cr2,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall void native_write_cr2(unsigned int val)
+{
+	asm volatile("movl %0,%%cr2": :"r" (val));
+}
+
+static fastcall unsigned int native_read_cr3(void)
+{
+	unsigned int val;
+	asm volatile("movl %%cr3,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall void native_write_cr3(unsigned int val)
+{
+	asm volatile("movl %0,%%cr3": :"r" (val));
+}
+
+static fastcall unsigned int native_read_cr4(void)
+{
+	unsigned int val;
+	asm volatile("movl %%cr4,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall unsigned int native_read_cr4_safe(void)
+{
+	unsigned int val;
+	/* This could fault if %cr4 does not exist */
+	asm("1: movl %%cr4, %0		\n"
+		"2:				\n"
+		".section __ex_table,\"a\"	\n"
+		".long 1b,2b			\n"
+		".previous			\n"
+		: "=3Dr" (val): "0" (0));
+	return val;
+}
+
+static fastcall void native_write_cr4(unsigned int val)
+{
+	asm volatile("movl %0,%%cr4": :"r" (val));
+}
+
+static fastcall unsigned long native_save_fl(void)
+{
+	unsigned long f;
+	asm volatile("pushfl ; popl %0":"=3Dg" (f): /* no input */);
+	return f;
+}
+
+static fastcall void native_restore_fl(unsigned long f)
+{
+	asm volatile("pushl %0 ; popfl": /* no output */
+			     :"g" (f)
+			     :"memory", "cc");
+}
+
+static fastcall void native_irq_disable(void)
+{
+	asm volatile("cli": : :"memory");
+}
+
+static fastcall void native_irq_enable(void)
+{
+	asm volatile("sti": : :"memory");
+}
+
+static fastcall void native_safe_halt(void)
+{
+	asm volatile("sti; hlt": : :"memory");
+}
+
+static fastcall void native_halt(void)
+{
+	asm volatile("hlt": : :"memory");
+}
+
+static fastcall void native_wbinvd(void)
+{
+	asm volatile("wbinvd": : :"memory");
+}
+
+static fastcall unsigned long long native_read_msr(unsigned int msr, int *=
err)
+{
+	unsigned long long val;
+
+	asm volatile("2: rdmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %3,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 4\n\t"
+		     "   .long 	2b,3b\n\t"
+		     ".previous"
+		     : "=3Dr" (*err), "=3DA" (val)
+		     : "c" (msr), "i" (-EFAULT));
+
+	return val;
+}
+
+static fastcall int native_write_msr(unsigned int msr, unsigned long long =
val)
+{
+	int err;
+	asm volatile("2: wrmsr ; xorl %0,%0\n"
+		     "1:\n\t"
+		     ".section .fixup,\"ax\"\n\t"
+		     "3:  movl %4,%0 ; jmp 1b\n\t"
+		     ".previous\n\t"
+ 		     ".section __ex_table,\"a\"\n"
+		     "   .align 4\n\t"
+		     "   .long 	2b,3b\n\t"
+		     ".previous"
+		     : "=3Da" (err)
+		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val>>32)),
+		       "i" (-EFAULT));
+	return err;
+}
+
+static fastcall unsigned long long native_read_tsc(void)
+{
+	unsigned long long val;
+	asm volatile("rdtsc" : "=3DA" (val));
+	return val;
+}
+
+static fastcall unsigned long long native_read_pmc(void)
+{
+	unsigned long long val;
+	asm volatile("rdpmc" : "=3DA" (val));
+	return val;
+}
+
+static fastcall void native_load_tr_desc(void)
+{
+	asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
+}
+
+static fastcall void native_load_ldt_desc(void)
+{
+	asm volatile("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
+}
+
+static fastcall void native_load_gdt(const struct Xgt_desc_struct *dtr)
+{
+	asm volatile("lgdt %0"::"m" (*dtr));
+}
+
+static fastcall void native_load_idt(const struct Xgt_desc_struct *dtr)
+{
+	asm volatile("lidt %0"::"m" (*dtr));
+}
+
+static fastcall void native_store_gdt(struct Xgt_desc_struct *dtr)
+{
+	asm ("sgdt %0":"=3Dm" (*dtr));
+}
+
+static fastcall void native_store_idt(struct Xgt_desc_struct *dtr)
+{
+	asm ("sidt %0":"=3Dm" (*dtr));
+}
+
+static fastcall unsigned long native_store_tr(void)
+{
+	unsigned long tr;
+	asm ("str %0":"=3Dr" (tr));
+	return tr;
+}
+
+static fastcall void native_load_tls(struct thread_struct *t, unsigned int=
 cpu)
+{
+#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] =3D t->tls_arra=
y[i]
+	C(0); C(1); C(2);
+#undef C
+}
+
+static inline void native_write_dt_entry(void *dt, int entry, __u32 entry_=
a, __u32 entry_b)
+{
+	__u32 *lp =3D (__u32 *)((char *)dt + entry*8);
+	*lp =3D entry_a;
+	*(lp+1) =3D entry_b;
+}
+
+static fastcall void native_write_ldt_entry(void *dt, int entrynum, u64 en=
try)
+{
+	native_write_dt_entry(dt, entrynum, entry >> 32, entry);
+}
+
+static fastcall void native_write_gdt_entry(void *dt, int entrynum, u64 en=
try)
+{
+	native_write_dt_entry(dt, entrynum, entry >> 32, entry);
+}
+
+static fastcall void native_write_idt_entry(void *dt, int entrynum, u64 en=
try)
+{
+	native_write_dt_entry(dt, entrynum, entry >> 32, entry);
+}
+
+static fastcall void native_set_iopl_mask(unsigned mask)
+{
+	unsigned int reg;
+	asm volatile ("pushfl;"
+		      "popl %0;"
+		      "andl %1, %0;"
+		      "orl %2, %0;"
+		      "pushl %0;"
+		      "popfl"
+		      : "=3D&r" (reg)
+		      : "i" (~X86_EFLAGS_IOPL), "r" (mask));
+}
+
+/* These are in entry.S */
+extern fastcall void native_iret(void);
+extern fastcall void native_irq_enable_sysexit(void);
+
+struct paravirt_ops paravirt_ops =3D {
+	.kernel_rpl =3D 0,
+	.cpuid =3D native_cpuid,
+	.get_debugreg =3D native_get_debugreg,
+	.set_debugreg =3D native_set_debugreg,
+	.clts =3D native_clts,
+	.read_cr0 =3D native_read_cr0,
+	.write_cr0 =3D native_write_cr0,
+	.read_cr2 =3D native_read_cr2,
+	.write_cr2 =3D native_write_cr2,
+	.read_cr3 =3D native_read_cr3,
+	.write_cr3 =3D native_write_cr3,
+	.read_cr4 =3D native_read_cr4,
+	.read_cr4_safe =3D native_read_cr4_safe,
+	.write_cr4 =3D native_write_cr4,
+	.save_fl =3D native_save_fl,
+	.restore_fl =3D native_restore_fl,
+	.irq_disable =3D native_irq_disable,
+	.irq_enable =3D native_irq_enable,
+	.safe_halt =3D native_safe_halt,
+	.halt =3D native_halt,
+	.wbinvd =3D native_wbinvd,
+	.read_msr =3D native_read_msr,
+	.write_msr =3D native_write_msr,
+	.read_tsc =3D native_read_tsc,
+	.read_pmc =3D native_read_pmc,
+	.load_tr_desc =3D native_load_tr_desc,
+	.load_ldt_desc =3D native_load_ldt_desc,
+	.load_gdt =3D native_load_gdt,
+	.load_idt =3D native_load_idt,
+	.store_gdt =3D native_store_gdt,
+	.store_idt =3D native_store_idt,
+	.store_tr =3D native_store_tr,
+	.load_tls =3D native_load_tls,
+	.write_ldt_entry =3D native_write_ldt_entry,
+	.write_gdt_entry =3D native_write_gdt_entry,
+	.write_idt_entry =3D native_write_idt_entry,
+
+	.set_iopl_mask =3D native_set_iopl_mask,
+	.irq_enable_sysexit =3D native_irq_enable_sysexit,
+	.iret =3D native_iret,
+};
+EXPORT_SYMBOL(paravirt_ops);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/include/asm-i386/paravirt.h
@@ -0,0 +1,223 @@
+#ifndef __ASM_PARAVIRT_H
+#define __ASM_PARAVIRT_H
+/* Various instructions on x86 need to be replaced for
+ * para-virtualization: those hooks are defined here. */
+#include <linux/linkage.h>
+
+#ifdef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+struct thread_struct;
+struct Xgt_desc_struct;
+struct paravirt_ops
+{
+	unsigned int kernel_rpl;
+
+	/* All the function pointers here are declared as "fastcall"
+	   so that we get a specific register-based calling
+	   convention.  This makes it easier to implement inline
+	   assembler replacements. */
+
+	void (fastcall *cpuid)(unsigned int *eax, unsigned int *ebx,
+		      unsigned int *ecx, unsigned int *edx);
+
+	unsigned int (fastcall *get_debugreg)(int regno);
+	void (fastcall *set_debugreg)(int regno, unsigned int value);
+
+	void (fastcall *clts)(void);
+
+	unsigned int (fastcall *read_cr0)(void);
+	void (fastcall *write_cr0)(unsigned int);
+
+	unsigned int (fastcall *read_cr2)(void);
+	void (fastcall *write_cr2)(unsigned int);
+
+	unsigned int (fastcall *read_cr3)(void);
+	void (fastcall *write_cr3)(unsigned int);
+
+	unsigned int (fastcall *read_cr4_safe)(void);
+	unsigned int (fastcall *read_cr4)(void);
+	void (fastcall *write_cr4)(unsigned int);
+
+	unsigned long (fastcall *save_fl)(void);
+	void (fastcall *restore_fl)(unsigned long);
+	void (fastcall *irq_disable)(void);
+	void (fastcall *irq_enable)(void);
+	void (fastcall *safe_halt)(void);
+	void (fastcall *halt)(void);
+	void (fastcall *wbinvd)(void);
+
+	/* err =3D 0/-EFAULT.  wrmsr returns 0/-EFAULT. */
+	u64 (fastcall *read_msr)(unsigned int msr, int *err);
+	int (fastcall *write_msr)(unsigned int msr, u64 val);
+
+	u64 (fastcall *read_tsc)(void);
+	u64 (fastcall *read_pmc)(void);
+
+	void (fastcall *load_tr_desc)(void);
+	void (fastcall *load_ldt_desc)(void);
+	void (fastcall *load_gdt)(const struct Xgt_desc_struct *);
+	void (fastcall *load_idt)(const struct Xgt_desc_struct *);
+	void (fastcall *store_gdt)(struct Xgt_desc_struct *);
+	void (fastcall *store_idt)(struct Xgt_desc_struct *);
+	unsigned long (fastcall *store_tr)(void);
+	void (fastcall *load_tls)(struct thread_struct *t, unsigned int cpu);
+	void (fastcall *write_ldt_entry)(void *dt, int entrynum, u64 entry);
+	void (fastcall *write_gdt_entry)(void *dt, int entrynum, u64 entry);
+	void (fastcall *write_idt_entry)(void *dt, int entrynum, u64 entry);
+
+	void (fastcall *set_iopl_mask)(unsigned mask);
+
+	/* These two are jmp to, not actually called. */
+	void (fastcall *irq_enable_sysexit)(void);
+	void (fastcall *iret)(void);
+};
+
+extern struct paravirt_ops paravirt_ops;
+
+/* The paravirtualized CPUID instruction. */
+static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
+			   unsigned int *ecx, unsigned int *edx)
+{
+	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * These special macros can be used to get or set a debugging register
+ */
+#define get_debugreg(var, reg) var =3D paravirt_ops.get_debugreg(reg)
+#define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
+
+#define clts() paravirt_ops.clts()
+
+#define read_cr0() paravirt_ops.read_cr0()
+#define write_cr0(x) paravirt_ops.write_cr0(x)
+
+#define read_cr2() paravirt_ops.read_cr2()
+#define write_cr2(x) paravirt_ops.write_cr2(x)
+
+#define read_cr3() paravirt_ops.read_cr3()
+#define write_cr3(x) paravirt_ops.write_cr3(x)
+
+#define read_cr4() paravirt_ops.read_cr4()
+#define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
+#define write_cr4(x) paravirt_ops.write_cr4(x)
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	return paravirt_ops.save_fl();
+}
+
+static inline void raw_local_irq_restore(unsigned long flags)
+{
+	return paravirt_ops.restore_fl(flags);
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	paravirt_ops.irq_disable();
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	paravirt_ops.irq_enable();
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long flags =3D paravirt_ops.save_fl();
+
+	paravirt_ops.irq_disable();
+
+	return flags;
+}
+
+static inline void raw_safe_halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+
+static inline void halt(void)
+{
+	paravirt_ops.safe_halt();
+}
+#define wbinvd() paravirt_ops.wbinvd()
+
+#define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
+
+#define rdmsr(msr,val1,val2) do {				\
+	int _err;						\
+	u64 _l =3D paravirt_ops.read_msr(msr,&_err);		\
+	val1 =3D (u32)_l;						\
+	val2 =3D _l >> 32;					\
+} while(0)
+
+#define wrmsr(msr,val1,val2) do {				\
+	u64 _l =3D ((u64)(val2) << 32) | (val1);			\
+	paravirt_ops.write_msr((msr), _l);			\
+} while(0)
+
+#define rdmsrl(msr,val) do {					\
+	int _err;						\
+	val =3D paravirt_ops.read_msr((msr),&_err);		\
+} while(0)
+
+#define wrmsrl(msr,val) (paravirt_ops.write_msr((msr),(val)))
+#define wrmsr_safe(msr,a,b) ({					\
+	u64 _l =3D ((u64)(b) << 32) | (a);			\
+	paravirt_ops.write_msr((msr),_l);			\
+})
+
+/* rdmsr with exception handling */
+#define rdmsr_safe(msr,a,b) ({					\
+	int _err;						\
+	u64 _l =3D paravirt_ops.read_msr(msr,&_err);		\
+	(*a) =3D (u32)_l;						\
+	(*b) =3D _l >> 32;					\
+	_err; })
+
+#define rdtsc(low,high) do {					\
+	u64 _l =3D paravirt_ops.read_tsc();			\
+	low =3D (u32)_l;						\
+	high =3D _l >> 32;					\
+} while(0)
+
+#define rdtscl(low) do {					\
+	u64 _l =3D paravirt_ops.read_tsc();			\
+	low =3D (int)_l;						\
+} while(0)
+
+#define rdtscll(val) (val =3D paravirt_ops.read_tsc())
+
+#define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
+
+#define rdpmc(counter,low,high) do {				\
+	u64 _l =3D paravirt_ops.read_pmc();			\
+	low =3D (u32)_l;						\
+	high =3D _l >> 32;					\
+} while(0)
+
+#define load_TR_desc() (paravirt_ops.load_tr_desc())
+#define load_LDT_desc() (paravirt_ops.load_ldt_desc())
+#define load_gdt(dtr) (paravirt_ops.load_gdt(dtr))
+#define load_idt(dtr) (paravirt_ops.load_idt(dtr))
+#define store_gdt(dtr) (paravirt_ops.store_gdt(dtr))
+#define store_idt(dtr) (paravirt_ops.store_idt(dtr))
+#define store_tr(tr) ((tr) =3D paravirt_ops.store_tr())
+#define load_TLS(t,cpu) (paravirt_ops.load_tls((t),(cpu)))
+#define write_ldt_entry(dt, entry, a, b) (paravirt_ops.write_ldt_entry((dt=
), (entry), ((u64)a) << 32 | b))
+#define write_gdt_entry(dt, entry, a, b) (paravirt_ops.write_gdt_entry((dt=
), (entry), ((u64)a) << 32 | b))
+#define write_idt_entry(dt, entry, a, b) (paravirt_ops.write_idt_entry((dt=
), (entry), ((u64)a) << 32 | b))
+#define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
+
+#define CLI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops=
+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax"
+#define STI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops=
+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax"
+#else  /* __ASSEMBLY__ */
+
+#define INTERRUPT_RETURN	jmp *%cs:paravirt_ops+PARAVIRT_iret
+#define DISABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *parav=
irt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax
+#define ENABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *%cs:pa=
ravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax
+#define ENABLE_INTERRUPTS_SYSEXIT	jmp *%cs:paravirt_ops+PARAVIRT_irq_enabl=
e_sysexit
+#define GET_CR0_INTO_EAX	call *paravirt_ops+PARAVIRT_read_cr0
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+#endif	/* __ASM_PARAVIRT_H */

-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
