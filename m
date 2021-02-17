Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF780C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:02:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE6B64E5B
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE6B64E5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F253586F98;
	Wed, 17 Feb 2021 12:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id apAxR5uklqcD; Wed, 17 Feb 2021 12:02:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48AF687223;
	Wed, 17 Feb 2021 12:02:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32579C0174;
	Wed, 17 Feb 2021 12:02:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9D2DC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C994B86D32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Nnj3FajZlUt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:02:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E6F586D19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:02:12 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id AF1D1412;
 Wed, 17 Feb 2021 13:02:09 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH 3/3] x86/sev-es: Improve comments in and around
 __sev_es_ist_enter/exit()
Date: Wed, 17 Feb 2021 13:01:43 +0100
Message-Id: <20210217120143.6106-4-joro@8bytes.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217120143.6106-1-joro@8bytes.org>
References: <20210217120143.6106-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
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

Better explain why this code is necessary and what it is doing.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0df38b185d53..79241bc45f25 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -127,14 +127,20 @@ static __always_inline bool on_vc_stack(unsigned long sp)
 }
 
 /*
- * This function handles the case when an NMI is raised in the #VC exception
- * handler entry code. In this case, the IST entry for #VC must be adjusted, so
- * that any subsequent #VC exception will not overwrite the stack contents of the
- * interrupted #VC handler.
+ * This function handles the case when an NMI is raised in the #VC
+ * exception handler entry code, before the #VC handler has switched off
+ * its IST stack. In this case, the IST entry for #VC must be adjusted,
+ * so that any nested #VC exception will not overwrite the stack
+ * contents of the interrupted #VC handler.
  *
  * The IST entry is adjusted unconditionally so that it can be also be
- * unconditionally adjusted back in sev_es_ist_exit(). Otherwise a nested
- * sev_es_ist_exit() call may adjust back the IST entry too early.
+ * unconditionally adjusted back in __sev_es_ist_exit(). Otherwise a
+ * nested sev_es_ist_exit() call may adjust back the IST entry too
+ * early.
+ *
+ * The __sev_es_ist_enter() and __sev_es_ist_exit() functions always run
+ * on the NMI IST stack, as they are only called from NMI handling code
+ * right now.
  */
 void noinstr __sev_es_ist_enter(struct pt_regs *regs)
 {
@@ -143,7 +149,10 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
 	/* Read old IST entry */
 	old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
 
-	/* Make room on the IST stack */
+	/*
+	 * Make room on the IST stack - Reserve 8 bytes to store the old
+	 * IST entry.
+	 */
 	if (on_vc_stack(regs->sp) &&
 	    !user_mode(regs) &&
 	    !from_syscall_gap(regs))
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
