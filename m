Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E04BECAAD3
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 10:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71F8C402E5;
	Wed,  7 Sep 2022 10:03:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71F8C402E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RkCkoGes
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5igoesSPl8s9; Wed,  7 Sep 2022 10:03:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56E7140137;
	Wed,  7 Sep 2022 10:03:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56E7140137
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B645C0032;
	Wed,  7 Sep 2022 10:03:27 +0000 (UTC)
Received: from smtp1.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe97:d076])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66FD1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 301C781364
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:03:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 301C781364
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=RkCkoGes
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jjhEqEUCq8wk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:03:23 +0000 (UTC)
X-Greylist: delayed 01:12:43 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A00B8125B
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A00B8125B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M9ffSCcPAJFL/NG3iecTA6XnLuNGeYKgtteM2yRjbw8=; b=RkCkoGesMVEcRNleJvacW27ZN9
 eY6mqXlLytLmnVTUKkvVx8upYmP36N0nVMK6OGviCGk0MrGxxqvCKFQ2sVRWckFQAB5ga87K5lECr
 7m0wErxJQXSkUWe0P3Qq31N3F9tBcfUN2tNLtWayNUzwxQGjlG35NgtA8f1SDxw4a6Bx/48ySEszA
 KPjszB/XFsGfcyya0D92vkgmt8MBtS9AeDfzrSfDWIxuZ8jnpXh+c9RTwBZWtiuuZHUMtPsReO5PX
 Cud2D6l2SHerN+rFL9hFmy6zneagpc7A2yy9HT/ovVqtGCSOiWRuqX7kFvwVUvfahUbviFXUq9k90
 gaDEFQVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oVql3-00APB3-3s; Wed, 07 Sep 2022 08:50:05 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C72E130013F;
 Wed,  7 Sep 2022 10:50:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 9DD9B20134FB3; Wed,  7 Sep 2022 10:50:03 +0200 (CEST)
Date: Wed, 7 Sep 2022 10:50:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook>
 <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
Cc: Juergen Gross <jgross@suse.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 clang-built-linux <llvm@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Bill Wendling <morbo@google.com>,
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

On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > [...]
> > > >         callq   *pv_ops+536(%rip)
> > >
> > > Do you know which pv_ops function is this? I can't figure out where
> > > pte_offset_kernel() gets converted into a pv_ops call....
> > >
> > This one is _paravirt_ident_64, I believe. I think that the original
> > issue Nathan was seeing was with another seemingly innocuous function.
> 
> _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> really needs to not be touched at all by the compiler for
> these...special features.

My source tree sayeth:

  u64 notrace _paravirt_ident_64(u64 x)

And that function is only ever called at boot, after alternatives runs
it's patched with:

  mov %_ASM_ARG1, %_ASM_AX

Anyway, if you want to take it away from the compiler, something like
so should do.


diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7ca2d46c08cc..8922e2887779 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -80,11 +80,16 @@ static unsigned paravirt_patch_call(void *insn_buff, const void *target,
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
-/* identity function, which can be inlined */
-u64 notrace _paravirt_ident_64(u64 x)
-{
-	return x;
-}
+extern u64 _paravirt_ident_64(u64 x);
+asm (".pushsection .entry.text, \"ax\"\n"
+     ".global _paravirt_ident_64\n"
+     "_paravirt_ident_64:\n\t"
+     ASM_ENDBR
+     "mov %" _ASM_ARG1 ", %" _ASM_AX "\n\t"
+     ASM_RET
+     ".size _paravirt_ident_64, . - _paravirt_ident_64\n\t"
+     ".type _paravirt_ident_64, @function\n\t"
+     ".popsection");
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
