Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CEC433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 18:38:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187606516B
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 18:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187606516B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8525F414EC;
	Mon,  8 Mar 2021 18:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SfRvKTanspIy; Mon,  8 Mar 2021 18:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07BF046E38;
	Mon,  8 Mar 2021 18:38:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C46DEC000B;
	Mon,  8 Mar 2021 18:38:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82336C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 18:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68BBF46E38
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 18:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eBDhe2b6EESh
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 18:38:29 +0000 (UTC)
X-Greylist: delayed 00:07:22 by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3F2844302
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 18:38:29 +0000 (UTC)
Received: from zn.tnic (p200300ec2f05ab0000cbc018bb7305ab.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f05:ab00:cb:c018:bb73:5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 402F51EC0473;
 Mon,  8 Mar 2021 19:31:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1615228264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=R6Ru9203fpURvzmZRq8yn1riFpTQt60U5lcjEmeWKn0=;
 b=qIptAghnedJcDlkx/F8uwNChFfQEKy4KKBB+5XrfeEuhThKI8g22F1BamxZ83fyPHVx7BX
 oJvtgVXiR88qxGa+hs5ED0PQMY20AkAWQFP4qF9KJN9vVmYqQYRxNHt7L4UqA57BK0gDxx
 1JhtQ+BoV1uLOBTASs1EwTFbeIdf+KM=
Date: Mon, 8 Mar 2021 19:30:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v5 11/12] x86/paravirt: switch functions with custom code
 to ALTERNATIVE
Message-ID: <20210308183058.GC12548@zn.tnic>
References: <20210308122844.30488-1-jgross@suse.com>
 <20210308122844.30488-12-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210308122844.30488-12-jgross@suse.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
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

On Mon, Mar 08, 2021 at 01:28:43PM +0100, Juergen Gross wrote:
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 36cd71fa097f..04b3067f31b5 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -137,7 +137,8 @@ static inline void write_cr0(unsigned long x)
>  
>  static inline unsigned long read_cr2(void)
>  {
> -	return PVOP_CALLEE0(unsigned long, mmu.read_cr2);
> +	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
> +				"mov %%cr2, %%rax;", ~X86_FEATURE_XENPV);

Just some cursory poking first - indepth review later.

Do I see this correctly that the negated feature can be expressed with, to use
this example here:

	ALTERNATIVE_TERNARY(mmu.read_cr2, X86_FEATURE_XENPV, "", "mov %%cr2, %%rax;");

?

And then you don't need to touch the patching code for ~feature handling
and the flags byte.

If you want it syntactically sugared, you can define a separate
ALTERNATIVE_NOT macro using ALTERNATIVE_TERNARY...

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
