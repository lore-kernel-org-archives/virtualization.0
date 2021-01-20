Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A486C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:26:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798022339D
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798022339D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A769285F85;
	Wed, 20 Jan 2021 13:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2RwuwTl9EpT; Wed, 20 Jan 2021 13:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8F5785F54;
	Wed, 20 Jan 2021 13:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC221C1DA7;
	Wed, 20 Jan 2021 13:26:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7DFEC088B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93CE485F33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TehqqmDWYu5W
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B448985F35
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:26:17 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611149175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/muUWGGP2zH35/xgppym3fqM4u0SphD3mtIprEyxGx4=;
 b=bir2fSzmSCDfO6mm6ZenXCRZlY085K4FjHCdV8lt5Kr+VNwBBj7tYwFBSgg7pmc55Lx5jj
 r+8Hx68nGxHRMtVqOUcYysvLB7b2syi5sNYIdfFooWHiVSCxqQelgVijKlzpY+PZftpznJ
 Qh8Xv99gC/8hce6GTX8P6uMDb136lt8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 41498AEE0;
 Wed, 20 Jan 2021 13:26:15 +0000 (UTC)
To: bpetkov@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v4 09/15] x86: add new features for paravirt patching
Date: Wed, 20 Jan 2021 14:26:07 +0100
Message-Id: <20210120132613.31487-10-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120132613.31487-1-jgross@suse.com>
References: <20210120132613.31487-1-jgross@suse.com>
MIME-Version: 1.0
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

For being able to switch paravirt patching from special cased custom
code sequences to ALTERNATIVE handling some X86_FEATURE_* are needed
as new features. This enables to have the standard indirect pv call
as the default code and to patch that with the non-Xen custom code
sequence via ALTERNATIVE patching later.

Make sure paravirt patching is performed before alternative patching.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- add comment (Boris Petkov)
- no negative features (Boris Petkov)

V4:
- move paravirt_set_cap() to paravirt-spinlocks.c
---
 arch/x86/include/asm/cpufeatures.h   |  2 ++
 arch/x86/include/asm/paravirt.h      | 10 ++++++++++
 arch/x86/kernel/alternative.c        | 30 ++++++++++++++++++++++++++--
 arch/x86/kernel/paravirt-spinlocks.c |  9 +++++++++
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 84b887825f12..3ae8944b253a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -238,6 +238,8 @@
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 #define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualization - Encrypted State */
 #define X86_FEATURE_VM_PAGE_FLUSH	( 8*32+21) /* "" VM Page Flush MSR is supported */
+#define X86_FEATURE_PVUNLOCK		( 8*32+22) /* "" PV unlock function */
+#define X86_FEATURE_VCPUPREEMPT		( 8*32+23) /* "" PV vcpu_is_preempted function */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1e45b46fae84..8c354099d9c3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -47,6 +47,10 @@ static inline u64 paravirt_steal_clock(int cpu)
 	return static_call(pv_steal_clock)(cpu);
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+void __init paravirt_set_cap(void);
+#endif
+
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
@@ -811,5 +815,11 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 }
 #endif
+
+#ifndef CONFIG_PARAVIRT_SPINLOCKS
+static inline void paravirt_set_cap(void)
+{
+}
+#endif
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0a904fb2678b..221acb2b868a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -28,6 +28,7 @@
 #include <asm/insn.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
+#include <asm/paravirt.h>
 
 int __read_mostly alternatives_patched;
 
@@ -730,6 +731,33 @@ void __init alternative_instructions(void)
 	 * patching.
 	 */
 
+	/*
+	 * Paravirt patching and alternative patching can be combined to
+	 * replace a function call with a short direct code sequence (e.g.
+	 * by setting a constant return value instead of doing that in an
+	 * external function).
+	 * In order to make this work the following sequence is required:
+	 * 1. set (artificial) features depending on used paravirt
+	 *    functions which can later influence alternative patching
+	 * 2. apply paravirt patching (generally replacing an indirect
+	 *    function call with a direct one)
+	 * 3. apply alternative patching (e.g. replacing a direct function
+	 *    call with a custom code sequence)
+	 * Doing paravirt patching after alternative patching would clobber
+	 * the optimization of the custom code with a function call again.
+	 */
+	paravirt_set_cap();
+
+	/*
+	 * First patch paravirt functions, such that we overwrite the indirect
+	 * call with the direct call.
+	 */
+	apply_paravirt(__parainstructions, __parainstructions_end);
+
+	/*
+	 * Then patch alternatives, such that those paravirt calls that are in
+	 * alternatives can be overwritten by their immediate fragments.
+	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 #ifdef CONFIG_SMP
@@ -748,8 +776,6 @@ void __init alternative_instructions(void)
 	}
 #endif
 
-	apply_paravirt(__parainstructions, __parainstructions_end);
-
 	restart_nmi();
 	alternatives_patched = 1;
 }
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 4f75d0cf6305..9e1ea99ad9df 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -32,3 +32,12 @@ bool pv_is_native_vcpu_is_preempted(void)
 	return pv_ops.lock.vcpu_is_preempted.func ==
 		__raw_callee_save___native_vcpu_is_preempted;
 }
+
+void __init paravirt_set_cap(void)
+{
+	if (!pv_is_native_spin_unlock())
+		setup_force_cpu_cap(X86_FEATURE_PVUNLOCK);
+
+	if (!pv_is_native_vcpu_is_preempted())
+		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
+}
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
