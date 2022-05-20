Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABA4C433EF
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 09:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D97983180;
	Fri, 20 May 2022 09:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PoQ7fBkrZVmt; Fri, 20 May 2022 09:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A5FF18316A;
	Fri, 20 May 2022 09:27:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7907EC0039;
	Fri, 20 May 2022 09:27:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F01C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 09:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3876E82F8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 09:27:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xYM4oPVndN5z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 09:27:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EE6182FF9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 09:27:07 +0000 (UTC)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 173CA1EC0258;
 Fri, 20 May 2022 11:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1653038820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=4q4B8B6JOY6jxn99S0iabm4qIhRYOLZ2S6fDGT0xc58=;
 b=CHhsgH5o3QZU5x8WA5Vm69Uiz4Zzi2Q/w8I1mdaqxQVCy98cyXm3LnSwTa/On2NVcV4IdN
 ubSxLchELki5hjuBvMDCy4cvxgnfiu3v6q/wWuna7AvD5xA86T+/oH2VnOFB1D/+NMmPJm
 dCMDNlt2aCjyasbV9hyEBu52YO2AoCA=
Date: Fri, 20 May 2022 11:26:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shreenidhi Shedi <yesshedi@gmail.com>
Subject: Re: [PATCH] x86/vmware: use unsigned integer for shifting
Message-ID: <Yode3m6iia9ZBHsl@zn.tnic>
References: <20220520072857.592746-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520072857.592746-1-sshedi@vmware.com>
Cc: x86@kernel.org, amakhalov@vmware.com, Shreenidhi Shedi <sshedi@vmware.com>,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
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

On Fri, May 20, 2022 at 12:58:57PM +0530, Shreenidhi Shedi wrote:
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..b28f789d3c56 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -476,7 +476,7 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> +	return (eax & (1U << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
>  	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;

Or you can use the BIT() macro and simplify this expression even more:

       return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
               (eax & BIT(VMWARE_CMD_LEGACY_X2APIC));


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
