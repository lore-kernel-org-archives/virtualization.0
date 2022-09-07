Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C2BECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 23:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1BBB40A45;
	Wed,  7 Sep 2022 23:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1BBB40A45
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fHmNShdg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUHiYVcqt3hS; Wed,  7 Sep 2022 23:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC1B8402B1;
	Wed,  7 Sep 2022 23:10:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC1B8402B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B985C0033;
	Wed,  7 Sep 2022 23:10:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32230C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 23:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED1A183E0B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 23:10:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED1A183E0B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fHmNShdg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 52efDaX3XzYy
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 23:10:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C66283DFD
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C66283DFD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 23:10:46 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id c24so14977847pgg.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=D9GYa8OJDUYWVtjvzZNWj4WxHz/CsMN9FwfpuX4V0rg=;
 b=fHmNShdgI4dnC6hErvVoYwXgDNbgsvnYw6M/vzNGlywwNb8ieN/SlRLVWwpWKkoSu1
 vq0hcEhlT+GKynnWf9AqlWHeUPpZL08URJGii/8YbtzlfJ0IfDSoFsIU4KgaZEj4R4uU
 m+2r1/Ucjkq3qLNSD1SgrXHQXWlvKtbJxGq1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=D9GYa8OJDUYWVtjvzZNWj4WxHz/CsMN9FwfpuX4V0rg=;
 b=mbd4oStMxx+3XvX4F0E9vDwU5ERw9hf+ZrBkHiVknb+ujKBSCDqd5NSp+DpqAeUmRw
 j+H29PUWdm+E8nvhFFoO0rfrFclsUtf+7jj/cqNxxyeyxSVpPini1rY3r3dOaoUckR0m
 cTiFuBkZWWLKIAgI0PGivEreq0uFGHfyWQAeRrRETPc4XRQjrwP04CVL0tvMTciPaMK4
 chU1PXOlQQgvIWm4qDKzzi3VgBQEYai3zS1UNFeYtOdVNbZznwNZoztbbo5h01o1mh6c
 nD4b8clA6tKrpTXz5o72Lyp16jl/3gsNp7vFJ4WXlA+qogr34F7OmkcrACFfp+Wm5E78
 HaFA==
X-Gm-Message-State: ACgBeo0QSJA8Em6x6aAjwwzG3GaFByee+wPXMn0gHbv9ZxPrxR1HmQJo
 /z5Vu0PjEDDv+RitD4vRF0IX3Q==
X-Google-Smtp-Source: AA6agR5mOZptHzyKX2MhRGXlipNiPACZtnxxJGgxQ8tn93t85KvuvocH+td73K+d6+k4fFh4O61YPw==
X-Received: by 2002:a63:1e61:0:b0:41c:45d:7d50 with SMTP id
 p33-20020a631e61000000b0041c045d7d50mr5135945pgm.507.1662592245677; 
 Wed, 07 Sep 2022 16:10:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 v28-20020aa799dc000000b00537ab89c66csm13683408pfi.143.2022.09.07.16.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 16:10:44 -0700 (PDT)
Date: Wed, 7 Sep 2022 16:10:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <202209071609.BE5BF18D6@keescook>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
Cc: Juergen Gross <jgross@suse.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bill Wendling <morbo@google.com>,
 clang-built-linux <llvm@lists.linux.dev>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-hardening@vger.kernel.org
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

On Wed, Sep 07, 2022 at 10:50:03AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> > On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > > [...]
> > > > >         callq   *pv_ops+536(%rip)
> > > >
> > > > Do you know which pv_ops function is this? I can't figure out where
> > > > pte_offset_kernel() gets converted into a pv_ops call....
> > > >
> > > This one is _paravirt_ident_64, I believe. I think that the original
> > > issue Nathan was seeing was with another seemingly innocuous function.
> > 
> > _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> > really needs to not be touched at all by the compiler for
> > these...special features.
> 
> My source tree sayeth:
> 
>   u64 notrace _paravirt_ident_64(u64 x)

I don't see noinstr either. But it seems a reasonable thing to do?

Bill, does fixing up the noinstr macro and adding it here fix the
problem?

-- 
Kees Cook
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
