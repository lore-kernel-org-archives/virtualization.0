Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373E9C433FE
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 10:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D248F41B4B;
	Thu, 27 Jan 2022 10:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h2_o7PHC6WNc; Thu, 27 Jan 2022 10:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8171141C94;
	Thu, 27 Jan 2022 10:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C515AC0031;
	Thu, 27 Jan 2022 10:11:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A161C007D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E10B610B2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lewz-SKK6mCq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43FE160F3B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:27 +0000 (UTC)
Received: from cap.home.8bytes.org (p549ad610.dip0.t-ipconnect.de
 [84.154.214.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id C1787DB2;
 Thu, 27 Jan 2022 11:11:24 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v3 10/10] x86/kexec/64: Support kexec under SEV-ES with AP
 Jump Table Blob
Date: Thu, 27 Jan 2022 11:10:44 +0100
Message-Id: <20220127101044.13803-11-joro@8bytes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127101044.13803-1-joro@8bytes.org>
References: <20220127101044.13803-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Erdem Aktas <erdemaktas@google.com>
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

When the AP jump table blob is installed the kernel can hand over the
APs from the old to the new kernel. Enable kexec when the AP jump
table blob has been installed.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/sev.h         |  2 ++
 arch/x86/kernel/machine_kexec_64.c |  3 ++-
 arch/x86/kernel/sev.c              | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e342dce3e7a1..41e07d037b6e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -91,6 +91,7 @@ extern enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  u64 exit_code, u64 exit_info_1,
 					  u64 exit_info_2);
 void sev_es_stop_this_cpu(void);
+bool sev_kexec_supported(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -98,6 +99,7 @@ static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { ret
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
 static inline void sev_es_stop_this_cpu(void) { }
+static inline bool sev_kexec_supported(void) { return true; }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5079a75f8944..c58808fe3fb5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -27,6 +27,7 @@
 #include <asm/kexec-bzimage64.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
+#include <asm/sev.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -271,7 +272,7 @@ static void load_segments(void)
 
 static bool machine_kexec_supported(void)
 {
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!sev_kexec_supported())
 		return false;
 
 	return true;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1bced5b49150..17dcbcddd6ab 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -884,6 +884,21 @@ static int __init sev_setup_ap_jump_table(void)
 }
 core_initcall(sev_setup_ap_jump_table);
 
+bool sev_kexec_supported(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return true;
+
+	/*
+	 * KEXEC with SEV-ES and more than one CPU is only supported
+	 * when the AP jump table is installed.
+	 */
+	if (num_possible_cpus() > 1)
+		return sev_ap_jumptable_blob_installed;
+	else
+		return true;
+}
+
 static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
