From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 14/15] x86_64 patching functions
Date: Thu, 20 Dec 2007 18:04:09 -0200
Message-ID: <11981813691362-git-send-email-gcosta__26574.8963029639$1198182065$gmane$org@redhat.com>
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
	<11981813592589-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981813592589-git-send-email-gcosta@redhat.com>
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

Like i386, x86_64 also need to include its own patching function.
(Well, if you're not in a hurry, and don't care about speed, you don't
really _need_ ;-)) 

So here they are. Not much different in essence from i386

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/Makefile_64         |    1 +
 arch/x86/kernel/paravirt_patch_64.c |   56 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/kernel/paravirt_patch_64.c

Index: linux-2.6-x86/arch/x86/kernel/Makefile_64
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/Makefile_64	2007-12-20 19:05:52.000000000 -0800
+++ linux-2.6-x86/arch/x86/kernel/Makefile_64	2007-12-20 19:08:14.000000000 -0800
@@ -41,6 +41,7 @@
 obj-$(CONFIG_K8_NB)		+= k8.o
 obj-$(CONFIG_AUDIT)		+= audit_64.o
 obj-$(CONFIG_EFI)		+= efi.o efi_64.o efi_stub_64.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch_64.o
 
 obj-$(CONFIG_MODULES)		+= module_64.o
 obj-$(CONFIG_PCI)		+= early-quirks.o
Index: linux-2.6-x86/arch/x86/kernel/paravirt_patch_64.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-x86/arch/x86/kernel/paravirt_patch_64.c	2007-12-20 19:08:14.000000000 -0800
@@ -0,0 +1,56 @@
+#include <asm/paravirt.h>
+#include <asm/asm-offsets.h>
+
+DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
+DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
+DEF_NATIVE(pv_irq_ops, restore_fl, "pushq %rdi; popfq");
+DEF_NATIVE(pv_irq_ops, save_fl, "pushfq; popq %rax");
+DEF_NATIVE(pv_cpu_ops, iret, "iretq");
+DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
+DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
+DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
+DEF_NATIVE(pv_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
+DEF_NATIVE(pv_cpu_ops, clts, "clts");
+DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
+
+/* the three commands give us more control to how to return from a syscall */
+DEF_NATIVE(pv_cpu_ops, irq_enable_syscall_ret, "movq %gs:" __stringify(pda_oldrsp) ", %rsp; swapgs; sysretq;");
+DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
+
+unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
+		      unsigned long addr, unsigned len)
+{
+	const unsigned char *start, *end;
+	unsigned ret;
+
+#define PATCH_SITE(ops, x)					\
+		case PARAVIRT_PATCH(ops.x):			\
+			start = start_##ops##_##x;		\
+			end = end_##ops##_##x;			\
+			goto patch_site
+	switch(type) {
+		PATCH_SITE(pv_irq_ops, restore_fl);
+		PATCH_SITE(pv_irq_ops, save_fl);
+		PATCH_SITE(pv_irq_ops, irq_enable);
+		PATCH_SITE(pv_irq_ops, irq_disable);
+		PATCH_SITE(pv_cpu_ops, iret);
+		PATCH_SITE(pv_cpu_ops, irq_enable_syscall_ret);
+		PATCH_SITE(pv_cpu_ops, swapgs);
+		PATCH_SITE(pv_mmu_ops, read_cr2);
+		PATCH_SITE(pv_mmu_ops, read_cr3);
+		PATCH_SITE(pv_mmu_ops, write_cr3);
+		PATCH_SITE(pv_cpu_ops, clts);
+		PATCH_SITE(pv_mmu_ops, flush_tlb_single);
+		PATCH_SITE(pv_cpu_ops, wbinvd);
+
+	patch_site:
+		ret = paravirt_patch_insns(ibuf, len, start, end);
+		break;
+
+	default:
+		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
+		break;
+	}
+#undef PATCH_SITE
+	return ret;
+}
