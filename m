Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347CC43461
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:16:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF19220838
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF19220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 969A785F83;
	Mon,  7 Sep 2020 13:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAgGuqvD2_2v; Mon,  7 Sep 2020 13:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ECBB785F50;
	Mon,  7 Sep 2020 13:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D65E3C0859;
	Mon,  7 Sep 2020 13:16:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C6E5C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 43A1F86717
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBorZA1QCnKk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 143CF86749
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:48 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 361CEBCA;
 Mon,  7 Sep 2020 15:16:45 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 06/72] x86/traps: Move pf error codes to <asm/trap_pf.h>
Date: Mon,  7 Sep 2020 15:15:07 +0200
Message-Id: <20200907131613.12703-7-joro@8bytes.org>
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

Move the definition of the x86 page-fault error code bits to the new
header file asm/trap_pf.h. This makes it easier to include them into
pre-decompression boot code. No functional changes.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/trap_pf.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/traps.h   | 19 +------------------
 2 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/trap_pf.h

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
new file mode 100644
index 000000000000..305bc1214aef
--- /dev/null
+++ b/arch/x86/include/asm/trap_pf.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_TRAP_PF_H
+#define _ASM_X86_TRAP_PF_H
+
+/*
+ * Page fault error code bits:
+ *
+ *   bit 0 ==	 0: no page found	1: protection fault
+ *   bit 1 ==	 0: read access		1: write access
+ *   bit 2 ==	 0: kernel-mode access	1: user-mode access
+ *   bit 3 ==				1: use of reserved bit detected
+ *   bit 4 ==				1: fault was an instruction fetch
+ *   bit 5 ==				1: protection keys block access
+ */
+enum x86_pf_error_code {
+	X86_PF_PROT	=		1 << 0,
+	X86_PF_WRITE	=		1 << 1,
+	X86_PF_USER	=		1 << 2,
+	X86_PF_RSVD	=		1 << 3,
+	X86_PF_INSTR	=		1 << 4,
+	X86_PF_PK	=		1 << 5,
+};
+
+#endif /* _ASM_X86_TRAP_PF_H */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..6a308355ea29 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -8,6 +8,7 @@
 #include <asm/debugreg.h>
 #include <asm/idtentry.h>
 #include <asm/siginfo.h>			/* TRAP_TRACE, ... */
+#include <asm/trap_pf.h>
 
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
@@ -41,22 +42,4 @@ void __noreturn handle_stack_overflow(const char *message,
 				      unsigned long fault_address);
 #endif
 
-/*
- * Page fault error code bits:
- *
- *   bit 0 ==	 0: no page found	1: protection fault
- *   bit 1 ==	 0: read access		1: write access
- *   bit 2 ==	 0: kernel-mode access	1: user-mode access
- *   bit 3 ==				1: use of reserved bit detected
- *   bit 4 ==				1: fault was an instruction fetch
- *   bit 5 ==				1: protection keys block access
- */
-enum x86_pf_error_code {
-	X86_PF_PROT	=		1 << 0,
-	X86_PF_WRITE	=		1 << 1,
-	X86_PF_USER	=		1 << 2,
-	X86_PF_RSVD	=		1 << 3,
-	X86_PF_INSTR	=		1 << 4,
-	X86_PF_PK	=		1 << 5,
-};
 #endif /* _ASM_X86_TRAPS_H */
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
