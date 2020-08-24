Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7EC433E3
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4502074D
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4502074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C643878A8;
	Mon, 24 Aug 2020 08:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlavMZrKYrdE; Mon, 24 Aug 2020 08:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F8AF877E3;
	Mon, 24 Aug 2020 08:56:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 358A6C016F;
	Mon, 24 Aug 2020 08:56:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CF3EC016F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 15E8F87908
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1nGJXaFQtWdm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4638878AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:04 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id A2E77DEB;
 Mon, 24 Aug 2020 10:55:59 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 25/76] x86/sev-es: Add support for handling IOIO exceptions
Date: Mon, 24 Aug 2020 10:54:20 +0200
Message-Id: <20200824085511.7553-26-joro@8bytes.org>
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

Add support for decoding and handling #VC exceptions for IOIO events.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: Adapted code to #VC handling framework ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-25-joro@8bytes.org
---
 arch/x86/boot/compressed/sev-es.c |  32 +++++
 arch/x86/kernel/sev-es-shared.c   | 214 ++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index e3abf8737015..4f2fc7a85c2f 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -24,6 +24,35 @@
 struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
+/*
+ * Copy a version of this function here - insn-eval.c can't be used in
+ * pre-decompression code.
+ */
+static bool insn_has_rep_prefix(struct insn *insn)
+{
+	int i;
+
+	insn_get_prefixes(insn);
+
+	for (i = 0; i < insn->prefixes.nbytes; i++) {
+		insn_byte_t p = insn->prefixes.bytes[i];
+
+		if (p == 0xf2 || p == 0xf3)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
+ * doesn't use segments.
+ */
+static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
+{
+	return 0UL;
+}
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	unsigned long low, high;
@@ -151,6 +180,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		goto finish;
 
 	switch (exit_code) {
+	case SVM_EXIT_IOIO:
+		result = vc_handle_ioio(boot_ghcb, &ctxt);
+		break;
 	default:
 		result = ES_UNSUPPORTED;
 		break;
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 7ac6e6b0ae57..bae7cf28455b 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -218,3 +218,217 @@ static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
 
 	return ret;
 }
+
+#define IOIO_TYPE_STR  BIT(2)
+#define IOIO_TYPE_IN   1
+#define IOIO_TYPE_INS  (IOIO_TYPE_IN | IOIO_TYPE_STR)
+#define IOIO_TYPE_OUT  0
+#define IOIO_TYPE_OUTS (IOIO_TYPE_OUT | IOIO_TYPE_STR)
+
+#define IOIO_REP       BIT(3)
+
+#define IOIO_ADDR_64   BIT(9)
+#define IOIO_ADDR_32   BIT(8)
+#define IOIO_ADDR_16   BIT(7)
+
+#define IOIO_DATA_32   BIT(6)
+#define IOIO_DATA_16   BIT(5)
+#define IOIO_DATA_8    BIT(4)
+
+#define IOIO_SEG_ES    (0 << 10)
+#define IOIO_SEG_DS    (3 << 10)
+
+static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
+{
+	struct insn *insn = &ctxt->insn;
+	*exitinfo = 0;
+
+	switch (insn->opcode.bytes[0]) {
+	/* INS opcodes */
+	case 0x6c:
+	case 0x6d:
+		*exitinfo |= IOIO_TYPE_INS;
+		*exitinfo |= IOIO_SEG_ES;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* OUTS opcodes */
+	case 0x6e:
+	case 0x6f:
+		*exitinfo |= IOIO_TYPE_OUTS;
+		*exitinfo |= IOIO_SEG_DS;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* IN immediate opcodes */
+	case 0xe4:
+	case 0xe5:
+		*exitinfo |= IOIO_TYPE_IN;
+		*exitinfo |= (u64)insn->immediate.value << 16;
+		break;
+
+	/* OUT immediate opcodes */
+	case 0xe6:
+	case 0xe7:
+		*exitinfo |= IOIO_TYPE_OUT;
+		*exitinfo |= (u64)insn->immediate.value << 16;
+		break;
+
+	/* IN register opcodes */
+	case 0xec:
+	case 0xed:
+		*exitinfo |= IOIO_TYPE_IN;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* OUT register opcodes */
+	case 0xee:
+	case 0xef:
+		*exitinfo |= IOIO_TYPE_OUT;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	default:
+		return ES_DECODE_FAILED;
+	}
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x6c:
+	case 0x6e:
+	case 0xe4:
+	case 0xe6:
+	case 0xec:
+	case 0xee:
+		/* Single byte opcodes */
+		*exitinfo |= IOIO_DATA_8;
+		break;
+	default:
+		/* Length determined by instruction parsing */
+		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
+						     : IOIO_DATA_32;
+	}
+	switch (insn->addr_bytes) {
+	case 2:
+		*exitinfo |= IOIO_ADDR_16;
+		break;
+	case 4:
+		*exitinfo |= IOIO_ADDR_32;
+		break;
+	case 8:
+		*exitinfo |= IOIO_ADDR_64;
+		break;
+	}
+
+	if (insn_has_rep_prefix(insn))
+		*exitinfo |= IOIO_REP;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u64 exit_info_1, exit_info_2;
+	enum es_result ret;
+
+	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
+	if (ret != ES_OK)
+		return ret;
+
+	if (exit_info_1 & IOIO_TYPE_STR) {
+
+		/* (REP) INS/OUTS */
+
+		bool df = ((regs->flags & X86_EFLAGS_DF) == X86_EFLAGS_DF);
+		unsigned int io_bytes, exit_bytes;
+		unsigned int ghcb_count, op_count;
+		unsigned long es_base;
+		u64 sw_scratch;
+
+		/*
+		 * For the string variants with rep prefix the amount of in/out
+		 * operations per #VC exception is limited so that the kernel
+		 * has a chance to take interrupts and re-schedule while the
+		 * instruction is emulated.
+		 */
+		io_bytes   = (exit_info_1 >> 4) & 0x7;
+		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
+
+		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
+		exit_info_2 = min(op_count, ghcb_count);
+		exit_bytes  = exit_info_2 * io_bytes;
+
+		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+		/* Read bytes of OUTS into the shared buffer */
+		if (!(exit_info_1 & IOIO_TYPE_IN)) {
+			ret = vc_insn_string_read(ctxt,
+					       (void *)(es_base + regs->si),
+					       ghcb->shared_buffer, io_bytes,
+					       exit_info_2, df);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * Issue an VMGEXIT to the HV to consume the bytes from the
+		 * shared buffer or to have it write them into the shared buffer
+		 * depending on the instruction: OUTS or INS.
+		 */
+		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
+		ghcb_set_sw_scratch(ghcb, sw_scratch);
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
+					  exit_info_1, exit_info_2);
+		if (ret != ES_OK)
+			return ret;
+
+		/* Read bytes from shared buffer into the guest's destination. */
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			ret = vc_insn_string_write(ctxt,
+						   (void *)(es_base + regs->di),
+						   ghcb->shared_buffer, io_bytes,
+						   exit_info_2, df);
+			if (ret)
+				return ret;
+
+			if (df)
+				regs->di -= exit_bytes;
+			else
+				regs->di += exit_bytes;
+		} else {
+			if (df)
+				regs->si -= exit_bytes;
+			else
+				regs->si += exit_bytes;
+		}
+
+		if (exit_info_1 & IOIO_REP)
+			regs->cx -= exit_info_2;
+
+		ret = regs->cx ? ES_RETRY : ES_OK;
+
+	} else {
+
+		/* IN/OUT into/from rAX */
+
+		int bits = (exit_info_1 & 0x70) >> 1;
+		u64 rax = 0;
+
+		if (!(exit_info_1 & IOIO_TYPE_IN))
+			rax = lower_bits(regs->ax, bits);
+
+		ghcb_set_rax(ghcb, rax);
+
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
+		if (ret != ES_OK)
+			return ret;
+
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			if (!ghcb_rax_is_valid(ghcb))
+				return ES_VMM_ERROR;
+			regs->ax = lower_bits(ghcb->save.rax, bits);
+		}
+	}
+
+	return ret;
+}
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
