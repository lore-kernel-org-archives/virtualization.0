From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] paravirt inline patching
Date: Tue, 22 Aug 2006 16:12:32 +1000
Message-ID: <1156227152.26898.11.camel@localhost.localdomain>
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

(And Andi's request, I drew out the noop-writing part of alternative.c,
but unfortunately not much else can be shared.)

=3D=3D=3D
It turns out that the most called ops, by several orders of magnitude,
are the interrupt manipulation ops.  These are obvious candidates for
patching, so mark them up and create infrastructure for it.

The method used is that the ops structure has a patch function, which
is called for each place which needs to be patched: this returns a
number of instructions (the rest are NOP-padded).

Usually we can spare a register (%eax) for the binary patched code to
use, but in a couple of critical places in entry.S we can't: we make
the clobbers explicit at the call site, and manually clobber the
allowed registers in debug mode as an extra check.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Zachary Amsden <zach@vmware.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -123,6 +123,20 @@ static unsigned char** find_nop_table(vo
 =

 #endif /* CONFIG_X86_64 */
 =

+static void nop_out(void *insns, unsigned int len)
+{
+	unsigned char **noptable =3D find_nop_table();
+
+	while (len > 0) {
+		unsigned int noplen =3D len;
+		if (noplen > ASM_NOP_MAX)
+			noplen =3D ASM_NOP_MAX;
+		memcpy(insns, noptable[noplen], noplen);
+		insns +=3D noplen;
+		len -=3D noplen;
+	}
+}
+
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern struct alt_instr __smp_alt_instructions[], __smp_alt_instructions_e=
nd[];
 extern u8 *__smp_locks[], *__smp_locks_end[];
@@ -137,10 +151,9 @@ extern u8 __smp_alt_begin[], __smp_alt_e
 =

 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
-	unsigned char **noptable =3D find_nop_table();
 	struct alt_instr *a;
 	u8 *instr;
-	int diff, i, k;
+	int diff;
 =

 	DPRINTK("%s: alt table %p -> %p\n", __FUNCTION__, start, end);
 	for (a =3D start; a < end; a++) {
@@ -158,13 +171,7 @@ void apply_alternatives(struct alt_instr
 #endif
 		memcpy(instr, a->replacement, a->replacementlen);
 		diff =3D a->instrlen - a->replacementlen;
-		/* Pad the rest with nops */
-		for (i =3D a->replacementlen; diff > 0; diff -=3D k, i +=3D k) {
-			k =3D diff;
-			if (k > ASM_NOP_MAX)
-				k =3D ASM_NOP_MAX;
-			memcpy(a->instr + i, noptable[k], k);
-		}
+		nop_out(instr + a->replacementlen, diff);
 	}
 }
 =

@@ -208,7 +215,6 @@ static void alternatives_smp_lock(u8 **s
 =

 static void alternatives_smp_unlock(u8 **start, u8 **end, u8 *text, u8 *te=
xt_end)
 {
-	unsigned char **noptable =3D find_nop_table();
 	u8 **ptr;
 =

 	for (ptr =3D start; ptr < end; ptr++) {
@@ -216,7 +222,7 @@ static void alternatives_smp_unlock(u8 *
 			continue;
 		if (*ptr > text_end)
 			continue;
-		**ptr =3D noptable[1][0];
+		nop_out(*ptr, 1);
 	};
 }
 =

@@ -341,6 +347,45 @@ void alternatives_smp_switch(int smp)
 }
 =

 #endif
+
+#ifdef CONFIG_PARAVIRT
+void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *e=
nd)
+{
+	struct paravirt_patch *p;
+	int i;
+
+	local_irq_disable();
+	for (p =3D start; p < end; p++) {
+		unsigned int used;
+
+		used =3D paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
+					  p->len);
+#ifdef CONFIG_DEBUG_KERNEL
+		/* Deliberately clobber regs using "not %reg" to find bugs. */
+		for (i =3D 0; i < 3; i++) {
+			if (p->len - used >=3D 2 && (p->clobbers & (1 << i))) {
+				memcpy(p->instr + used, "\xf7\xd0", 2);
+				p->instr[used+1] |=3D i;
+				used +=3D 2;
+			}
+		}
+#endif
+		/* Pad the rest with nops */
+		nop_out(p->instr + used, p->len - used);
+	}
+
+	/* Sync in case we patched this coming "sti" last. */
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
+extern struct paravirt_patch *__start_parainstructions, *__stop_parainstru=
ctions;
+#endif	/* CONFIG_PARAVIRT */
 =

 void __init alternative_instructions(void)
 {
@@ -386,4 +430,6 @@ void __init alternative_instructions(voi
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
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -77,9 +77,9 @@ VM_MASK		=3D 0x00020000
 VM_MASK		=3D 0x00020000
 =

 #ifdef CONFIG_PREEMPT
-#define preempt_stop		DISABLE_INTERRUPTS; TRACE_IRQS_OFF
+#define preempt_stop(clobbers)	DISABLE_INTERRUPTS(clobbers); TRACE_IRQS_OFF
 #else
-#define preempt_stop
+#define preempt_stop(clobbers)
 #define resume_kernel		restore_nocheck
 #endif
 =

@@ -223,7 +223,7 @@ ENTRY(ret_from_fork)
 	ALIGN
 	RING0_PTREGS_FRAME
 ret_from_exception:
-	preempt_stop
+	preempt_stop(CLBR_ANY)
 ret_from_intr:
 	GET_THREAD_INFO(%ebp)
 check_userspace:
@@ -233,7 +233,7 @@ check_userspace:
 	cmpl $USER_RPL, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
 ENTRY(resume_userspace)
- 	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
+ 	DISABLE_INTERRUPTS(CLBR_ANY)	# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -244,7 +244,7 @@ ENTRY(resume_userspace)
 =

 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	DISABLE_INTERRUPTS
+	DISABLE_INTERRUPTS(CLBR_ANY)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -272,7 +272,7 @@ sysenter_past_esp:
 	 * No need to follow this irqs on/off section: the syscall
 	 * disabled irqs and here we enable it straight after entry:
 	 */
-	ENABLE_INTERRUPTS
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushl $(__USER_DS)
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ss, 0*/
@@ -317,7 +317,7 @@ 1:	movl (%ebp),%ebp
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	DISABLE_INTERRUPTS
+	DISABLE_INTERRUPTS(CLBR_ECX|CLBR_EDX)
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
@@ -352,7 +352,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS(CLBR_ANY)	# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -381,7 +381,7 @@ 1:	INTERRUPT_RETURN
 .section .fixup,"ax"
 iret_exc:
 	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS
+	ENABLE_INTERRUPTS(CLBR_NONE)
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
@@ -405,7 +405,7 @@ ldt_ss:
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
 	CFI_ADJUST_CFA_OFFSET 8
-	DISABLE_INTERRUPTS
+	DISABLE_INTERRUPTS(CLBR_EAX)
 	TRACE_IRQS_OFF
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
@@ -430,7 +430,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS(CLBR_ANY)	# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	TRACE_IRQS_OFF
@@ -486,7 +486,7 @@ syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	TRACE_IRQS_ON
-	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS(CLBR_ANY)	# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -667,7 +667,7 @@ ENTRY(device_not_available)
 	GET_CR0_INTO_EAX
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate
-	preempt_stop
+	preempt_stop(CLBR_ANY)
 	call math_state_restore
 	jmp ret_from_exception
 device_not_available_emulate:
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
+		void *pseg =3D (void *)para->sh_addr;
+		apply_paravirt(pseg, pseg + para->sh_size);
+	}
 	return 0;
 }
 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -322,8 +322,52 @@ extern fastcall void native_iret(void);
 extern fastcall void native_iret(void);
 extern fastcall void native_irq_enable_sysexit(void);
 =

+/* Simple instruction patching code. */
+#define DEF_NATIVE(name, code)					\
+	extern const char start_##name[], end_##name[];		\
+	asm("start_" #name ": " code "; end_" #name ":")
+DEF_NATIVE(cli, "cli");
+DEF_NATIVE(sti, "sti");
+DEF_NATIVE(popf, "push %eax; popf");
+DEF_NATIVE(pushf, "pushf; pop %eax");
+DEF_NATIVE(pushf_cli, "pushf; pop %eax; cli");
+DEF_NATIVE(iret, "iret");
+DEF_NATIVE(sti_sysexit, "sti; sysexit");
+
+static const struct native_insns
+{
+	const char *start, *end;
+} native_insns[] =3D {
+	[PARAVIRT_IRQ_DISABLE] =3D { start_cli, end_cli },
+	[PARAVIRT_IRQ_ENABLE] =3D { start_sti, end_sti },
+	[PARAVIRT_RESTORE_FLAGS] =3D { start_popf, end_popf },
+	[PARAVIRT_SAVE_FLAGS] =3D { start_pushf, end_pushf },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] =3D { start_pushf_cli, end_pushf_cli },
+	[PARAVIRT_INTERRUPT_RETURN] =3D { start_iret, end_iret },
+	[PARAVIRT_STI_SYSEXIT] =3D { start_sti_sysexit, end_sti_sysexit },
+};
+
+static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned =
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
+	memcpy(insns, native_insns[type].start, insn_len);
+	return insn_len;
+}
+
 struct paravirt_ops paravirt_ops =3D {
 	.kernel_rpl =3D 0,
+	.patch =3D native_patch,
 	.cpuid =3D native_cpuid,
 	.get_debugreg =3D native_get_debugreg,
 	.set_debugreg =3D native_set_debugreg,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmlinux.lds.S
+++ b/arch/i386/kernel/vmlinux.lds.S
@@ -152,6 +152,12 @@ SECTIONS
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
--- a/include/asm-i386/irqflags.h
+++ b/include/asm-i386/irqflags.h
@@ -79,8 +79,8 @@ static inline unsigned long __raw_local_
 }
 =

 #else
-#define DISABLE_INTERRUPTS		cli
-#define ENABLE_INTERRUPTS		sti
+#define DISABLE_INTERRUPTS(clobbers)	cli
+#define ENABLE_INTERRUPTS(clobbers)	sti
 #define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
 #define INTERRUPT_RETURN		iret
 #define GET_CR0_INTO_EAX		movl %cr0, %eax
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -3,14 +3,34 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 #include <linux/linkage.h>
+#include <linux/stringify.h>
 =

 #ifdef CONFIG_PARAVIRT
+/* These are the most performance critical ops, so we want to be able to p=
atch
+ * callers */
+#define PARAVIRT_IRQ_DISABLE 0
+#define PARAVIRT_IRQ_ENABLE 1
+#define PARAVIRT_RESTORE_FLAGS 2
+#define PARAVIRT_SAVE_FLAGS 3
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
+#define PARAVIRT_INTERRUPT_RETURN 5
+#define PARAVIRT_STI_SYSEXIT 6
+
+/* Bitmask of what can be clobbered: usually at least eax. */
+#define CLBR_NONE 0x0
+#define CLBR_EAX 0x1
+#define CLBR_ECX 0x2
+#define CLBR_EDX 0x4
+#define CLBR_ANY 0x7
+
 #ifndef __ASSEMBLY__
 struct thread_struct;
 struct Xgt_desc_struct;
 struct paravirt_ops
 {
 	unsigned int kernel_rpl;
+
+	unsigned (*patch)(u8 type, u16 clobber, void *firstinsn, unsigned len);
 =

 	/* All the function pointers here are declared as "fastcall"
 	   so that we get a specific register-based calling
@@ -101,35 +121,6 @@ static inline void __cpuid(unsigned int =

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
-	unsigned long flags =3D paravirt_ops.save_fl();
-
-	paravirt_ops.irq_disable();
-
-	return flags;
-}
 =

 static inline void raw_safe_halt(void)
 {
@@ -209,15 +200,130 @@ static inline void halt(void)
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
+	u16 clobbers;		/* what registers you may clobber */
+};
+
+#define paravirt_alt(insn_string, typenum, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	"  .long 771b\n"				\
+	"  .byte " __stringify(typenum) "\n"		\
+	"  .byte 772b-771b\n"				\
+	"  .short " __stringify(clobber) "\n"		\
+	".popsection"
+
+static inline unsigned long __raw_local_save_flags(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%1;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
+			     : "=3Da"(f): "m"(paravirt_ops.save_fl)
+			     : "memory", "cc");
+	return f;
+}
+
+static inline void raw_local_irq_restore(unsigned long f)
+{
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%1;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
+			     : "=3Da"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
+			     : "memory", "cc");
+}
+
+static inline void raw_local_irq_disable(void)
+{
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%0;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
+			     : : "m" (paravirt_ops.irq_disable)
+			     : "memory", "eax", "cc");
+}
+
+static inline void raw_local_irq_enable(void)
+{
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%0;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
+			     : : "m" (paravirt_ops.irq_enable)
+			     : "memory", "eax", "cc");
+}
+
+static inline unsigned long __raw_local_irq_save(void)
+{
+	unsigned long f;
+
+	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
+					   "call *%1; pushl %%eax;"
+					   "call *%2; popl %%eax;"
+					   "popl %%edx; popl %%ecx",
+					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
+					  CLBR_NONE)
+			     : "=3Da"(f)
+			     : "m" (paravirt_ops.save_fl),
+			       "m" (paravirt_ops.irq_disable)
+			     : "memory", "cc");
+	return f;
+}
+
+#define CLI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
+		     "call *paravirt_ops+PARAVIRT_irq_disable;"		\
+		     "popl %edx; popl %ecx",				\
+		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
+
+#define STI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
+		     "call *paravirt_ops+PARAVIRT_irq_enable;"		\
+		     "popl %edx; popl %ecx",				\
+		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
+#define CLI_STI_CLOBBERS , "%eax"
+
 #else  /* __ASSEMBLY__ */
-
-#define INTERRUPT_RETURN	jmp *%cs:paravirt_ops+PARAVIRT_iret
-#define DISABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *parav=
irt_ops+PARAVIRT_irq_disable; popl %edx; popl %ecx; popl %eax
-#define ENABLE_INTERRUPTS	pushl %eax; pushl %ecx; pushl %edx; call *%cs:pa=
ravirt_ops+PARAVIRT_irq_enable; popl %edx; popl %ecx; popl %eax
-#define ENABLE_INTERRUPTS_SYSEXIT	jmp *%cs:paravirt_ops+PARAVIRT_irq_enabl=
e_sysexit
-#define GET_CR0_INTO_EAX	call *paravirt_ops+PARAVIRT_read_cr0
+  =

+#define PARA_PATCH(ptype, clobbers, ops)	\
+771:;						\
+	ops;					\
+772:;						\
+	.pushsection .parainstructions,"a";	\
+	 .long 771b;				\
+	 .byte ptype;				\
+	 .byte 772b-771b;			\
+	 .short clobbers;			\
+	.popsection
+
+#define INTERRUPT_RETURN				\
+	PARA_PATCH(PARAVIRT_INTERRUPT_RETURN, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_iret)
+
+#define DISABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_DISABLE, clobbers,	\
+	pushl %ecx; pushl %edx;				\
+	call *paravirt_ops+PARAVIRT_irq_disable;	\
+	popl %edx; popl %ecx)				\
+
+#define ENABLE_INTERRUPTS(clobbers)			\
+	PARA_PATCH(PARAVIRT_IRQ_ENABLE, clobbers,	\
+	pushl %ecx; pushl %edx;				\
+	call *%cs:paravirt_ops+PARAVIRT_irq_enable;	\
+	popl %edx; popl %ecx)
+
+#define ENABLE_INTERRUPTS_SYSEXIT			\
+	PARA_PATCH(PARAVIRT_STI_SYSEXIT, CLBR_ANY,	\
+	jmp *%cs:paravirt_ops+PARAVIRT_irq_enable_sysexit)
+
+#define GET_CR0_INTO_EAX			\
+	call *paravirt_ops+PARAVIRT_read_cr0
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT */
 #endif	/* __ASM_PARAVIRT_H */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/spinlock.h
+++ b/include/asm-i386/spinlock.h
@@ -22,6 +22,7 @@
 #else
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
+#define CLI_STI_CLOBBERS
 #endif /* CONFIG_PARAVIRT */
 =

 #define __raw_spin_is_locked(x) \
@@ -86,7 +87,8 @@ static inline void __raw_spin_lock_flags
 	alternative_smp(
 		__raw_spin_lock_string_flags,
 		__raw_spin_lock_string_up,
-		"+m" (lock->slock) : "r" (flags) : "memory");
+		"+m" (lock->slock) : "r" (flags)
+		: "memory" CLI_STI_CLOBBERS);
 }
 #endif
 =


-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
