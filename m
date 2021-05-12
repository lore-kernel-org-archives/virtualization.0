Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4FC43600
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 07:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B988613BF
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 07:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B988613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2141C83D23;
	Wed, 12 May 2021 07:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MaiI5kLer7IU; Wed, 12 May 2021 07:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A76E38350A;
	Wed, 12 May 2021 07:55:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE48C0030;
	Wed, 12 May 2021 07:55:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04D05C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E81CB4019A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGN1Fa_fgO4j
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9968F40015
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:55:11 +0000 (UTC)
Received: from cap.home.8bytes.org (p549ad305.dip0.t-ipconnect.de
 [84.154.211.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id E9F862A5;
 Wed, 12 May 2021 09:55:07 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org,
	Hyunwook Baek <baekhw@google.com>
Subject: [PATCH 1/6] x86/sev-es: Don't return NULL from sev_es_get_ghcb()
Date: Wed, 12 May 2021 09:54:40 +0200
Message-Id: <20210512075445.18935-2-joro@8bytes.org>
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

The sev_es_get_ghcb() is called from several places, but only one of
them checks the return value. The reaction to returning NULL is always
the same: Calling panic() and kill the machine.

Instead of adding checks to all call-places, move the panic() into the
function itself so that it will no longer return NULL.

Fixes: 0786138c78e7 ("x86/sev-es: Add a Runtime #VC Exception Handler")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9578c82832aa..c49270c7669e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -203,8 +203,18 @@ static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
 	if (unlikely(data->ghcb_active)) {
 		/* GHCB is already in use - save its contents */
 
-		if (unlikely(data->backup_ghcb_active))
-			return NULL;
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+		}
 
 		/* Mark backup_ghcb active before writing to it */
 		data->backup_ghcb_active = true;
@@ -1284,7 +1294,6 @@ static __always_inline bool on_vc_fallback_stack(struct pt_regs *regs)
  */
 DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 {
-	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
 	irqentry_state_t irq_state;
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -1310,16 +1319,6 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	 */
 
 	ghcb = sev_es_get_ghcb(&state);
-	if (!ghcb) {
-		/*
-		 * Mark GHCBs inactive so that panic() is able to print the
-		 * message.
-		 */
-		data->ghcb_active        = false;
-		data->backup_ghcb_active = false;
-
-		panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-	}
 
 	vc_ghcb_invalidate(ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, error_code);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
