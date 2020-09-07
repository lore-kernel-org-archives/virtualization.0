Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70523C43461
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2D4215A4
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2D4215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 153C18607D;
	Mon,  7 Sep 2020 13:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SsUBawLnrHoc; Mon,  7 Sep 2020 13:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0249D86049;
	Mon,  7 Sep 2020 13:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDC65C08A6;
	Mon,  7 Sep 2020 13:17:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D313C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7C173860C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JE2qQG88ITWa
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4724185F8D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:04 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 9CDC81007;
 Mon,  7 Sep 2020 15:17:01 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 38/72] x86/sev-es: Compile early handler code into kernel
 image
Date: Mon,  7 Sep 2020 15:15:39 +0200
Message-Id: <20200907131613.12703-39-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907131613.12703-1-joro@8bytes.org>
References: <20200907131613.12703-1-joro@8bytes.org>
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

Setup sev-es.c and include the code from the
pre-decompression stage to also build it into the image of the running
kernel. Temporarily add __maybe_unused annotations to avoid build
warnings until the functions get used.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/Makefile        |   1 +
 arch/x86/kernel/sev-es-shared.c |  21 ++--
 arch/x86/kernel/sev-es.c        | 163 ++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 10 deletions(-)
 create mode 100644 arch/x86/kernel/sev-es.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index de09af019e23..3bcdd8d2bbdd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
+obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index a6b41910b8ab..18619279a46f 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -9,7 +9,7 @@
  * and is included directly into both code-bases.
  */
 
-static void sev_es_terminate(unsigned int reason)
+static void __maybe_unused sev_es_terminate(unsigned int reason)
 {
 	u64 val = GHCB_SEV_TERMINATE;
 
@@ -27,7 +27,7 @@ static void sev_es_terminate(unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-static bool sev_es_negotiate_protocol(void)
+static bool __maybe_unused sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
@@ -46,7 +46,7 @@ static bool sev_es_negotiate_protocol(void)
 	return true;
 }
 
-static void vc_ghcb_invalidate(struct ghcb *ghcb)
+static void __maybe_unused vc_ghcb_invalidate(struct ghcb *ghcb)
 {
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
@@ -58,9 +58,9 @@ static bool vc_decoding_needed(unsigned long exit_code)
 		 exit_code <= SVM_EXIT_LAST_EXCP);
 }
 
-static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
-				      struct pt_regs *regs,
-				      unsigned long exit_code)
+static enum es_result __maybe_unused vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+						     struct pt_regs *regs,
+						     unsigned long exit_code)
 {
 	enum es_result ret = ES_OK;
 
@@ -73,7 +73,7 @@ static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
 	return ret;
 }
 
-static void vc_finish_insn(struct es_em_ctxt *ctxt)
+static void __maybe_unused vc_finish_insn(struct es_em_ctxt *ctxt)
 {
 	ctxt->regs->ip += ctxt->insn.length;
 }
@@ -325,7 +325,8 @@ static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
 	return ES_OK;
 }
 
-static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+static enum es_result __maybe_unused
+vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	u64 exit_info_1, exit_info_2;
@@ -433,8 +434,8 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
+static enum es_result __maybe_unused vc_handle_cpuid(struct ghcb *ghcb,
+						     struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
 	u32 cr4 = native_read_cr4();
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
new file mode 100644
index 000000000000..0b698b653c0b
--- /dev/null
+++ b/arch/x86/kernel/sev-es.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2019 SUSE
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+#include <asm/sev-es.h>
+#include <asm/insn-eval.h>
+#include <asm/fpu/internal.h>
+#include <asm/processor.h>
+#include <asm/trap_pf.h>
+#include <asm/trapnr.h>
+#include <asm/svm.h>
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	return native_read_msr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = (u32)(val);
+	high = (u32)(val >> 32);
+
+	native_write_msr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
+				unsigned char *buffer)
+{
+	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+}
+
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	enum es_result ret;
+	int res;
+
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (unlikely(res == -EFAULT)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = 0;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
+
+	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+	insn_get_length(&ctxt->insn);
+
+	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
+
+	return ret;
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   char *dst, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
+	char __user *target = (char __user *)dst;
+	u64 d8;
+	u32 d4;
+	u16 d2;
+	u8  d1;
+
+	switch (size) {
+	case 1:
+		memcpy(&d1, buf, 1);
+		if (put_user(d1, target))
+			goto fault;
+		break;
+	case 2:
+		memcpy(&d2, buf, 2);
+		if (put_user(d2, target))
+			goto fault;
+		break;
+	case 4:
+		memcpy(&d4, buf, 4);
+		if (put_user(d4, target))
+			goto fault;
+		break;
+	case 8:
+		memcpy(&d8, buf, 8);
+		if (put_user(d8, target))
+			goto fault;
+		break;
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)dst;
+
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  char *src, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT;
+	char __user *s = (char __user *)src;
+	u64 d8;
+	u32 d4;
+	u16 d2;
+	u8  d1;
+
+	switch (size) {
+	case 1:
+		if (get_user(d1, s))
+			goto fault;
+		memcpy(buf, &d1, 1);
+		break;
+	case 2:
+		if (get_user(d2, s))
+			goto fault;
+		memcpy(buf, &d2, 2);
+		break;
+	case 4:
+		if (get_user(d4, s))
+			goto fault;
+		memcpy(buf, &d4, 4);
+		break;
+	case 8:
+		if (get_user(d8, s))
+			goto fault;
+		memcpy(buf, &d8, 8);
+		break;
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)src;
+
+	return ES_EXCEPTION;
+}
+
+/* Include code shared with pre-decompression boot stage */
+#include "sev-es-shared.c"
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
