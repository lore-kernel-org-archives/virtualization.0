Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB073C433E2
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:28:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95789215A4
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95789215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 63BCF86088;
	Mon,  7 Sep 2020 13:28:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DfCmeXPeMIU8; Mon,  7 Sep 2020 13:27:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B467A86168;
	Mon,  7 Sep 2020 13:27:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92755C0894;
	Mon,  7 Sep 2020 13:27:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A8E7C0859
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 71F3021509
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HYNcHdUzJTAu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 73A4820531
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:47 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 2E1713AA8;
 Mon,  7 Sep 2020 15:17:17 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 66/72] x86/realmode: Setup AP jump table
Date: Mon,  7 Sep 2020 15:16:07 +0200
Message-Id: <20200907131613.12703-67-joro@8bytes.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

As part of the GHCB specification, the booting of APs under SEV-ES
requires an AP jump table when transitioning from one layer of code to
another (e.g. when going from UEFI to the OS). As a result, each layer
that parks an AP must provide the physical address of an AP jump table
to the next layer via the hypervisor.

Upon booting of the kernel, read the AP jump table address from the
hypervisor. Under SEV-ES, APs are started using the INIT-SIPI-SIPI
sequence. Before issuing the first SIPI request for an AP, the start
CS and IP is programmed into the AP jump table. Upon issuing the SIPI
request, the AP will awaken and jump to that start CS:IP address.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Adapted to different code base
                   - Moved AP table setup from SIPI sending path to
		     real-mode setup code
		   - Fix sparse warnings ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/sev-es.h   |  5 +++
 arch/x86/include/uapi/asm/svm.h |  3 ++
 arch/x86/kernel/sev-es.c        | 69 +++++++++++++++++++++++++++++++++
 arch/x86/realmode/init.c        | 18 ++++++++-
 4 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index 59176e8c6b81..db88e1c3442d 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -73,6 +73,9 @@ static inline u64 lower_bits(u64 val, unsigned int bits)
 	return (val & mask);
 }
 
+struct real_mode_header;
+enum stack_type;
+
 /* Early IDT entry points for #VC handler */
 extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
@@ -92,9 +95,11 @@ static __always_inline void sev_es_ist_exit(void)
 	if (static_branch_unlikely(&sev_es_enable_key))
 		__sev_es_ist_exit();
 }
+extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
+static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 #endif
 
 #endif
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 8f36ae021a7f..346b8a7155e8 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -84,6 +84,9 @@
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
+#define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
+#define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
 #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
 
 #define SVM_EXIT_ERR           -1
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 9814ac99aea1..91e32172d355 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -21,6 +21,7 @@
 #include <linux/mm.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/stacktrace.h>
 #include <asm/sev-es.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/internal.h>
@@ -214,6 +215,9 @@ static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
 	}
 }
 
+/* Needed in vc_early_forward_exception */
+void do_early_exception(struct pt_regs *regs, int trapnr);
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return native_read_msr(MSR_AMD64_SEV_ES_GHCB);
@@ -402,6 +406,71 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 /* Include code shared with pre-decompression boot stage */
 #include "sev-es-shared.c"
 
+static u64 get_jump_table_addr(void)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u64 ret = 0;
+
+	local_irq_save(flags);
+
+	ghcb = sev_es_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
+	ghcb_set_sw_exit_info_1(ghcb, SVM_VMGEXIT_GET_AP_JUMP_TABLE);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
+	    ghcb_sw_exit_info_2_is_valid(ghcb))
+		ret = ghcb->save.sw_exit_info_2;
+
+	sev_es_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
+{
+	u16 startup_cs, startup_ip;
+	phys_addr_t jump_table_pa;
+	u64 jump_table_addr;
+	u16 __iomem *jump_table;
+
+	jump_table_addr = get_jump_table_addr();
+
+	/* On UP guests there is no jump table so this is not a failure */
+	if (!jump_table_addr)
+	       return 0;
+
+	/* Check if AP Jump Table is page-aligned */
+	if (jump_table_addr & ~PAGE_MASK)
+		return -EINVAL;
+
+	jump_table_pa = jump_table_addr & PAGE_MASK;
+
+	startup_cs = (u16)(rmh->trampoline_start >> 4);
+	startup_ip = (u16)(rmh->sev_es_trampoline_start -
+			   rmh->trampoline_start);
+
+	jump_table = ioremap_encrypted(jump_table_pa, PAGE_SIZE);
+	if (!jump_table)
+		return -EIO;
+
+	writew(startup_ip, &jump_table[0]);
+	writew(startup_cs, &jump_table[1]);
+
+	iounmap(jump_table);
+
+	return 0;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 1ed1208931e0..3fb9b60be07a 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -9,6 +9,7 @@
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
 #include <asm/crash.h>
+#include <asm/sev-es.h>
 
 struct real_mode_header *real_mode_header;
 u32 *trampoline_cr4_features;
@@ -38,6 +39,19 @@ void __init reserve_real_mode(void)
 	crash_reserve_low_1M();
 }
 
+static void sme_sev_setup_real_mode(struct trampoline_header *th)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	if (sme_active())
+		th->flags |= TH_FLAGS_SME_ACTIVE;
+
+	if (sev_es_active()) {
+		if (sev_es_setup_ap_jump_table(real_mode_header))
+			panic("Failed to get/update SEV-ES AP Jump Table");
+	}
+#endif
+}
+
 static void __init setup_real_mode(void)
 {
 	u16 real_mode_seg;
@@ -104,13 +118,13 @@ static void __init setup_real_mode(void)
 	*trampoline_cr4_features = mmu_cr4_features;
 
 	trampoline_header->flags = 0;
-	if (sme_active())
-		trampoline_header->flags |= TH_FLAGS_SME_ACTIVE;
 
 	trampoline_pgd = (u64 *) __va(real_mode_header->trampoline_pgd);
 	trampoline_pgd[0] = trampoline_pgd_entry.pgd;
 	trampoline_pgd[511] = init_top_pgt[511].pgd;
 #endif
+
+	sme_sev_setup_real_mode(trampoline_header);
 }
 
 /*
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
