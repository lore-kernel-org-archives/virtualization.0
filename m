Return-Path: <SRS0=KlxN=KO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C50CC43619
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 13:53:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A6E611AE
	for <virtualization@archiver.kernel.org>; Wed, 19 May 2021 13:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A6E611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC380403EB;
	Wed, 19 May 2021 13:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BDhHICY42G0Q; Wed, 19 May 2021 13:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C96B3403E8;
	Wed, 19 May 2021 13:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F7C8C000E;
	Wed, 19 May 2021 13:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2713DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 13:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E00F6078D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 13:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xo3JtT64qLFX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 13:53:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FA96607BC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 13:53:15 +0000 (UTC)
Received: from cap.home.8bytes.org (p549ad305.dip0.t-ipconnect.de
 [84.154.211.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 016484E1;
 Wed, 19 May 2021 15:53:11 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org,
	Hyunwook Baek <baekhw@google.com>
Subject: [PATCH v2 7/8] x86/insn: Extend error reporting from
 insn_fetch_from_user[_inatomic]()
Date: Wed, 19 May 2021 15:52:50 +0200
Message-Id: <20210519135251.30093-8-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519135251.30093-1-joro@8bytes.org>
References: <20210519135251.30093-1-joro@8bytes.org>
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
 arch/x86/include/asm/insn-eval.h |  6 +++--
 arch/x86/kernel/sev.c            |  8 +++----
 arch/x86/kernel/umip.c           | 10 ++++-----
 arch/x86/lib/insn-eval.c         | 38 +++++++++++++++++++++++---------
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 91d7182ad2d6..8362f1ce4b00 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -22,9 +22,11 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
-			 unsigned char buf[MAX_INSN_SIZE]);
+			 unsigned char buf[MAX_INSN_SIZE],
+			 int *copied);
 int insn_fetch_from_user_inatomic(struct pt_regs *regs,
-				  unsigned char buf[MAX_INSN_SIZE]);
+				  unsigned char buf[MAX_INSN_SIZE],
+				  int *copied);
 bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9a64030e74c0..1edb6cd5e308 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -258,17 +258,17 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	int res;
+	int insn_bytes = 0, res;
 
-	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (!res) {
+	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer, &insn_bytes);
+	if (res) {
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
index 8daa70b0d2da..b005ef42682e 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -346,13 +346,13 @@ bool fixup_umip_exception(struct pt_regs *regs)
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
+	if (!insn_fetch_from_user(regs, buf, NULL))
+		return false;
+
 	if (!nr_copied)
 		return false;
 
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4eecb9c7c6a0..d8a057ba0895 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1442,27 +1442,36 @@ static int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
  * insn_fetch_from_user() - Copy instruction bytes from user-space memory
  * @regs:	Structure with register values as seen when entering kernel mode
  * @buf:	Array to store the fetched instruction
+ * @copied:	Pointer to an int where the number of copied instruction bytes
+ *		is stored. Can be NULL.
  *
  * Gets the linear address of the instruction and copies the instruction bytes
  * to the buf.
  *
  * Returns:
  *
- * Number of instruction bytes copied.
+ * -EINVAL if the linear address of the instruction could not be calculated
+ * -EFAULT if nothing was copied
+ *       0 on success
  *
- * 0 if nothing was copied.
  */
-int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
+int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE],
+			 int *copied)
 {
 	unsigned long ip;
 	int not_copied;
+	int bytes;
 
 	if (insn_get_effective_ip(regs, &ip))
-		return 0;
+		return -EINVAL;
 
 	not_copied = copy_from_user(buf, (void __user *)ip, MAX_INSN_SIZE);
 
-	return MAX_INSN_SIZE - not_copied;
+	bytes = MAX_INSN_SIZE - not_copied;
+	if (copied)
+		*copied = bytes;
+
+	return bytes ? 0 : -EFAULT;
 }
 
 /**
@@ -1470,27 +1479,36 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  *                                   while in atomic code
  * @regs:	Structure with register values as seen when entering kernel mode
  * @buf:	Array to store the fetched instruction
+ * @copied:	Pointer to an int where the number of copied instruction bytes
+ *		is stored. Can be NULL.
  *
  * Gets the linear address of the instruction and copies the instruction bytes
  * to the buf. This function must be used in atomic context.
  *
  * Returns:
  *
- * Number of instruction bytes copied.
+ * -EINVAL if the linear address of the instruction could not be calculated
+ * -EFAULT if nothing was copied
+ *       0 on success
  *
- * 0 if nothing was copied.
  */
-int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
+int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE],
+				  int *copied)
 {
 	unsigned long ip;
 	int not_copied;
+	int bytes;
 
 	if (insn_get_effective_ip(regs, &ip))
-		return 0;
+		return -EINVAL;
 
 	not_copied = __copy_from_user_inatomic(buf, (void __user *)ip, MAX_INSN_SIZE);
 
-	return MAX_INSN_SIZE - not_copied;
+	bytes = MAX_INSN_SIZE - not_copied;
+	if (copied)
+		*copied = bytes;
+
+	return bytes ? 0 : -EFAULT;
 }
 
 /**
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
