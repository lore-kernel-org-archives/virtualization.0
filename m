Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB6C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 16:22:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CDE61185
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 16:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CDE61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1272C4056E;
	Wed, 16 Jun 2021 16:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nvn8DVQeWWe2; Wed, 16 Jun 2021 16:22:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A2BA40388;
	Wed, 16 Jun 2021 16:22:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25BBBC000E;
	Wed, 16 Jun 2021 16:22:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12AA8C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 16:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5DB140486
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 16:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YsDGQHwznjwz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 16:22:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E298B40388
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=1d0Tl5rfohMOCIU/0DFB9J6Hwo/O5OgV8ZAPADtlBA0=; b=FTmH95Q23BqY4TkY4TDDOpOMxH
 9BtCg09BOIov7oalJ/k0iE3EaYw61VOCnIK0T+0XEkuV2C7lUm+GsDRXUJutWmZCHiimixdyrtPLt
 ozU7afsS3dXlOwMxyhAcCVKRGTT7ybEV/mOs4dxAto9Ems80hcGpOQgqaG+5YjiDWRTDbzGMhoLEU
 7gWPiz5fJnrL5KDKrpMzgSJdXpEmUsFGv3dDoFsal53jiwMKjDDKUBv1hoEbG0adkF0kXyPeoe2lO
 NdDudTUPcjbwLq4NgG5GBik6RFAB+pfIA+ZGmmR5uw4m9d7lBhU+1Uu7bwEZwwgLZcv3uBSVvlje9
 6PpMGJDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltYIX-008FOd-VY; Wed, 16 Jun 2021 16:21:52 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7874D300269;
 Wed, 16 Jun 2021 18:04:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5620A2BD35DD3; Wed, 16 Jun 2021 18:04:26 +0200 (CEST)
Date: Wed, 16 Jun 2021 18:04:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 3/6] x86/sev-es: Split up runtime #VC handler for
 correct state tracking
Message-ID: <YMohCkW/mChNpkqi@hirez.programming.kicks-ass.net>
References: <20210614135327.9921-1-joro@8bytes.org>
 <20210614135327.9921-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210614135327.9921-4-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
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

On Mon, Jun 14, 2021 at 03:53:24PM +0200, Joerg Roedel wrote:

> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -506,7 +506,7 @@ SYM_CODE_START(\asmsym)
>  
>  	movq	%rsp, %rdi		/* pt_regs pointer */
>  
> -	call	\cfunc
> +	call	kernel_\cfunc
>  
>  	/*
>  	 * No need to switch back to the IST stack. The current stack is either
> @@ -517,7 +517,7 @@ SYM_CODE_START(\asmsym)
>  
>  	/* Switch to the regular task stack */
>  .Lfrom_usermode_switch_stack_\@:
> -	idtentry_body safe_stack_\cfunc, has_error_code=1
> +	idtentry_body user_\cfunc, has_error_code=1
>  
>  _ASM_NOKPROBE(\asmsym)
>  SYM_CODE_END(\asmsym)

Consistency with idtentry_mce_db would seem to suggest using \cfunc and
noist_\cfunc.

amluto, tglx: do we have strong feelings on consistency?


> +static bool noinstr vc_check_and_handle_db(struct pt_regs *regs, unsigned long error_code)
> +{
> +	if (likely(error_code != SVM_EXIT_EXCP_BASE + X86_TRAP_DB))
> +		return false;
>  
> +	vc_handle_trap_db(regs);

It's a bit sad this does user_mode(regs) again.

> +
> +	return true;
> +}

Maybe something like:

static __always_inline bool vc_is_db(unsigned long error_code)
{
	return error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB;
}

> +
> +/*
> + * Runtime #VC exception handler when raised from kernel mode. Runs in NMI mode
> + * and will panic when an error happens.
> + */
> +DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
> +{
> +	irqentry_state_t irq_state;
>  
> +	/*
> +	 * With the current implementation it is always possible to switch to a
> +	 * safe stack because #VC exceptions only happen at known places, like
> +	 * intercepted instructions or accesses to MMIO areas/IO ports. They can
> +	 * also happen with code instrumentation when the hypervisor intercepts
> +	 * #DB, but the critical paths are forbidden to be instrumented, so #DB
> +	 * exceptions currently also only happen in safe places.
> +	 *
> +	 * But keep this here in case the noinstr annotations are violated due
> +	 * to bug elsewhere.
> +	 */
> +	if (unlikely(on_vc_fallback_stack(regs))) {
> +		instrumentation_begin();
> +		panic("Can't handle #VC exception from unsupported context\n");
> +		instrumentation_end();
> +	}
> +
> +	/*
> +	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
> +	 */
> +	if (vc_check_and_handle_db(regs, error_code))
> +		return;

	if (vc_is_db(error_core)) {
		exc_debug(regs);
		return;
	}

> +
> +	irq_state = irqentry_nmi_enter(regs);
> +
> +	instrumentation_begin();
> +
> +	if (!vc_raw_handle_exception(regs, error_code)) {
>  		/* Show some debug info */
>  		show_regs(regs);
>  
> @@ -1443,23 +1448,38 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
>  		panic("Returned from Terminate-Request to Hypervisor\n");
>  	}
>  
> +	instrumentation_end();
> +	irqentry_nmi_exit(regs, irq_state);
>  }
>  
> +/*
> + * Runtime #VC exception handler when raised from user mode. Runs in IRQ mode
> + * and will kill the current task with SIGBUS when an error happens.
> + */
> +DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
>  {
> +	irqentry_state_t irq_state;
> +
> +	/*
> +	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
> +	 */
> +	if (vc_check_and_handle_db(regs, error_code))
> +		return;

	if (vs_is_db(error_code)) {
		noist_exc_debug(regs);
		return;
	}

> +
> +	irq_state = irqentry_enter(regs);
>  	instrumentation_begin();
>  
> +	if (!vc_raw_handle_exception(regs, error_code)) {
> +		/*
> +		 * Do not kill the machine if user-space triggered the
> +		 * exception. Send SIGBUS instead and let user-space deal with
> +		 * it.
> +		 */
> +		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
> +	}
> +
> +	instrumentation_end();
> +	irqentry_exit(regs, irq_state);
>  }

Other than that, this seems *much* nicer. Thanks!


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
