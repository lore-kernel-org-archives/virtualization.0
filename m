Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DB0C433F5
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 11:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C8EF410CF;
	Fri, 20 May 2022 11:52:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXX7DcVpiCpe; Fri, 20 May 2022 11:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A8D34410DB;
	Fri, 20 May 2022 11:52:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DAFCC0039;
	Fri, 20 May 2022 11:52:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6983C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EC3F61356
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hrzVIOm07Rcq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:52:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC40F60BA8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:52:14 +0000 (UTC)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 574D71EC0432;
 Fri, 20 May 2022 13:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1653047527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=UBx25AJVNBXwj5NkoGiu7FzpWAyO7lQh9NzqQwd3+KY=;
 b=hlg4xpGj5ir+DAwkdOit9i47xkD0eD832zyfp5Bqcbc65pO+fSAD4TR+ozvBBFilfXWqNg
 prhaUpQsxQMZUJa0smCpYQ1blvcii5b+KZtbuBu4AhzCPSBJn8kpcFkW3GmW6J9n2rBQ4a
 GW3RDinr3LPum9Ozz1lYbI7tEuAzbsg=
Date: Fri, 20 May 2022 13:52:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shreenidhi Shedi <yesshedi@gmail.com>
Subject: Re: [PATCH v1] x86/vmware: use unsigned integer for shifting
Message-ID: <YoeA4pf5OWxfjE0J@zn.tnic>
References: <20220520114712.595583-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220520114712.595583-1-sshedi@vmware.com>
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

On Fri, May 20, 2022 at 05:17:12PM +0530, Shreenidhi Shedi wrote:
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.
> 
> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>

This is not how this is done - you need to set your author email
properly in git so that it adds your From: ... @vmware.com> instead of
having two SOBs.

> ---
>  arch/x86/kernel/cpu/vmware.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..7f44ea073436 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpu.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
> +#include <linux/bits.h>
>  #include <asm/div64.h>
>  #include <asm/x86_init.h>
>  #include <asm/hypervisor.h>
> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return (eax & BIT(VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> +	       (eax & BIT(VMWARE_CMD_LEGACY_X2APIC)) != 0;
						    ^^^^^^^^

You did hurry too much with sending a new version.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
