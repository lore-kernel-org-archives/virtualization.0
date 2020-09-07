Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1740BC43461
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9462207C3
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9462207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEFCD867A1;
	Mon,  7 Sep 2020 13:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zc99utwDhtRH; Mon,  7 Sep 2020 13:17:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5A5258670C;
	Mon,  7 Sep 2020 13:17:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51693C0859;
	Mon,  7 Sep 2020 13:17:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40D97C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1C3BE20398
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JIerc71FO-Fv
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 136EB1FD7D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:00 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 7EE22FDC;
 Mon,  7 Sep 2020 15:16:57 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 30/72] x86/head/64: Load GDT after switch to virtual
 addresses
Date: Mon,  7 Sep 2020 15:15:31 +0200
Message-Id: <20200907131613.12703-31-joro@8bytes.org>
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

Load the GDT right after switching to virtual addresses to make sure
there is a defined GDT for exception handling.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/head_64.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2b2e91627221..03b03f266dc1 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -158,6 +158,14 @@ SYM_CODE_START(secondary_startup_64)
 1:
 	UNWIND_HINT_EMPTY
 
+	/*
+	 * We must switch to a new descriptor in kernel space for the GDT
+	 * because soon the kernel won't have access anymore to the userspace
+	 * addresses where we're currently running on. We have to do that here
+	 * because in 32bit we couldn't load a 64bit linear address.
+	 */
+	lgdt	early_gdt_descr(%rip)
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
@@ -185,14 +193,6 @@ SYM_CODE_START(secondary_startup_64)
 	pushq $0
 	popfq
 
-	/*
-	 * We must switch to a new descriptor in kernel space for the GDT
-	 * because soon the kernel won't have access anymore to the userspace
-	 * addresses where we're currently running on. We have to do that here
-	 * because in 32bit we couldn't load a 64bit linear address.
-	 */
-	lgdt	early_gdt_descr(%rip)
-
 	/* set up data segments */
 	xorl %eax,%eax
 	movl %eax,%ds
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
