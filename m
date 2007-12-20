From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 13/15] move patching code to arch-specific file.
Date: Thu, 20 Dec 2007 18:04:08 -0200
Message-ID: <11981813592589-git-send-email-gcosta__39307.0457889282$1198182061$gmane$org@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
	<1198181215625-git-send-email-gcosta@redhat.com>
	<1198181224677-git-send-email-gcosta@redhat.com>
	<11981812412879-git-send-email-gcosta@redhat.com>
	<11981812771615-git-send-email-gcosta@redhat.com>
	<1198181309285-git-send-email-gcosta@redhat.com>
	<11981813192341-git-send-email-gcosta@redhat.com>
	<11981813292926-git-send-email-gcosta@redhat.com>
	<11981813384090-git-send-email-gcosta@redhat.com>
	<1198181348746-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1198181348746-git-send-email-gcosta@redhat.com>
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

The core patching code for paravirt is sufficiently different
among i386 and x86_64, and we move them to specific files.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/Makefile_32 |    2 +-
 arch/x86/kernel/paravirt.c  |   50 -------------------------------------------
 include/asm-x86/paravirt.h  |    8 +++++++
 3 files changed, 9 insertions(+), 51 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/Makefile_32
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/Makefile_32	2007-12-20 19:07:15.000000000 -0800
+++ linux-2.6-x86/arch/x86/kernel/Makefile_32	2007-12-20 19:08:11.000000000 -0800
@@ -48,7 +48,7 @@
 obj-$(CONFIG_MGEODE_LX)		+= geode_32.o mfgpt_32.o
 
 obj-$(CONFIG_VMI)		+= vmi_32.o vmiclock_32.o
-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_32.o
 obj-y				+= pcspeaker.o
 
 obj-$(CONFIG_SCx200)		+= scx200_32.o
Index: linux-2.6-x86/arch/x86/kernel/paravirt.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/paravirt.c	2007-12-20 19:08:06.000000000 -0800
+++ linux-2.6-x86/arch/x86/kernel/paravirt.c	2007-12-20 19:08:11.000000000 -0800
@@ -58,59 +58,9 @@
 	extern const char start_##ops##_##name[], end_##ops##_##name[];	\
 	asm("start_" #ops "_" #name ": " code "; end_" #ops "_" #name ":")
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
-DEF_NATIVE(pv_cpu_ops, iret, "iret");
-DEF_NATIVE(pv_cpu_ops, irq_enable_syscall_ret, "sti; sysexit");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
-DEF_NATIVE(pv_cpu_ops, clts, "clts");
-DEF_NATIVE(pv_cpu_ops, read_tsc, "rdtsc");
-
 /* Undefined instruction for dealing with missing ops pointers. */
 static const unsigned char ud2a[] = { 0x0f, 0x0b };
 
-static unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
-			     unsigned long addr, unsigned len)
-{
-	const unsigned char *start, *end;
-	unsigned ret;
-
-	switch(type) {
-#define SITE(ops, x)						\
-	case PARAVIRT_PATCH(ops.x):				\
-		start = start_##ops##_##x;			\
-		end = end_##ops##_##x;				\
-		goto patch_site
-
-	SITE(pv_irq_ops, irq_disable);
-	SITE(pv_irq_ops, irq_enable);
-	SITE(pv_irq_ops, restore_fl);
-	SITE(pv_irq_ops, save_fl);
-	SITE(pv_cpu_ops, iret);
-	SITE(pv_cpu_ops, irq_enable_syscall_ret);
-	SITE(pv_mmu_ops, read_cr2);
-	SITE(pv_mmu_ops, read_cr3);
-	SITE(pv_mmu_ops, write_cr3);
-	SITE(pv_cpu_ops, clts);
-	SITE(pv_cpu_ops, read_tsc);
-#undef SITE
-
-	patch_site:
-		ret = paravirt_patch_insns(ibuf, len, start, end);
-		break;
-
-	default:
-		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
-		break;
-	}
-
-	return ret;
-}
-
 unsigned paravirt_patch_nop(void)
 {
 	return 0;
Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:08:10.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:08:11.000000000 -0800
@@ -308,6 +308,11 @@
 #define paravirt_alt(insn_string)					\
 	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
+/* Simple instruction patching code. */
+#define DEF_NATIVE(ops, name, code) 					\
+	extern const char start_##ops##_##name[], end_##ops##_##name[];	\
+	asm("start_" #ops "_" #name ": " code "; end_" #ops "_" #name ":")
+
 unsigned paravirt_patch_nop(void);
 unsigned paravirt_patch_ignore(unsigned len);
 unsigned paravirt_patch_call(void *insnbuf,
@@ -322,6 +327,9 @@
 unsigned paravirt_patch_insns(void *insnbuf, unsigned len,
 			      const char *start, const char *end);
 
+unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
+		      unsigned long addr, unsigned len);
+
 int paravirt_disable_iospace(void);
 
 /*
