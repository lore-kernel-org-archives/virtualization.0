Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D300C433E5
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375C4206F0
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375C4206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C7F4820796;
	Mon, 24 Aug 2020 09:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0hBeUV7eGfOm; Mon, 24 Aug 2020 09:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6FC802094D;
	Mon, 24 Aug 2020 09:06:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5382BC0051;
	Mon, 24 Aug 2020 09:06:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80BE3C089F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6F9818829F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oKWK1VsTcH8L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C2122881BB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:51 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 6575736B;
 Mon, 24 Aug 2020 10:56:12 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 42/76] x86/sev-es: Setup early #VC handler
Date: Mon, 24 Aug 2020 10:54:37 +0200
Message-Id: <20200824085511.7553-43-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
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

Setup an early handler for #VC exceptions. There is no GHCB mapped
yet, so just re-use the vc_no_ghcb_handler. It can only handle CPUID
exit-codes, but that should be enough to get the kernel through
verify_cpu() and __startup_64() until it runs on virtual addresses.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-42-joro@8bytes.org
---
 arch/x86/include/asm/setup.h  |  1 +
 arch/x86/include/asm/sev-es.h |  3 +++
 arch/x86/kernel/head64.c      |  1 +
 arch/x86/kernel/head_64.S     | 34 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/idt.c         | 36 +++++++++++++++++++++++++++++++++++
 5 files changed, 75 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index cafae86813ae..0ce6453c9272 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -53,6 +53,7 @@ extern unsigned long __startup_secondary_64(void);
 extern void startup_64_setup_env(unsigned long physbase);
 extern void early_idt_setup_early_handler(unsigned long physaddr);
 extern void early_load_idt(void);
+extern void early_idt_setup(unsigned long physbase);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 7c0807b84546..ec0e112a742b 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -73,4 +73,7 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 	return (val & mask);
 }
 
+/* Early IDT entry points for #VC handler */
+extern void vc_no_ghcb(void);
+
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 41514ec1e6f0..250fae33bf66 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -39,6 +39,7 @@
 #include <asm/realmode.h>
 #include <asm/extable.h>
 #include <asm/trapnr.h>
+#include <asm/sev-es.h>
 
 /*
  * Manage page tables very early on.
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4622940134a5..12bf6f11fd83 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -95,6 +95,13 @@ SYM_CODE_START_NOALIGN(startup_64)
 .Lon_kernel_cs:
 	UNWIND_HINT_EMPTY
 
+	/* Setup IDT - Needed for SEV-ES */
+	pushq	%rsi
+	/* early_idt_setup - physbase as first parameter */
+	leaq	_text(%rip), %rdi
+	call	early_idt_setup
+	popq	%rsi
+
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
@@ -363,6 +370,33 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
 	jmp restore_regs_and_return_to_kernel
 SYM_CODE_END(early_idt_handler_common)
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/*
+ * VC Exception handler used during very early boot. The
+ * early_idt_handler_array can't be used because it returns via the
+ * paravirtualized INTERRUPT_RETURN and pv-ops don't work that early.
+ */
+SYM_CODE_START_NOALIGN(vc_no_ghcb)
+	UNWIND_HINT_IRET_REGS offset=8
+
+	/* Build pt_regs */
+	PUSH_AND_CLEAR_REGS
+
+	/* Call C handler */
+	movq    %rsp, %rdi
+	movq	ORIG_RAX(%rsp), %rsi
+	call    do_vc_no_ghcb
+
+	/* Unwind pt_regs */
+	POP_REGS
+
+	/* Remove Error Code */
+	addq    $8, %rsp
+
+	/* Pure iret required here - don't use INTERRUPT_RETURN */
+	iretq
+SYM_CODE_END(vc_no_ghcb)
+#endif
 
 #define SYM_DATA_START_PAGE_ALIGNED(name)			\
 	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index e2777cc264f5..0d560a1218e1 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -11,6 +11,7 @@
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
 #include <asm/setup.h>
+#include <asm/sev-es.h>
 
 struct idt_data {
 	unsigned int	vector;
@@ -408,3 +409,38 @@ void early_load_idt(void)
 {
 	load_idt(&idt_descr);
 }
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+static void set_early_idt_handler(gate_desc *idt, int n, void *handler)
+{
+	struct idt_data data;
+	gate_desc desc;
+
+	init_idt_data(&data, n, handler);
+	idt_init_desc(&desc, &data);
+	native_write_idt_entry(idt, n, &desc);
+}
+#endif
+
+static struct desc_ptr early_idt_descr __initdata = {
+	.size		= IDT_TABLE_SIZE - 1,
+	.address	= 0 /* Needs physical address of idt_table - initialized at runtime. */,
+};
+
+void __init early_idt_setup(unsigned long physbase)
+{
+	void __maybe_unused *handler;
+	gate_desc *idt;
+
+	idt = fixup_pointer(idt_table, physbase);
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* VMM Communication Exception */
+	handler = fixup_pointer(vc_no_ghcb, physbase);
+	set_early_idt_handler(idt, X86_TRAP_VC, handler);
+#endif
+
+	/* Initialize IDT descriptor and load IDT */
+	early_idt_descr.address = (unsigned long)idt;
+	native_load_idt(&early_idt_descr);
+}
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
