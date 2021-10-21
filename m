Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13767C4332F
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 08:08:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C372460FED
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 08:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C372460FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 898BD60EA0;
	Thu, 21 Oct 2021 08:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bma3dmbBUe21; Thu, 21 Oct 2021 08:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C13D6068A;
	Thu, 21 Oct 2021 08:08:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 247BEC0033;
	Thu, 21 Oct 2021 08:08:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98AA9C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87061402A2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZjKuzpcYYS7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:08:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC42640265
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 08:08:44 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de
 [79.242.181.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 6768E29C;
 Thu, 21 Oct 2021 10:08:38 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH 2/2] x86/sev: Allow #VC exceptions on the VC2 stack
Date: Thu, 21 Oct 2021 10:08:33 +0200
Message-Id: <20211021080833.30875-3-joro@8bytes.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211021080833.30875-1-joro@8bytes.org>
References: <20211021080833.30875-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Xinyang Ge <xing@microsoft.com>,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 Marc Orr <marcorr@google.com>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Juergen Gross <jgross@suse.com>,
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

When code running on the VC2 stack causes a nested VC exception, the
handler will not handle it as expected but goes again into the error
path.

The result is that the panic() call happening when the VC exception
was raised in an invalid context is called recursively. Fix this by
checking the interrupted stack too and only call panic if it is not
the VC2 stack.

Reported-by: Xinyang Ge <xing@microsoft.com>
Fixes: 0786138c78e79 ("x86/sev-es: Add a Runtime #VC Exception Handler")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..f39165b5fa34 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1319,13 +1319,26 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 	}
 }
 
-static __always_inline bool on_vc_fallback_stack(struct pt_regs *regs)
+static __always_inline bool is_vc2_stack(unsigned long sp)
 {
-	unsigned long sp = (unsigned long)regs;
-
 	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
 }
 
+static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
+{
+	unsigned long sp, prev_sp;
+
+	sp      = (unsigned long)regs;
+	prev_sp = regs->sp;
+
+	/*
+	 * If the code was already executing on the VC2 stack when the #VC
+	 * happened, let it proceed to the normal handling routine. This way the
+	 * code executing on the VC2 stack can cause get #VC exceptions handled.
+	 */
+	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
+}
+
 static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
 {
 	struct ghcb_state state;
@@ -1406,7 +1419,7 @@ DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
 	 * But keep this here in case the noinstr annotations are violated due
 	 * to bug elsewhere.
 	 */
-	if (unlikely(on_vc_fallback_stack(regs))) {
+	if (unlikely(vc_from_invalid_context(regs))) {
 		instrumentation_begin();
 		panic("Can't handle #VC exception from unsupported context\n");
 		instrumentation_end();
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
