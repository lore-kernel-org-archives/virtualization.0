From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: rough sketch of revised patching infrastructure
Date: Wed, 21 Feb 2007 18:09:50 -0800
Message-ID: <45DCFB6E.2010806@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010005060301040204090503"
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
To: Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------010005060301040204090503
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Here's the new patching patch.  It compiles, but it doesn't, you know,
boot, as such.

The basic idea is to make the incremental cost of patching a new hook as
small as possible.  If a backend wants pure default patch handling, then
it can simply call paravirt_patcher with a NULL patch table; this will
end up patching calls to be direct calls to the paravirt op, unless the
op is NULL or points to native_nop.  Otherwise, a backend can set up a
patch table to set specific handling for entrypoints, though the default
is still to generate a direct call to the op.

The patch type is now derived from offsetof(paravirt_ops, op), so that
there's no need to maintain a specific enumeration.

    J

--------------010005060301040204090503
Content-Type: text/x-patch;
 name="paravirt-generic-patching.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-generic-patching.patch"

diff -r d83f67d4b2b8 arch/i386/kernel/alternative.c
--- a/arch/i386/kernel/alternative.c	Wed Feb 21 12:12:31 2007 -0800
+++ b/arch/i386/kernel/alternative.c	Wed Feb 21 18:08:17 2007 -0800
@@ -350,9 +350,9 @@ void alternatives_smp_switch(int smp)
 #endif
 
 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
-{
-	struct paravirt_patch *p;
+void apply_paravirt(struct paravirt_patch_site *start, struct paravirt_patch_site *end)
+{
+	struct paravirt_patch_site *p;
 
 	for (p = start; p < end; p++) {
 		unsigned int used;
@@ -379,8 +379,6 @@ void apply_paravirt(struct paravirt_patc
 	/* Sync to be conservative, in case we patched following instructions */
 	sync_core();
 }
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
 #endif	/* CONFIG_PARAVIRT */
 
 void __init alternative_instructions(void)
diff -r d83f67d4b2b8 arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Wed Feb 21 12:12:31 2007 -0800
+++ b/arch/i386/kernel/asm-offsets.c	Wed Feb 21 18:08:17 2007 -0800
@@ -110,5 +110,11 @@ void foo(void)
 	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
 	OFFSET(PARAVIRT_iret, paravirt_ops, iret);
 	OFFSET(PARAVIRT_read_cr0, paravirt_ops, read_cr0);
+
+	DEFINE(PARAVIRT_IRQ_DISABLE, PARAVIRT_IRQ_DISABLE);
+	DEFINE(PARAVIRT_IRQ_ENABLE, PARAVIRT_IRQ_ENABLE);
+	DEFINE(PARAVIRT_STI_SYSEXIT, PARAVIRT_STI_SYSEXIT);
+	DEFINE(PARAVIRT_IRQ_DISABLE, PARAVIRT_IRQ_DISABLE);
+	DEFINE(PARAVIRT_INTERRUPT_RETURN, PARAVIRT_INTERRUPT_RETURN);
 #endif
 }
diff -r d83f67d4b2b8 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Wed Feb 21 12:12:31 2007 -0800
+++ b/arch/i386/kernel/paravirt.c	Wed Feb 21 18:08:17 2007 -0800
@@ -61,34 +61,106 @@ DEF_NATIVE(iret, "iret");
 DEF_NATIVE(iret, "iret");
 DEF_NATIVE(sti_sysexit, "sti; sysexit");
 
-static const struct native_insns
-{
-	const char *start, *end;
-} native_insns[] = {
-	[PARAVIRT_IRQ_DISABLE] = { start_cli, end_cli },
-	[PARAVIRT_IRQ_ENABLE] = { start_sti, end_sti },
-	[PARAVIRT_RESTORE_FLAGS] = { start_popf, end_popf },
-	[PARAVIRT_SAVE_FLAGS] = { start_pushf, end_pushf },
-	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] = { start_pushf_cli, end_pushf_cli },
-	[PARAVIRT_INTERRUPT_RETURN] = { start_iret, end_iret },
-	[PARAVIRT_STI_SYSEXIT] = { start_sti_sysexit, end_sti_sysexit },
+static const struct paravirt_patch native_patches[256] = 
+{
+	[PARAVIRT_IRQ_DISABLE] = { PVP_INSTR, { { start_cli, end_cli } } },
+	[PARAVIRT_IRQ_ENABLE] = { PVP_INSTR, { { start_sti, end_sti } } },
+	[PARAVIRT_RESTORE_FLAGS] = { PVP_INSTR, { { start_popf, end_popf } } },
+	[PARAVIRT_SAVE_FLAGS] = { PVP_INSTR, { { start_pushf, end_pushf } } },
+	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] = { PVP_INSTR, { { start_pushf_cli, end_pushf_cli } } },
+	[PARAVIRT_INTERRUPT_RETURN] = { PVP_INSTR, {{ start_iret, end_iret }} },
+	[PARAVIRT_STI_SYSEXIT] = { PVP_INSTR, {{ start_sti_sysexit, end_sti_sysexit }} },
+
+	[PARAVIRT_PATCH(pmd_val)] = { PVP_NOP },
+	[PARAVIRT_PATCH(pgd_val)] = { PVP_NOP },
 };
 
 static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned len)
 {
-	unsigned int insn_len;
-
-	/* Don't touch it if we don't have a replacement */
-	if (type >= ARRAY_SIZE(native_insns) || !native_insns[type].start)
-		return len;
-
-	insn_len = native_insns[type].end - native_insns[type].start;
-
-	/* Similarly if we can't fit replacement. */
-	if (len < insn_len)
-		return len;
-
-	memcpy(insns, native_insns[type].start, insn_len);
+	return paravirt_patcher(type, clobbers, insns, len, native_patches);
+}
+
+static unsigned gen_call(unsigned char *call, void *target)
+{
+	unsigned long delta = (unsigned long)target - (unsigned long)(call+5);
+
+	*call++ = 0xe8;		/* call */
+	*(unsigned long *)call = delta;
+
+	return 5;
+}
+
+static unsigned gen_jmp(unsigned char *call, void *target)
+{
+	unsigned long delta = (unsigned long)target - (unsigned long)(call+5);
+
+	*call++ = 0xe9;		/* jmp */
+	*(unsigned long *)call = delta;
+
+	return 5;
+}
+
+unsigned paravirt_patcher(u8 type, u16 clobbers, void *insns, unsigned len,
+			  const struct paravirt_patch *patch_table)
+{
+	unsigned insn_len;
+	static const struct paravirt_patch default_call = { PVP_OPCALL };
+	static const struct paravirt_patch default_jmp = { PVP_OPJMP };
+	void *opfunc = *((void **)&paravirt_ops + type);
+	const struct paravirt_patch *p;
+
+	if (patch_table != NULL)
+		p = &patch_table[type];
+	else {
+		/* If there's no patch table, then do some sensable defaults */
+		if (type == PARAVIRT_PATCH(iret) ||
+		    type == PARAVIRT_PATCH(irq_enable_sysexit))
+			p = &default_jmp;
+		else
+			p = &default_call;
+	}
+
+	switch(p->action) {
+	default:
+	case PVP_NULL:
+		/* do nothing */
+		insn_len = len;
+		break;
+
+	case PVP_NOP:
+		/* replace with nops */
+		insn_len = 0;
+		break;
+
+	case PVP_OPCALL:
+		/* generate direct call to paravirt_op (or NOPs if
+		   there's no function) */
+		if (opfunc == NULL || opfunc == (void *)native_nop)
+			insn_len = 0;  /* missing or nop function */
+		else
+			insn_len = gen_call(insns, opfunc);
+		break;
+
+	case PVP_OPJMP:
+		BUG_ON(opfunc == NULL);
+		insn_len = gen_jmp(insns, opfunc);
+		break;
+
+	case PVP_INSTR:
+		insn_len = p->instr.end - p->instr.start;
+		if (p->instr.start == NULL || insn_len > len)
+			insn_len = len;
+		else
+			memcpy(insns, p->instr.start, insn_len);
+		break;
+
+	case PVP_SPECIAL:
+		insn_len = (*p->fn)(type, clobbers, insns, len);
+		break;
+	}
+
+	BUG_ON(insn_len > len);
+
 	return insn_len;
 }
 
diff -r d83f67d4b2b8 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Wed Feb 21 12:12:31 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Wed Feb 21 18:08:17 2007 -0800
@@ -70,10 +70,6 @@ struct {
 	void (*set_initial_ap_state)(int, int);
 	void (*halt)(void);
 } vmi_ops;
-
-/* XXX move this to alternative.h */
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
 
 /*
  * VMI patching routines.
diff -r d83f67d4b2b8 include/asm-i386/alternative.h
--- a/include/asm-i386/alternative.h	Wed Feb 21 12:12:31 2007 -0800
+++ b/include/asm-i386/alternative.h	Wed Feb 21 18:08:17 2007 -0800
@@ -118,12 +118,12 @@ static inline void alternatives_smp_swit
 #define LOCK_PREFIX ""
 #endif
 
-struct paravirt_patch;
+struct paravirt_patch_site;
 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
+void apply_paravirt(struct paravirt_patch_site *start, struct paravirt_patch_site *end);
 #else
 static inline void
-apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
+apply_paravirt(struct paravirt_patch_site *start, struct paravirt_patch_site *end)
 {}
 #define __start_parainstructions NULL
 #define __stop_parainstructions NULL
diff -r d83f67d4b2b8 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Wed Feb 21 12:12:31 2007 -0800
+++ b/include/asm-i386/paravirt.h	Wed Feb 21 18:08:17 2007 -0800
@@ -9,14 +9,6 @@
 #ifdef CONFIG_PARAVIRT
 /* These are the most performance critical ops, so we want to be able to patch
  * callers */
-#define PARAVIRT_IRQ_DISABLE 0
-#define PARAVIRT_IRQ_ENABLE 1
-#define PARAVIRT_RESTORE_FLAGS 2
-#define PARAVIRT_SAVE_FLAGS 3
-#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
-#define PARAVIRT_INTERRUPT_RETURN 5
-#define PARAVIRT_STI_SYSEXIT 6
-
 /* Bitmask of what can be clobbered: usually at least eax. */
 #define CLBR_NONE 0x0
 #define CLBR_EAX 0x1
@@ -238,21 +230,109 @@ pgd_t native_make_pgd(unsigned long pgd)
 
 #define paravirt_enabled() (paravirt_ops.paravirt_enabled)
 
+#define paravirt_type(type)		[paravirt_typenum] "i" (type)
+#define paravirt_clobber(clobber)	[paravirt_clobber] "i" (clobber)
+
+#define PARAVIRT_PATCH(x)	(offsetof(struct paravirt_ops, x) / sizeof(void *))
+#define PARAVIRT_PATCH_SPECIAL(x)	(0x80+x)
+
+#define _paravirt_alt(insn_string, type, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	"  .long 771b\n"				\
+	"  .byte " type "\n"				\
+	"  .byte 772b-771b\n"				\
+	"  .short " clobber "\n"			\
+	".popsection"
+
+#define paravirt_alt(insn_string)				\
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+
+#define PVOP_CALL0(__rettype, op)					\
+	({								\
+		unsigned long long __ret;				\
+		asm(paravirt_alt("call *%1")				\
+		    : "=A" (__ret)					\
+		    : "m" (paravirt_ops.op),				\
+		      paravirt_type(PARAVIRT_PATCH(op)),		\
+		      paravirt_clobber(CLBR_EAX|CLBR_ECX|CLBR_EDX)	\
+		    : "ecx");						\
+		(__rettype)__ret;					\
+	})
+
+#define PVOP_CALL1(__rettype, op, arg1)					\
+	({								\
+		unsigned long long __ret;				\
+		asm(paravirt_alt("call *%1")				\
+		    : "=A" (__ret)					\
+		    : "m" (paravirt_ops.op),				\
+		      "a" ((u32)(arg1)),				\
+		      paravirt_type(PARAVIRT_PATCH(op)),		\
+		      paravirt_clobber(CLBR_EAX|CLBR_ECX|CLBR_EDX)	\
+		    : "ecx");						\
+		(__rettype)__ret;					\
+	})
+
+#define PVOP_CALL2(__rettype, op, arg1, arg2)				\
+	({								\
+		unsigned long long __ret;				\
+		asm(paravirt_alt("call *%1")				\
+		    : "=A" (__ret)					\
+		    : "m" (paravirt_ops.op),				\
+		      "a" ((u32)(arg1)),				\
+		      "d" ((u32)(arg2)),				\
+		      paravirt_type(PARAVIRT_PATCH(op)),		\
+		      paravirt_clobber(CLBR_EAX|CLBR_ECX|CLBR_EDX)	\
+		    : "ecx");						\
+		(__rettype)__ret;					\
+	})
+
+#define PVOP_CALL3(__rettype, op, arg1, arg2, arg3)			\
+	({								\
+		unsigned long long __ret;				\
+		asm(paravirt_alt("call *%1")				\
+		    : "=A" (__ret)					\
+		    : "m" (paravirt_ops.op),				\
+		      "a" ((u32)(arg1)),				\
+		      "d" ((u32)(arg2)),				\
+		      "c" ((u32)(arg3)),				\
+		      paravirt_type(PARAVIRT_PATCH(op)),		\
+		      paravirt_clobber(CLBR_EAX|CLBR_ECX|CLBR_EDX)	\
+		    : "ecx");						\
+		(__rettype)__ret;					\
+	})
+
+#define PVOP_CALL4(__rettype, op, arg1, arg2, arg3, arg4)		\
+	({								\
+		unsigned long long __ret;				\
+		asm(paravirt_alt("push %5; call *%1; add $4,%%esp")	\
+		    : "=A" (__ret)					\
+		    : "m" (paravirt_ops.op),				\
+		    "a" ((u32)(arg1)),					\
+		    "d" ((u32)(arg2)),					\
+		    "c" ((u32)(arg3)),					\
+		    "mr" ((u32)(arg4)),					\
+		      paravirt_type(PARAVIRT_PATCH(op)),		\
+		      paravirt_clobber(CLBR_EAX|CLBR_ECX|CLBR_EDX)	\
+		    : "ecx");						\
+		(__rettype)__ret;					\
+	})
+		
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
-	paravirt_ops.load_esp0(tss, thread);
+	PVOP_CALL2(void, load_esp0, tss, thread);
 }
 
 #define ARCH_SETUP			paravirt_ops.arch_setup();
 static inline unsigned long get_wallclock(void)
 {
-	return paravirt_ops.get_wallclock();
+	return PVOP_CALL0(unsigned long, get_wallclock);
 }
 
 static inline int set_wallclock(unsigned long nowtime)
 {
-	return paravirt_ops.set_wallclock(nowtime);
+	return PVOP_CALL1(int, set_wallclock, nowtime);
 }
 
 static inline void do_time_init(void)
@@ -264,42 +344,47 @@ static inline void __cpuid(unsigned int 
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
-	paravirt_ops.cpuid(eax, ebx, ecx, edx);
+	PVOP_CALL4(void, cpuid, eax, ebx, ecx, edx);
 }
 
 /*
  * These special macros can be used to get or set a debugging register
  */
-#define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
-#define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
-
-#define clts() paravirt_ops.clts()
-
-#define read_cr0() paravirt_ops.read_cr0()
-#define write_cr0(x) paravirt_ops.write_cr0(x)
-
-#define read_cr2() paravirt_ops.read_cr2()
-#define write_cr2(x) paravirt_ops.write_cr2(x)
-
-#define read_cr3() paravirt_ops.read_cr3()
-#define write_cr3(x) paravirt_ops.write_cr3(x)
-
-#define read_cr4() paravirt_ops.read_cr4()
-#define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
-#define write_cr4(x) paravirt_ops.write_cr4(x)
-
-#define raw_ptep_get_and_clear(xp)	(paravirt_ops.ptep_get_and_clear(xp))
+#define get_debugreg(var, reg) var = PVOP_CALL1(unsigned long, get_debugreg, reg)
+#define set_debugreg(val, reg) PVOP_CALL2(void, set_debugreg, reg, val)
+
+#define clts()		PVOP_CALL0(void, clts)
+
+#define read_cr0()	PVOP_CALL0(unsigned long, read_cr0)
+#define write_cr0(x)	PVOP_CALL1(void, write_cr0, x)
+
+#define read_cr2()	PVOP_CALL0(unsigned long, read_cr2)
+#define write_cr2(x)	PVOP_CALL1(void, write_cr2, x)
+
+#define read_cr3()	PVOP_CALL0(unsigned long, read_cr3)
+#define write_cr3(x)	PVOP_CALL1(void, write_cr3, x)
+
+#define read_cr4()	PVOP_CALL0(unsigned long, read_cr4)
+#define read_cr4_safe(x) PVOP_CALL0(unsigned long, read_cr4_safe)
+#define write_cr4(x)	PVOP_CALL1(void, write_cr4, x)
+
+static inline pte_t raw_ptep_get_and_clear(pte_t *p)
+{
+	pte_t ret;
+	PVOP_CALL2(void, ptep_get_and_clear, &ret, p);
+	return ret;
+}
 
 static inline void raw_safe_halt(void)
 {
-	paravirt_ops.safe_halt();
+	PVOP_CALL0(void, safe_halt);
 }
 
 static inline void halt(void)
 {
-	paravirt_ops.safe_halt();
-}
-#define wbinvd() paravirt_ops.wbinvd()
+	PVOP_CALL0(void, safe_halt);
+}
+#define wbinvd()	PVOP_CALL0(void, wbinvd)
 
 #define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
 
@@ -335,22 +420,22 @@ static inline void halt(void)
 	_err; })
 
 #define rdtsc(low,high) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = PVOP_CALL0(u64, read_tsc);			\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
 
 #define rdtscl(low) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = PVOP_CALL0(u64, read_tsc);			\
 	low = (int)_l;						\
 } while(0)
 
-#define rdtscll(val) (val = paravirt_ops.read_tsc())
+#define rdtscll(val) (val = PVOP_CALL0(u64, read_tsc))
 
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) do {				\
-	u64 _l = paravirt_ops.read_pmc();			\
+	u64 _l = PVOP_CALL0(u64, read_pmc);			\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
@@ -371,15 +456,66 @@ static inline void halt(void)
 	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
 #define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
 
-#define __pte(x)	paravirt_ops.make_pte(x)
-#define __pgd(x)	paravirt_ops.make_pgd(x)
-
-#define pte_val(x)	paravirt_ops.pte_val(x)
-#define pgd_val(x)	paravirt_ops.pgd_val(x)
-
 #ifdef CONFIG_X86_PAE
-#define __pmd(x)	paravirt_ops.make_pmd(x)
-#define pmd_val(x)	paravirt_ops.pmd_val(x)
+static inline pte_t __pte(unsigned long long val)
+{
+	pte_t ret;
+	PVOP_CALL3(void, make_pte, &ret, val, val >> 32);
+	return ret;
+}
+
+static inline pmd_t __pmd(unsigned long long val)
+{
+	pmd_t ret;
+	PVOP_CALL3(void, make_pmd, &ret, val, val >> 32);
+	return ret;
+}
+
+static inline pgd_t __pgd(unsigned long long val)
+{
+	pgd_t ret;
+	PVOP_CALL3(void, make_pgd, &ret, val, val >> 32);
+	return ret;
+}
+
+static inline unsigned long long pte_val(pte_t x)
+{
+	return PVOP_CALL2(unsigned long long, pte_val, x.pte_low, x.pte_high);
+}
+
+static inline unsigned long long pmd_val(pmd_t x)
+{
+	return PVOP_CALL2(unsigned long long, pmd_val, x.pmd, x.pmd >> 32);
+}
+
+static inline unsigned long long pgd_val(pgd_t x)
+{
+	return PVOP_CALL2(unsigned long long, pgd_val, x.pgd, x.pgd >> 32);
+}
+#else
+static inline pte_t __pte(unsigned long val)
+{
+	pte_t ret;
+	PVOP_CALL2(void, make_pte, &ret, val);
+	return ret;
+}
+
+static inline pgd_t __pte(unsigned long val)
+{
+	pgd_t ret;
+	PVOP_CALL2(void, make_pgd, &ret, val);
+	return ret;
+}
+
+static inline unsigned long pte_val(pte_t x)
+{
+	PVOP_CALL1(unsigned long, pte_val, x.pte_low);
+}
+
+static inline unsigned long pgd_val(pgd_t x)
+{
+	PVOP_CALL2(unsigned long, pgd_val, x.pgd);
+}
 #endif
 
 /* The paravirtualized I/O functions */
@@ -456,18 +592,18 @@ static inline void paravirt_activate_mm(
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
-	paravirt_ops.activate_mm(prev, next);
+	PVOP_CALL2(void, activate_mm, prev, next);
 }
 
 static inline void arch_dup_mmap(struct mm_struct *oldmm,
 				 struct mm_struct *mm)
 {
-	paravirt_ops.dup_mmap(oldmm, mm);
+	PVOP_CALL2(void, dup_mmap, oldmm, mm);
 }
 
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
-	paravirt_ops.exit_mmap(mm);
+	PVOP_CALL1(void, exit_mmap, mm);
 }
 
 static inline void paravirt_init_pda(struct i386_pda *pda, int cpu)
@@ -497,33 +633,41 @@ unsigned long native_store_tr(void);
 
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	paravirt_ops.set_pte(ptep, pteval);
+#ifdef CONFIG_X86_PAE
+	PVOP_CALL3(void, set_pte, ptep, pteval.pte_low, pteval.pte_high);
+#else
+	PVOP_CALL2(void, set_pte, ptep, pteval.pte_low);
+#endif
 }
 
 static inline void set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval)
 {
+#ifndef CONFIG_X86_PAE
+	PVOP_CALL4(void, set_pte_at, mm, addr, ptep, pteval.pte_low);
+#else
 	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+#endif
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
-	paravirt_ops.set_pmd(pmdp, pmdval);
+	PVOP_CALL3(void, set_pmd, pmdp, pmdval.pmd, pmdval.pmd >> 32);
 }
 
 static inline void pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep)
 {
-	paravirt_ops.pte_update(mm, addr, ptep);
+	PVOP_CALL3(void, pte_update, mm, addr, ptep);
 }
 
 static inline void pte_update_defer(struct mm_struct *mm, u32 addr, pte_t *ptep)
 {
-	paravirt_ops.pte_update_defer(mm, addr, ptep);
+	PVOP_CALL3(void, pte_update_defer, mm, addr, ptep);
 }
 
 #ifdef CONFIG_X86_PAE
 static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
 {
-	paravirt_ops.set_pte_atomic(ptep, pteval);
+	PVOP_CALL3(void, set_pte_atomic, ptep, pteval.pte_low, pteval.pte_high);
 }
 
 static inline void set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
@@ -533,17 +677,17 @@ static inline void set_pte_present(struc
 
 static inline void set_pud(pud_t *pudp, pud_t pudval)
 {
-	paravirt_ops.set_pud(pudp, pudval);
+	PVOP_CALL3(void, set_pud, pudp, pudval.pgd.pgd, pudval.pgd.pgd >> 32);
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	paravirt_ops.pte_clear(mm, addr, ptep);
+	PVOP_CALL3(void, pte_clear, mm, addr, ptep);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	paravirt_ops.pmd_clear(pmdp);
+	PVOP_CALL1(void, pmd_clear, pmdp);
 }
 #endif
 
@@ -553,29 +697,32 @@ static inline void pmd_clear(pmd_t *pmdp
 #define PARAVIRT_LAZY_CPU  2
 
 #define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
-#define arch_enter_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_CPU)
-#define arch_leave_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+#define arch_enter_lazy_cpu_mode() PVOP_CALL1(void, set_lazy_mode, PARAVIRT_LAZY_CPU)
+#define arch_leave_lazy_cpu_mode() PVOP_CALL1(void, set_lazy_mode, PARAVIRT_LAZY_NONE)
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-#define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_MMU)
-#define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+#define arch_enter_lazy_mmu_mode() PVOP_CALL1(void, set_lazy_mode, PARAVIRT_LAZY_MMU)
+#define arch_leave_lazy_mmu_mode() PVOP_CALL1(void, set_lazy_mode, PARAVIRT_LAZY_NONE)
+
+#define PARAVIRT_IRQ_DISABLE		PARAVIRT_PATCH(irq_disable)
+#define PARAVIRT_IRQ_ENABLE		PARAVIRT_PATCH(irq_enable)
+#define PARAVIRT_RESTORE_FLAGS		PARAVIRT_PATCH(restore_fl)
+#define PARAVIRT_SAVE_FLAGS		PARAVIRT_PATCH(save_fl)
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE	PARAVIRT_PATCH_SPECIAL(0)
+#define PARAVIRT_INTERRUPT_RETURN	PARAVIRT_PATCH(iret)
+#define PARAVIRT_STI_SYSEXIT		PARAVIRT_PATCH(irq_enable_sysexit)
+
 
 /* These all sit in the .parainstructions section to tell us what to patch. */
-struct paravirt_patch {
+struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
 	u8 instrtype;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 	u16 clobbers;		/* what registers you may clobber */
 };
 
-#define paravirt_alt(insn_string, typenum, clobber)	\
-	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
-	"  .long 771b\n"				\
-	"  .byte " __stringify(typenum) "\n"		\
-	"  .byte 772b-771b\n"				\
-	"  .short " __stringify(clobber) "\n"		\
-	".popsection"
+extern struct paravirt_patch_site __start_parainstructions[],
+	__stop_parainstructions[];
 
 static inline unsigned long __raw_local_save_flags(void)
 {
@@ -583,9 +730,10 @@ static inline unsigned long __raw_local_
 
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%1;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
-			     : "=a"(f): "m"(paravirt_ops.save_fl)
+					   "popl %%edx; popl %%ecx")
+			     : "=a"(f): "m"(paravirt_ops.save_fl),
+			       paravirt_type(PARAVIRT_SAVE_FLAGS),
+			       paravirt_clobber(CLBR_NONE)
 			     : "memory", "cc");
 	return f;
 }
@@ -594,9 +742,10 @@ static inline void raw_local_irq_restore
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%1;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
-			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
+					   "popl %%edx; popl %%ecx")
+			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f),
+			       paravirt_type(PARAVIRT_RESTORE_FLAGS),
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "cc");
 }
 
@@ -604,9 +753,10 @@ static inline void raw_local_irq_disable
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%0;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_disable)
+					   "popl %%edx; popl %%ecx")
+			     : : "m" (paravirt_ops.irq_disable),
+			       paravirt_type(PARAVIRT_IRQ_DISABLE),
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "eax", "cc");
 }
 
@@ -614,9 +764,10 @@ static inline void raw_local_irq_enable(
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%0;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_enable)
+					   "popl %%edx; popl %%ecx")
+			     : : "m" (paravirt_ops.irq_enable),
+			       paravirt_type(PARAVIRT_IRQ_ENABLE),
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "eax", "cc");
 }
 
@@ -627,30 +778,63 @@ static inline unsigned long __raw_local_
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%1; pushl %%eax;"
 					   "call *%2; popl %%eax;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
-					  CLBR_NONE)
+					   "popl %%edx; popl %%ecx")
 			     : "=a"(f)
 			     : "m" (paravirt_ops.save_fl),
-			       "m" (paravirt_ops.irq_disable)
+			       "m" (paravirt_ops.irq_disable),
+			       paravirt_type(PARAVIRT_SAVE_FLAGS_IRQ_DISABLE),
+			       paravirt_clobber(CLBR_NONE)
 			     : "memory", "cc");
 	return f;
 }
 
-#define CLI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_disable];"		\
-		     "popl %%edx; popl %%ecx",				\
-		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-
-#define STI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_enable];"		\
-		     "popl %%edx; popl %%ecx",				\
-		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
+#define CLI_STRING _paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+				 "call *paravirt_ops+%c[irq_disable];"	\
+				 "popl %%edx; popl %%ecx",		\
+				 "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
+
+#define STI_STRING _paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+				"call *paravirt_ops+%c[irq_enable];"	\
+				 "popl %%edx; popl %%ecx",		\
+				 "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
+
 #define CLI_STI_CLOBBERS , "%eax"
-#define CLI_STI_INPUT_ARGS \
+#define CLI_STI_INPUT_ARGS						\
 	,								\
-	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
-	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
+		[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
+		[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable)), \
+		[paravirt_cli_type] "i" (PARAVIRT_IRQ_DISABLE),		\
+		[paravirt_sti_type] "i" (PARAVIRT_IRQ_DISABLE),		\
+		paravirt_clobber(CLBR_NONE)
+
+/* Specify to the paravirt patcher how a particular patch should be
+   dealt with.  PVP_OPCALL is the default (=0) - it just replaces the
+   indirect call via paravirt_ops with a direct call to the
+   function. */
+enum pvpatch {
+	PVP_OPCALL,		/* direct call to pv_op */
+	PVP_OPJMP,		/* direct jump to pv_op */
+	PVP_NULL,		/* do nothing */
+	PVP_NOP,		/* patch with nops */
+	PVP_INSTR,		/* replace with literal code */
+	PVP_SPECIAL,		/* backend-specific special actions */
+};
+struct paravirt_patch
+{
+	enum pvpatch action;
+	union {
+		struct pvp_instructions {
+			const char *start, *end;
+		} instr;
+		void *p;
+		unsigned long ul;
+		unsigned (*fn)(u8 type, u16 clobbers, void *insns, unsigned len);
+	};
+};
+
+/* generic patcher */
+unsigned paravirt_patcher(u8 type, u16 clobbers, void *site, unsigned site_len,
+			  const struct paravirt_patch *patch_table);
 
 #else  /* __ASSEMBLY__ */
 

--------------010005060301040204090503
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------010005060301040204090503--
