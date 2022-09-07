Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B904BC38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 06:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26F83402DD;
	Wed,  7 Sep 2022 06:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26F83402DD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=N5bYCEfk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v17Gdgd_aPQW; Wed,  7 Sep 2022 06:00:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 639C2402BE;
	Wed,  7 Sep 2022 06:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 639C2402BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0862FC0033;
	Wed,  7 Sep 2022 06:00:24 +0000 (UTC)
Received: from smtp4.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe79:d16b])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8707DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65E4B402DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65E4B402DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zm11MQ0UqRiz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:00:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46F5E402BE
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46F5E402BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 06:00:21 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 n23-20020a7bc5d7000000b003a62f19b453so11097292wmk.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Sep 2022 23:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=EVRMZUvSq6xdhiNGVwAMQ7WuOP9ljPbQMnIekWicfSw=;
 b=N5bYCEfkkrWyuEJPBnbTK/P4VF0qrJCydMxRgw41WsKreSUINlmQeNsJ/YPB5bBIFK
 SsQpepIKHI/EMjLdctJZb50mtWece3w2MYGIzGroJVKn/KYLRj2sZa7XEFWeOxkWj1bj
 7Xs/uYI8e4ObXhXJCLOc+IJG14T1N5SQM51tpw6CPYpEmTkd61bi5O06qN49dj0eC1bT
 IOr8MYSainsRvm7SpOLbsjDYPGs+bIDh4CwMiO9btuTPQzdr+1M6f2h0/BgtlBGwljRL
 es56etYDfYgVvxz4cr0R370WFJYutF+T50asjfOODsInyZBTG/LasVBGYcqd5mr29Wck
 eicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=EVRMZUvSq6xdhiNGVwAMQ7WuOP9ljPbQMnIekWicfSw=;
 b=NOLssHw9davQ3MYLmKHveNj1PhRFZBy1UwZoRNVCtZeHrC6TBY1JPT+AsfQXDwcVRT
 JoQov91HHUD9b4GEHUONLblsadWVeN62mkTaksNpI5HWPmODpOFm7BdPtgnXs8CF0sTQ
 oJlfkf6CE6i/b4YIjmJoFvSwjTHSqKkmsljO98fVQ7oHX2M3OF30VLw+uvc5YBA5mAnx
 Sd7gehPp0CH0WNiaPa5ELr4VXf/3M6DaEC1z4d4kGfm2ZTrYmGgTCdQhSkmJfAa9tU/k
 ASjRZsPgdvzmI7W4pLLLDh3+MwHVxY5xm55FgK4QcANUKUgVGWgyU/gbXx/bCSHWB4Hy
 y25w==
X-Gm-Message-State: ACgBeo2F38L3Vfj/O1dYReEjrroF7DpHnsKiMHYTaWa9pAktwvPoMAou
 6r9Tnu81py3jywFhULNXU6DO9gOmRswbvlyqtoCyvw==
X-Google-Smtp-Source: AA6agR6B3gQeycz+50jNE1EjqvKOK6DVZ6AZkhyR7V48tJgKgBWRV2R4ljnfmvXEtAbxKaCEOo921MMA+cgAFlUvbqE=
X-Received: by 2002:a05:600c:4ca3:b0:3a6:1616:e591 with SMTP id
 g35-20020a05600c4ca300b003a61616e591mr862526wmp.99.1662530419174; Tue, 06 Sep
 2022 23:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
In-Reply-To: <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
Date: Tue, 6 Sep 2022 23:00:07 -0700
Message-ID: <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
To: Bill Wendling <morbo@google.com>
Cc: Juergen Gross <jgross@suse.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 clang-built-linux <llvm@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-hardening@vger.kernel.org,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
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
From: Nick Desaulniers via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
>
> On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > [...]
> > >         callq   *pv_ops+536(%rip)
> >
> > Do you know which pv_ops function is this? I can't figure out where
> > pte_offset_kernel() gets converted into a pv_ops call....
> >
> This one is _paravirt_ident_64, I believe. I think that the original
> issue Nathan was seeing was with another seemingly innocuous function.

_paravirt_ident_64 is marked noinstr, which makes me suspect that it
really needs to not be touched at all by the compiler for
these...special features.

Maybe the definition of noinstr in include/linux/compiler_types.h
should be adding __attribute__((zero_call_used_regs(skip)))?

Untested:

```
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 4f2a819fd60a..a51ab77e2da8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,10 +226,17 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif

+#ifdef CONFIG_ZERO_CALL_USED_REGS
+#define __no_zero_call_used_regs __attribute__((__zero_call_used_reg__(skip)))
+#else
+#define __no_zero_call_used_regs
+#endif
+
 /* Section for code which can't be instrumented at all */
 #define noinstr
         \
        noinline notrace __attribute((__section__(".noinstr.text")))    \
-       __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage
+       __no_kcsan __no_sanitize_address __no_profile                   \
+       __no_sanitize_coverage __no_zero_call_used_regs

 #endif /* __KERNEL__ */
```
Or use __has_attribute in include/linux/compiler_attributes.h.
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
