Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E55C31E40
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:28:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2656C2166E
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2656C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A9231871A2;
	Mon,  7 Sep 2020 13:28:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJAmJa26DGCq; Mon,  7 Sep 2020 13:28:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B54E871F5;
	Mon,  7 Sep 2020 13:27:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 084F6C0891;
	Mon,  7 Sep 2020 13:27:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26A0EC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 115778680E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cp8tqxCVJMl0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 323E2867B7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:49 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id E8D7E12E2;
 Mon,  7 Sep 2020 15:17:08 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 52/72] x86/sev-es: Handle DR7 read/write events
Date: Mon,  7 Sep 2020 15:15:53 +0200
Message-Id: <20200907131613.12703-53-joro@8bytes.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

Add code to handle #VC exceptions on DR7 register reads and writes.
This is needed early because show_regs() reads DR7 to print it out.

Under SEV-ES there is currently no support for saving/restoring the
DRx registers, but software expects to be able to write to the DR7
register. For now, cache the value written to DR7 and return it on
read attempts, but do not touch the real hardware DR7.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapt to #VC handling framework
                   - Support early usage ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 85 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 439b963ed52b..7879fe640dcc 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -29,6 +29,8 @@
 #include <asm/traps.h>
 #include <asm/svm.h>
 
+#define DR7_RESET_VALUE        0x400
+
 /* For early boot hypervisor communication in SEV-ES enabled guests */
 static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
 
@@ -76,6 +78,13 @@ struct sev_es_runtime_data {
 	 */
 	bool ghcb_active;
 	bool backup_ghcb_active;
+
+	/*
+	 * Cached DR7 value - write it on DR7 writes and return it on reads.
+	 * That value will never make it to the real hardware DR7 as debugging
+	 * is currently unsupported in SEV-ES guests.
+	 */
+	unsigned long dr7;
 };
 
 struct ghcb_state {
@@ -519,6 +528,21 @@ static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
 	return reg_array + offset;
 }
 
+static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
+{
+	long *reg_array;
+	int offset;
+
+	reg_array = (long *)ctxt->regs;
+	offset    = insn_get_modrm_rm_off(&ctxt->insn, ctxt->regs);
+
+	if (offset < 0)
+		return NULL;
+
+	offset /= sizeof(long);
+
+	return reg_array + offset;
+}
 static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 				 unsigned int bytes, bool read)
 {
@@ -768,6 +792,61 @@ static enum es_result vc_handle_mmio(struct ghcb *ghcb,
 	return ret;
 }
 
+static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long val, *reg = vc_insn_get_rm(ctxt);
+	enum es_result ret;
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	val = *reg;
+
+	/* Upper 32 bits must be written as zeroes */
+	if (val >> 32) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	/* Clear out other reserved bits and set bit 10 */
+	val = (val & 0xffff23ffL) | BIT(10);
+
+	/* Early non-zero writes to DR7 are not supported */
+	if (!data && (val & ~DR7_RESET_VALUE))
+		return ES_UNSUPPORTED;
+
+	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
+	ghcb_set_rax(ghcb, val);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (data)
+		data->dr7 = val;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
+					 struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long *reg = vc_insn_get_rm(ctxt);
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	if (data)
+		*reg = data->dr7;
+	else
+		*reg = DR7_RESET_VALUE;
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
@@ -775,6 +854,12 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	enum es_result result;
 
 	switch (exit_code) {
+	case SVM_EXIT_READ_DR7:
+		result = vc_handle_dr7_read(ghcb, ctxt);
+		break;
+	case SVM_EXIT_WRITE_DR7:
+		result = vc_handle_dr7_write(ghcb, ctxt);
+		break;
 	case SVM_EXIT_CPUID:
 		result = vc_handle_cpuid(ghcb, ctxt);
 		break;
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
