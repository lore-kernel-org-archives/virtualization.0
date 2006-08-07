From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
Date: Mon, 07 Aug 2006 14:47:27 +1000
Message-ID: <1154926048.21647.35.camel@localhost.localdomain>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<1154925943.21647.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1154925943.21647.32.camel@localhost.localdomain>
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
Cc: Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

This patch does the dumbest possible replacement of paravirtualized
instructions: calls through a "paravirt_ops" structure.  Currently
these are function implementations of native hardware: hypervisors
will override the ops structure with their own variants.

All the pv-ops functions are declared "fastcall" so that a specific
register-based ABI is used, to make inlining assember easier.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/Kconfig                |   11 +
 arch/i386/kernel/Makefile        |    1
 arch/i386/kernel/asm-offsets.c   |    8
 arch/i386/kernel/entry.S         |    9
 arch/i386/kernel/paravirt.c      |  392 ++++++++++++++++++++++++++++++++++=
++++
 include/asm-i386/msr.h           |    5
 include/asm-i386/paravirt.h      |  226 +++++++++++++++++++++
 include/asm-i386/paravirt_desc.h |    5
 8 files changed, 657 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -180,6 +180,17 @@ config X86_ES7000
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
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/elf.h>
+#include <asm/paravirt.h>
 =

 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -74,4 +75,11 @@ void foo(void)
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
@@ -803,6 +803,15 @@ 1:	INTERRUPT_RETURN
 	.long 1b,iret_exc
 .previous
 =

+#ifdef CONFIG_PARAVIRT
+ENTRY(nopara_iret)
+	iret
+
+ENTRY(nopara_irq_enable_sysexit)
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
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -2,6 +2,232 @@
 #define __ASM_PARAVIRT_H
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
+#include <linux/linkage.h>
+
+#ifndef CONFIG_PARAVIRT
 #include <asm/no_paravirt.h>
+#else
+
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
+	void (fastcall *sync_core)(void);
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
+	unsigned long (fastcall *save_fl_irq_disable)(void);
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
+/* Stop speculative execution */
+static inline void sync_core(void)
+{
+	paravirt_ops.sync_core();
+}
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
+	return paravirt_ops.save_fl_irq_disable();
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
+#define INTERRUPT_RETURN	jmp *paravirt_ops+PARAVIRT_iret
+#define DISABLE_INTERRUPTS	call *paravirt_ops+PARAVIRT_irq_disable
+#define ENABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *paravi=
rt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax
+#define ENABLE_INTERRUPTS_SYSEXIT	jmp *paravirt_ops+PARAVIRT_irq_enable_sy=
sexit
+#define GET_CR0_INTO_EAX	call *paravirt_ops+PARAVIRT_read_cr0
+#endif /* __ASSEMBLY__ */
+
+#endif	/* PARAVIRT */
 =

 #endif	/* __ASM_PARAVIRT_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt_desc.h
+++ b/include/asm-i386/paravirt_desc.h
@@ -1,6 +1,10 @@
 #ifndef __ASM_PARAVIRT_DESC_H
 #define __ASM_PARAVIRT_DESC_H
 /* A separate header because they need processor.h, which needs paravirt.h=
 */
+#ifndef CONFIG_PARAVIRT
 #include <asm/no_paravirt_desc.h>
+#else
+#include <asm/paravirt.h>
+#endif
 =

 #endif	/* __ASM_PARAVIRT_DESC_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/arch/i386/kernel/paravirt.c
@@ -0,0 +1,382 @@
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
+static fastcall void nopara_cpuid(unsigned int *eax, unsigned int *ebx,
+				  unsigned int *ecx, unsigned int *edx)
+{
+	/* must be "asm volatile" so that it won't be optimised out in
+	   nopara_sync_core  */
+	asm volatile ("cpuid"
+		      : "=3Da" (*eax),
+			"=3Db" (*ebx),
+			"=3Dc" (*ecx),
+			"=3Dd" (*edx)
+		      : "0" (*eax), "2" (*ecx));
+}
+
+static fastcall unsigned int nopara_get_debugreg(int regno)
+{
+	unsigned int val =3D 0; 	/* Damn you, gcc! */
+
+	switch (regno) {
+	case 0:
+		__asm__("movl %%db0, %0" :"=3Dr" (val)); break;
+	case 1:
+		__asm__("movl %%db1, %0" :"=3Dr" (val)); break;
+	case 2:
+		__asm__("movl %%db2, %0" :"=3Dr" (val)); break;
+	case 3:
+		__asm__("movl %%db3, %0" :"=3Dr" (val)); break;
+	case 6:
+		__asm__("movl %%db6, %0" :"=3Dr" (val)); break;
+	case 7:
+		__asm__("movl %%db7, %0" :"=3Dr" (val)); break;
+	default:
+		BUG();
+	}
+	return val;
+}
+
+static fastcall void nopara_set_debugreg(int regno, unsigned int value)
+{
+	switch (regno) {
+	case 0:
+		__asm__("movl %0,%%db0"	: /* no output */ :"r" (value));
+		break;
+	case 1:
+		__asm__("movl %0,%%db1"	: /* no output */ :"r" (value));
+		break;
+	case 2:
+		__asm__("movl %0,%%db2"	: /* no output */ :"r" (value));
+		break;
+	case 3:
+		__asm__("movl %0,%%db3"	: /* no output */ :"r" (value));
+		break;
+	case 6:
+		__asm__("movl %0,%%db6"	: /* no output */ :"r" (value));
+		break;
+	case 7:
+		__asm__("movl %0,%%db7"	: /* no output */ :"r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+static fastcall void nopara_sync_core(void)
+{
+	unsigned int eax =3D 1, ebx, ecx =3D 0, edx;
+	nopara_cpuid(&eax, &ebx, &ecx, &edx);
+}
+
+static fastcall void nopara_clts(void)
+{
+	__asm__ __volatile__ ("clts");
+}
+
+static fastcall unsigned int nopara_read_cr0(void)
+{
+	unsigned int val;
+	__asm__ __volatile__("movl %%cr0,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall void nopara_write_cr0(unsigned int val)
+{
+	__asm__ __volatile__("movl %0,%%cr0": :"r" (val));
+}
+
+static fastcall unsigned int nopara_read_cr2(void)
+{
+	unsigned int val;
+	__asm__ __volatile__("movl %%cr2,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall void nopara_write_cr2(unsigned int val)
+{
+	__asm__ __volatile__("movl %0,%%cr2": :"r" (val));
+}
+
+static fastcall unsigned int nopara_read_cr3(void)
+{
+	unsigned int val;
+	__asm__ __volatile__("movl %%cr3,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall void nopara_write_cr3(unsigned int val)
+{
+	__asm__ __volatile__("movl %0,%%cr3": :"r" (val));
+}
+
+static fastcall unsigned int nopara_read_cr4(void)
+{
+	unsigned int val;
+	__asm__ __volatile__("movl %%cr4,%0\n\t" :"=3Dr" (val));
+	return val;
+}
+
+static fastcall unsigned int nopara_read_cr4_safe(void)
+{
+	unsigned int val;
+	/* This could fault if %cr4 does not exist */
+	__asm__("1: movl %%cr4, %0		\n"
+		"2:				\n"
+		".section __ex_table,\"a\"	\n"
+		".long 1b,2b			\n"
+		".previous			\n"
+		: "=3Dr" (val): "0" (0));
+	return val;
+}
+
+static fastcall void nopara_write_cr4(unsigned int val)
+{
+	__asm__ __volatile__("movl %0,%%cr4": :"r" (val));
+}
+
+static fastcall unsigned long nopara_save_fl(void)
+{
+	unsigned long f;
+	__asm__ __volatile__("pushfl ; popl %0":"=3Dg" (f): /* no input */);
+	return f;
+}
+
+static fastcall unsigned long nopara_save_fl_irq_disable(void)
+{
+	unsigned long f;
+	__asm__ __volatile__("pushfl ; popl %0; cli":"=3Dg" (f): : "memory");
+	return f;
+}
+
+static fastcall void nopara_restore_fl(unsigned long f)
+{
+	__asm__ __volatile__("pushl %0 ; popfl": /* no output */
+			     :"g" (f)
+			     :"memory", "cc");
+}
+
+static fastcall void nopara_irq_disable(void)
+{
+	__asm__ __volatile__("cli": : :"memory");
+}
+
+static fastcall void nopara_irq_enable(void)
+{
+	__asm__ __volatile__("sti": : :"memory");
+}
+
+static fastcall void nopara_safe_halt(void)
+{
+	__asm__ __volatile__("sti; hlt": : :"memory");
+}
+
+static fastcall void nopara_halt(void)
+{
+	__asm__ __volatile__("hlt": : :"memory");
+}
+
+static fastcall void nopara_wbinvd(void)
+{
+	__asm__ __volatile__("wbinvd": : :"memory");
+}
+
+static fastcall unsigned long long nopara_read_msr(unsigned int msr, int *=
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
+static fastcall int nopara_write_msr(unsigned int msr, unsigned long long =
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
+static fastcall unsigned long long nopara_read_tsc(void)
+{
+	unsigned long long val;
+	__asm__ __volatile__("rdtsc" : "=3DA" (val));
+	return val;
+}
+
+static fastcall unsigned long long nopara_read_pmc(void)
+{
+	unsigned long long val;
+	__asm__ __volatile__("rdpmc" : "=3DA" (val));
+	return val;
+}
+
+static fastcall void nopara_load_tr_desc(void)
+{
+	__asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
+}
+
+static fastcall void nopara_load_ldt_desc(void)
+{
+	__asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8));
+}
+
+static fastcall void nopara_load_gdt(const struct Xgt_desc_struct *dtr)
+{
+	__asm__ __volatile("lgdt %0"::"m" (*dtr));
+}
+
+static fastcall void nopara_load_idt(const struct Xgt_desc_struct *dtr)
+{
+	__asm__ __volatile("lidt %0"::"m" (*dtr));
+}
+
+static fastcall void nopara_store_gdt(struct Xgt_desc_struct *dtr)
+{
+	__asm__ ("sgdt %0":"=3Dm" (*dtr));
+}
+
+static fastcall void nopara_store_idt(struct Xgt_desc_struct *dtr)
+{
+	__asm__ ("sidt %0":"=3Dm" (*dtr));
+}
+
+static fastcall unsigned long nopara_store_tr(void)
+{
+	unsigned long tr;
+	__asm__ ("str %0":"=3Dr" (tr));
+	return tr;
+}
+
+static fastcall void nopara_load_tls(struct thread_struct *t, unsigned int=
 cpu)
+{
+#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] =3D t->tls_arra=
y[i]
+	C(0); C(1); C(2);
+#undef C
+}
+
+static inline void write_dt_entry(void *dt, int entry, __u32 entry_a, __u3=
2 entry_b)
+{
+	__u32 *lp =3D (__u32 *)((char *)dt + entry*8);
+	*lp =3D entry_a;
+	*(lp+1) =3D entry_b;
+}
+
+static fastcall void nopara_write_ldt_entry(void *dt, int entrynum, u64 en=
try)
+{
+	write_dt_entry(dt, entrynum, entry >> 32, entry);
+}
+
+static fastcall void nopara_write_gdt_entry(void *dt, int entrynum, u64 en=
try)
+{
+	write_dt_entry(dt, entrynum, entry >> 32, entry);
+}
+
+static fastcall void nopara_write_idt_entry(void *dt, int entrynum, u64 en=
try)
+{
+	write_dt_entry(dt, entrynum, entry >> 32, entry);
+}
+
+static fastcall void nopara_set_iopl_mask(unsigned mask)
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
+
+/* These are in entry.S */
+extern fastcall void nopara_iret(void);
+extern fastcall void nopara_irq_enable_sysexit(void);
+
+struct paravirt_ops paravirt_ops =3D {
+	.kernel_rpl =3D 0,
+	.cpuid =3D nopara_cpuid,
+	.get_debugreg =3D nopara_get_debugreg,
+	.set_debugreg =3D nopara_set_debugreg,
+	.sync_core =3D nopara_sync_core,
+	.clts =3D nopara_clts,
+	.read_cr0 =3D nopara_read_cr0,
+	.write_cr0 =3D nopara_write_cr0,
+	.read_cr2 =3D nopara_read_cr2,
+	.write_cr2 =3D nopara_write_cr2,
+	.read_cr3 =3D nopara_read_cr3,
+	.write_cr3 =3D nopara_write_cr3,
+	.read_cr4 =3D nopara_read_cr4,
+	.read_cr4_safe =3D nopara_read_cr4_safe,
+	.write_cr4 =3D nopara_write_cr4,
+	.save_fl =3D nopara_save_fl,
+	.restore_fl =3D nopara_restore_fl,
+	.save_fl_irq_disable =3D nopara_save_fl_irq_disable,
+	.irq_disable =3D nopara_irq_disable,
+	.irq_enable =3D nopara_irq_enable,
+	.safe_halt =3D nopara_safe_halt,
+	.halt =3D nopara_halt,
+	.wbinvd =3D nopara_wbinvd,
+	.read_msr =3D nopara_read_msr,
+	.write_msr =3D nopara_write_msr,
+	.read_tsc =3D nopara_read_tsc,
+	.read_pmc =3D nopara_read_pmc,
+	.load_tr_desc =3D nopara_load_tr_desc,
+	.load_ldt_desc =3D nopara_load_ldt_desc,
+	.load_gdt =3D nopara_load_gdt,
+	.load_idt =3D nopara_load_idt,
+	.store_gdt =3D nopara_store_gdt,
+	.store_idt =3D nopara_store_idt,
+	.store_tr =3D nopara_store_tr,
+	.load_tls =3D nopara_load_tls,
+	.write_ldt_entry =3D nopara_write_ldt_entry,
+	.write_gdt_entry =3D nopara_write_gdt_entry,
+	.write_idt_entry =3D nopara_write_idt_entry,
+
+	.set_iopl_mask =3D nopara_set_iopl_mask,
+	.irq_enable_sysexit =3D nopara_irq_enable_sysexit,
+	.iret =3D nopara_iret,
+};
+EXPORT_SYMBOL_GPL(paravirt_ops);

-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
