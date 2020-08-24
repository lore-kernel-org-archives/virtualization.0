Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA34C433E1
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62F722B49
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62F722B49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B3D987998;
	Mon, 24 Aug 2020 09:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TpigBb+6tGrB; Mon, 24 Aug 2020 09:06:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A853D879B1;
	Mon, 24 Aug 2020 09:06:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D05FC089E;
	Mon, 24 Aug 2020 09:06:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A379EC016F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 903FC85F5F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e3jKbqxRaRdx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E225985F37
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:49 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id A4EEAFF7;
 Mon, 24 Aug 2020 10:56:19 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 53/76] x86/sev-es: Handle MMIO String Instructions
Date: Mon, 24 Aug 2020 10:54:48 +0200
Message-Id: <20200824085511.7553-54-joro@8bytes.org>
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

Add handling for emulation the MOVS instruction on MMIO regions, as done
by the memcpy_toio() and memcpy_fromio() functions.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-53-joro@8bytes.org
---
 arch/x86/kernel/sev-es.c | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index fa1fa55fd8e3..7bfd402c74e3 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -595,6 +595,73 @@ static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
 	return ret;
 }
 
+/*
+ * The MOVS instruction has two memory operands, which raises the
+ * problem that it is not known whether the access to the source or the
+ * destination caused the #VC exception (and hence whether an MMIO read
+ * or write operation needs to be emulated).
+ *
+ * Instead of playing games with walking page-tables and trying to guess
+ * whether the source or destination is an MMIO range, split the move
+ * into two operations, a read and a write with only one memory operand.
+ * This will cause a nested #VC exception on the MMIO address which can
+ * then be handled.
+ *
+ * This implementation has the benefit that it also supports MOVS where
+ * source _and_ destination are MMIO regions.
+ *
+ * It will slow MOVS on MMIO down a lot, but in SEV-ES guests it is a
+ * rare operation. If it turns out to be a performance problem the split
+ * operations can be moved to memcpy_fromio() and memcpy_toio().
+ */
+static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
+					  unsigned int bytes)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	enum es_result ret;
+	bool rep;
+	int off;
+
+	ds_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	src = ds_base + (unsigned char *)ctxt->regs->si;
+	dst = es_base + (unsigned char *)ctxt->regs->di;
+
+	ret = vc_read_mem(ctxt, src, buffer, bytes);
+	if (ret != ES_OK)
+		return ret;
+
+	ret = vc_write_mem(ctxt, dst, buffer, bytes);
+	if (ret != ES_OK)
+		return ret;
+
+	if (ctxt->regs->flags & X86_EFLAGS_DF)
+		off = -bytes;
+	else
+		off =  bytes;
+
+	ctxt->regs->si += off;
+	ctxt->regs->di += off;
+
+	rep = insn_has_rep_prefix(&ctxt->insn);
+	if (rep)
+		ctxt->regs->cx -= 1;
+
+	if (!rep || ctxt->regs->cx == 0)
+		return ES_OK;
+	else
+		return ES_RETRY;
+}
+
 static enum es_result vc_handle_mmio(struct ghcb *ghcb,
 				     struct es_em_ctxt *ctxt)
 {
@@ -655,6 +722,16 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
 		memcpy(reg_data, ghcb->shared_buffer, bytes);
 		break;
 
+		/* MOVS instruction */
+	case 0xa4:
+		bytes = 1;
+		fallthrough;
+	case 0xa5:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		ret = vc_handle_mmio_movs(ctxt, bytes);
+		break;
 		/* Two-Byte Opcodes */
 	case 0x0f:
 		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
