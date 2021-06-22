Return-Path: <SRS0=aA1Z=LQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3700AC48BDF
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 14:48:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BE861378
	for <virtualization@archiver.kernel.org>; Tue, 22 Jun 2021 14:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BE861378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C9CB402FD;
	Tue, 22 Jun 2021 14:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r2PTzTCSE4f2; Tue, 22 Jun 2021 14:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F0C2C40245;
	Tue, 22 Jun 2021 14:48:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A99E2C001A;
	Tue, 22 Jun 2021 14:48:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D62E9C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4B1682A17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:48:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 42NydSwr4S0U
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:48:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C215282D85
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:48:46 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 629BD26F;
 Tue, 22 Jun 2021 16:48:42 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH 2/3] x86/sev: Add defines for GHCB version 2 MSR protocol
 requests
Date: Tue, 22 Jun 2021 16:48:24 +0200
Message-Id: <20210622144825.27588-3-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622144825.27588-1-joro@8bytes.org>
References: <20210622144825.27588-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
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

From: Brijesh Singh <brijesh.singh@amd.com>

Add the necessary defines for supporting the GHCB version 2 protocol.
This includes defines for:

	- MSR-based AP hlt request/response
	- Hypervisor Feature request/response

This is the bare minimum of requests that need to be supported by a GHCB
version 2 implementation. There are more requests in the specification,
but those depend on Secure Nested Paging support being available.

These defines are shared between SEV host and guest support, so they are
submitted as an individual patch without users yet to avoid merge
conflicts in the future.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/sev-common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1cc9e7dd8107..4e6c4c7cb294 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -47,6 +47,21 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* AP Reset Hold */
+#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_RESULT_POS	12
+#define GHCB_MSR_AP_RESET_HOLD_RESULT_MASK	GENMASK_ULL(51, 0)
+
+/* GHCB Hypervisor Feature Request/Response */
+#define GHCB_MSR_HV_FT_REQ			0x080
+#define GHCB_MSR_HV_FT_RESP			0x081
+#define GHCB_MSR_HV_FT_POS			12
+#define GHCB_MSR_HV_FT_MASK			GENMASK_ULL(51, 0)
+
+#define GHCB_MSR_HV_FT_RESP_VAL(v)		\
+	(((unsigned long)((v) & GHCB_MSR_HV_FT_MASK) >> GHCB_MSR_HV_FT_POS))
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
