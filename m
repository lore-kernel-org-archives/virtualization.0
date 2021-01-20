Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D59C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:56:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20031233EB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20031233EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34E0381A89;
	Wed, 20 Jan 2021 13:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4+ZfSTcNdo3X; Wed, 20 Jan 2021 13:56:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E3CB887113;
	Wed, 20 Jan 2021 13:56:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C45EBC088B;
	Wed, 20 Jan 2021 13:56:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62B33C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4825B85F87
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YA-ZBwricPPr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E286C85F7F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:56:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611150960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZVylN0TrlznWFey0UjP85iwRxueujMp7mhjZsmecT4=;
 b=MYswaDCB5fpzZeOaGqespPXJUzn8HebAYW0jo6f0m+i5goGiz4Xr4UQvUfD3Q+fMiguXKO
 DRxX9spAera3w9mkslanzNBCf/RidahtQLWlVnFbDOYhmjQnCrWgdh0cw8C4k6w6xPx4PR
 A18im91q3uTFq+KU5zPD1SICXwr26WA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7BF9AAEE0;
 Wed, 20 Jan 2021 13:56:00 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 04/15] x86/pv: switch SWAPGS to ALTERNATIVE
Date: Wed, 20 Jan 2021 14:55:44 +0100
Message-Id: <20210120135555.32594-5-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210120135555.32594-1-jgross@suse.com>
References: <20210120135555.32594-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
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

SWAPGS is used only for interrupts coming from user mode or for
returning to user mode. So there is no reason to use the PARAVIRT
framework, as it can easily be replaced by an ALTERNATIVE depending
on X86_FEATURE_XENPV.

There are several instances using the PV-aware SWAPGS macro in paths
which are never executed in a Xen PV guest. Replace those with the
plain swapgs instruction. For SWAPGS_UNSAFE_STACK the same applies.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S             | 10 +++++-----
 arch/x86/include/asm/irqflags.h       | 20 ++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 --------------------
 arch/x86/include/asm/paravirt_types.h |  2 --
 arch/x86/kernel/asm-offsets_64.c      |  1 -
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/kernel/paravirt_patch.c      |  3 ---
 arch/x86/xen/enlighten_pv.c           |  3 ---
 8 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad08703c4ad..a876204a73e0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -669,7 +669,7 @@ native_irq_return_ldt:
 	 */
 
 	pushq	%rdi				/* Stash user RDI */
-	SWAPGS					/* to kernel GS */
+	swapgs					/* to kernel GS */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi	/* to kernel CR3 */
 
 	movq	PER_CPU_VAR(espfix_waddr), %rdi
@@ -699,7 +699,7 @@ native_irq_return_ldt:
 	orq	PER_CPU_VAR(espfix_stack), %rax
 
 	SWITCH_TO_USER_CR3_STACK scratch_reg=%rdi
-	SWAPGS					/* to user GS */
+	swapgs					/* to user GS */
 	popq	%rdi				/* Restore user RDI */
 
 	movq	%rax, %rsp
@@ -943,7 +943,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	ret
 
 .Lparanoid_entry_swapgs:
-	SWAPGS
+	swapgs
 
 	/*
 	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
@@ -1001,7 +1001,7 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	jnz		restore_regs_and_return_to_kernel
 
 	/* We are returning to a context with user GSBASE */
-	SWAPGS_UNSAFE_STACK
+	swapgs
 	jmp		restore_regs_and_return_to_kernel
 SYM_CODE_END(paranoid_exit)
 
@@ -1426,7 +1426,7 @@ nmi_no_fsgsbase:
 	jnz	nmi_restore
 
 nmi_swapgs:
-	SWAPGS_UNSAFE_STACK
+	swapgs
 
 nmi_restore:
 	POP_REGS
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 2dfc8d380dab..8c86edefa115 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -131,18 +131,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #define SAVE_FLAGS(x)		pushfq; popq %rax
 #endif
 
-#define SWAPGS	swapgs
-/*
- * Currently paravirt can't handle swapgs nicely when we
- * don't have a stack we can rely on (such as a user space
- * stack).  So we either find a way around these or just fault
- * and emulate if a guest tries to call swapgs directly.
- *
- * Either way, this is a good way to document that we don't
- * have a reliable stack. x86_64 only.
- */
-#define SWAPGS_UNSAFE_STACK	swapgs
-
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
@@ -170,6 +158,14 @@ static __always_inline int arch_irqs_disabled(void)
 
 	return arch_irqs_disabled_flags(flags);
 }
+#else
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_XEN_PV
+#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
+#else
+#define SWAPGS	swapgs
+#endif
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f8dce11d2bc1..f2ebe109a37e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -776,26 +776,6 @@ extern void default_banner(void);
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
-/*
- * If swapgs is used while the userspace stack is still current,
- * there's no way to call a pvop.  The PV replacement *must* be
- * inlined, or the swapgs instruction must be trapped and emulated.
- */
-#define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(PV_CPU_swapgs), swapgs)
-
-/*
- * Note: swapgs is very special, and in practise is either going to be
- * implemented with a single "swapgs" instruction or something very
- * special.  Either way, we don't need to save any registers for
- * it.
- */
-#define SWAPGS								\
-	PARA_SITE(PARA_PATCH(PV_CPU_swapgs),				\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
-		 )
-
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b6b02b7c19cc..130f428b0cc8 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -168,8 +168,6 @@ struct pv_cpu_ops {
 	   frame set up. */
 	void (*iret)(void);
 
-	void (*swapgs)(void);
-
 	void (*start_context_switch)(struct task_struct *prev);
 	void (*end_context_switch)(struct task_struct *next);
 #endif
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 828be792231e..1354bc30614d 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -15,7 +15,6 @@ int main(void)
 #ifdef CONFIG_PARAVIRT_XXL
 	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
 	       cpu.usergs_sysret64);
-	OFFSET(PV_CPU_swapgs, paravirt_patch_template, cpu.swapgs);
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6c3407ba6ee9..5e5fcf5c376d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -312,7 +312,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.usergs_sysret64	= native_usergs_sysret64,
 	.cpu.iret		= native_iret,
-	.cpu.swapgs		= native_swapgs,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 	.cpu.invalidate_io_bitmap	= native_tss_invalidate_io_bitmap,
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index ace6e334cb39..7c518b08aa3c 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -28,7 +28,6 @@ struct patch_xxl {
 	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	cpu_usergs_sysret64[6];
-	const unsigned char	cpu_swapgs[3];
 	const unsigned char	mov64[3];
 };
 
@@ -43,7 +42,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
 	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
 				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
-	.cpu_swapgs		= { 0x0f, 0x01, 0xf8 },	// swapgs
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
 
@@ -86,7 +84,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
 
 	PATCH_CASE(cpu, usergs_sysret64, xxl, insn_buff, len);
-	PATCH_CASE(cpu, swapgs, xxl, insn_buff, len);
 	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
 #endif
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 76616024129e..44bb18adfb51 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1085,9 +1085,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 #endif
 	.io_delay = xen_io_delay,
 
-	/* Xen takes care of %gs when switching to usermode for us */
-	.swapgs = paravirt_nop,
-
 	.start_context_switch = paravirt_start_context_switch,
 	.end_context_switch = xen_end_context_switch,
 };
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
