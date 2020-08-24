Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FCC433ED
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BF320738
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BF320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 605898843F;
	Mon, 24 Aug 2020 09:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gafB-D5-7+1a; Mon, 24 Aug 2020 09:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DBE3A883B8;
	Mon, 24 Aug 2020 09:07:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C453EC0895;
	Mon, 24 Aug 2020 09:07:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEB74C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AA1E687904
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 255eko7gKy4h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ACA8387960
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:51 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id E29D2F91;
 Mon, 24 Aug 2020 10:56:12 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 43/76] x86/sev-es: Setup GHCB based boot #VC handler
Date: Mon, 24 Aug 2020 10:54:38 +0200
Message-Id: <20200824085511.7553-44-joro@8bytes.org>
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

Add the infrastructure to handle #VC exceptions when the kernel runs
on virtual addresses and has a GHCB mapped. This handler will be used
until the runtime #VC handler takes over.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-43-joro@8bytes.org
---
 arch/x86/include/asm/segment.h  |   2 +-
 arch/x86/include/asm/sev-es.h   |   1 +
 arch/x86/kernel/head64.c        |   6 ++
 arch/x86/kernel/sev-es-shared.c |  14 ++--
 arch/x86/kernel/sev-es.c        | 116 ++++++++++++++++++++++++++++++++
 arch/x86/mm/extable.c           |   1 +
 6 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 517920928989..7fdd4facfce7 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -226,7 +226,7 @@
 #define NUM_EXCEPTION_VECTORS		32
 
 /* Bitmask of exception vectors which push an error code on the stack: */
-#define EXCEPTION_ERRCODE_MASK		0x00027d00
+#define EXCEPTION_ERRCODE_MASK		0x20027d00
 
 #define GDT_SIZE			(GDT_ENTRIES*8)
 #define GDT_ENTRY_TLS_ENTRIES		3
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index ec0e112a742b..824e9e6b067c 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -75,5 +75,6 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 
 /* Early IDT entry points for #VC handler */
 extern void vc_no_ghcb(void);
+extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
 #endif
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 250fae33bf66..ce2d8284edb9 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -403,6 +403,12 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    early_make_pgtable(native_read_cr2()))
 		return;
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (trapnr == X86_TRAP_VC &&
+	    handle_vc_boot_ghcb(regs))
+		return;
+#endif
+
 	early_fixup_exception(regs, trapnr);
 }
 
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 18619279a46f..aa77f2eb8d88 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -9,7 +9,7 @@
  * and is included directly into both code-bases.
  */
 
-static void __maybe_unused sev_es_terminate(unsigned int reason)
+static void sev_es_terminate(unsigned int reason)
 {
 	u64 val = GHCB_SEV_TERMINATE;
 
@@ -27,7 +27,7 @@ static void __maybe_unused sev_es_terminate(unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-static bool __maybe_unused sev_es_negotiate_protocol(void)
+static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
@@ -46,7 +46,7 @@ static bool __maybe_unused sev_es_negotiate_protocol(void)
 	return true;
 }
 
-static void __maybe_unused vc_ghcb_invalidate(struct ghcb *ghcb)
+static void vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
@@ -58,9 +58,9 @@ static bool vc_decoding_needed(unsigned long exit_code)
 		 exit_code <= SVM_EXIT_LAST_EXCP);
 }
 
-static enum es_result __maybe_unused vc_init_em_ctxt(struct es_em_ctxt *ctxt,
-						     struct pt_regs *regs,
-						     unsigned long exit_code)
+static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+				      struct pt_regs *regs,
+				      unsigned long exit_code)
 {
 	enum es_result ret = ES_OK;
 
@@ -73,7 +73,7 @@ static enum es_result __maybe_unused vc_init_em_ctxt(struct es_em_ctxt *ctxt,
 	return ret;
 }
 
-static void __maybe_unused vc_finish_insn(struct es_em_ctxt *ctxt)
+static void vc_finish_insn(struct es_em_ctxt *ctxt)
 {
 	ctxt->regs->ip += ctxt->insn.length;
 }
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0b698b653c0b..bb3e702a71eb 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -7,7 +7,9 @@
  * Author: Joerg Roedel <jroedel@suse.de>
  */
 
+#include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/kernel.h>
+#include <linux/printk.h>
 #include <linux/mm.h>
 
 #include <asm/sev-es.h>
@@ -18,6 +20,18 @@
 #include <asm/trapnr.h>
 #include <asm/svm.h>
 
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+static struct ghcb __initdata *boot_ghcb;
+
+/* Needed in vc_early_forward_exception */
+void do_early_exception(struct pt_regs *regs, int trapnr);
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return native_read_msr(MSR_AMD64_SEV_ES_GHCB);
@@ -161,3 +175,105 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
+
+/*
+ * This function runs on the first #VC exception after the kernel
+ * switched to virtual addresses.
+ */
+static bool __init sev_es_setup_ghcb(void)
+{
+	/* First make sure the hypervisor talks a supported protocol. */
+	if (!sev_es_negotiate_protocol())
+		return false;
+
+	/*
+	 * Clear the boot_ghcb. The first exception comes in before the bss
+	 * section is cleared.
+	 */
+	memset(&boot_ghcb_page, 0, PAGE_SIZE);
+
+	/* Alright - Make the boot-ghcb public */
+	boot_ghcb = &boot_ghcb_page;
+
+	return true;
+}
+
+static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
+{
+	int trapnr = ctxt->fi.vector;
+
+	if (trapnr == X86_TRAP_PF)
+		native_write_cr2(ctxt->fi.cr2);
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+	do_early_exception(ctxt->regs, trapnr);
+}
+
+static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
+					 struct ghcb *ghcb,
+					 unsigned long exit_code)
+{
+	enum es_result result;
+
+	switch (exit_code) {
+	default:
+		/*
+		 * Unexpected #VC exception
+		 */
+		result = ES_UNSUPPORTED;
+	}
+
+	return result;
+}
+
+bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
+{
+	unsigned long exit_code = regs->orig_ax;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	/* Do initial setup or terminate the guest */
+	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+	vc_ghcb_invalidate(boot_ghcb);
+
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		early_printk("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_VMM_ERROR:
+		early_printk("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_DECODE_FAILED:
+		early_printk("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_EXCEPTION:
+		vc_early_forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		BUG();
+	}
+
+	return true;
+
+fail:
+	show_regs(regs);
+
+	while (true)
+		halt();
+}
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1d6cb07f4f86..3966749d07ac 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -5,6 +5,7 @@
 #include <xen/xen.h>
 
 #include <asm/fpu/internal.h>
+#include <asm/sev-es.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
