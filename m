Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31431C2D0E3
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87AE20838
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87AE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A5C9087168;
	Mon,  7 Sep 2020 13:17:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JAl14ihyCLd; Mon,  7 Sep 2020 13:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 958F987160;
	Mon,  7 Sep 2020 13:17:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E49AC0893;
	Mon,  7 Sep 2020 13:17:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D43D0C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C07BA8715A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z0QtCHj7xyYF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 03774870A2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 634A2FC1;
 Mon,  7 Sep 2020 15:16:54 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 24/72] x86/boot/compressed/64: Unmap GHCB page before
 booting the kernel
Date: Mon,  7 Sep 2020 15:15:25 +0200
Message-Id: <20200907131613.12703-25-joro@8bytes.org>
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

Force a page-fault on any further accesses to the GHCB page when they
shouldn't happen anymore. This will catch the bugs where a #VC exception
is raised when no one is expected anymore.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/ident_map_64.c | 17 +++++++++++++++--
 arch/x86/boot/compressed/misc.h         |  6 ++++++
 arch/x86/boot/compressed/sev-es.c       | 14 ++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 05742f641a06..063a60edcf99 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -298,6 +298,11 @@ int set_page_encrypted(unsigned long address)
 	return set_clr_page_flags(&mapping_info, address, _PAGE_ENC, 0);
 }
 
+int set_page_non_present(unsigned long address)
+{
+	return set_clr_page_flags(&mapping_info, address, 0, _PAGE_PRESENT);
+}
+
 static void do_pf_error(const char *msg, unsigned long error_code,
 			unsigned long address, unsigned long ip)
 {
@@ -316,8 +321,14 @@ static void do_pf_error(const char *msg, unsigned long error_code,
 
 void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
-	unsigned long address = native_read_cr2() & PMD_MASK;
-	unsigned long end = address + PMD_SIZE;
+	unsigned long address = native_read_cr2();
+	unsigned long end;
+	bool ghcb_fault;
+
+	ghcb_fault = sev_es_check_ghcb_fault(address);
+
+	address   &= PMD_MASK;
+	end        = address + PMD_SIZE;
 
 	/*
 	 * Check for unexpected error codes. Unexpected are:
@@ -327,6 +338,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
 		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
+	else if (ghcb_fault)
+		do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
 
 	/*
 	 * Error code is sane - now identity map the 2M region around
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 9995c70ca813..c0e0ffeee50a 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -100,6 +100,7 @@ static inline void choose_random_location(unsigned long input,
 #ifdef CONFIG_X86_64
 extern int set_page_decrypted(unsigned long address);
 extern int set_page_encrypted(unsigned long address);
+extern int set_page_non_present(unsigned long address);
 extern unsigned char _pgtable[];
 #endif
 
@@ -117,8 +118,13 @@ void set_sev_encryption_mask(void);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 void sev_es_shutdown_ghcb(void);
+extern bool sev_es_check_ghcb_fault(unsigned long address);
 #else
 static inline void sev_es_shutdown_ghcb(void) { }
+static inline bool sev_es_check_ghcb_fault(unsigned long address)
+{
+	return false;
+}
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 633d47df702f..ea656b22743b 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -121,6 +121,20 @@ void sev_es_shutdown_ghcb(void)
 	 */
 	if (set_page_encrypted((unsigned long)&boot_ghcb_page))
 		error("Can't map GHCB page encrypted");
+
+	/*
+	 * GHCB page is mapped encrypted again and flushed from the cache.
+	 * Mark it non-present now to catch bugs when #VC exceptions trigger
+	 * after this point.
+	 */
+	if (set_page_non_present((unsigned long)&boot_ghcb_page))
+		error("Can't unmap GHCB page");
+}
+
+bool sev_es_check_ghcb_fault(unsigned long address)
+{
+	/* Check whether the fault was on the GHCB page */
+	return ((address & PAGE_MASK) == (unsigned long)&boot_ghcb_page);
 }
 
 void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
