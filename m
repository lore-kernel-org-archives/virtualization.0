Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD8EC636C9
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:20:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FAFF61246
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAFF61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F34EA404FA;
	Wed, 21 Jul 2021 14:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLA2XhPOZsmL; Wed, 21 Jul 2021 14:20:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6EFB0404F9;
	Wed, 21 Jul 2021 14:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB48C0010;
	Wed, 21 Jul 2021 14:20:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B6C7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CA6083163
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ro1q1R0QQK9p
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01B1283143
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:52 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de
 [79.242.177.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id AAF97A6A;
 Wed, 21 Jul 2021 16:20:30 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 08/12] x86/sev: Park APs on AP Jump Table with GHCB protocol
 version 2
Date: Wed, 21 Jul 2021 16:20:11 +0200
Message-Id: <20210721142015.1401-9-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721142015.1401-1-joro@8bytes.org>
References: <20210721142015.1401-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

GHCB protocol version 2 adds the MSR-based AP-reset-hold VMGEXIT which
does not need a GHCB. Use that to park APs in 16-bit protected mode on
the AP Jump Table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/realmode.h    |  3 +
 arch/x86/kernel/sev.c              | 48 ++++++++++++++--
 arch/x86/realmode/rm/Makefile      | 11 ++--
 arch/x86/realmode/rm/header.S      |  3 +
 arch/x86/realmode/rm/sev_ap_park.S | 89 ++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/realmode/rm/sev_ap_park.S

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 29590a4ddf24..668de0a8b1ae 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -23,6 +23,9 @@ struct real_mode_header {
 	u32	trampoline_header;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	u32	sev_es_trampoline_start;
+	u32	sev_real_ap_park_asm;
+	u32	sev_real_ap_park_seg;
+	u32	sev_ap_park_gdt;
 #endif
 #ifdef CONFIG_X86_64
 	u32	trampoline_pgd;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a98eab926682..20b439986d86 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -27,6 +27,7 @@
 #include <asm/fpu/internal.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
+#include <asm/tlbflush.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
 #include <asm/smp.h>
@@ -695,6 +696,35 @@ static bool __init sev_es_setup_ghcb(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+void __noreturn sev_jumptable_ap_park(void)
+{
+	local_irq_disable();
+
+	write_cr3(real_mode_header->trampoline_pgd);
+
+	/* Exiting long mode will fail if CR4.PCIDE is set. */
+	if (boot_cpu_has(X86_FEATURE_PCID))
+		cr4_clear_bits(X86_CR4_PCIDE);
+
+	asm volatile("xorq	%%r15, %%r15\n"
+		     "xorq	%%r14, %%r14\n"
+		     "xorq	%%r13, %%r13\n"
+		     "xorq	%%r12, %%r12\n"
+		     "xorq	%%r11, %%r11\n"
+		     "xorq	%%r10, %%r10\n"
+		     "xorq	%%r9,  %%r9\n"
+		     "xorq	%%r8,  %%r8\n"
+		     "xorq	%%rsi, %%rsi\n"
+		     "xorq	%%rdi, %%rdi\n"
+		     "xorq	%%rsp, %%rsp\n"
+		     "xorq	%%rbp, %%rbp\n"
+		     "ljmpl	*%0" : :
+		     "m" (real_mode_header->sev_real_ap_park_asm),
+		     "b" (sev_es_jump_table_pa >> 4));
+	unreachable();
+}
+STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);
+
 static void sev_es_ap_hlt_loop(void)
 {
 	struct ghcb_state state;
@@ -731,8 +761,10 @@ static void sev_es_play_dead(void)
 	play_dead_common();
 
 	/* IRQs now disabled */
-
-	sev_es_ap_hlt_loop();
+	if (sev_ap_jumptable_blob_installed)
+		sev_jumptable_ap_park();
+	else
+		sev_es_ap_hlt_loop();
 
 	/*
 	 * If we get here, the VCPU was woken up again. Jump to CPU
@@ -762,8 +794,9 @@ static inline void sev_es_setup_play_dead(void) { }
 void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
 {
 	struct sev_ap_jump_table_header *header;
+	u64 *ap_jumptable_gdt, *sev_ap_park_gdt;
 	struct desc_ptr *gdt_descr;
-	u64 *ap_jumptable_gdt;
+	int idx;
 
 	header = base;
 
@@ -773,8 +806,13 @@ void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
 	 * real-mode.
 	 */
 	ap_jumptable_gdt = (u64 *)(base + header->gdt_offset);
-	ap_jumptable_gdt[SEV_APJT_CS16 / 8] = GDT_ENTRY(0x9b, pa, 0xffff);
-	ap_jumptable_gdt[SEV_APJT_DS16 / 8] = GDT_ENTRY(0x93, pa, 0xffff);
+	sev_ap_park_gdt  = __va(real_mode_header->sev_ap_park_gdt);
+
+	idx = SEV_APJT_CS16 / 8;
+	ap_jumptable_gdt[idx] = sev_ap_park_gdt[idx] = GDT_ENTRY(0x9b, pa, 0xffff);
+
+	idx = SEV_APJT_DS16 / 8;
+	ap_jumptable_gdt[idx] = sev_ap_park_gdt[idx] = GDT_ENTRY(0x93, pa, 0xffff);
 
 	/* Write correct GDT base address into GDT descriptor */
 	gdt_descr = (struct desc_ptr *)(base + header->gdt_offset);
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 83f1b6a56449..a7f84d43a0a3 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -27,11 +27,12 @@ wakeup-objs	+= video-vga.o
 wakeup-objs	+= video-vesa.o
 wakeup-objs	+= video-bios.o
 
-realmode-y			+= header.o
-realmode-y			+= trampoline_$(BITS).o
-realmode-y			+= stack.o
-realmode-y			+= reboot.o
-realmode-$(CONFIG_ACPI_SLEEP)	+= $(wakeup-objs)
+realmode-y				+= header.o
+realmode-y				+= trampoline_$(BITS).o
+realmode-y				+= stack.o
+realmode-y				+= reboot.o
+realmode-$(CONFIG_ACPI_SLEEP)		+= $(wakeup-objs)
+realmode-$(CONFIG_AMD_MEM_ENCRYPT)	+= sev_ap_park.o
 
 targets	+= $(realmode-y)
 
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 8c1db5bf5d78..6c17f8fd1eb4 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -22,6 +22,9 @@ SYM_DATA_START(real_mode_header)
 	.long	pa_trampoline_header
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.long	pa_sev_es_trampoline_start
+	.long	pa_sev_ap_park_asm
+	.long	__KERNEL32_CS
+	.long	pa_sev_ap_park_gdt;
 #endif
 #ifdef CONFIG_X86_64
 	.long	pa_trampoline_pgd;
diff --git a/arch/x86/realmode/rm/sev_ap_park.S b/arch/x86/realmode/rm/sev_ap_park.S
new file mode 100644
index 000000000000..0b63d0569d4d
--- /dev/null
+++ b/arch/x86/realmode/rm/sev_ap_park.S
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+#include <asm/msr-index.h>
+#include <asm/sev-ap-jumptable.h>
+#include "realmode.h"
+
+	.section ".text32", "ax"
+	.code32
+/*
+ * The following code switches to 16-bit protected mode and sets up the
+ * execution environment for the AP Jump Table blob. Then it jumps to the AP
+ * Jump Table to park the AP.
+ *
+ * The code was copied from reboot.S and modified to fit the SEV-ES requirements
+ * for AP parking. When this code is entered, all registers except %EAX-%EDX are
+ * in reset state.
+ *
+ * The AP Jump Table physical base address is in %EBX upon entry.
+ *
+ * %EAX, %ECX, %EDX and EFLAGS are undefined. Only use registers %EAX-%EDX and
+ * %ESP in this code.
+ */
+SYM_CODE_START(sev_ap_park_asm)
+
+	/* Switch to trampoline GDT as it is guaranteed < 4 GiB */
+	movl	$__KERNEL_DS, %eax
+	movl	%eax, %ds
+	lgdt	pa_tr_gdt
+
+	/* Disable paging to drop us out of long mode */
+	movl	%cr0, %eax
+	btcl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	ljmpl	$__KERNEL32_CS, $pa_sev_ap_park_paging_off
+
+SYM_INNER_LABEL(sev_ap_park_paging_off, SYM_L_GLOBAL)
+	/* Clear EFER */
+	movl	$0, %eax
+	movl	$0, %edx
+	movl	$MSR_EFER, %ecx
+	wrmsr
+
+	/* Clear CR3 */
+	movl	$0, %ecx
+	movl	%ecx, %cr3
+
+	/* Set up the IDT for real mode. */
+	lidtl	pa_machine_real_restart_idt
+
+	/*
+	 * Load the GDT with the 16-bit segments for the AP Jump Table
+	 */
+	lgdtl	pa_sev_ap_park_gdt
+
+	/* Setup Code and Data segments for AP Jump Table */
+	movw	$SEV_APJT_DS16, %ax
+	movw	%ax, %ds
+	movw	%ax, %ss
+
+	/* Jump to the AP Jump Table into 16 bit protected mode */
+	ljmpw	$SEV_APJT_CS16, $SEV_APJT_ENTRY
+SYM_CODE_END(sev_ap_park_asm)
+
+	.data
+	.balign	16
+SYM_DATA_START(sev_ap_park_gdt)
+	/* Self-pointer */
+	.word	sev_ap_park_gdt_end - sev_ap_park_gdt - 1
+	.long	pa_sev_ap_park_gdt
+	.word	0
+
+	/*
+	 * Offset 0x8
+	 * 32 bit code segment descriptor pointing to AP Jump table base
+	 * Setup at runtime in sev_es_setup_ap_jump_table_data().
+	 */
+	.quad	0
+
+	/*
+	 * Offset 0x10
+	 * 32 bit data segment descriptor pointing to AP Jump table base
+	 * Setup at runtime in sev_es_setup_ap_jump_table_data().
+	 */
+	.quad	0
+SYM_DATA_END_LABEL(sev_ap_park_gdt, SYM_L_GLOBAL, sev_ap_park_gdt_end)
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
