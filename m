Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FAC433DF
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0578A22B4B
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0578A22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D711087F19;
	Mon, 24 Aug 2020 09:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jdsWS7Jrt2pr; Mon, 24 Aug 2020 09:07:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C05287C1C;
	Mon, 24 Aug 2020 09:06:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55146C08A5;
	Mon, 24 Aug 2020 09:06:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 313BAC0895
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2A55285F78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJrFrdVoaRQZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E65C785F4C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:49 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 22277FF4;
 Mon, 24 Aug 2020 10:56:19 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 52/76] x86/sev-es: Handle MMIO events
Date: Mon, 24 Aug 2020 10:54:47 +0200
Message-Id: <20200824085511.7553-53-joro@8bytes.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

Add handler for VC exceptions caused by MMIO intercepts. These
intercepts come along as nested page faults on pages with reserved
bits set.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapt to VC handling framework ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-52-joro@8bytes.org
---
 arch/x86/include/uapi/asm/svm.h |   5 +
 arch/x86/kernel/sev-es.c        | 220 ++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index c68d1618c9b0..8f36ae021a7f 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -81,6 +81,11 @@
 #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
 #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
 
+/* SEV-ES software-defined VMGEXIT events */
+#define SVM_VMGEXIT_MMIO_READ			0x80000001
+#define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
+
 #define SVM_EXIT_ERR           -1
 
 #define SVM_EXIT_REASONS \
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 1493e8cf14f2..fa1fa55fd8e3 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -364,6 +364,37 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	return ES_EXCEPTION;
 }
 
+static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 unsigned long vaddr, phys_addr_t *paddr)
+{
+	unsigned long va = (unsigned long)vaddr;
+	unsigned int level;
+	phys_addr_t pa;
+	pgd_t *pgd;
+	pte_t *pte;
+
+	pgd = __va(read_cr3_pa());
+	pgd = &pgd[pgd_index(va)];
+	pte = lookup_address_in_pgd(pgd, va, &level);
+	if (!pte) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.cr2        = vaddr;
+		ctxt->fi.error_code = 0;
+
+		if (user_mode(ctxt->regs))
+			ctxt->fi.error_code |= X86_PF_USER;
+
+		return false;
+	}
+
+	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
+	pa |= va & ~page_level_mask(level);
+
+	*paddr = pa;
+
+	return true;
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
@@ -449,6 +480,192 @@ static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
 	do_early_exception(ctxt->regs, trapnr);
 }
 
+static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
+{
+	long *reg_array;
+	int offset;
+
+	reg_array = (long *)ctxt->regs;
+	offset    = insn_get_modrm_reg_off(&ctxt->insn, ctxt->regs);
+
+	if (offset < 0)
+		return NULL;
+
+	offset /= sizeof(long);
+
+	return reg_array + offset;
+}
+
+static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 unsigned int bytes, bool read)
+{
+	u64 exit_code, exit_info_1, exit_info_2;
+	unsigned long ghcb_pa = __pa(ghcb);
+	phys_addr_t paddr;
+	void __user *ref;
+
+	ref = insn_get_addr_ref(&ctxt->insn, ctxt->regs);
+	if (ref == (void __user *)-1L)
+		return ES_UNSUPPORTED;
+
+	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
+
+	if (!vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr)) {
+		if (!read)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return ES_EXCEPTION;
+	}
+
+	exit_info_1 = paddr;
+	exit_info_2 = bytes;    /* Can never be greater than 8 */
+
+	ghcb->save.sw_scratch = ghcb_pa + offsetof(struct ghcb, shared_buffer);
+
+	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
+}
+
+static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
+						 struct es_em_ctxt *ctxt)
+{
+	struct insn *insn = &ctxt->insn;
+	unsigned int bytes = 0;
+	enum es_result ret;
+	int sign_byte;
+	long *reg_data;
+
+	switch (insn->opcode.bytes[1]) {
+		/* MMIO Read w/ zero-extension */
+	case 0xb6:
+		bytes = 1;
+		fallthrough;
+	case 0xb7:
+		if (!bytes)
+			bytes = 2;
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero extend based on operand size */
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		memset(reg_data, 0, insn->opnd_bytes);
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+
+		/* MMIO Read w/ sign-extension */
+	case 0xbe:
+		bytes = 1;
+		fallthrough;
+	case 0xbf:
+		if (!bytes)
+			bytes = 2;
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Sign extend based on operand size */
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		if (bytes == 1) {
+			u8 *val = (u8 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			u16 *val = (u16 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+		memset(reg_data, sign_byte, insn->opnd_bytes);
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+
+	default:
+		ret = ES_UNSUPPORTED;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_handle_mmio(struct ghcb *ghcb,
+				     struct es_em_ctxt *ctxt)
+{
+	struct insn *insn = &ctxt->insn;
+	unsigned int bytes = 0;
+	enum es_result ret;
+	long *reg_data;
+
+	switch (insn->opcode.bytes[0]) {
+	/* MMIO Write */
+	case 0x88:
+		bytes = 1;
+		fallthrough;
+	case 0x89:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+
+	case 0xc6:
+		bytes = 1;
+		fallthrough;
+	case 0xc7:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+
+		/* MMIO Read */
+	case 0x8a:
+		bytes = 1;
+		fallthrough;
+	case 0x8b:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		if (bytes == 4)
+			*reg_data = 0;  /* Zero-extend for 32-bit operation */
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+
+		/* Two-Byte Opcodes */
+	case 0x0f:
+		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
+		break;
+	default:
+		ret = ES_UNSUPPORTED;
+	}
+
+	return ret;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -462,6 +679,9 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	case SVM_EXIT_IOIO:
 		result = vc_handle_ioio(ghcb, ctxt);
 		break;
+	case SVM_EXIT_NPF:
+		result = vc_handle_mmio(ghcb, ctxt);
+		break;
 	default:
 		/*
 		 * Unexpected #VC exception
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
