Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E89FC433E6
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 14:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7510064EE1
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 14:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7510064EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF4A549986;
	Wed,  3 Mar 2021 14:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q45RnKqV3zIE; Wed,  3 Mar 2021 14:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AAC34954E;
	Wed,  3 Mar 2021 14:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0682FC000E;
	Wed,  3 Mar 2021 14:17:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4477FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3305F400E9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Krdod1LWD4N
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:17:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68435400E6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:17:30 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id DD0A1451;
 Wed,  3 Mar 2021 15:17:23 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH 3/5] x86/sev-es: Optimize __sev_es_ist_enter() for better
 readability
Date: Wed,  3 Mar 2021 15:17:14 +0100
Message-Id: <20210303141716.29223-4-joro@8bytes.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303141716.29223-1-joro@8bytes.org>
References: <20210303141716.29223-1-joro@8bytes.org>
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

Reorganize the code and improve the comments to make the function more
readable and easier to understand.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 28b0144daddd..e1eeb3ef58c5 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -137,29 +137,41 @@ static __always_inline bool on_vc_stack(struct pt_regs *regs)
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
 	unsigned long old_ist, new_ist;
 
 	/* Read old IST entry */
-	old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+	new_ist = old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
 
-	/* Make room on the IST stack */
+	/*
+	 * If NMI happened while on the #VC IST stack, set the new IST
+	 * value below regs->sp, so that the interrupted stack frame is
+	 * not overwritten by subsequent #VC exceptions.
+	 */
 	if (on_vc_stack(regs))
-		new_ist = ALIGN_DOWN(regs->sp, 8) - sizeof(old_ist);
-	else
-		new_ist = old_ist - sizeof(old_ist);
+		new_ist = regs->sp;
 
-	/* Store old IST entry */
+	/*
+	 * Reserve additional 8 bytes and store old IST value so this
+	 * adjustment can be unrolled in __sev_es_ist_exit().
+	 */
+	new_ist -= sizeof(old_ist);
 	*(unsigned long *)new_ist = old_ist;
 
 	/* Set new IST entry */
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
