Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0004C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 10:50:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECCF64EC9
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 10:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECCF64EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B72E483CED;
	Wed, 24 Feb 2021 10:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ofLgd9CF-aV3; Wed, 24 Feb 2021 10:50:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 355EA83CEA;
	Wed, 24 Feb 2021 10:50:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0850EC000A;
	Wed, 24 Feb 2021 10:50:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14EC1C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 10:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB37283CEA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 10:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NYl-aahW4lCj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 10:49:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B843D83CDF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 10:49:57 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 440591EC0598;
 Wed, 24 Feb 2021 11:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1614163794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ZM0t91q7XsXZUuvaXIua4IFViIknTuFeIw/XCzZmzfA=;
 b=FJbcg0KGjeOlpWEgwB8zHiDdWukpITxv+sFNTzRnRtpdlU2qTiax8xEaHYXgBEnFwxx8HH
 vdFObudelZT9IVnuTvkPx822sDrD7zQ3kZV0BlrzTeLrbrPEcZmPRgOsqlrTVEtQ8soXig
 oQuooKEsfTjRO5XXnaqiWC/ERlBo9nI=
Date: Wed, 24 Feb 2021 11:49:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/7] x86/boot/compressed/64: Setup IDT in startup_32 boot
 path
Message-ID: <20210224104952.GA20344@zn.tnic>
References: <20210210102135.30667-1-joro@8bytes.org>
 <20210210102135.30667-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210102135.30667-4-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

On Wed, Feb 10, 2021 at 11:21:31AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This boot path needs exception handling when it is used with SEV-ES.

For ?

Let's explain pls.

> Setup an IDT and provide a helper function to write IDT entries for
> use in 32-bit protected mode.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/head_64.S | 73 +++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index c59c80ca546d..8deeec78cdb4 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -116,6 +116,11 @@ SYM_FUNC_START(startup_32)
>  	lretl
>  1:
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* Setup Exception handling for SEV-ES */
> +	call	startup32_load_idt
> +#endif
> +

You can push that ifdeffery out of the main path (diff ontop):

---
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8deeec78cdb4..cb5a6849fb29 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -116,10 +116,7 @@ SYM_FUNC_START(startup_32)
 	lretl
 1:
 
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	/* Setup Exception handling for SEV-ES */
 	call	startup32_load_idt
-#endif
 
 	/* Make sure cpu supports long mode. */
 	call	verify_cpu
@@ -854,16 +851,18 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	pop     %ebx
 	ret
 SYM_FUNC_END(startup32_set_idt_entry)
+#endif
 
+/* Setup Exception handling for SEV-ES */
 SYM_FUNC_START(startup32_load_idt)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 	/* Load IDT */
 	leal	rva(boot32_idt)(%ebp), %eax
 	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
 	lidt    rva(boot32_idt_desc)(%ebp)
-
+#endif
 	ret
 SYM_FUNC_END(startup32_load_idt)
-#endif
 /*
  * Stack and heap for uncompression
  */
---

> +SYM_FUNC_START(startup32_set_idt_entry)
> +	push    %ebx
> +	push    %ecx
> +
> +	/* IDT entry address to %ebx */
> +	leal    rva(boot32_idt)(%ebp), %ebx
> +	shl	$3, %edx
> +	addl    %edx, %ebx
> +
> +	/* Build IDT entry, lower 4 bytes */
> +	movl    %eax, %edx

Let's add some side comments here:

 +	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]


 +	movl    $__KERNEL32_CS, %ecx		# Target code segment selector 
> +	shl     $16, %ecx
> +	orl     %ecx, %edx
> +
> +	/* Store lower 4 bytes to IDT */
> +	movl    %edx, (%ebx)
> +
> +	/* Build IDT entry, upper 4 bytes */
> +	movl    %eax, %edx
 +	andl    $0xffff0000, %edx		# Target code segment offset [31:16]
 +	orl     $0x00008e00, %edx		# Present, Type 32-bit Interrupt Gate

so that a reader like me can quickly find interrupt gates in the docs.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
