Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968141E32DA
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602398; cv=none; b=RepbFs1av1CnpHQ4+CwR4gHyqFcWf4L/GfgjSSeQeoRT67dGdvtFt+s4hT7srzPi/4z69Sv1B6cwhwX/CgodKajaoaFi0aw34V7EMgKXgSYt0Lb6j/u6bgVFJjIKudZaYih4vgACrAmCoXG2o/DmBsMWqMTvT6TUqpzkK3UyEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602398; c=relaxed/simple;
	bh=oCS5Xfj4X/FFcAUnAUdKi51IRu8AeeZmD8qMXspWZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3fhuaQwTJMyOK6XDHwLqZrJRN81ET8Cr0pUPVWSy0jkt3fhScrasaLQNg9xf84iaKbfkYBHUwxVDSBgse5Iiw+FrCRmIBYO1A7Hvk7cTNrEM7WtduXpdjeTEFe+OqbF64dXyTQpxuK/zTa0vehtRnhMZazgG0g13Dx+ZSh2YDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GANWGPn4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GANWGPn4"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6407840E01AD;
	Mon, 10 Mar 2025 10:26:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QWrDmRuwhB90; Mon, 10 Mar 2025 10:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741602389; bh=evJgpKIxgP0x4EAJW7cWZK1RzQrhPq55MehaqfbmoOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GANWGPn4iQ+WgUAcQPG5O9CfcQQhbw0AMMRmVaDQmH9CNZFuIUT2BMAs6P/fuAB6u
	 nr842tG4sHdHv60lhNi4Cy92DF1LCgIvMHeecMWE4PvOH935Fku+1/6tu6kwTdkrDd
	 hVftCNIfmAdkUAl2UwszYf7dZ0y/nB30WjqCdtXsO51+ZlqKDNxmXQ6xPFYQ36AXxI
	 JL6Cezwtnf6hbkiA2cZz6NsVSUn9gQGf+wNBMnsnBxzb/v0tVOdOQ/4TErF4PqfiD7
	 yCz1KCYxxft/ipSgZloWiRt3wKDWZYVzxVX3l8PSELiWeaycJEbU7R8aBXdT4D+H1a
	 aXDcONaWk/WI86l7s/FZHLwiQZ/Q1WTX/3uI8wxkT8zKmIlDcblfeylJj4bgE1oB0Z
	 3nS/DvgVh5d/2L7AMpOAxQXk5RYscX6ck7LfhSWQqbUFqHUwktQ72UaRTHb8gljAf1
	 6koFq5WF37zOcwXgDejf+S9Z6WjKYqNwIU8GMeL7swC4lbCBT4apf5dJSCQV6Tvw/B
	 Ssuud/EgefXnrgb/YW/QwoHnDbYw/jnlSJLtK7nYI1o+x5yjRHzKzE+19GJwcrx1H9
	 qagMukFdUc3kUuCAc38FfSiS1ij+K5xHPYH8snYq++Z1d7JFKdf2VIb94iUPGWub16
	 PBWRWLo3t7Kv6Q32Tjjd1/IM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B6C140E015D;
	Mon, 10 Mar 2025 10:26:13 +0000 (UTC)
Date: Mon, 10 Mar 2025 11:26:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: kevinloughlin@google.com, bcm-kernel-feedback-list@broadcom.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, ye.li@broadcom.com,
	bo.gan@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
Message-ID: <20250310102607.GDZ86-P3VFA-x2iy4l@fat_crate.local>
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219114400.858980-1-ajay.kaher@broadcom.com>

On Thu, Dec 19, 2024 at 11:44:00AM +0000, Ajay Kaher wrote:
> For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.
> In this case, mpparse_find_mptable() has to be called to parse MP
> tables which contains boot information.
> 
> Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> Signed-off-by: Ye Li <ye.li@broadcom.com>
> Tested-by: Ye Li <ye.li@broadcom.com>

That SOB chain is wrong. Ye's SOB means, he's sending the patch but that
doesn't look like it.

> ---
>  arch/x86/kernel/cpu/vmware.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 00189cd..3e2594d 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -26,6 +26,7 @@
>  #include <linux/export.h>
>  #include <linux/clocksource.h>
>  #include <linux/cpu.h>
> +#include <linux/efi.h>
>  #include <linux/reboot.h>
>  #include <linux/static_call.h>
>  #include <asm/div64.h>
> @@ -35,6 +36,8 @@
>  #include <asm/apic.h>
>  #include <asm/vmware.h>
>  #include <asm/svm.h>
> +#include <asm/mem_encrypt.h>
> +#include <asm/efi.h>
>  
>  #undef pr_fmt
>  #define pr_fmt(fmt)	"vmware: " fmt
> @@ -429,6 +432,10 @@ static void __init vmware_platform_setup(void)
>  		pr_warn("Failed to get TSC freq from the hypervisor\n");
>  	}
>  
> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&

cpu_feature_enabled(X86_FEATURE_SEV_SNP)

> +	    !efi_enabled(EFI_BOOT))
> +		x86_init.mpparse.find_mptable = mpparse_find_mptable;
> +
>  	vmware_paravirt_ops_setup();
>  
>  #ifdef CONFIG_X86_IO_APIC
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
