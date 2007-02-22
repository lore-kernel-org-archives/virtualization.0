From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 10:13:36 -0800
Message-ID: <45DDDD50.80502@goop.org>
References: <45DCFB6E.2010806@goop.org>	
	<1172115803.13378.63.camel@localhost.localdomain>	
	<45DD6EF7.9060808@goop.org>
	<1172141757.13378.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030401050504040300040708"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1172141757.13378.76.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------030401050504040300040708
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Rusty Russell wrote:
> Actually, your paravirt_patch_insns has similar logic anyway, so this
> code could collapse (it should fall back to paravirt_patch_default tho
> IMHO).
>   

I wanted to get rid of the table because its now sparse, and possibly
fairly large (since the special save flags & disable is at offset
0x80).  And a switch would be pretty clean anyway.

How does this look?  Compiles, but untested.

    J

--------------030401050504040300040708
Content-Type: text/x-patch;
 name="paravirt-patch-machinery.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-patch-machinery.patch"

Implement the actual patching machinery.  paravirt_patcher() contains the logic to automatically patch a callsite based on a few simple rules:
 - if the paravirt_op function is either NULL or native_nop, then patch nops
 - if the paravirt_op function is a jmp target, then jmp to it
 - if the paravirt_op function is callable and doesn't clobber too much
    for the callsite, call it directly

These rules will remove most of the expensive indirect calls in favour
of either a direct call or a pile of nops.

Paravirt backends can also pass in other patcher functions for
specific operations if they want to insert literal machine code, or do
more complex things.  The function paravirt_patch_insns() is available
to help with this.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

diff -r 30afc1621aa1 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Thu Feb 22 02:05:33 2007 -0800
+++ b/arch/i386/kernel/paravirt.c	Thu Feb 22 10:09:17 2007 -0800
@@ -53,6 +53,7 @@ char *memory_setup(void)
 #define DEF_NATIVE(name, code)					\
 	extern const char start_##name[], end_##name[];		\
 	asm("start_" #name ": " code "; end_" #name ":")
+
 DEF_NATIVE(cli, "cli");
 DEF_NATIVE(sti, "sti");
 DEF_NATIVE(popf, "push %eax; popf");
@@ -61,36 +62,128 @@ DEF_NATIVE(iret, "iret");
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
-};
+static unsigned native_patch_insns(u8 type, u16 clobbers, void *insns, unsigned len)
+{
+	const unsigned char *start, *end;
+
+	switch(type) {
+	case PARAVIRT_IRQ_DISABLE:
+		start = start_cli;
+		end = end_cli;
+		break;
+	case PARAVIRT_IRQ_ENABLE:
+		start = start_sti;
+		end = end_sti;
+		break;
+	case PARAVIRT_RESTORE_FLAGS:
+		start = start_popf;
+		end = end_popf;
+		break;
+	case PARAVIRT_SAVE_FLAGS:
+		start = start_pushf;
+		end = end_pushf;
+		break;
+	case PARAVIRT_SAVE_FLAGS_IRQ_DISABLE:
+		start = start_pushf_cli;
+		end = end_pushf_cli;
+		break;
+	case PARAVIRT_INTERRUPT_RETURN:
+		start = start_iret;
+		end = end_iret;
+		break;
+	case PARAVIRT_STI_SYSEXIT:
+		start = start_sti_sysexit;
+		end = end_sti_sysexit;
+		break;
+
+	default:
+		return 0;
+	}
+
+	return paravirt_patch_insns(insns, len, start, end);
+}
 
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
+	unsigned ret = native_patch_insns(type, clobbers, insns, len);
+
+	if (ret == 0)
+		ret = paravirt_patch_default(type, clobbers, insns, len);
+
+	return ret;
+}
+
+unsigned paravirt_patch_nop(u8 type, u16 clobbers, void *site, unsigned len)
+{
+	return 0;
+}
+
+unsigned paravirt_patch_ignore(u8 type, u16 clobbers, void *site, unsigned len)
+{
+	return len;
+}
+
+unsigned paravirt_patch_call(u8 type, u16 clobbers, void *site, unsigned len)
+{
+	void *target = *((void **)&paravirt_ops + type);
+	unsigned char *call = site;
+	unsigned long delta = (unsigned long)target - (unsigned long)(call+5);
+
+	if (clobbers != CLBR_ANY)
+		return len;	/* calling C would clobber too much */
+	if (len < 5)
+		return len;	/* call too long for patch site */
+
+	*call++ = 0xe8;		/* call */
+	*(unsigned long *)call = delta;
+
+	return 5;
+}
+
+unsigned paravirt_patch_jmp(u8 type, u16 clobbers, void *site, unsigned len)
+{
+	void *target = *((void **)&paravirt_ops + type);
+	unsigned char *jmp = site;
+	unsigned long delta = (unsigned long)target - (unsigned long)(jmp+5);
+
+	if (len < 5)
+		return len;	/* call too long for patch site */
+
+	*jmp++ = 0xe9;		/* jmp */
+	*(unsigned long *)jmp = delta;
+
+	return 5;
+}
+
+unsigned paravirt_patch_default(u8 type, u16 clobbers, void *site, unsigned len)
+{
+	void *opfunc = *((void **)&paravirt_ops + type);
+	unsigned ret;
+
+	if (opfunc == (void *)native_nop || opfunc == NULL)
+		ret = paravirt_patch_nop(type, clobbers, site, len);
+	else if (type == PARAVIRT_PATCH(iret) ||
+		 type == PARAVIRT_PATCH(irq_enable_sysexit))
+		ret = paravirt_patch_jmp(type, clobbers, site, len);
+	else
+		ret = paravirt_patch_jmp(type, clobbers, site, len);
+
+	return ret;
+}
+
+unsigned paravirt_patch_insns(void *site, unsigned len,
+			      const char *start, const char *end)
+{
+	unsigned insn_len = end - start;
+
+	if (insn_len > len || start == NULL)
+		insn_len = len;
+	else
+		memcpy(site, start, insn_len);
+
 	return insn_len;
 }
+
 
 static unsigned long native_get_debugreg(int regno)
 {
diff -r 30afc1621aa1 arch/i386/xen/enlighten.c
--- a/arch/i386/xen/enlighten.c	Thu Feb 22 02:05:33 2007 -0800
+++ b/arch/i386/xen/enlighten.c	Thu Feb 22 10:09:17 2007 -0800
@@ -36,13 +36,6 @@ extern const char xen_sti_sysexit[];
 
 struct start_info *xen_start_info;
 EXPORT_SYMBOL_GPL(xen_start_info);
-
-static unsigned xen_patch(u8 type, u16 clobber, void *firstinsn, unsigned len)
-{
-	/* Xen will require relocations to patch calls and jmps, and
-	   perhaps chunks of inline code */
-	return len;
-}
 
 static void __init xen_banner(void)
 {
@@ -619,7 +612,7 @@ static const struct paravirt_ops xen_par
 	.name = "Xen",
 	.banner = xen_banner,
 
-	.patch = xen_patch,
+	.patch = paravirt_patch_default,
 
 	.memory_setup = xen_memory_setup,
 	.arch_setup = xen_arch_setup,
diff -r 30afc1621aa1 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Thu Feb 22 02:05:33 2007 -0800
+++ b/include/asm-i386/paravirt.h	Thu Feb 22 10:09:17 2007 -0800
@@ -865,6 +865,17 @@ struct paravirt_patch_site {
 	u16 clobbers;		/* what registers you may clobber */
 };
 
+typedef unsigned (*patcher_t)(u8 type, u16 clobbers, void *site, unsigned len);
+
+unsigned paravirt_patch_nop(u8 type, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_ignore(u8 type, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_call(u8 type, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_jmp(u8 type, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_default(u8 type, u16 clobbers, void *site, unsigned len);
+
+unsigned paravirt_patch_insns(void *site, unsigned len,
+			      const char *start, const char *end);
+
 extern struct paravirt_patch_site __start_parainstructions[],
 	__stop_parainstructions[];
 

--------------030401050504040300040708
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------030401050504040300040708--
