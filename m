Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DF4C433FE
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 07:28:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDFE604AC
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEDFE604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2D3A825BF;
	Thu, 28 Oct 2021 07:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAvNAxw4nJVC; Thu, 28 Oct 2021 07:28:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D4218258A;
	Thu, 28 Oct 2021 07:28:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16566C0019;
	Thu, 28 Oct 2021 07:28:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13A08C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 07:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E01ED40157
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 07:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FXFZdtYpXWaV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 07:27:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7EE5400F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 07:27:58 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68ADB21967;
 Thu, 28 Oct 2021 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1635406076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggMgRCzUrgVk3/nbGHlSVTwAJfT38iDHULHtl55v/o8=;
 b=L+hv7qAjrtmHYTJ8VoWW7a/cmADpjn9JUa+yjIIp8HlLmnZVXHLcZHpgdATMNLaxfScin7
 eTxF6U3n9v2kka9NS4TuR31Zc2y4baK1ldiDDkiidpC1V7KxUJ3PibOnOsjl7eYQNoMpUP
 6PXws49K+zxxzYg50k1WwNhWqNMKcY0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D40313ABD;
 Thu, 28 Oct 2021 07:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UAr+AfxQemEmGwAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 28 Oct 2021 07:27:56 +0000
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86/xen: switch initial pvops IRQ functions to dummy
 ones
Date: Thu, 28 Oct 2021 09:27:48 +0200
Message-Id: <20211028072748.29862-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211028072748.29862-1-jgross@suse.com>
References: <20211028072748.29862-1-jgross@suse.com>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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

So switch them to be dummy functions:
- xen_save_fl() can always return 0
- xen_irq_disable() is a nop
- xen_irq_enable() can BUG()

Add some generic paravirt functions for that purpose.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
V3:
- make paravirt_BUG() noinstr
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
index 04cafc057bed..b44814dfe83f 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -46,6 +46,17 @@ asm (".pushsection .entry.text, \"ax\"\n"
      ".type _paravirt_nop, @function\n\t"
      ".popsection");
 
+/* stub always returning 0. */
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
+noinstr void paravirt_BUG(void)
 {
 	BUG();
 }
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 006b4a814fac..30c6e986a6cd 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -31,25 +31,10 @@ EXPORT_SYMBOL_GPL(hypercall_page);
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
