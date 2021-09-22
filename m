Return-Path: <SRS0=qgkY=OM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A269AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 10:31:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279926124A
	for <virtualization@archiver.kernel.org>; Wed, 22 Sep 2021 10:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 279926124A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D116A407AD;
	Wed, 22 Sep 2021 10:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wZg5BbAsjfC; Wed, 22 Sep 2021 10:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6984D407D7;
	Wed, 22 Sep 2021 10:31:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2833DC0011;
	Wed, 22 Sep 2021 10:31:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9795FC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 10:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 75BD5400AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 10:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQqrdu9Dh_VB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 10:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 514B2404F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 10:31:10 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C57DC201E0;
 Wed, 22 Sep 2021 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1632306667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86firgN1jlIPP55LKir2kex+Qi/Crgc5F8hTbnkpj2U=;
 b=kZGArRO73g3w8z8IReMclRkOaaUnVYe0ECsdBZfUOlFhmaUZHgqupIR64JXeM1AHaQXDsA
 CijKASyMoETKc7tdXh1H8YtbxRn7zNVjB1cwhvD/ldCJZSZDDhSIuExXIGRBBu3MMqWqB4
 WjQ9ub50sn99ss24Wydkqxj9LgIgvOY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EEA813D69;
 Wed, 22 Sep 2021 10:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gNPdGesFS2GHWAAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 22 Sep 2021 10:31:07 +0000
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/xen: switch initial pvops IRQ functions to dummy
 ones
Date: Wed, 22 Sep 2021 12:31:02 +0200
Message-Id: <20210922103102.3589-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210922103102.3589-1-jgross@suse.com>
References: <20210922103102.3589-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, peterz@infradead.org, "VMware,
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

The initial pvops functions handling irq flags will only ever be called
before interrupts are being enabled.

So make the __init and switch them to be dummy functions:
- xen_save_fl() can always return 0
- xen_irq_disable() is a nop
- xen_irq_enable() can BUG()

Add some generic paravirt functions for that purpose.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h |  2 +
 arch/x86/kernel/paravirt.c            | 13 +++++-
 arch/x86/xen/enlighten.c              | 19 +--------
 arch/x86/xen/irq.c                    | 61 ++-------------------------
 4 files changed, 20 insertions(+), 75 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index d9d6b0203ec4..fc1151e77569 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -577,7 +577,9 @@ void paravirt_leave_lazy_mmu(void);
 void paravirt_flush_lazy_mmu(void);
 
 void _paravirt_nop(void);
+void paravirt_BUG(void);
 u64 _paravirt_ident_64(u64);
+unsigned long paravirt_ret0(void);
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 04cafc057bed..4f0ebc46a15d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -46,6 +46,17 @@ asm (".pushsection .entry.text, \"ax\"\n"
      ".type _paravirt_nop, @function\n\t"
      ".popsection");
 
+/* stub always return ing 0. */
+asm (".pushsection .entry.text, \"ax\"\n"
+     ".global paravirt_ret0\n"
+     "paravirt_ret0:\n\t"
+     "xor %" _ASM_AX ", %" _ASM_AX ";\n\t"
+     "ret\n\t"
+     ".size paravirt_ret0, . - paravirt_ret0\n\t"
+     ".type paravirt_ret0, @function\n\t"
+     ".popsection");
+
+
 void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
@@ -53,7 +64,7 @@ void __init default_banner(void)
 }
 
 /* Undefined instruction for dealing with missing ops pointers. */
-static void paravirt_BUG(void)
+void paravirt_BUG(void)
 {
 	BUG();
 }
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 8a7bd3f4591e..d96cabe34a01 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -27,25 +27,10 @@ EXPORT_SYMBOL_GPL(hypercall_page);
  * Pointer to the xen_vcpu_info structure or
  * &HYPERVISOR_shared_info->vcpu_info[cpu]. See xen_hvm_init_shared_info
  * and xen_vcpu_setup for details. By default it points to share_info->vcpu_info
- * but if the hypervisor supports VCPUOP_register_vcpu_info then it can point
- * to xen_vcpu_info. The pointer is used in __xen_evtchn_do_upcall to
- * acknowledge pending events.
- * Also more subtly it is used by the patched version of irq enable/disable
- * e.g. xen_irq_enable_direct and xen_iret in PV mode.
- *
- * The desire to be able to do those mask/unmask operations as a single
- * instruction by using the per-cpu offset held in %gs is the real reason
- * vcpu info is in a per-cpu pointer and the original reason for this
- * hypercall.
- *
+ * but during boot it is switched to point to xen_vcpu_info.
+ * The pointer is used in __xen_evtchn_do_upcall to acknowledge pending events.
  */
 DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
-
-/*
- * Per CPU pages used if hypervisor supports VCPUOP_register_vcpu_info
- * hypercall. This can be used both in PV and PVHVM mode. The structure
- * overrides the default per_cpu(xen_vcpu, cpu) value.
- */
 DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
 
 /* Linux <-> Xen vCPU id mapping */
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index dfa091d79c2e..ae8537583102 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -24,60 +24,6 @@ void xen_force_evtchn_callback(void)
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
 
-asmlinkage __visible unsigned long xen_save_fl(void)
-{
-	struct vcpu_info *vcpu;
-	unsigned long flags;
-
-	vcpu = this_cpu_read(xen_vcpu);
-
-	/* flag has opposite sense of mask */
-	flags = !vcpu->evtchn_upcall_mask;
-
-	/* convert to IF type flag
-	   -0 -> 0x00000000
-	   -1 -> 0xffffffff
-	*/
-	return (-flags) & X86_EFLAGS_IF;
-}
-PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
-
-asmlinkage __visible void xen_irq_disable(void)
-{
-	/* There's a one instruction preempt window here.  We need to
-	   make sure we're don't switch CPUs between getting the vcpu
-	   pointer and updating the mask. */
-	preempt_disable();
-	this_cpu_read(xen_vcpu)->evtchn_upcall_mask = 1;
-	preempt_enable_no_resched();
-}
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
-
-asmlinkage __visible void xen_irq_enable(void)
-{
-	struct vcpu_info *vcpu;
-
-	/*
-	 * We may be preempted as soon as vcpu->evtchn_upcall_mask is
-	 * cleared, so disable preemption to ensure we check for
-	 * events on the VCPU we are still running on.
-	 */
-	preempt_disable();
-
-	vcpu = this_cpu_read(xen_vcpu);
-	vcpu->evtchn_upcall_mask = 0;
-
-	/* Doesn't matter if we get preempted here, because any
-	   pending event will get dealt with anyway. */
-
-	barrier(); /* unmask then check (avoid races) */
-	if (unlikely(vcpu->evtchn_upcall_pending))
-		xen_force_evtchn_callback();
-
-	preempt_enable();
-}
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
-
 static void xen_safe_halt(void)
 {
 	/* Blocking includes an implicit local_irq_enable(). */
@@ -95,9 +41,10 @@ static void xen_halt(void)
 }
 
 static const struct pv_irq_ops xen_irq_ops __initconst = {
-	.save_fl = PV_CALLEE_SAVE(xen_save_fl),
-	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
-	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
+	/* Initial interrupt flag handling only called while interrupts off. */
+	.save_fl = __PV_IS_CALLEE_SAVE(paravirt_ret0),
+	.irq_disable = __PV_IS_CALLEE_SAVE(paravirt_nop),
+	.irq_enable = __PV_IS_CALLEE_SAVE(paravirt_BUG),
 
 	.safe_halt = xen_safe_halt,
 	.halt = xen_halt,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
