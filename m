Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC8C433E6
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 09:45:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC992064B
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 09:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hDnCxTDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC992064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4ADF68630A;
	Mon, 31 Aug 2020 09:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gH+TxJ34iYa; Mon, 31 Aug 2020 09:45:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 28A2585C57;
	Mon, 31 Aug 2020 09:45:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF85C0052;
	Mon, 31 Aug 2020 09:45:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85D1AC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 70D8B878A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FML3-V5cyfMW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:45:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6D2B8788B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:45:46 +0000 (UTC)
Received: from zn.tnic (p200300ec2f085000329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:5000:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C5091EC02F2;
 Mon, 31 Aug 2020 11:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598867145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ekJdpwvphjOKlQIbAp+8+LkeKmG6PBAegFPKIHvH6zs=;
 b=hDnCxTDT3/Oj4fPBE0hGDA8UVt83lzNbYfBzkn2257MEQfuxFndrFvIi3Yt+02BBUttPxQ
 T0WLfkj3j5FBOZg14SLzJe1sh2+JrPkGiEhW1EeB7GhRBbh2s442flj2V1Bthgr1j/eiJb
 xVte/nnElLdX6F54j7hYn5Y6RzOZZyI=
Date: Mon, 31 Aug 2020 11:45:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 42/76] x86/sev-es: Setup early #VC handler
Message-ID: <20200831094541.GD27517@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-43-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-43-joro@8bytes.org>
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

On Mon, Aug 24, 2020 at 10:54:37AM +0200, Joerg Roedel wrote:
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +static void set_early_idt_handler(gate_desc *idt, int n, void *handler)
> +{
> +	struct idt_data data;
> +	gate_desc desc;
> +
> +	init_idt_data(&data, n, handler);
> +	idt_init_desc(&desc, &data);
> +	native_write_idt_entry(idt, n, &desc);
> +}
> +#endif
> +
> +static struct desc_ptr early_idt_descr __initdata = {
> +	.size		= IDT_TABLE_SIZE - 1,
> +	.address	= 0 /* Needs physical address of idt_table - initialized at runtime. */,
> +};
> +
> +void __init early_idt_setup(unsigned long physbase)
> +{
> +	void __maybe_unused *handler;
> +	gate_desc *idt;
> +
> +	idt = fixup_pointer(idt_table, physbase);
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* VMM Communication Exception */
> +	handler = fixup_pointer(vc_no_ghcb, physbase);
> +	set_early_idt_handler(idt, X86_TRAP_VC, handler);

This function is used only once AFAICT - you might just as well add its
three-lined body here and save yourself the function definition and
ifdeffery above...

> +#endif
> +
> +	/* Initialize IDT descriptor and load IDT */
> +	early_idt_descr.address = (unsigned long)idt;
> +	native_load_idt(&early_idt_descr);
> +}
> -- 
> 2.28.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
