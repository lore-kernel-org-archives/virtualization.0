Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9FC433E2
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 11:05:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6162072D
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 11:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k5OzW1/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6162072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5A9C864D7;
	Mon, 31 Aug 2020 11:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fz-hs1RcQcMa; Mon, 31 Aug 2020 11:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5CDB88583C;
	Mon, 31 Aug 2020 11:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AC7DC07FF;
	Mon, 31 Aug 2020 11:05:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 424B4C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 315A285BD3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kcjR5pLwSTVV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:05:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BDF3185BD0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:05:14 +0000 (UTC)
Received: from zn.tnic (p200300ec2f085000329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:5000:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E066A1EC03D2;
 Mon, 31 Aug 2020 13:05:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598871912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=UWhp3f9YxF2VMm1TSSMKQUkz2bSONkfaUSAxBdUgOxk=;
 b=k5OzW1/NI8KbRGxEcrXotZry45yEGl//5nMPTkaRBks0dcPHNxwjBC8KsJQMfcY9urmNfq
 INHp/tjubr1rjgpYgrgiPabVNSFsFXrRZlbdMRQEVP3dOZlRmKoqeqdMLFaoX+xadfQQUS
 zjWGPdiy0Xcm0ORa3M/qfT9X13azCLs=
Date: Mon, 31 Aug 2020 13:05:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 46/76] x86/sev-es: Adjust #VC IST Stack on entering
 NMI handler
Message-ID: <20200831110507.GF27517@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-47-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-47-joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>, Joerg Roedel <jroedel@suse.de>,
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

On Mon, Aug 24, 2020 at 10:54:41AM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 4fc9954a9560..951f098a4bf5 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -33,6 +33,7 @@
>  #include <asm/reboot.h>
>  #include <asm/cache.h>
>  #include <asm/nospec-branch.h>
> +#include <asm/sev-es.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/nmi.h>
> @@ -488,6 +489,9 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
>  	this_cpu_write(nmi_cr2, read_cr2());
>  nmi_restart:
>  
> +	/* Needs to happen before DR7 is accessed */

... because? Let's explain why.

> +	sev_es_ist_enter(regs);
> +
>  	this_cpu_write(nmi_dr7, local_db_save());
>  
>  	irq_state = idtentry_enter_nmi(regs);
> @@ -501,6 +505,8 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
>  
>  	local_db_restore(this_cpu_read(nmi_dr7));
>  
> +	sev_es_ist_exit();
> +
>  	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
>  		write_cr2(this_cpu_read(nmi_cr2));
>  	if (this_cpu_dec_return(nmi_state))
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 64002d86a237..95831d103418 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -52,6 +52,9 @@ struct sev_es_runtime_data {
>  
>  static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
>  
> +DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
> +EXPORT_SYMBOL_GPL(sev_es_enable_key);

So the GPL export is not needed. The key itself can be made static when
you uninline the sev_es_ist_enter/exit accessors as they're called only
in nmi.c but I guess Peter would object to that in high-NMI-load perf
scenarios...

The export looks unneeded tho.

> +
>  static void __init sev_es_setup_vc_stacks(int cpu)
>  {
>  	struct sev_es_runtime_data *data;
> @@ -73,6 +76,59 @@ static void __init sev_es_setup_vc_stacks(int cpu)
>  	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
>  }
>  
> +static __always_inline bool on_vc_stack(unsigned long sp)
> +{
> +	return ((sp >= __this_cpu_ist_bot_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
> +}
> +
> +/*
> + * This function handles the case when an NM is raised in the #VC exception

					     NMI

> + * handler entry code. In this case the IST entry for VC must be adjusted, so

"VC" or "#VC"? Choose one pls.

> + * that any subsequent VC exception will not overwrite the stack contents of the
> + * interrupted VC handler.
> + *
> + * The IST entry is adjusted unconditionally so that it can be also be
> + * unconditionally back-adjusted in sev_es_ist_exit(). Otherwise a nested
		      ^^^^^^^^^^^^^

"adjusted back"

> + * sev_es_ist_exit() call may back-adjust the IST entry too early.

Ditto.

> + */
> +void noinstr __sev_es_ist_enter(struct pt_regs *regs)
> +{
> +	unsigned long old_ist, new_ist;
> +	unsigned long *p;
> +
> +	/* Read old IST entry */
> +	old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
> +
> +	/* Make room on the IST stack */
> +	if (on_vc_stack(regs->sp))
> +		new_ist = ALIGN_DOWN(regs->sp, 8) - sizeof(old_ist);
> +	else
> +		new_ist = old_ist - sizeof(old_ist);
> +
> +	/* Store old IST entry */
> +	p       = (unsigned long *)new_ist;
> +	*p      = old_ist;

What's wrong with:

	*(unsigned long *)new_ist = old_ist;

?

> +
> +	/* Set new IST entry */
> +	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
> +}
> +
> +void noinstr __sev_es_ist_exit(void)
> +{
> +	unsigned long ist;
> +	unsigned long *p;
> +
> +	/* Read IST entry */
> +	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
> +
> +	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
> +		return;
> +
> +	/* Read back old IST entry and write it to the TSS */
> +	p = (unsigned long *)ist;
> +	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *p);

And

	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);

?

> +}
> +
>  /* Needed in vc_early_forward_exception */
>  void do_early_exception(struct pt_regs *regs, int trapnr);
>  
> @@ -277,6 +333,9 @@ void __init sev_es_init_vc_handling(void)
>  	if (!sev_es_active())
>  		return;
>  
> +	/* Enable SEV-ES special handling */
> +	static_branch_enable(&sev_es_enable_key);
> +
>  	/* Initialize per-cpu GHCB pages */
>  	for_each_possible_cpu(cpu) {
>  		sev_es_alloc_runtime_data(cpu);
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 74cfe6eb7ebb..030d882eaad1 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -59,6 +59,7 @@
>  #include <asm/umip.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
> +#include <asm/sev-es.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -731,6 +732,7 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
>  
>  static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
>  {
> +
>  	/*
>  	 * Disable breakpoints during exception handling; recursive exceptions
>  	 * are exceedingly 'fun'.

Leftover hunk which got committed my mistake.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
