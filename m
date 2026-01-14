Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C733A9D3
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768422555; cv=none; b=O5UpsUeeJAB04/ONRCgSIgodJ0rxm84S7p19jbwT0scU9Mcn1+ECKlroCdNe0TBQIr4cXVBPHTHW1ZJfFcrbsuTjEdkBCCt0L7VpGUHmLwNSrAQGINdR9xw7AyCqGGecAOJwU1O7su2lGjkdvDxbiVHMzV/pewhTB0Ek0Sn4l+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768422555; c=relaxed/simple;
	bh=TbRGBAt1ko30b1ePo6M5ETfxLMCAR7vckrZz0CldVrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms0lJ8IvCGHO+5FPDqFRyfHeYJH2uvNGdE4DuUPSQjWD6wRIV+/VLcFUfxDavRBYAbn2HeTBTEcfMvN9StU4eE9IhfkmRI3qakCsJ4KAnPfCmZnJO2iKxIBiwUNpgW5wX25nID/zajvaSfeMvz8QuF/TbazpQuWZ1lNyW4XUFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JLuESpSh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JLuESpSh"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF79A40E0252;
	Wed, 14 Jan 2026 20:29:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p8f55rPpusqu; Wed, 14 Jan 2026 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768422545; bh=R2TcZ64Nqb5DPT1NRjRyWuapRlhfT5Vr0IUpAfrWUm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLuESpShq4zd6ak2GhOF4qmtHhJyFNGohSP7OrxDNPmcgOHkfj2BLq1arnJvbqzsa
	 mOkgD2xdVXPxn2M+ty5q0cyCSiJnbGXd7Np9xZ6NSJFDOjAHCxqJszABbgB4hod8jf
	 X8IYzW1n4j84TZmHjkbQk+B4yt457ZBCoRD8HAlIvQG4MAQuUctRYZWCyWtOk5z/nN
	 VneOVuDx4sxdQPWkTf0uXjqRkJWXLtgyo9TAVHDX5ItGRM+DHFCZ7+0w7J+9NSi8BT
	 Per5lru9KvkLZi7nTpgoCvi/puMOAGKdZsAp9OZWk5LhZ93bNqsyF+qrYza5+TnaAN
	 M/Mt/TgqWJ+kRW97NofZpak4AOPh6XredJk4EU1ickoO6UD/IRtVGC7PpWH9YjRt4U
	 aWE0Fjv4C2bESVWVqHro94JRhv/uytS+zQs/K9E/ffRr2Dacmma/JfNDgdPBz/JIVL
	 4IJdvCFQ27VyoBQg88PRE4sSoktc0WXMrriWsNGrCLUqADTe/Q4d2NscCQak6K9bi5
	 3dFmNQ2WyPsoBFKy+dCHptZSjAYpR73UUH6o1IqhOs1pgCrj7W/QRRJIIQGpd5zJLr
	 dm91xg7ru6k2Qa7UkK+vDR0TF2GskVkI8EQu15uqTETQEKXaKZ8JlNWMcCi0tjivnm
	 7fpsf/+4dD9BA5YvuAKaSwa8=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 39A7540E0194;
	Wed, 14 Jan 2026 20:28:53 +0000 (UTC)
Date: Wed, 14 Jan 2026 21:28:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RESEND 1/2] x86/paravirt: Remove trailing semicolons from
 alternative asm templates
Message-ID: <20260114202846.GGaWf8foEIum1AotkZ@fat_crate.local>
References: <20260105093944.52387-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105093944.52387-1-ubizjak@gmail.com>

On Mon, Jan 05, 2026 at 10:39:06AM +0100, Uros Bizjak wrote:
> GCC inline asm treats semicolons as instruction separators, so a
> semicolon after the last instruction is not required.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/paravirt.h       | 20 ++++++++++----------
>  arch/x86/include/asm/paravirt_types.h |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)

Those don't apply anymore. Please rebase them against latest tip/master
branch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
