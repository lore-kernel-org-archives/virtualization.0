Return-Path: <SRS0=XJSt=CH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F625C433E2
	for <virtualization@archiver.kernel.org>; Sat, 29 Aug 2020 15:55:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4041920BED
	for <virtualization@archiver.kernel.org>; Sat, 29 Aug 2020 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="S7HKF4Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4041920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ED2EB2035D;
	Sat, 29 Aug 2020 15:55:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-plFehhIDLP; Sat, 29 Aug 2020 15:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BF7AE2014A;
	Sat, 29 Aug 2020 15:55:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABA4FC07FF;
	Sat, 29 Aug 2020 15:55:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2730C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Aug 2020 15:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8A70E85551
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Aug 2020 15:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPAkydOJtmhT
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Aug 2020 15:55:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2A74C85550
 for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Aug 2020 15:55:30 +0000 (UTC)
Received: from zn.tnic (p200300ec2f20450061bc46564a6ab4aa.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f20:4500:61bc:4656:4a6a:b4aa])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDDB41EC037C;
 Sat, 29 Aug 2020 17:55:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598716528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=/hKrT6Agxsa0U42BH+OXVujqtR6Nrnq1ZKABoxchmnQ=;
 b=S7HKF4Tptffv/o1WtKtqUzdKtdftwyIQBtMOCSEWGCYytv/FZEnVROCv9pXhDh6fn4saNE
 ExIP/iUquIhslj/obBhSNv7pw8mAkwV0T+DA+QEsGeLvuXZWkElDhiFiSyTCZ1F9bUVRmw
 l9HDLUPGTfCtTdr1HNIiZ5XGTFxKUmQ=
Date: Sat, 29 Aug 2020 17:55:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 38/76] x86/head/64: Set CR4.FSGSBASE early
Message-ID: <20200829155525.GB29091@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-39-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-39-joro@8bytes.org>
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

On Mon, Aug 24, 2020 at 10:54:33AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Early exception handling will use rd/wrgsbase in paranoid_entry/exit.
> Enable the feature to avoid #UD exceptions on boot APs.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Link: https://lore.kernel.org/r/20200724160336.5435-38-joro@8bytes.org
> ---
>  arch/x86/kernel/head_64.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 08412f308de3..4622940134a5 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -153,6 +153,13 @@ SYM_CODE_START(secondary_startup_64)
>  	orl	$X86_CR4_LA57, %ecx
>  1:
>  #endif
> +
> +	ALTERNATIVE "jmp .Lstartup_write_cr4", "", X86_FEATURE_FSGSBASE
> +
> +	/* Early exception handling uses FSGSBASE on APs */
> +	orl	$X86_CR4_FSGSBASE, %ecx

How is this supposed to work?

Alternatives haven't run that early yet and that piece of code looks
like this:

ffffffff81000067:       eb 06                   jmp    ffffffff8100006f <secondary_startup_64+0x1f>
ffffffff81000069:       81 c9 00 00 01 00       or     $0x10000,%ecx
ffffffff8100006f:       0f 22 e1                mov    %rcx,%cr4

so we'll never set X86_CR4_FSGSBASE during early boot.

Stopping a guest with gdb just before that shows the same thing:

Dump of assembler code from 0x1000069 to 0x100007b:
=> 0x0000000001000069:  eb 06   jmp    0x1000071
   0x000000000100006b:  81 c9 00 00 01 00       or     $0x10000,%ecx
   0x0000000001000071:  0f 22 e1        mov    %rcx,%cr4
   0x0000000001000074:  48 03 05 95 ff 20 01    add    0x120ff95(%rip),%rax        # 0x2210010

the unconditional JMP is there and it hasn't been patched out yet.

If you really need to test CPUID flags, you need to do something similar
to what verify_cpu does that early. And looking at that thing:

 *      verify_cpu, returns the status of longmode and SSE in register %eax.
 *              0: Success    1: Failure

you could return the FSGSBASE CPUID bit there too and act accordingly.

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
