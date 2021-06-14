Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D2EC2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 16:25:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4797613DC
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 16:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4797613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BB3C40189;
	Mon, 14 Jun 2021 16:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MKx1AwX6eQ3L; Mon, 14 Jun 2021 16:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01DFF400C3;
	Mon, 14 Jun 2021 16:25:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C80ABC000E;
	Mon, 14 Jun 2021 16:25:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD42EC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 16:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF045400C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 16:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BEJCd72dxol3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 16:25:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2712C40189
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 16:25:29 +0000 (UTC)
Received: from zn.tnic (p200300ec2f09b900f41fb76786649a77.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f09:b900:f41f:b767:8664:9a77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6540E1EC04AD;
 Mon, 14 Jun 2021 18:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1623687926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=SsxVz2r5oN4lnCyZbTvn/5Zz+6zt1F06cejR2VGMXJg=;
 b=Vo00EAKNgD7AFNhgm49YEDwGuLn98ZSZ2j4ts2lt7+AjJGooEdju5hgyyfWHl+5RkB+ies
 mAsS/wthE7dX6kaEIBjy5kLOKZGp78o+BTNok/EvMkb6G0Ct7BpVv3LyJC/49oT7fv2OlA
 CR5GJZWqXsOypS7uRrIX879uLLHqvmc=
Date: Mon, 14 Jun 2021 18:25:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 2/6] x86/sev-es: Make sure IRQs are disabled while
 GHCB is active
Message-ID: <YMeC7vJxm0OVJJhr@zn.tnic>
References: <20210614135327.9921-1-joro@8bytes.org>
 <20210614135327.9921-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210614135327.9921-3-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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

On Mon, Jun 14, 2021 at 03:53:23PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The #VC handler only cares about IRQs being disabled while the GHCB is
> active, as it must not be interrupted by something which could cause
> another #VC while it holds the GHCB (NMI is the exception for which the
> backup GHCB exits).
> 
> Make sure nothing interrupts the code path while the GHCB is active by
> disabling IRQs in sev_es_get_ghcb() and restoring the previous irq state
> in sev_es_put_ghcb().
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/sev.c | 48 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 14 deletions(-)

Here's a diff ontop of yours with a couple of points:

* I've named the low-level, interrupts-enabled workers
__sev_get_ghcb()/__sev_put_ghcb() to mean a couple of things:

** underscored to mean, that callers need to disable local locks. There's
also a lockdep_assert_irqs_disabled() to make sure, both in the get and
put function.

** also only "sev" in the name because this code is not used for SEV-ES
only anymore.

* I've done it this way because you have a well-recognized code pattern
where the caller disables interrupts, calls the low-level helpers and
then enables interrupts again when done. VS passing a flags pointer back
and forth which just looks weird.

And as to being easy to use - users can botch flags too, when passing
around so they can just as well do proper interrupts toggling like a
gazillion other places in the kernel.

Also, you have places like exc_vmm_communication() where you have
to artifically pass in flags - I'm looking at your previous version
- even if you already make sure interrupts are disabled with the
BUG_ON assertion on entry. So in those cases you can simply call the
interrupt-enabled, __-variants.

Btw, while we're on exc_vmm_communication, it has a:

	BUG_ON(!irqs_disabled());

on entry and then later

	lockdep_assert_irqs_disabled();

and that second assertion is not really needed, methinks. So a hunk
below removes it.

Thoughts?

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7d70cddc38be..b85c4a2be9fa 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -192,11 +192,19 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-static __always_inline struct ghcb *__sev_es_get_ghcb(struct ghcb_state *state)
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static __always_inline struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
 	struct ghcb *ghcb;
 
+	lockdep_assert_irqs_disabled();
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -231,18 +239,6 @@ static __always_inline struct ghcb *__sev_es_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state,
-						    unsigned long *flags)
-{
-	/*
-	 * Nothing shall interrupt this code path while holding the per-cpu
-	 * GHCB. The backup GHCB is only for NMIs interrupting this path.
-	 */
-	local_irq_save(*flags);
-
-	return __sev_es_get_ghcb(state);
-}
-
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -491,11 +487,13 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
-static __always_inline void __sev_es_put_ghcb(struct ghcb_state *state)
+static __always_inline void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
 	struct ghcb *ghcb;
 
+	lockdep_assert_irqs_disabled();
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -514,13 +512,6 @@ static __always_inline void __sev_es_put_ghcb(struct ghcb_state *state)
 	}
 }
 
-static __always_inline void sev_es_put_ghcb(struct ghcb_state *state,
-					    unsigned long flags)
-{
-	__sev_es_put_ghcb(state);
-	local_irq_restore(flags);
-}
-
 void noinstr __sev_es_nmi_complete(void)
 {
 	struct ghcb_state state;
@@ -528,7 +519,7 @@ void noinstr __sev_es_nmi_complete(void)
 
 	BUG_ON(!irqs_disabled());
 
-	ghcb = __sev_es_get_ghcb(&state);
+	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
@@ -538,7 +529,7 @@ void noinstr __sev_es_nmi_complete(void)
 	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
 	VMGEXIT();
 
-	__sev_es_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 }
 
 static u64 get_jump_table_addr(void)
@@ -548,7 +539,9 @@ static u64 get_jump_table_addr(void)
 	struct ghcb *ghcb;
 	u64 ret = 0;
 
-	ghcb = sev_es_get_ghcb(&state, &flags);
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
@@ -562,7 +555,9 @@ static u64 get_jump_table_addr(void)
 	    ghcb_sw_exit_info_2_is_valid(ghcb))
 		ret = ghcb->save.sw_exit_info_2;
 
-	sev_es_put_ghcb(&state, flags);
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
 
 	return ret;
 }
@@ -686,7 +681,9 @@ static void sev_es_ap_hlt_loop(void)
 	unsigned long flags;
 	struct ghcb *ghcb;
 
-	ghcb = sev_es_get_ghcb(&state, &flags);
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
 
 	while (true) {
 		vc_ghcb_invalidate(ghcb);
@@ -703,7 +700,9 @@ static void sev_es_ap_hlt_loop(void)
 			break;
 	}
 
-	sev_es_put_ghcb(&state, flags);
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
 }
 
 /*
@@ -1364,7 +1363,6 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	}
 
 	irq_state = irqentry_nmi_enter(regs);
-	lockdep_assert_irqs_disabled();
 	instrumentation_begin();
 
 	/*
@@ -1373,7 +1371,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	 * keep the IRQs disabled to protect us against concurrent TLB flushes.
 	 */
 
-	ghcb = __sev_es_get_ghcb(&state);
+	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, error_code);
@@ -1381,7 +1379,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	if (result == ES_OK)
 		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
 
-	__sev_es_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 
 	/* Done - now check the result */
 	switch (result) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
