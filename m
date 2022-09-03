Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904F5C6FA86
	for <virtualization@archiver.kernel.org>; Sat,  3 Sep 2022 07:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDB3E8266A;
	Sat,  3 Sep 2022 07:18:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDB3E8266A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AskGi2ax
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyI-IEA2D0zG; Sat,  3 Sep 2022 07:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F1E5825B9;
	Sat,  3 Sep 2022 07:18:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F1E5825B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A338C0033;
	Sat,  3 Sep 2022 07:18:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CEDCC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 07:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7DDB60B2B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 07:18:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7DDB60B2B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=AskGi2ax
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTM9307X0Lqz
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 07:18:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0781160AF2
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0781160AF2
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 07:18:48 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id l65so3941777pfl.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 03 Sep 2022 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=SHiiav/UTzP3n773mJagoVt2o/t4dOU1H79RijaCaHU=;
 b=AskGi2axoxsEY7KBMXI29CjNbAw+cxBhimz+Uws86axHbnwkRzVkZm0D1J5APPX1zH
 RE63qqDfrdaIRKvGYkOK9sQyFnbW82CNfeKcNNVKRsuR6HwoHzDihm8NXT8SAX1B+tKM
 ROhbgkgg/KN32vOURtYpeFrRIqnmAQkrQ4fYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=SHiiav/UTzP3n773mJagoVt2o/t4dOU1H79RijaCaHU=;
 b=Rri9lgMLdYBQL1B8u5SIiHS+W9Vz34FnEYkJm4vTq3zAg3/DuhmfrsBYFxHKPE+iuS
 5UNbbjWulYnzM203AJxwll2kCgOkbNkc1Z8LifvYWYIPndAxm6Y6eIwJ7YR6q/XGesfU
 trQ8W5E5W0GQH5L/02DgqxXfUboGwHcKgP/43wVIJ7LRjShVn3ePG12usXRzJhlESN1u
 WsOVRQ7PHHZAHxqJUJAOEwGVtvdw8SBCmRm9pfKF8tqXqnlwYanJ5uIJbLbYiFBAtf8E
 Om4EgXCrOVy5JHUdhXjpKTIWzEJhu2jZLN4TW6NT92t8HYWx98NTAj/gcM58UhFo+nxI
 r6yw==
X-Gm-Message-State: ACgBeo0cGiIaBzpsECaIcCKKg9ML/wQqxnDT9jJ695UOH2MJbkYSNGJq
 mSRBeZOV6vuBDSEIzoqZkJbrPA==
X-Google-Smtp-Source: AA6agR7is3qPx2jzNtjCUYC08MYC3I8gIVe9jpfazv4o1qlzZaJVGogtiDukY6sKPz49eksygDlzsg==
X-Received: by 2002:a63:8bc3:0:b0:42b:1bd2:9a6d with SMTP id
 j186-20020a638bc3000000b0042b1bd29a6dmr31887720pge.503.1662189528295; 
 Sat, 03 Sep 2022 00:18:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a63f558000000b0042c5a1715d7sm2519864pgk.83.2022.09.03.00.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Sep 2022 00:18:47 -0700 (PDT)
Date: Sat, 3 Sep 2022 00:18:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Bill Wendling <morbo@google.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <202209022251.B14BD50B29@keescook>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902213750.1124421-3-morbo@google.com>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, Alexey Makhalov <amakhalov@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> [...]
>         callq   *pv_ops+536(%rip)

Do you know which pv_ops function is this? I can't figure out where
pte_offset_kernel() gets converted into a pv_ops call....

> [...]
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -414,8 +414,17 @@ int paravirt_disable_iospace(void);
>  				"=c" (__ecx)
>  #define PVOP_CALL_CLOBBERS	PVOP_VCALL_CLOBBERS, "=a" (__eax)
>  
> -/* void functions are still allowed [re]ax for scratch */
> +/*
> + * void functions are still allowed [re]ax for scratch.
> + *
> + * The ZERO_CALL_USED REGS feature may end up zeroing out callee-saved
> + * registers. Make sure we model this with the appropriate clobbers.
> + */
> +#ifdef CONFIG_ZERO_CALL_USED_REGS
> +#define PVOP_VCALLEE_CLOBBERS	"=a" (__eax), PVOP_VCALL_CLOBBERS
> +#else
>  #define PVOP_VCALLEE_CLOBBERS	"=a" (__eax)
> +#endif
>  #define PVOP_CALLEE_CLOBBERS	PVOP_VCALLEE_CLOBBERS

I don't think this should depend on CONFIG_ZERO_CALL_USED_REGS; it should
always be present.

I've only been looking at this just now, so many I'm missing
something. The callee clobbers are for functions with return values,
yes?

For example, 32-bit has to manually deal with doing a 64-bit value return,
and even got it wrong originally, fixing it in commit 0eb592dbba40
("x86/paravirt: return full 64-bit result"), with:

-#define PVOP_VCALLEE_CLOBBERS          "=a" (__eax)
+#define PVOP_VCALLEE_CLOBBERS          "=a" (__eax), "=d" (__edx)

But the naming is confusing, since these aren't actually clobbers,
they're input constraints marked as clobbers (the "=" modifier).

Regardless, the note in the comments ...

 ...
 * However, x86_64 also have to clobber all caller saved registers, which
 * unfortunately, are quite a bit (r8 - r11)
 ...

... would indicate that ALL the function argument registers need to be
marked as clobbers (i.e. the compiler can't figure this out on its own).

I was going to say it seems like they're missing from EXTRA_CLOBBERS,
but it's not used with any of the macros using PVOP_VCALLEE_CLOBBERS,
and then I saw the weird alternatives patching that encodes the clobbers
a second time (CLBR_ANY vs CLBR_RET_REG) via:

#define _paravirt_alt(insn_string, type, clobber)       \
        "771:\n\t" insn_string "\n" "772:\n"            \
        ".pushsection .parainstructions,\"a\"\n"        \
        _ASM_ALIGN "\n"                                 \
        _ASM_PTR " 771b\n"                              \
        "  .byte " type "\n"                            \
        "  .byte 772b-771b\n"                           \
        "  .short " clobber "\n"                        \
        ".popsection\n"

And after reading the alternatives patching code which parses this via
the following struct:

/* These all sit in the .parainstructions section to tell us what to patch. */
struct paravirt_patch_site {
        u8 *instr;              /* original instructions */
        u8 type;                /* type of this instruction */
        u8 len;                 /* length of original instruction */
};

... I see it _doesn't use the clobbers_ at all! *head explode* I found
that removal in commit 27876f3882fd ("x86/paravirt: Remove clobbers from
struct paravirt_patch_site")

So, I guess the CLBR_* can all be entirely removed. But back to my other
train of thought...

It seems like all the input registers need to be explicitly listed in
the PVOP_VCALLEE_CLOBBERS list (as you have), but likely should be done
unconditionally and for 32-bit as well.

-Kees

(Also, please CC linux-hardening@vger.kernel.org.)

-- 
Kees Cook
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
