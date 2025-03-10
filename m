Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25861BC3F
	for <virtualization@lists.linux.dev>; Mon, 10 Mar 2025 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615311; cv=none; b=o9Q8ozenf3J8FBztlcXQikWIoiifnhiVgBOHpKTi9hUAXKdaAJNK4OfkeDr/xQFtYOEb0iDepzGXM4hscKBXRF/60jO1N9xrjxeQ6Dho32EBXUXO/Jz7s3a8PH8+kypaYCcsIKXD/HaT50HEtfjMI+cQzPPeQRPlq3YY18fcCaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615311; c=relaxed/simple;
	bh=yCDsSYaRK/VEjlMIlFOopdkFsAI8qdUxSfxn2JA5o1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBZHnGqGxHKEypWHCWHl3NarO2iOyMzwhVAisFfw57oqLWz2bAjqES2/p/JNicJAn7sJFFf+HbLlSBfbYkD903Yrn96sT7LFx7SxNaKqTi3/hoxFRvcu3x5mUPTGJSv+a/Rcn5iB++A6+oJG0oL4ecdUObP77HCUuUht2Pto0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AdiD7AQX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AdiD7AQX"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8584040E0217;
	Mon, 10 Mar 2025 14:01:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gClL4MeeByiO; Mon, 10 Mar 2025 14:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741615303; bh=J2EqMSZqFGnnRjkBtkxopSMfQEtLpebbT9NzBZrJ3Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdiD7AQXkeN75sNMUdXgRQXkXMtLl51h6B5yieWFG7I32GNC1c2ZZ3wmAKnyjWR/C
	 0NWnwMYJX61qTQP/jecTAdiUe2Cv5yYnhvt0Shc6UsMVCjKYMM33/PFmkDnuaMcxhb
	 hBxxTtG42eQF3E9pKiyMnNYFQMQzQ7B0dXO+wmdwfHOBMikjnd9jNLj8FdRnkUMLNi
	 VnxyObD5NBjl5tx4TFlCr1DYwSyXNhPCtTDRPX2arRH/MXD9p3YgqonaM9e+/RiMf/
	 d66dfglKf450pe9rtYOj1nFMNls+gVn18zEITl4GxXj0hp/mgFXcyXLO5xEcqZse/E
	 XS+axt34ZitKKRI0auvLuPoP7jc6Fo/4mjxdET4NWCR8KC3/+/BzPMJSsi8VbZXPnC
	 JvrcZej+0Zn+baPpZeH/DpnL2VPlEYSSIREsHGFW6DtFKfoUp3wm1+cMLOLM/dyemn
	 mYeY2CrUeHaEPUnN4+6ZEngLd5+Yd5IGo1NGB+Z1fCX7RLbjL28pykl28qYRFeYXUI
	 D/PM61+HZBnrm95lGuIN5/Nv4Ox9xPJUp8oh92YMdx7VXefRTjO5LdB9p0pqPoTYY9
	 F83oEUO3i730ih7NuSlUB6RN1rT4JzUjGb4SstPxugGhmO/BIBQo2nYBCtc+d4o+WY
	 v3LkET8wl71kAFccqE4EVikY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B61ED40E0214;
	Mon, 10 Mar 2025 14:01:25 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:01:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, kevinloughlin@google.com,
	bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, ye.li@broadcom.com,
	bo.gan@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH] sev-snp: parse MP tables for VMware hypervisor
Message-ID: <20250310140124.GJZ87wtBf-qMlizKuo@fat_crate.local>
References: <20241219114400.858980-1-ajay.kaher@broadcom.com>
 <20250310102607.GDZ86-P3VFA-x2iy4l@fat_crate.local>
 <c2f26b4f-e42c-f152-c33d-4c0dd8d68da6@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2f26b4f-e42c-f152-c33d-4c0dd8d68da6@amd.com>

On Mon, Mar 10, 2025 at 08:12:46AM -0500, Tom Lendacky wrote:
> >> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> > 
> > cpu_feature_enabled(X86_FEATURE_SEV_SNP)
> 
> I think this should really be cc_platform_has(CC_ATTR_GUEST_SEV_SNP).

Ah, we wanna check the guest, sure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
