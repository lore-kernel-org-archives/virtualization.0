Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E76C2BBCA
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 09:32:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8342388E
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 09:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8342388E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60F3D87A5C;
	Thu, 17 Dec 2020 09:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDUgFYUK5ZqK; Thu, 17 Dec 2020 09:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A94BF87A71;
	Thu, 17 Dec 2020 09:31:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93C66C1DA3;
	Thu, 17 Dec 2020 09:31:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF4B3C088E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D83AF8755D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id umKAYR1IpiX3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DE92087559
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1608197510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Z31sgETFoAxIEzI7xHzoYozsFHKuujs94Hp62Q7FRA=;
 b=X/y9Q2eBf8HFFDZkyWg/27vZR0RcyGn9FEAFW7zZqaU+Q0iEgrwssEbeEmRqe0nf+utKs9
 entG7+GEZi0QUf/vnNUbp5QkeEXLFeCqUOWnk2dwv55kG7VRoldm2ADmjnfnRPSGJoKZh+
 5ecW8L5SqqsF7vzhfZWwGCCG5E5aCGQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 78760B723;
 Thu, 17 Dec 2020 09:31:50 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] x86/paravirt: have only one paravirt patch function
Date: Thu, 17 Dec 2020 10:31:33 +0100
Message-Id: <20201217093133.1507-16-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217093133.1507-1-jgross@suse.com>
References: <20201217093133.1507-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

There is no need any longer to have different paravirt patch functions
for native and Xen. Eliminate native_patch() and rename
paravirt_patch_default() to paravirt_patch().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- remove paravirt_patch_insns() (kernel test robot)
---
 arch/x86/include/asm/paravirt_types.h | 19 +------------------
 arch/x86/kernel/Makefile              |  3 +--
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/paravirt.c            | 20 ++------------------
 arch/x86/kernel/paravirt_patch.c      | 11 -----------
 arch/x86/xen/enlighten_pv.c           |  1 -
 6 files changed, 5 insertions(+), 51 deletions(-)
 delete mode 100644 arch/x86/kernel/paravirt_patch.c

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f9e77046b61b..5c728eab9cd1 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -73,19 +73,6 @@ struct pv_info {
 	const char *name;
 };
 
-struct pv_init_ops {
-	/*
-	 * Patch may replace one of the defined code sequences with
-	 * arbitrary code, subject to the same register constraints.
-	 * This generally means the code is not free to clobber any
-	 * registers other than EAX.  The patch function should return
-	 * the number of bytes of code generated, as we nop pad the
-	 * rest in generic code.
-	 */
-	unsigned (*patch)(u8 type, void *insn_buff,
-			  unsigned long addr, unsigned len);
-} __no_randomize_layout;
-
 #ifdef CONFIG_PARAVIRT_XXL
 struct pv_lazy_ops {
 	/* Set deferred update mode, used for batching operations. */
@@ -281,7 +268,6 @@ struct pv_lock_ops {
  * number for each function using the offset which we use to indicate
  * what to patch. */
 struct paravirt_patch_template {
-	struct pv_init_ops	init;
 	struct pv_cpu_ops	cpu;
 	struct pv_irq_ops	irq;
 	struct pv_mmu_ops	mmu;
@@ -322,10 +308,7 @@ extern void (*paravirt_iret)(void);
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
 
-unsigned paravirt_patch_default(u8 type, void *insn_buff, unsigned long addr, unsigned len);
-unsigned paravirt_patch_insns(void *insn_buff, unsigned len, const char *start, const char *end);
-
-unsigned native_patch(u8 type, void *insn_buff, unsigned long addr, unsigned len);
+unsigned paravirt_patch(u8 type, void *insn_buff, unsigned long addr, unsigned len);
 
 int paravirt_disable_iospace(void);
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 68608bd892c0..61f52f95670b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -35,7 +35,6 @@ KASAN_SANITIZE_sev-es.o					:= n
 KCSAN_SANITIZE := n
 
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
-OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
 
 ifdef CONFIG_FRAME_POINTER
 OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
@@ -122,7 +121,7 @@ obj-$(CONFIG_AMD_NB)		+= amd_nb.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
 
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvmclock.o
-obj-$(CONFIG_PARAVIRT)		+= paravirt.o paravirt_patch.o
+obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index abb481808811..1dbd6a934b66 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -621,7 +621,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
 		memcpy(insn_buff, p->instr, p->len);
-		used = pv_ops.init.patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
+		used = paravirt_patch(p->type, insn_buff, (unsigned long)p->instr, p->len);
 
 		BUG_ON(used > p->len);
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index db6ae7f7c14e..b648eaf640f2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -99,8 +99,8 @@ void __init native_pv_lock_init(void)
 		static_branch_disable(&virt_spin_lock_key);
 }
 
-unsigned paravirt_patch_default(u8 type, void *insn_buff,
-				unsigned long addr, unsigned len)
+unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
+			    unsigned int len)
 {
 	/*
 	 * Neat trick to map patch type back to the call within the
@@ -121,19 +121,6 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	return ret;
 }
 
-unsigned paravirt_patch_insns(void *insn_buff, unsigned len,
-			      const char *start, const char *end)
-{
-	unsigned insn_len = end - start;
-
-	/* Alternative instruction is too large for the patch site and we cannot continue: */
-	BUG_ON(insn_len > len || start == NULL);
-
-	memcpy(insn_buff, start, insn_len);
-
-	return insn_len;
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -255,9 +242,6 @@ struct pv_info pv_info = {
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
 
 struct paravirt_patch_template pv_ops = {
-	/* Init ops. */
-	.init.patch		= native_patch,
-
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
 
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
deleted file mode 100644
index 10543dcc8211..000000000000
--- a/arch/x86/kernel/paravirt_patch.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/stringify.h>
-
-#include <asm/paravirt.h>
-#include <asm/asm-offsets.h>
-
-unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
-			  unsigned int len)
-{
-	return paravirt_patch_default(type, insn_buff, addr, len);
-}
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 4716383c64a9..66f83de4d9e0 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1218,7 +1218,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	pv_ops.init.patch = paravirt_patch_default;
 	pv_ops.cpu = xen_cpu_ops;
 	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
