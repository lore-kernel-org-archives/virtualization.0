Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49EAC433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 17:20:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25847206B5
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 17:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NT+D1his"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25847206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1AD785E40;
	Tue,  8 Sep 2020 17:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yuu3PtRVO8vy; Tue,  8 Sep 2020 17:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1C83C85D70;
	Tue,  8 Sep 2020 17:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8201C0859;
	Tue,  8 Sep 2020 17:20:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7B4BC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9590F85D70
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id woVKno8iGeIy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:20:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16D7A85D39
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:20:51 +0000 (UTC)
Received: from zn.tnic (p200300ec2f10bf0070b09dfd4356f225.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:bf00:70b0:9dfd:4356:f225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6016C1EC0493;
 Tue,  8 Sep 2020 19:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1599585648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=LmUlHAGcDfQUhA9DUzYK7oqYD6W3gPvxbkj2WBXLliI=;
 b=NT+D1hisw4b0wW+6D7Ney6pv8pqgOWkQiIpZMVJFpu03DYUr3koV1ACECWUSItIFaW0klI
 6lQvPBJz1xfNqiAypVEEPioZLzJhxPHQWnPMBFkqcSx5eFSdpW4Hse7mx++L7Y6j3zJfOv
 V2b1QESn48gtV8CN2wkTeDHRDEKrGvo=
Date: Tue, 8 Sep 2020 19:20:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v7 67/72] x86/smpboot: Load TSS and getcpu GDT entry
 before loading IDT
Message-ID: <20200908172042.GF25236@zn.tnic>
References: <20200907131613.12703-1-joro@8bytes.org>
 <20200907131613.12703-68-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907131613.12703-68-joro@8bytes.org>
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

On Mon, Sep 07, 2020 at 03:16:08PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IDT on 64bit contains vectors which use paranoid_entry() and/or IST
> stacks. To make these vectors work the TSS and the getcpu GDT entry need
> to be set up before the IDT is loaded.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/processor.h |  1 +
>  arch/x86/kernel/cpu/common.c     | 23 +++++++++++++++++++++++
>  arch/x86/kernel/smpboot.c        |  2 +-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index d8a82e650810..5ac507586769 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -696,6 +696,7 @@ extern void load_direct_gdt(int);
>  extern void load_fixmap_gdt(int);
>  extern void load_percpu_segment(int);
>  extern void cpu_init(void);
> +extern void cpu_init_exception_handling(void);
>  extern void cr4_init(void);
>  
>  static inline unsigned long get_debugctlmsr(void)
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 1d65365363a1..a9527c0c38fb 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1854,6 +1854,29 @@ static inline void tss_setup_io_bitmap(struct tss_struct *tss)
>  #endif
>  }
>  
> +/*
> + * Setup everything needed to handle exceptions from the IDT, including the IST
> + * exceptions which use paranoid_entry()
> + */
> +void cpu_init_exception_handling(void)
> +{
> +	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
> +	int cpu = raw_smp_processor_id();
> +
> +	/* paranoid_entry() gets the CPU number from the GDT */
> +	setup_getcpu(cpu);
> +
> +	/* IST vectors need TSS to be set up. */
> +	tss_setup_ist(tss);
> +	tss_setup_io_bitmap(tss);
> +	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
> +
> +	load_TR_desc();

Aha, this is what you mean here in your 0th message. I'm guessing it is
ok to do those things twice in start_secondary...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
