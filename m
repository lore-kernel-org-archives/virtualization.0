From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/4] x86 paravirt_ops: binary patching infrastructure
Date: Mon, 07 Aug 2006 14:48:33 +1000
Message-ID: <1154926114.21647.38.camel@localhost.localdomain>
References: <1154925835.21647.29.camel@localhost.localdomain>
	<1154925943.21647.32.camel@localhost.localdomain>
	<1154926048.21647.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1154926048.21647.35.camel@localhost.localdomain>
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

It turns out that the most called ops, by several orders of magnitude,
are the interrupt manipulation ops.  These are obvious candidates for
patching, so mark them up and create infrastructure for it.

The method used is that the ops structure has a patch function, which
is called for each place which needs to be patched: this returns a
number of instructions (the rest are NOP-padded).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -3,6 +3,7 @@
 #include <linux/list.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
+#include <asm/paravirt.h>
 =

 static int no_replacement    =3D 0;
 static int smp_alt_once      =3D 0;
@@ -342,6 +343,38 @@ void alternatives_smp_switch(int smp)
 =

 #endif
 =

+#ifdef CONFIG_PARAVIRT
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd)
+{
+	unsigned char **noptable =3D find_nop_table();
+	struct paravirt_patch *p;
+	int diff, i, k;
+
+	local_irq_disable();
+	for (p =3D start; p < end; p++) {
+		unsigned int used;
+		used =3D paravirt_ops.patch(p->instrtype, p->instr, p->len);
+		/* Pad the rest with nops */
+		diff =3D p->len - used;
+		for (i =3D used; diff > 0; diff -=3D k, i +=3D k) {
+			k =3D diff;
+			if (k > ASM_NOP_MAX)
+				k =3D ASM_NOP_MAX;
+			memcpy(p->instr + i, noptable[k], k);
+		}
+	}
+	sync_core();
+	local_irq_enable();
+}
+extern struct paravirt_patch __start_parainstructions[],
+	__stop_parainstructions[];
+#else
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd)
+{
+}
+extern char __start_parainstructions[], __stop_parainstructions[];
+#endif	/* CONFIG_PARAVIRT */
+
 void __init alternative_instructions(void)
 {
 	if (no_replacement) {
@@ -386,4 +419,6 @@ void __init alternative_instructions(voi
 		alternatives_smp_switch(0);
 	}
 #endif
-}
+
+	apply_paravirt(__start_parainstructions, __stop_parainstructions);
+}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/module.c
+++ b/arch/i386/kernel/module.c
@@ -108,7 +108,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *text =3D NULL, *alt =3D NULL, *locks =3D NULL;
+	const Elf_Shdr *s, *text =3D NULL, *alt =3D NULL, *locks =3D NULL,
+		*para =3D NULL;
 	char *secstrings =3D (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 =

 	for (s =3D sechdrs; s < sechdrs + hdr->e_shnum; s++) { =

@@ -118,6 +119,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			alt =3D s;
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
 			locks=3D s;
+		if (!strcmp(".parainstructions", secstrings + s->sh_name))
+			para =3D s;
 	}
 =

 	if (alt) {
@@ -132,6 +135,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 					    lseg, lseg + locks->sh_size,
 					    tseg, tseg + text->sh_size);
 	}
+	if (para) {
+		void *aseg =3D (void *)alt->sh_addr;
+		apply_paravirt(aseg, aseg + alt->sh_size);
+	}
 	return 0;
 }
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -335,8 +335,53 @@ extern fastcall void nopara_iret(void);
 extern fastcall void nopara_iret(void);
 extern fastcall void nopara_irq_enable_sysexit(void);
 =

+#define DEF_PARAINST(name, code)				\
+	extern const char para_##name;				\
+	extern const char para_##name##_end;			\
+	asm("para_" #name ": " code ";"				\
+	    "para_"#name"_end:")
+
+DEF_PARAINST(irq_disable, "cli");
+DEF_PARAINST(irq_enable, "sti");
+DEF_PARAINST(restore_flags, "push %eax; popf");
+DEF_PARAINST(save_flags, "pushf; pop %eax");
+DEF_PARAINST(save_flags_irq_disable, "pushf; pop %eax; cli");
+
+/* Simple instruction patching code. */
+static const struct native_insns
+{
+	const char *start, *end;
+} native_insns[] =3D {
+	[PARAVIRT_IRQ_DISABLE] =3D { &para_irq_disable, &para_irq_disable_end },
+	[PARAVIRT_IRQ_ENABLE] =3D { &para_irq_enable, &para_irq_enable_end },
+	[PARAVIRT_RESTORE_FLAGS] =3D { &para_restore_flags, &para_restore_flags_e=
nd },
+	[PARAVIRT_SAVE_FLAGS] =3D { &para_save_flags, &para_save_flags_end },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] =3D { &para_save_flags_irq_disable,
+					      &para_save_flags_irq_disable_end },
+};
+
+static unsigned nopara_patch(unsigned int type, void *firstinsn, unsigned =
len)
+{
+	unsigned int insn_len;
+
+	/* Don't touch it if we don't have a replacement */
+	if (type >=3D ARRAY_SIZE(native_insns) || !native_insns[type].start)
+		return len;
+
+	insn_len =3D native_insns[type].end - native_insns[type].start;
+
+	/* Similarly if we can't fit replacement. */
+	if (len < insn_len)
+		return len;
+
+	memcpy(firstinsn, native_insns[type].start, insn_len);
+	return insn_len;
+}
+
+
 struct paravirt_ops paravirt_ops =3D {
 	.kernel_rpl =3D 0,
+	.patch =3D nopara_patch,
 	.cpuid =3D nopara_cpuid,
 	.get_debugreg =3D nopara_get_debugreg,
 	.set_debugreg =3D nopara_set_debugreg,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -150,6 +150,12 @@ SECTIONS
   .altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
 	*(.altinstr_replacement)
   }
+  . =3D ALIGN(4);
+  __start_parainstructions =3D .;
+  .parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
+	*(.parainstructions)
+  }
+  __stop_parainstructions =3D .;
   /* .exit.text is discard at runtime, not link time, to deal with referen=
ces
      from .altinstructions and .eh_frame */
   .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) { *(.exit.text) }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/alternative.h
+++ b/include/asm-i386/alternative.h
@@ -138,4 +138,7 @@ static inline void alternatives_smp_swit
 #define LOCK_PREFIX ""
 #endif
 =

+struct paravirt_patch;
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd);
+
 #endif /* _I386_ALTERNATIVE_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -3,10 +3,18 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 #include <linux/linkage.h>
+#include <linux/stringify.h>
 =

 #ifndef CONFIG_PARAVIRT
 #include <asm/no_paravirt.h>
 #else
+
+/* These are the most common ops, so we want to be able to patch callers. =
*/
+#define PARAVIRT_IRQ_DISABLE 0
+#define PARAVIRT_IRQ_ENABLE 1
+#define PARAVIRT_RESTORE_FLAGS 2
+#define PARAVIRT_SAVE_FLAGS 3
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
 =

 #ifndef __ASSEMBLY__
 struct thread_struct;
@@ -14,6 +22,8 @@ struct paravirt_ops
 struct paravirt_ops
 {
 	unsigned int kernel_rpl;
+
+	unsigned (*patch)(unsigned int type, void *firstinsn, unsigned len);
 =

 	/* All the function pointers here are declared as "fastcall"
 	   so that we get a specific register-based calling
@@ -113,31 +123,6 @@ static inline void sync_core(void)
 #define read_cr4() paravirt_ops.read_cr4()
 #define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
 #define write_cr4(x) paravirt_ops.write_cr4(x)
-
-static inline unsigned long __raw_local_save_flags(void)
-{
-	return paravirt_ops.save_fl();
-}
-
-static inline void raw_local_irq_restore(unsigned long flags)
-{
-	return paravirt_ops.restore_fl(flags);
-}
-
-static inline void raw_local_irq_disable(void)
-{
-	paravirt_ops.irq_disable();
-}
-
-static inline void raw_local_irq_enable(void)
-{
-	paravirt_ops.irq_enable();
-}
-
-static inline unsigned long __raw_local_irq_save(void)
-{
-	return paravirt_ops.save_fl_irq_disable();
-}
 =

 static inline void raw_safe_halt(void)
 {
@@ -217,13 +202,89 @@ static inline void halt(void)
 #define write_idt_entry(dt, entry, a, b) (paravirt_ops.write_idt_entry((dt=
), (entry), ((u64)a) << 32 | b))
 #define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
 =

-#define CLI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops=
+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax"
-#define STI_STRING	"pushl %eax; pushl %ecx; pushl %edx; call *paravirt_ops=
+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax"
+/* These all sit in the .parainstructions section to tell us what to patch=
. */
+struct paravirt_patch {
+	u8 *instr; 		/* original instructions */
+	u8 instrtype;		/* type of this instruction */
+	u8 len;			/* length of original instruction */
+	u16 pad;
+};
+
+#define paravirt_alt(insn_string, typenum)	\
+	"771:\n\t" insn_string "\n" "772:\n"	\
+	".pushsection .parainstructions,\"a\"\n"\
+	"  .long 771b\n"			\
+	"  .byte " __stringify(typenum) "\n"	\
+	"  .byte 772b-771b\n"			\
+	"  .byte 0,0\n"				\
+	".popsection"
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt("call *%1",
+					  PARAVIRT_SAVE_FLAGS)
+			     : "=3Da"(f): "m"(paravirt_ops.save_fl)
+			     : "memory", "ecx", "edx");
+	return f;
+}
+
+static inline void raw_local_irq_restore(unsigned long f)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0",
+					  PARAVIRT_RESTORE_FLAGS)
+			     : : "m" (paravirt_ops.restore_fl), "a"(f)
+			     : "memory", "ecx", "edx");
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt("call *%1",
+					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE)
+			     : "=3Da"(f): "m"(paravirt_ops.save_fl_irq_disable)
+			     : "memory", "ecx", "edx");
+	return f;
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0",
+					  PARAVIRT_IRQ_DISABLE)
+			     : : "m" (paravirt_ops.irq_disable)
+			     : "memory", "eax", "ecx", "edx");
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	__asm__ __volatile__(paravirt_alt("call *%0",
+					  PARAVIRT_IRQ_ENABLE)
+			     : : "m" (paravirt_ops.irq_enable)
+			     : "memory", "eax", "ecx", "edx");
+}
+
+/* XXX TODO?: work out some way to mark eax, ecx & edx as clobbered rather=
 than having explicit push/pops */
+#define CLI_STRING	paravirt_alt("pushl %eax; pushl %ecx; pushl %edx; call =
*paravirt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax", PARAV=
IRT_IRQ_DISABLE)
+#define STI_STRING	paravirt_alt("pushl %eax; pushl %ecx; pushl %edx; call =
*paravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax", PARAVI=
RT_IRQ_ENABLE)
+
 #else  /* __ASSEMBLY__ */
 =

+#define PARA_PATCH(ptype, ops)			\
+771:;						\
+	ops;					\
+772:;						\
+	.pushsection .parainstructions,"a";	\
+	 .long 771b;				\
+	 .byte ptype;				\
+	 .byte 772b-771b;			\
+	 .byte 0,0;				\
+	.popsection
+
 #define INTERRUPT_RETURN	jmp *paravirt_ops+PARAVIRT_iret
-#define DISABLE_INTERRUPTS	call *paravirt_ops+PARAVIRT_irq_disable
-#define ENABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *paravi=
rt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax
+#define DISABLE_INTERRUPTS	PARA_PATCH(PARAVIRT_IRQ_DISABLE,call *paravirt_=
ops+PARAVIRT_irq_disable)
+#define ENABLE_INTERRUPTS	PARA_PATCH(PARAVIRT_IRQ_ENABLE,pushl %eax; pushl=
 %ecx; pushl %edx; call *paravirt_ops+PARAVIRT_irq_enable; popl %edx; popl =
%ecx; popl %eax)
 #define ENABLE_INTERRUPTS_SYSEXIT	jmp *paravirt_ops+PARAVIRT_irq_enable_sy=
sexit
 #define GET_CR0_INTO_EAX	call *paravirt_ops+PARAVIRT_read_cr0
 #endif /* __ASSEMBLY__ */

-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
