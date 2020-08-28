Return-Path: <SRS0=Pzcc=CG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A33C433E6
	for <virtualization@archiver.kernel.org>; Fri, 28 Aug 2020 18:14:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6692A20936
	for <virtualization@archiver.kernel.org>; Fri, 28 Aug 2020 18:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KXRzfuly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6692A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38CB9886F3;
	Fri, 28 Aug 2020 18:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BABZnIlHbJGl; Fri, 28 Aug 2020 18:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B210886E6;
	Fri, 28 Aug 2020 18:13:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B525C07FF;
	Fri, 28 Aug 2020 18:13:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A18D9C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 18:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 073D58501D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 18:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cfogMLxgbgKI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 18:13:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3FD9C844E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 18:13:53 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0ba60078cbaf9a215c2e9d.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:a600:78cb:af9a:215c:2e9d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFDBB1EC03E3;
 Fri, 28 Aug 2020 20:13:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598638430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=/jYI5IHuv43D+ZADrXsFhwBXIJnV8i1FIyxJtyua/Yg=;
 b=KXRzfulyqoFzRZ+dj+HluE21PJnj0cjQ69UGDcWcPA264jRdoC9l65vRds3AZNoIGQLiw/
 etQ7GAfkKPIWNnJokkDlepYsvcxMPquvY19el5NfnOAs2br3nC3Vjryk/KQaFohIqhnVUW
 NNFAZll3B7FQ4406XApoT0w5nSGLFcY=
Date: Fri, 28 Aug 2020 20:13:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 31/76] x86/head/64: Setup MSR_GS_BASE before calling
 into C code
Message-ID: <20200828181346.GB19342@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-32-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-32-joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 x86@kernel.org, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
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

On Mon, Aug 24, 2020 at 10:54:26AM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 2b2e91627221..800053219054 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -78,6 +78,14 @@ SYM_CODE_START_NOALIGN(startup_64)
>  	call	startup_64_setup_env
>  	popq	%rsi
>  
> +	/*
> +	 * Setup %gs here already to make stack-protector work - it needs to be
> +	 * setup again after the switch to kernel addresses. The address read
> +	 * from initial_gs is a kernel address, so it needs to be adjusted first
> +	 * for the identity mapping.
> +	 */
> +	movl	$MSR_GS_BASE,%ecx

I'm confused: is this missing those three lines:

        movl    initial_gs(%rip),%eax
        movl    initial_gs+4(%rip),%edx
        wrmsr

as it is done in secondary_startup_64 ?

Or why would you otherwise put 0xc0000101 in %ecx and not do anything
with it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
