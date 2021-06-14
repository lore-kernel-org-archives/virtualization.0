Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF87C48BE6
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 13:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C0D61350
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 13:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C0D61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 736DC4045F;
	Mon, 14 Jun 2021 13:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sESiYgRyECj1; Mon, 14 Jun 2021 13:53:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B0D840131;
	Mon, 14 Jun 2021 13:53:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B765C0026;
	Mon, 14 Jun 2021 13:53:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B41CC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AC3840100
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hh9XWQPQ6nI3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:53:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B8A564032F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 13:53:48 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id D8C354ED;
 Mon, 14 Jun 2021 15:53:44 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v5 5/6] x86/insn: Extend error reporting from
 insn_fetch_from_user[_inatomic]()
Date: Mon, 14 Jun 2021 15:53:26 +0200
Message-Id: <20210614135327.9921-6-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614135327.9921-1-joro@8bytes.org>
References: <20210614135327.9921-1-joro@8bytes.org>
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
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Erdem Aktas <erdemaktas@google.com>
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

The error reporting from the insn_fetch_from_user*() functions is not
very verbose. Extend it to include information on whether the linear
RIP could not be calculated or whether the memory access faulted.

This will be used in the SEV-ES code to propagate the correct
exception depending on what went wrong during instruction fetch.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev.c    |  8 ++++----
 arch/x86/kernel/umip.c   | 10 ++++------
 arch/x86/lib/insn-eval.c |  8 ++++++--
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 6a580a8d5b32..259f64be2611 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -270,17 +270,17 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	int res;
+	int insn_bytes;
 
-	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (!res) {
+	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
+	if (insn_bytes <= 0) {
 		ctxt->fi.vector     = X86_TRAP_PF;
 		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
 		ctxt->fi.cr2        = ctxt->regs->ip;
 		return ES_EXCEPTION;
 	}
 
-	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
 		return ES_DECODE_FAILED;
 
 	if (ctxt->insn.immediate.got)
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 8daa70b0d2da..337178809c89 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -346,14 +346,12 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!regs)
 		return false;
 
-	nr_copied = insn_fetch_from_user(regs, buf);
-
 	/*
-	 * The insn_fetch_from_user above could have failed if user code
-	 * is protected by a memory protection key. Give up on emulation
-	 * in such a case.  Should we issue a page fault?
+	 * Give up on emulation if fetching the instruction failed. Should we
+	 * issue a page fault or a #GP?
 	 */
-	if (!nr_copied)
+	nr_copied = insn_fetch_from_user(regs, buf);
+	if (nr_copied <= 0)
 		return false;
 
 	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4eecb9c7c6a0..1b5cdf8b7a4e 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1451,6 +1451,8 @@ static int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
  * Number of instruction bytes copied.
  *
  * 0 if nothing was copied.
+ *
+ * -EINVAL if the linear address of the instruction could not be calculated
  */
 int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 {
@@ -1458,7 +1460,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 	int not_copied;
 
 	if (insn_get_effective_ip(regs, &ip))
-		return 0;
+		return -EINVAL;
 
 	not_copied = copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE);
 
@@ -1479,6 +1481,8 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  * Number of instruction bytes copied.
  *
  * 0 if nothing was copied.
+ *
+ * -EINVAL if the linear address of the instruction could not be calculated
  */
 int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 {
@@ -1486,7 +1490,7 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
 	int not_copied;
 
 	if (insn_get_effective_ip(regs, &ip))
-		return 0;
+		return -EINVAL;
 
 	not_copied = __copy_from_user_inatomic(buf, (void __user *)ip, MAX_INSN_SIZE);
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
