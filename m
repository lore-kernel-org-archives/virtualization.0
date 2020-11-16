Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4767DC4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:28:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF64820776
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 16:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSp2LxJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF64820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F464868B5;
	Mon, 16 Nov 2020 16:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ZYdvbzfPtNJ; Mon, 16 Nov 2020 16:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C80AE868B6;
	Mon, 16 Nov 2020 16:28:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2686C0800;
	Mon, 16 Nov 2020 16:28:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E95DC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2AB5A868B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7yFcDPI229Z3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 80D60868B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:15 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2A2F222B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605544095;
 bh=x3FHK31Xm/BBB7HpLRBIa98x7QEqf275AgxsToa6mkU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dSp2LxJUJ58gcX59eL2xT0qVUTROA6hs+/D6p0wzaVRwjytMTLR0IOaUwLCw0qvV9
 oPxeDEHDRvLSTb6pZKi4znh9AdooQXrCYtwzhXRxhD5nuPb55BqjjPXvLVpCG0M3FD
 iDc77eS+vloBkEmarGAjuhz3e8qNrbVN/RCsAOsE=
Received: by mail-wr1-f41.google.com with SMTP id s8so19316595wrw.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 08:28:14 -0800 (PST)
X-Gm-Message-State: AOAM530Xva+x3GjMGA08J3rc1UsMmnw0B9pGEEZznIy+txT3+sJX6RLy
 xl+D1QUt/HV+MGuon91o/cdS0ASsTHscblPLnJV9sg==
X-Google-Smtp-Source: ABdhPJyncJCxKduqliOLf7Ic4pClunkNO5+SsixRmuCBm2erhKc8dlxKlGJlIEYjuLvuG7ANk+QxxpsYnP+LvzP3zfc=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr20556285wrq.70.1605544093233; 
 Mon, 16 Nov 2020 08:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20201116152301.24558-1-jgross@suse.com>
 <20201116152301.24558-5-jgross@suse.com>
In-Reply-To: <20201116152301.24558-5-jgross@suse.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 16 Nov 2020 08:28:00 -0800
X-Gmail-Original-Message-ID: <CALCETrW_UO9sksa1agOfs5E7yV+RqOyugEEOBjZY8Z47R-04Pg@mail.gmail.com>
Message-ID: <CALCETrW_UO9sksa1agOfs5E7yV+RqOyugEEOBjZY8Z47R-04Pg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/xen: drop USERGS_SYSRET64 paravirt call
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 16, 2020 at 7:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> USERGS_SYSRET64 is used to return from a syscall via sysret, but
> a Xen PV guest will nevertheless use the iret hypercall, as there
> is no sysret PV hypercall defined.
>
> So instead of testing all the prerequisites for doing a sysret and
> then mangling the stack for Xen PV again for doing an iret just use
> the iret exit from the beginning.
>
> This can easily be done via an ALTERNATIVE like it is done for the
> sysenter compat case already.
>
> While at it remove to stale sysret32 remnants.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Andy Lutomirski <luto@kernel.org>

FWIW, you've lost the VGCF_in_syscall optimization.  Let me see if I
can give it back to you better.

> ---
>  arch/x86/entry/entry_64.S             | 22 +++++++++-------------
>  arch/x86/include/asm/irqflags.h       |  6 ------
>  arch/x86/include/asm/paravirt.h       |  5 -----
>  arch/x86/include/asm/paravirt_types.h |  8 --------
>  arch/x86/kernel/asm-offsets_64.c      |  2 --
>  arch/x86/kernel/paravirt.c            |  5 +----
>  arch/x86/kernel/paravirt_patch.c      |  4 ----
>  arch/x86/xen/enlighten_pv.c           |  1 -
>  arch/x86/xen/xen-asm.S                | 20 --------------------
>  arch/x86/xen/xen-ops.h                |  2 --
>  10 files changed, 10 insertions(+), 65 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index a876204a73e0..df865eebd3d7 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -46,14 +46,6 @@
>  .code64
>  .section .entry.text, "ax"
>
> -#ifdef CONFIG_PARAVIRT_XXL
> -SYM_CODE_START(native_usergs_sysret64)
> -       UNWIND_HINT_EMPTY
> -       swapgs
> -       sysretq
> -SYM_CODE_END(native_usergs_sysret64)
> -#endif /* CONFIG_PARAVIRT_XXL */
> -
>  /*
>   * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
>   *
> @@ -123,12 +115,15 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>          * Try to use SYSRET instead of IRET if we're returning to
>          * a completely clean 64-bit userspace context.  If we're not,
>          * go to the slow exit path.
> +        * In the Xen PV case we must use iret anyway.
>          */
> -       movq    RCX(%rsp), %rcx
> -       movq    RIP(%rsp), %r11
>
> -       cmpq    %rcx, %r11      /* SYSRET requires RCX == RIP */
> -       jne     swapgs_restore_regs_and_return_to_usermode
> +       ALTERNATIVE __stringify( \
> +               movq    RCX(%rsp), %rcx; \
> +               movq    RIP(%rsp), %r11; \
> +               cmpq    %rcx, %r11;     /* SYSRET requires RCX == RIP */ \
> +               jne     swapgs_restore_regs_and_return_to_usermode), \
> +       "jmp    swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV

I'm not in love with this save-a-few-bytes stringify, but I can live with it.

--Andy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
