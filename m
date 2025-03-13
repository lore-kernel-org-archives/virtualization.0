Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6A15DBC1
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888378; cv=none; b=jGayUSTYV13tJp0nu2nrKLE7NAdvtyB+bKaQ7LZu0CvfjH9cKyjOAVYttcKMZc1AmDfE5xJa6MlgeIknEOuOjwfeGt2q+c3PQ9vumIv1GZtHohZ5JFYjKG4Aa/eBQCIOqdDxSAyFov3F5yHrDy4fCbA7GUddOJ3KRGtNgK0HU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888378; c=relaxed/simple;
	bh=qta9zjCgN7jZ+PWtJVuJ3fMLrb2Pvtnoo7xNpROmcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRaxNmZQWaIfAw9G69LFPDGQ0+cpIntCQ2EF3dpAFXLS/Brrsdk4UdFDXdJstnexeFbAxVaLTbLahEfBv/z8tfe1AQb0w/5UsSpp95EdP+/AoZamA7ut2ztfb/mb/oyB8fzYdTRXFjqAKByrV+bxFs+ozeVEFD6iD1FLyLgfOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O1URm7vD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O1URm7vD"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD51B40E0232;
	Thu, 13 Mar 2025 17:52:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mRNq1ZtsJE5L; Thu, 13 Mar 2025 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741888369; bh=tPEJDRMG2yx1Hj/lqU3Fh9xedOg7UYhyq7ITvKKAv6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1URm7vDn7ESzL4QE+cS3IvAjioyjwddWdd41W9iDIy2N612TbijoQ+4ic+nUXzTN
	 a3/jQHKTHG1uT2zthR664pk5KFS+eHxfxjQAVhAxV0zTE6QgB12gace55CktZVBoH8
	 5jYw4rp4ifmqkf/5rEzQEjBWK2j+162VSHKxZuz6UE2NS7E6dE7Hj+Lq8dPliNXS6a
	 K2lZPbpGP844E56X2zK8h4OcTE31Q6g8BREWrTwy77c1jcOlgjk2FJGfGeWiL/Y7fC
	 TELT3KicLf8zjAVt9hxBSPWsAGOTf6DqnbYvOd7j4qUYBkn44Xkz7bXPjFYUWDD3tB
	 nwZVnr6Pn+SGm2F87ipu9LamC0YptivNf5EjWde/H5WyBZZPmLR740ET5eFHNB6VZE
	 cWVM6m1Us19NvYmCF8QXjUuAlBotNpzeNVI7gDUh7Gt17OfbHvpcND+hPIsK4Q5Xgj
	 lgOtyLozc9dxe6iwz7Hy11tyebg1p7P3k80ZTj4r71leVZIt9KlqG2X+ycityBmjgl
	 GpC0/LoAVHoKs5t89mOIc71F944sA8/7ZkNmGN3EfDqBShcKP5NWGV1DflYEOphaxE
	 e6rSlyFGplTh4kt3D0wcTdNwhqx9OIAg+cWtKLICQUs/NfjIlS6WxvTiZwtoFR+Uyg
	 uKQrRO0wiKPtZKMpc+w8oH2Y=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 810F640E0213;
	Thu, 13 Mar 2025 17:52:32 +0000 (UTC)
Date: Thu, 13 Mar 2025 18:52:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: thomas.lendacky@amd.com, alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, bo.gan@broadcom.com,
	dave.hansen@linux.intel.com, florian.fainelli@broadcom.com,
	hpa@zytor.com, kevinloughlin@google.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	vamsi-krishna.brahmajosyula@broadcom.com,
	vasavi.sirnapalli@broadcom.com, virtualization@lists.linux.dev,
	x86@kernel.org, ye.li@broadcom.com
Subject: Re: [PATCH v2] sev-snp: parse MP tables for VMware hypervisor
Message-ID: <20250313175226.GEZ9MbWuPkPQweJo1U@fat_crate.local>
References: <20250313173111.10918-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313173111.10918-1-ajay.kaher@broadcom.com>

On Thu, Mar 13, 2025 at 05:31:11PM +0000, Ajay Kaher wrote:
> For VMware hypervisor, SEV-SNP enabled VM's could boot without UEFI.

VMs

mingo, pls fix up while applying.

> In this case, mpparse_find_mptable() has to be called to parse MP
> tables which contains boot information.
> 
> Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
> Co-developed-by: Ye Li <ye.li@broadcom.com>
> Signed-off-by: Ye Li <ye.li@broadcom.com>
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> Tested-by: Ye Li <ye.li@broadcom.com>
> Reviewed-by: Kevin Loughlin <kevinloughlin@google.com>
> ---
> Changes since v1:
> https://lore.kernel.org/lkml/20241219114400.858980-1-ajay.kaher@broadcom.com/
>         - use cc_platform_has(CC_ATTR_GUEST_SEV_SNP) instead of
>           (sev_status & MSR_AMD64_SEV_SNP_ENABLED)
> 	- remove unwanted header files
> ---
>  arch/x86/kernel/cpu/vmware.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
