From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 14/20] add common patching machinery
Date: Wed, 04 Apr 2007 12:12:05 -0700
Message-ID: <20070404191206.124948907@goop.org>
References: <20070404191151.009821039@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=paravirt-patch-machinery.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Implement the actual patching machinery.  paravirt_patch_default()
contains the logic to automatically patch a callsite based on a few
simple rules:

 - if the paravirt_op function is paravirt_nop, then patch nops
 - if the paravirt_op function is a jmp target, then jmp to it
 - if the paravirt_op function is callable and doesn't clobber too much
    for the callsite, call it directly

paravirt_patch_default is suitable as a default implementation of
paravirt_ops.patch, will remove most of the expensive indirect calls
in favour of either a direct call or a pile of nops.

Backends may implement their own patcher, however.  There are several
helper functions to help with this:

paravirt_patch_nop	nop out a callsite
paravirt_patch_ignore	leave the callsite as-is
paravirt_patch_call	patch a call if the caller and callee
			have compatible clobbers
paravirt_patch_jmp	patch in a jmp
paravirt_patch_insns	patch some literal instructions over
			the callsite, if they fit

This patch also implements more direct patches for the native case, so
that when running on native hardware many common operations are
implemented inline.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>
Acked-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/alternative.c |    5 -
 arch/i386/kernel/paravirt.c    |  164 ++++++++++++++++++++++++++++++++----=
----
 include/asm-i386/paravirt.h    |   12 ++
 3 files changed, 149 insertions(+), 32 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -349,11 +349,14 @@ void apply_paravirt(struct paravirt_patc
 		used =3D paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
 					  p->len);
 =

+		BUG_ON(used > p->len);
+
 		/* Pad the rest with nops */
 		nop_out(p->instr + used, p->len - used);
 	}
 =

-	/* Sync to be conservative, in case we patched following instructions */
+	/* Sync to be conservative, in case we patched following
+	   instructions */
 	sync_core();
 }
 #endif	/* CONFIG_PARAVIRT */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -54,40 +54,142 @@ char *memory_setup(void)
 #define DEF_NATIVE(name, code)					\
 	extern const char start_##name[], end_##name[];		\
 	asm("start_" #name ": " code "; end_" #name ":")
-DEF_NATIVE(cli, "cli");
-DEF_NATIVE(sti, "sti");
-DEF_NATIVE(popf, "push %eax; popf");
-DEF_NATIVE(pushf, "pushf; pop %eax");
+
+DEF_NATIVE(irq_disable, "cli");
+DEF_NATIVE(irq_enable, "sti");
+DEF_NATIVE(restore_fl, "push %eax; popf");
+DEF_NATIVE(save_fl, "pushf; pop %eax");
 DEF_NATIVE(iret, "iret");
-DEF_NATIVE(sti_sysexit, "sti; sysexit");
-
-static const struct native_insns
-{
-	const char *start, *end;
-} native_insns[] =3D {
-	[PARAVIRT_PATCH(irq_disable)] =3D { start_cli, end_cli },
-	[PARAVIRT_PATCH(irq_enable)] =3D { start_sti, end_sti },
-	[PARAVIRT_PATCH(restore_fl)] =3D { start_popf, end_popf },
-	[PARAVIRT_PATCH(save_fl)] =3D { start_pushf, end_pushf },
-	[PARAVIRT_PATCH(iret)] =3D { start_iret, end_iret },
-	[PARAVIRT_PATCH(irq_enable_sysexit)] =3D { start_sti_sysexit, end_sti_sys=
exit },
-};
+DEF_NATIVE(irq_enable_sysexit, "sti; sysexit");
+DEF_NATIVE(read_cr2, "mov %cr2, %eax");
+DEF_NATIVE(write_cr3, "mov %eax, %cr3");
+DEF_NATIVE(read_cr3, "mov %cr3, %eax");
+DEF_NATIVE(clts, "clts");
+DEF_NATIVE(read_tsc, "rdtsc");
+
+DEF_NATIVE(ud2a, "ud2a");
 =

 static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned =
len)
 {
-	unsigned int insn_len;
-
-	/* Don't touch it if we don't have a replacement */
-	if (type >=3D ARRAY_SIZE(native_insns) || !native_insns[type].start)
-		return len;
-
-	insn_len =3D native_insns[type].end - native_insns[type].start;
-
-	/* Similarly if we can't fit replacement. */
-	if (len < insn_len)
-		return len;
-
-	memcpy(insns, native_insns[type].start, insn_len);
+	const unsigned char *start, *end;
+	unsigned ret;
+
+	switch(type) {
+#define SITE(x)	case PARAVIRT_PATCH(x):	start =3D start_##x; end =3D end_#=
#x; goto patch_site
+		SITE(irq_disable);
+		SITE(irq_enable);
+		SITE(restore_fl);
+		SITE(save_fl);
+		SITE(iret);
+		SITE(irq_enable_sysexit);
+		SITE(read_cr2);
+		SITE(read_cr3);
+		SITE(write_cr3);
+		SITE(clts);
+		SITE(read_tsc);
+#undef SITE
+
+	patch_site:
+		ret =3D paravirt_patch_insns(insns, len, start, end);
+		break;
+
+	case PARAVIRT_PATCH(make_pgd):
+	case PARAVIRT_PATCH(make_pte):
+	case PARAVIRT_PATCH(pgd_val):
+	case PARAVIRT_PATCH(pte_val):
+#ifdef CONFIG_X86_PAE
+	case PARAVIRT_PATCH(make_pmd):
+	case PARAVIRT_PATCH(pmd_val):
+#endif
+		/* These functions end up returning exactly what
+		   they're passed, in the same registers. */
+		ret =3D paravirt_patch_nop();
+		break;
+
+	default:
+		ret =3D paravirt_patch_default(type, clobbers, insns, len);
+		break;
+	}
+
+	return ret;
+}
+
+unsigned paravirt_patch_nop(void)
+{
+	return 0;
+}
+
+unsigned paravirt_patch_ignore(unsigned len)
+{
+	return len;
+}
+
+unsigned paravirt_patch_call(void *target, u16 tgt_clobbers,
+			     void *site, u16 site_clobbers,
+			     unsigned len)
+{
+	unsigned char *call =3D site;
+	unsigned long delta =3D (unsigned long)target - (unsigned long)(call+5);
+
+	if (tgt_clobbers & ~site_clobbers)
+		return len;	/* target would clobber too much for this site */
+	if (len < 5)
+		return len;	/* call too long for patch site */
+
+	*call++ =3D 0xe8;		/* call */
+	*(unsigned long *)call =3D delta;
+
+	return 5;
+}
+
+unsigned paravirt_patch_jmp(void *target, void *site, unsigned len)
+{
+	unsigned char *jmp =3D site;
+	unsigned long delta =3D (unsigned long)target - (unsigned long)(jmp+5);
+
+	if (len < 5)
+		return len;	/* call too long for patch site */
+
+	*jmp++ =3D 0xe9;		/* jmp */
+	*(unsigned long *)jmp =3D delta;
+
+	return 5;
+}
+
+unsigned paravirt_patch_default(u8 type, u16 clobbers, void *site, unsigne=
d len)
+{
+	void *opfunc =3D *((void **)&paravirt_ops + type);
+	unsigned ret;
+
+	if (opfunc =3D=3D NULL)
+		/* If there's no function, patch it with a ud2a (BUG) */
+		ret =3D paravirt_patch_insns(site, len, start_ud2a, end_ud2a);
+	else if (opfunc =3D=3D paravirt_nop)
+		/* If the operation is a nop, then nop the callsite */
+		ret =3D paravirt_patch_nop();
+	else if (type =3D=3D PARAVIRT_PATCH(iret) ||
+		 type =3D=3D PARAVIRT_PATCH(irq_enable_sysexit))
+		/* If operation requires a jmp, then jmp */
+		ret =3D paravirt_patch_jmp(opfunc, site, len);
+	else
+		/* Otherwise call the function; assume target could
+		   clobber any caller-save reg */
+		ret =3D paravirt_patch_call(opfunc, CLBR_ANY,
+					  site, clobbers, len);
+
+	return ret;
+}
+
+unsigned paravirt_patch_insns(void *site, unsigned len,
+			      const char *start, const char *end)
+{
+	unsigned insn_len =3D end - start;
+
+	if (insn_len > len || start =3D=3D NULL)
+		insn_len =3D len;
+	else
+		memcpy(site, start, insn_len);
+
 	return insn_len;
 }
 =

@@ -110,7 +212,7 @@ static void native_flush_tlb_global(void
 	__native_flush_tlb_global();
 }
 =

-static void native_flush_tlb_single(u32 addr)
+static void native_flush_tlb_single(unsigned long addr)
 {
 	__native_flush_tlb_single(addr);
 }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -247,6 +247,18 @@ extern struct paravirt_ops paravirt_ops;
 /* Generate patchable code, with the default asm parameters. */
 #define paravirt_alt(insn_string)					\
 	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+
+unsigned paravirt_patch_nop(void);
+unsigned paravirt_patch_ignore(unsigned len);
+unsigned paravirt_patch_call(void *target, u16 tgt_clobbers,
+			     void *site, u16 site_clobbers,
+			     unsigned len);
+unsigned paravirt_patch_jmp(void *target, void *site, unsigned len);
+unsigned paravirt_patch_default(u8 type, u16 clobbers, void *site, unsigne=
d len);
+
+unsigned paravirt_patch_insns(void *site, unsigned len,
+			      const char *start, const char *end);
+
 =

 /*
  * This generates an indirect call based on the operation type number.

-- =
