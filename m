Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A693BC433E2
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 11:30:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5D12098B
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 11:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="SenbmO87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D12098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4777985C2E;
	Mon, 31 Aug 2020 11:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8dm4FQ4cDX3o; Mon, 31 Aug 2020 11:30:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B68B983773;
	Mon, 31 Aug 2020 11:30:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99928C0052;
	Mon, 31 Aug 2020 11:30:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F84CC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C04085C56
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:30:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yTgGPlbFCvtt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:30:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A8AC8636A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 11:30:09 +0000 (UTC)
Received: from zn.tnic (p200300ec2f085000329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:5000:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F12D1EC02C1;
 Mon, 31 Aug 2020 13:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598873406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Xc+Pd4QRnfNfg4+7CpZrHisRsqB1SyQ+tI27GhvzMCQ=;
 b=SenbmO87jXBqpXwojhBpSHQnEP4BtnTmjZyLxOz7tyqmb6JwiuipB0Ll5jgUTJzOB5CVQI
 gqH0XdsTxrHF2XN6Q8OMqK5PJ0qdVeME1fBmi9+KIvMkE1t9bJ3vKpQFj/q/RLBwVVakrk
 U7cWe9EJ9E3Y7cK1nNtroJ067GRc6f8=
Date: Mon, 31 Aug 2020 13:30:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 48/76] x86/entry/64: Add entry code for #VC handler
Message-ID: <20200831113002.GH27517@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-49-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-49-joro@8bytes.org>
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

On Mon, Aug 24, 2020 at 10:54:43AM +0200, Joerg Roedel wrote:
> @@ -446,6 +448,82 @@ _ASM_NOKPROBE(\asmsym)
>  SYM_CODE_END(\asmsym)
>  .endm
>  

ifdeffery pls...

> +/**
> + * idtentry_vc - Macro to generate entry stub for #VC
> + * @vector:		Vector number
> + * @asmsym:		ASM symbol for the entry point
> + * @cfunc:		C function to be called
> + *
> + * The macro emits code to set up the kernel context for #VC. The #VC handler
> + * runs on an IST stack and needs to be able to cause nested #VC exceptions.
> + *
> + * To make this work the #VC entry code tries its best to pretend it doesn't use
> + * an IST stack by switching to the task stack if coming from user-space (which
> + * includes early SYSCALL entry path) or back to the stack in the IRET frame if
> + * entered from kernel-mode.
> + *
> + * If entered from kernel-mode the return stack is validated first, and if it is
> + * not safe to use (e.g. because it points to the entry stack) the #VC handler
> + * will switch to a fall-back stack (VC2) and call a special handler function.
> + *
> + * The macro is only used for one vector, but it is planned to extend it in the
								^^^^^^^^^^^

"... to be extended..."

...

> @@ -674,6 +675,56 @@ asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
>  	return regs;
>  }
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs)
> +{
> +	unsigned long sp, *stack;
> +	struct stack_info info;
> +	struct pt_regs *regs;

Let's call those "regs_ret" or so, so that the argument can be "regs" by
convention and for better differentiation.

> +	/*
> +	 * In the SYSCALL entry path the RSP value comes from user-space - don't
> +	 * trust it and switch to the current kernel stack
> +	 */
> +	if (eregs->ip >= (unsigned long)entry_SYSCALL_64 &&
> +	    eregs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack) {
> +		sp = this_cpu_read(cpu_current_top_of_stack);
> +		goto sync;
> +	}
> +
> +	/*
> +	 * From here on the the RSP value is trusted - more RSP sanity checks
> +	 * need to happen above.
> +	 *
> +	 * Check whether entry happened from a safe stack.
> +	 */
> +	sp    = eregs->sp;
> +	stack = (unsigned long *)sp;
> +	get_stack_info_noinstr(stack, current, &info);
> +
> +	/*
> +	 * Don't sync to entry stack or other unknown stacks - use the fall-back
> +	 * stack instead.
> +	 */
> +	if (info.type == STACK_TYPE_UNKNOWN || info.type == STACK_TYPE_ENTRY ||

AFAICT, that STACK_TYPE_UNKNOWN gets set only by the plain
get_stack_info() function - not by the _noinstr() variant so you'd need
to check the return value of latter...

> +	    info.type >= STACK_TYPE_EXCEPTION_LAST)
> +		sp = __this_cpu_ist_top_va(VC2);
> +
> +sync:
> +	/*
> +	 * Found a safe stack - switch to it as if the entry didn't happen via
> +	 * IST stack. The code below only copies pt_regs, the real switch happens
> +	 * in assembly code.
> +	 */
> +	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs);
> +
> +	regs = (struct pt_regs *)sp;
> +	*regs = *eregs;
> +
> +	return regs;
> +}
> +#endif
> +
>  struct bad_iret_stack {
>  	void *error_entry_ret;
>  	struct pt_regs regs;
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
