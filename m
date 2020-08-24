Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E67C433E4
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173CD2087D
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 08:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173CD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCC42878B0;
	Mon, 24 Aug 2020 08:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrETXoe1dS+x; Mon, 24 Aug 2020 08:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEEB68787C;
	Mon, 24 Aug 2020 08:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 943D2C089E;
	Mon, 24 Aug 2020 08:56:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4482C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D7AF185F59
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYO8RwIrTtDn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9E90E85FEF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 08:56:08 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 0C98FF13;
 Mon, 24 Aug 2020 10:56:03 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 31/76] x86/head/64: Setup MSR_GS_BASE before calling into C
 code
Date: Mon, 24 Aug 2020 10:54:26 +0200
Message-Id: <20200824085511.7553-32-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
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

When stack-protector is enabled a valid GS_BASE is needed before
calling any C code function, because the stack canary is loaded from
per-cpu data.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200724160336.5435-31-joro@8bytes.org
---
 arch/x86/kernel/head64.c  | 7 +++++++
 arch/x86/kernel/head_64.S | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8c82be44be94..b0ab5627900b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -36,6 +36,7 @@
 #include <asm/microcode.h>
 #include <asm/kasan.h>
 #include <asm/fixmap.h>
+#include <asm/realmode.h>
 
 /*
  * Manage page tables very early on.
@@ -513,6 +514,8 @@ void __init x86_64_start_reservations(char *real_mode_data)
  */
 void __head startup_64_setup_env(unsigned long physbase)
 {
+	unsigned long gsbase;
+
 	/* Load GDT */
 	startup_gdt_descr.address = (unsigned long)fixup_pointer(startup_gdt, physbase);
 	native_load_gdt(&startup_gdt_descr);
@@ -521,4 +524,8 @@ void __head startup_64_setup_env(unsigned long physbase)
 	asm volatile("movl %%eax, %%ds\n"
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+
+	/* Setup GS_BASE - needed for stack protector */
+	gsbase = (unsigned long)fixup_pointer((void *)initial_gs, physbase);
+	__wrmsr(MSR_GS_BASE, (u32)gsbase, (u32)(gsbase >> 32));
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 2b2e91627221..800053219054 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -78,6 +78,14 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	startup_64_setup_env
 	popq	%rsi
 
+	/*
+	 * Setup %gs here already to make stack-protector work - it needs to be
+	 * setup again after the switch to kernel addresses. The address read
+	 * from initial_gs is a kernel address, so it needs to be adjusted first
+	 * for the identity mapping.
+	 */
+	movl	$MSR_GS_BASE,%ecx
+
 	/* Now switch to __KERNEL_CS so IRET works reliably */
 	pushq	$__KERNEL_CS
 	leaq	.Lon_kernel_cs(%rip), %rax
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
