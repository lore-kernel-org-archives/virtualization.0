Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CFEC433E2
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:27:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B80E2166E
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B80E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DDF38860E6;
	Mon,  7 Sep 2020 13:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47tQKBdcByV7; Mon,  7 Sep 2020 13:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 543DA86099;
	Mon,  7 Sep 2020 13:27:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F2AFC0893;
	Mon,  7 Sep 2020 13:27:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50F41C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3BAD887184
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wg5FPf-01A2D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9671087188
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:47 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id F01DA3AAD;
 Mon,  7 Sep 2020 15:17:18 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 69/72] x86/sev-es: Support CPU offline/online
Date: Mon,  7 Sep 2020 15:16:10 +0200
Message-Id: <20200907131613.12703-70-joro@8bytes.org>
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

Add a play_dead handler when running under SEV-ES. This is needed
because the hypervisor can't deliver an SIPI request to restart the AP.
Instead the kernel has to issue a VMGEXIT to halt the VCPU until the
hypervisor wakes it up again.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/uapi/asm/svm.h |  1 +
 arch/x86/kernel/sev-es.c        | 63 +++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 346b8a7155e8..c1dcf3e114e4 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -84,6 +84,7 @@
 /* SEV-ES software-defined VMGEXIT events */
 #define SVM_VMGEXIT_MMIO_READ			0x80000001
 #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
+#define SVM_VMGEXIT_AP_HLT_LOOP			0x80000004
 #define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
 #define SVM_VMGEXIT_SET_AP_JUMP_TABLE		0
 #define SVM_VMGEXIT_GET_AP_JUMP_TABLE		1
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 91e32172d355..0b6c4f46ddfc 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -29,6 +29,8 @@
 #include <asm/realmode.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
+#include <asm/smp.h>
+#include <asm/cpu.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -518,6 +520,65 @@ static bool __init sev_es_setup_ghcb(void)
 	return true;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void sev_es_ap_hlt_loop(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = sev_es_get_ghcb(&state);
+
+	while (true) {
+		vc_ghcb_invalidate(ghcb);
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_HLT_LOOP);
+		ghcb_set_sw_exit_info_1(ghcb, 0);
+		ghcb_set_sw_exit_info_2(ghcb, 0);
+
+		sev_es_wr_ghcb_msr(__pa(ghcb));
+		VMGEXIT();
+
+		/* Wakeup signal? */
+		if (ghcb_sw_exit_info_2_is_valid(ghcb) &&
+		    ghcb->save.sw_exit_info_2)
+			break;
+	}
+
+	sev_es_put_ghcb(&state);
+}
+
+/*
+ * Play_dead handler when running under SEV-ES. This is needed because
+ * the hypervisor can't deliver an SIPI request to restart the AP.
+ * Instead the kernel has to issue a VMGEXIT to halt the VCPU until the
+ * hypervisor wakes it up again.
+ */
+static void sev_es_play_dead(void)
+{
+	play_dead_common();
+
+	/* IRQs now disabled */
+
+	sev_es_ap_hlt_loop();
+
+	/*
+	 * If we get here, the VCPU was woken up again. Jump to CPU
+	 * startup code to get it back online.
+	 */
+	start_cpu0();
+}
+#else  /* CONFIG_HOTPLUG_CPU */
+#define sev_es_play_dead	native_play_dead
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#ifdef CONFIG_SMP
+static void __init sev_es_setup_play_dead(void)
+{
+	smp_ops.play_dead = sev_es_play_dead;
+}
+#else
+static inline void sev_es_setup_play_dead(void) { }
+#endif
+
 static void __init alloc_runtime_data(int cpu)
 {
 	struct sev_es_runtime_data *data;
@@ -566,6 +627,8 @@ void __init sev_es_init_vc_handling(void)
 		setup_vc_stacks(cpu);
 	}
 
+	sev_es_setup_play_dead();
+
 	/* Secondary CPUs use the runtime #VC handler */
 	initial_vc_handler = (unsigned long)safe_stack_exc_vmm_communication;
 }
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
