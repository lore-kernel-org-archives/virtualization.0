Return-Path: <SRS0=2V5C=IB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F3C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 14:29:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D07860202
	for <virtualization@archiver.kernel.org>; Wed,  3 Mar 2021 14:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D07860202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA3A8400F2;
	Wed,  3 Mar 2021 14:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l_GElbnvqq46; Wed,  3 Mar 2021 14:29:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B4B8400ED;
	Wed,  3 Mar 2021 14:29:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 408A4C000B;
	Wed,  3 Mar 2021 14:29:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82275C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62BD9834B6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtaO_0JRf0jV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:29:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 912FA83440
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 14:29:26 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id CC9513A7;
 Wed,  3 Mar 2021 15:17:22 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH 1/5] x86/sev-es: Introduce ip_within_syscall_gap() helper
Date: Wed,  3 Mar 2021 15:17:12 +0100
Message-Id: <20210303141716.29223-2-joro@8bytes.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303141716.29223-1-joro@8bytes.org>
References: <20210303141716.29223-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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

Introduce a helper to check whether an exception came from the syscall
gap and use it in the SEV-ES code. Extend the check to also cover the
compatibility SYSCALL entry path.

Fixes: 315562c9af3d5 ("x86/sev-es: Adjust #VC IST Stack on entering NMI handler")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_64_compat.S |  2 ++
 arch/x86/include/asm/proto.h     |  1 +
 arch/x86/include/asm/ptrace.h    | 15 +++++++++++++++
 arch/x86/kernel/traps.c          |  3 +--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 541fdaf64045..0051cf5c792d 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -210,6 +210,8 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	/* Switch to the kernel stack */
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
+SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
+
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
 	pushq	%r8			/* pt_regs->sp */
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 2c35f1c01a2d..b6a9d51d1d79 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -25,6 +25,7 @@ void __end_SYSENTER_singlestep_region(void);
 void entry_SYSENTER_compat(void);
 void __end_entry_SYSENTER_compat(void);
 void entry_SYSCALL_compat(void);
+void entry_SYSCALL_compat_safe_stack(void);
 void entry_INT80_compat(void);
 #ifdef CONFIG_XEN_PV
 void xen_entry_INT80_compat(void);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index d8324a236696..409f661481e1 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -94,6 +94,8 @@ struct pt_regs {
 #include <asm/paravirt_types.h>
 #endif
 
+#include <asm/proto.h>
+
 struct cpuinfo_x86;
 struct task_struct;
 
@@ -175,6 +177,19 @@ static inline bool any_64bit_mode(struct pt_regs *regs)
 #ifdef CONFIG_X86_64
 #define current_user_stack_pointer()	current_pt_regs()->sp
 #define compat_user_stack_pointer()	current_pt_regs()->sp
+
+static inline bool ip_within_syscall_gap(struct pt_regs *regs)
+{
+	bool ret = (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
+		    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack);
+
+#ifdef CONFIG_IA32_EMULATION
+	ret = ret || (regs->ip >= (unsigned long)entry_SYSCALL_compat &&
+		      regs->ip <  (unsigned long)entry_SYSCALL_compat_safe_stack);
+#endif
+
+	return ret;
+}
 #endif
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 7f5aec758f0e..ac1874a2a70e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -694,8 +694,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 	 * In the SYSCALL entry path the RSP value comes from user-space - don't
 	 * trust it and switch to the current kernel stack
 	 */
-	if (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
-	    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack) {
+	if (ip_within_syscall_gap(regs)) {
 		sp = this_cpu_read(cpu_current_top_of_stack);
 		goto sync;
 	}
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
