From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Fix CONFIG_PARAVIRT for 2.6.19-rc5-mm1
Date: Thu, 09 Nov 2006 12:01:42 +1100
Message-ID: <1163034102.15681.6.camel@localhost.localdomain>
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
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

OK, at least two patches got dropped on the way from the mm tree to
Andi's tree: the desc.h cleanup, and the processor.h rearrangement.
Merging into Andi's tree without these patches must have been a
nightmare 8(

Andi then tried to fix it with x86_64-mm-paravirt-compile.patch but then
it didn't boot so he disabled it in x86_64-mm-paravirt-broken.patch  =


This patch undoes those two patches and rearranges processor.h correctly
so the kernel compiles and boots with CONFIG_PARAVIRT.  Andi's
"paravirt-compile" patch also cleans up the spinlock header, which is
good but should probably be patched separately.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc5-mm1/arch/i386/Kconfig working-2.6.19-rc5-mm1-=
paravirt/arch/i386/Kconfig
--- linux-2.6.19-rc5-mm1/arch/i386/Kconfig	2006-11-09 11:21:58.000000000 +1=
100
+++ working-2.6.19-rc5-mm1-paravirt/arch/i386/Kconfig	2006-11-09 11:29:27.0=
00000000 +1100
@@ -204,8 +204,6 @@ endchoice
 config PARAVIRT
 	bool "Paravirtualization support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
-	# doesn't compile right now
-	depends on BROKEN
 	help
 	  Paravirtualization is a way of running multiple instances of
 	  Linux on the same machine, under a hypervisor.  This option
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc5-mm1/include/asm-i386/desc.h working-2.6.19-rc=
5-mm1-paravirt/include/asm-i386/desc.h
--- linux-2.6.19-rc5-mm1/include/asm-i386/desc.h	2006-11-09 11:22:25.000000=
000 +1100
+++ working-2.6.19-rc5-mm1-paravirt/include/asm-i386/desc.h	2006-11-09 11:3=
3:24.000000000 +1100
@@ -81,6 +81,10 @@ static inline void load_TLS(struct threa
 #undef C
 }
 =

+#define write_ldt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+#define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
+
 static inline void write_dt_entry(void *dt, int entry, __u32 entry_a, __u3=
2 entry_b)
 {
 	__u32 *lp =3D (__u32 *)((char *)dt + entry*8);
@@ -88,29 +92,9 @@ static inline void write_dt_entry(void *
 	*(lp+1) =3D entry_b;
 }
 =

-#define write_ldt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
-#define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
-#define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
-
 #define set_ldt native_set_ldt
 #endif /* CONFIG_PARAVIRT */
 =

-static inline void _set_gate(int gate, unsigned int type, void *addr, unsi=
gned short seg)
-{
-	__u32 a, b;
-	pack_gate(&a, &b, (unsigned long)addr, seg, type, 0);
-	write_idt_entry(idt_table, gate, a, b);
-}
-
-static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, co=
nst void *addr)
-{
-	__u32 a, b;
-	pack_descriptor(&a, &b, (unsigned long)addr,
-			offsetof(struct tss_struct, __cacheline_filler) - 1,
-			DESCTYPE_TSS, 0);
-	write_gdt_entry(get_cpu_gdt_table(cpu), entry, a, b);
-}
-
 static inline fastcall void native_set_ldt(const void *addr,
 					   unsigned int entries)
 {
@@ -128,6 +112,23 @@ static inline fastcall void native_set_l
 	}
 }
 =

+static inline void _set_gate(int gate, unsigned int type, void *addr, unsi=
gned short seg)
+{
+	__u32 a, b;
+	pack_gate(&a, &b, (unsigned long)addr, seg, type, 0);
+	write_idt_entry(idt_table, gate, a, b);
+}
+
+static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, co=
nst void *addr)
+{
+	__u32 a, b;
+	pack_descriptor(&a, &b, (unsigned long)addr,
+			offsetof(struct tss_struct, __cacheline_filler) - 1,
+			DESCTYPE_TSS, 0);
+	write_gdt_entry(get_cpu_gdt_table(cpu), entry, a, b);
+}
+
+
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
 =

 #define LDT_entry_a(info) \
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc5-mm1/include/asm-i386/paravirt.h working-2.6.1=
9-rc5-mm1-paravirt/include/asm-i386/paravirt.h
--- linux-2.6.19-rc5-mm1/include/asm-i386/paravirt.h	2006-11-09 11:22:25.00=
0000000 +1100
+++ working-2.6.19-rc5-mm1-paravirt/include/asm-i386/paravirt.h	2006-11-09 =
11:29:20.000000000 +1100
@@ -449,20 +449,16 @@ static inline unsigned long __raw_local_
 	return f;
 }
 =

-#define CLI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_disable];"		\
-		     "popl %%edx; popl %%ecx",				\
+#define CLI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
+		     "call *paravirt_ops+PARAVIRT_irq_disable;"		\
+		     "popl %edx; popl %ecx",				\
 		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
 =

-#define STI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_enable];"		\
-		     "popl %%edx; popl %%ecx",				\
+#define STI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
+		     "call *paravirt_ops+PARAVIRT_irq_enable;"		\
+		     "popl %edx; popl %ecx",				\
 		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
 #define CLI_STI_CLOBBERS , "%eax"
-#define CLI_STI_INPUT_ARGS \
-	,								\
-	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
-	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
 =

 #else  /* __ASSEMBLY__ */
 =

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc5-mm1/include/asm-i386/processor.h working-2.6.=
19-rc5-mm1-paravirt/include/asm-i386/processor.h
--- linux-2.6.19-rc5-mm1/include/asm-i386/processor.h	2006-11-09 11:22:25.0=
00000000 +1100
+++ working-2.6.19-rc5-mm1-paravirt/include/asm-i386/processor.h	2006-11-09=
 11:48:37.000000000 +1100
@@ -22,13 +22,6 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 =

-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#else
-#define paravirt_enabled() 0
-#define __cpuid native_cpuid
-#endif
-
 /* flag for disabling the tsc */
 extern int tsc_disable;
 =

@@ -166,59 +159,6 @@ static inline fastcall void native_cpuid
 		: "0" (*eax), "2" (*ecx));
 }
 =

-/*
- * Generic CPUID function
- * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
- * resulting in stale register contents being returned.
- */
-static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int =
*ebx, unsigned int *ecx, unsigned int *edx)
-{
-	*eax =3D op;
-	*ecx =3D 0;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/* Some CPUID calls want 'count' to be placed in ecx */
-static inline void cpuid_count(int op, int count, int *eax, int *ebx, int =
*ecx,
-			       int *edx)
-{
-	*eax =3D op;
-	*ecx =3D count;
-	__cpuid(eax, ebx, ecx, edx);
-}
-
-/*
- * CPUID functions returning a single datum
- */
-static inline unsigned int cpuid_eax(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-	return eax;
-}
-static inline unsigned int cpuid_ebx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-	return ebx;
-}
-static inline unsigned int cpuid_ecx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-	return ecx;
-}
-static inline unsigned int cpuid_edx(unsigned int op)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid(op, &eax, &ebx, &ecx, &edx);
-	return edx;
-}
-
 #define load_cr3(pgdir) write_cr3(__pa(pgdir))
 =

 /*
@@ -505,18 +445,6 @@ struct thread_struct {
 	.io_bitmap	=3D { [ 0 ... IO_BITMAP_LONGS] =3D ~0 },		\
 }
 =

-#ifndef CONFIG_PARAVIRT
-static inline void load_esp0(struct tss_struct *tss, struct thread_struct =
*thread)
-{
-	tss->esp0 =3D thread->esp0;
-	/* This can only happen when SEP is enabled, no need to test "SEP"arately=
 */
-	if (unlikely(tss->ss1 !=3D thread->sysenter_cs)) {
-		tss->ss1 =3D thread->sysenter_cs;
-		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
-	}
-}
-#endif
-
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs": :"r" (0));			\
 	regs->xgs =3D 0;						\
@@ -529,37 +457,6 @@ static inline void load_esp0(struct tss_
 	regs->esp =3D new_esp;					\
 } while (0)
 =

-#ifndef CONFIG_PARAVIRT
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
-#define set_iopl_mask native_set_iopl_mask
-#endif /* CONFIG_PARAVIRT */
-
-/*
- * Set IOPL bits in EFLAGS from given mask
- */
-static fastcall inline void native_set_iopl_mask(unsigned mask)
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
@@ -651,6 +548,105 @@ static inline void rep_nop(void)
 =

 #define cpu_relax()	rep_nop()
 =

+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define paravirt_enabled() 0
+#define __cpuid native_cpuid
+
+static inline void load_esp0(struct tss_struct *tss, struct thread_struct =
*thread)
+{
+	tss->esp0 =3D thread->esp0;
+	/* This can only happen when SEP is enabled, no need to test "SEP"arately=
 */
+	if (unlikely(tss->ss1 !=3D thread->sysenter_cs)) {
+		tss->ss1 =3D thread->sysenter_cs;
+		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
+	}
+}
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
+#define set_iopl_mask native_set_iopl_mask
+#endif /* CONFIG_PARAVIRT */
+
+/*
+ * Set IOPL bits in EFLAGS from given mask
+ */
+static fastcall inline void native_set_iopl_mask(unsigned mask)
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
+/*
+ * Generic CPUID function
+ * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
+ * resulting in stale register contents being returned.
+ */
+static inline void cpuid(unsigned int op, unsigned int *eax, unsigned int =
*ebx, unsigned int *ecx, unsigned int *edx)
+{
+	*eax =3D op;
+	*ecx =3D 0;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/* Some CPUID calls want 'count' to be placed in ecx */
+static inline void cpuid_count(int op, int count, int *eax, int *ebx, int =
*ecx,
+			       int *edx)
+{
+	*eax =3D op;
+	*ecx =3D count;
+	__cpuid(eax, ebx, ecx, edx);
+}
+
+/*
+ * CPUID functions returning a single datum
+ */
+static inline unsigned int cpuid_eax(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+	return eax;
+}
+static inline unsigned int cpuid_ebx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+	return ebx;
+}
+static inline unsigned int cpuid_ecx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+	return ecx;
+}
+static inline unsigned int cpuid_edx(unsigned int op)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	cpuid(op, &eax, &ebx, &ecx, &edx);
+	return edx;
+}
+
 /* generic versions from gas */
 #define GENERIC_NOP1	".byte 0x90\n"
 #define GENERIC_NOP2    	".byte 0x89,0xf6\n"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/dontdi=
ff --minimal linux-2.6.19-rc5-mm1/include/asm-i386/spinlock.h working-2.6.1=
9-rc5-mm1-paravirt/include/asm-i386/spinlock.h
--- linux-2.6.19-rc5-mm1/include/asm-i386/spinlock.h	2006-11-09 11:22:25.00=
0000000 +1100
+++ working-2.6.19-rc5-mm1-paravirt/include/asm-i386/spinlock.h	2006-11-09 =
11:29:20.000000000 +1100
@@ -13,7 +13,6 @@
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
 #define CLI_STI_CLOBBERS
-#define CLI_STI_INPUT_ARGS
 #endif /* CONFIG_PARAVIRT */
 =

 /*
@@ -59,27 +58,26 @@ static inline void __raw_spin_lock_flags
 {
 	asm volatile(
 		"\n1:\t"
-		LOCK_PREFIX " ; decb %[slock]\n\t"
+		LOCK_PREFIX " ; decb %0\n\t"
 		"jns 5f\n"
 		"2:\t"
-		"testl $0x200, %[flags]\n\t"
+		"testl $0x200, %1\n\t"
 		"jz 4f\n\t"
 		STI_STRING "\n"
 		"3:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %[slock]\n\t"
+		"cmpb $0, %0\n\t"
 		"jle 3b\n\t"
 		CLI_STRING "\n\t"
 		"jmp 1b\n"
 		"4:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %[slock]\n\t"
+		"cmpb $0, %0\n\t"
 		"jg 1b\n\t"
 		"jmp 4b\n"
 		"5:\n\t"
-		: [slock] "+m" (lock->slock)
-		: [flags] "r" (flags)
-	 	  CLI_STI_INPUT_ARGS
+		: "+m" (lock->slock)
+		: "r" (flags)
 		: "memory" CLI_STI_CLOBBERS);
 }
 #endif
