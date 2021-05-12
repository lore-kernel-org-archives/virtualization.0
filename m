Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5BC43619
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 07:55:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B3F61370
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 07:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B3F61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F92A404F1;
	Wed, 12 May 2021 07:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nXXszqOkTlHb; Wed, 12 May 2021 07:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 114D3404F6;
	Wed, 12 May 2021 07:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFA51C000F;
	Wed, 12 May 2021 07:55:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8522AC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EDE483518
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r18st7X4Jyci
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9614283096
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:15 +0000 (UTC)
Received: from cap.home.8bytes.org (p549ad305.dip0.t-ipconnect.de
 [84.154.211.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id D19EA4B4;
 Wed, 12 May 2021 09:55:10 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org,
	Hyunwook Baek <baekhw@google.com>
Subject: [PATCH 6/6] x86/sev-es: Leave NMI-mode before sending signals
Date: Wed, 12 May 2021 09:54:45 +0200
Message-Id: <20210512075445.18935-7-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512075445.18935-1-joro@8bytes.org>
References: <20210512075445.18935-1-joro@8bytes.org>
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

The error path in the runtime #VC handler sends a signal to kill the
current task if the exception was raised from user-space. Some parts of
the #VC handler run in NMI mode, because it is critical that it is not
interrupted (except from an NMI) while the GHCB is in use.

But sending signals in NMI-mode is actually broken and triggers lockdep
warnings. On the other side, when the signal is sent, there is no reason
for the handler to still be in NMI-mode, as the GHCB is not used
anymore.

Leave NMI-mode before entering the error path to get rid of the lockdep
warnings.

Fixes: 62441a1fb532 ("x86/sev-es: Correctly track IRQ states in runtime #VC handler")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 77155c4f07f5..79cbed2f28de 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1300,9 +1300,10 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		return;
 	}
 
+	instrumentation_begin();
+
 	irq_state = irqentry_nmi_enter(regs);
 	lockdep_assert_irqs_disabled();
-	instrumentation_begin();
 
 	/*
 	 * This is invoked through an interrupt gate, so IRQs are disabled. The
@@ -1352,13 +1353,19 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		BUG();
 	}
 
-out:
-	instrumentation_end();
 	irqentry_nmi_exit(regs, irq_state);
+	instrumentation_end();
 
 	return;
 
 fail:
+	/*
+	 * Leave NMI mode - the GHCB is not busy anymore and depending on where
+	 * the #VC came from this code is about to either kill the task (when in
+	 * task context) or kill the machine.
+	 */
+	irqentry_nmi_exit(regs, irq_state);
+
 	if (user_mode(regs)) {
 		/*
 		 * Do not kill the machine if user-space triggered the
@@ -1380,7 +1387,9 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		panic("Returned from Terminate-Request to Hypervisor\n");
 	}
 
-	goto out;
+	instrumentation_end();
+
+	return;
 }
 
 /* This handler runs on the #VC fall-back stack. It can cause further #VC exceptions */
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
