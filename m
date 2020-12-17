Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA2DC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 09:31:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DED23602
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DED23602
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C156A87A4A;
	Thu, 17 Dec 2020 09:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emWg2OU20IlY; Thu, 17 Dec 2020 09:31:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E99FB87A3C;
	Thu, 17 Dec 2020 09:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2805C1DA4;
	Thu, 17 Dec 2020 09:31:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3A4FC013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B9B6A87A42
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCJ+rihCG4ym
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C8DDD87A43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 09:31:48 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1608197507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWa8LXJtPmdrGF/SU7ngKGgWKwsy52HIQIMfyyd743k=;
 b=XV18fU5jObgxzak0SuEa4O/Fu1W4msBVPVw+I4RyV0+x/g1FB+E24MhDfSXhUgrLBHkP54
 7+VaG4EuQrH0C1QUt62IfclRgOMOUQEy2sf66NMiRuMKbqj7u6FJ1SeSNZ+V1TQCeZlso+
 HwYGPxsv9e3fr+FOrK2wvuezZi6Mu9Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 45CAFB717;
 Thu, 17 Dec 2020 09:31:47 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v3 05/15] x86: rework arch_local_irq_restore() to not use popf
Date: Thu, 17 Dec 2020 10:31:23 +0100
Message-Id: <20201217093133.1507-6-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201217093133.1507-1-jgross@suse.com>
References: <20201217093133.1507-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
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

"popf" is a rather expensive operation, so don't use it for restoring
irq flags. Instead test whether interrupts are enabled in the flags
parameter and enable interrupts via "sti" in that case.

This results in the restore_fl paravirt op to be no longer needed.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/irqflags.h       | 20 ++++++-------------
 arch/x86/include/asm/paravirt.h       |  5 -----
 arch/x86/include/asm/paravirt_types.h |  7 ++-----
 arch/x86/kernel/irqflags.S            | 11 -----------
 arch/x86/kernel/paravirt.c            |  1 -
 arch/x86/kernel/paravirt_patch.c      |  3 ---
 arch/x86/xen/enlighten_pv.c           |  2 --
 arch/x86/xen/irq.c                    | 23 ----------------------
 arch/x86/xen/xen-asm.S                | 28 ---------------------------
 arch/x86/xen/xen-ops.h                |  1 -
 10 files changed, 8 insertions(+), 93 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index e585a4705b8d..144d70ea4393 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -35,15 +35,6 @@ extern __always_inline unsigned long native_save_fl(void)
 	return flags;
 }
 
-extern inline void native_restore_fl(unsigned long flags);
-extern inline void native_restore_fl(unsigned long flags)
-{
-	asm volatile("push %0 ; popf"
-		     : /* no output */
-		     :"g" (flags)
-		     :"memory", "cc");
-}
-
 static __always_inline void native_irq_disable(void)
 {
 	asm volatile("cli": : :"memory");
@@ -79,11 +70,6 @@ static __always_inline unsigned long arch_local_save_flags(void)
 	return native_save_fl();
 }
 
-static __always_inline void arch_local_irq_restore(unsigned long flags)
-{
-	native_restore_fl(flags);
-}
-
 static __always_inline void arch_local_irq_disable(void)
 {
 	native_irq_disable();
@@ -152,6 +138,12 @@ static __always_inline int arch_irqs_disabled(void)
 
 	return arch_irqs_disabled_flags(flags);
 }
+
+static __always_inline void arch_local_irq_restore(unsigned long flags)
+{
+	if (!arch_irqs_disabled_flags(flags))
+		arch_local_irq_enable();
+}
 #else
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dd43b1100a87..4abf110e2243 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -648,11 +648,6 @@ static inline notrace unsigned long arch_local_save_flags(void)
 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
 }
 
-static inline notrace void arch_local_irq_restore(unsigned long f)
-{
-	PVOP_VCALLEE1(irq.restore_fl, f);
-}
-
 static inline notrace void arch_local_irq_disable(void)
 {
 	PVOP_VCALLEE0(irq.irq_disable);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0169365f1403..de87087d3bde 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -168,16 +168,13 @@ struct pv_cpu_ops {
 struct pv_irq_ops {
 #ifdef CONFIG_PARAVIRT_XXL
 	/*
-	 * Get/set interrupt state.  save_fl and restore_fl are only
-	 * expected to use X86_EFLAGS_IF; all other bits
-	 * returned from save_fl are undefined, and may be ignored by
-	 * restore_fl.
+	 * Get/set interrupt state.  save_fl is expected to use X86_EFLAGS_IF;
+	 * all other bits returned from save_fl are undefined.
 	 *
 	 * NOTE: These functions callers expect the callee to preserve
 	 * more registers than the standard C calling convention.
 	 */
 	struct paravirt_callee_save save_fl;
-	struct paravirt_callee_save restore_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
 
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index 0db0375235b4..8ef35063964b 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -13,14 +13,3 @@ SYM_FUNC_START(native_save_fl)
 	ret
 SYM_FUNC_END(native_save_fl)
 EXPORT_SYMBOL(native_save_fl)
-
-/*
- * void native_restore_fl(unsigned long flags)
- * %eax/%rdi: flags
- */
-SYM_FUNC_START(native_restore_fl)
-	push %_ASM_ARG1
-	popf
-	ret
-SYM_FUNC_END(native_restore_fl)
-EXPORT_SYMBOL(native_restore_fl)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 18560b71e717..c60222ab8ab9 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -320,7 +320,6 @@ struct paravirt_patch_template pv_ops = {
 
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
-	.irq.restore_fl		= __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 2fada2c347c9..abd27ec67397 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -25,7 +25,6 @@ struct patch_xxl {
 	const unsigned char	mmu_read_cr2[3];
 	const unsigned char	mmu_read_cr3[3];
 	const unsigned char	mmu_write_cr3[3];
-	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	mov64[3];
 };
@@ -37,7 +36,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
 	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
-	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
@@ -71,7 +69,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	switch (type) {
 
 #ifdef CONFIG_PARAVIRT_XXL
-	PATCH_CASE(irq, restore_fl, xxl, insn_buff, len);
 	PATCH_CASE(irq, save_fl, xxl, insn_buff, len);
 	PATCH_CASE(irq, irq_enable, xxl, insn_buff, len);
 	PATCH_CASE(irq, irq_disable, xxl, insn_buff, len);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5476423fc6d0..32b295cc2716 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1022,8 +1022,6 @@ void __init xen_setup_vcpu_info_placement(void)
 	 */
 	if (xen_have_vcpu_info_placement) {
 		pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
-		pv_ops.irq.restore_fl =
-			__PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
 		pv_ops.irq.irq_disable =
 			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_ops.irq.irq_enable =
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 850c93f346c7..dfa091d79c2e 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -42,28 +42,6 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
 
-__visible void xen_restore_fl(unsigned long flags)
-{
-	struct vcpu_info *vcpu;
-
-	/* convert from IF type flag */
-	flags = !(flags & X86_EFLAGS_IF);
-
-	/* See xen_irq_enable() for why preemption must be disabled. */
-	preempt_disable();
-	vcpu = this_cpu_read(xen_vcpu);
-	vcpu->evtchn_upcall_mask = flags;
-
-	if (flags == 0) {
-		barrier(); /* unmask then check (avoid races) */
-		if (unlikely(vcpu->evtchn_upcall_pending))
-			xen_force_evtchn_callback();
-		preempt_enable();
-	} else
-		preempt_enable_no_resched();
-}
-PV_CALLEE_SAVE_REGS_THUNK(xen_restore_fl);
-
 asmlinkage __visible void xen_irq_disable(void)
 {
 	/* There's a one instruction preempt window here.  We need to
@@ -118,7 +96,6 @@ static void xen_halt(void)
 
 static const struct pv_irq_ops xen_irq_ops __initconst = {
 	.save_fl = PV_CALLEE_SAVE(xen_save_fl),
-	.restore_fl = PV_CALLEE_SAVE(xen_restore_fl),
 	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
 	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
 
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index c0630fd9f44e..1ea7e41044b5 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -72,34 +72,6 @@ SYM_FUNC_START(xen_save_fl_direct)
 	ret
 SYM_FUNC_END(xen_save_fl_direct)
 
-
-/*
- * In principle the caller should be passing us a value return from
- * xen_save_fl_direct, but for robustness sake we test only the
- * X86_EFLAGS_IF flag rather than the whole byte. After setting the
- * interrupt mask state, it checks for unmasked pending events and
- * enters the hypervisor to get them delivered if so.
- */
-SYM_FUNC_START(xen_restore_fl_direct)
-	FRAME_BEGIN
-	testw $X86_EFLAGS_IF, %di
-	setz PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-	/*
-	 * Preempt here doesn't matter because that will deal with any
-	 * pending interrupts.  The pending check may end up being run
-	 * on the wrong CPU, but that doesn't hurt.
-	 */
-
-	/* check for unmasked and pending */
-	cmpw $0x0001, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
-	jnz 1f
-	call check_events
-1:
-	FRAME_END
-	ret
-SYM_FUNC_END(xen_restore_fl_direct)
-
-
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index b2fd80a01a36..8d7ec49a35fb 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -131,7 +131,6 @@ static inline void __init xen_efi_init(struct boot_params *boot_params)
 __visible void xen_irq_enable_direct(void);
 __visible void xen_irq_disable_direct(void);
 __visible unsigned long xen_save_fl_direct(void);
-__visible void xen_restore_fl_direct(unsigned long);
 
 __visible unsigned long xen_read_cr2(void);
 __visible unsigned long xen_read_cr2_direct(void);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
